//
// model.fp
// github.com/astrochili/defold-illumination
// Copyright (c) 2022 Roman Silin
// MIT license. See LICENSE for details.
//

#define pi 3.1415926535897932384626433832795
#define light_pixels_count 5.0
#define meta_pixels_count 5.0
#define texture_size 32.0

const highp float axis_capacity = 2.0 * 2048.0;
const highp float max_uint24 = 256.0 * 256.0 * 256.0 - 1.0;
const highp vec3 flat_normal = vec3(0.5, 0.5, 1.0);

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp sampler2D DATA_TEXTURE;
uniform lowp sampler2D LIGHT_TEXTURE;
uniform lowp sampler2D SPECULAR_TEXTURE;
uniform lowp sampler2D NORMAL_TEXTURE;

uniform highp vec4 surface;

varying highp vec3 camera_position;
varying highp vec3 world_position;
varying highp vec3 view_position;
varying mediump vec3 world_normal;
varying mediump vec2 texture_coord;
varying mediump vec2 light_map_coord;

vec4 get_data(float index) {
    float x = mod(index, texture_size) / texture_size;
    float y = float(index / texture_size) / float(texture_size);

    return texture2D(DATA_TEXTURE, vec2(x, y));
}

float data_to_axis(vec3 data) {
    float r = 255.0 * data.r * 256.0 * 256.0;
    float g = 255.0 * data.g * 256.0;
    float b = 255.0 * data.b;
    float value = r + g + b;

    value = value - (max_uint24 * 0.5);
    value = value * (axis_capacity / max_uint24);

    return value;
}

mat3 get_tbn_mtx(vec3 normal, vec3 view_direction, vec2 texture_coord) {
    vec3 d_vd_x = dFdx(view_direction);
    vec2 d_tc_x = dFdx(texture_coord);

    vec3 d_vd_y = dFdy(view_direction);
    vec2 d_tc_y = dFdy(texture_coord);

    vec3 d_vd_y_cross = cross(d_vd_y, normal);
    vec3 d_vd_x_cross = cross(normal, d_vd_x);

    vec3 tangent = d_vd_y_cross * d_tc_x.x + d_vd_x_cross * d_tc_y.x;
    vec3 bitangent = d_vd_y_cross * d_tc_x.y + d_vd_x_cross * d_tc_y.y;

    float inv_max = inversesqrt(max(dot(tangent, tangent), dot(bitangent, bitangent)));
    mat3 tbn_mtx = mat3(tangent * inv_max, bitangent * inv_max, normal);

    return tbn_mtx;
}

vec3 get_perturb_normal(vec3 world_normal, vec3 view_direction, vec2 texture_coord) {
    mat3 tbn_mtx = get_tbn_mtx(world_normal, -view_direction, texture_coord);

    vec3 normal_map_color = texture2D(NORMAL_TEXTURE, texture_coord).xyz;
    vec3 perturb_normal = normal_map_color * (255.0 / 127.0) - vec3(128.0 / 127.0);

    if (surface.z > 0.5) {
        // This is the DirectX normals map format
        perturb_normal.y = -perturb_normal.y;
    }

    return normalize(tbn_mtx * perturb_normal);
}

float get_fog_factor(float distance, float fog_min, float fog_max) {
    if (distance >= fog_max) {
        return 1.0;
    }

    if (distance <= fog_min) {
        return 0.0;
    }

    return 1.0 - (fog_max - distance) / (fog_max - fog_min);
}

vec3 get_specular_color(vec3 map_specular, float light_specular, vec3 light_color, vec3 light_direction, vec3 surface_normal, vec3 view_direction) {
    if (light_specular == 0.0 || map_specular.x == 0.0) {
        return vec3(0.0);
    }

    float lambertian = max(dot(light_direction, surface_normal), 0.0);

    if (lambertian <= 0.0) {
        return vec3(0.0);
    }

    float surface_shininess = surface.x;

    vec3 reflection_direction = reflect(-light_direction, surface_normal);
    float specular_value = pow(max(dot(view_direction, reflection_direction), 0.0), surface_shininess);

    return light_color * light_specular * specular_value;
}

void main() {

    //
    // Texture

    vec4 texture_color = texture2D(DIFFUSE_TEXTURE, texture_coord);

    if (texture_color.a == 0.0) {
       discard;
    }

    vec3 color = texture_color.rgb;


    //
    // Defold Editor

    vec4 meta_1 = get_data(0.0);

    if (meta_1.r == 0.0) {
        vec3 editor_ambient = vec3(0.8);
        vec3 editor_diffuse = vec3(1.0) - editor_ambient;

        editor_diffuse = editor_ambient + editor_diffuse * world_normal.y;

        gl_FragColor = vec4(color.rgb * editor_diffuse.rgb, 1.0);

        // If the first byte is zero, it's the editor,
        // so just shade the sides according to the normal.
        return;
    }


    //
    // Fog

    float fog_type = meta_1.g * 255.0;
    vec4 fog_color = vec4(0.0);

    if (fog_type > 0.0) {
        fog_color = get_data(4.0);

        float fog_distance = fog_type > 1.5 ? length(view_position) : abs(view_position.z);
        vec2 fog_range = meta_1.ba * 255.0;

        float fog_factor = get_fog_factor(fog_distance, fog_range.x, fog_range.y);

        if (fog_factor < 1.0 || fog_color.a < 1.0) {
            fog_color = fog_color * fog_factor * fog_color.a;
        } else {
            gl_FragColor = vec4(fog_color.rgb, 1.0);

            // Completely filled with fog,
            // so there is no need to continue any calculations.
            return;
        }
    }

    //
    // Normal Map

    vec3 view_direction = normalize(camera_position - world_position);

    vec3 surface_normal = world_normal;
    vec3 normal_map_color = texture2D(NORMAL_TEXTURE, texture_coord).xyz;

    if (normal_map_color.r > 0.0 && normal_map_color != flat_normal) {
        surface_normal = get_perturb_normal(world_normal, view_direction, texture_coord);
    }


    //
    // Light Map

    vec3 light_map_color = texture2D(LIGHT_TEXTURE, surface.y > 0.5 ? light_map_coord : texture_coord).xyz;
    vec3 illuminance_color = light_map_color;


    //
    // Specular Map

    vec3 specular_color = vec3(0.0);
    vec3 specular_map_color = texture2D(SPECULAR_TEXTURE, texture_coord).xyz;


    //
    // Ambient

    vec4 meta_2 = get_data(1.0);
    vec3 ambient_color = meta_2.rgb * meta_2.w;

    illuminance_color = illuminance_color + ambient_color;


    //
    // Sunlight

    vec4 meta_3 = get_data(2.0);

    if (meta_3.a > 0.0) {
        vec4 meta_4 = get_data(3.0);

        vec3 sunlight_direction = normalize(meta_4.rgb * 2.0 - vec3(1.0));
        float sunlight_shininess = max(dot(surface_normal, sunlight_direction), 0.0);
        vec3 sunlight_color = meta_3.rgb * meta_3.w * sunlight_shininess;

        float sunlight_specular = meta_4.a;
        vec3 sunlight_specular_color = get_specular_color(specular_map_color, sunlight_specular, sunlight_color, sunlight_direction, surface_normal, view_direction);

        illuminance_color = illuminance_color + sunlight_color;
        specular_color = specular_color + sunlight_specular_color;
    }


    //
    // Lights

    float lights_count = meta_1.r * 255.0 - 1.0;

    for (float p = meta_pixels_count; p < meta_pixels_count + lights_count * light_pixels_count; p = p + light_pixels_count) {
        vec4 light_2 = get_data(p + 1.0);
        vec4 light_3 = get_data(p + 2.0);
        vec4 light_4 = get_data(p + 3.0);

        float light_radius = light_2.r * 255.0;

        vec3 light_position = vec3(
            data_to_axis(vec3(light_2.a, light_3.rg)),
            data_to_axis(vec3(light_3.ba, light_4.r)),
            data_to_axis(light_4.gba)
        );

        float light_distance = length(light_position - world_position);

        if (light_distance > light_radius) {
            // Skip this light source because of distance
            continue;
        }

        vec4 light_1 = get_data(p);
        vec4 light_5 = get_data(p + 4.0);

        vec3 light_direction = normalize(light_position - world_position);
        vec3 light_color = light_1.rgb * light_1.w;
        float light_smoothness = light_2.g;

        vec3 light_illuminance_color = light_color;

        //
        // Specular

        float light_specular = light_2.b;
        vec3 light_specular_color = get_specular_color(specular_map_color, light_specular, light_color, light_direction, surface_normal, view_direction);

        //
        // Attenuation

        float light_attenuation = pow(clamp(1.0 - light_distance / light_radius, 0.0, 1.0), 2.0 * light_smoothness);
        float light_strength = light_attenuation * max(dot(surface_normal, light_direction), 0.0);

        //
        // Cutoff

        if (light_5.r < 1.0) {
            vec3 spot_direction = light_5.gba * 2.0 - vec3(1.0);
            float spot_theta = dot(light_direction, normalize(spot_direction));

            float spot_cutoff = light_5.r * 2.0 - 1.0;

            if (spot_theta <= spot_cutoff) {
                // Skip this light source because of cutoff
                continue;
            }

            if (light_smoothness > 0.0) {
                float spot_cutoff_inner = (spot_cutoff + 1.0) * (1.0 - light_smoothness) - 1.0;
                float spot_epsilon = spot_cutoff_inner - spot_cutoff;
                float spot_intensity = clamp((spot_cutoff - spot_theta) / spot_epsilon, 0.0, 1.0);

                light_illuminance_color = light_illuminance_color * spot_intensity;
                light_specular_color = light_specular_color * spot_intensity;
            }
        }

        //
        // Adding

        illuminance_color = illuminance_color + light_illuminance_color * light_strength;
        specular_color = specular_color + light_specular_color * light_strength;
    }


    //
    // Mixing

    color = color * (min(illuminance_color, 1.0));
    color = (min(color + specular_map_color.x * specular_color, 1.0));
    color = mix(color, fog_color.rgb, fog_color.a);

    gl_FragColor = vec4(color, texture_color.a);


    //
    // Debug

    // gl_FragColor = vec4((view_position / 2.0 + 0.5).xyz, 1.0);
    // gl_FragColor = vec4((world_position / 2.0 + 0.5).xyz, 1.0);
    // gl_FragColor = vec4((world_normal / 2.0 + 0.5).xyz, 1.0);
    // gl_FragColor = vec4((surface_normal / 2.0 + 0.5).xyz, 1.0);

}
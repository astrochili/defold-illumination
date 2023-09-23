//
// debug.fp
// github.com/astrochili/defold-illumination
// Copyright (c) 2022 Roman Silin
// MIT license. See LICENSE for details.
//

varying mediump vec3 model_normal;
varying mediump vec2 texture_coord;

uniform lowp sampler2D DIFFUSE_TEXTURE;

void main() {
    vec4 color = texture2D(DIFFUSE_TEXTURE, texture_coord.xy);

    vec3 ambient = vec3(0.8);
    vec3 diffuse = vec3(1.0) - ambient;

    diffuse = ambient + diffuse * model_normal.y;

    gl_FragColor = vec4(color.rgb * diffuse.rgb, 1.0);
}
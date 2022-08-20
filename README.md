![logo](https://user-images.githubusercontent.com/4752473/185670169-8b27dcab-a6a9-4a9d-b1a7-ab4b136fdd65.jpg)
[![buymeacoffee](https://user-images.githubusercontent.com/4752473/179627111-617b77b1-f900-4fac-9e03-df73994246ad.svg)](https://www.buymeacoffee.com/astrochili) [![tinkoff](https://user-images.githubusercontent.com/4752473/188312285-9162bbed-e50f-40ad-9fbf-a622a80f0249.svg)](https://www.tinkoff.ru/cf/4B9FjHDHA5a) [![twitter](https://user-images.githubusercontent.com/4752473/179627140-c8991473-c4c1-4d6a-9bb1-4dc2117b049f.svg)](https://twitter.com/astronachos) [![telegram](https://user-images.githubusercontent.com/4752473/179627134-0bdcf8a5-7826-4ed2-b8cd-06d0b9792422.svg)](https://t.me/astronachos)

# Illumination

## Overview

This extension contains ready-to-use forward shading lighting for 3D games made with Defold. Just set the provided material to your mesh and place light sources on the scene.

Technically it supports about ~200 light sources, but the performance limit is about 20-30 sources at the moment. Need to implement [clustered forward shading](https://github.com/astrochili/defold-illumination/issues/1) to get a valuable performance boost.

All the lighting data passed to the shader program as the texture, so it doesn't use a render script.

🎮 [Play HTML5 demo](https://astronachos.com/defold/illumination) with 🔦 on the `E` key.

💬 [Discuss on the forum](https://forum.defold.com/t/illumination-ready-to-use-forward-shading-lighting-for-3d-games/71465/2).

👀 Look at [Operator](https://github.com/astrochili/defold-operator), [Kinematic Walker](https://github.com/astrochili/defold-kinematic-walker) and [TrenchBroom](https://github.com/astrochili/defold-trenchbroom) used in the demo.

## Features

- [x] Linear and radial fog.
- [x] Ambient lighting.
- [x] Directional lighting.
- [x] Light points and spots.
- [x] Everything can be animated with `go.animate()`.
- [x] Support for baked light maps (also can be used as emission maps).
- [x] Support for specular maps.
- [x] Support for normal maps.
- [ ] [Support for height maps](https://github.com/astrochili/defold-illumination/issues/2).
- [ ] [Clustered forward shading](https://github.com/astrochili/defold-illumination/issues/1).
- [ ] Request by [adding an issue or contribute](https://github.com/astrochili/defold-illumination/issues).

## Install

Add link to the zip-archive of the latest version of [defold-illumination](https://github.com/astrochili/defold-illumination/releases) to your Defold project as [dependency](http://www.defold.com/manuals/libraries/).

## Quick Start

1. Add `illumination.go` to your scene as the sunlight source and configure it.
2. Add `light_point.go` or `light_spot.go` as light sources and configure them.
3. Set `/illumination/materials/model.material` to your mesh.
4. Set `/illumination/textures/data.png` to the *`DATA_TEXTURE`* slot.
5. Fill *`LIGHT_TEXTURE`*, *`SPECULAR_TEXTURE`* and *`NORMAL_TEXTURE`* slots with your maps or set the empty texture `/illumination/textures/empty.png`.

## Illumination

![illumination](https://user-images.githubusercontent.com/4752473/185738458-fdac06c0-275f-4dae-a0a2-c55335e9bd13.jpg)

### rotation

Affects the direction of sunlight.

### ambient_color

Ambient light color.

### ambient_level

Ambient light strength from `0.0` to `1.0`.

### sunlight_color

Directional light color.

### sunlight_brightness

Directional light strength from `0.0` to `1.0`.

### sunlight_specular

Directional light specular component from `0.0` to `1.0`.

### fog

Adds fog in front of the camera and fade-out distant objects.

### fog_is_radial

- `true` — calculates the fog around the camera position.
- `false` — calculates the fog along the camera view direction.

### fog_distance_min

Distance at which the fog begins to appear.

### fog_distance_max

Distance at which the fog reaches the full strength.

### fog_color

Used to draw the fog gradient and sent with the `clear_color` message to the render script.

### fog_level

Fog full strength from `0.0` to `1.0`.

- `1.0` — not a transparent fog. It can save some performance by ignoring the lighting calculation.

## Light

![light-point](https://user-images.githubusercontent.com/4752473/185738463-5b5deabb-817b-4996-be2c-2828efada7bf.jpg)
![light-spot](https://user-images.githubusercontent.com/4752473/185738462-79790471-b315-4d40-8352-4751d1492b53.jpg)

There are `light_point.go` and `light_spot.go`. The only difference is the texture of the debug mesh for a friendlier placement on the scene.

### position

Light source world position.

### rotation

Rotation affects the direction of the spotlight when [`cutoff`](#cutoff) is less than `1.0`.

### color

Light color that will be multiplied with the diffuse color.

### brightness

Light brightness from `0.0` to `1.0`.

- `0.0` — turn off to save some performance by ignoring the lighting calculation.
- `1.0` — full brightness.

### radius

Light radius.

- `0.0` — turn off to save some performance by ignoring the lighting calculation.

### specular

Light specular component from `0.0` to `1.0`, will be multiplied with the specular map color.

### smoothness

Light smoothness / attenuation from `0.0` to `1.0`.

- `0.0` — no attenuation at all, fill all the radius evenly.
- `1.0` — standard attenuation from the center to the edges.

### cutoff

Spotlight cutoff from `0.0` to `1.0`.

- `0.0` — no light.
- `0.3` — like a flashlight.
- `0.5` — half of the sphere.
- `1.0` — no cutoff.

To get the best results, you need to jungle with [`radius`](#radius), [`cutoff`](#cutoff) and [`smoothness`](#smoothness), which is [not so obvious](https://github.com/astrochili/defold-illumination/issues/4) at the moment.

## Material

![material](https://user-images.githubusercontent.com/4752473/185738654-0bdd5e6d-0f90-47ad-b52b-cf1cf5d561c5.jpg)
![flashlight](https://user-images.githubusercontent.com/4752473/185738460-0c66e9fd-99c2-4001-a2ac-e29bcc54836c.jpg)

Use the `/illumination/materials/model.material` material on your meshes to add them to lighting calculation.

It's important to fill unused texture slots with `/illumination/textures/empty.png`.

### DIFFUSE_TEXTURE

A basic diffuse texture.

### DATA_TEXTURE

The illumination data texture, always set to `/illumination/textures/data.png`.

### LIGHT_TEXTURE

A baked light map or an emission map texture.

- `/illumination/textures/white.png` to have full strength emmission.
- `/illumination/textures/empty.png` to skip it.

If your light map texture has different uv coordinates from the diffuse texture you need to turn on [surface.y](#surface) constant.

### SPECULAR_TEXTURE

A specular map texture.

- `/illumination/textures/white.png` to have full strength reflection.
- `/illumination/textures/empty.png` to skip it.

### NORMAL_TEXTURE

A normal map texture with green on the top.

- `/illumination/textures/empty.png` to skip it.

### surface

Fragment constant to pass some surface properties.

- `x` — the surface shininess. Impacts the scattering of the specular highlight. Default value is `32.0`.
- `y` — using separate uvs for the light map. Set to `1.0` to use the stream `texcoord1` as light map uv coordinates. By default it's `0.0` and uses the `texcoord0` stream.

## Module

### illumination.set_debug(is_enabled)

Enables the sun and light sources debug meshes.

```lua
illumination.set_debug(true)
```

### illumination.is_debug()

Returns the debug mode state as boolean.

```lua
local is_debug = operator.is_debug()
```

### illumination.set_light(light, url)

Manually add or remove a light source. Don't use it if you already use `light_point.go` or `light_spot.go`.


```lua
-- Prepare the light
local light = {
    position = go.get_world_position(),
    direction = vmath.rotate(go.get_world_rotation(), vmath.vector3(0, 0, 1)),
    color = vmath.vector4(1.0),
    radius = 5.0,
    specular = 0.5,
    smoothness = 1.0,
    cutoff = 1.0,
}

-- Prepare the url
local light_url = msg.url('#')

-- Add or update the light
illumination.set_light(light, light_url)

-- Remove the light
illumination.set_light(nil, light_url)
```

## TrenchBroom

[TrenchBroom extension](https://github.com/astrochili/defold-trenchbroom#illumination-light_point-light_spot) contains entities `illumination`, `light_point` and `light_spot` to configure lighting directly on the map.

To assign textures to meshes use [texture path patterns](https://github.com/astrochili/defold-trenchbroom#texture-path-patterns):

- `texture1` — `/illumination/textures/data.png`
- `texture2` — `*_light.png` or `/illumination/textures/empty.png`
- `texture3` — `*_specular.png` or `/illumination/textures/empty.png`
- `texture4` — `*_normal.png` or `/illumination/textures/empty.png`

## Credits

- Textures in the demo are from Tiny Texture Pack [1](https://screamingbrainstudios.itch.io/tiny-texture-pack)-[2](https://screamingbrainstudios.itch.io/tiny-texture-pack-2) by [Screaming Brain Studios](https://screamingbrainstudios.itch.io/).
- Specular and normal maps generated with [Normal Map Online](https://cpetry.github.io/NormalMap-Online/) by [@cpetry](https://github.com/cpetry).
- The header background picture by [Thor Alvis](https://unsplash.com/photos/sgrCLKYdw5g).
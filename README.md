![logo](https://user-images.githubusercontent.com/4752473/185670169-8b27dcab-a6a9-4a9d-b1a7-ab4b136fdd65.jpg)

# Illumination

[![Release](https://img.shields.io/github/v/release/astrochili/defold-illumination.svg?include_prereleases=&sort=semver&color=blue)](https://github.com/astrochili/defold-illumination/releases)
[![License](https://img.shields.io/badge/License-MIT-blue)](https://github.com/astrochili/defold-illumination/blob/master/LICENSE)
[![Website](https://img.shields.io/badge/website-gray.svg?&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOCIgaGVpZ2h0PSIxNiIgZmlsbD0ibm9uZSIgdmlld0JveD0iMCAwIDE4IDE2Ij48Y2lyY2xlIGN4PSIzLjY2IiBjeT0iMTQuNzUiIHI9IjEuMjUiIGZpbGw9InVybCgjYSkiLz48Y2lyY2xlIGN4PSI4LjY2IiBjeT0iMTQuNzUiIHI9IjEuMjUiIGZpbGw9InVybCgjYikiLz48Y2lyY2xlIGN4PSIxMy42NSIgY3k9IjE0Ljc1IiByPSIxLjI1IiBmaWxsPSJ1cmwoI2MpIi8+PHBhdGggZmlsbD0idXJsKCNkKSIgZmlsbC1ydWxlPSJldmVub2RkIiBkPSJNNy42MyAxLjQ4Yy41LS43IDEuNTUtLjcgMi4wNSAwbDYuMjIgOC44MWMuNTguODMtLjAxIDEuOTctMS4wMyAxLjk3SDIuNDRhMS4yNSAxLjI1IDAgMCAxLTEuMDItMS45N2w2LjIxLTguODFaIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiLz48ZGVmcz48bGluZWFyR3JhZGllbnQgaWQ9ImEiIHgxPSIyLjQxIiB4Mj0iMi40MSIgeTE9IjEzLjUiIHkyPSIxNiIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiPjxzdG9wIHN0b3AtY29sb3I9IiNGRDhENDIiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiNGOTU0MUYiLz48L2xpbmVhckdyYWRpZW50PjxsaW5lYXJHcmFkaWVudCBpZD0iYiIgeDE9IjcuNDEiIHgyPSI3LjQxIiB5MT0iMTMuNSIgeTI9IjE2IiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHN0b3Agc3RvcC1jb2xvcj0iI0ZEOEQ0MiIvPjxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iI0Y5NTQxRiIvPjwvbGluZWFyR3JhZGllbnQ+PGxpbmVhckdyYWRpZW50IGlkPSJjIiB4MT0iMTIuNCIgeDI9IjEyLjQiIHkxPSIxMy41IiB5Mj0iMTYiIGdyYWRpZW50VW5pdHM9InVzZXJTcGFjZU9uVXNlIj48c3RvcCBzdG9wLWNvbG9yPSIjRkQ4RDQyIi8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjRjk1NDFGIi8+PC9saW5lYXJHcmFkaWVudD48bGluZWFyR3JhZGllbnQgaWQ9ImQiIHgxPSIuMDMiIHgyPSIuMDMiIHkxPSIuMDMiIHkyPSIxMi4yNiIgZ3JhZGllbnRVbml0cz0idXNlclNwYWNlT25Vc2UiPjxzdG9wIHN0b3AtY29sb3I9IiNGRkU2NUUiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiNGRkM4MzAiLz48L2xpbmVhckdyYWRpZW50PjwvZGVmcz48L3N2Zz4=)](https://astronachos.com/)
[![Mastodon](https://img.shields.io/badge/mastodon-gray?&logo=mastodon)](https://mastodon.gamedev.place/@astronachos)
[![Twitter](https://img.shields.io/badge/twitter-gray?&logo=twitter)](https://twitter.com/astronachos)
[![Telegram](https://img.shields.io/badge/telegram-gray?&logo=telegram)](https://t.me/astronachos)
[![Buy me a coffee](https://img.shields.io/badge/buy_me_a_coffee-gray?&logo=buy%20me%20a%20coffee)](https://buymeacoffee.com/astrochili)

📼 Also in this series:
- 👖 [Kinematic Walker](https://github.com/astrochili/defold-kinematic-walker)
- 🎥 [Operator](https://github.com/astrochili/defold-operator)
- 🏗️ [TrenchFold](https://github.com/astrochili/defold-trenchfold)
- 🚧 [Blockout Textures](https://github.com/astrochili/blockout-textures)

## Overview

This extension contains ready-to-use forward shading lighting for 3D games made with Defold. Just set the provided material to your mesh and place light sources on the scene.

Technically it supports about ~200 light sources, but the performance limit is about 20-30 sources at the moment. Need to implement [clustered forward shading](https://github.com/astrochili/defold-illumination/issues/1) to get a valuable performance boost.

All the lighting data passed to the shader program as the texture, so it doesn't use a render script.

🎮 [Play HTML5 demo](https://astronachos.com/defold/illumination) with 🔦 on the `E` key.

💬 [Discuss on the forum](https://forum.defold.com/t/illumination-ready-to-use-forward-shading-lighting-for-3d-games/71465/2).

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

OpenGL normal maps format used by default. To use DirectX format turn on [surface.z](#surface) constant.

### surface

Fragment constant to pass some surface properties.

- `x` — the surface shininess. Impacts the scattering of the specular highlight. Default value is `32.0`.
- `y` — using separate uvs for the light map. Set to `1.0` to use the stream `texcoord1` as light map uv coordinates. By default it's `0.0` and uses the `texcoord0` stream.
- `z` — use the OpenGL or DirectX normal maps format. Set to `1.0` to use DirectX format where green is down. By default it's `0.0` and uses the OpenGL format where green is top.

## Module

### illumination.set_debug(is_enabled)

Enables the sun and light sources debug meshes.

```lua
illumination.set_debug(true)
```

### illumination.is_debug()

Returns the debug mode state as boolean.

```lua
local is_debug = illumination.is_debug()
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

[TrenchFold](https://github.com/astrochili/defold-trenchfold#illumination-light_point-light_spot) extension contains entities `illumination`, `light_point` and `light_spot` to configure lighting directly on the map.

To assign textures to meshes use [texture path patterns](https://github.com/astrochili/defold-trenchfold#texture-path-patterns):

- `texture1` — `/illumination/textures/data.png`
- `texture2` — `*_light.png` or `/illumination/textures/empty.png`
- `texture3` — `*_specular.png` or `/illumination/textures/empty.png`
- `texture4` — `*_normal.png` or `/illumination/textures/empty.png`

## Credits

- Textures in the demo are from Tiny Texture Pack [1](https://screamingbrainstudios.itch.io/tiny-texture-pack)-[2](https://screamingbrainstudios.itch.io/tiny-texture-pack-2) by [Screaming Brain Studios](https://screamingbrainstudios.itch.io/).
- Specular and normal maps generated with [Normal Map Online](https://cpetry.github.io/NormalMap-Online/) by [@cpetry](https://github.com/cpetry).
- The header background picture by [Thor Alvis](https://unsplash.com/photos/sgrCLKYdw5g).
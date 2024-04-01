--[[
  illumination.lua
  github.com/astrochili/defold-illumination
  Copyright (c) 2022 Roman Silin
  MIT license. See LICENSE for details.
--]]

local utils = require 'illumination.utils'

local illumination = { }

--
-- Structure

--[[
  -- Meta
  1 - lights_count, fog_type, fog_min, fog_max
  2 - ambient color: r, g, b, a
  3 - sunlight color: r, g, b, a
  4 - sunlight direction: x, y, z, specular
  5 - fog color: r, g, b, a

  -- Light
  1 - r, g, b, a
  2 - radius, smoothness, specular, x1
  3 - x2, x3, y1, y2
  4 - y3, z1, z2, z3
  5 - cutoff, direction: x, y, z
--]]

--
-- Public Enum

illumination.FOG_TYPE_NONE = 0
illumination.FOG_TYPE_LINEAR = 1
illumination.FOG_TYPE_RADIAL = 2

--
-- Local Properties

local HASH_RGBA = hash 'rgba'
local TEXTURE_DATA = hash 'texture0'

local position_axis_bound = 2048 -- the same is in the fragment shader
local data_texture_size = 32 -- the same is in the fragment shader

local data_buffer_size = data_texture_size ^ 2
local data_pixel_length = 4
local data_meta_length = 20
local data_light_length = 5 * data_pixel_length
local data_buffer
local data_stream

local data_texture_path
local data_texture_header = {
  width = data_texture_size,
  height = data_texture_size,
  type = resource.TEXTURE_TYPE_2D,
  format = resource.TEXTURE_FORMAT_RGBA,
  num_mip_maps = 0
}

local light_index_by_url = { }
local lights = { }

local script_url
local is_debug = false

--
-- Local Functions

local function update_meta()
  data_stream[1] = 1 + #lights
end

local function update_environment(environment)
  if environment.fog_type then
    data_stream[2] = environment.fog_type
  end

  if environment.ambient_color then
    local color = environment.ambient_color * 255

    data_stream[5] = color.x
    data_stream[6] = color.y
    data_stream[7] = color.z
    data_stream[8] = color.w
  end

  if environment.sunlight_color then
    local color = environment.sunlight_color * 255

    data_stream[9] = color.x
    data_stream[10] = color.y
    data_stream[11] = color.z
    data_stream[12] = color.w
  end

  if environment.sunlight_direction then
    local direction = environment.sunlight_direction

    if direction ~= vmath.vector3(0) then
      direction = vmath.normalize(direction)
      direction = (direction + vmath.vector3(1)) * 255 / 2
    end

    data_stream[13] = direction.x
    data_stream[14] = direction.y
    data_stream[15] = direction.z
  end

  if environment.sunlight_specular then
    data_stream[16] = environment.sunlight_specular * 255
  end

  if data_stream[2] ~= illumination.FOG_TYPE_NONE then
    if environment.fog_min then
      data_stream[3] = math.max(0, environment.fog_min)
    end

    if environment.fog_max then
      data_stream[4] = math.max(environment.fog_min or data_stream[3], environment.fog_max)
    end

    if environment.fog_color then
      msg.post('@render:', hash 'clear_color', { color = environment.fog_color } )

      local fog_color = environment.fog_color * 255

      data_stream[17] = fog_color.x
      data_stream[18] = fog_color.y
      data_stream[19] = fog_color.z
      data_stream[20] = fog_color.w
    end
  end

  illumination.should_post_update_texture = next(environment) ~= nil
end

local function update_light(light, index)
  local byte = data_meta_length + 1 + data_light_length * (index - 1)
  local color = light.color * 255

  if color.w == 0 then
    data_stream[byte + 3] = 0
    return
  end

  data_stream[byte] = color.x
  data_stream[byte + 1] = color.y
  data_stream[byte + 2] = color.z
  data_stream[byte + 3] = color.w

  local radius = light.radius or 0

  if radius <= 0 then
    data_stream[byte + 4] = 0
    return
  end

  local smoothness =  math.max(0, math.min(light.smoothness or 1, 1))
  local specular = math.max(0, math.min(light.specular or 1, 1))
  local x1, x2, x3, y1, y2, y3, z1, z2, z3 = utils.vector3_to_9_uint8(light.position, position_axis_bound)

  data_stream[byte + 4] = math.min(math.ceil(radius), 255)
  data_stream[byte + 5] = smoothness * 255
  data_stream[byte + 6] = specular * 255
  data_stream[byte + 7] = x1

  data_stream[byte + 8] = x2
  data_stream[byte + 9] = x3
  data_stream[byte + 10] = y1
  data_stream[byte + 11] = y2

  data_stream[byte + 12] = y3
  data_stream[byte + 13] = z1
  data_stream[byte + 14] = z2
  data_stream[byte + 15] = z3

  local cutoff = math.max(0, math.min(light.cutoff or 1, 1))
  local direction = light.direction

  if cutoff < 1 and direction and direction ~= vmath.vector3(0) then
    direction = vmath.normalize(direction)
    direction = (direction + vmath.vector3(1)) * 255 / 2
  else
    data_stream[byte + 16] = 255
    return
  end

  data_stream[byte + 16] = (math.cos(cutoff * math.pi) + 1) * 255 / 2
  data_stream[byte + 17] = direction.x
  data_stream[byte + 18] = direction.y
  data_stream[byte + 19] = direction.z
end

local function add_light(light, url)
  local index = #lights + 1
  lights[index] = light
  light_index_by_url[url] = index

  update_light(light, index)
  update_meta()

  illumination.should_post_update_texture = true
  msg.post(url, hash 'debug', { is_enabled = is_debug })
end

local function replace_light(light, url)
  local index = light_index_by_url[url]
  lights[index] = light

  update_light(light, index)

  illumination.should_post_update_texture = true
end

local function delete_light(url)
  local removed_index = light_index_by_url[url]
  table.remove(lights, removed_index)
  light_index_by_url[url] = nil

  for url, index in pairs(light_index_by_url) do
    if index > removed_index then
      light_index_by_url[url] = index - 1
    end
  end

  -- Clear the light data
  local starting_byte = data_meta_length + 1 + data_light_length * (removed_index - 1)
  local ending_byte = starting_byte + data_light_length - 1
  for byte = starting_byte, ending_byte do
    data_stream[byte] = 0
  end

  -- Shift all the next pixels after index backward
  for index = removed_index + 1, #lights + 1 do
    starting_byte = data_meta_length + 1 + data_light_length * (index - 1)
    ending_byte = starting_byte + data_light_length - 1

    for byte = starting_byte, ending_byte do
      data_stream[byte] = data_stream[byte + data_light_length]
    end
  end

  update_meta()

  illumination.should_post_update_texture = true
  msg.post(url, hash 'debug', { is_enabled = false })
end

--
-- Public Functions

function illumination.set_debug(is_enabled)
  is_debug = is_enabled

  for url, _ in pairs(light_index_by_url) do
    msg.post(url, hash 'debug', { is_enabled = is_debug })
  end

  if script_url then
    msg.post(script_url, hash 'debug', { is_enabled = is_debug })
  end
end

function illumination.is_debug()
  return is_debug
end

function illumination.set_environment(environment)
  update_environment(environment)
end

function illumination.set_light(light, url)
  assert(url, 'Can\'t set a light without an url')

  local light_is_on = light and light.color.w > 0 and light.radius > 0 and light.cutoff > 0

  if light_index_by_url[url] then
    if light_is_on then
      replace_light(light, url)
    else
      delete_light(url)
    end
  elseif light_is_on then
    add_light(light, url)
  end
end

--
-- Internal functions

function illumination.init(data_url, sender)
  local buffer_declaration = {
    name = HASH_RGBA,
    type = buffer.VALUE_TYPE_UINT8,
    count = data_pixel_length
  }

  script_url = sender
  msg.post(script_url, hash 'debug', { is_enabled = is_debug })

  data_buffer = buffer.create(data_buffer_size, { buffer_declaration })
  data_stream = buffer.get_stream(data_buffer, HASH_RGBA)

  update_meta()

  data_texture_path = go.get(data_url, TEXTURE_DATA)
  resource.set_texture(data_texture_path, data_texture_header, data_buffer)
end

function illumination.post_update_data_texture()
  resource.set_texture(data_texture_path, data_texture_header, data_buffer)
  illumination.should_post_update_texture = false
end

return illumination
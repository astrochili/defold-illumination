--[[
  utils.lua
  github.com/astrochili/defold-illumination
  Copyright (c) 2022 Roman Silin
  MIT license. See LICENSE for details.
--]]

local utils = { }

--
-- Local

local MAX_UINT24 = 256 ^ 3 - 1

--
-- Public

function utils.color_rgba(rgb, a)
  return vmath.vector4(rgb.x, rgb.y, rgb.z, a)
end

function utils.patch(original, patch)
  for key, value in pairs(patch) do
    if type(value) == 'table' then
      original[key] = original[key] or { }
      utils.patch(original[key], value)
    else
      original[key] = value
    end
  end
end

function utils.uint16_to_2_uint8(uint16)
  local y = uint16

  local x = math.floor(y / 256)
  y = math.floor(y % 256)

  return x, y
end

function utils.uint24_to_3_uint8(uint24)
  local z = math.floor(math.min(math.max(0, uint24 + 0.5), MAX_UINT24))

  local y = math.floor(z / 256)
  z = math.floor(z % 256)

  local x = math.floor(y / 256)
  y = math.floor(y % 256)

  return x, y, z
end

function utils.vector3_to_9_uint8(position, axis_bound)
  local proportion_to_uint24 = 2 * axis_bound / MAX_UINT24

  local x = (axis_bound + position.x) / proportion_to_uint24
  local y = (axis_bound + position.y) / proportion_to_uint24
  local z = (axis_bound + position.z) / proportion_to_uint24

  local x1, x2, x3 = utils.uint24_to_3_uint8(x)
  local y1, y2, y3 = utils.uint24_to_3_uint8(y)
  local z1, z2, z3 = utils.uint24_to_3_uint8(z)

  return x1, x2, x3, y1, y2, y3, z1, z2, z3
end

return utils
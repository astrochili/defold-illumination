components {
  id: "light"
  component: "/illumination/light.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
embedded_components {
  id: "mesh"
  type: "mesh"
  data: "material: \"/illumination/assets/materials/debug.material\"\n"
  "vertices: \"/illumination/assets/models/box.buffer\"\n"
  "textures: \"/illumination/assets/textures/light_spot.png\"\n"
  "primitive_type: PRIMITIVE_TRIANGLES\n"
  "position_stream: \"position\"\n"
  "normal_stream: \"normal\"\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}

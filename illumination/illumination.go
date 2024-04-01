components {
  id: "illumination"
  component: "/illumination/illumination.script"
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
components {
  id: "mesh"
  component: "/illumination/assets/models/light_directional.mesh"
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
  id: "data"
  type: "model"
  data: "mesh: \"/builtins/assets/meshes/quad.dae\"\n"
  "skeleton: \"\"\n"
  "animations: \"\"\n"
  "default_animation: \"\"\n"
  "name: \"unnamed\"\n"
  "materials {\n"
  "  name: \"default\"\n"
  "  material: \"/illumination/materials/model.material\"\n"
  "  textures {\n"
  "    sampler: \"DIFFUSE_TEXTURE\"\n"
  "    texture: \"/illumination/textures/empty.png\"\n"
  "  }\n"
  "  textures {\n"
  "    sampler: \"DATA_TEXTURE\"\n"
  "    texture: \"/illumination/textures/data.png\"\n"
  "  }\n"
  "  textures {\n"
  "    sampler: \"LIGHT_TEXTURE\"\n"
  "    texture: \"/illumination/textures/empty.png\"\n"
  "  }\n"
  "  textures {\n"
  "    sampler: \"SPECULAR_TEXTURE\"\n"
  "    texture: \"/illumination/textures/empty.png\"\n"
  "  }\n"
  "  textures {\n"
  "    sampler: \"NORMAL_TEXTURE\"\n"
  "    texture: \"/illumination/textures/empty.png\"\n"
  "  }\n"
  "}\n"
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

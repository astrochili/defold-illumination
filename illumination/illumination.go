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
  "material: \"/illumination/materials/model.material\"\n"
  "textures: \"/illumination/textures/empty.png\"\n"
  "textures: \"/illumination/textures/data.png\"\n"
  "textures: \"/illumination/textures/empty.png\"\n"
  "textures: \"/illumination/textures/empty.png\"\n"
  "textures: \"/illumination/textures/empty.png\"\n"
  "skeleton: \"\"\n"
  "animations: \"\"\n"
  "default_animation: \"\"\n"
  "name: \"unnamed\"\n"
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

return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.15.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 12,
  tilewidth = 64,
  tileheight = 64,
  nextobjectid = 11,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      filename = "../../res/tiles.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 2,
      margin = 1,
      image = "../tiles.png",
      imagewidth = 264,
      imageheight = 264,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 16,
      tiles = {
        {
          id = 14,
          terrain = { 1, 1, 1, 1 }
        }
      }
    },
    {
      name = "crates2",
      firstgid = 17,
      filename = "../../res/crates.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../crates2.png",
      imagewidth = 320,
      imageheight = 128,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 10,
      tiles = {}
    },
    {
      name = "spawners",
      firstgid = 27,
      tilewidth = 192,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {
        {
          id = 0,
          properties = {
            ["component"] = "Spawner",
            ["life"] = "100"
          },
          image = "../spawner.png",
          width = 192,
          height = 128
        }
      }
    },
    {
      name = "tanks",
      firstgid = 28,
      tilewidth = 128,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../tanks.png",
      imagewidth = 128,
      imageheight = 192,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 3,
      tiles = {
        {
          id = 0,
          properties = {
            ["component"] = "Shooter",
            ["interval"] = "2",
            ["life"] = "75"
          }
        },
        {
          id = 1,
          properties = {
            ["component"] = "Shooter",
            ["life"] = "100"
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 32,
      height = 12,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["component"] = "Sprite,Box,Blink"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 4, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 4, 0, 0, 0, 10, 0, 0, 10, 0, 0, 0, 0, 0, 0, 22
      }
    },
    {
      type = "objectgroup",
      name = "enemies",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["function"] = "Factory.createFlyingEnemy",
        ["type"] = "Copter"
      },
      objects = {
        {
          id = 6,
          name = "",
          type = "",
          shape = "ellipse",
          x = 857,
          y = 102,
          width = 56,
          height = 43,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "polyline",
          x = 787,
          y = 136,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -173, y = -40 },
            { x = -275, y = 70 },
            { x = -15, y = 135 },
            { x = 454, y = -87 },
            { x = 389, y = -164 }
          },
          properties = {}
        }
      }
    }
  }
}

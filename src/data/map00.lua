return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 12,
  tilewidth = 64,
  tileheight = 64,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      filename = "tiles1",
      tilewidth = 64,
      tileheight = 64,
      spacing = 2,
      margin = 1,
      image = "tiles.png",
      imagewidth = 264,
      imageheight = 264,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {
        {
          name = "test",
          tile = 12,
          properties = {}
        },
        {
          name = "New Terrain",
          tile = 14,
          properties = {}
        }
      },
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
      filename = "crates",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "crates2.png",
      imagewidth = 320,
      imageheight = 128,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 10,
      tiles = {
        {
          id = 1,
          properties = {
            ["component"] = "Shooter"
          }
        },
        {
          id = 4,
          properties = {
            ["component"] = "Spawner",
            ["life"] = "50"
          }
        }
      }
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
          image = "spawner.png",
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
      image = "tanks.png",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 27, 0, 0, 0, 10, 0, 1, 2, 2, 2, 2, 4, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 1, 2, 2, 2, 2, 4, 11, 0, 0, 10, 0, 0, 10, 0, 0, 0, 0, 0, 0, 22
      }
    }
  }
}

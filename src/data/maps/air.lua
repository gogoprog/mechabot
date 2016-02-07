return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.15.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 92,
  height = 12,
  tilewidth = 64,
  tileheight = 64,
  nextobjectid = 27,
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
      image = "../textures/tiles.png",
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
      image = "../textures/crates2.png",
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
          image = "../textures/spawner.png",
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
      image = "../textures/tanks.png",
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
      width = 92,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      name = "copters",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["function"] = "Factory.createEnemy",
        ["type"] = "copter"
      },
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "polyline",
          x = 1442.42,
          y = -27.2727,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -184.848, y = 269.697 },
            { x = -1012.12, y = 196.97 }
          },
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "polyline",
          x = 1936.36,
          y = -9.09091,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -172.727, y = 245.455 },
            { x = -1224.24, y = 90.9091 }
          },
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "polyline",
          x = 2148.48,
          y = -33.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -51.5152, y = 736.364 },
            { x = -457.576, y = 730.303 },
            { x = -751.515, y = 427.273 },
            { x = -1133.33, y = 481.818 }
          },
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "polyline",
          x = 3154.55,
          y = 178.788,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -851.515, y = 9.09091 },
            { x = -654.545, y = 203.03 },
            { x = -209.091, y = -124.242 },
            { x = 321.212, y = 239.394 },
            { x = 951.515, y = -121.212 }
          },
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "polyline",
          x = 2693.94,
          y = 472.727,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -445.455, y = 48.4848 },
            { x = -263.636, y = 233.333 },
            { x = 93.9394, y = 239.394 },
            { x = 160.606, y = -81.8182 },
            { x = 400, y = -66.6667 },
            { x = 384.848, y = 193.939 },
            { x = 793.939, y = 266.667 }
          },
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "polyline",
          x = 3760.61,
          y = -127.273,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -75.7576, y = 609.091 },
            { x = -181.818, y = 833.333 },
            { x = -369.697, y = 178.788 },
            { x = -512.121, y = 760.606 },
            { x = -760.606, y = 378.788 }
          },
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "polyline",
          x = 3951.52,
          y = -145.455,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 3.0303, y = 757.576 },
            { x = -393.939, y = 178.788 },
            { x = -1212.12, y = 536.364 }
          },
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "polyline",
          x = 5727.27,
          y = -139.394,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -466.667, y = 784.848 },
            { x = -1666.67, y = 796.97 },
            { x = -1569.7, y = 409.091 },
            { x = -1569.7, y = 181.818 }
          },
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "polyline",
          x = 4706.06,
          y = -72.7273,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -309.091, y = 342.424 },
            { x = -172.727, y = 557.576 },
            { x = 45.4545, y = 178.788 },
            { x = 206.061, y = 554.545 },
            { x = 503.03, y = 139.394 },
            { x = 760.606, y = 478.788 },
            { x = 969.697, y = 160.606 },
            { x = 1078.79, y = 730.303 },
            { x = 472.727, y = 572.727 }
          },
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "polyline",
          x = 1387.88,
          y = 33.3333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -493.939, y = 345.455 },
            { x = -575.758, y = 590.909 }
          },
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "polyline",
          x = 890.909,
          y = -200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 284.848, y = 875.758 },
            { x = 621.212, y = 330.303 },
            { x = 654.545, y = 990.909 },
            { x = 1042.42, y = 360.606 },
            { x = 1360.61, y = 736.364 },
            { x = 1666.67, y = 200 }
          },
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "polyline",
          x = 554.545,
          y = -209.091,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 21.2121, y = 796.97 },
            { x = 433.333, y = 318.182 },
            { x = 951.515, y = 909.091 },
            { x = 1587.88, y = 554.545 }
          },
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "polyline",
          x = 2539.39,
          y = -315.152,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -1272.73, y = 536.364 },
            { x = -396.97, y = 900 },
            { x = -1645.45, y = 969.697 }
          },
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "polyline",
          x = 1739.39,
          y = -336.364,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 354.545, y = 739.394 },
            { x = -236.364, y = 890.909 },
            { x = 736.364, y = 1060.61 }
          },
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "polyline",
          x = 3245.45,
          y = -418.182,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -663.636, y = 218.182 },
            { x = -115.152, y = 815.152 },
            { x = -639.394, y = 939.394 }
          },
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "polyline",
          x = 3469.7,
          y = -290.909,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -157.576, y = 596.97 }
          },
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "polyline",
          x = 4151.52,
          y = -60.6061,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -2106.06, y = 148.485 },
            { x = -1730.3, y = 548.485 },
            { x = -1581.82, y = 257.576 },
            { x = -1318.18, y = 596.97 },
            { x = -1054.55, y = 324.242 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "boss",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["function"] = "Factory.createEnemy",
        ["type"] = "bossCopter"
      },
      objects = {
        {
          id = 26,
          name = "",
          type = "",
          shape = "polyline",
          x = 4272.73,
          y = -224.242,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = -636.364, y = 351.515 },
            { x = -681.818, y = 890.909 },
            { x = -357.576, y = 318.182 },
            { x = -248.485, y = 900 },
            { x = 21.2121, y = 290.909 },
            { x = 175.758, y = 909.091 },
            { x = 490.909, y = 303.03 },
            { x = 636.364, y = 951.515 },
            { x = 872.727, y = 242.424 },
            { x = 1100, y = 836.364 },
            { x = 1206.06, y = 287.879 }
          },
          properties = {}
        }
      }
    }
  }
}

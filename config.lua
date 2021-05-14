Config = {}

-- [+] Markers Position
Config.Zones = {

  Drink         = {
    Type     = 27,
    Position = vector3(1016.98, -799.74, 57.40),
    Size     = {a = 0.8, b = 0.8, c = 0.8},
    Colour   = {r = 255, g = 0, b = 0}
  },
  Burger        = {
    Type     = 27,
    Position = vector3(1016.85, -804.84, 57.40),
    Size     = {a = 0.8, b = 0.8, c = 0.8},
    Colour   = {r = 255, g = 0, b = 0}
  },
  Burger2       = {
    Type     = 27,
    Position      = vector3(1015.54, -805.99, 57.40),
    Size     = {a = 0.8, b = 0.8, c = 0.8},
    Colour   = {r = 255, g = 0, b = 0}
  },
  Fries         = {
    Type     = 27,
    Position = vector3(1018.44, -801.48, 57.40),
    Size     = {a = 0.8, b = 0.8, c = 0.8},
    Colour   = {r = 255, g = 0, b = 0}
  },
  Prepare       = {
    Type     = 27,
    Position = vector3(1016.19, -803.19, 57.40),
    Size     = {a = 0.8, b = 0.8, c = 0.8},
    Colour   = {r = 255, g = 0, b = 0}
  },
  Locker        = {
    Type     = 20,
    Position = vector3(1005.61, -799.29, 58.10),
    Size     = {a = 0.7, b = 0.7, c = 0.7},
    Colour   = {r = 255, g = 50, b = 0}
  },
  Locker2       = {
    Type     = 20,
    Position      = vector3(1004.61, -795.77, 58.20),
    Size     = {a = 0.7, b = 0.7, c = 0.7},
    Colour   = {r = 255, g = 50, b = 0}
  },
  CarSpawn      = {
    Type     = 36,
    Position = vector3(1036.21, -763.38, 57.99),
    Size     = {a = 0.9, b = 0.9, c = 0.9},
    Colour   = {r = 255, g = 50, b = 0}
  },
  CarDelete     = {
    Type     = 1,
    Position = vector3(1011.97, -766.52, 56.87),
    Size     = {a = 3.0, b = 3.0, c = 1.0},
    Colour   = {r = 255, g = 0, b = 0}
  },
  ChangeDuty    = {
    Type     = 27,
    Position = vector3(1003.11, -791.67, 57.40),
    Size     = {a = 0.8, b = 0.8, c = 0.8},
    Colour   = {r = 255, g = 0, b = 0}
  },
  ChangeClothes = {
    Type     = 27,
    Position = vector3(1000.69, -791.89, 57.40),
    Size     = {a = 0.8, b = 0.8, c = 0.8},
    Colour   = {r = 255, g = 0, b = 0}
  },

}
-- [-] Markers Position

-- [+] Cars
Config.CarName            = 'burrito3'
Config.DeliveryCarSpawn	= vector3(1044.03, -756.63, 57.27)
-- [-] Cars


Config.Preparing = {
    TrayPosition     = vector3(1015.41, -804.2, 58.20),
    BagPosition    = vector3(1015.50, -804.20, 58.19),
    DrinkPosition    = vector3(1015.30, -804.20, 58.24)
}


-- [+] Blip
Config.Blip = {
  title = "Fastfood",
  colour = 73,
  id = 206,
  pos = {
    x = 1032.52,
    y = -779.51,
    z = 58.02
  }
}
-- [-] Blip
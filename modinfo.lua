name = "Dark Matter v2.2"
description = "Adds Dark Motes, Dark Matter and Dark Pylon to the game."
author = "cr4shmaster"
version = "2.2.2"
forumthread = ""
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
api_version = 6
icon_atlas = "modicon.xml"
icon = "modicon.tex"

local crsDarkmotes = {
 {description = "50", data = 50},
 {description = "75", data = 75},
 {description = "100", data = 100},
 {description = "125", data = 125},
 {description = "150", data = 150},
 {description = "175", data = 175},
 {description = "200", data = 200},
 {description = "225", data = 225},
}
local crsDamage = {
 {description = "20", data = 20},
 {description = "30", data = 30},
 {description = "40", data = 40},
 {description = "50", data = 50},
 {description = "60", data = 60},
 {description = "70", data = 70},
 {description = "80", data = 80},
}
local crsPosition = {
 {description = "500", data = 500},
 {description = "475", data = 475},
 {description = "450", data = 450},
 {description = "425", data = 425},
 {description = "400", data = 400},
 {description = "375", data = 375},
 {description = "350", data = 350},
 {description = "325", data = 325},
 {description = "300", data = 300},
 {description = "275", data = 275},
 {description = "250", data = 250},
 {description = "225", data = 225},
 {description = "200", data = 200},
 {description = "175", data = 175},
 {description = "150", data = 150},
 {description = "125", data = 125},
 {description = "100", data = 100},
 {description = "75", data = 75},
 {description = "50", data = 50},
 {description = "25", data = 25},
 {description = "0", data = 0},
 {description = "-25", data = -25},
 {description = "-50", data = -50},
 {description = "-75", data = -75},
 {description = "-100", data = -100},
 {description = "-125", data = -125},
 {description = "-150", data = -150},
 {description = "-175", data = -175},
 {description = "-200", data = -200},
 {description = "-225", data = -225},
 {description = "-250", data = -250},
 {description = "-275", data = -275},
 {description = "-300", data = -300},
 {description = "-325", data = -325},
 {description = "-350", data = -350},
 {description = "-375", data = -375},
 {description = "-400", data = -400},
 {description = "-425", data = -425},
 {description = "-450", data = -450},
 {description = "-475", data = -475},
 {description = "-500", data = -500},
}

configuration_options = {
 {
  name = "crsDarkMatterDarkMotes",
  label = "DM Dark Motes",
  options = crsDarkmotes,
  default = 100,
 },
 {
  name = "crsDarkMatterMaxDamageTaken",
  label = "DM Max Damage Taken",
  options = crsDamage,
  default = 40,
 },
 {
  name = "crsDarkPylonDarkMotes",
  label = "DP Cut Stones",
  options = crsDarkmotes,
  default = 50,
 },
 {
  name = "crsHorizontalPosition",
  label = "DP UI x Position",
  options = crsPosition,
  default = -300,
 },
 {
  name = "crsVerticalPosition",
  label = "DP UI y Position",
  options = crsPosition,
  default = -100,
 },
}

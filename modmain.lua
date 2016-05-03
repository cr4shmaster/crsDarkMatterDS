PrefabFiles = {
 "darkmatter",
 "darkmote",
 "darkpylon",
}

Assets = {
 Asset("ATLAS", "images/inventoryimages/darkmatter.xml"),
 Asset("IMAGE", "images/inventoryimages/darkmatter.tex"),
 Asset("ATLAS", "images/inventoryimages/darkmote.xml"),
 Asset("IMAGE", "images/inventoryimages/darkmote.tex"),
 Asset("ATLAS", "images/inventoryimages/darkpylon.xml"),
 Asset("IMAGE", "images/inventoryimages/darkpylon.tex"),
 Asset("ATLAS", "images/inventoryimages/darkcontainer.xml"),
 Asset("IMAGE", "images/inventoryimages/darkcontainer.tex"),
}

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
Vector3 = GLOBAL.Vector3
ACTIONS = GLOBAL.ACTIONS
Action = GLOBAL.Action
ActionHandler = GLOBAL.ActionHandler

local function crsMergeTables(a, b)
 for i=1, #b do
  table.insert(a, b[i])
 end
 return a
end

-- local crsNoDLCEnabled = not GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) and not GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC)
local crsAnyDLCEnabled = GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS) or GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC)
local crsReignOfGiantsEnabled = GLOBAL.IsDLCEnabled(GLOBAL.REIGN_OF_GIANTS)
local crsShipwreckedEnabled = GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC)

-- add strings
STRINGS.NAMES.DARKMATTER = "Dark Matter"
STRINGS.RECIPE_DESC.DARKMATTER = "Home-made dark matter."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKMATTER = "I should drop this on the ground, see what happens. YOLO!"
STRINGS.NAMES.DARKMOTE = "Dark Mote"
STRINGS.RECIPE_DESC.DARKMOTE = "Used to create Dark Matter."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKMOTE = "It's used to create Dark Matter."
STRINGS.NAMES.DARKPYLON = "Dark Pylon"
STRINGS.RECIPE_DESC.DARKPYLON = "Turns most things into Dark Motes."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKPYLON = "I better not touch it directly!"


-- add recipes
local crsDarkMatterDarkMotes = Ingredient("darkmote", GetModConfigData("crsDarkMatterDarkMotes"))
local crsDarkPylonDarkMotes = Ingredient("darkmote", GetModConfigData("crsDarkPylonDarkMotes"))
crsDarkMatterDarkMotes.atlas = "images/inventoryimages/darkmote.xml"
crsDarkPylonDarkMotes.atlas = "images/inventoryimages/darkmote.xml"
-- Dark Mote
local darkmote = Recipe("darkmote", {
 Ingredient("goldnugget", 1),
}, RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, 3)
darkmote.atlas = "images/inventoryimages/darkmote.xml"
-- Dark Matter
local darkmatter = Recipe("darkmatter", {
 crsDarkMatterDarkMotes,
}, RECIPETABS.REFINE, TECH.MAGIC_THREE)
darkmatter.atlas = "images/inventoryimages/darkmatter.xml"
-- Dark Pylon
if crsShipwreckedEnabled then
 local darkpylon = Recipe("darkpylon", {
  crsDarkPylonDarkMotes,
 }, RECIPETABS.REFINE, TECH.NONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "darkpylon_placer")
 darkpylon.atlas = "images/inventoryimages/darkpylon.xml"
else
 local darkpylon = Recipe("darkpylon", {
  crsDarkPylonDarkMotes,
 }, RECIPETABS.REFINE, TECH.NONE, "darkpylon_placer")
 darkpylon.atlas = "images/inventoryimages/darkpylon.xml"
end
 
-- action
local CGIVE = Action()
CGIVE.str = "Give"
CGIVE.id = "CGIVE"
CGIVE.fn = function(act)
 if act.invobject.components.ctradable then
  if act.target.components.ctrader then
   act.target.components.ctrader:AcceptGift(act.doer, act.invobject)
   return true
  end
 end
end
AddAction(CGIVE)
AddStategraphActionHandler("wilson", ActionHandler(CGIVE, "give"))

-- add tint
local function crsImageTintUpdate(self, num, atlas, bgim, owner, container)
 if container.widgetbgimagetint then
  self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
 end
end
AddClassPostConstruct("widgets/invslot", crsImageTintUpdate)

-- add item values
local crsItemMoteValue = {
 {name = "ash", motevalue = 1},
 {name = "boneshard", motevalue = 1},
 {name = "charcoal", motevalue = 1},
 {name = "cutgrass", motevalue = 1},
 {name = "cutreeds", motevalue = 1},
 {name = "feather_crow", motevalue = 1},
 {name = "flint", motevalue = 1},
 {name = "log", motevalue = 1},
 {name = "poop", motevalue = 1},
 {name = "rocks", motevalue = 1},
 {name = "stinger", motevalue = 1},
 {name = "thulecite_pieces", motevalue = 1},
 {name = "twigs", motevalue = 1},
 {name = "sand", motevalue = 1},
 {name = "coral", motevalue = 1},
 {name = "bamboo", motevalue = 1},
 {name = "doydoyfeather", motevalue = 1},
 {name = "vine", motevalue = 1},
 {name = "snakeskin", motevalue = 1},
 {name = "palmleaf", motevalue = 1},
 {name = "seashell", motevalue = 1},

 {name = "beardhair", motevalue = 2},
 {name = "beefalowool", motevalue = 2},
 {name = "rottenegg", motevalue = 2},
 {name = "silk", motevalue = 2},
 {name = "slurtleslime", motevalue = 2},
 {name = "spidergland", motevalue = 2},
 {name = "feather_robin", motevalue = 2},
 {name = "nitre", motevalue = 2},
 {name = "limestone", motevalue = 2},
 {name = "venomgland", motevalue = 2},

 {name = "feather_robin_winter", motevalue = 3},
 {name = "goldnugget", motevalue = 3},
 {name = "houndstooth", motevalue = 3},
 {name = "pigskin", motevalue = 3},
 {name = "obsidian", motevalue = 3},
 
 {name = "honeycomb", motevalue = 5},
 {name = "horn", motevalue = 5},
 {name = "lightninggoathorn", motevalue = 5},
 {name = "livinglog", motevalue = 5},
 {name = "manrabbit_tail", motevalue = 5},
 {name = "mosquitosack", motevalue = 5},
 {name = "nightmarefuel", motevalue = 5},
 {name = "tentaclespots", motevalue = 5},
 -- {name = "fireflies", motevalue = 5},
 -- {name = "bioluminescence", motevalue = 5},
 
 {name = "gears", motevalue = 6},
 {name = "marble", motevalue = 6},
 
 {name = "thulecite", motevalue = 8},
 
 {name = "bluegem", motevalue = 10},
 {name = "goose_feather", motevalue = 10},
 {name = "shark_gills", motevalue = 10},
 {name = "redgem", motevalue = 10},
 
 {name = "purplegem", motevalue = 15},
 
 {name = "greengem", motevalue = 20},
 {name = "walrus_tusk", motevalue = 20},
 {name = "yellowgem", motevalue = 20},
 {name = "bearger_fur", motevalue = 50},
 
 {name = "deerclops_eyeball", motevalue = 50},
 {name = "dragon_scales", motevalue = 50},
 {name = "minotaurhorn", motevalue = 50},
 {name = "turbine_blades", motevalue = 50},
 {name = "tigereye", motevalue = 50},
 
 {name = "snakeoil", motevalue = 100},
}

for k,v in pairs(crsItemMoteValue) do
 if v.name then
  AddPrefabPostInit(v.name, function(inst)
   inst:AddTag("ctradable")
   inst:AddComponent("ctradable")    
   inst.components.ctradable.motevalue = v.motevalue
  end)
 end
end

local crsWidgetPosition = Vector3(GetModConfigData("crsHorizontalPosition"),GetModConfigData("crsVerticalPosition"),0) -- background image position
AddPrefabPostInit("darkpylon", function(inst)
 inst.components.container.widgetpos = crsWidgetPosition
end)

local crsMobs = {"spider", "hound", "ghost", "knight", "bat", "frog", "tallbird", "mosquito", "killerbee",}
local crsBosses = {"deerclops",}

local crsReignOfGiantsMobs = {"warg",}
local crsReignOfGiantsBosses = {"bearger", "dragonfly",}

local crsShipwreckedMobs = {"snake", "snake_poison", "mosquito_poison", "dragoon",}
local crsShipwreckedBosses = {"tigershark",}

if crsAnyDLCEnabled then
 for i = 1, #crsReignOfGiantsMobs do
  table.insert(crsMobs, crsReignOfGiantsMobs[i])
  table.insert(crsBosses, crsReignOfGiantsBosses[i])
 end
end

if crsShipwreckedEnabled then
 for i = 1, #crsReignOfGiantsMobs do
  table.insert(crsMobs, crsShipwreckedMobs[i])
  table.insert(crsBosses, crsShipwreckedBosses[i])
 end
end

AddPrefabPostInit("darkmatter", function(inst)
 inst.crsMobs = crsMobs
 inst.crsBosses = crsBosses
end)
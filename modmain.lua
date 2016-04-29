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
GLOBAL.crsDamagePenaltyOnUse = GetModConfigData("crsDarkMatterMaxDamageTaken")
Vector3 = GLOBAL.Vector3
ACTIONS = GLOBAL.ACTIONS
Action = GLOBAL.Action
ActionHandler = GLOBAL.ActionHandler

local C = GLOBAL.IsDLCEnabled(GLOBAL.CAPY_DLC)

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
if C then
 local darkpylon = Recipe("darkpylon", {
  crsDarkPylonDarkMotes,
 }, RECIPETABS.REFINE, TECH.MAGIC_TWO, GLOBAL.RECIPE_GAME_TYPE.COMMON, "darkpylon_placer")
 darkpylon.atlas = "images/inventoryimages/darkpylon.xml"
else
 local darkpylon = Recipe("darkpylon", {
  crsDarkPylonDarkMotes,
 }, RECIPETABS.REFINE, TECH.MAGIC_TWO, "darkpylon_placer")
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
 {name = "backpack", motevalue = 6},
 {name = "beardhair", motevalue = 2},
 {name = "bearger_fur", motevalue = 50},
 {name = "beefalowool", motevalue = 2},
 {name = "bluegem", motevalue = 10},
 {name = "boards", motevalue = 3},
 {name = "boneshard", motevalue = 1},
 {name = "charcoal", motevalue = 1},
 {name = "cutgrass", motevalue = 1},
 {name = "cutreeds", motevalue = 1},
 {name = "cutstone", motevalue = 2},
 {name = "darkmatter", motevalue = GetModConfigData("crsDarkMatterDarkMotes") * 0.5},
 {name = "deerclops_eyeball", motevalue = 50},
 {name = "dragon_scales", motevalue = 50},
 {name = "feather_crow", motevalue = 1},
 {name = "feather_robin", motevalue = 2},
 {name = "feather_robin_winter", motevalue = 3},
 {name = "flint", motevalue = 1},
 {name = "gears", motevalue = 6},
 {name = "goldnugget", motevalue = 3},
 {name = "goose_feather", motevalue = 10},
 {name = "greengem", motevalue = 20},
 {name = "honeycomb", motevalue = 5},
 {name = "horn", motevalue = 5},
 {name = "houndstooth", motevalue = 3},
 {name = "lightninggoathorn", motevalue = 5},
 {name = "livinglog", motevalue = 5},
 {name = "log", motevalue = 1},
 {name = "manrabbit_tail", motevalue = 5},
 {name = "marble", motevalue = 6},
 {name = "minotaurhorn", motevalue = 50},
 {name = "mosquitosack", motevalue = 5},
 {name = "nightmarefuel", motevalue = 5},
 {name = "nitre", motevalue = 2},
 {name = "papyrus", motevalue = 3},
 {name = "piggyback", motevalue = 18},
 {name = "pigskin", motevalue = 3},
 {name = "poop", motevalue = 1},
 {name = "purplegem", motevalue = 15},
 {name = "redgem", motevalue = 10},
 {name = "rocks", motevalue = 1},
 {name = "rope", motevalue = 2},
 {name = "rottenegg", motevalue = 2},
 {name = "silk", motevalue = 2},
 {name = "slurtleslime", motevalue = 2},
 {name = "spidergland", motevalue = 2},
 -- {name = "spoiled_food", motevalue = 1},
 {name = "stinger", motevalue = 1},
 {name = "tentaclespots", motevalue = 5},
 {name = "thulecite", motevalue = 8},
 {name = "thulecite_pieces", motevalue = 1},
 {name = "transistor", motevalue = 6},
 {name = "twigs", motevalue = 1},
 {name = "walrus_tusk", motevalue = 20},
 {name = "yellowgem", motevalue = 20},
 
 {name = "sand", motevalue = 1},
 {name = "coral", motevalue = 1},
 {name = "venomgland", motevalue = 1},
 {name = "bamboo", motevalue = 1},
 {name = "doydoyfeather", motevalue = 1},
 {name = "vine", motevalue = 1},
 {name = "snakeskin", motevalue = 1},
 {name = "palmleaf", motevalue = 1},
 {name = "fabric", motevalue = 2},
 {name = "limestone", motevalue = 2},
 {name = "obsidian", motevalue = 3},
 {name = "dubloon", motevalue = 3},
 {name = "shark_gills", motevalue = 10},
 {name = "turbine_blades", motevalue = 50},
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
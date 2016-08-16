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
IsDLCEnabled = GLOBAL.IsDLCEnabled
SetSharedLootTable = GLOBAL.SetSharedLootTable
getConfig = GetModConfigData
RoG = GLOBAL.REIGN_OF_GIANTS
SW = GLOBAL.CAPY_DLC

-- local noDLC = not IsDLCEnabled(RoG) and not GLOBAL.IsDLCEnabled(SW)
local anyDLC = IsDLCEnabled(RoG) or IsDLCEnabled(SW)
-- local rogDLC = IsDLCEnabled(RoG)
local swDLC = IsDLCEnabled(SW)

local function crsMergeTables(a, b)
    for i=1, #b do
        table.insert(a, b[i])
    end
    return a
end

-- STRINGS --

STRINGS.NAMES.DARKMATTER = "Dark Matter"
STRINGS.RECIPE_DESC.DARKMATTER = "Home-made dark matter."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKMATTER = "I should drop this on the ground, see what happens. YOLO!"
STRINGS.NAMES.DARKMOTE = "Dark Mote"
STRINGS.RECIPE_DESC.DARKMOTE = "Used to create Dark Matter."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKMOTE = "It's used to create Dark Matter."
STRINGS.NAMES.DARKPYLON = "Dark Pylon"
STRINGS.RECIPE_DESC.DARKPYLON = "Turns most things into Dark Motes."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKPYLON = "I better not touch it directly!"

-- RECIPES --

local DMMotes = Ingredient("darkmote", getConfig("cfgDMMotes"))
local DPMotes = Ingredient("darkmote", getConfig("cfgDPMotes"))
DMMotes.atlas = "images/inventoryimages/darkmote.xml"
DPMotes.atlas = "images/inventoryimages/darkmote.xml"
-- Dark Mote --
local darkmote = Recipe("darkmote", {
    Ingredient("goldnugget", 1),
}, RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, 3)
darkmote.atlas = "images/inventoryimages/darkmote.xml"
-- Dark Matter --
local darkmatter = Recipe("darkmatter", {
    DMMotes,
}, RECIPETABS.REFINE, TECH.MAGIC_THREE)
darkmatter.atlas = "images/inventoryimages/darkmatter.xml"
-- Dark Pylon --
if crsShipwreckedEnabled then
local darkpylon = Recipe("darkpylon", {
    DPMotes,
}, RECIPETABS.REFINE, TECH.NONE, GLOBAL.RECIPE_GAME_TYPE.COMMON, "darkpylon_placer")
darkpylon.atlas = "images/inventoryimages/darkpylon.xml"
else
local darkpylon = Recipe("darkpylon", {
    DPMotes,
}, RECIPETABS.REFINE, TECH.NONE, "darkpylon_placer")
darkpylon.atlas = "images/inventoryimages/darkpylon.xml"
end
 
-- TINT --

local function crsImageTintUpdate(self, num, atlas, bgim, owner, container)
    if container.widgetbgimagetint then
        self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
    end
end
AddClassPostConstruct("widgets/invslot", crsImageTintUpdate)

-- ITEM VALUE --

local crsItemConfig = {
    {name = "ash", quality = "common"},
    {name = "boneshard", quality = "common"},
    {name = "charcoal", quality = "common"},
    {name = "cutgrass", quality = "common"},
    {name = "cutreeds", quality = "common"},
    {name = "feather_crow", quality = "common"},
    {name = "flint", quality = "common"},
    {name = "log", quality = "common"},
    {name = "poop", quality = "common"},
    {name = "rocks", quality = "common"},
    {name = "stinger", quality = "common"},
    {name = "thulecite_pieces", quality = "common"},
    {name = "twigs", quality = "common"},
    {name = "sand", quality = "common"},
    {name = "coral", quality = "common"},
    {name = "bamboo", quality = "common"},
    {name = "doydoyfeather", quality = "common"},
    {name = "vine", quality = "common"},
    {name = "snakeskin", quality = "common"},
    {name = "palmleaf", quality = "common"},
    {name = "seashell", quality = "common"},

    {name = "feather_robin", quality = "uncommon"},
    {name = "beefalowool", quality = "uncommon"},
    {name = "rottenegg", quality = "uncommon"},
    {name = "beardhair", quality = "uncommon"},
    {name = "silk", quality = "uncommon"},
    {name = "slurtleslime", quality = "uncommon"},
    {name = "spidergland", quality = "uncommon"},
    {name = "nitre", quality = "uncommon"},
    {name = "limestone", quality = "uncommon"},
    {name = "venomgland", quality = "uncommon"},
    {name = "feather_robin_winter", quality = "uncommon"},

    {name = "goldnugget", quality = "rare"},
    {name = "houndstooth", quality = "rare"},
    {name = "pigskin", quality = "rare"},
    {name = "obsidian", quality = "rare"},
    {name = "manrabbit_tail", quality = "rare"},
    {name = "mosquitosack", quality = "rare"},

    {name = "nightmarefuel", quality = "veryrare"},
    {name = "honeycomb", quality = "veryrare"},
    {name = "lightninggoathorn", quality = "veryrare"},
    {name = "tentaclespots", quality = "veryrare"},
    {name = "marble", quality = "veryrare"},
    {name = "thulecite", quality = "veryrare"},
    {name = "gears", quality = "veryrare"},

    {name = "livinglog", quality = "extremelyrare"},
    {name = "bluegem", quality = "extremelyrare"},
    {name = "redgem", quality = "extremelyrare"},
    {name = "purplegem", quality = "extremelyrare"},


    {name = "goose_feather", quality = "epic"},
    {name = "shark_gills", quality = "epic"},
    {name = "greengem", quality = "epic"},
    {name = "walrus_tusk", quality = "epic"},
    {name = "yellowgem", quality = "epic"},

    {name = "bearger_fur", quality = "legendary"},
    {name = "deerclops_eyeball", quality = "legendary"},
    {name = "dragon_scales", quality = "legendary"},
    {name = "minotaurhorn", quality = "legendary"},
    {name = "turbine_blades", quality = "legendary"},
    {name = "tigereye", quality = "legendary"},

    {name = "snakeoil", quality = "unknown"},
}

local crsQuality = {
    {q = "common",        c = 0.3,   v = 1},
    {q = "uncommon",      c = 0.2,   v = 2},
    {q = "rare",          c = 0.1,   v = 3},
    {q = "veryrare",      c = 0.07,  v = 5},
    {q = "extremelyrare", c = 0.04,  v = 10},
    {q = "epic",          c = 0.02,  v = 20},
    {q = "legendary",     c = 0.01,  v = 50},
    {q = "unknown",       c = 0.001, v = 100},
}

local crsLootTable = {}

for k = 1, #crsItemConfig do
    if crsItemConfig[k].name then
        for n = 1, #crsQuality do
            if crsItemConfig[k].quality == crsQuality[n].q then
                table.insert(crsLootTable, {crsItemConfig[k].name, crsQuality[n].c})
                AddPrefabPostInit(crsItemConfig[k].name, function(inst)
                    inst:AddTag("crsHasDarkValue")  
                    inst:AddTag("crsHasDarkChance")  
                    inst.crsDarkValue = crsQuality[n].v
                end)
            end
        end
    end
end
SetSharedLootTable('darkmatter', crsLootTable)

-- CONTAINER POSITION --

local crsWidgetPosition = Vector3(getConfig("cfgXPos"),getConfig("cfgYPos"),0) -- background image position
AddPrefabPostInit("darkpylon", function(inst)
    inst.components.container.widgetpos = crsWidgetPosition
end)

-- MOB/BOSS SPAWNING --

local crsMobs = {
    "spider",
    "hound",
    "ghost",
    "knight",
    "bat",
    "frog",
    "tallbird",
    "mosquito",
    "killerbee",
}
 
local crsBosses = {
    "deerclops",
}

local crsReignOfGiantsMobs = {
    "warg",
}

local crsReignOfGiantsBosses = {
    "bearger",
    "dragonfly",
}

local crsShipwreckedMobs = {
    "snake",
    "snake_poison",
    "mosquito_poison",
    "dragoon",
}

local crsShipwreckedBosses = {
    "tigershark",
}

if anyDLC then
    for i = 1, #crsReignOfGiantsMobs do
        table.insert(crsMobs, crsReignOfGiantsMobs[i])
        table.insert(crsBosses, crsReignOfGiantsBosses[i])
    end
end

if swDLC then
    for i = 1, #crsReignOfGiantsMobs do
        table.insert(crsMobs, crsShipwreckedMobs[i])
        table.insert(crsBosses, crsShipwreckedBosses[i])
    end
end

AddPrefabPostInit("darkmatter", function(inst)
    inst.crsMobs = crsMobs
    inst.crsBosses = crsBosses
end)
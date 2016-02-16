require "prefabutil"

local assets = {
 Asset("ATLAS", "images/inventoryimages/darkmatter.xml"),
 Asset("IMAGE", "images/inventoryimages/darkmatter.tex"),
}

local function crsOnDropped(inst)
 local gamble = math.random(crsDamagePenaltyOnUse)
 GetPlayer().components.health:DoDelta(-gamble) -- does damage when used
 local oldtuning = TUNING.HAMMER_LOOT_PERCENT
 TUNING.HAMMER_LOOT_PERCENT = 0
 inst:Remove()
 inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/iceboulder_smash")
 inst.components.lootdropper:DropLoot()
 TUNING.HAMMER_LOOT_PERCENT = oldtuning
end

-- loot table
SetSharedLootTable ( 'darkmatter', {
 {"deerclops_eyeball", .01},
 {"bearger_fur", .01},
 {"dragon_scales", .01},
 {"minotaurhorn", .01},
 {"turbine_blades", .01},
 
 {"walrus_tusk", .02},
 
 {"goose_feather", .03},
 {"shark_gills", .03},
 {"purplegem", .03},
 {"bluegem", .03},
 {"redgem", .03},
 {"gears", .03},
 {"thulecite", .03},
 
 {"livinglog", .05},
 {"butter", .05},
 {"manrabbit_tail", .05},
 
 {"tentaclespots", .10},
 
 {"feather_robin_winter", .15},
 {"spidergland", .15},
 
 {"houndstooth", .20},
 {"feather_robin", .20},
 {"slurtleslime", .20},
 {"snakeskin", .20},
 
 {"feather_crow", .25},
 {"silk", .25},
 {"stinger", .25},
 {"venomgland", .25},
 {"bamboo", .25},
 {"doydoyfeather", .25},
 
 {"goldnugget", .30},
 {"obsidian", .30},
  
 {"rocks", 0.40},
 {"flint", 0.40},
 {"twigs", 0.40},
 {"nitre", 0.40},
 {"ash", 0.40},
 {"charcoal", 0.40},
 {"sand", 0.40},
 {"coral", 0.40},
 {"vine", 0.40},
 {"palmleaf", 0.40},
})

local function fn(Sim)
 local inst = CreateEntity()
 
 inst.entity:AddTransform()
 
 MakeInventoryPhysics(inst)
 
 inst.entity:AddAnimState()
 
 inst.entity:AddSoundEmitter()
 
 inst:AddComponent("inventoryitem")
 inst.components.inventoryitem.atlasname = "images/inventoryimages/darkmatter.xml"
 inst.components.inventoryitem.cangoincontainer = true

 inst:AddComponent("lootdropper")
 inst.components.lootdropper:SetChanceLootTable('darkmatter')
 inst:ListenForEvent("ondropped", crsOnDropped)
 
 inst:AddComponent("inspectable")

 return inst
end

return Prefab("common/inventory/darkmatter", fn, assets)

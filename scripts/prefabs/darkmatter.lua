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
if IsDLCEnabled(REIGN_OF_GIANTS) then
SetSharedLootTable ( 'darkmatter', {
 {"deerclops_eyeball", .01},
 {"bearger_fur", .01},
 {"dragon_scales", .01},
 {"minotaurhorn", .01},
 
 {"goose_feather", .02},
 {"walrus_tusk", .02},
 
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
 
 {"feather_crow", .25},
 {"silk", .25},
 {"stinger", .25},
 
 {"goldnugget", .30},
 
 {"rocks", 0.50},
 {"flint", 0.50},
 {"twigs", 0.50},
 {"nitre", 0.50},
 {"ash", 0.50},
 {"charcoal", 0.50},
})
end
SetSharedLootTable ( 'darkmatter', {
 {"goldnugget", .30},
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

require "prefabutil"

local assets = {
 Asset("ATLAS", "images/inventoryimages/darkmatter.xml"),
 Asset("IMAGE", "images/inventoryimages/darkmatter.tex"),
}

local crsDarkMatterDS = nil
if GetModConfigData("crsDarkFarmerTest", "workshop-407474316") == 1 then
 crsDarkMatterDS = "workshop-407474316"
else
 crsDarkMatterDS = "crsDarkMatterDS"
end
local crsMaxDamageTaken = GetModConfigData("crsDarkMatterMaxDamageTaken", crsDarkMatterDS)

local function crsOnDropped(inst)
 local x,y,z = GetPlayer().Transform:GetWorldPosition()
 local crsRandomChance = math.random(1000)
 if crsRandomChance == 666 then
  local crsRandomBoss = inst.crsBosses[math.random(#inst.crsBosses)]
  local crsBoss = SpawnPrefab(crsRandomBoss)
  crsBoss.Transform:SetPosition(x + 5, y + 5, z)
  crsBoss.components.combat:SetTarget(GetPlayer())
 elseif crsRandomChance <= 50 then
  local crsRandomMob = inst.crsMobs[math.random(#inst.crsMobs)]
  local crsMob = SpawnPrefab(crsRandomMob)
  crsMob.Transform:SetPosition(x + 5, y + 5, z)
  crsMob.components.combat:SetTarget(GetPlayer())
 else
  local crsCycles = 1
  local crsJackpot = math.random(10000)
  if crsJackpot == 1337 then
   crsCycles = 100
  end
  local crsRandomDamage = math.random(crsMaxDamageTaken)
  GetPlayer().components.health:DoDelta(-crsRandomDamage) -- does damage when used
  local oldHammerLootPercent = TUNING.HAMMER_LOOT_PERCENT
  TUNING.HAMMER_LOOT_PERCENT = 0
  inst:Remove()
  inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/iceboulder_smash")
  for x = 0, crsCycles do
   inst.components.lootdropper:DropLoot()
  end
  TUNING.HAMMER_LOOT_PERCENT = oldHammerLootPercent
 end
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
 
 inst:AddTag("crsNoAutoCollect")
 
 inst:AddComponent("inventoryitem")
 inst.components.inventoryitem.atlasname = "images/inventoryimages/darkmatter.xml"
 inst.components.inventoryitem.cangoincontainer = true
 
 inst.crsMobs = {}
 inst.crsBosses = {}
 
 inst:AddComponent("lootdropper")
 inst.components.lootdropper:SetChanceLootTable('darkmatter')
 inst:ListenForEvent("ondropped", crsOnDropped)
 
 inst:AddComponent("inspectable")

 return inst
end

return Prefab("common/inventory/darkmatter", fn, assets)

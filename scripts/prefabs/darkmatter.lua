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
 local x,y,z = GetPlayer().Transform:GetWorldPosition() -- get player position
 local crsRandomChance = math.random(1000)
 -- 0.1% chance to spawn a boss 
 if crsRandomChance == 666 then
  local crsRandomBoss = inst.crsBosses[math.random(#inst.crsBosses)]
  local crsBoss = SpawnPrefab(crsRandomBoss)
  crsBoss.Transform:SetPosition(x + 5, y + 5, z)
  crsBoss.components.combat:SetTarget(GetPlayer())
 -- 5% chance to spawn a mob
 elseif crsRandomChance <= 50 then
  local crsRandomMob = inst.crsMobs[math.random(#inst.crsMobs)]
  local crsMob = SpawnPrefab(crsRandomMob)
  crsMob.Transform:SetPosition(x + 5, y + 5, z)
  crsMob.components.combat:SetTarget(GetPlayer())
 else
  local crsCycles = 1
  local crsJackpot = math.random(10000)
  local crsRandomDamage = math.random(crsMaxDamageTaken)
  -- 0.001% chance to drop items 99 more times and restore full health
  if crsJackpot == 1337 then
   crsCycles = 100
   crsRandomDamage = -1000
  end
  GetPlayer().components.health:DoDelta(-crsRandomDamage) -- does damage when used
  local oldHammerLootPercent = TUNING.HAMMER_LOOT_PERCENT
  TUNING.HAMMER_LOOT_PERCENT = 0
  inst:Remove()
  inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/iceboulder_smash")
  for x = 1, crsCycles do
   inst.components.lootdropper:DropLoot()
  end
  TUNING.HAMMER_LOOT_PERCENT = oldHammerLootPercent
 end
end

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

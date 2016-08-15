require "prefabutil"

local assets = {
    Asset("ATLAS", "images/inventoryimages/darkmatter.xml"),
    Asset("IMAGE", "images/inventoryimages/darkmatter.tex"),
}

local crsDarkMatterDS = nil
if GetModConfigData("cfgTestCheck", "workshop-407474316") then
    crsDarkMatterDS = "workshop-407474316"
else
    crsDarkMatterDS = "crsDarkMatterDS"
end
local maxDamage = GetModConfigData("cfgDMMaxDmg", crsDarkMatterDS)

local function crsOnDropped(inst)
    local x,y,z = GetPlayer().Transform:GetWorldPosition() -- get player position
    local chance = math.random(1000)
    -- 0.1% chance to spawn a boss 
    if chance == 666 then
        local randomBoss = inst.crsBosses[math.random(#inst.crsBosses)]
        local boss = SpawnPrefab(randomBoss)
        boss.Transform:SetPosition(x + 5, y + 5, z)
        boss.components.combat:SetTarget(GetPlayer())
    -- 5% chance to spawn a mob
    elseif chance <= 50 then
        local randomMob = inst.crsMobs[math.random(#inst.crsMobs)]
        local mob = SpawnPrefab(randomMob)
        mob.Transform:SetPosition(x + 5, y + 5, z)
        mob.components.combat:SetTarget(GetPlayer())
    else
        local cycles = 1
        local jackpot = math.random(10000)
        local damage = math.random(maxDamage)
        -- 0.001% chance to drop items 99 more times and restore full health
        if jackpot == 1337 then
            cycles = 100
            damage = -1000
        end
        GetPlayer().components.health:DoDelta(-damage) -- does damage when used
        local oldHammerLootPercent = TUNING.HAMMER_LOOT_PERCENT
        TUNING.HAMMER_LOOT_PERCENT = 0
        inst:Remove()
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/iceboulder_smash")
        for x = 1, cycles do
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

local assets = {
 Asset("ANIM", "anim/darkpylon.zip"),
 -- Asset("SOUND", "sound/pig.fsb"),
 Asset("ATLAS", "images/inventoryimages/darkcontainer.xml" ),
 Asset("IMAGE", "images/inventoryimages/darkcontainer.tex" ),
}

local prefabs = {
 "darkmote",
}

local function crsOnOpen(inst)
 inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open", "open")
end 

local function crsOnClose(inst)
 inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close", "open")
end

local function crsOnHammered(inst, worker)
 -- inst.components.lootdropper:DropLoot()
 if inst.components.container then
  inst.components.container:DropEverything()
 end
 if inst.components.workable then
  inst:RemoveComponent("workable")
 end
 inst.SoundEmitter:PlaySound("dontstarve/sanity/shadowhand_snuff")
 inst.AnimState:PlayAnimation("destroyed")
 inst:DoTaskInTime(0.5, function()
  inst:Remove()
 end)
end

local function crsItemTest(inst, item, slot)
 return item:HasTag("crsHasDarkValue") or item.prefab == "darkmote"
end

local function fn(Sim)

 local inst = CreateEntity()

 inst.entity:AddTransform()
 --inst.Transform:SetScale(1.5,1.5,1.5)
 
 MakeObstaclePhysics(inst, 0.5, 0.5) -- can't pass through
 
 inst.entity:AddDynamicShadow()
 inst.DynamicShadow:SetSize(10,5)
 
 inst.entity:AddAnimState()
 inst.AnimState:SetBank("darkpylon")
 inst.AnimState:SetBuild("darkpylon")
 inst.AnimState:PlayAnimation("idle", true)
 
 inst.entity:AddSoundEmitter()
 
 inst:AddTag("crsDarkPylon")
 
 local slotpos = {}
 for y = 2, 0, -1 do
  for x = 0, 2 do
  table.insert(slotpos, Vector3(80*x-80, 80*y-80, 0))
  end
 end
 inst:AddComponent("container")
 inst.components.container.onopenfn = crsOnOpen
 inst.components.container.onclosefn = crsOnClose
 inst.components.container.itemtestfn = crsItemTest
 inst.components.container.side_align_tip = 160
 inst.components.container:SetNumSlots(#slotpos)
 inst.components.container.widgetslotpos = slotpos
 inst.components.container.widgetbgimage = "darkcontainer.tex"
 inst.components.container.widgetbgatlas = "images/inventoryimages/darkcontainer.xml"
 inst.components.container.widgetbgimagetint = {r=95/255,g=95/255,b=95/255,a=1} -- add tint

 inst:AddComponent("inspectable")
 
 inst:AddComponent("lootdropper")

 inst:AddComponent("workable")
 inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
 inst.components.workable:SetWorkLeft(6)
 inst.components.workable:SetOnFinishCallback(crsOnHammered)
  
 local function crsExchangeItems(inst)
  local crsHasTradable = inst.components.container:FindItem(function(crsTradable)
   return crsTradable:HasTag("crsHasDarkValue")
  end)
  if crsHasTradable then
   if crsHasTradable.components.stackable then
    crsHasTradable.components.stackable:Get():Remove()
    for k = 1, crsHasTradable.crsDarkValue, 1 do
     inst.components.container:GiveItem(SpawnPrefab("darkmote"))
    end
   else
    crsHasTradable:Remove()
    for k = 1, crsHasTradable.crsDarkValue, 1 do
     inst.components.container:GiveItem(SpawnPrefab("darkmote"))
    end
   end
  end
 end
 inst:DoPeriodicTask(1, crsExchangeItems)

 return inst
end

return Prefab("common/objects/darkpylon", fn, assets, prefabs),
 MakePlacer("common/darkpylon_placer", "darkpylon", "darkpylon", "idle")

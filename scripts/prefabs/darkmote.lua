require "prefabutil"

local assets = {
 Asset("ATLAS", "images/inventoryimages/darkmote.xml"),
 Asset("IMAGE", "images/inventoryimages/darkmote.tex"),
 Asset("ANIM", "anim/darkmote.zip"),
}

local function fn(Sim)
 local inst = CreateEntity()
 
 inst.entity:AddTransform()
 
 MakeInventoryPhysics(inst)
 
 inst.entity:AddAnimState()
 inst.AnimState:SetBank("darkmote")
 inst.AnimState:SetBuild("darkmote")
 inst.AnimState:PlayAnimation("idle")
 
 inst.entity:AddSoundEmitter()
 
 inst:AddComponent("inventoryitem")
 inst.components.inventoryitem.atlasname = "images/inventoryimages/darkmote.xml"
 inst.components.inventoryitem.cangoincontainer = true
 
 inst:AddComponent("stackable")
 inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
 
 inst:AddComponent("inspectable")

 return inst
end

return Prefab( "common/inventory/darkmote", fn, assets)

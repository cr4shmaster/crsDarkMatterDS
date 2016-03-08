-- similar to the tradable component

local Ctradable = Class(function(self, inst)
 self.inst = inst
 self.motevalue = 0
end)

function Ctradable:CollectUseActions(doer, target, actions)
 if target.components.ctrader and target.components.ctrader.enabled then
  table.insert(actions, ACTIONS.CGIVE)
 end
end

return Ctradable

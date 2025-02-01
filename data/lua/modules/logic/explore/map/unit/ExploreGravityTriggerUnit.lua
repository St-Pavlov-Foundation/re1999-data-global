module("modules.logic.explore.map.unit.ExploreGravityTriggerUnit", package.seeall)

slot0 = class("ExploreGravityTriggerUnit", ExploreBaseDisplayUnit)

function slot0.onRoleEnter(slot0, slot1, slot2, slot3)
	if slot3:isRole() or slot3.mo.canTriggerGear then
		slot0:tryTrigger()
	end
end

return slot0

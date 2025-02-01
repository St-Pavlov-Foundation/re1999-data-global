module("modules.logic.explore.map.unit.ExploreStepUnit", package.seeall)

slot0 = class("ExploreStepUnit", ExploreBaseDisplayUnit)

function slot0.onInit(slot0)
end

function slot0.onRoleEnter(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	if not slot0:canTrigger() then
		return
	end

	if not slot3:isRole() then
		return
	end

	slot0:tryTrigger()
end

return slot0

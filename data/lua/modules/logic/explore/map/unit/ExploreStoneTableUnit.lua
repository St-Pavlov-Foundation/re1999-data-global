module("modules.logic.explore.map.unit.ExploreStoneTableUnit", package.seeall)

slot0 = class("ExploreStoneTableUnit", ExploreBaseMoveUnit)

function slot0.getIdleAnim(slot0)
	if uv0.super.getIdleAnim(slot0) == ExploreAnimEnum.AnimName.active then
		slot1 = (slot0.mo:getInteractInfoMO().statusInfo.status == 1 or ExploreAnimEnum.AnimName.active) and ExploreAnimEnum.AnimName.active2
	end

	return slot1
end

function slot0.canTrigger(slot0)
	if slot0.mo:isInteractActiveState() and slot0.mo:getInteractInfoMO().statusInfo.status ~= 1 then
		return false
	end

	return uv0.super.canTrigger(slot0)
end

function slot0.tryTrigger(slot0, slot1)
	if ExploreStepController.instance:getCurStepType() == ExploreEnum.StepType.DelUnit then
		return
	end

	return uv0.super.tryTrigger(slot0, slot1)
end

function slot0.needInteractAnim(slot0)
	return true
end

function slot0.onStatus2Change(slot0, slot1, slot2)
	if slot0.animComp:isIdleAnim() then
		slot0.animComp:playIdleAnim()
	end
end

return slot0

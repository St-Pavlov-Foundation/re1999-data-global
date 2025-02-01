module("modules.logic.explore.map.unit.ExploreDoorOnceUnit", package.seeall)

slot0 = class("ExploreDoorOnceUnit", ExploreDoor)

function slot0.tryTrigger(slot0, ...)
	if not slot0.mo:isInteractActiveState() then
		uv0.super.tryTrigger(slot0, ...)
	end
end

function slot0.cancelTrigger(slot0, ...)
	if not slot0.mo:isInteractActiveState() then
		uv0.super.cancelTrigger(slot0, ...)
	end
end

function slot0.getIdleAnim(slot0)
	if slot0.mo:isInteractActiveState() then
		return ExploreAnimEnum.AnimName.active
	else
		return uv0.super.getIdleAnim(slot0)
	end
end

function slot0.onUpdateCount(slot0, ...)
	if slot0.mo:isInteractActiveState() then
		if slot0.animComp._curAnim ~= ExploreAnimEnum.AnimName.nToA then
			slot0:playAnim(ExploreAnimEnum.AnimName.active)
		end
	else
		uv0.super.onUpdateCount(slot0, ...)
	end
end

function slot0.onActiveChange(slot0, slot1)
	if slot1 and slot0.animComp._curAnim and slot2 ~= ExploreAnimEnum.AnimName.active and slot0.animComp:isIdleAnim() then
		slot0:playAnim(ExploreAnimEnum.AnimName.nToA)
		slot0:checkShowIcon()

		return
	end

	uv0.super.onActiveChange(slot0, slot1)
end

return slot0

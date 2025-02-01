module("modules.logic.explore.map.unit.ExploreRockUnit", package.seeall)

slot0 = class("ExploreRockUnit", ExploreItemUnit)

function slot0.needInteractAnim(slot0)
	return true
end

function slot0.setExitCallback(slot0, slot1, slot2)
	if slot0._displayTr and slot0:isInFOV() and ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.Spike) and ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.Teleport) then
		slot0._exitCallback = slot1
		slot0._exitCallbackObj = slot2
	else
		slot1(slot2)
	end
end

function slot0._releaseDisplayGo(slot0)
	if slot0._exitCallback then
		slot0._exitCallback(slot0._exitCallbackObj)
	end

	slot0._exitCallback = nil
	slot0._exitCallbackObj = nil

	uv0.super._releaseDisplayGo(slot0)
end

function slot0.onAnimEnd(slot0, slot1, slot2)
	if slot1 == ExploreAnimEnum.AnimName.exit then
		if slot0._exitCallback then
			slot0._exitCallback(slot0._exitCallbackObj)
		end

		slot0._exitCallback = nil
		slot0._exitCallbackObj = nil
	end

	uv0.super.onAnimEnd(slot0, slot1, slot2)
end

function slot0.onDestroy(slot0)
	slot0._exitCallback = nil
	slot0._exitCallbackObj = nil

	uv0.super.onDestroy(slot0)
end

return slot0

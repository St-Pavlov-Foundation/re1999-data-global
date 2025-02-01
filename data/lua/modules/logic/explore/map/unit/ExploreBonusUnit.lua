module("modules.logic.explore.map.unit.ExploreBonusUnit", package.seeall)

slot0 = class("ExploreBonusUnit", ExploreBaseMoveUnit)

function slot0.canTrigger(slot0)
	if slot0.mo:isInteractActiveState() then
		return false
	end

	return uv0.super.canTrigger(slot0)
end

function slot0.playAnim(slot0, slot1)
	uv0.super.playAnim(slot0, slot1)

	if slot1 == ExploreAnimEnum.AnimName.nToA then
		PopupController.instance:setPause("ExploreBonusUnit_EXIT", true)

		slot2 = ExploreController.instance:getMap():getHero()

		slot2:onCheckDir(slot2.nodePos, slot0.nodePos)
		slot2:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.OpenChest, true, true)
		slot0.animComp:setShowEffect(false)
	end
end

function slot0.onAnimEnd(slot0, slot1, slot2)
	if slot1 == ExploreAnimEnum.AnimName.nToA then
		AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage02)
		PopupController.instance:setPause("ExploreBonusUnit_EXIT", false)

		if slot0:checkHavePopup() then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.checkHavePopup, slot0)
		end
	end

	uv0.super.onAnimEnd(slot0, slot1, slot2)
end

function slot0.checkHavePopup(slot0)
	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return true
	else
		slot0:onPopupEnd()
	end
end

function slot0.onPopupEnd(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.checkHavePopup, slot0)
	slot0.animComp:setShowEffect(true)
	slot0.animComp:_setCurAnimName(ExploreAnimEnum.AnimName.active)
end

function slot0.onDestroy(slot0, ...)
	PopupController.instance:setPause("ExploreBonusUnit_EXIT", false)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.checkHavePopup, slot0)
	uv0.super.onDestroy(slot0, ...)
end

return slot0

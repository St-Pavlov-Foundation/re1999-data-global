module("modules.logic.explore.map.unit.ExploreBagItemRewardUnit", package.seeall)

slot0 = class("ExploreBagItemRewardUnit", ExploreBaseDisplayUnit)

function slot0.needInteractAnim(slot0)
	return true
end

function slot0.playAnim(slot0, slot1)
	if slot1 == ExploreAnimEnum.AnimName.exit then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.checkHavePopup, slot0)
	else
		uv0.super.playAnim(slot0, slot1)
	end
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
	slot0.animComp:playAnim(ExploreAnimEnum.AnimName.exit)
end

function slot0.onDestroy(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.checkHavePopup, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0

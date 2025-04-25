module("modules.logic.fight.FightBaseView", package.seeall)

slot0 = class("FightBaseView", FightBaseClass)
slot0.IS_FIGHT_BASE_VIEW = true

function slot0.onConstructor(slot0, ...)
	slot0.inner_visible = true
end

function slot0.setViewVisible(slot0, slot1)
	slot0:setViewVisibleInternal(slot1)
end

function slot0.setViewVisibleInternal(slot0, slot1)
	if slot0.inner_visible == slot1 then
		return
	end

	slot0.inner_visible = slot1

	if not slot0.viewGO then
		return
	end

	slot0.canvasGroup_internal = slot0.canvasGroup_internal or gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
	slot0.canvasGroup_internal.alpha = slot1 and 1 or 0
	slot0.canvasGroup_internal.interactable = slot1
	slot0.canvasGroup_internal.blocksRaycasts = slot1
end

function slot0.inner_startView(slot0)
	slot0:onInitViewInternal()
	slot0:addEventsInternal()
	slot0:onOpenInternal()
	slot0:onOpenFinishInternal()
end

function slot0.onInitViewInternal(slot0)
	slot0.INVOKED_OPEN_VIEW = true

	slot0:onInitView()
end

function slot0.addEventsInternal(slot0)
	slot0:addEvents()
end

function slot0.onOpenInternal(slot0)
	slot0:onOpen()
end

function slot0.onOpenFinishInternal(slot0)
	slot0:onOpenFinish()
end

function slot0.onUpdateParamInternal(slot0)
	slot0:onUpdateParam()
end

function slot0.onClickModalMaskInternal(slot0)
	slot0:onClickModalMask()
end

function slot0.inner_destroyView(slot0)
	slot0:onCloseInternal()
	slot0:onCloseFinishInternal()
	slot0:removeEventsInternal()
	slot0:onDestroyViewInternal()
end

function slot0.onCloseInternal(slot0)
	slot0:onClose()
end

function slot0.onCloseFinishInternal(slot0)
	slot0:onCloseFinish()
end

function slot0.removeEventsInternal(slot0)
	slot0:removeEvents()
end

function slot0.onDestroyViewInternal(slot0)
	slot0:onDestroyView()

	slot0.INVOKED_DESTROY_VIEW = true
end

function slot0.onDestructor(slot0)
	if slot0.INVOKED_OPEN_VIEW and not slot0.INVOKED_DESTROY_VIEW then
		slot0:killMyComponent(FightViewComponent)
		slot0:inner_destroyView()
	end
end

function slot0.__onInit(slot0)
end

function slot0.__onDispose(slot0)
	slot0:disposeSelf()
end

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onOpenFinish(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onClickModalMask(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onCloseFinish(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.getResInst(slot0, slot1, slot2, slot3)
	return slot0.viewContainer:getResInst(slot1, slot2, slot3)
end

function slot0.closeThis(slot0)
	ViewMgr.instance:closeView(slot0.viewName, nil, true)
end

function slot0.tryCallMethodName(slot0, slot1)
	if slot1 == "__onDispose" then
		slot0:__onDispose()
	end
end

function slot0.isHasTryCallFail(slot0)
	return false
end

function slot0.com_registViewItemList(slot0, slot1, slot2, slot3)
	return slot0:getComponent(FightObjItemListComponent):registViewItemList(slot1, slot2, slot3)
end

function slot0.com_openSubView(slot0, slot1, slot2, slot3, ...)
	return slot0:getComponent(FightViewComponent):openSubView(slot1, slot2, slot3, ...)
end

function slot0.com_openSubViewForBaseView(slot0, slot1, slot2, ...)
	return slot0:getComponent(FightViewComponent):openSubViewForBaseView(slot1, slot2, ...)
end

function slot0.com_openExclusiveView(slot0, slot1, slot2, slot3, slot4, ...)
	return slot0:getComponent(FightViewComponent):openExclusiveView(slot1, slot2, slot3, slot4, ...)
end

function slot0.com_hideExclusiveGroup(slot0, slot1)
	return slot0:getComponent(FightViewComponent):hideExclusiveGroup(slot1)
end

function slot0.com_hideExclusiveView(slot0, slot1, slot2, slot3)
	return slot0:getComponent(FightViewComponent):hideExclusiveView(slot1, slot2, slot3)
end

function slot0.com_setExclusiveViewVisible(slot0, slot1, slot2)
	return slot0:getComponent(FightViewComponent):setExclusiveViewVisible(slot1, slot2)
end

function slot0.com_registClick(slot0, slot1, slot2, slot3)
	return slot0:getComponent(FightClickComponent):registClick(slot1, slot2, slot0, slot3)
end

function slot0.com_removeClick(slot0, slot1)
	return slot0:getComponent(FightClickComponent):removeClick(slot1)
end

function slot0.com_registDragBegin(slot0, slot1, slot2, slot3)
	return slot0:getComponent(FightDragComponent):registDragBegin(slot1, slot2, slot0, slot3)
end

function slot0.com_registDrag(slot0, slot1, slot2, slot3)
	return slot0:getComponent(FightDragComponent):registDrag(slot1, slot2, slot0, slot3)
end

function slot0.com_registDragEnd(slot0, slot1, slot2, slot3)
	return slot0:getComponent(FightDragComponent):registDragEnd(slot1, slot2, slot0, slot3)
end

function slot0.com_registLongPress(slot0, slot1, slot2, slot3)
	return slot0:getComponent(FightLongPressComponent):registLongPress(slot1, slot2, slot0, slot3)
end

function slot0.com_registHover(slot0, slot1, slot2)
	return slot0:getComponent(FightLongPressComponent):registHover(slot1, slot2, slot0)
end

function slot0.com_playTween(slot0, slot1, ...)
	return slot0:getComponent(FightTweenComponent):playTween(slot1, ...)
end

function slot0.com_killTween(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0:getComponent(FightTweenComponent):killTween(slot1)
end

function slot0.com_KillTweenByObj(slot0, slot1, slot2)
	return slot0:getComponent(FightTweenComponent):KillTweenByObj(slot1, slot2)
end

return slot0

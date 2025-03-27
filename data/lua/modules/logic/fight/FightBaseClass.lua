module("modules.logic.fight.FightBaseClass", package.seeall)

slot0 = class("FightBaseClass", FightBaseCoreClass)

function slot0.onInitialization(slot0)
end

function slot0.onDestructor(slot0)
end

function slot0.onDestructorFinish(slot0)
end

function slot0.releaseSelf(slot0)
end

function slot0.onAwake(slot0, ...)
end

function slot0.com_loadAsset(slot0, slot1, slot2, slot3)
	slot0:registComponent(FightLoaderComponent):loadAsset(slot1, slot2, slot0, slot3)
end

function slot0.com_loadListAsset(slot0, slot1, slot2, slot3, slot4)
	slot0:registComponent(FightLoaderComponent):loadListAsset(slot1, slot2, slot3, slot0, slot4)
end

function slot0.com_releaseAllLoader(slot0)
	slot0:releaseComponent(FightLoaderComponent)
end

function slot0.com_registFlowSequence(slot0)
	return slot0:com_registCustomFlow(FightWorkFlowSequence)
end

function slot0.com_registFlowParallel(slot0)
	return slot0:com_registCustomFlow(FightWorkFlowParallel)
end

function slot0.com_registWorkDoneFlowSequence(slot0)
	slot1 = slot0:com_registCustomFlow(FightWorkDoneFlowSequence)

	slot1:registFinishCallback(slot0.finishWork, slot0)

	return slot1
end

function slot0.com_registWorkDoneFlowParallel(slot0)
	slot1 = slot0:com_registCustomFlow(FightWorkDoneFlowParallel)

	slot1:registFinishCallback(slot0.finishWork, slot0)

	return slot1
end

function slot0.com_registCustomFlow(slot0, slot1)
	return slot0:registComponent(FightFlowComponent):registCustomFlow(slot1)
end

function slot0.com_releaseAllFlow(slot0)
	slot0:releaseComponent(FightFlowComponent)
end

function slot0.com_registWork(slot0, slot1, ...)
	return slot0:registComponent(FightWorkComponent):registWork(slot1, ...)
end

function slot0.com_playWork(slot0, slot1, ...)
	slot0:registComponent(FightWorkComponent):playWork(slot1, ...)
end

function slot0.com_registAutoSequence(slot0, slot1, ...)
	return slot0:registComponent(FightSequenceAutoWorkComponent):registAutoSequence(slot1, ...)
end

function slot0.com_playAutoWork(slot0, slot1, ...)
	return slot0:registComponent(FightSequenceAutoWorkComponent):playAutoWork(slot1, ...)
end

function slot0.com_registAutoWork(slot0, slot1, ...)
	return slot0:registComponent(FightSequenceAutoWorkComponent):registAutoWork(slot1, ...)
end

function slot0.com_releaseAllWork(slot0)
	slot0:releaseComponent(FightWorkComponent)
	slot0:releaseComponent(FightSequenceAutoWorkComponent)
end

function slot0.com_registObjItemList(slot0, slot1, slot2, slot3)
	return slot0:registComponent(FightObjItemListComponent):registObjItemList(slot1, slot2, slot3)
end

function slot0.com_registViewItemList(slot0, slot1, slot2, slot3)
	return slot0:registComponent(FightObjItemListComponent):registViewItemList(slot1, slot2, slot3)
end

function slot0.com_cancelTimer(slot0, slot1)
	if not slot1 then
		return
	end

	slot1.isDone = true
end

function slot0.com_registTimer(slot0, slot1, slot2, slot3)
	return slot0:com_registRepeatTimer(slot1, slot2, 1, slot3)
end

function slot0.com_registRepeatTimer(slot0, slot1, slot2, slot3, slot4)
	return slot0:registComponent(FightTimerComponent):registRepeatTimer(slot1, slot0, slot2, slot3, slot4)
end

function slot0.com_registSingleTimer(slot0, slot1, slot2, slot3, slot4)
	return slot0:registComponent(FightTimerComponent):registSingleTimer(slot1, slot2, slot0, slot3, 1, slot4)
end

function slot0.com_restartTimer(slot0, slot1, slot2, slot3)
	return slot0:com_restartRepeatTimer(slot1, slot2, 1, slot3)
end

function slot0.com_restartRepeatTimer(slot0, slot1, slot2, slot3, slot4)
	if not slot1.isDone then
		slot1:restart(slot2, slot3, slot4)

		return
	end

	return slot0:registComponent(FightTimerComponent):restartRepeatTimer(slot1, slot2, slot3, slot4)
end

function slot0.com_releaseAllTimer(slot0)
	return slot0:registComponent(FightTimerComponent):releaseAllTimer()
end

function slot0.com_registFightEvent(slot0, slot1, slot2, slot3)
	slot0:com_registEvent(FightController.instance, slot1, slot2, slot3)
end

function slot0.com_registEvent(slot0, slot1, slot2, slot3, slot4)
	slot0:registComponent(FightEventComponent):registEvent(slot1, slot2, slot3, slot0, slot4)
end

function slot0.com_cancelFightEvent(slot0, slot1, slot2)
	slot0:com_cancelEvent(FightController.instance, slot1, slot2)
end

function slot0.com_cancelEvent(slot0, slot1, slot2, slot3)
	slot0:registComponent(FightEventComponent):cancelEvent(slot1, slot2, slot3, slot0)
end

function slot0.com_lockEvent(slot0)
	slot0:registComponent(FightEventComponent):lockEvent()
end

function slot0.com_unlockEvent(slot0)
	slot0:registComponent(FightEventComponent):unlockEvent()
end

function slot0.com_sendFightEvent(slot0, slot1, ...)
	FightController.instance:dispatchEvent(slot1, ...)
end

function slot0.com_sendEvent(slot0, slot1, slot2, ...)
	slot1:dispatchEvent(slot2, ...)
end

function slot0.com_registMsg(slot0, slot1, slot2)
	return slot0:registComponent(FightMsgComponent):registMsg(slot1, slot2, slot0)
end

function slot0.com_removeMsg(slot0, slot1)
	return slot0:registComponent(FightMsgComponent):removeMsg(slot1)
end

function slot0.com_sendMsg(slot0, slot1, ...)
	return FightMsgMgr.sendMsg(slot1, ...)
end

function slot0.com_replyMsg(slot0, slot1, slot2)
	return FightMsgMgr.replyMsg(slot1, slot2)
end

function slot0.com_lockMsg(slot0)
	return slot0:registComponent(FightMsgComponent):lockMsg()
end

function slot0.com_unlockMsg(slot0)
	return slot0:registComponent(FightMsgComponent):unlockMsg()
end

function slot0.com_openSubView(slot0, slot1, slot2, slot3, ...)
	return slot0:registComponent(FightViewComponent):openSubView(slot1, slot2, slot3, ...)
end

function slot0.com_openSubViewForBaseView(slot0, slot1, slot2, ...)
	return slot0:registComponent(FightViewComponent):openSubViewForBaseView(slot1, slot2, ...)
end

function slot0.com_openExclusiveView(slot0, slot1, slot2, slot3, slot4, ...)
	return slot0:registComponent(FightViewComponent):openExclusiveView(slot1, slot2, slot3, slot4, ...)
end

function slot0.com_hideExclusiveGroup(slot0, slot1)
	return slot0:registComponent(FightViewComponent):hideExclusiveGroup(slot1)
end

function slot0.com_hideExclusiveView(slot0, slot1, slot2, slot3)
	return slot0:registComponent(FightViewComponent):hideExclusiveView(slot1, slot2, slot3)
end

function slot0.com_setExclusiveViewVisible(slot0, slot1, slot2)
	return slot0:registComponent(FightViewComponent):setExclusiveViewVisible(slot1, slot2)
end

function slot0.com_registClick(slot0, slot1, slot2, slot3)
	return slot0:registComponent(FightClickComponent):registClick(slot1, slot2, slot0, slot3)
end

function slot0.com_removeClick(slot0, slot1)
	return slot0:registComponent(FightClickComponent):removeClick(slot1)
end

function slot0.com_registDragBegin(slot0, slot1, slot2, slot3)
	return slot0:registComponent(FightDragComponent):registDragBegin(slot1, slot2, slot0, slot3)
end

function slot0.com_registDrag(slot0, slot1, slot2, slot3)
	return slot0:registComponent(FightDragComponent):registDrag(slot1, slot2, slot0, slot3)
end

function slot0.com_registDragEnd(slot0, slot1, slot2, slot3)
	return slot0:registComponent(FightDragComponent):registDragEnd(slot1, slot2, slot0, slot3)
end

function slot0.com_registLongPress(slot0, slot1, slot2, slot3)
	return slot0:registComponent(FightLongPressComponent):registLongPress(slot1, slot2, slot0, slot3)
end

function slot0.com_registHover(slot0, slot1, slot2)
	return slot0:registComponent(FightLongPressComponent):registHover(slot1, slot2, slot0)
end

function slot0.com_registUpdate(slot0, slot1, slot2)
	return slot0:registComponent(FightUpdateComponent):registUpdate(slot1, slot0, slot2)
end

function slot0.com_cancelUpdate(slot0, slot1)
	return slot0:registComponent(FightUpdateComponent):cancelUpdate(slot1)
end

function slot0.com_playTween(slot0, slot1, ...)
	return slot0:registComponent(FightTweenComponent):playTween(slot1, ...)
end

function slot0.com_killTween(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0:registComponent(FightTweenComponent):killTween(slot1)
end

function slot0.com_KillTweenByObj(slot0, slot1)
	return slot0:registComponent(FightTweenComponent):KillTweenByObj(slot1)
end

return slot0

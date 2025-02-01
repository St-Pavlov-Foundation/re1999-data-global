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

function slot0.com_loadListAsset(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:registComponent(FightLoaderComponent):loadListAsset(slot1, slot2, slot3, slot0, slot4, slot5)
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

function slot0.com_registWork(slot0, slot1, ...)
	return slot0:registComponent(FightWorkComponent):registWork(slot1, ...)
end

function slot0.com_playWork(slot0, slot1, ...)
	slot0:registComponent(FightWorkComponent):playWork(slot1, ...)
end

function slot0.com_playSequeueWork(slot0, slot1, ...)
	return slot0:registComponent(FightWorkComponent):playIdSequeueWork(1, slot1, ...)
end

function slot0.com_playIdSequeueWork(slot0, slot1, slot2, ...)
	return slot0:registComponent(FightWorkComponent):playIdSequeueWork(slot1, slot2, ...)
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

function slot0.com_sendFightEvent(slot0, slot1, ...)
	FightController.instance:dispatchEvent(slot1, ...)
end

function slot0.com_sendEvent(slot0, slot1, slot2, ...)
	slot1:dispatchEvent(slot2, ...)
end

function slot0.com_getBuffConfig(slot0, slot1)
end

return slot0

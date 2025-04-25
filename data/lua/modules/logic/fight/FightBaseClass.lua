module("modules.logic.fight.FightBaseClass", package.seeall)

slot0 = class("FightBaseClass", FightBaseCoreClass)

function slot0.onConstructor(slot0)
	slot0.USER_DATA_LIST = {}
	slot0.MY_COMPONENT_DIC = {}
end

function slot0.onAwake(slot0, ...)
end

function slot0.releaseSelf(slot0)
end

function slot0.onDestructor(slot0)
	for slot5 = #slot0.USER_DATA_LIST, 1, -1 do
		for slot10 in pairs(slot1[slot5]) do
			rawset(slot6, slot10, nil)
		end

		rawset(slot1, slot5, nil)
	end

	for slot5, slot6 in pairs(slot0) do
		if type(slot6) == "userdata" then
			rawset(slot0, slot5, nil)
		end
	end

	slot0.USER_DATA_LIST = nil
	slot0.MY_COMPONENT_DIC = nil
end

function slot0.onDestructorFinish(slot0)
end

function slot0.newUserDataTable(slot0)
	if slot0.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用注册table的方法,请检查代码,类名:" .. slot0.__cname)
	end

	slot1 = {}

	table.insert(slot0.USER_DATA_LIST, slot1)

	return slot1
end

function slot0.getUserDataTb_(slot0)
	return slot0:newUserDataTable()
end

function slot0.getComponent(slot0, slot1)
	if slot0.IS_DISPOSED then
		logError("生命周期已经结束了,但是又调用了获取组件的方法,请检查代码,类名:" .. slot0.__cname)
	end

	if slot0.MY_COMPONENT_DIC[slot1.__cname] then
		return slot0.MY_COMPONENT_DIC[slot2]
	end

	slot3 = slot0:addComponent(slot1)
	slot0.MY_COMPONENT_DIC[slot2] = slot3

	return slot3
end

function slot0.killMyComponent(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0.MY_COMPONENT_DIC[slot1.__cname] then
		slot0.MY_COMPONENT_DIC[slot2]:disposeSelf()

		slot0.MY_COMPONENT_DIC[slot2] = nil
	end
end

function slot0.com_loadAsset(slot0, slot1, slot2, slot3)
	slot0:getComponent(FightLoaderComponent):loadAsset(slot1, slot2, slot0, slot3)
end

function slot0.com_loadListAsset(slot0, slot1, slot2, slot3, slot4)
	slot0:getComponent(FightLoaderComponent):loadListAsset(slot1, slot2, slot3, slot0, slot4)
end

function slot0.com_registFlowSequence(slot0)
	return slot0:com_registCustomFlow(FightWorkFlowSequence)
end

function slot0.com_registFlowParallel(slot0)
	return slot0:com_registCustomFlow(FightWorkFlowParallel)
end

function slot0.com_registCustomFlow(slot0, slot1)
	return slot0:getComponent(FightFlowComponent):registCustomFlow(slot1)
end

function slot0.com_registWork(slot0, slot1, ...)
	return slot0:getComponent(FightWorkComponent):registWork(slot1, ...)
end

function slot0.com_playWork(slot0, slot1, ...)
	slot0:getComponent(FightWorkComponent):playWork(slot1, ...)
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
	return slot0:getComponent(FightTimerComponent):registRepeatTimer(slot1, slot0, slot2, slot3, slot4)
end

function slot0.com_registSingleTimer(slot0, slot1, slot2, slot3, slot4)
	return slot0:getComponent(FightTimerComponent):registSingleTimer(slot1, slot2, slot0, slot3, 1, slot4)
end

function slot0.com_restartTimer(slot0, slot1, slot2, slot3)
	return slot0:com_restartRepeatTimer(slot1, slot2, 1, slot3)
end

function slot0.com_restartRepeatTimer(slot0, slot1, slot2, slot3, slot4)
	if not slot1.isDone then
		slot1:restart(slot2, slot3, slot4)

		return
	end

	return slot0:getComponent(FightTimerComponent):restartRepeatTimer(slot1, slot2, slot3, slot4)
end

function slot0.com_registFightEvent(slot0, slot1, slot2, slot3)
	slot0:com_registEvent(FightController.instance, slot1, slot2, slot3)
end

function slot0.com_registEvent(slot0, slot1, slot2, slot3, slot4)
	slot0:getComponent(FightEventComponent):registEvent(slot1, slot2, slot3, slot0, slot4)
end

function slot0.com_cancelFightEvent(slot0, slot1, slot2)
	slot0:com_cancelEvent(FightController.instance, slot1, slot2)
end

function slot0.com_cancelEvent(slot0, slot1, slot2, slot3)
	slot0:getComponent(FightEventComponent):cancelEvent(slot1, slot2, slot3, slot0)
end

function slot0.com_lockEvent(slot0)
	slot0:getComponent(FightEventComponent):lockEvent()
end

function slot0.com_unlockEvent(slot0)
	slot0:getComponent(FightEventComponent):unlockEvent()
end

function slot0.com_sendFightEvent(slot0, slot1, ...)
	FightController.instance:dispatchEvent(slot1, ...)
end

function slot0.com_sendEvent(slot0, slot1, slot2, ...)
	slot1:dispatchEvent(slot2, ...)
end

function slot0.com_registMsg(slot0, slot1, slot2)
	return slot0:getComponent(FightMsgComponent):registMsg(slot1, slot2, slot0)
end

function slot0.com_removeMsg(slot0, slot1)
	return slot0:getComponent(FightMsgComponent):removeMsg(slot1)
end

function slot0.com_sendMsg(slot0, slot1, ...)
	return FightMsgMgr.sendMsg(slot1, ...)
end

function slot0.com_replyMsg(slot0, slot1, slot2)
	return FightMsgMgr.replyMsg(slot1, slot2)
end

function slot0.com_lockMsg(slot0)
	return slot0:getComponent(FightMsgComponent):lockMsg()
end

function slot0.com_unlockMsg(slot0)
	return slot0:getComponent(FightMsgComponent):unlockMsg()
end

function slot0.com_registUpdate(slot0, slot1, slot2)
	return slot0:getComponent(FightUpdateComponent):registUpdate(slot1, slot0, slot2)
end

function slot0.com_cancelUpdate(slot0, slot1)
	return slot0:getComponent(FightUpdateComponent):cancelUpdate(slot1)
end

return slot0

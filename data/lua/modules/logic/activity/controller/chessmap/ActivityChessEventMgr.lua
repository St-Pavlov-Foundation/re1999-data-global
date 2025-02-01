module("modules.logic.activity.controller.chessmap.ActivityChessEventMgr", package.seeall)

slot0 = class("ActivityChessEventMgr")

function slot0.ctor(slot0)
	slot0._stepList = {}
	slot0._stepPool = nil
	slot0._curStep = nil
	slot0._curEventData = nil
	slot0._curEvent = nil
end

slot0.EventClzMap = {
	[ActivityChessEnum.GameEventType.Lock] = ActivityChessStateLock,
	[ActivityChessEnum.GameEventType.Normal] = ActivityChessStateNormal,
	[ActivityChessEnum.GameEventType.Battle] = ActivityChessStateBattle,
	[ActivityChessEnum.GameEventType.UseItem] = ActivityChessStateUseItem,
	[ActivityChessEnum.GameEventType.FinishEvent] = ActivityChessStateFinishEvent
}

function slot0.setCurEvent(slot0, slot1)
	if slot1 ~= nil and not string.nilorempty(slot1.param) then
		slot0._curEventData = cjson.decode(slot1.param)
	else
		slot0._curEventData = nil
	end

	slot0:buildEventState()
end

function slot0.setCurEventByObj(slot0, slot1)
	if slot1 then
		slot0._curEventData = slot1
	else
		slot0._curEventData = nil
	end

	slot0:buildEventState()
end

function slot0.buildEventState(slot0)
	slot1 = nil
	slot1 = (slot0._curEventData or ActivityChessEnum.GameEventType.Normal) and slot0._curEventData.eventType

	if slot0._curEvent and slot0._curEvent:getStateType() == slot1 then
		return
	end

	if uv0.EventClzMap[slot1] then
		slot0:disposeEventState()

		slot0._curEvent = slot2.New()

		slot0._curEvent:init(slot1, slot0._curEventData)
		slot0._curEvent:start()
	end
end

function slot0.setLockEvent(slot0)
	slot0:disposeEventState()

	slot0._curEventData = nil
	slot0._curEvent = ActivityChessStateLock.New()

	slot0._curEvent:init()
	slot0._curEvent:start()
end

function slot0.disposeEventState(slot0)
	if slot0._curEvent ~= nil then
		slot0._curEvent:dispose()

		slot0._curEvent = nil
	end
end

function slot0.getCurEvent(slot0)
	return slot0._curEvent
end

function slot0.insertStepList(slot0, slot1)
	for slot6 = 1, #slot1 do
		slot0:insertStep(slot1[slot6])
	end
end

function slot0.insertStep(slot0, slot1)
	if slot0:buildStep(slot1) then
		slot0._stepList = slot0._stepList or {}

		table.insert(slot0._stepList, slot2)
	end

	if slot0._curStep == nil then
		slot0:nextStep()
	end
end

slot0.StepClzMap = {
	[ActivityChessEnum.GameStepType.GameFinish] = ActivityChessStepGameFinish,
	[ActivityChessEnum.GameStepType.Move] = ActivityChessStepMove,
	[ActivityChessEnum.GameStepType.NextRound] = ActivityChessStepNextRound,
	[ActivityChessEnum.GameStepType.CallEvent] = ActivityChessStepCallEvent,
	[ActivityChessEnum.GameStepType.CreateObject] = ActivityChessStepCreateObject,
	[ActivityChessEnum.GameStepType.DeleteObject] = ActivityChessStepDeleteObject,
	[ActivityChessEnum.GameStepType.PickUp] = ActivityChessStepPickUpItem,
	[ActivityChessEnum.GameStepType.InteractFinish] = ActivityChessStepInteractFinish,
	[ActivityChessEnum.GameStepType.SyncInteractObj] = ActivityChessStepSyncObject
}

function slot0.buildStep(slot0, slot1)
	if uv0.StepClzMap[cjson.decode(slot1.param).stepType] then
		slot4 = nil
		slot0._stepPool = slot0._stepPool or {}

		if slot0._stepPool[slot3] ~= nil and #slot0._stepPool[slot3] >= 1 then
			slot5 = #slot0._stepPool[slot3]
			slot4 = slot0._stepPool[slot3][slot5]
			slot0._stepPool[slot3][slot5] = nil
		else
			slot4 = slot3.New()
		end

		slot4:init(slot2)

		return slot4
	end
end

function slot0.nextStep(slot0)
	slot0:recycleCurStep()

	if not slot0._isStepStarting then
		slot0._isStepStarting = true

		while slot0._stepList and #slot0._stepList > 0 and slot0._curStep == nil do
			slot0._curStep = slot0._stepList[1]

			table.remove(slot0._stepList, 1)
			slot0._curStep:start()
		end

		slot0._isStepStarting = false
	end
end

function slot0.recycleCurStep(slot0)
	if slot0._curStep then
		slot0._curStep:dispose()

		slot0._stepPool[slot0._curStep.class] = slot0._stepPool[slot0._curStep.class] or {}

		table.insert(slot0._stepPool[slot0._curStep.class], slot0._curStep)

		slot0._curStep = nil
	end
end

function slot0.disposeAllStep(slot0)
	if slot0._curStep then
		slot0._curStep:dispose()

		slot0._curStep = nil
	end

	if slot0._stepList then
		for slot4, slot5 in pairs(slot0._stepList) do
			slot5:dispose()
		end

		slot0._stepList = nil
	end

	slot0._stepPool = nil
	slot0._isStepStarting = false
end

function slot0.removeAll(slot0)
	slot0._stepList = nil
	slot0._curStep = nil

	slot0:disposeAllStep()
	slot0:disposeEventState()
end

return slot0

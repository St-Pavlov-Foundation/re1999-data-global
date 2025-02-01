module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessEventMgr", package.seeall)

slot0 = class("Va3ChessEventMgr")

function slot0.ctor(slot0)
	slot0._stepList = {}
	slot0._stepPool = nil
	slot0._curStep = nil
	slot0._curEventData = nil
	slot0._curEvent = nil
end

slot0.EventClzMap = {
	[Va3ChessEnum.GameEventType.Lock] = Va3ChessStateLock,
	[Va3ChessEnum.GameEventType.Normal] = Va3ChessStateNormal,
	[Va3ChessEnum.GameEventType.Battle] = Va3ChessStateBattle,
	[Va3ChessEnum.GameEventType.UseItem] = Va3ChessStateUseItem,
	[Va3ChessEnum.GameEventType.FinishEvent] = Va3ChessStateFinishEvent
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
	slot1 = (slot0._curEventData or Va3ChessEnum.GameEventType.Normal) and slot0._curEventData.eventType

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
	slot0._curEvent = Va3ChessStateLock.New()

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

function slot0.isNeedBlock(slot0)
	if slot0._stepList then
		for slot4 = 1, #slot0._stepList do
			if slot0:_chekNeedBlock(slot0._stepList[slot4]) then
				return true
			end
		end
	end

	if slot0:_chekNeedBlock(slot0._curStep) then
		return true
	end

	return false
end

function slot0._chekNeedBlock(slot0, slot1)
	slot2 = slot1 and slot1.originData and slot1.originData.stepType

	if not slot0._needBlockStepMap then
		slot0._needBlockStepMap = {
			[Va3ChessEnum.GameStepType.Story] = true,
			[Va3ChessEnum.GameStepType.Move] = true,
			[Va3ChessEnum.GameStepType.DeleteObject] = true,
			[Va3ChessEnum.GameStepType.CreateObject] = true,
			[Va3ChessEnum.GameStepType.NextMap] = true
		}
	end

	return slot0._needBlockStepMap[slot2]
end

slot0.StepClzMap = {
	[Va3ChessEnum.GameStepType.GameFinish] = Va3ChessStepGameFinish,
	[Va3ChessEnum.GameStepType.Move] = Va3ChessStepMove,
	[Va3ChessEnum.GameStepType.NextRound] = Va3ChessStepNextRound,
	[Va3ChessEnum.GameStepType.CallEvent] = Va3ChessStepCallEvent,
	[Va3ChessEnum.GameStepType.CreateObject] = Va3ChessStepCreateObject,
	[Va3ChessEnum.GameStepType.DeleteObject] = Va3ChessStepDeleteObject,
	[Va3ChessEnum.GameStepType.PickUp] = Va3ChessStepPickUpItem,
	[Va3ChessEnum.GameStepType.InteractFinish] = Va3ChessStepInteractFinish,
	[Va3ChessEnum.GameStepType.SyncInteractObj] = Va3ChessStepSyncObject,
	[Va3ChessEnum.GameStepType.Story] = Va3ChessStepStory,
	[Va3ChessEnum.GameStepType.Toast] = Va3ChessStepToast,
	[Va3ChessEnum.GameStepType.NextMap] = Va3ChessStepNextMap,
	[Va3ChessEnum.GameStepType.HpUpdate] = Va3ChessStepDeductHp,
	[Va3ChessEnum.GameStepType.MapUpdate] = Va3ChessStepMapUpdate,
	[Va3ChessEnum.GameStepType.TargetUpdate] = Va3ChessStepTargetUpdate,
	[Va3ChessEnum.GameStepType.BulletUpdate] = Va3ChessStepBulletUpdate,
	[Va3ChessEnum.GameStepType.BrazierTrigger] = Va3ChessStepBrazierTrigger,
	[Va3ChessEnum.GameStepType.RefreshPedalStatus] = Va3ChessStepRefreshPedal
}
slot0.ActStepClzMap = {
	[Va3ChessEnum.ActivityId.Act120] = {
		[Va3ChessEnum.GameStepType.NextMap] = Va3ChessStepNextMapAct120,
		[Va3ChessEnum.Act120StepType.TilePosui] = Va3ChessStepTilePoSui
	},
	[Va3ChessEnum.ActivityId.Act142] = {
		[Va3ChessEnum.Act142StepType.TileFragile] = Va3ChessStepTileBroken,
		[Va3ChessEnum.Act142StepType.TileBroken] = Va3ChessStepTileBroken
	}
}

function slot0.buildStep(slot0, slot1)
	slot2 = cjson.decode(slot1.param)
	slot5 = uv0.ActStepClzMap[Va3ChessGameModel.instance:getActId()] and slot4[slot2.stepType] or uv0.StepClzMap[slot2.stepType]

	if slot2.stepType == Va3ChessEnum.GameStepType.NextMap then
		logNormal("stepClz actId = " .. slot3)
	end

	if slot5 then
		slot6 = nil
		slot0._stepPool = slot0._stepPool or {}

		if slot0._stepPool[slot5] ~= nil and #slot0._stepPool[slot5] >= 1 then
			slot7 = #slot0._stepPool[slot5]
			slot6 = slot0._stepPool[slot5][slot7]
			slot0._stepPool[slot5][slot7] = nil
		else
			slot6 = slot5.New()
		end

		slot6:init(slot2)

		return slot6
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

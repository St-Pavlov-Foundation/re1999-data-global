module("modules.logic.chessgame.game.event.ChessEventMgr", package.seeall)

slot0 = class("ChessEventMgr")

function slot0.ctor(slot0)
	slot0._stepList = {}
	slot0._stepPool = nil
	slot0._curStep = nil
	slot0._curEventData = nil
	slot0._curEvent = nil
	slot0._flow = nil
	slot0._lastWork = nil
end

slot0.EventClzMap = {
	[ChessGameEnum.GameEventType.Normal] = ChessStateNormal
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
	slot1 = (slot0._curEventData or ChessGameEnum.GameEventType.Normal) and slot0._curEventData.eventType

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
	slot0._curEvent = ChessStateLock.New()

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
	slot0._flow = FlowSequence.New()

	for slot6 = 1, #slot1 do
		slot0:insertStep2(slot0._flow, slot1[slot6])
	end

	slot0._flow:addWork(ChessCheckIsCatch.New())

	slot0._moveFlow = nil

	slot0._flow:registerDoneListener(slot0._onFlowDone, slot0)
	slot0._flow:start(ChessGameModel.instance:getCatchObj())
end

function slot0._onFlowDone(slot0)
	if not ChessGameModel.instance:isTalking() then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameMapDataUpdate)
	end

	slot0._flow = nil
	slot0._lastWork = nil
end

function slot0.isPlayingFlow(slot0)
	if slot0._flow then
		return true
	end
end

function slot0.stopFlow(slot0)
	if slot0._flow and slot0._flow.status == WorkStatus.Running then
		slot0._flow:stop()
	end

	slot0._flow = nil
end

function slot0.insertStep2(slot0, slot1, slot2)
	if slot0:buildStep(slot2).originData.stepType == ChessGameEnum.StepType.Move then
		if slot0._lastWork and slot0._lastWork.originData.id == slot3.originData.id then
			slot0._moveFlow = nil

			slot1:addWork(slot3)

			slot0._lastWork = slot3
		else
			if not slot0._moveFlow then
				slot0._moveFlow = FlowParallel.New()

				slot1:addWork(slot0._moveFlow)

				slot0._lastWork = slot3
			end

			slot0._moveFlow:addWork(slot3)

			slot0._lastWork = slot3
		end
	else
		slot0._moveFlow = nil

		slot1:addWork(slot3)

		slot0._lastWork = slot3
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
			[ChessGameEnum.StepType.Story] = true,
			[ChessGameEnum.StepType.Move] = true,
			[ChessGameEnum.StepType.InteractDelete] = true,
			[ChessGameEnum.StepType.Transport] = true,
			[ChessGameEnum.StepType.Dialogue] = true
		}
	end

	return slot0._needBlockStepMap[slot2]
end

slot0.StepClzMap = {
	[ChessGameEnum.StepType.UpdateRound] = ChessStepUpdateRound,
	[ChessGameEnum.StepType.Move] = ChessStepMove,
	[ChessGameEnum.StepType.Transport] = ChessStepTransport,
	[ChessGameEnum.StepType.CurrMapRefresh] = ChessStepCurrMapRefresh,
	[ChessGameEnum.StepType.InteractDelete] = ChessStepInteractDelete,
	[ChessGameEnum.StepType.Story] = ChessStepStory,
	[ChessGameEnum.StepType.Guide] = ChessStepGuide,
	[ChessGameEnum.StepType.Pass] = ChessStepPass,
	[ChessGameEnum.StepType.Dead] = ChessStepDead,
	[ChessGameEnum.StepType.Dialogue] = ChessStepDialogue,
	[ChessGameEnum.StepType.Completed] = ChessStepCompleted,
	[ChessGameEnum.StepType.ShowInteract] = ChessStepShowInteract,
	[ChessGameEnum.StepType.ChangeModule] = ChessStepChangeModule,
	[ChessGameEnum.StepType.ShowToast] = ChessStepShowToast,
	[ChessGameEnum.StepType.BreakObstacle] = ChessStepBreakObstacle,
	[ChessGameEnum.StepType.Talk] = ChessStepTalk,
	[ChessGameEnum.StepType.RefreshTarget] = ChessStepRefreshTarget
}

function slot0.buildStep(slot0, slot1)
	slot3 = ChessModel.instance:getActId()

	if uv0.StepClzMap[cjson.decode(slot1.param).stepType] then
		slot5 = nil
		slot0._stepPool = slot0._stepPool or {}

		if slot0._stepPool[slot4] ~= nil and #slot0._stepPool[slot4] >= 1 then
			slot6 = #slot0._stepPool[slot4]
			slot5 = slot0._stepPool[slot4][slot6]
			slot0._stepPool[slot4][slot6] = nil
		else
			slot5 = slot4.New()
		end

		slot5:init(slot2)

		return slot5
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

module("modules.logic.chessgame.game.event.ChessEventMgr", package.seeall)

local var_0_0 = class("ChessEventMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._stepList = {}
	arg_1_0._stepPool = nil
	arg_1_0._curStep = nil
	arg_1_0._curEventData = nil
	arg_1_0._curEvent = nil
	arg_1_0._flow = nil
	arg_1_0._lastWork = nil
end

var_0_0.EventClzMap = {
	[ChessGameEnum.GameEventType.Normal] = ChessStateNormal
}

function var_0_0.setCurEvent(arg_2_0, arg_2_1)
	if arg_2_1 ~= nil and not string.nilorempty(arg_2_1.param) then
		arg_2_0._curEventData = cjson.decode(arg_2_1.param)
	else
		arg_2_0._curEventData = nil
	end

	arg_2_0:buildEventState()
end

function var_0_0.setCurEventByObj(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0._curEventData = arg_3_1
	else
		arg_3_0._curEventData = nil
	end

	arg_3_0:buildEventState()
end

function var_0_0.buildEventState(arg_4_0)
	local var_4_0

	if not arg_4_0._curEventData then
		var_4_0 = ChessGameEnum.GameEventType.Normal
	else
		var_4_0 = arg_4_0._curEventData.eventType
	end

	if arg_4_0._curEvent and arg_4_0._curEvent:getStateType() == var_4_0 then
		return
	end

	local var_4_1 = var_0_0.EventClzMap[var_4_0]

	if var_4_1 then
		arg_4_0:disposeEventState()

		arg_4_0._curEvent = var_4_1.New()

		arg_4_0._curEvent:init(var_4_0, arg_4_0._curEventData)
		arg_4_0._curEvent:start()
	end
end

function var_0_0.setLockEvent(arg_5_0)
	arg_5_0:disposeEventState()

	arg_5_0._curEventData = nil
	arg_5_0._curEvent = ChessStateLock.New()

	arg_5_0._curEvent:init()
	arg_5_0._curEvent:start()
end

function var_0_0.disposeEventState(arg_6_0)
	if arg_6_0._curEvent ~= nil then
		arg_6_0._curEvent:dispose()

		arg_6_0._curEvent = nil
	end
end

function var_0_0.getCurEvent(arg_7_0)
	return arg_7_0._curEvent
end

function var_0_0.insertStepList(arg_8_0, arg_8_1)
	arg_8_0._flow = FlowSequence.New()

	local var_8_0 = #arg_8_1

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = arg_8_1[iter_8_0]

		arg_8_0:insertStep2(arg_8_0._flow, var_8_1)
	end

	arg_8_0._flow:addWork(ChessCheckIsCatch.New())

	arg_8_0._moveFlow = nil

	arg_8_0._flow:registerDoneListener(arg_8_0._onFlowDone, arg_8_0)

	local var_8_2 = ChessGameModel.instance:getCatchObj()

	arg_8_0._flow:start(var_8_2)
end

function var_0_0._onFlowDone(arg_9_0)
	if not ChessGameModel.instance:isTalking() then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameMapDataUpdate)
	end

	arg_9_0._flow = nil
	arg_9_0._lastWork = nil
end

function var_0_0.isPlayingFlow(arg_10_0)
	if arg_10_0._flow then
		return true
	end
end

function var_0_0.stopFlow(arg_11_0)
	if arg_11_0._flow and arg_11_0._flow.status == WorkStatus.Running then
		arg_11_0._flow:stop()
	end

	arg_11_0._flow = nil
end

function var_0_0.insertStep2(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:buildStep(arg_12_2)

	if var_12_0.originData.stepType == ChessGameEnum.StepType.Move then
		if arg_12_0._lastWork and arg_12_0._lastWork.originData.id == var_12_0.originData.id then
			arg_12_0._moveFlow = nil

			arg_12_1:addWork(var_12_0)

			arg_12_0._lastWork = var_12_0
		else
			if not arg_12_0._moveFlow then
				arg_12_0._moveFlow = FlowParallel.New()

				arg_12_1:addWork(arg_12_0._moveFlow)

				arg_12_0._lastWork = var_12_0
			end

			arg_12_0._moveFlow:addWork(var_12_0)

			arg_12_0._lastWork = var_12_0
		end
	else
		arg_12_0._moveFlow = nil

		arg_12_1:addWork(var_12_0)

		arg_12_0._lastWork = var_12_0
	end
end

function var_0_0.isNeedBlock(arg_13_0)
	if arg_13_0._stepList then
		for iter_13_0 = 1, #arg_13_0._stepList do
			if arg_13_0:_chekNeedBlock(arg_13_0._stepList[iter_13_0]) then
				return true
			end
		end
	end

	if arg_13_0:_chekNeedBlock(arg_13_0._curStep) then
		return true
	end

	return false
end

function var_0_0._chekNeedBlock(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 and arg_14_1.originData and arg_14_1.originData.stepType

	if not arg_14_0._needBlockStepMap then
		arg_14_0._needBlockStepMap = {
			[ChessGameEnum.StepType.Story] = true,
			[ChessGameEnum.StepType.Move] = true,
			[ChessGameEnum.StepType.InteractDelete] = true,
			[ChessGameEnum.StepType.Transport] = true,
			[ChessGameEnum.StepType.Dialogue] = true
		}
	end

	return arg_14_0._needBlockStepMap[var_14_0]
end

var_0_0.StepClzMap = {
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

function var_0_0.buildStep(arg_15_0, arg_15_1)
	local var_15_0 = cjson.decode(arg_15_1.param)
	local var_15_1 = ChessModel.instance:getActId()
	local var_15_2 = var_0_0.StepClzMap[var_15_0.stepType]

	if var_15_2 then
		local var_15_3

		arg_15_0._stepPool = arg_15_0._stepPool or {}

		if arg_15_0._stepPool[var_15_2] ~= nil and #arg_15_0._stepPool[var_15_2] >= 1 then
			local var_15_4 = #arg_15_0._stepPool[var_15_2]

			var_15_3 = arg_15_0._stepPool[var_15_2][var_15_4]
			arg_15_0._stepPool[var_15_2][var_15_4] = nil
		else
			var_15_3 = var_15_2.New()
		end

		var_15_3:init(var_15_0)

		return var_15_3
	end
end

function var_0_0.nextStep(arg_16_0)
	arg_16_0:recycleCurStep()

	if not arg_16_0._isStepStarting then
		arg_16_0._isStepStarting = true

		while arg_16_0._stepList and #arg_16_0._stepList > 0 and arg_16_0._curStep == nil do
			arg_16_0._curStep = arg_16_0._stepList[1]

			table.remove(arg_16_0._stepList, 1)
			arg_16_0._curStep:start()
		end

		arg_16_0._isStepStarting = false
	end
end

function var_0_0.recycleCurStep(arg_17_0)
	if arg_17_0._curStep then
		arg_17_0._curStep:dispose()

		arg_17_0._stepPool[arg_17_0._curStep.class] = arg_17_0._stepPool[arg_17_0._curStep.class] or {}

		table.insert(arg_17_0._stepPool[arg_17_0._curStep.class], arg_17_0._curStep)

		arg_17_0._curStep = nil
	end
end

function var_0_0.disposeAllStep(arg_18_0)
	if arg_18_0._curStep then
		arg_18_0._curStep:dispose()

		arg_18_0._curStep = nil
	end

	if arg_18_0._stepList then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._stepList) do
			iter_18_1:dispose()
		end

		arg_18_0._stepList = nil
	end

	arg_18_0._stepPool = nil
	arg_18_0._isStepStarting = false
end

function var_0_0.removeAll(arg_19_0)
	arg_19_0._stepList = nil
	arg_19_0._curStep = nil

	arg_19_0:disposeAllStep()
	arg_19_0:disposeEventState()
end

return var_0_0

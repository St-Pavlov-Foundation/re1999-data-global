module("modules.logic.activity.controller.chessmap.ActivityChessEventMgr", package.seeall)

local var_0_0 = class("ActivityChessEventMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._stepList = {}
	arg_1_0._stepPool = nil
	arg_1_0._curStep = nil
	arg_1_0._curEventData = nil
	arg_1_0._curEvent = nil
end

var_0_0.EventClzMap = {
	[ActivityChessEnum.GameEventType.Lock] = ActivityChessStateLock,
	[ActivityChessEnum.GameEventType.Normal] = ActivityChessStateNormal,
	[ActivityChessEnum.GameEventType.Battle] = ActivityChessStateBattle,
	[ActivityChessEnum.GameEventType.UseItem] = ActivityChessStateUseItem,
	[ActivityChessEnum.GameEventType.FinishEvent] = ActivityChessStateFinishEvent
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
		var_4_0 = ActivityChessEnum.GameEventType.Normal
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
	arg_5_0._curEvent = ActivityChessStateLock.New()

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
	local var_8_0 = #arg_8_1

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = arg_8_1[iter_8_0]

		arg_8_0:insertStep(var_8_1)
	end
end

function var_0_0.insertStep(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:buildStep(arg_9_1)

	if var_9_0 then
		arg_9_0._stepList = arg_9_0._stepList or {}

		table.insert(arg_9_0._stepList, var_9_0)
	end

	if arg_9_0._curStep == nil then
		arg_9_0:nextStep()
	end
end

var_0_0.StepClzMap = {
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

function var_0_0.buildStep(arg_10_0, arg_10_1)
	local var_10_0 = cjson.decode(arg_10_1.param)
	local var_10_1 = var_0_0.StepClzMap[var_10_0.stepType]

	if var_10_1 then
		local var_10_2

		arg_10_0._stepPool = arg_10_0._stepPool or {}

		if arg_10_0._stepPool[var_10_1] ~= nil and #arg_10_0._stepPool[var_10_1] >= 1 then
			local var_10_3 = #arg_10_0._stepPool[var_10_1]

			var_10_2 = arg_10_0._stepPool[var_10_1][var_10_3]
			arg_10_0._stepPool[var_10_1][var_10_3] = nil
		else
			var_10_2 = var_10_1.New()
		end

		var_10_2:init(var_10_0)

		return var_10_2
	end
end

function var_0_0.nextStep(arg_11_0)
	arg_11_0:recycleCurStep()

	if not arg_11_0._isStepStarting then
		arg_11_0._isStepStarting = true

		while arg_11_0._stepList and #arg_11_0._stepList > 0 and arg_11_0._curStep == nil do
			arg_11_0._curStep = arg_11_0._stepList[1]

			table.remove(arg_11_0._stepList, 1)
			arg_11_0._curStep:start()
		end

		arg_11_0._isStepStarting = false
	end
end

function var_0_0.recycleCurStep(arg_12_0)
	if arg_12_0._curStep then
		arg_12_0._curStep:dispose()

		arg_12_0._stepPool[arg_12_0._curStep.class] = arg_12_0._stepPool[arg_12_0._curStep.class] or {}

		table.insert(arg_12_0._stepPool[arg_12_0._curStep.class], arg_12_0._curStep)

		arg_12_0._curStep = nil
	end
end

function var_0_0.disposeAllStep(arg_13_0)
	if arg_13_0._curStep then
		arg_13_0._curStep:dispose()

		arg_13_0._curStep = nil
	end

	if arg_13_0._stepList then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._stepList) do
			iter_13_1:dispose()
		end

		arg_13_0._stepList = nil
	end

	arg_13_0._stepPool = nil
	arg_13_0._isStepStarting = false
end

function var_0_0.removeAll(arg_14_0)
	arg_14_0._stepList = nil
	arg_14_0._curStep = nil

	arg_14_0:disposeAllStep()
	arg_14_0:disposeEventState()
end

return var_0_0

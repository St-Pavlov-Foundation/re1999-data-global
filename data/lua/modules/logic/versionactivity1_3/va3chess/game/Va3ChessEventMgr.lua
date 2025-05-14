module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessEventMgr", package.seeall)

local var_0_0 = class("Va3ChessEventMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._stepList = {}
	arg_1_0._stepPool = nil
	arg_1_0._curStep = nil
	arg_1_0._curEventData = nil
	arg_1_0._curEvent = nil
end

var_0_0.EventClzMap = {
	[Va3ChessEnum.GameEventType.Lock] = Va3ChessStateLock,
	[Va3ChessEnum.GameEventType.Normal] = Va3ChessStateNormal,
	[Va3ChessEnum.GameEventType.Battle] = Va3ChessStateBattle,
	[Va3ChessEnum.GameEventType.UseItem] = Va3ChessStateUseItem,
	[Va3ChessEnum.GameEventType.FinishEvent] = Va3ChessStateFinishEvent
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
		var_4_0 = Va3ChessEnum.GameEventType.Normal
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
	arg_5_0._curEvent = Va3ChessStateLock.New()

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

function var_0_0.isNeedBlock(arg_10_0)
	if arg_10_0._stepList then
		for iter_10_0 = 1, #arg_10_0._stepList do
			if arg_10_0:_chekNeedBlock(arg_10_0._stepList[iter_10_0]) then
				return true
			end
		end
	end

	if arg_10_0:_chekNeedBlock(arg_10_0._curStep) then
		return true
	end

	return false
end

function var_0_0._chekNeedBlock(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1.originData and arg_11_1.originData.stepType

	if not arg_11_0._needBlockStepMap then
		arg_11_0._needBlockStepMap = {
			[Va3ChessEnum.GameStepType.Story] = true,
			[Va3ChessEnum.GameStepType.Move] = true,
			[Va3ChessEnum.GameStepType.DeleteObject] = true,
			[Va3ChessEnum.GameStepType.CreateObject] = true,
			[Va3ChessEnum.GameStepType.NextMap] = true
		}
	end

	return arg_11_0._needBlockStepMap[var_11_0]
end

var_0_0.StepClzMap = {
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
var_0_0.ActStepClzMap = {
	[Va3ChessEnum.ActivityId.Act120] = {
		[Va3ChessEnum.GameStepType.NextMap] = Va3ChessStepNextMapAct120,
		[Va3ChessEnum.Act120StepType.TilePosui] = Va3ChessStepTilePoSui
	},
	[Va3ChessEnum.ActivityId.Act142] = {
		[Va3ChessEnum.Act142StepType.TileFragile] = Va3ChessStepTileBroken,
		[Va3ChessEnum.Act142StepType.TileBroken] = Va3ChessStepTileBroken
	}
}

function var_0_0.buildStep(arg_12_0, arg_12_1)
	local var_12_0 = cjson.decode(arg_12_1.param)
	local var_12_1 = Va3ChessGameModel.instance:getActId()
	local var_12_2 = var_0_0.ActStepClzMap[var_12_1]
	local var_12_3 = var_12_2 and var_12_2[var_12_0.stepType] or var_0_0.StepClzMap[var_12_0.stepType]

	if var_12_0.stepType == Va3ChessEnum.GameStepType.NextMap then
		logNormal("stepClz actId = " .. var_12_1)
	end

	if var_12_3 then
		local var_12_4

		arg_12_0._stepPool = arg_12_0._stepPool or {}

		if arg_12_0._stepPool[var_12_3] ~= nil and #arg_12_0._stepPool[var_12_3] >= 1 then
			local var_12_5 = #arg_12_0._stepPool[var_12_3]

			var_12_4 = arg_12_0._stepPool[var_12_3][var_12_5]
			arg_12_0._stepPool[var_12_3][var_12_5] = nil
		else
			var_12_4 = var_12_3.New()
		end

		var_12_4:init(var_12_0)

		return var_12_4
	end
end

function var_0_0.nextStep(arg_13_0)
	arg_13_0:recycleCurStep()

	if not arg_13_0._isStepStarting then
		arg_13_0._isStepStarting = true

		while arg_13_0._stepList and #arg_13_0._stepList > 0 and arg_13_0._curStep == nil do
			arg_13_0._curStep = arg_13_0._stepList[1]

			table.remove(arg_13_0._stepList, 1)
			arg_13_0._curStep:start()
		end

		arg_13_0._isStepStarting = false
	end
end

function var_0_0.recycleCurStep(arg_14_0)
	if arg_14_0._curStep then
		arg_14_0._curStep:dispose()

		arg_14_0._stepPool[arg_14_0._curStep.class] = arg_14_0._stepPool[arg_14_0._curStep.class] or {}

		table.insert(arg_14_0._stepPool[arg_14_0._curStep.class], arg_14_0._curStep)

		arg_14_0._curStep = nil
	end
end

function var_0_0.disposeAllStep(arg_15_0)
	if arg_15_0._curStep then
		arg_15_0._curStep:dispose()

		arg_15_0._curStep = nil
	end

	if arg_15_0._stepList then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._stepList) do
			iter_15_1:dispose()
		end

		arg_15_0._stepList = nil
	end

	arg_15_0._stepPool = nil
	arg_15_0._isStepStarting = false
end

function var_0_0.removeAll(arg_16_0)
	arg_16_0._stepList = nil
	arg_16_0._curStep = nil

	arg_16_0:disposeAllStep()
	arg_16_0:disposeEventState()
end

return var_0_0

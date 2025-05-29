module("modules.logic.versionactivity2_6.xugouji.controller.XugoujiGameStepController", package.seeall)

local var_0_0 = class("XugoujiGameStepController", BaseController)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.ctor(arg_1_0)
	arg_1_0._stepList = {}
	arg_1_0._stepPool = nil
	arg_1_0._curStep = nil
	arg_1_0.muteAutoNext = false
end

function var_0_0.insertStepList(arg_2_0, arg_2_1)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)

	local var_2_0 = #arg_2_1

	for iter_2_0 = 1, var_2_0 do
		local var_2_1 = arg_2_1[iter_2_0]

		arg_2_0:insertStep(var_2_1)
	end
end

function var_0_0.insertStep(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:buildStep(arg_3_1)

	if var_3_0 then
		arg_3_0._stepList = arg_3_0._stepList or {}

		table.insert(arg_3_0._stepList, var_3_0)
	end

	if arg_3_0._curStep == nil then
		arg_3_0:nextStep()
	end
end

function var_0_0.insertStepListClient(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = #arg_4_1

	for iter_4_0 = 1, var_4_0 do
		local var_4_1 = arg_4_0:buildStepClient(arg_4_1[iter_4_0])

		if var_4_1 then
			arg_4_0._stepList = arg_4_0._stepList or {}

			if arg_4_2 then
				table.insert(arg_4_0._stepList, iter_4_0, var_4_1)
			else
				table.insert(arg_4_0._stepList, var_4_1)
			end
		end

		if arg_4_0._curStep == nil then
			arg_4_0:nextStep()
		end
	end
end

var_0_0.StepClzMap = {
	[XugoujiEnum.GameStepType.HpUpdate] = XugoujiGameStepHpUpdate,
	[XugoujiEnum.GameStepType.UpdateCardStatus] = XugoujiGameStepCardUpdate,
	[XugoujiEnum.GameStepType.Result] = XugoujiGameStepResult,
	[XugoujiEnum.GameStepType.ChangeTurn] = XugoujiGameStepChangeTurn,
	[XugoujiEnum.GameStepType.NewCards] = XugoujiGameStepNewCards,
	[XugoujiEnum.GameStepType.GotCardPair] = XugoujiGameStepPairsUpdate,
	[XugoujiEnum.GameStepType.OperateNumUpdate] = XugoujiGameStepOperateNumUpdate,
	[XugoujiEnum.GameStepType.BuffUpdate] = XugoujiGameStepBuffUpdate,
	[XugoujiEnum.GameStepType.UpdateCardEffectStatus] = XugoujiGameStepCardEffectStatue,
	[XugoujiEnum.GameStepType.WaitGameStart] = XugoujiGameStepWaitGameStart,
	[XugoujiEnum.GameStepType.UpdateInitialCard] = XugoujiGameStepInitialCard,
	[XugoujiEnum.GameStepType.GameReStart] = XugoujiGameStepGameReStart
}

function var_0_0.buildStep(arg_5_0, arg_5_1)
	local var_5_0 = cjson.decode(arg_5_1.param)

	if var_5_0.stepType == XugoujiEnum.GameStepType.HpUpdate then
		local var_5_1 = var_5_0.isSelf
		local var_5_2 = var_5_0.hpChange

		if var_5_1 then
			Activity188Model.instance:checkHpZero(var_5_2)
		end
	end

	local var_5_3 = var_0_0.StepClzMap[var_5_0.stepType]

	if var_5_3 then
		local var_5_4

		arg_5_0._stepPool = arg_5_0._stepPool or {}

		if arg_5_0._stepPool[var_5_3] ~= nil and #arg_5_0._stepPool[var_5_3] >= 1 then
			local var_5_5 = #arg_5_0._stepPool[var_5_3]

			var_5_4 = arg_5_0._stepPool[var_5_3][var_5_5]
			arg_5_0._stepPool[var_5_3][var_5_5] = nil
		else
			var_5_4 = var_5_3.New()
		end

		var_5_4:init(var_5_0)

		return var_5_4
	end
end

function var_0_0.buildStepClient(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.StepClzMap[arg_6_1.stepType]

	if var_6_0 then
		local var_6_1

		arg_6_0._stepPool = arg_6_0._stepPool or {}

		if arg_6_0._stepPool[var_6_0] ~= nil and #arg_6_0._stepPool[var_6_0] >= 1 then
			local var_6_2 = #arg_6_0._stepPool[var_6_0]

			var_6_1 = arg_6_0._stepPool[var_6_0][var_6_2]
			arg_6_0._stepPool[var_6_0][var_6_2] = nil
		else
			var_6_1 = var_6_0.New()
		end

		var_6_1:init(arg_6_1)

		return var_6_1
	end
end

function var_0_0.nextStep(arg_7_0)
	arg_7_0:recycleCurStep()

	arg_7_0._doingStepAction = arg_7_0._stepList and #arg_7_0._stepList > 0

	if not arg_7_0._doingStepAction then
		Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	end

	if not arg_7_0._isStepStarting then
		arg_7_0._isStepStarting = true

		while arg_7_0._curStep == nil and arg_7_0._stepList and #arg_7_0._stepList > 0 do
			arg_7_0._curStep = arg_7_0._stepList[1]

			table.remove(arg_7_0._stepList, 1)
			arg_7_0._curStep:start()
		end

		arg_7_0._isStepStarting = false
	end
end

function var_0_0.recycleCurStep(arg_8_0)
	if arg_8_0._curStep then
		arg_8_0._curStep:dispose()

		arg_8_0._stepPool[arg_8_0._curStep.class] = arg_8_0._stepPool[arg_8_0._curStep.class] or {}

		table.insert(arg_8_0._stepPool[arg_8_0._curStep.class], arg_8_0._curStep)

		arg_8_0._curStep = nil
	end
end

function var_0_0.disposeAllStep(arg_9_0)
	if arg_9_0._curStep then
		arg_9_0._curStep:dispose()

		arg_9_0._curStep = nil
	end

	if arg_9_0._stepList then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._stepList) do
			iter_9_1:dispose()
		end

		arg_9_0._stepList = nil
	end

	arg_9_0._stepPool = nil
	arg_9_0._isStepStarting = false
end

function var_0_0.clear(arg_10_0)
	arg_10_0._stepList = nil
	arg_10_0._curStep = nil

	arg_10_0:disposeAllStep()
end

var_0_0.instance = var_0_0.New()

return var_0_0

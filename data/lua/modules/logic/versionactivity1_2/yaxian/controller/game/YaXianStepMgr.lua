module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianStepMgr", package.seeall)

local var_0_0 = class("YaXianStepMgr")

var_0_0.StepClzMap = {
	[YaXianGameEnum.GameStepType.GameFinish] = YaXianStepGameFinish,
	[YaXianGameEnum.GameStepType.Move] = YaXianStepMove,
	[YaXianGameEnum.GameStepType.NextRound] = YaXianStepNextRound,
	[YaXianGameEnum.GameStepType.CallEvent] = YaXianStepCallEvent,
	[YaXianGameEnum.GameStepType.CreateObject] = YaXianStepCreateObject,
	[YaXianGameEnum.GameStepType.DeleteObject] = YaXianStepDeleteObject,
	[YaXianGameEnum.GameStepType.PickUp] = YaXianStepPickUpItem,
	[YaXianGameEnum.GameStepType.InteractFinish] = YaXianStepInteractFinish,
	[YaXianGameEnum.GameStepType.UpdateObjectData] = YaXianStepUpdateObjectData
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._stepList = nil
	arg_1_0._stepPool = nil
	arg_1_0._curStep = nil
end

function var_0_0.insertStepList(arg_2_0, arg_2_1)
	arg_2_0:beforeBuildStep(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.stepDataList) do
		arg_2_0:insertStep(iter_2_1, iter_2_0)
	end
end

function var_0_0.beforeBuildStep(arg_3_0, arg_3_1)
	arg_3_0.stepDataList = {}

	local var_3_0
	local var_3_1

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_2 = cjson.decode(iter_3_1.param)

		if var_3_2.stepType ~= YaXianGameEnum.GameStepType.Move then
			if var_3_1 then
				table.insert(arg_3_0.stepDataList, var_3_1)

				var_3_1 = nil
			end

			table.insert(arg_3_0.stepDataList, var_3_2)
		else
			if var_3_1 and var_3_1.id ~= var_3_2.id then
				table.insert(arg_3_0.stepDataList, var_3_1)
			end

			var_3_1 = var_3_2
		end
	end

	local var_3_3 = {}
	local var_3_4 = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.stepDataList) do
		if iter_3_3.stepType == YaXianGameEnum.GameStepType.DeleteObject and iter_3_3.reason == YaXianGameEnum.DeleteInteractReason.AssassinateKill then
			table.insert(var_3_3, iter_3_2)
		end

		if iter_3_3.stepType == YaXianGameEnum.GameStepType.Move then
			table.insert(var_3_4, iter_3_2)
		end
	end

	for iter_3_4, iter_3_5 in ipairs(var_3_3) do
		local var_3_5

		for iter_3_6 = #var_3_4, 1, -1 do
			if iter_3_5 > var_3_4[iter_3_6] then
				var_3_5 = var_3_4[iter_3_6]

				break
			end
		end

		local var_3_6 = arg_3_0:getStepData(var_3_5)

		if var_3_6 then
			var_3_6.assassinateSourceStep = true
			var_3_6.deleteStepIndex = iter_3_5
		else
			logError("not found step data, index : " .. iter_3_5)
		end
	end
end

function var_0_0.getStepData(arg_4_0, arg_4_1)
	return arg_4_0.stepDataList and arg_4_0.stepDataList[arg_4_1]
end

function var_0_0.insertStep(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:buildStep(arg_5_1, arg_5_2)

	if var_5_0 then
		arg_5_0._stepList = arg_5_0._stepList or {}

		table.insert(arg_5_0._stepList, var_5_0)
	end

	if arg_5_0._curStep == nil then
		arg_5_0:nextStep()
	end
end

function var_0_0.buildStep(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1 = arg_6_0._stepPool and arg_6_0._stepPool[arg_6_1.stepType]

	if var_6_1 and #var_6_1 > 0 then
		var_6_0 = var_6_1[#var_6_1]
		var_6_1[#var_6_1] = nil
	else
		var_6_0 = var_0_0.StepClzMap[arg_6_1.stepType].New()
	end

	var_6_0:init(arg_6_1, arg_6_2)

	return var_6_0
end

function var_0_0.nextStep(arg_7_0)
	if arg_7_0._curStep then
		arg_7_0:putPool(arg_7_0._curStep)

		arg_7_0._curStep = nil
	end

	if arg_7_0._stepList and #arg_7_0._stepList > 0 then
		arg_7_0._curStep = arg_7_0._stepList[1]

		table.remove(arg_7_0._stepList, 1)
		arg_7_0._curStep:start()
	end
end

function var_0_0.putPool(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	arg_8_1:dispose()

	arg_8_0._stepPool = arg_8_0._stepPool or {}

	local var_8_0 = arg_8_0._stepPool[arg_8_1.stepType] or {}

	table.insert(var_8_0, arg_8_1)

	arg_8_0._stepPool[arg_8_1.stepType] = var_8_0
end

function var_0_0.disposeAllStep(arg_9_0)
	if arg_9_0._curStep then
		arg_9_0:putPool(arg_9_0._curStep)

		arg_9_0._curStep = nil
	end

	if arg_9_0._stepList then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._stepList) do
			arg_9_0:putPool(iter_9_1)
		end

		arg_9_0._stepList = nil
	end
end

function var_0_0.removeAll(arg_10_0)
	arg_10_0:disposeAllStep()
end

function var_0_0.dispose(arg_11_0)
	arg_11_0._stepPool = nil
end

function var_0_0.log(arg_12_0, arg_12_1)
	logError(string.format("data : %s, index : %s", cjson.encode(arg_12_1.originData), arg_12_1.index))
end

return var_0_0

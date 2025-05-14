module("modules.logic.versionactivity1_8.dungeon.model.Activity157PipeGridMo", package.seeall)

local var_0_0 = pureTable("Activity157PipeGridMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.x = arg_1_1
	arg_1_0.y = arg_1_2
	arg_1_0.typeId = 0
	arg_1_0.value = 0
	arg_1_0.pathIndex = 0
	arg_1_0.pathType = 0
	arg_1_0.numIndex = 0
	arg_1_0.connectSet = {}
	arg_1_0.entryConnect = {}
	arg_1_0.entryCount = 0
	arg_1_0.connectPathIndex = 0
end

local var_0_1 = {}

function var_0_0.getConnectValue(arg_2_0)
	local var_2_0 = 0
	local var_2_1 = 0

	if arg_2_0.entryConnect then
		for iter_2_0, iter_2_1 in pairs(arg_2_0.entryConnect) do
			table.insert(var_0_1, iter_2_0)

			var_2_0 = var_2_0 + 1
		end

		table.sort(var_0_1)

		for iter_2_2, iter_2_3 in ipairs(var_0_1) do
			var_2_1 = var_2_1 * 10 + iter_2_3
		end

		for iter_2_4 = 1, var_2_0 do
			var_0_1[iter_2_4] = nil
		end
	end

	return var_2_1
end

function var_0_0.getBackgroundRes(arg_3_0)
	return ArmPuzzleHelper.getBackgroundRes(arg_3_0.typeId, Activity157Enum.res)
end

function var_0_0.getConnectRes(arg_4_0)
	return ArmPuzzleHelper.getConnectRes(arg_4_0.typeId, Activity157Enum.res)
end

function var_0_0.getRotation(arg_5_0)
	return ArmPuzzleHelper.getRotation(arg_5_0.typeId, arg_5_0.value)
end

function var_0_0.cleanEntrySet(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.entryConnect) do
		arg_6_0.entryConnect[iter_6_0] = nil
	end

	arg_6_0.entryCount = 0
	arg_6_0.connectPathIndex = 0
end

function var_0_0.getEntryCount(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.isEntry(arg_8_0)
	return ArmPuzzlePipeEnum.entry[arg_8_0.typeId]
end

function var_0_0.setParamStr(arg_9_0, arg_9_1)
	local var_9_0 = string.splitToNumber(arg_9_1, "#") or {}

	arg_9_0.typeId = var_9_0[1] or 0
	arg_9_0.value = var_9_0[2] or 0
	arg_9_0.pathIndex = var_9_0[3] or 0
	arg_9_0.pathType = var_9_0[4] or 0
	arg_9_0.numIndex = var_9_0[5] or 0
end

function var_0_0.getParamStr(arg_10_0)
	return string.format("%s#%s#%s#%s#%s", arg_10_0.typeId, arg_10_0.value, arg_10_0.pathIndex, arg_10_0.pathType, arg_10_0.numIndex)
end

return var_0_0

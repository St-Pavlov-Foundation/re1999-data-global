module("modules.logic.versionactivity1_4.act131.model.Activity131ElementMo", package.seeall)

local var_0_0 = pureTable("Activity131ElementMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.elementId = 0
	arg_1_0.isFinish = false
	arg_1_0.index = 0
	arg_1_0.historylist = {}
	arg_1_0.visible = false
	arg_1_0.config = {}
	arg_1_0.typeList = {}
	arg_1_0.paramList = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.elementId = arg_2_1.elementId
	arg_2_0.isFinish = arg_2_1.isFinish
	arg_2_0.index = arg_2_1.index
	arg_2_0.historylist = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.historylist) do
		table.insert(arg_2_0.historylist, iter_2_1)
	end

	arg_2_0.visible = arg_2_1.visible

	local var_2_0 = VersionActivity1_4Enum.ActivityId.Role6

	arg_2_0.config = Activity131Config.instance:getActivity131ElementCo(var_2_0, arg_2_0.elementId)

	if not arg_2_0.config then
		logError(string.format("Activity131ElementMo no config id:%s", arg_2_0.elementId))

		return
	end

	arg_2_0.typeList = string.splitToNumber(arg_2_0.config.type, "#")
	arg_2_0.paramList = string.split(arg_2_0.config.param, "#")
end

function var_0_0.isAvailable(arg_3_0)
	return not arg_3_0.isFinish and arg_3_0.visible
end

function var_0_0.updateHistoryList(arg_4_0, arg_4_1)
	arg_4_0.historylist = arg_4_1
end

function var_0_0.getType(arg_5_0)
	return arg_5_0.typeList[arg_5_0.index + 1]
end

function var_0_0.getNextType(arg_6_0)
	return arg_6_0.typeList[arg_6_0.index + 2]
end

function var_0_0.getParam(arg_7_0)
	return arg_7_0.paramList[arg_7_0.index + 1]
end

function var_0_0.getPrevParam(arg_8_0)
	return arg_8_0.paramList[arg_8_0.index]
end

return var_0_0

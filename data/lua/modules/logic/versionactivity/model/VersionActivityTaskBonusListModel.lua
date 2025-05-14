module("modules.logic.versionactivity.model.VersionActivityTaskBonusListModel", package.seeall)

local var_0_0 = class("VersionActivityTaskBonusListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.taskActivityMo = nil
end

function var_0_0.initTaskBonusList(arg_3_0)
	return
end

function var_0_0.refreshList(arg_4_0)
	arg_4_0:setList(TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.ActivityDungeon))
end

function var_0_0.getTaskActivityMo(arg_5_0)
	if not arg_5_0.taskActivityMo then
		arg_5_0.taskActivityMo = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon)
	end

	return arg_5_0.taskActivityMo
end

function var_0_0.recordPrefixActivityPointCount(arg_6_0)
	arg_6_0.prefixActivityPointCount = arg_6_0:getTaskActivityMo().value
end

function var_0_0.checkActivityPointCountHasChange(arg_7_0)
	return arg_7_0.prefixActivityPointCount ~= arg_7_0:getTaskActivityMo().value
end

function var_0_0.checkNeedPlayEffect(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = TaskConfig.instance:getTaskBonusValue(TaskEnum.TaskType.ActivityDungeon, arg_8_1, arg_8_2)

	return var_8_0 > arg_8_0.prefixActivityPointCount and var_8_0 <= arg_8_0:getTaskActivityMo().value
end

var_0_0.instance = var_0_0.New()

return var_0_0

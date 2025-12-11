module("modules.logic.versionactivity3_1.towerdeep.model.TowerDeepOperActModel", package.seeall)

local var_0_0 = class("TowerDeepOperActModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._maxLayer = 0
end

function var_0_0.setMaxLayer(arg_3_0, arg_3_1)
	arg_3_0._maxLayer = arg_3_1
end

function var_0_0.getMaxLayer(arg_4_0)
	return arg_4_0._maxLayer
end

function var_0_0.isTaskFinished(arg_5_0, arg_5_1)
	local var_5_0 = TaskModel.instance:getTaskById(arg_5_1)

	return var_5_0 and var_5_0.finishCount > 0
end

function var_0_0.getNextTaskId(arg_6_0, arg_6_1)
	local var_6_0 = TowerDeepOperActConfig.instance:getTaskCos()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if not LuaUtil.isEmptyStr(iter_6_1.prepose) and arg_6_1 == tonumber(iter_6_1.prepose) then
			return iter_6_1.id
		end
	end

	return 0
end

var_0_0.instance = var_0_0.New()

return var_0_0

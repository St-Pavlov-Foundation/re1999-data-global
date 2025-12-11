module("modules.logic.survival.model.shelter.SurvivalMapInfoMo", package.seeall)

local var_0_0 = pureTable("SurvivalMapInfoMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.rainId = arg_1_1.rainId
	arg_1_0.disasterId = arg_1_1.disasterId
	arg_1_0.taskId = arg_1_1.taskId

	if arg_1_0.taskId > 0 then
		arg_1_0.taskCo = SurvivalConfig.instance:getTaskCo(SurvivalEnum.TaskModule.MapMainTarget, arg_1_0.taskId)
	end

	arg_1_0.disasterCo = lua_survival_disaster.configDict[arg_1_0.disasterId]
	arg_1_0.rainCo = lua_survival_rain.configDict[arg_1_0.rainId]

	local var_1_0 = lua_survival_map_group_mapping.configDict[arg_1_0.mapId]

	arg_1_0.groupId = var_1_0 and var_1_0.id or 0
	arg_1_0.groupCo = lua_survival_map_group.configDict[arg_1_0.groupId]
	arg_1_0.mapType = arg_1_0.groupCo and arg_1_0.groupCo.type or 0

	local var_1_1 = arg_1_0.groupCo and arg_1_0.groupCo.hardLevel or 1

	if var_1_1 <= 2 then
		arg_1_0.level = 1
	elseif var_1_1 <= 4 then
		arg_1_0.level = 2
	else
		arg_1_0.level = 3
	end
end

return var_0_0

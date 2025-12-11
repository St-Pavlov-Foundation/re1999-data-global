module("modules.logic.survival.model.shelter.SurvivalIntrudeSchemeMo", package.seeall)

local var_0_0 = pureTable("SurvivalIntrudeSchemeMo")

function var_0_0.setData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.survivalIntrudeScheme = arg_1_1
	arg_1_0.point = arg_1_2
	arg_1_0.intrudeSchemeCfg = lua_survival_shelter_intrude_scheme.configDict[arg_1_0.survivalIntrudeScheme.id]
end

function var_0_0.getDisplayIcon(arg_2_0)
	local var_2_0 = arg_2_0.intrudeSchemeCfg.icon

	if arg_2_0.survivalIntrudeScheme.repress then
		var_2_0 = "survival_new_bossbuff1_0"
	end

	return var_2_0
end

return var_0_0

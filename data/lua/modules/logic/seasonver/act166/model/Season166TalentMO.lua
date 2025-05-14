module("modules.logic.seasonver.act166.model.Season166TalentMO", package.seeall)

local var_0_0 = pureTable("Season166TalentMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.level = 1
	arg_1_0.skillIds = {}
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.level = arg_2_1.level

	arg_2_0:updateSkillIds(arg_2_1.skillIds)

	arg_2_0.config = lua_activity166_talent_style.configDict[arg_2_1.id][arg_2_1.level]
end

function var_0_0.updateSkillIds(arg_3_0, arg_3_1)
	tabletool.clear(arg_3_0.skillIds)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.skillIds[iter_3_0] = iter_3_1
	end
end

return var_0_0

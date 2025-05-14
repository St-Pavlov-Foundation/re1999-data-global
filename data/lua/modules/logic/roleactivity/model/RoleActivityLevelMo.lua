module("modules.logic.roleactivity.model.RoleActivityLevelMo", package.seeall)

local var_0_0 = pureTable("RoleActivityLevelMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.config = arg_1_1
	arg_1_0.isUnlock = DungeonModel.instance:isUnlock(arg_1_1)

	local var_1_0 = DungeonModel.instance:getEpisodeInfo(arg_1_1.id)

	arg_1_0.star = var_1_0 and var_1_0.star or 0
end

function var_0_0.update(arg_2_0)
	arg_2_0.isUnlock = DungeonModel.instance:isUnlock(arg_2_0.config)

	local var_2_0 = DungeonModel.instance:getEpisodeInfo(arg_2_0.config.id)

	arg_2_0.star = var_2_0 and var_2_0.star or 0
end

return var_0_0

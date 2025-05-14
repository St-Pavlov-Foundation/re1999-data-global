module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DispatchHeroMo", package.seeall)

local var_0_0 = pureTable("VersionActivity1_5DispatchVersionActivity1_5DispatchHeroMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.heroId = 0
	arg_1_0.config = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.config = arg_2_1.config
	arg_2_0.level = arg_2_1.level
	arg_2_0.rare = arg_2_0.config.rare
end

function var_0_0.isDispatched(arg_3_0)
	return VersionActivity1_5DungeonModel.instance:isDispatched(arg_3_0.heroId)
end

return var_0_0

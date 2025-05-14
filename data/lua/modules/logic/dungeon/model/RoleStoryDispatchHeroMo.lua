module("modules.logic.dungeon.model.RoleStoryDispatchHeroMo", package.seeall)

local var_0_0 = pureTable("RoleStoryDispatchHeroMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.heroId = 0
	arg_1_0.config = nil
	arg_1_0.storyId = 0
	arg_1_0.isEffect = false
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_1.id
	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.config = arg_2_1.config
	arg_2_0.level = arg_2_1.level
	arg_2_0.rare = arg_2_0.config.rare
	arg_2_0.storyId = arg_2_2
	arg_2_0.isEffect = arg_2_3
end

function var_0_0.isDispatched(arg_3_0)
	return RoleStoryModel.instance:isHeroDispatching(arg_3_0.heroId, arg_3_0.storyId)
end

function var_0_0.isEffectHero(arg_4_0)
	return arg_4_0.isEffect
end

return var_0_0

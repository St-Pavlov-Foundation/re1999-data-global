module("modules.logic.fight.entity.FightEntityPlayer", package.seeall)

local var_0_0 = class("FightEntityPlayer", BaseFightEntity)

function var_0_0.getTag(arg_1_0)
	return SceneTag.UnitPlayer
end

function var_0_0.initComponents(arg_2_0)
	var_0_0.super.initComponents(arg_2_0)
	arg_2_0:addComp("readyAttack", FightPlayerReadyAttackComp)
	arg_2_0:addComp("variantCrayon", FightVariantCrayonComp)
	arg_2_0:addComp("entityVisible", FightEntityVisibleComp)
	arg_2_0:addComp("nameUIVisible", FightNameUIVisibleComp)
	arg_2_0:addComp("variantHeart", FightVariantHeartComp)
	arg_2_0:addComp("heroCustomComp", FightHeroCustomComp)
end

return var_0_0

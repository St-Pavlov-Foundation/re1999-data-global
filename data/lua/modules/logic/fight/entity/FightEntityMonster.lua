module("modules.logic.fight.entity.FightEntityMonster", package.seeall)

local var_0_0 = class("FightEntityMonster", BaseFightEntity)

function var_0_0.getTag(arg_1_0)
	return SceneTag.UnitMonster
end

function var_0_0.initComponents(arg_2_0)
	var_0_0.super.initComponents(arg_2_0)
	arg_2_0:addComp("variantHeart", FightVariantHeartComp)
	arg_2_0:addComp("entityVisible", FightEntityVisibleComp)
	arg_2_0:addComp("nameUIVisible", FightNameUIVisibleComp)
end

return var_0_0

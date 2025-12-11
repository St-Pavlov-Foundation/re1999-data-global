module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_HideCard", package.seeall)

local var_0_0 = class("FightBuffBehaviour_HideCard", FightBuffBehaviourBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = FightStrUtil.instance:getSplitCache(arg_1_0.co.param, "#")

	arg_1_0.smallSkillIcon = var_1_0[1]
	arg_1_0.bigSkillIcon = var_1_0[2]
end

function var_0_0.onAddBuff(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	FightModel.instance:setSkillIcon(arg_2_0.smallSkillIcon, arg_2_0.bigSkillIcon)
	FightModel.instance:setIsHideCard(true)
	FightController.instance:dispatchEvent(FightEvent.OnAddHideCardBuff)
	AudioMgr.instance:trigger(310005)
end

function var_0_0.onRemoveBuff(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	FightModel.instance:setSkillIcon(nil, nil)
	FightModel.instance:setIsHideCard(false)
	FightController.instance:dispatchEvent(FightEvent.OnRemoveHideCardBuff)
end

return var_0_0

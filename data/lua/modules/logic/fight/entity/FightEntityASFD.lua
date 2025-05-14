module("modules.logic.fight.entity.FightEntityASFD", package.seeall)

local var_0_0 = class("FightEntityASFD", BaseFightEntity)

function var_0_0.getTag(arg_1_0)
	return SceneTag.UnitNpc
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)
	FightRenderOrderMgr.instance:unregister(arg_2_0.id)
end

function var_0_0.initComponents(arg_3_0)
	arg_3_0:addComp("effect", FightEffectComp)
end

return var_0_0

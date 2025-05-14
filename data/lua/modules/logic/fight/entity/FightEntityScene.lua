module("modules.logic.fight.entity.FightEntityScene", package.seeall)

local var_0_0 = class("FightEntityScene", BaseFightEntity)

var_0_0.MySideId = "0"
var_0_0.EnemySideId = "-99999"

function var_0_0.getTag(arg_1_0)
	return SceneTag.UnitNpc
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)
	FightRenderOrderMgr.instance:unregister(arg_2_0.id)
end

function var_0_0.initComponents(arg_3_0)
	arg_3_0:addComp("skill", FightSkillComp)
	arg_3_0:addComp("effect", FightEffectComp)
	arg_3_0:addComp("buff", FightBuffComp)
end

function var_0_0.getSide(arg_4_0)
	if arg_4_0.id == var_0_0.MySideId then
		return FightEnum.EntitySide.MySide
	elseif arg_4_0.id == var_0_0.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	else
		return FightEnum.EntitySide.BothSide
	end
end

return var_0_0

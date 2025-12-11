module("modules.logic.fight.entity.FightEntityBuffObject", package.seeall)

local var_0_0 = class("FightEntityBuffObject", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.buffData = arg_1_1
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.entityId = arg_1_1.entityId
	arg_1_0.buffId = arg_1_1.buffId
end

function var_0_0.onAddBuff(arg_2_0)
	arg_2_0:showAddEffect()

	if lua_fight_gao_si_niao_buffeffect_electric_level.configDict[arg_2_0.buffId] then
		arg_2_0:newClass(FightGaoSiNiaoBuffEffectWithElectricLevel, arg_2_0.buffData)
	end

	FightMsgMgr.sendMsg(FightMsgId.OnAddBuff, arg_2_0.buffData)
end

function var_0_0.showAddEffect(arg_3_0)
	return
end

function var_0_0.onRemoveBuff(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0.uid then
		return
	end

	arg_4_0:showRemoveEffect()
	FightMsgMgr.sendMsg(FightMsgId.OnRemoveBuff, arg_4_1)
end

function var_0_0.showRemoveEffect(arg_5_0)
	return
end

function var_0_0.onUpdateBuff(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0.uid then
		return
	end

	FightMsgMgr.sendMsg(FightMsgId.OnUpdateBuff, arg_6_0.buffData)
end

function var_0_0.onDestructor(arg_7_0)
	return
end

return var_0_0

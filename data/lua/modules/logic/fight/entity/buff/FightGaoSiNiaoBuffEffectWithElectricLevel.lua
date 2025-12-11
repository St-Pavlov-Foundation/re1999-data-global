module("modules.logic.fight.entity.buff.FightGaoSiNiaoBuffEffectWithElectricLevel", package.seeall)

local var_0_0 = class("FightGaoSiNiaoBuffEffectWithElectricLevel", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.buffData = arg_1_1
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.entityId = arg_1_1.entityId
	arg_1_0.buffId = arg_1_1.buffId
	arg_1_0.entityData = FightDataHelper.entityMgr:getById(arg_1_0.entityId)
	arg_1_0.entity = FightHelper.getEntity(arg_1_0.entityId)
	arg_1_0.bigSkillCounter = 0

	arg_1_0:com_registMsg(FightMsgId.OnUpdateBuff, arg_1_0.refreshEffect)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_1_0.onSkillPlayStart)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_1_0.onSkillPlayFinish)
	arg_1_0:com_registFightEvent(FightEvent.UpdateMagicCircile, arg_1_0.onUpdateMagicCircile)
	arg_1_0:com_registFightEvent(FightEvent.DeleteMagicCircile, arg_1_0.onDeleteMagicCircile)
	arg_1_0:com_registFightEvent(FightEvent.AddMagicCircile, arg_1_0.onAddMagicCircile)
	arg_1_0:com_registFightEvent(FightEvent.UpgradeMagicCircile, arg_1_0.onUpgradeMagicCircile)
end

function var_0_0.onLogicEnter(arg_2_0)
	arg_2_0:refreshEffect(arg_2_0.uid)
end

function var_0_0.onUpdateMagicCircile(arg_3_0)
	arg_3_0:refreshEffect(arg_3_0.uid)
end

function var_0_0.onUpgradeMagicCircile(arg_4_0)
	arg_4_0:refreshEffect(arg_4_0.uid)
end

function var_0_0.onDeleteMagicCircile(arg_5_0)
	arg_5_0:refreshEffect(arg_5_0.uid)
end

function var_0_0.onAddMagicCircile(arg_6_0)
	arg_6_0:refreshEffect(arg_6_0.uid)
end

function var_0_0.refreshEffect(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0.uid then
		return
	end

	if arg_7_0.effectWrap then
		arg_7_0.entity.effect:removeEffect(arg_7_0.effectWrap)
		arg_7_0.entity.buff:removeLoopBuff(arg_7_0.effectWrap)

		arg_7_0.effectWrap = nil
	end

	local var_7_0 = lua_fight_gao_si_niao_buffeffect_electric_level.configDict[arg_7_0.buffId]

	if not var_7_0 then
		return
	end

	var_7_0 = var_7_0[arg_7_0.entityData.skin] or var_7_0[0]

	if not var_7_0 then
		return
	end

	local var_7_1 = FightModel.instance:getMagicCircleInfo()

	var_7_0 = var_7_1 and var_7_0[var_7_1.electricLevel] or var_7_0[1]

	if not var_7_0 then
		return
	end

	arg_7_0.effectWrap = arg_7_0.entity.effect:addHangEffect(var_7_0.effect, var_7_0.effectHangPoint)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_7_0.entityId, arg_7_0.effectWrap)
	arg_7_0.effectWrap:setLocalPos(0, 0, 0)
	arg_7_0.entity.buff:addLoopBuff(arg_7_0.effectWrap)

	local var_7_2 = var_7_0.audio

	if var_7_2 and var_7_2 ~= 0 then
		AudioMgr.instance:trigger(var_7_2)
	end
end

function var_0_0.onSkillPlayStart(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1:getMO()

	if var_8_0 and var_8_0.id == arg_8_0.entityId and FightCardDataHelper.isBigSkill(arg_8_2) then
		arg_8_0.bigSkillCounter = arg_8_0.bigSkillCounter + 1

		arg_8_0.effectWrap:setActive(arg_8_0.bigSkillCounter <= 0, "FightGaoSiNiaoBuffEffectWithElectricLevel")
	end
end

function var_0_0.onSkillPlayFinish(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1:getMO()

	if var_9_0 and var_9_0.id == arg_9_0.entityId and FightCardDataHelper.isBigSkill(arg_9_2) then
		arg_9_0.bigSkillCounter = arg_9_0.bigSkillCounter - 1

		arg_9_0.effectWrap:setActive(arg_9_0.bigSkillCounter <= 0, "FightGaoSiNiaoBuffEffectWithElectricLevel")
	end
end

function var_0_0.onDestructor(arg_10_0)
	if arg_10_0.effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_10_0.entityId, arg_10_0.effectWrap)
		arg_10_0.entity.effect:removeEffect(arg_10_0.effectWrap)
		arg_10_0.entity.buff:removeLoopBuff(arg_10_0.effectWrap)

		arg_10_0.effectWrap = nil
	end
end

return var_0_0

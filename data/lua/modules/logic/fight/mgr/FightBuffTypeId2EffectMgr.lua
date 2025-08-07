module("modules.logic.fight.mgr.FightBuffTypeId2EffectMgr", package.seeall)

local var_0_0 = class("FightBuffTypeId2EffectMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.effectDic = {}
	arg_1_0.refCounter = {}
	arg_1_0.posDic = {}

	arg_1_0:com_registFightEvent(FightEvent.AddEntityBuff, arg_1_0._onAddEntityBuff)
	arg_1_0:com_registFightEvent(FightEvent.RemoveEntityBuff, arg_1_0._onRemoveEntityBuff)
	arg_1_0:com_registFightEvent(FightEvent.OnFightReconnectLastWork, arg_1_0._onFightReconnectLastWork)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish)
	arg_1_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_1_0._onOnRoundSequenceFinish)
	arg_1_0:com_registFightEvent(FightEvent.SetBuffTypeIdSceneEffect, arg_1_0._onSetBuffTypeIdSceneEffect)
end

function var_0_0._isValid(arg_2_0, arg_2_1)
	local var_2_0 = lua_skill_buff.configDict[arg_2_1]

	if not var_2_0 then
		return
	end

	local var_2_1 = var_2_0.typeId

	if not lua_fight_buff_type_id_2_scene_effect.configDict[var_2_1] then
		return
	end

	return true, var_2_0
end

function var_0_0._onAddEntityBuff(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0, var_3_1 = arg_3_0:_isValid(arg_3_2.buffId)

	if not var_3_0 then
		return
	end

	arg_3_0:addBuff(arg_3_1, var_3_1.typeId)
end

function var_0_0._onRemoveEntityBuff(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = arg_4_0:_isValid(arg_4_2.buffId)

	if not var_4_0 then
		return
	end

	arg_4_0:deleteBuff(var_4_1.typeId)
end

function var_0_0.addBuff(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = (arg_5_0.refCounter[arg_5_2] or 0) + 1

	arg_5_0.refCounter[arg_5_2] = var_5_0

	if var_5_0 == 1 then
		arg_5_0:addEffect(arg_5_1, arg_5_2)
	end
end

function var_0_0.deleteBuff(arg_6_0, arg_6_1)
	local var_6_0 = (arg_6_0.refCounter[arg_6_1] or 0) - 1

	arg_6_0.refCounter[arg_6_1] = var_6_0

	if var_6_0 <= 0 then
		arg_6_0:releaseEffect(arg_6_1)
	end
end

function var_0_0.addEffect(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = FightHelper.getEntity(FightEntityScene.MySideId)

	if not var_7_0 then
		return
	end

	local var_7_1 = lua_fight_buff_type_id_2_scene_effect.configDict[arg_7_2]

	if not var_7_1 then
		return
	end

	local var_7_2 = var_7_1.effect
	local var_7_3 = var_7_1.pos
	local var_7_4 = var_7_3[1] or 0

	if var_7_1.reverseX == 1 then
		local var_7_5 = FightDataHelper.entityMgr:getById(arg_7_1)

		if var_7_5 and var_7_5:isEnemySide() then
			var_7_4 = -var_7_4
		end
	end

	local var_7_6 = var_7_3[2] or 0
	local var_7_7 = var_7_3[3] or 0
	local var_7_8 = var_7_0.effect:addGlobalEffect(var_7_2)

	var_7_8:setLocalPos(var_7_4, var_7_6, var_7_7)

	arg_7_0.posDic[arg_7_2] = {
		var_7_4,
		var_7_6,
		var_7_7
	}
	arg_7_0.effectDic[arg_7_2] = var_7_8
end

function var_0_0.releaseEffect(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.effectDic[arg_8_1]

	if not var_8_0 then
		return
	end

	local var_8_1 = FightHelper.getEntity(FightEntityScene.MySideId)

	if not var_8_1 then
		return
	end

	var_8_1.effect:removeEffect(var_8_0)

	arg_8_0.effectDic[arg_8_1] = nil
end

function var_0_0._onFightReconnectLastWork(arg_9_0)
	local var_9_0 = FightDataHelper.entityMgr:getAllEntityData()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		local var_9_1 = iter_9_1:getBuffDic()

		for iter_9_2, iter_9_3 in pairs(var_9_1) do
			arg_9_0:_onAddEntityBuff(iter_9_0, iter_9_3)
		end
	end
end

function var_0_0._onSkillPlayStart(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1:getMO() and FightCardDataHelper.isBigSkill(arg_10_2) then
		arg_10_0:_hideEffect()
	end
end

function var_0_0._onSkillPlayFinish(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1:getMO() and FightCardDataHelper.isBigSkill(arg_11_2) then
		arg_11_0:_showEffect()
	end
end

function var_0_0._onSetBuffTypeIdSceneEffect(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.effectDic) do
		local var_12_0 = arg_12_0.posDic[iter_12_0]
		local var_12_1 = arg_12_1 and var_12_0[1] or 9999
		local var_12_2 = arg_12_1 and var_12_0[2] or 9999
		local var_12_3 = arg_12_1 and var_12_0[3] or 9999

		iter_12_1:setLocalPos(var_12_1, var_12_2, var_12_3)
	end
end

function var_0_0._hideEffect(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.effectDic) do
		iter_13_1:setActive(false, "FightBuffTypeId2EffectMgr")
	end
end

function var_0_0._showEffect(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.effectDic) do
		iter_14_1:setActive(true, "FightBuffTypeId2EffectMgr")
	end
end

function var_0_0._onOnRoundSequenceFinish(arg_15_0)
	if tabletool.len(arg_15_0.refCounter) <= 0 then
		return
	end

	local var_15_0 = {}
	local var_15_1 = FightDataHelper.entityMgr:getAllEntityData()

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		local var_15_2 = iter_15_1:getBuffDic()

		for iter_15_2, iter_15_3 in pairs(var_15_2) do
			local var_15_3 = lua_skill_buff.configDict[iter_15_3.buffId]

			if var_15_3 and lua_fight_buff_type_id_2_scene_effect.configDict[var_15_3.typeId] then
				local var_15_4 = (var_15_0[var_15_3.typeId] or 0) + 1

				var_15_0[var_15_3.typeId] = var_15_4
			end
		end
	end

	if FightDataUtil.findDiff(arg_15_0.refCounter, var_15_0) then
		arg_15_0:releaseAllEffect()

		arg_15_0.refCounter = {}

		arg_15_0:_onFightReconnectLastWork()
	end
end

function var_0_0.releaseAllEffect(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.effectDic) do
		arg_16_0:releaseEffect(iter_16_0)
	end
end

function var_0_0.onDestructor(arg_17_0)
	return
end

return var_0_0

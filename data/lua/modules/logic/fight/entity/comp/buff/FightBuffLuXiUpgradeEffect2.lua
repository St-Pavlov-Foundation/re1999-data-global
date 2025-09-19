module("modules.logic.fight.entity.comp.buff.FightBuffLuXiUpgradeEffect2", package.seeall)

local var_0_0 = class("FightBuffLuXiUpgradeEffect2", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.entity = arg_1_1
	arg_1_0.entityData = arg_1_2
	arg_1_0.entityId = arg_1_2.id
	arg_1_0.configDict = arg_1_3
	arg_1_0.buffDic = {}
	arg_1_0.count = 0
	arg_1_0.effectNameList = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.configDict) do
		local var_1_0 = iter_1_1.effect

		arg_1_0.effectNameList = string.split(var_1_0, "#")

		break
	end

	arg_1_0:com_registFightEvent(FightEvent.AddEntityBuff, arg_1_0.onAddEntityBuff)
	arg_1_0:com_registFightEvent(FightEvent.RemoveEntityBuff, arg_1_0.onRemoveEntityBuff)
	arg_1_0:com_registFightEvent(FightEvent.SetBuffEffectVisible, arg_1_0.onSetBuffEffectVisible)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, LuaEventSystem.High)
end

function var_0_0.onAddEntityBuff(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= arg_2_0.entityId then
		return
	end

	local var_2_0 = arg_2_2.buffId
	local var_2_1 = arg_2_0.configDict[var_2_0]

	if not var_2_1 then
		return
	end

	arg_2_0.count = arg_2_0.count + 1 + var_2_1.countOffset

	arg_2_0:releaseAllEffect()

	local var_2_2 = arg_2_0.effectNameList[arg_2_0.count]
	local var_2_3 = var_2_1.effectHangPoint
	local var_2_4 = arg_2_0.entity.effect:addHangEffect(var_2_2, var_2_3)

	var_2_4:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_2_0.entity.id, var_2_4)

	arg_2_0.buffDic[var_2_0] = var_2_4

	local var_2_5 = var_2_1.audio

	if var_2_5 ~= 0 then
		AudioMgr.instance:trigger(var_2_5)
	end
end

function var_0_0.onRemoveEntityBuff(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= arg_3_0.entityId then
		return
	end

	local var_3_0 = arg_3_2.buffId
	local var_3_1 = arg_3_0.configDict[var_3_0]

	if not var_3_1 then
		return
	end

	arg_3_0.count = arg_3_0.count - 1 - var_3_1.countOffset

	arg_3_0:releaseEffect(var_3_0)
end

function var_0_0.onSetBuffEffectVisible(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 ~= arg_4_0.entityId then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.buffDic) do
		iter_4_1:setActive(arg_4_2, arg_4_3 or "FightBuffLuXiUpgradeEffect2")
	end
end

function var_0_0._onSkillPlayStart(arg_5_0, arg_5_1)
	arg_5_0:onSetBuffEffectVisible(arg_5_1.id, false, "FightBuffLuXiUpgradeEffect2_PlaySkill")
end

function var_0_0._onSkillPlayFinish(arg_6_0, arg_6_1)
	arg_6_0:onSetBuffEffectVisible(arg_6_1.id, true, "FightBuffLuXiUpgradeEffect2_PlaySkill")
end

function var_0_0.releaseEffect(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.buffDic[arg_7_1]

	if var_7_0 then
		arg_7_0.entity.effect:removeEffect(var_7_0)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_7_0.entityId, var_7_0)
	end

	arg_7_0.buffDic[arg_7_1] = nil
end

function var_0_0.releaseAllEffect(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.buffDic) do
		arg_8_0:releaseEffect(iter_8_0)
	end
end

function var_0_0.onDestructor(arg_9_0)
	arg_9_0:releaseAllEffect()
end

return var_0_0

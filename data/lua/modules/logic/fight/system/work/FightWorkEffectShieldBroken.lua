module("modules.logic.fight.system.work.FightWorkEffectShieldBroken", package.seeall)

local var_0_0 = class("FightWorkEffectShieldBroken", FightEffectBase)
local var_0_1 = "buff_rush_break"
local var_0_2 = {
	[51400021] = true,
	[514000111] = true
}

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_0 and var_1_0.skill then
		if arg_1_0:_isBossRushBossShieldBroken(var_1_0) then
			FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillEnd, arg_1_0, LuaEventSystem.Low)
			var_1_0.skill:playTimeline(var_0_1, arg_1_0.fightStepData)
			arg_1_0:com_registTimer(arg_1_0._delayDone, 10)
		else
			arg_1_0:onDone(true)
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._isBossRushBossShieldBroken(arg_2_0, arg_2_1)
	if not BossRushController.instance:isInBossRushFight() then
		return false
	end

	if not arg_2_1:isEnemySide() then
		return false
	end

	local var_2_0 = FightModel.instance:getCurMonsterGroupId()
	local var_2_1 = var_2_0 and lua_monster_group.configDict[var_2_0]
	local var_2_2 = var_2_1 and var_2_1.bossId

	if not (var_2_2 and FightHelper.isBossId(var_2_2, arg_2_1:getMO().modelId)) then
		return false
	end

	local var_2_3 = arg_2_1:getMO():getBuffDic()

	for iter_2_0, iter_2_1 in pairs(var_2_3) do
		if var_0_2[iter_2_1.buffId] then
			return true
		end
	end

	return false
end

function var_0_0._onSkillEnd(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:onDone(true)
end

function var_0_0._delayDone(arg_4_0)
	logError("播放破盾Timeline超时")
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_5_0._onSkillEnd, arg_5_0)
end

return var_0_0

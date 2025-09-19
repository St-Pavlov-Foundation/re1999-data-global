module("modules.logic.fight.system.work.FightWorkTriggerAnalysis343", package.seeall)

local var_0_0 = class("FightWorkTriggerAnalysis343", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.targetId
	local var_1_1 = FightHelper.getEntity(var_1_0)

	if not var_1_1 then
		logError("触发分析 未找到技能释放者 : " .. tostring(var_1_0))

		return arg_1_0:onDone(true)
	end

	local var_1_2 = var_1_1:getMO()
	local var_1_3 = var_1_2 and var_1_2.skin
	local var_1_4 = var_1_3 and lua_fight_sp_effect_wuerlixi_timeline.configDict[var_1_3]

	if not var_1_4 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_5 = arg_1_0.actEffectData.teamType == FightEnum.TeamType.MySide and var_1_4.mySideTimeline or var_1_4.enemySideTimeline

	if string.nilorempty(var_1_5) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0:com_registTimer(arg_1_0._delayDone, 30)
	arg_1_0:com_registEvent(FightController.instance, FightEvent.OnSkillPlayFinish, arg_1_0.onSkillPlayFinish)
	var_1_1.skill:playTimeline(var_1_5, arg_1_0.fightStepData)
end

function var_0_0.onSkillPlayFinish(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0

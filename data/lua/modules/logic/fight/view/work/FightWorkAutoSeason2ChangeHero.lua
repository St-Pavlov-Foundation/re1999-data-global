module("modules.logic.fight.view.work.FightWorkAutoSeason2ChangeHero", package.seeall)

local var_0_0 = class("FightWorkAutoSeason2ChangeHero", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._opList = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._beginRoundOp = arg_1_0._opList[arg_1_2]
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._beginRoundOp then
		arg_2_0:onDone(true)

		return
	end

	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 30)

	local var_2_0 = arg_2_0._opList[arg_2_0._index - 2].toId
	local var_2_1 = arg_2_0._opList[arg_2_0._index - 1].toId

	arg_2_0._toId = arg_2_0._beginRoundOp.toId

	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0, LuaEventSystem.Low)
	FightController.instance:registerCallback(FightEvent.ReceiveChangeSubHeroReply, arg_2_0._onReceiveChangeSubHeroReply, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ChangeSubHeroExSkillReply, arg_2_0._onChangeSubHeroExSkillReply, arg_2_0)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Season2AutoChangeHero)
	FightRpc.instance:sendChangeSubHeroRequest(var_2_0, var_2_1)
end

function var_0_0._onRoundSequenceFinish(arg_3_0)
	if not arg_3_0._changedSkill then
		arg_3_0._changedSkill = true
	else
		arg_3_0:clearWork()

		return
	end

	FightRpc.instance:sendChangeSubHeroExSkillRequest(arg_3_0._toId)
end

function var_0_0._onReceiveChangeSubHeroReply(arg_4_0, arg_4_1)
	if arg_4_1 ~= 0 then
		arg_4_0:onDone(true)
	end
end

function var_0_0._onChangeSubHeroExSkillReply(arg_5_0, arg_5_1)
	if arg_5_1 ~= 0 then
		arg_5_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Season2AutoChangeHero)
	TaskDispatcher.cancelTask(arg_7_0._delayDone, arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.ReceiveChangeSubHeroReply, arg_7_0._onReceiveChangeSubHeroReply, arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_7_0._onRoundSequenceFinish, arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.ChangeSubHeroExSkillReply, arg_7_0._onChangeSubHeroExSkillReply, arg_7_0)
end

return var_0_0

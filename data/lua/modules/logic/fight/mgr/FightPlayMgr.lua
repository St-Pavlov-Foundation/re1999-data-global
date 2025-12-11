module("modules.logic.fight.mgr.FightPlayMgr", package.seeall)

local var_0_0 = class("FightPlayMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workComp = arg_1_0:addComponent(FightWorkComponent)

	arg_1_0:com_registMsg(FightMsgId.ForceReleasePlayFlow, arg_1_0.onForceReleasePlayFlow)
	arg_1_0:com_registFightEvent(FightEvent.StageChanged, arg_1_0.onStageChanged)
end

function var_0_0.onForceReleasePlayFlow(arg_2_0)
	arg_2_0.workComp:disposeAllWork()
end

function var_0_0.onStageChanged(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == FightStageMgr.StageType.Play then
		arg_3_0.workComp:disposeAllWork()
	end
end

function var_0_0.playStart(arg_4_0)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local var_4_0 = arg_4_0.workComp:registWork(FightWorkFlowSequence)

	var_4_0:registWork(FightWorkPlayStart)
	var_4_0:registWork(FightWorkPlay2Operate, true)
	var_4_0:start()
end

function var_0_0.playShow(arg_5_0)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local var_5_0 = arg_5_0.workComp:registWork(FightWorkFlowSequence)

	var_5_0:registWork(FightWorkPlayShow)
	var_5_0:registWork(FightWorkPlay2Operate)
	var_5_0:start()
end

function var_0_0.playCloth(arg_6_0)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.ClothSkill)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local var_6_0 = arg_6_0.workComp:registWork(FightWorkFlowSequence)

	var_6_0:registWork(FightWorkPlayCloth)
	var_6_0:registWork(FightWorkPlay2Operate, false, true)
	var_6_0:start()
end

function var_0_0.playEnd(arg_7_0)
	arg_7_0.workComp:disposeAllWork()

	FightDataHelper.stateMgr.isFinish = true

	if FightSystem.instance.restarting then
		return
	end

	if FightRestartHelper.tryRestart() then
		return
	end

	ViewMgr.instance:closeView(ViewName.FightQuitTipView)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	FightGameMgr.restartMgr:killComponent(FightFlowComponent)
	FightDataMgr.instance.stateMgr:setPlayingEnd(true)
	arg_7_0:_PlayEnd()
end

function var_0_0._PlayEnd(arg_8_0)
	local var_8_0 = arg_8_0.workComp:registWork(FightWorkFlowSequence)

	var_8_0:registWork(FightWorkPlayEnd)
	var_8_0:registFinishCallback(arg_8_0.onEndFinish, arg_8_0)
	var_8_0:start()
end

function var_0_0.onEndFinish(arg_9_0)
	FightController.instance:dispatchEvent(FightEvent.OnEndSequenceFinish)
end

function var_0_0.playReconnect(arg_10_0)
	FightController.instance:dispatchEvent(FightEvent.OnFightReconnect)

	if FightModel.instance:isFinish() then
		FightRpc.instance:sendEndFightRequest(false)
	else
		local var_10_0 = arg_10_0.workComp:registWork(FightWorkFlowSequence)

		var_10_0:registWork(FightWorkPlayReconnect)
		var_10_0:registWork(FightWorkPlay2Operate, true)
		var_10_0:start()
	end
end

function var_0_0.onDestructor(arg_11_0)
	return
end

return var_0_0

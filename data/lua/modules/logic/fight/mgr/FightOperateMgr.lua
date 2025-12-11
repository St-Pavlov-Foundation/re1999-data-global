module("modules.logic.fight.mgr.FightOperateMgr", package.seeall)

local var_0_0 = class("FightOperateMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workComp = arg_1_0:addComponent(FightWorkComponent)

	arg_1_0:com_registFightEvent(FightEvent.StageChanged, arg_1_0.onStageChanged)
end

function var_0_0.isOperating(arg_2_0)
	return arg_2_0.workComp:hasAliveWork()
end

function var_0_0.onStageChanged(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == FightStageMgr.StageType.Play then
		arg_3_0.workComp:disposeAllWork()
		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.SendOperation2Server)
	end
end

function var_0_0.cancelAllOperate(arg_4_0)
	arg_4_0.workComp:disposeAllWork()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.SendOperation2Server)
end

function var_0_0.beforeOperate(arg_5_0)
	FightMsgMgr.sendMsg(FightMsgId.BeforeOperate)
end

function var_0_0.afterOperate(arg_6_0)
	FightMsgMgr.sendMsg(FightMsgId.AfterOperate)
end

function var_0_0.newOperateFlow(arg_7_0)
	local var_7_0 = arg_7_0.workComp:registWork(FightWorkFlowSequence)

	var_7_0:registWork(FightWorkFunction, arg_7_0.beforeOperate, arg_7_0)
	var_7_0:registFinishCallback(arg_7_0.afterOperate, arg_7_0)

	return var_7_0
end

function var_0_0.playHandCard(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_0:newOperateFlow()

	var_8_0:registWork(FightWorkPlayHandCard, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	var_8_0:start()
end

function var_0_0.sendOperate2Server(arg_9_0)
	local var_9_0 = arg_9_0.workComp:registWork(FightWorkFlowSequence)

	var_9_0:registWork(FightWorkSendOperate2Server)
	var_9_0:start()
end

function var_0_0.requestAutoFight(arg_10_0)
	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Operate then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AutoCardPlaying) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.SendOperation2Server) then
		return
	end

	arg_10_0.workComp:registWork(FightWorkRequestAutoFight):start()
end

function var_0_0.onDestructor(arg_11_0)
	return
end

return var_0_0

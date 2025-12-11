module("modules.logic.fight.system.work.FightWorkSendOperate2Server", package.seeall)

local var_0_0 = class("FightWorkSendOperate2Server", FightWorkItem)

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.SendOperation2Server)

	local var_2_0 = arg_2_0:com_registFlowSequence()
	local var_2_1 = FightMsgMgr.sendMsg(FightMsgId.RegistCardEndAniFlow)

	if var_2_1 then
		var_2_0:addWork(var_2_1)
	end

	var_2_0:registFinishCallback(arg_2_0.onFinish, arg_2_0)
	arg_2_0:playWorkAndDone(var_2_0)
end

function var_0_0.onFinish(arg_3_0)
	local var_3_0 = FightDataHelper.handCardMgr.handCard

	FightDataUtil.coverData(var_3_0, FightLocalDataMgr.instance.handCardMgr:getHandCard())
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr:getOpList())

	if FightModel.instance:getVersion() >= 1 then
		FightController.instance:dispatchEvent(FightEvent.ShowSimulateClientUsedCard)

		return
	end

	FightPlayCardModel.instance:updateClientOps()
	FightController.instance:dispatchEvent(FightEvent.UpdateWaitingArea)
end

return var_0_0

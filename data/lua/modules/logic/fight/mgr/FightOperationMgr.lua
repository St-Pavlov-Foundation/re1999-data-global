module("modules.logic.fight.mgr.FightOperationMgr", package.seeall)

local var_0_0 = class("FightOperationMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0:com_registFightEvent(FightEvent.EnterStage, arg_1_0._onEnterStage)
	arg_1_0:com_registFightEvent(FightEvent.ExitStage, arg_1_0._onExitStage)
	arg_1_0:com_registMsg(FightMsgId.RequestOperation, arg_1_0._onRequestOperation)
end

local var_0_1 = {
	[FightOperationStateMgr.StateType.PlayHandCard] = "onPlayHandCard",
	[FightOperationStateMgr.StateType.PlayAssistBossCard] = "onPlayVirtualCard",
	[FightOperationStateMgr.StateType.PlayPlayerFinisherSkill] = "onPlayVirtualCard",
	[FightOperationStateMgr.StateType.MoveHandCard] = "onMoveHandCard"
}

function var_0_0._onRequestOperation(arg_2_0, arg_2_1, ...)
	local var_2_0 = var_0_1[arg_2_1]

	if var_2_0 then
		local var_2_1, var_2_2 = arg_2_0[var_2_0](arg_2_0, ...)

		if var_2_1 then
			FightDataHelper.operationStateMgr:enterOperationState(arg_2_1)
			var_2_1:registFinishCallback(arg_2_0._onOperationFinish, arg_2_0, arg_2_1)
			var_2_1:start(var_2_2)
		else
			logError("声明了操作方法,但是却没有返回work,设计上目前考虑不应该出现此情况,不知后续是否有此需求,目前先直接强制操作结束")
			arg_2_0:_requestOperation()
		end
	end
end

function var_0_0._onOperationFinish(arg_3_0, arg_3_1)
	FightDataHelper.operationStateMgr:exitOperationState(arg_3_1)
	arg_3_0:_checkSend2Server()
end

function var_0_0.onPlayHandCard(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0:com_sendMsg(FightMsgId.PlayCard, arg_4_1, arg_4_2)

	if var_4_0 then
		local var_4_1 = FightDataHelper.operationDataMgr:newOperation()

		var_4_1:playCard(arg_4_1, arg_4_2, arg_4_3)

		local var_4_2 = {
			operationData = var_4_1
		}

		return var_4_0, var_4_2
	end
end

function var_0_0.onPlayVirtualCard(arg_5_0, arg_5_1, ...)
	local var_5_0 = arg_5_0:com_sendMsg(FightMsgId.RegistPlayAtOperationView, arg_5_1, ...)

	if var_5_0 then
		FightDataHelper.operationDataMgr:addOperation(arg_5_1)

		local var_5_1 = {
			operationData = arg_5_1
		}

		return var_5_0, var_5_1
	end
end

function var_0_0.onMoveHandCard(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:com_sendMsg(FightMsgId.MoveCard, arg_6_1)

	if var_6_0 then
		local var_6_1 = FightOperationItemData.New()
		local var_6_2 = {
			operationData = var_6_1
		}

		var_6_0:registFinishCallback(arg_6_0._onMoveCardFinish, arg_6_0, var_6_1)

		return var_6_0, var_6_2
	end
end

function var_0_0._onMoveCardFinish(arg_7_0, arg_7_1)
	if arg_7_1.param1 ~= arg_7_1.param2 then
		FightDataHelper.operationDataMgr:addOperation(arg_7_1)
	end
end

function var_0_0._checkSend2Server(arg_8_0)
	if FightDataHelper.stageMgr:isPlayStage() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		local var_8_0 = arg_8_0:com_sendMsg(FightMsgId.CheckAliveOperationWork)

		if not var_8_0 then
			logError("操作区不存在了,理论上不应该发生此情况")
			arg_8_0:_requestOperation()
		else
			FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.OperationView2PlayView)

			local var_8_1 = arg_8_0:com_registFlowSequence()
			local var_8_2 = var_8_1:registWork(FightWorkFlowParallel)

			for iter_8_0, iter_8_1 in ipairs(var_8_0) do
				var_8_2:listen2Work(iter_8_1)
			end

			var_8_1:registFinishCallback(arg_8_0._operation2PlayFinished, arg_8_0)

			return var_8_1
		end
	end
end

function var_0_0._operation2PlayFinished(arg_9_0)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.OperationView2PlayView)
	arg_9_0:_requestOperation()
end

function var_0_0._requestOperation(arg_10_0)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.SendOperation2Server)
	FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr.operationList)

	local var_10_0 = arg_10_0:com_sendMsg(FightMsgId.GetUIHandCardDataList)

	FightDataUtil.coverData(var_10_0, FightLocalDataMgr.instance.handCardMgr.handCard)
	FightDataUtil.coverData(var_10_0, FightDataMgr.instance.handCardMgr.handCard)
end

function var_0_0._onEnterStage(arg_11_0, arg_11_1)
	return
end

function var_0_0._onExitStage(arg_12_0, arg_12_1)
	return
end

function var_0_0.onDestructor(arg_13_0)
	return
end

return var_0_0

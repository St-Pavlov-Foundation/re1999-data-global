module("modules.logic.fight.system.work.FightWorkRequestAutoFight", package.seeall)

local var_0_0 = class("FightWorkRequestAutoFight", FightWorkItem)

function var_0_0.onConstructor(arg_1_0)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.AutoCardPlaying)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_registMsg(FightMsgId.AutoRoundReply, arg_2_0.onAutoRoundReply)
	arg_2_0:com_registMsg(FightMsgId.AutoRoundReplyFail, arg_2_0.onAutoRoundReplyFail)
	FightRpc.instance:sendAutoRoundRequest(FightDataHelper.operationDataMgr:getOpList())
	arg_2_0:cancelFightWorkSafeTimer()
end

function var_0_0.onAutoRoundReply(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.opers) do
		local var_3_1 = FightOperationItemData.New()

		var_3_1:setByProto(iter_3_1)
		table.insert(var_3_0, var_3_1)
	end

	if #var_3_0 > 0 then
		local var_3_2 = arg_3_0:com_registFlowSequence()

		var_3_2:registWork(FightWorkCheckUseAiJiAoQte)
		var_3_2:registWork(FightWorkClearAiJiAoQteTempData)
		var_3_2:registWork(FightAutoBindContractWork)
		var_3_2:registWork(FightAutoDetectUpgradeWork)
		var_3_2:registWork(FightWorkWaitAllOperateDone)

		local var_3_3 = 0

		for iter_3_2, iter_3_3 in ipairs(var_3_0) do
			if iter_3_3:isAssistBossPlayCard() then
				var_3_2:addWork(WorkWaitSeconds.New(0.3))
				var_3_2:addWork(FightAutoPlayAssistBossCardWork.New(iter_3_3))
			elseif iter_3_3:isSeason2ChangeHero() then
				-- block empty
			elseif iter_3_3:isPlayerFinisherSkill() then
				var_3_2:addWork(WorkWaitSeconds.New(0.1))
				var_3_2:addWork(FightWorkAutoPlayerFinisherSkill.New(iter_3_3))
			elseif iter_3_3:isBloodPoolSkill() then
				logError("自动打牌  血池牌 todo")
			elseif iter_3_3:isPlayCard() then
				var_3_2:addWork(WorkWaitSeconds.New(0.01))
				var_3_2:addWork(FightAutoPlayCardWork.New(iter_3_3))
			end
		end

		var_3_2:registWork(FightWorkSendOperate2Server)
		arg_3_0:playWorkAndDone(var_3_2)
	else
		local var_3_4 = arg_3_0:com_registWork(FightWorkSendOperate2Server)

		arg_3_0:playWorkAndDone(var_3_4)
	end
end

function var_0_0.onAutoRoundReplyFail(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.onDestructor(arg_5_0)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AutoCardPlaying)
end

return var_0_0

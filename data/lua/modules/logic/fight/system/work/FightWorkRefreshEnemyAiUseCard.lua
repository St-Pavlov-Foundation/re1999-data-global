module("modules.logic.fight.system.work.FightWorkRefreshEnemyAiUseCard", package.seeall)

local var_0_0 = class("FightWorkRefreshEnemyAiUseCard", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightDataHelper.roundMgr:getRoundData()

	if not var_1_0 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = arg_1_0:com_registFlowSequence()

	FightMsgMgr.sendMsg(FightMsgId.EntrustFightWork, var_1_1)

	local var_1_2, var_1_3 = FightMsgMgr.sendMsg(FightMsgId.DiscardUnUsedEnemyAiCard)

	if var_1_3 then
		local var_1_4 = var_1_1:registWork(FightWorkFlowParallel)

		for iter_1_0, iter_1_1 in ipairs(var_1_3) do
			var_1_4:addWork(iter_1_1)
		end
	end

	var_1_1:registWork(FightWorkFunction, function()
		local var_2_0 = var_1_0.entityAiUseCards
		local var_2_1 = FightDataHelper.entityMgr.entityDataDic

		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			local var_2_2 = FightDataHelper.entityExMgr:getById(iter_2_0)
			local var_2_3 = var_2_0[iter_2_0] or {}

			FightDataUtil.coverData(var_2_3, var_2_2.aiUseCardList)
		end
	end)
	var_1_1:registWork(FightWorkSendMsg, FightMsgId.RefreshEnemyAiUseCard)
	var_1_1:start()
	arg_1_0:onDone(true)
end

return var_0_0

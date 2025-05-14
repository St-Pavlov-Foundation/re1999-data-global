module("modules.logic.fight.system.work.FightWorkCompareServerDataNew", package.seeall)

local var_0_0 = class("FightWorkCompareServerDataNew", BaseWork)
local var_0_1 = {
	Local2Performance = 2,
	Server2Local = 1
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	if FightModel.instance:isFinish() then
		arg_1_0:onDone(true)

		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		arg_1_0:onDone(true)

		return
	end

	if FightReplayModel.instance:isReplay() then
		if FightModel.instance:getVersion() >= 4 then
			arg_1_0:_compareLocalWithPerformance()
		end

		arg_1_0:onDone(true)

		return
	end

	arg_1_0:_compareLocalWithPerformance()

	if not SLFramework.FrameworkSettings.IsEditor then
		arg_1_0:onDone(true)

		return
	end

	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 5)

	arg_1_0._count = 0

	FightController.instance:registerCallback(FightEvent.CountEntityInfoReply, arg_1_0._onCountEntityInfoReply, arg_1_0)

	local var_1_0 = FightLocalDataMgr.instance.entityMgr:getAllEntityMO()

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if not iter_1_1:isStatusDead() then
			arg_1_0._count = arg_1_0._count + 1

			local var_1_1 = iter_1_1.uid

			FightRpc.instance:sendEntityInfoRequest(var_1_1)
		end
	end

	if arg_1_0._count == 0 then
		arg_1_0:onDone(true)
	end
end

function var_0_0._compareLocalWithPerformance(arg_2_0)
	local var_2_0 = FightLocalDataMgr.instance.entityMgr:getAllEntityMO()
	local var_2_1 = false

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_2 = FightDataHelper.entityMgr:getById(iter_2_1.id)

		if not arg_2_0:_compareData(iter_2_1, var_2_2, var_0_1.Local2Performance) then
			var_2_1 = true
		end
	end

	if var_2_1 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
	end
end

function var_0_0._compareData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 and arg_3_2 and not arg_3_1:isStatusDead() then
		local var_3_0 = arg_3_1.id
		local var_3_1 = FightEntityMoCompareHelper.compareEntityMo(arg_3_1, arg_3_2)

		if not var_3_1 then
			if isDebugBuild and arg_3_3 == var_0_1.Server2Local then
				local var_3_2 = arg_3_1:getCO()
				local var_3_3 = FightEntityMoDiffHelper.getDiffMsg(arg_3_1, arg_3_2)
				local var_3_4 = ""

				if arg_3_3 == var_0_1.Server2Local then
					var_3_4 = "前后端数据不一致"
				end

				logError(string.format("%s, entityId:%s, 角色名称:%s\n %s", var_3_4, var_3_0, var_3_2 and var_3_2.name or "", var_3_3))
			end

			FightEntityDataHelper.copyEntityMO(arg_3_1, arg_3_2)
			FightController.instance:dispatchEvent(FightEvent.ForceUpdatePerformanceData, var_3_0)
		end

		return var_3_1
	end

	return true
end

function var_0_0._onCountEntityInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		local var_4_0 = arg_4_2.entityInfo and FightLocalDataMgr.instance.entityMgr:getById(arg_4_2.entityInfo.uid)

		if var_4_0 then
			local var_4_1 = var_4_0.id
			local var_4_2 = FightEntityMO.New()

			var_4_2:init(arg_4_2.entityInfo, var_4_0.side)

			if not var_0_0:_compareData(var_4_2, var_4_0, var_0_1.Server2Local) then
				local var_4_3 = FightDataHelper.entityMgr:getById(var_4_1)

				if var_4_3 then
					FightEntityDataHelper.copyEntityMO(var_4_2, var_4_3)
					FightController.instance:dispatchEvent(FightEvent.ForceUpdatePerformanceData, var_4_1)
				end
			end
		else
			logError("数据错误")
		end
	end

	arg_4_0._count = arg_4_0._count - 1

	if arg_4_0._count <= 0 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
		arg_4_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_5_0)
	logError("[new]对比前后端数据超时")
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.CountEntityInfoReply, arg_6_0._onCountEntityInfoReply, arg_6_0)
end

return var_0_0

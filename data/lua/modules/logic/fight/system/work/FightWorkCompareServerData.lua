module("modules.logic.fight.system.work.FightWorkCompareServerData", package.seeall)

local var_0_0 = class("FightWorkCompareServerData", BaseWork)
local var_0_1 = {
	stanceIndex = true,
	playCardExPoint = true,
	stanceDic = true,
	_playCardAddExpoint = true,
	buffFeaturesSplit = true,
	_last_clone_mo = true,
	moveCardExPoint = true,
	passiveSkillDic = true,
	_combineCardAddExpoint = true,
	custom_refreshNameUIOp = true,
	class = true,
	attrMO = true,
	skillList = true,
	_moveCardAddExpoint = true
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		arg_1_0:onDone(true)

		return
	end

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

	if SLFramework.FrameworkSettings.IsEditor then
		arg_1_0:_compareLocalWithPerformance(true)
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
	else
		arg_1_0:_compareLocalWithPerformance()
		arg_1_0:onDone(true)
	end
end

function var_0_0._compareLocalWithPerformance(arg_2_0, arg_2_1)
	local var_2_0 = FightLocalDataMgr.instance.entityMgr:getAllEntityMO()
	local var_2_1 = false

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_2 = FightDataHelper.entityMgr:getById(iter_2_1.id)

		if arg_2_0:_compareLocalData(iter_2_1, var_2_2, arg_2_1) then
			var_2_1 = true
		end
	end

	if var_2_1 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
	end

	return var_2_1
end

function var_0_0._compareLocalData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 and arg_3_2 and not arg_3_1:isStatusDead() then
		local var_3_0 = arg_3_1.id

		for iter_3_0, iter_3_1 in pairs(arg_3_2.buffDic) do
			if not arg_3_1.buffDic[iter_3_0] then
				local var_3_1 = FightHelper.getEntity(arg_3_1.id)

				if var_3_1 and var_3_1.buff then
					var_3_1.buff:delBuff(iter_3_0)
				end

				arg_3_2.buffDic[iter_3_0] = nil
			end
		end

		local var_3_2, var_3_3, var_3_4, var_3_5 = FightHelper.compareData(arg_3_1, arg_3_2, var_0_1)

		if not var_3_2 then
			FightEntityDataHelper.copyEntityMO(arg_3_1, arg_3_2)
			FightController.instance:dispatchEvent(FightEvent.ForceUpdatePerformanceData, var_3_0)

			return true
		end
	end
end

function var_0_0.sortBuffList(arg_4_0, arg_4_1)
	return arg_4_0.time < arg_4_1.time
end

function var_0_0._onCountEntityInfoReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		local var_5_0 = arg_5_2.entityInfo and FightLocalDataMgr.instance.entityMgr:getById(arg_5_2.entityInfo.uid)

		if var_5_0 then
			local var_5_1 = var_5_0.id
			local var_5_2 = FightEntityMO.New()

			var_5_2:init(arg_5_2.entityInfo, var_5_0.side)

			local var_5_3, var_5_4, var_5_5, var_5_6 = FightHelper.compareData(var_5_2, var_5_0, var_0_1)

			if not var_5_3 then
				local var_5_7 = var_5_0:getCO()
				local var_5_8 = "前后端entity数据不一致,entityId:%s, 角色名称:%s, key = %s, \nserverValue = %s, \nlocalValue = %s"

				logError(string.format(var_5_8, var_5_1, var_5_7 and var_5_7.name or "", var_5_4, FightHelper.logStr(var_5_5, var_0_1), FightHelper.logStr(var_5_6, var_0_1)))
				FightLocalDataMgr.instance.entityMgr:replaceEntityMO(var_5_2)

				local var_5_9 = FightDataHelper.entityMgr:getById(var_5_1)

				if var_5_9 then
					FightEntityDataHelper.copyEntityMO(var_5_2, var_5_9)
					FightController.instance:dispatchEvent(FightEvent.ForceUpdatePerformanceData, var_5_1)
				end
			else
				local var_5_10 = FightDataHelper.entityMgr:getById(var_5_1)

				arg_5_0:_compareLocalData(var_5_0, var_5_10)
			end
		else
			logError("数据错误")
		end
	end

	arg_5_0._count = arg_5_0._count - 1

	if arg_5_0._count <= 0 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
		arg_5_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_6_0)
	logError("对比前后端数据超时")
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._delayDone, arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.CountEntityInfoReply, arg_7_0._onCountEntityInfoReply, arg_7_0)
end

return var_0_0

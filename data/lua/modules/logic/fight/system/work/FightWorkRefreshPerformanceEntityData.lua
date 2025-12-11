module("modules.logic.fight.system.work.FightWorkRefreshPerformanceEntityData", package.seeall)

local var_0_0 = class("FightWorkRefreshPerformanceEntityData", FightWorkItem)

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

	if FightDataHelper.stateMgr.isReplay then
		if FightModel.instance:getVersion() >= 4 then
			arg_1_0:_refreshPerformanceData()
		end

		arg_1_0:onDone(true)

		return
	end

	arg_1_0:_refreshPerformanceData(true)
	arg_1_0:onDone(true)
end

function var_0_0._refreshPerformanceData(arg_2_0)
	local var_2_0 = FightWorkCompareServerEntityData.filterCompareKey
	local var_2_1 = FightWorkCompareServerEntityData.costomCompareFunc
	local var_2_2 = FightLocalDataMgr.instance.entityMgr:getAllEntityMO()

	for iter_2_0, iter_2_1 in pairs(var_2_2) do
		if not iter_2_1:isStatusDead() then
			local var_2_3 = iter_2_1.id
			local var_2_4 = FightDataHelper.entityMgr:getById(var_2_3)
			local var_2_5, var_2_6 = FightDataUtil.findDiff(iter_2_1, var_2_4, var_2_0, var_2_1)

			if var_2_5 then
				FightEntityDataHelper.copyEntityMO(iter_2_1, var_2_4)
				FightController.instance:dispatchEvent(FightEvent.CoverPerformanceEntityData, var_2_3)
			end
		end
	end
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0

﻿module("modules.logic.fight.system.work.FightWorkRefreshPerformanceEntityData", package.seeall)

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

	if FightReplayModel.instance:isReplay() then
		if FightModel.instance:getVersion() >= 4 then
			arg_1_0:_refreshPerformanceData()
		end

		arg_1_0:onDone(true)

		return
	end

	if SLFramework.FrameworkSettings.IsEditor then
		arg_1_0:_refreshPerformanceData(true)
	end

	arg_1_0:onDone(true)
end

function var_0_0._refreshPerformanceData(arg_2_0)
	local var_2_0 = FightLocalDataMgr.instance.entityMgr:getAllEntityMO()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		if not iter_2_1:isStatusDead() then
			local var_2_1 = iter_2_1.id
			local var_2_2 = FightDataHelper.entityMgr:getById(var_2_1)

			FightEntityDataHelper.copyEntityMO(iter_2_1, var_2_2)
			FightController.instance:dispatchEvent(FightEvent.CoverPerformanceEntityData, var_2_1)
		end
	end
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0

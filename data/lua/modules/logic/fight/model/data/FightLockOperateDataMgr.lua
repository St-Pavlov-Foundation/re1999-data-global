module("modules.logic.fight.model.data.FightLockOperateDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightLockOperateDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.isLock(arg_2_0)
	if FightDataHelper.stateMgr:getIsAuto() then
		return true
	end

	if FightDataHelper.stateMgr.isReplay then
		return true
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AutoCardPlaying) then
		return true
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.SendOperation2Server) then
		return true
	end

	return false
end

return var_0_0

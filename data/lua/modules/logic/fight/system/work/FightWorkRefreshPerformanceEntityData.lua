module("modules.logic.fight.system.work.FightWorkRefreshPerformanceEntityData", package.seeall)

slot0 = class("FightWorkRefreshPerformanceEntityData", FightWorkItem)

function slot0.onStart(slot0, slot1)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		slot0:onDone(true)

		return
	end

	if FightModel.instance:isFinish() then
		slot0:onDone(true)

		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		slot0:onDone(true)

		return
	end

	if FightReplayModel.instance:isReplay() then
		if FightModel.instance:getVersion() >= 4 then
			slot0:_refreshPerformanceData()
		end

		slot0:onDone(true)

		return
	end

	if SLFramework.FrameworkSettings.IsEditor then
		slot0:_refreshPerformanceData(true)
	end

	slot0:onDone(true)
end

function slot0._refreshPerformanceData(slot0)
	for slot5, slot6 in pairs(FightLocalDataMgr.instance.entityMgr:getAllEntityMO()) do
		if not slot6:isStatusDead() then
			slot7 = slot6.id

			FightEntityDataHelper.copyEntityMO(slot6, FightDataHelper.entityMgr:getById(slot7))
			FightController.instance:dispatchEvent(FightEvent.CoverPerformanceEntityData, slot7)
		end
	end
end

function slot0.clearWork(slot0)
end

return slot0

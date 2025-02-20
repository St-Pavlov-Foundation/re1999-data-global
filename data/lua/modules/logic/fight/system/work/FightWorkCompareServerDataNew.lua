module("modules.logic.fight.system.work.FightWorkCompareServerDataNew", package.seeall)

slot0 = class("FightWorkCompareServerDataNew", BaseWork)
slot1 = {
	Local2Performance = 2,
	Server2Local = 1
}

function slot0.onStart(slot0, slot1)
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
			slot0:_compareLocalWithPerformance()
		end

		slot0:onDone(true)

		return
	end

	slot0:_compareLocalWithPerformance()

	if not SLFramework.FrameworkSettings.IsEditor then
		slot0:onDone(true)

		return
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 5)

	slot0._count = 0
	slot6 = slot0._onCountEntityInfoReply
	slot7 = slot0

	FightController.instance:registerCallback(FightEvent.CountEntityInfoReply, slot6, slot7)

	for slot6, slot7 in pairs(FightLocalDataMgr.instance.entityMgr:getAllEntityMO()) do
		if not slot7:isStatusDead() then
			slot0._count = slot0._count + 1

			FightRpc.instance:sendEntityInfoRequest(slot7.uid)
		end
	end

	if slot0._count == 0 then
		slot0:onDone(true)
	end
end

function slot0._compareLocalWithPerformance(slot0)
	slot2 = false

	for slot6, slot7 in pairs(FightLocalDataMgr.instance.entityMgr:getAllEntityMO()) do
		if not slot0:_compareData(slot7, FightDataHelper.entityMgr:getById(slot7.id), uv0.Local2Performance) then
			slot2 = true
		end
	end

	if slot2 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
	end
end

function slot0._compareData(slot0, slot1, slot2, slot3)
	if slot1 and slot2 and not slot1:isStatusDead() then
		slot4 = slot1.id

		if not FightEntityMoCompareHelper.compareEntityMo(slot1, slot2) then
			if isDebugBuild and slot3 == uv0.Server2Local then
				slot6 = slot1:getCO()
				slot7 = FightEntityMoDiffHelper.getDiffMsg(slot1, slot2)
				slot8 = ""

				if slot3 == uv0.Server2Local then
					slot8 = "前后端数据不一致"
				end

				logError(string.format("%s, entityId:%s, 角色名称:%s\n %s", slot8, slot4, slot6 and slot6.name or "", slot7))
			end

			FightEntityDataHelper.copyEntityMO(slot1, slot2)
			FightController.instance:dispatchEvent(FightEvent.ForceUpdatePerformanceData, slot4)
		end

		return slot5
	end

	return true
end

function slot0._onCountEntityInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.entityInfo and FightLocalDataMgr.instance.entityMgr:getById(slot2.entityInfo.uid) then
			slot4 = slot3.id
			slot5 = FightEntityMO.New()

			slot5:init(slot2.entityInfo, slot3.side)

			if not uv0:_compareData(slot5, slot3, uv1.Server2Local) and FightDataHelper.entityMgr:getById(slot4) then
				FightEntityDataHelper.copyEntityMO(slot5, slot6)
				FightController.instance:dispatchEvent(FightEvent.ForceUpdatePerformanceData, slot4)
			end
		else
			logError("数据错误")
		end
	end

	slot0._count = slot0._count - 1

	if slot0._count <= 0 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	logError("[new]对比前后端数据超时")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.CountEntityInfoReply, slot0._onCountEntityInfoReply, slot0)
end

return slot0

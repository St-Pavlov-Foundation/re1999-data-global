module("modules.logic.fight.system.work.FightWorkCompareServerData", package.seeall)

slot0 = class("FightWorkCompareServerData", BaseWork)
slot1 = {
	buffFeaturesSplit = true,
	playCardExPoint = true,
	stanceIndex = true,
	skillList = true,
	stanceDic = true,
	_afterUniqueCombineCount = true,
	_combineCardAddExpoint = true,
	custom_refreshNameUIOp = true,
	class = true,
	_afterUniqueMoveCount = true,
	_moveCardAddExpoint = true,
	_playCardAddExpoint = true,
	moveCardExPoint = true,
	passiveSkillDic = true,
	isOnlyData = true,
	attrMO = true,
	storedExPoint = true
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

	if SLFramework.FrameworkSettings.IsEditor then
		slot0:_compareLocalWithPerformance(true)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 5)

		slot0._count = 0
		slot6 = slot0

		FightController.instance:registerCallback(FightEvent.CountEntityInfoReply, slot0._onCountEntityInfoReply, slot6)

		for slot6, slot7 in pairs(FightDataMgr.instance:getEntityDataMgr():getAllEntityMO()) do
			if not slot7.isDead then
				slot0._count = slot0._count + 1

				FightRpc.instance:sendEntityInfoRequest(slot7.uid)
			end
		end

		if slot0._count == 0 then
			slot0:onDone(true)
		end
	else
		slot0:_compareLocalWithPerformance()
		slot0:onDone(true)
	end
end

function slot0._compareLocalWithPerformance(slot0, slot1)
	slot3 = false

	for slot7, slot8 in pairs(FightDataMgr.instance:getEntityDataMgr():getAllEntityMO()) do
		if slot0:_compareLocalData(slot8, FightEntityModel.instance:getById(slot8.id), slot1) then
			slot3 = true
		end
	end

	if slot3 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
	end

	return slot3
end

function slot0._compareLocalData(slot0, slot1, slot2, slot3)
	if slot1 and slot2 and not slot1.isDead then
		slot4 = slot1.id

		slot1.buffModel:sort(uv0.sortBuffList)
		slot2.buffModel:sort(uv0.sortBuffList)

		slot5, slot6, slot7, slot8 = FightHelper.compareData(slot1, slot2, uv1)

		if not slot5 then
			if slot3 then
				logError(string.format("本地数据和表现层数据不一致,如无明显异常,则可忽略此错误,entityId:%s, 角色名称:%s, key = %s, \nlocalValue = %s, \nperformanceValue = %s", slot4, slot1:getCO() and slot10.name or "", slot6, FightHelper.logStr(slot7, uv1), FightHelper.logStr(slot8, uv1)))
			end

			FightEntityDataMgr.copyEntityMO(slot1, slot2)

			slot2.storedExPoint = slot2.storedExPoint

			FightController.instance:dispatchEvent(FightEvent.ForceUpdatePerformanceData, slot4)

			return true
		end
	end
end

function slot0.sortBuffList(slot0, slot1)
	return slot0.time < slot1.time
end

function slot0._onCountEntityInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.entityInfo and FightDataMgr.instance:getEntityDataMgr():getEntityMO(slot2.entityInfo.uid) then
			slot4 = slot3.id
			slot5 = FightEntityMO.New()

			slot5:init(slot2.entityInfo, slot3.side)
			slot5.buffModel:sort(uv0.sortBuffList)
			slot3.buffModel:sort(uv0.sortBuffList)

			slot6, slot7, slot8, slot9 = FightHelper.compareData(slot5, slot3, uv1)

			if not slot6 then
				logError(string.format("前后端entity数据不一致,entityId:%s, 角色名称:%s, key = %s, \nserverValue = %s, \nlocalValue = %s", slot4, slot3:getCO() and slot10.name or "", slot7, FightHelper.logStr(slot8, uv1), FightHelper.logStr(slot9, uv1)))
				FightDataMgr.instance:getEntityDataMgr():replaceEntityMO(slot5)

				if FightEntityModel.instance:getById(slot4) then
					FightEntityDataMgr.copyEntityMO(slot5, slot12)
					FightController.instance:dispatchEvent(FightEvent.ForceUpdatePerformanceData, slot4)
				end
			else
				slot0:_compareLocalData(slot3, FightEntityModel.instance:getById(slot4))
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
	logError("对比前后端数据超时")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.CountEntityInfoReply, slot0._onCountEntityInfoReply, slot0)
end

return slot0

module("modules.logic.fight.system.work.FightWorkCompareServerEntityData", package.seeall)

slot0 = class("FightWorkCompareServerEntityData", FightWorkItem)

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
		slot0:onDone(true)

		return
	end

	if SLFramework.FrameworkSettings.IsEditor then
		slot0:com_registTimer(slot0._delayDone, 5)

		slot0._count = 0

		slot0:com_registFightEvent(FightEvent.CountEntityInfoReply, slot0._onCountEntityInfoReply)

		for slot6, slot7 in pairs(FightLocalDataMgr.instance.entityMgr:getAllEntityMO()) do
			if not slot7:isStatusDead() then
				slot0._count = slot0._count + 1

				FightRpc.instance:sendEntityInfoRequest(slot7.uid)
			end
		end

		if slot0._count == 0 then
			slot0:onDone(true)
		end

		return
	end

	slot0:onDone(true)
end

function slot0.compareAttrMO(slot0, slot1, slot2, slot3)
	if slot0.hp ~= slot1.hp then
		FightDataHelper.addDiff("hp", FightDataHelper.diffType.difference)
	end

	if slot0.multiHpNum ~= slot1.multiHpNum then
		FightDataHelper.addDiff("multiHpNum", FightDataHelper.diffType.difference)
	end
end

function slot0.comparSummonedOneData(slot0, slot1)
	FightDataHelper.doFindDiff(slot0, slot1, {
		stanceIndex = true
	})
end

function slot0.compareSummonedInfo(slot0, slot1, slot2, slot3)
	FightDataHelper.addPathkey("dataDic")
	FightDataHelper.doFindDiff(slot0.dataDic, slot1.dataDic, nil, , uv0.comparSummonedOneData)
	FightDataHelper.removePathKey()
end

slot1 = {
	[FightDataHelper.diffType.missingSource] = "服务器数据不存在",
	[FightDataHelper.diffType.missingTarget] = "本地数据不存在",
	[FightDataHelper.diffType.difference] = "数据不一致"
}
slot2 = {
	buffFeaturesSplit = true,
	playCardExPoint = true,
	resistanceDict = true,
	_playCardAddExpoint = true,
	moveCardExPoint = true,
	passiveSkillDic = true,
	_combineCardAddExpoint = true,
	custom_refreshNameUIOp = true,
	class = true,
	skillList = true,
	_moveCardAddExpoint = true
}
slot3 = {
	attrMO = slot0.compareAttrMO,
	summonedInfo = slot0.compareSummonedInfo
}

function slot0._onCountEntityInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.entityInfo and FightLocalDataMgr.instance.entityMgr:getById(slot2.entityInfo.uid) then
			slot5 = FightEntityMO.New()

			slot5:init(slot2.entityInfo, slot3.side)

			slot6, slot7 = FightDataHelper.findDiff(slot5, slot3, uv0, uv1)

			if slot6 then
				slot9 = string.format("前后端entity数据不一致,entityId:%s, 角色名称:%s \n", slot3.id, slot3:getCO() and slot8.name or "")

				for slot13, slot14 in pairs(slot7) do
					for slot18, slot19 in ipairs(slot14) do
						slot20 = " "

						if slot19.diffType == FightDataHelper.diffType.difference then
							slot21, slot22 = FightDataHelper.getDiffValue(slot5, slot3, slot19)
							slot20 = string.format("    服务器数据:%s, 本地数据:%s", slot21, slot22)
						end

						slot9 = slot9 .. "路径: entityMO." .. slot19.pathStr .. ", 原因:" .. uv2[slot19.diffType] .. slot20 .. "\n"
					end

					slot9 = slot9 .. "\n" .. "服务器数据: entityMO." .. slot13 .. " = " .. FightHelper.logStr(slot5[slot13], uv0) .. "\n" .. "\n" .. "本地数据: entityMO." .. slot13 .. " = " .. FightHelper.logStr(slot3[slot13], uv0) .. "\n" .. "------------------------------------------------------------------------------------------------------------------------\n"
				end

				logError(slot9)
				FightLocalDataMgr.instance.entityMgr:replaceEntityMO(slot5)
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
end

return slot0

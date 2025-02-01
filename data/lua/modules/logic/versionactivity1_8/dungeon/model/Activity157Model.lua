module("modules.logic.versionactivity1_8.dungeon.model.Activity157Model", package.seeall)

slot0 = class("Activity157Model", BaseModel)
slot1 = 0
slot2 = 1

function slot0.onInit(slot0)
	slot0:setIsUnlockEntrance(false, true)
	slot0:setIsSideMissionUnlocked(false, true)
	slot0:setUnlockComponentByList(nil, true)
	slot0:setHasGotRewardComponentByList(nil, true)
	slot0:setProductionInfo(nil, , true)
	slot0:setMissionInfoByList(nil, true)
	slot0:setInProgressMissionGroup(nil, true)
	slot0:setHasPlayedAnim()

	slot0._hasPlayedAnimDict = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.setActivityInfo(slot0, slot1)
	if not slot1 or not slot1.activityId or slot2 ~= slot0:getActId() then
		return
	end

	slot0:setIsUnlockEntrance(slot1.haveMap)
	slot0:setIsSideMissionUnlocked(slot1.isSideMissionUnlocked)
	slot0:setUnlockComponentByList(slot1.unlockedComponents)
	slot0:setHasGotRewardComponentByList(slot1.gainRewardComponents)
	slot0:setProductionInfo(slot1.productionInfo.productionMaterial.quantity, slot1.productionInfo.nextRecoverTime)
	slot0:setMissionInfoByList(slot1.missionInfos)
	slot0:setInProgressMissionGroup(slot1.inProgressSideMissionGroupId)
	slot0:setSideMissionUnlockTime(slot1.sideMissionUnlockTime)
	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157UpdateInfo)
end

function slot0.setIsUnlockEntrance(slot0, slot1, slot2)
	slot0._isUnlockEntrance = slot1

	if slot2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshEntrance)
end

function slot0.setIsSideMissionUnlocked(slot0, slot1, slot2)
	slot0._isSideMissionUnlocked = slot1

	if slot2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshSideMission)
end

function slot0.setUnlockComponentByList(slot0, slot1, slot2)
	slot0._unlockComponentDict = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot0:setComponentUnlock(slot7, true)
		end
	end

	if slot2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RepairComponent)
end

function slot0.setComponentUnlock(slot0, slot1, slot2)
	if not slot0._unlockComponentDict then
		slot0._unlockComponentDict = {}
	end

	if not slot1 then
		return
	end

	slot0._unlockComponentDict[slot1] = true

	if slot2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RepairComponent, slot1)
end

function slot0.setHasGotRewardComponentByList(slot0, slot1, slot2)
	slot0._hasGotRewardComponentDict = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot0:addHasGotRewardComponent(slot7, true)
		end
	end

	if slot2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157GetComponentReward)
end

function slot0.addHasGotRewardComponent(slot0, slot1, slot2)
	if not slot0._hasGotRewardComponentDict then
		slot0._hasGotRewardComponentDict = {}
	end

	if not slot1 then
		return
	end

	slot0._hasGotRewardComponentDict[slot1] = true

	if slot2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157GetComponentReward)
end

function slot0.setProductionInfo(slot0, slot1, slot2, slot3)
	slot0._productionNum = slot1
	slot0._nextRecoverTime = slot2

	if slot3 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshFactoryProduction)
end

function slot0.setMissionInfoByList(slot0, slot1, slot2)
	slot0._missionGroupId2FinishMissions = {}

	if not slot1 then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		for slot12, slot13 in ipairs(slot7.finishedMissionIds) do
			slot0:addFinishedMission(slot13, slot7.missionGroup, true)
		end
	end

	if slot2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157FinishMission)
end

function slot0.setInProgressMissionGroup(slot0, slot1, slot2)
	slot0._inProcessMissionGroup = slot1

	if slot2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157ChangeInProgressMissionGroup)
end

function slot0.addFinishedMission(slot0, slot1, slot2, slot3)
	if not slot0._missionGroupId2FinishMissions then
		slot0._missionGroupId2FinishMissions = {}
	end

	if not slot1 then
		return
	end

	if not (slot2 or Activity157Config.instance:getMissionGroup(slot0:getActId(), slot1)) then
		return
	end

	if not slot0._missionGroupId2FinishMissions[slot5] then
		slot0._missionGroupId2FinishMissions[slot5] = {}
	end

	slot6[slot1] = true

	if slot3 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157FinishMission)
end

function slot0.setSideMissionUnlockTime(slot0, slot1)
	slot0._sideMissionUnlockTime = slot1
end

function slot0.getActId(slot0)
	return VersionActivity1_8Enum.ActivityId.DungeonReturnToWork
end

function slot0.getIsUnlockEntrance(slot0)
	return slot0._isUnlockEntrance
end

function slot0.getIsSideMissionUnlocked(slot0)
	return slot0._isSideMissionUnlocked
end

function slot0.getIsUnlockFactoryBlueprint(slot0)
	slot2 = false

	return slot0:getIsFirstComponentRepair() and true or slot0:isCanRepairComponent(Activity157Config.instance:getAct157Const(slot0:getActId(), Activity157Enum.ConstId.FirstFactoryComponent))
end

function slot0.getIsNeedPlayMissionUnlockAnim(slot0, slot1)
	if not slot1 then
		return false
	end

	slot3 = slot0:getActId()

	if (not Activity157Config.instance:isRootMission(slot3, slot1) or slot5 and Activity157Config.instance:isSideMission(slot3, slot1)) and slot0:getIsUnlockMission(slot1) then
		slot2 = not slot0:getHasPlayedAnim(VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedMissionNodeUnlocked .. slot1)
	end

	return slot2
end

function slot0.getHasPlayedAnim(slot0, slot1)
	if not slot0._hasPlayedAnimDict then
		slot0._hasPlayedAnimDict = {}
	end

	if not slot1 then
		return
	end

	if not slot0._hasPlayedAnimDict[slot1] then
		slot0._hasPlayedAnimDict[slot1] = VersionActivity1_8DungeonController.instance:getPlayerPrefs(slot1, uv0)
	end

	return slot0._hasPlayedAnimDict[slot1] ~= uv0
end

function slot0.setHasPlayedAnim(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._hasPlayedAnimDict[slot1] = uv0

	VersionActivity1_8DungeonController.instance:savePlayerPrefs(slot1, slot0._hasPlayedAnimDict[slot1])
end

function slot0.getFactoryProductionNum(slot0)
	return slot0._productionNum or 0
end

function slot0.getFactoryNextRecoverCountdown(slot0)
	slot1 = ""

	if slot0._nextRecoverTime and slot0._nextRecoverTime ~= 0 then
		slot1 = TimeUtil.second2TimeString(math.max(slot0._nextRecoverTime / 1000 - ServerTime.now(), 0), true)
	end

	return slot1
end

function slot0.getSideMissionUnlockTime(slot0)
	slot1 = ""
	slot2 = true

	if slot0._sideMissionUnlockTime and slot0._sideMissionUnlockTime ~= 0 then
		slot3 = math.max(slot0._sideMissionUnlockTime / 1000 - ServerTime.now(), 0)
		slot1 = TimeUtil.second2TimeString(slot3, true)
		slot2 = slot3 <= 0
	end

	return slot1, slot2
end

function slot0.isRepairComponent(slot0, slot1)
	slot2 = false

	if tonumber(slot1) and slot0._unlockComponentDict then
		slot2 = slot0._unlockComponentDict[slot3] or false
	end

	return slot2
end

function slot0.getIsFirstComponentRepair(slot0)
	return slot0:isRepairComponent(Activity157Config.instance:getAct157Const(slot0:getActId(), Activity157Enum.ConstId.FirstFactoryComponent))
end

function slot0.isCanRepairComponent(slot0, slot1)
	slot2 = false

	if slot0:isPreComponentRepaired(slot1) then
		slot5, slot6, slot7 = Activity157Config.instance:getComponentUnlockCondition(slot0:getActId(), slot1)

		if slot7 then
			slot2 = slot7 <= ItemModel.instance:getItemQuantity(slot5, slot6)
		end
	end

	return slot2
end

function slot0.isPreComponentRepaired(slot0, slot1)
	slot4 = true

	if Activity157Config.instance:getPreComponentId(slot0:getActId(), slot1) and slot3 ~= 0 then
		slot4 = slot0:isRepairComponent(slot3)
	end

	return slot4
end

function slot0.getLastWillBeRepairedComponent(slot0)
	slot1 = nil

	for slot7, slot8 in ipairs(Activity157Config.instance:getComponentIdList(slot0:getActId())) do
		if not slot0:isRepairComponent(slot8) then
			slot1 = slot8

			break
		end
	end

	return slot1
end

function slot0.getComponentRepairProgress(slot0)
	slot1 = 0

	if slot0:getIsUnlockFactoryBlueprint() then
		for slot9, slot10 in ipairs(Activity157Config.instance:getComponentIdList(slot0:getActId())) do
			if slot0:isRepairComponent(slot10) then
				slot4 = 0 + 1
			end
		end

		slot1 = slot4 / #slot5
	end

	return slot1
end

function slot0.isAllComponentRepair(slot0)
	return slot0:getComponentRepairProgress() >= 1
end

function slot0.hasComponentGotReward(slot0, slot1)
	slot2 = false

	if slot1 and slot0._hasGotRewardComponentDict then
		slot2 = slot0._hasGotRewardComponentDict[slot1] or false
	end

	return slot2
end

function slot0.getLastHasGotRewardComponent(slot0)
	slot1 = nil

	for slot7, slot8 in ipairs(Activity157Config.instance:getComponentIdList(slot0:getActId())) do
		if not slot0:hasComponentGotReward(slot8) then
			break
		end

		slot1 = slot8
	end

	return slot1
end

function slot0.getLastArchiveRewardComponent(slot0)
	slot1 = nil

	for slot7, slot8 in ipairs(Activity157Config.instance:getComponentIdList(slot0:getActId())) do
		if not slot0:isRepairComponent(slot8) then
			break
		end

		if not slot0:hasComponentGotReward(slot8) then
			slot1 = slot8
		end
	end

	return slot1
end

function slot0.isFinishMission(slot0, slot1, slot2)
	slot3 = false

	if slot1 and slot2 then
		slot4 = {}

		if slot0._missionGroupId2FinishMissions then
			slot4 = slot0._missionGroupId2FinishMissions[slot1] or {}
		end

		slot3 = slot4[slot2] or false
	end

	return slot3
end

function slot0.isFinishAllMission(slot0, slot1)
	slot2 = true

	for slot8, slot9 in ipairs(Activity157Config.instance:getAct157MissionList(slot0:getActId(), slot1)) do
		if not slot0:isFinishMission(slot1, slot9) then
			slot2 = false

			break
		end
	end

	return slot2
end

function slot0.getAllActiveNodeGroupList(slot0)
	slot1 = {}

	for slot8, slot9 in ipairs(Activity157Config.instance:getAllMissionGroupIdList(slot0:getActId())) do
		if not Activity157Config.instance:isSideMissionGroup(slot2, slot9) or slot10 and slot0:getIsFirstComponentRepair() then
			slot1[#slot1 + 1] = slot9
		end
	end

	return slot1
end

function slot0.getShowMissionIdList(slot0, slot1)
	slot2 = {}
	slot3 = slot0:getActId()
	slot4 = Activity157Config.instance:getAct157MissionList(slot3, slot1)

	if not Activity157Config.instance:isSideMissionGroup(slot3, slot1) then
		for slot9, slot10 in ipairs(slot4) do
			slot11 = true

			if Activity157Config.instance:getAct157ParentMissionId(slot3, slot10) then
				slot11 = slot0:isFinishMission(slot1, slot12)
			end

			if slot0:getIsUnlockMission(slot10) or slot11 then
				slot2[#slot2 + 1] = slot10
			end
		end
	else
		for slot9, slot10 in ipairs(slot4) do
			if slot0:getIsUnlockMission(slot10) or Activity157Config.instance:isRootMission(slot3, slot10) then
				slot2[#slot2 + 1] = slot10
			end
		end
	end

	return slot2
end

function slot0.getMissionStatus(slot0, slot1, slot2)
	if not Activity157Config.instance:getMissionElementId(slot0:getActId(), slot2) then
		logError(string.format("Activity157Model:getMissionStatus error, elementId is nil, actId:%s missionId:%s", slot3, slot2))

		return Activity157Enum.MissionStatus.Locked
	end

	if slot0:isFinishMission(slot1, slot2) then
		return Activity157Enum.MissionStatus.Finish
	end

	if not DungeonMapModel.instance:getElementById(slot4) then
		return Activity157Enum.MissionStatus.Locked
	end

	if DungeonConfig.instance:isDispatchElement(slot4) then
		if DispatchModel.instance:getDispatchStatus(slot4) == DispatchEnum.DispatchStatus.Finished then
			return Activity157Enum.MissionStatus.DispatchFinish
		elseif slot8 == DispatchEnum.DispatchStatus.Dispatching then
			return Activity157Enum.MissionStatus.Dispatching
		end
	end

	return Activity157Enum.MissionStatus.Normal
end

function slot0.getIsUnlockMission(slot0, slot1)
	if not slot0:getIsSideMissionUnlocked() and Activity157Config.instance:isSideMission(slot0:getActId(), slot1) then
		return false
	end

	if slot0:isFinishMission(Activity157Config.instance:getMissionGroup(slot3, slot1), slot1) or Activity157Config.instance:getMissionElementId(slot3, slot1) and DungeonMapModel.instance:getElementById(slot8) then
		slot2 = true
	end

	return slot2
end

function slot0.getMissionUnlockToastId(slot0, slot1, slot2)
	if Activity157Config.instance:isSideMission(slot0:getActId(), slot1) and not slot0:getIsSideMissionUnlocked() then
		return ToastEnum.V1a8Activity157NotUnlockSideMission
	end

	slot5 = slot2 and DungeonConfig.instance:getChapterMapElement(slot2)

	if string.nilorempty(slot5 and slot5.condition) then
		return
	end

	slot7, slot8 = string.match(slot6, "(ChapterMapElement=)(%d+)")
	slot9 = slot8 and tonumber(slot8)

	if slot9 and not (slot9 and DungeonMapModel.instance:elementIsFinished(slot9)) then
		return ToastEnum.V1a8Activity157MissionLockedByPreMission
	end

	slot11, slot12 = string.match(slot6, "(EpisodeFinish=)(%d+)")

	if slot12 and not (slot12 and DungeonModel.instance:hasPassLevelAndStory(slot12)) then
		return ToastEnum.V1a8Activity157MissionLockedByStory
	end

	slot14, slot15 = string.match(slot6, "(Act157ComponentUnlock=)(%d+)")

	if slot15 and not (slot15 and slot0:isRepairComponent(slot15)) then
		return ToastEnum.V1a8Activity157NotRepairComponent
	end

	return ToastEnum.ConditionLock
end

function slot0.getInProgressMissionGroup(slot0)
	return slot0._inProcessMissionGroup
end

function slot0.isInProgressOtherMissionGroup(slot0, slot1)
	slot2 = false

	if slot0:getInProgressMissionGroup() and slot3 ~= 0 then
		slot2 = slot3 ~= slot1
	end

	return slot2
end

function slot0.isInProgressOtherMissionGroupByElementId(slot0, slot1)
	slot2 = false

	if Activity157Config.instance:getMissionIdByElementId(slot0:getActId(), slot1) then
		slot2 = slot0:isInProgressOtherMissionGroup(Activity157Config.instance:getMissionGroup(slot3, slot4))
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0

module("modules.logic.versionactivity1_8.dungeon.model.Activity157Model", package.seeall)

local var_0_0 = class("Activity157Model", BaseModel)
local var_0_1 = 0
local var_0_2 = 1

function var_0_0.onInit(arg_1_0)
	arg_1_0:setIsUnlockEntrance(false, true)
	arg_1_0:setIsSideMissionUnlocked(false, true)
	arg_1_0:setUnlockComponentByList(nil, true)
	arg_1_0:setHasGotRewardComponentByList(nil, true)
	arg_1_0:setProductionInfo(nil, nil, true)
	arg_1_0:setMissionInfoByList(nil, true)
	arg_1_0:setInProgressMissionGroup(nil, true)
	arg_1_0:setHasPlayedAnim()

	arg_1_0._hasPlayedAnimDict = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.setActivityInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1.activityId
	local var_3_1 = arg_3_0:getActId()

	if not var_3_0 or var_3_0 ~= var_3_1 then
		return
	end

	arg_3_0:setIsUnlockEntrance(arg_3_1.haveMap)
	arg_3_0:setIsSideMissionUnlocked(arg_3_1.isSideMissionUnlocked)
	arg_3_0:setUnlockComponentByList(arg_3_1.unlockedComponents)
	arg_3_0:setHasGotRewardComponentByList(arg_3_1.gainRewardComponents)

	local var_3_2 = arg_3_1.productionInfo.productionMaterial.quantity
	local var_3_3 = arg_3_1.productionInfo.nextRecoverTime

	arg_3_0:setProductionInfo(var_3_2, var_3_3)
	arg_3_0:setMissionInfoByList(arg_3_1.missionInfos)
	arg_3_0:setInProgressMissionGroup(arg_3_1.inProgressSideMissionGroupId)
	arg_3_0:setSideMissionUnlockTime(arg_3_1.sideMissionUnlockTime)
	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157UpdateInfo)
end

function var_0_0.setIsUnlockEntrance(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._isUnlockEntrance = arg_4_1

	if arg_4_2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshEntrance)
end

function var_0_0.setIsSideMissionUnlocked(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._isSideMissionUnlocked = arg_5_1

	if arg_5_2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshSideMission)
end

function var_0_0.setUnlockComponentByList(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._unlockComponentDict = {}

	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			arg_6_0:setComponentUnlock(iter_6_1, true)
		end
	end

	if arg_6_2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RepairComponent)
end

function var_0_0.setComponentUnlock(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._unlockComponentDict then
		arg_7_0._unlockComponentDict = {}
	end

	if not arg_7_1 then
		return
	end

	arg_7_0._unlockComponentDict[arg_7_1] = true

	if arg_7_2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RepairComponent, arg_7_1)
end

function var_0_0.setHasGotRewardComponentByList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._hasGotRewardComponentDict = {}

	if arg_8_1 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			arg_8_0:addHasGotRewardComponent(iter_8_1, true)
		end
	end

	if arg_8_2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157GetComponentReward)
end

function var_0_0.addHasGotRewardComponent(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._hasGotRewardComponentDict then
		arg_9_0._hasGotRewardComponentDict = {}
	end

	if not arg_9_1 then
		return
	end

	arg_9_0._hasGotRewardComponentDict[arg_9_1] = true

	if arg_9_2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157GetComponentReward)
end

function var_0_0.setProductionInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._productionNum = arg_10_1
	arg_10_0._nextRecoverTime = arg_10_2

	if arg_10_3 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157RefreshFactoryProduction)
end

function var_0_0.setMissionInfoByList(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._missionGroupId2FinishMissions = {}

	if not arg_11_1 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_0 = iter_11_1.missionGroup

		for iter_11_2, iter_11_3 in ipairs(iter_11_1.finishedMissionIds) do
			arg_11_0:addFinishedMission(iter_11_3, var_11_0, true)
		end
	end

	if arg_11_2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157FinishMission)
end

function var_0_0.setInProgressMissionGroup(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._inProcessMissionGroup = arg_12_1

	if arg_12_2 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157ChangeInProgressMissionGroup)
end

function var_0_0.addFinishedMission(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0._missionGroupId2FinishMissions then
		arg_13_0._missionGroupId2FinishMissions = {}
	end

	if not arg_13_1 then
		return
	end

	local var_13_0 = arg_13_0:getActId()
	local var_13_1 = arg_13_2 or Activity157Config.instance:getMissionGroup(var_13_0, arg_13_1)

	if not var_13_1 then
		return
	end

	local var_13_2 = arg_13_0._missionGroupId2FinishMissions[var_13_1]

	if not var_13_2 then
		var_13_2 = {}
		arg_13_0._missionGroupId2FinishMissions[var_13_1] = var_13_2
	end

	var_13_2[arg_13_1] = true

	if arg_13_3 then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.Act157FinishMission)
end

function var_0_0.setSideMissionUnlockTime(arg_14_0, arg_14_1)
	arg_14_0._sideMissionUnlockTime = arg_14_1
end

function var_0_0.getActId(arg_15_0)
	return VersionActivity1_8Enum.ActivityId.DungeonReturnToWork
end

function var_0_0.getIsUnlockEntrance(arg_16_0)
	return arg_16_0._isUnlockEntrance
end

function var_0_0.getIsSideMissionUnlocked(arg_17_0)
	return arg_17_0._isSideMissionUnlocked
end

function var_0_0.getIsUnlockFactoryBlueprint(arg_18_0)
	local var_18_0 = arg_18_0:getActId()
	local var_18_1 = false
	local var_18_2

	if arg_18_0:getIsFirstComponentRepair() then
		var_18_2 = true
	else
		local var_18_3 = Activity157Config.instance:getAct157Const(var_18_0, Activity157Enum.ConstId.FirstFactoryComponent)

		var_18_2 = arg_18_0:isCanRepairComponent(var_18_3)
	end

	return var_18_2
end

function var_0_0.getIsNeedPlayMissionUnlockAnim(arg_19_0, arg_19_1)
	local var_19_0 = false

	if not arg_19_1 then
		return var_19_0
	end

	local var_19_1 = arg_19_0:getActId()
	local var_19_2 = Activity157Config.instance:isSideMission(var_19_1, arg_19_1)
	local var_19_3 = Activity157Config.instance:isRootMission(var_19_1, arg_19_1)

	if (not var_19_3 or var_19_3 and var_19_2) and arg_19_0:getIsUnlockMission(arg_19_1) then
		local var_19_4 = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedMissionNodeUnlocked .. arg_19_1

		var_19_0 = not arg_19_0:getHasPlayedAnim(var_19_4)
	end

	return var_19_0
end

function var_0_0.getHasPlayedAnim(arg_20_0, arg_20_1)
	if not arg_20_0._hasPlayedAnimDict then
		arg_20_0._hasPlayedAnimDict = {}
	end

	if not arg_20_1 then
		return
	end

	if not arg_20_0._hasPlayedAnimDict[arg_20_1] then
		arg_20_0._hasPlayedAnimDict[arg_20_1] = VersionActivity1_8DungeonController.instance:getPlayerPrefs(arg_20_1, var_0_1)
	end

	return arg_20_0._hasPlayedAnimDict[arg_20_1] ~= var_0_1
end

function var_0_0.setHasPlayedAnim(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	arg_21_0._hasPlayedAnimDict[arg_21_1] = var_0_2

	VersionActivity1_8DungeonController.instance:savePlayerPrefs(arg_21_1, arg_21_0._hasPlayedAnimDict[arg_21_1])
end

function var_0_0.getFactoryProductionNum(arg_22_0)
	return arg_22_0._productionNum or 0
end

function var_0_0.getFactoryNextRecoverCountdown(arg_23_0)
	local var_23_0 = ""

	if arg_23_0._nextRecoverTime and arg_23_0._nextRecoverTime ~= 0 then
		local var_23_1 = math.max(arg_23_0._nextRecoverTime / 1000 - ServerTime.now(), 0)

		var_23_0 = TimeUtil.second2TimeString(var_23_1, true)
	end

	return var_23_0
end

function var_0_0.getSideMissionUnlockTime(arg_24_0)
	local var_24_0 = ""
	local var_24_1 = true

	if arg_24_0._sideMissionUnlockTime and arg_24_0._sideMissionUnlockTime ~= 0 then
		local var_24_2 = math.max(arg_24_0._sideMissionUnlockTime / 1000 - ServerTime.now(), 0)

		var_24_0 = TimeUtil.second2TimeString(var_24_2, true)
		var_24_1 = var_24_2 <= 0
	end

	return var_24_0, var_24_1
end

function var_0_0.isRepairComponent(arg_25_0, arg_25_1)
	local var_25_0 = false
	local var_25_1 = tonumber(arg_25_1)

	if var_25_1 and arg_25_0._unlockComponentDict then
		var_25_0 = arg_25_0._unlockComponentDict[var_25_1] or false
	end

	return var_25_0
end

function var_0_0.getIsFirstComponentRepair(arg_26_0)
	local var_26_0 = arg_26_0:getActId()
	local var_26_1 = Activity157Config.instance:getAct157Const(var_26_0, Activity157Enum.ConstId.FirstFactoryComponent)

	return (arg_26_0:isRepairComponent(var_26_1))
end

function var_0_0.isCanRepairComponent(arg_27_0, arg_27_1)
	local var_27_0 = false
	local var_27_1 = arg_27_0:getActId()

	if arg_27_0:isPreComponentRepaired(arg_27_1) then
		local var_27_2, var_27_3, var_27_4 = Activity157Config.instance:getComponentUnlockCondition(var_27_1, arg_27_1)
		local var_27_5 = ItemModel.instance:getItemQuantity(var_27_2, var_27_3)

		if var_27_4 then
			var_27_0 = var_27_4 <= var_27_5
		end
	end

	return var_27_0
end

function var_0_0.isPreComponentRepaired(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getActId()
	local var_28_1 = Activity157Config.instance:getPreComponentId(var_28_0, arg_28_1)
	local var_28_2 = true

	if var_28_1 and var_28_1 ~= 0 then
		var_28_2 = arg_28_0:isRepairComponent(var_28_1)
	end

	return var_28_2
end

function var_0_0.getLastWillBeRepairedComponent(arg_29_0)
	local var_29_0
	local var_29_1 = arg_29_0:getActId()
	local var_29_2 = Activity157Config.instance:getComponentIdList(var_29_1)

	for iter_29_0, iter_29_1 in ipairs(var_29_2) do
		if not arg_29_0:isRepairComponent(iter_29_1) then
			var_29_0 = iter_29_1

			break
		end
	end

	return var_29_0
end

function var_0_0.getComponentRepairProgress(arg_30_0)
	local var_30_0 = 0

	if arg_30_0:getIsUnlockFactoryBlueprint() then
		local var_30_1 = arg_30_0:getActId()
		local var_30_2 = 0
		local var_30_3 = Activity157Config.instance:getComponentIdList(var_30_1)

		for iter_30_0, iter_30_1 in ipairs(var_30_3) do
			if arg_30_0:isRepairComponent(iter_30_1) then
				var_30_2 = var_30_2 + 1
			end
		end

		var_30_0 = var_30_2 / #var_30_3
	end

	return var_30_0
end

function var_0_0.isAllComponentRepair(arg_31_0)
	return arg_31_0:getComponentRepairProgress() >= 1
end

function var_0_0.hasComponentGotReward(arg_32_0, arg_32_1)
	local var_32_0 = false

	if arg_32_1 and arg_32_0._hasGotRewardComponentDict then
		var_32_0 = arg_32_0._hasGotRewardComponentDict[arg_32_1] or false
	end

	return var_32_0
end

function var_0_0.getLastHasGotRewardComponent(arg_33_0)
	local var_33_0
	local var_33_1 = arg_33_0:getActId()
	local var_33_2 = Activity157Config.instance:getComponentIdList(var_33_1)

	for iter_33_0, iter_33_1 in ipairs(var_33_2) do
		if not arg_33_0:hasComponentGotReward(iter_33_1) then
			break
		end

		var_33_0 = iter_33_1
	end

	return var_33_0
end

function var_0_0.getLastArchiveRewardComponent(arg_34_0)
	local var_34_0
	local var_34_1 = arg_34_0:getActId()
	local var_34_2 = Activity157Config.instance:getComponentIdList(var_34_1)

	for iter_34_0, iter_34_1 in ipairs(var_34_2) do
		if not arg_34_0:isRepairComponent(iter_34_1) then
			break
		end

		if not arg_34_0:hasComponentGotReward(iter_34_1) then
			var_34_0 = iter_34_1
		end
	end

	return var_34_0
end

function var_0_0.isFinishMission(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = false

	if arg_35_1 and arg_35_2 then
		local var_35_1 = {}

		if arg_35_0._missionGroupId2FinishMissions then
			var_35_1 = arg_35_0._missionGroupId2FinishMissions[arg_35_1] or {}
		end

		var_35_0 = var_35_1[arg_35_2] or false
	end

	return var_35_0
end

function var_0_0.isFinishAllMission(arg_36_0, arg_36_1)
	local var_36_0 = true
	local var_36_1 = arg_36_0:getActId()
	local var_36_2 = Activity157Config.instance:getAct157MissionList(var_36_1, arg_36_1)

	for iter_36_0, iter_36_1 in ipairs(var_36_2) do
		if not arg_36_0:isFinishMission(arg_36_1, iter_36_1) then
			var_36_0 = false

			break
		end
	end

	return var_36_0
end

function var_0_0.getAllActiveNodeGroupList(arg_37_0)
	local var_37_0 = {}
	local var_37_1 = arg_37_0:getActId()
	local var_37_2 = Activity157Config.instance:getAllMissionGroupIdList(var_37_1)
	local var_37_3 = arg_37_0:getIsFirstComponentRepair()

	for iter_37_0, iter_37_1 in ipairs(var_37_2) do
		local var_37_4 = Activity157Config.instance:isSideMissionGroup(var_37_1, iter_37_1)

		if not var_37_4 or var_37_4 and var_37_3 then
			var_37_0[#var_37_0 + 1] = iter_37_1
		end
	end

	return var_37_0
end

function var_0_0.getShowMissionIdList(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = arg_38_0:getActId()
	local var_38_2 = Activity157Config.instance:getAct157MissionList(var_38_1, arg_38_1)

	if not Activity157Config.instance:isSideMissionGroup(var_38_1, arg_38_1) then
		for iter_38_0, iter_38_1 in ipairs(var_38_2) do
			local var_38_3 = true
			local var_38_4 = Activity157Config.instance:getAct157ParentMissionId(var_38_1, iter_38_1)

			if var_38_4 then
				var_38_3 = arg_38_0:isFinishMission(arg_38_1, var_38_4)
			end

			if arg_38_0:getIsUnlockMission(iter_38_1) or var_38_3 then
				var_38_0[#var_38_0 + 1] = iter_38_1
			end
		end
	else
		for iter_38_2, iter_38_3 in ipairs(var_38_2) do
			local var_38_5 = arg_38_0:getIsUnlockMission(iter_38_3)
			local var_38_6 = Activity157Config.instance:isRootMission(var_38_1, iter_38_3)

			if var_38_5 or var_38_6 then
				var_38_0[#var_38_0 + 1] = iter_38_3
			end
		end
	end

	return var_38_0
end

function var_0_0.getMissionStatus(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:getActId()
	local var_39_1 = Activity157Config.instance:getMissionElementId(var_39_0, arg_39_2)

	if not var_39_1 then
		logError(string.format("Activity157Model:getMissionStatus error, elementId is nil, actId:%s missionId:%s", var_39_0, arg_39_2))

		return Activity157Enum.MissionStatus.Locked
	end

	if arg_39_0:isFinishMission(arg_39_1, arg_39_2) then
		return Activity157Enum.MissionStatus.Finish
	end

	if not DungeonMapModel.instance:getElementById(var_39_1) then
		return Activity157Enum.MissionStatus.Locked
	end

	if DungeonConfig.instance:isDispatchElement(var_39_1) then
		local var_39_2 = DispatchModel.instance:getDispatchStatus(var_39_1)

		if var_39_2 == DispatchEnum.DispatchStatus.Finished then
			return Activity157Enum.MissionStatus.DispatchFinish
		elseif var_39_2 == DispatchEnum.DispatchStatus.Dispatching then
			return Activity157Enum.MissionStatus.Dispatching
		end
	end

	return Activity157Enum.MissionStatus.Normal
end

function var_0_0.getIsUnlockMission(arg_40_0, arg_40_1)
	local var_40_0 = false
	local var_40_1 = arg_40_0:getActId()
	local var_40_2 = Activity157Config.instance:isSideMission(var_40_1, arg_40_1)

	if not arg_40_0:getIsSideMissionUnlocked() and var_40_2 then
		return var_40_0
	end

	local var_40_3 = Activity157Config.instance:getMissionGroup(var_40_1, arg_40_1)
	local var_40_4 = arg_40_0:isFinishMission(var_40_3, arg_40_1)
	local var_40_5 = Activity157Config.instance:getMissionElementId(var_40_1, arg_40_1)
	local var_40_6 = var_40_5 and DungeonMapModel.instance:getElementById(var_40_5)

	if var_40_4 or var_40_6 then
		var_40_0 = true
	end

	return var_40_0
end

function var_0_0.getMissionUnlockToastId(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0:getActId()

	if Activity157Config.instance:isSideMission(var_41_0, arg_41_1) and not arg_41_0:getIsSideMissionUnlocked() then
		return ToastEnum.V1a8Activity157NotUnlockSideMission
	end

	local var_41_1 = arg_41_2 and DungeonConfig.instance:getChapterMapElement(arg_41_2)
	local var_41_2 = var_41_1 and var_41_1.condition

	if string.nilorempty(var_41_2) then
		return
	end

	local var_41_3, var_41_4 = string.match(var_41_2, "(ChapterMapElement=)(%d+)")
	local var_41_5 = var_41_4 and tonumber(var_41_4)
	local var_41_6 = var_41_5 and DungeonMapModel.instance:elementIsFinished(var_41_5)

	if var_41_5 and not var_41_6 then
		return ToastEnum.V1a8Activity157MissionLockedByPreMission
	end

	local var_41_7, var_41_8 = string.match(var_41_2, "(EpisodeFinish=)(%d+)")
	local var_41_9 = var_41_8 and DungeonModel.instance:hasPassLevelAndStory(var_41_8)

	if var_41_8 and not var_41_9 then
		return ToastEnum.V1a8Activity157MissionLockedByStory
	end

	local var_41_10, var_41_11 = string.match(var_41_2, "(Act157ComponentUnlock=)(%d+)")
	local var_41_12 = var_41_11 and arg_41_0:isRepairComponent(var_41_11)

	if var_41_11 and not var_41_12 then
		return ToastEnum.V1a8Activity157NotRepairComponent
	end

	return ToastEnum.ConditionLock
end

function var_0_0.getInProgressMissionGroup(arg_42_0)
	return arg_42_0._inProcessMissionGroup
end

function var_0_0.isInProgressOtherMissionGroup(arg_43_0, arg_43_1)
	local var_43_0 = false
	local var_43_1 = arg_43_0:getInProgressMissionGroup()

	if var_43_1 and var_43_1 ~= 0 then
		var_43_0 = var_43_1 ~= arg_43_1
	end

	return var_43_0
end

function var_0_0.isInProgressOtherMissionGroupByElementId(arg_44_0, arg_44_1)
	local var_44_0 = false
	local var_44_1 = arg_44_0:getActId()
	local var_44_2 = Activity157Config.instance:getMissionIdByElementId(var_44_1, arg_44_1)

	if var_44_2 then
		local var_44_3 = Activity157Config.instance:getMissionGroup(var_44_1, var_44_2)

		var_44_0 = arg_44_0:isInProgressOtherMissionGroup(var_44_3)
	end

	return var_44_0
end

var_0_0.instance = var_0_0.New()

return var_0_0

module("modules.logic.jump.controller.JumpControllerCanJumpFunc", package.seeall)

local var_0_0 = JumpController

var_0_0.DefaultToastId = 0
var_0_0.DefaultToastParam = nil

function var_0_0.checkModuleIsOpen(arg_1_0, arg_1_1)
	if not OpenModel.instance:isFunctionUnlock(arg_1_1) then
		local var_1_0, var_1_1 = OpenHelper.getToastIdAndParam(arg_1_1)

		return false, var_1_0, var_1_1
	end

	return arg_1_0:defaultCanJump()
end

function var_0_0.defaultCanJump(arg_2_0, arg_2_1)
	return true, var_0_0.DefaultToastId, var_0_0.DefaultToastParam
end

function var_0_0.canJumpToStoreView(arg_3_0, arg_3_1)
	local var_3_0, var_3_1, var_3_2 = arg_3_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Bank)

	if not var_3_0 then
		return var_3_0, var_3_1, var_3_2
	end

	local var_3_3 = string.splitToNumber(arg_3_1, "#")
	local var_3_4 = var_3_3[2]

	if StoreModel.instance:isTabOpen(var_3_4) then
		local var_3_5 = var_3_3[3]
		local var_3_6 = var_3_3[4]

		if var_3_5 then
			local var_3_7

			if not string.nilorempty(var_3_6) then
				var_3_7 = StoreConfig.instance:getChargeGoodsConfig(var_3_5)
			else
				var_3_7 = StoreConfig.instance:getGoodsConfig(var_3_5)
			end

			local var_3_8 = var_3_7.onlineTime
			local var_3_9 = var_3_7.offlineTime
			local var_3_10 = ServerTime.now()
			local var_3_11 = string.nilorempty(var_3_8) and var_3_10 or TimeUtil.stringToTimestamp(var_3_8)
			local var_3_12 = string.nilorempty(var_3_9) and var_3_10 or TimeUtil.stringToTimestamp(var_3_9)

			if var_3_7.isOnline and var_3_11 <= var_3_10 and var_3_10 <= var_3_12 then
				return arg_3_0:defaultCanJump(arg_3_1)
			else
				return false, ToastEnum.ActivityWeekWalkDeepShowView, var_0_0.DefaultToastParam
			end
		else
			return arg_3_0:defaultCanJump(arg_3_1)
		end
	else
		return false, ToastEnum.NotOpenStore, var_0_0.DefaultToastParam
	end
end

function var_0_0.canJumpToSummonView(arg_4_0, arg_4_1)
	return arg_4_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Summon)
end

function var_0_0.canJumpToDungeonViewWithType(arg_5_0, arg_5_1)
	local var_5_0 = string.splitToNumber(arg_5_1, "#")[2] or JumpEnum.DungeonChapterType.Story

	if not DungeonController.instance:canJumpDungeonType(var_5_0) then
		return false, ToastEnum.DungeonIsLock, var_0_0.DefaultToastParam
	end

	return arg_5_0:defaultCanJump(arg_5_1)
end

function var_0_0.canJumpToDungeonViewWithChapter(arg_6_0, arg_6_1)
	local var_6_0 = string.splitToNumber(arg_6_1, "#")
	local var_6_1 = var_6_0[#var_6_0]

	if not DungeonController.instance:canJumpDungeonChapter(var_6_1) then
		return false, ToastEnum.DungeonIsLock, var_0_0.DefaultToastParam
	end

	return arg_6_0:defaultCanJump(arg_6_1)
end

function var_0_0.canJumpToDungeonViewWithEpisode(arg_7_0, arg_7_1)
	local var_7_0 = string.splitToNumber(arg_7_1, "#")
	local var_7_1 = var_7_0[#var_7_0]
	local var_7_2 = DungeonConfig.instance:getEpisodeCO(var_7_1)
	local var_7_3 = DungeonConfig.instance:getChapterCO(var_7_2 and var_7_2.chapterId)

	if var_7_3 and var_7_3.type == DungeonEnum.ChapterType.Hard then
		local var_7_4 = DungeonConfig.instance:getEpisodeCO(var_7_2.preEpisode)

		if not DungeonModel.instance:isOpenHardDungeon(var_7_4.chapterId, var_7_4.id) then
			return false, ToastEnum.WarmUpGotoOrder, var_0_0.DefaultToastParam
		end
	end

	local var_7_5 = DungeonController.instance:canJumpDungeonChapter(var_7_2 and var_7_2.chapterId)

	if var_7_2 and var_7_5 and DungeonModel.instance:isUnlock(var_7_2) and DungeonModel.instance:isFinishElementList(var_7_2) then
		return arg_7_0:defaultCanJump(arg_7_1)
	else
		return false, ToastEnum.WarmUpGotoOrder, var_0_0.DefaultToastParam
	end
end

function var_0_0.canJumpToCharacterBackpackViewWithCharacter(arg_8_0, arg_8_1)
	return arg_8_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Role)
end

function var_0_0.canJumpToCharacterBackpackViewWithEquip(arg_9_0, arg_9_1)
	return arg_9_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Equip)
end

function var_0_0.canJumpToCharacterBackpackView(arg_10_0, arg_10_1)
	return arg_10_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Storage)
end

function var_0_0.canJumpToPlayerClothView(arg_11_0, arg_11_1)
	return arg_11_0:checkModuleIsOpen(OpenEnum.UnlockFunc.LeadRoleSkill)
end

function var_0_0.canJumpToTaskView(arg_12_0, arg_12_1)
	return arg_12_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Task)
end

function var_0_0.canJumpToRoomView(arg_13_0, arg_13_1)
	return arg_13_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Room)
end

function var_0_0.canJumpToRoomProductLineView(arg_14_0, arg_14_1)
	local var_14_0, var_14_1, var_14_2 = arg_14_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Room)

	if not var_14_0 then
		return var_14_0, var_14_1, var_14_2
	end

	if not RoomProductionHelper.hasUnlockLine(RoomProductLineEnum.ProductItemType.Change) then
		return false, ToastEnum.MaterialItemLockOnClick2
	end

	return true
end

function var_0_0.canJumpToEquipView(arg_15_0, arg_15_1)
	return arg_15_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Equip)
end

function var_0_0.canJumpToHandbookView(arg_16_0, arg_16_1)
	return arg_16_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Handbook)
end

function var_0_0.canJumpToSocialView(arg_17_0, arg_17_1)
	return arg_17_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Friend)
end

function var_0_0.canJumpToNoticeView(arg_18_0, arg_18_1)
	if VersionValidator.instance:isInReviewing() then
		arg_18_0:defaultCanJump(arg_18_1)
	end

	return arg_18_0:checkModuleIsOpen(OpenEnum.UnlockFunc.Notice)
end

function var_0_0.canJumpToActivityView(arg_19_0, arg_19_1)
	local var_19_0 = string.splitToNumber(arg_19_1, "#")
	local var_19_1 = var_19_0[2]
	local var_19_2, var_19_3, var_19_4 = ActivityHelper.getActivityStatusAndToast(var_19_1)

	if var_19_2 == ActivityEnum.ActivityStatus.Normal then
		local var_19_5 = var_0_0.CanJumpActFunc[var_19_1]

		if var_19_5 then
			return var_19_5(arg_19_0, var_19_0)
		end

		local var_19_6 = ActivityHelper.getActivityVersion(var_19_1)
		local var_19_7 = _G[string.format("VersionActivity%sCanJumpFunc", var_19_6)]

		if var_19_7 and var_19_7["canJumpTo" .. var_19_1] then
			return var_19_7["canJumpTo" .. var_19_1](arg_19_0, var_19_0)
		end

		return arg_19_0:defaultCanJump(arg_19_1)
	end

	return false, var_19_3, var_19_4
end

function var_0_0.canJumpToLeiMiTeBeiDungeonView(arg_20_0, arg_20_1)
	if not ReactivityModel.instance:isReactivity(VersionActivityEnum.ActivityId.Act113) then
		local var_20_0, var_20_1, var_20_2 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act105)

		if var_20_0 ~= ActivityEnum.ActivityStatus.Normal then
			return false, var_20_1, var_20_2
		end
	else
		local var_20_3, var_20_4, var_20_5 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act113)

		if var_20_3 ~= ActivityEnum.ActivityStatus.Normal then
			return false, var_20_4, var_20_5
		end
	end

	local var_20_6 = string.splitToNumber(arg_20_1, "#")[2]
	local var_20_7 = DungeonConfig.instance:getEpisodeCO(var_20_6)

	if not var_20_7 then
		logError("not found episode : " .. arg_20_1)

		return false, ToastEnum.EpisodeNotExist, var_0_0.DefaultToastParam
	end

	local var_20_8 = ActivityConfig.instance:getActivityDungeonConfig(VersionActivityEnum.ActivityId.Act113)

	if var_20_8 and var_20_8.hardChapterId and var_20_7.chapterId == var_20_8.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivityEnum.ActivityId.Act113) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, var_0_0.DefaultToastParam
	end

	if not DungeonModel.instance:getEpisodeInfo(var_20_6) then
		return false, ToastEnum.WarmUpGotoOrder, var_0_0.DefaultToastParam
	end

	return arg_20_0:defaultCanJump(arg_20_1)
end

function var_0_0.canJumpToPushBox(arg_21_0, arg_21_1)
	local var_21_0, var_21_1, var_21_2 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act105)

	if var_21_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_21_1, var_21_2
	end

	local var_21_3, var_21_4, var_21_5 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act111)
	local var_21_6 = var_21_5
	local var_21_7 = var_21_4

	if var_21_3 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_21_7, var_21_6
	end

	return arg_21_0:defaultCanJump(arg_21_1)
end

function var_0_0.canJump2Activity1_1Dungeon(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1[3]

	if var_22_0 and var_22_0 == JumpEnum.LeiMiTeBeiSubJumpId.DungeonHardMode then
		return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(arg_22_1[2])
	end

	return arg_22_0:defaultCanJump()
end

function var_0_0.canJump2Activity1_2Dungeon(arg_23_0, arg_23_1)
	if arg_23_1[3] == JumpEnum.Activity1_2DungeonJump.Hard then
		local var_23_0, var_23_1, var_23_2 = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen()

		if not var_23_0 then
			return false, var_23_2 == 1 and ToastEnum.Acticity1_2HardLock1 or ToastEnum.Acticity1_2HardLock2
		end
	elseif arg_23_1[3] == JumpEnum.Activity1_2DungeonJump.Jump2Dungeon then
		local var_23_3 = arg_23_1[4]
		local var_23_4 = DungeonConfig.instance:getEpisodeCO(var_23_3)

		if var_23_4 then
			if var_23_4.chapterId == VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard then
				local var_23_5, var_23_6, var_23_7 = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen()

				if not var_23_5 then
					return false, var_23_7 == 1 and ToastEnum.Acticity1_2HardLock1 or ToastEnum.Acticity1_2HardLock2
				elseif not DungeonModel.instance:isUnlock(var_23_4) then
					return false, ToastEnum.DungeonIsLockNormal
				end
			elseif not DungeonModel.instance:isUnlock(var_23_4) then
				return false, ToastEnum.DungeonIsLockNormal
			end
		end
	end

	return arg_23_0:defaultCanJump()
end

function var_0_0.canJump2Activity1_3Dungeon(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1[3]

	if var_24_0 and var_24_0 == JumpEnum.Activity1_3DungeonJump.Hard then
		return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(arg_24_1[2])
	end

	if var_24_0 == JumpEnum.Activity1_3DungeonJump.Daily then
		-- block empty
	elseif var_24_0 == JumpEnum.Activity1_3DungeonJump.Astrology then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30102) then
			local var_24_1, var_24_2 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Act_30102)

			return false, var_24_1
		end
	elseif var_24_0 == JumpEnum.Activity1_3DungeonJump.Buff and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30101) then
		local var_24_3, var_24_4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Act_30101)

		return false, var_24_3
	end

	return arg_24_0:defaultCanJump()
end

function var_0_0.canJumpToAct1_3DungeonView(arg_25_0, arg_25_1)
	local var_25_0, var_25_1, var_25_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.ReactivityStore)

	if var_25_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_25_1, var_25_2
	end

	local var_25_3 = string.splitToNumber(arg_25_1, "#")[2]
	local var_25_4 = DungeonConfig.instance:getEpisodeCO(var_25_3)

	if not var_25_4 then
		logError("not found episode : " .. arg_25_1)

		return false, ToastEnum.EpisodeNotExist, var_0_0.DefaultToastParam
	end

	local var_25_5 = ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_3Enum.ActivityId.Dungeon)

	if var_25_5 and var_25_5.hardChapterId and var_25_4.chapterId == var_25_5.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_3Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, var_0_0.DefaultToastParam
	end

	if not DungeonModel.instance:getEpisodeInfo(var_25_3) then
		return false, ToastEnum.WarmUpGotoOrder, var_0_0.DefaultToastParam
	end

	return arg_25_0:defaultCanJump(arg_25_1)
end

function var_0_0.canJumpToAct1_3Act306(arg_26_0, arg_26_1)
	local var_26_0, var_26_1, var_26_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.Act306)

	if var_26_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_26_1, var_26_2
	end

	return arg_26_0:defaultCanJump(arg_26_1)
end

function var_0_0.canJumpToAct1_3Act305(arg_27_0, arg_27_1)
	local var_27_0, var_27_1, var_27_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.Act305)

	if var_27_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_27_1, var_27_2
	end

	return arg_27_0:defaultCanJump(arg_27_1)
end

function var_0_0.canJumpToTurnback(arg_28_0, arg_28_1)
	if not TurnbackModel.instance:isNewType() and not TurnbackModel.instance:canShowTurnbackPop() then
		return false, ToastEnum.ActivityNotInOpenTime
	end

	return arg_28_0:defaultCanJump(arg_28_1)
end

function var_0_0.canJumpToAchievement(arg_29_0, arg_29_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		local var_29_0, var_29_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement)

		return false, var_29_0, var_29_1
	end

	return arg_29_0:defaultCanJump(arg_29_1)
end

function var_0_0.activateCanJumpFuncController()
	return
end

function var_0_0.canJumpToBossRush(arg_31_0, arg_31_1)
	local var_31_0 = string.splitToNumber(arg_31_1, "#")
	local var_31_1 = var_31_0[2]
	local var_31_2 = var_31_0[3] or 1

	if not BossRushModel.instance:isActOnLine() then
		return false, ToastEnum.ActivityNotInOpenTime
	end

	if var_31_1 then
		if not BossRushModel.instance:isBossOnline(var_31_1) then
			return false, ToastEnum.V1a4_BossRushBossLockTip
		end

		if not BossRushModel.instance:isBossLayerOpen(var_31_1, var_31_2) then
			return false, ToastEnum.V1a4_BossRushBossLockTip
		end
	end

	return arg_31_0:defaultCanJump(arg_31_1)
end

function var_0_0.canJumpToSeasonMainView(arg_32_0, arg_32_1)
	local var_32_0 = string.splitToNumber(arg_32_1, "#")

	if (var_32_0 and var_32_0[2]) == Activity104Enum.JumpId.Trail then
		local var_32_1 = var_32_0[3]
		local var_32_2 = Activity104Model.instance:getCurSeasonId()
		local var_32_3 = SeasonConfig.instance:getTrialConfig(var_32_2, var_32_1)
		local var_32_4 = Activity104Model.instance:getAct104CurLayer(var_32_2)

		if var_32_3 and var_32_4 <= var_32_3.unlockLayer then
			return false, ToastEnum.SeasonTrialLockTip, {
				GameUtil.getNum2Chinese(var_32_3.unlockLayer)
			}
		end
	end

	return arg_32_0:defaultCanJump(arg_32_1)
end

function var_0_0.canJumpToRoomFishing(arg_33_0, arg_33_1)
	if FishingModel.instance:isUnlockRoomFishing() then
		return arg_33_0:defaultCanJump(arg_33_1)
	else
		return false, ToastEnum.JumpSignView, var_0_0.DefaultToastParam
	end
end

function var_0_0.canJumpToAct1_5DungeonView(arg_34_0, arg_34_1)
	local var_34_0, var_34_1, var_34_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_1Enum.ActivityId.EnterView)

	if var_34_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_34_1, var_34_2
	end

	local var_34_3 = string.splitToNumber(arg_34_1, "#")[2]
	local var_34_4 = DungeonConfig.instance:getEpisodeCO(var_34_3)

	if not var_34_4 then
		logError("not found episode : " .. arg_34_1)

		return false, ToastEnum.EpisodeNotExist, var_0_0.DefaultToastParam
	end

	local var_34_5 = ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_5Enum.ActivityId.Dungeon)

	if var_34_5 and var_34_5.hardChapterId and var_34_4.chapterId == var_34_5.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_5Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, var_0_0.DefaultToastParam
	end

	if not DungeonModel.instance:getEpisodeInfo(var_34_3) then
		return false, ToastEnum.WarmUpGotoOrder, var_0_0.DefaultToastParam
	end

	return arg_34_0:defaultCanJump(arg_34_1)
end

function var_0_0.canJumpToActivity142(arg_35_0, arg_35_1)
	local var_35_0, var_35_1, var_35_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_5Enum.ActivityId.Activity142)

	if var_35_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_35_1, var_35_2
	end

	return arg_35_0:defaultCanJump(arg_35_1)
end

function var_0_0.canJumpToAct1_6DungeonView(arg_36_0, arg_36_1)
	local var_36_0, var_36_1, var_36_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_5Enum.ActivityId.EnterView)

	if var_36_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_36_1, var_36_2
	end

	local var_36_3 = string.splitToNumber(arg_36_1, "#")[2]
	local var_36_4 = DungeonConfig.instance:getEpisodeCO(var_36_3)

	if not var_36_4 then
		logError("not found episode : " .. arg_36_1)

		return false, ToastEnum.EpisodeNotExist, var_0_0.DefaultToastParam
	end

	local var_36_5 = ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_6Enum.ActivityId.Dungeon)

	if var_36_5 and var_36_5.hardChapterId and var_36_4.chapterId == var_36_5.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_6Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, var_0_0.DefaultToastParam
	end

	if not DungeonModel.instance:getEpisodeInfo(var_36_3) then
		return false, ToastEnum.WarmUpGotoOrder, var_0_0.DefaultToastParam
	end

	return arg_36_0:defaultCanJump(arg_36_1)
end

function var_0_0.canJumpToSeason123(arg_37_0, arg_37_1)
	local var_37_0 = Season123Model.instance:getCurSeasonId()

	if var_37_0 then
		local var_37_1 = ActivityModel.instance:getActMO(var_37_0)

		if not var_37_1 or not var_37_1:isOpen() then
			return false, ToastEnum.ActivityNotOpen, var_0_0.DefaultToastParam
		end
	else
		return false, ToastEnum.ActivityNotOpen, var_0_0.DefaultToastParam
	end

	return arg_37_0:defaultCanJump(arg_37_1)
end

function var_0_0.canJumpToVersionEnterView(arg_38_0, arg_38_1)
	local var_38_0 = string.splitToNumber(arg_38_1, "#")[2]

	if var_38_0 then
		local var_38_1 = ActivityModel.instance:getActMO(var_38_0)

		if not var_38_1 or not var_38_1:isOpen() then
			return false, ToastEnum.ActivityNotOpen, var_0_0.DefaultToastParam
		end
	else
		return false, ToastEnum.ActivityNotOpen, var_0_0.DefaultToastParam
	end

	return arg_38_0:defaultCanJump(arg_38_1)
end

function var_0_0.canJumpToRougeMainView(arg_39_0, arg_39_1)
	local var_39_0 = true
	local var_39_1
	local var_39_2

	if not RougeOutsideModel.instance:isUnlock() then
		var_39_0 = false

		local var_39_3 = RougeOutsideModel.instance:openUnlockId()

		var_39_1, var_39_2 = OpenHelper.getToastIdAndParam(var_39_3)
	end

	return var_39_0, var_39_1, var_39_2
end

function var_0_0.canJumpToRougeRewardView(arg_40_0, arg_40_1)
	local var_40_0 = true
	local var_40_1
	local var_40_2

	if not RougeOutsideModel.instance:isUnlock() then
		var_40_0 = false

		local var_40_3 = RougeOutsideModel.instance:openUnlockId()

		var_40_1, var_40_2 = OpenHelper.getToastIdAndParam(var_40_3)
	else
		local var_40_4 = string.splitToNumber(arg_40_1, "#")[3]

		if not RougeRewardModel.instance:isStageOpen(var_40_4) then
			var_40_0 = false
			var_40_1 = ToastEnum.RougeRewardStageLock
		end
	end

	return var_40_0, var_40_1, var_40_2
end

function var_0_0.canJumpToTower(arg_41_0, arg_41_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		local var_41_0, var_41_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Tower)

		return false, var_41_0, var_41_1
	end

	local var_41_2 = string.splitToNumber(arg_41_1, "#")[2]

	if var_41_2 == TowerEnum.TowerType.Boss then
		local var_41_3 = TowerController.instance:isBossTowerOpen()
		local var_41_4 = TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss)

		if not var_41_3 or not var_41_4 then
			return false, ToastEnum.TowerNotOpen
		end
	elseif var_41_2 == TowerEnum.TowerType.Limited then
		local var_41_5 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
		local var_41_6 = TowerController.instance:isTimeLimitTowerOpen()

		if not var_41_5 or not var_41_6 then
			return false, ToastEnum.TowerNotOpen
		end
	end

	return arg_41_0:defaultCanJump(arg_41_1)
end

function var_0_0.canJumpToOdyssey(arg_42_0, arg_42_1)
	local var_42_0 = VersionActivity2_9Enum.ActivityId.Dungeon2

	if not VersionActivityEnterHelper.checkCanOpen(var_42_0) then
		return false, ToastEnum.ActivityNotOpen
	end

	local var_42_1 = string.splitToNumber(arg_42_1, "#")
	local var_42_2 = var_42_1[2]

	if var_42_2 == OdysseyEnum.JumpType.JumpToElementAndOpen then
		if not OdysseyDungeonModel.instance:getElementMo(var_42_1[3]) then
			return false, ToastEnum.OdysseyElementLock
		end
	elseif var_42_2 == OdysseyEnum.JumpType.JumpToReligion then
		local var_42_3 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ReligionUnlock)

		if not OdysseyDungeonModel.instance:checkConditionCanUnlock(var_42_3.value) then
			return false, ToastEnum.OdysseyReligionLock
		end
	elseif var_42_2 == OdysseyEnum.JumpType.JumpToMyth and not OdysseyDungeonModel.instance:checkHasFightTypeElement(OdysseyEnum.FightType.Myth) then
		return false, ToastEnum.OdysseyMythViewLock
	end

	return arg_42_0:defaultCanJump(arg_42_1)
end

function var_0_0.canJumpToAssassinLibraryView(arg_43_0, arg_43_1)
	local var_43_0 = string.splitToNumber(arg_43_1, "#")[2]
	local var_43_1, var_43_2, var_43_3 = ActivityHelper.getActivityStatusAndToast(var_43_0)

	if not (var_43_1 == ActivityEnum.ActivityStatus.Normal or var_43_1 == ActivityEnum.ActivityStatus.Expired) then
		return false, var_43_2, var_43_3
	end

	return true
end

var_0_0.JumpViewToCanJumpFunc = {
	[JumpEnum.JumpView.StoreView] = var_0_0.canJumpToStoreView,
	[JumpEnum.JumpView.SummonView] = var_0_0.canJumpToSummonView,
	[JumpEnum.JumpView.DungeonViewWithType] = var_0_0.canJumpToDungeonViewWithType,
	[JumpEnum.JumpView.DungeonViewWithChapter] = var_0_0.canJumpToDungeonViewWithChapter,
	[JumpEnum.JumpView.DungeonViewWithEpisode] = var_0_0.canJumpToDungeonViewWithEpisode,
	[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = var_0_0.canJumpToCharacterBackpackViewWithCharacter,
	[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = var_0_0.canJumpToCharacterBackpackViewWithEquip,
	[JumpEnum.JumpView.BackpackView] = var_0_0.canJumpToCharacterBackpackView,
	[JumpEnum.JumpView.PlayerClothView] = var_0_0.canJumpToPlayerClothView,
	[JumpEnum.JumpView.TaskView] = var_0_0.canJumpToTaskView,
	[JumpEnum.JumpView.RoomView] = var_0_0.canJumpToRoomView,
	[JumpEnum.JumpView.RoomProductLineView] = var_0_0.canJumpToRoomProductLineView,
	[JumpEnum.JumpView.EquipView] = var_0_0.canJumpToEquipView,
	[JumpEnum.JumpView.HandbookView] = var_0_0.canJumpToHandbookView,
	[JumpEnum.JumpView.SocialView] = var_0_0.canJumpToSocialView,
	[JumpEnum.JumpView.NoticeView] = var_0_0.canJumpToNoticeView,
	[JumpEnum.JumpView.ActivityView] = var_0_0.canJumpToActivityView,
	[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = var_0_0.canJumpToLeiMiTeBeiDungeonView,
	[JumpEnum.JumpView.Act1_3DungeonView] = var_0_0.canJumpToAct1_3DungeonView,
	[JumpEnum.JumpView.PushBox] = var_0_0.canJumpToPushBox,
	[JumpEnum.JumpView.Turnback] = var_0_0.canJumpToTurnback,
	[JumpEnum.JumpView.Achievement] = var_0_0.canJumpToAchievement,
	[JumpEnum.JumpView.BossRush] = var_0_0.canJumpToBossRush,
	[JumpEnum.JumpView.SeasonMainView] = var_0_0.canJumpToSeasonMainView,
	[JumpEnum.JumpView.RoomFishing] = var_0_0.canJumpToRoomFishing,
	[JumpEnum.JumpView.Tower] = var_0_0.canJumpToTower,
	[JumpEnum.JumpView.Odyssey] = var_0_0.canJumpToOdyssey,
	[JumpEnum.JumpView.AssassinLibraryView] = var_0_0.canJumpToAssassinLibraryView,
	[JumpEnum.JumpView.Challenge] = Act183JumpController.canJumpToAct183,
	[JumpEnum.JumpView.V1a5Dungeon] = var_0_0.canJumpToAct1_5DungeonView,
	[JumpEnum.JumpView.V1a6Dungeon] = var_0_0.canJumpToAct1_6DungeonView,
	[JumpEnum.JumpView.Season123] = var_0_0.canJumpToSeason123,
	[JumpEnum.JumpView.VersionEnterView] = var_0_0.canJumpToVersionEnterView,
	[JumpEnum.JumpView.RougeRewardView] = var_0_0.canJumpToRougeRewardView,
	[JumpEnum.JumpView.RougeMainView] = var_0_0.canJumpToRougeMainView
}
var_0_0.CanJumpActFunc = {
	[JumpEnum.ActIdEnum.Act113] = var_0_0.canJump2Activity1_1Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Dungeon] = var_0_0.canJump2Activity1_3Dungeon,
	[JumpEnum.ActIdEnum.Act1_2Dungeon] = var_0_0.canJump2Activity1_2Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Act305] = var_0_0.canJumpToAct1_3Act305,
	[JumpEnum.ActIdEnum.Act1_3Act306] = var_0_0.canJumpToAct1_3Act306,
	[JumpEnum.ActIdEnum.Activity142] = var_0_0.canJumpToActivity142
}

return var_0_0

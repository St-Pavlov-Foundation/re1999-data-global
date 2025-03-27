module("modules.logic.jump.controller.JumpControllerCanJumpFunc", package.seeall)

slot0 = JumpController
slot0.DefaultToastId = 0
slot0.DefaultToastParam = nil

function slot0.checkModuleIsOpen(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(slot1) then
		slot2, slot3 = OpenHelper.getToastIdAndParam(slot1)

		return false, slot2, slot3
	end

	return slot0:defaultCanJump()
end

function slot0.defaultCanJump(slot0, slot1)
	return true, uv0.DefaultToastId, uv0.DefaultToastParam
end

function slot0.canJumpToStoreView(slot0, slot1)
	slot2, slot3, slot4 = slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Bank)

	if not slot2 then
		return slot2, slot3, slot4
	end

	if StoreModel.instance:isTabOpen(string.splitToNumber(slot1, "#")[2]) then
		if slot5[3] then
			slot9 = nil
			slot9 = (string.nilorempty(slot5[4]) or StoreConfig.instance:getChargeGoodsConfig(slot7)) and StoreConfig.instance:getGoodsConfig(slot7)
			slot11 = slot9.offlineTime
			slot12 = ServerTime.now()

			if slot9.isOnline and (string.nilorempty(slot9.onlineTime) and slot12 or TimeUtil.stringToTimestamp(slot10)) <= slot12 and slot12 <= (string.nilorempty(slot11) and slot12 or TimeUtil.stringToTimestamp(slot11)) then
				return slot0:defaultCanJump(slot1)
			else
				return false, ToastEnum.ActivityWeekWalkDeepShowView, uv0.DefaultToastParam
			end
		else
			return slot0:defaultCanJump(slot1)
		end
	else
		return false, ToastEnum.NotOpenStore, uv0.DefaultToastParam
	end
end

function slot0.canJumpToSummonView(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Summon)
end

function slot0.canJumpToDungeonViewWithType(slot0, slot1)
	if not DungeonController.instance:canJumpDungeonType(string.splitToNumber(slot1, "#")[2] or JumpEnum.DungeonChapterType.Story) then
		return false, ToastEnum.DungeonIsLock, uv0.DefaultToastParam
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToDungeonViewWithChapter(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	if not DungeonController.instance:canJumpDungeonChapter(slot2[#slot2]) then
		return false, ToastEnum.DungeonIsLock, uv0.DefaultToastParam
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToDungeonViewWithEpisode(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot2[#slot2]) and slot4.chapterId) and slot5.type == DungeonEnum.ChapterType.Hard then
		slot6 = DungeonConfig.instance:getEpisodeCO(slot4.preEpisode)

		if not DungeonModel.instance:isOpenHardDungeon(slot6.chapterId, slot6.id) then
			return false, ToastEnum.WarmUpGotoOrder, uv0.DefaultToastParam
		end
	end

	if slot4 and DungeonController.instance:canJumpDungeonChapter(slot4 and slot4.chapterId) and DungeonModel.instance:isUnlock(slot4) and DungeonModel.instance:isFinishElementList(slot4) then
		return slot0:defaultCanJump(slot1)
	else
		return false, ToastEnum.WarmUpGotoOrder, uv0.DefaultToastParam
	end
end

function slot0.canJumpToCharacterBackpackViewWithCharacter(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Role)
end

function slot0.canJumpToCharacterBackpackViewWithEquip(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Equip)
end

function slot0.canJumpToCharacterBackpackView(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Storage)
end

function slot0.canJumpToPlayerClothView(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.LeadRoleSkill)
end

function slot0.canJumpToTaskView(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Task)
end

function slot0.canJumpToRoomView(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Room)
end

function slot0.canJumpToRoomProductLineView(slot0, slot1)
	slot2, slot3, slot4 = slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Room)

	if not slot2 then
		return slot2, slot3, slot4
	end

	if not RoomProductionHelper.hasUnlockLine(RoomProductLineEnum.ProductItemType.Change) then
		return false, ToastEnum.MaterialItemLockOnClick2
	end

	return true
end

function slot0.canJumpToEquipView(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Equip)
end

function slot0.canJumpToHandbookView(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Handbook)
end

function slot0.canJumpToSocialView(slot0, slot1)
	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Friend)
end

function slot0.canJumpToNoticeView(slot0, slot1)
	if VersionValidator.instance:isInReviewing() then
		slot0:defaultCanJump(slot1)
	end

	return slot0:checkModuleIsOpen(OpenEnum.UnlockFunc.Notice)
end

function slot0.canJumpToActivityView(slot0, slot1)
	slot4, slot5, slot6 = ActivityHelper.getActivityStatusAndToast(string.splitToNumber(slot1, "#")[2])

	if slot4 == ActivityEnum.ActivityStatus.Normal then
		if uv0.CanJumpActFunc[slot3] then
			return slot7(slot0, slot2)
		end

		if _G[string.format("VersionActivity%sCanJumpFunc", ActivityHelper.getActivityVersion(slot3))] and slot9["canJumpTo" .. slot3] then
			return slot9["canJumpTo" .. slot3](slot0, slot2)
		end

		return slot0:defaultCanJump(slot1)
	end

	return false, slot5, slot6
end

function slot0.canJumpToLeiMiTeBeiDungeonView(slot0, slot1)
	if not ReactivityModel.instance:isReactivity(VersionActivityEnum.ActivityId.Act113) then
		slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act105)

		if slot3 ~= ActivityEnum.ActivityStatus.Normal then
			return false, slot4, slot5
		end
	else
		slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act113)

		if slot3 ~= ActivityEnum.ActivityStatus.Normal then
			return false, slot4, slot5
		end
	end

	if not DungeonConfig.instance:getEpisodeCO(string.splitToNumber(slot1, "#")[2]) then
		logError("not found episode : " .. slot1)

		return false, ToastEnum.EpisodeNotExist, uv0.DefaultToastParam
	end

	if ActivityConfig.instance:getActivityDungeonConfig(VersionActivityEnum.ActivityId.Act113) and slot6.hardChapterId and slot5.chapterId == slot6.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivityEnum.ActivityId.Act113) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, uv0.DefaultToastParam
	end

	if not DungeonModel.instance:getEpisodeInfo(slot4) then
		return false, ToastEnum.WarmUpGotoOrder, uv0.DefaultToastParam
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToPushBox(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act105)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot5, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act111)

	if slot5 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJump2Activity1_1Dungeon(slot0, slot1)
	if slot1[3] and slot2 == JumpEnum.LeiMiTeBeiSubJumpId.DungeonHardMode then
		return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(slot1[2])
	end

	return slot0:defaultCanJump()
end

function slot0.canJump2Activity1_2Dungeon(slot0, slot1)
	if slot1[3] == JumpEnum.Activity1_2DungeonJump.Hard then
		slot2, slot3, slot4 = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen()

		if not slot2 then
			return false, slot4 == 1 and ToastEnum.Acticity1_2HardLock1 or ToastEnum.Acticity1_2HardLock2
		end
	elseif slot1[3] == JumpEnum.Activity1_2DungeonJump.Jump2Dungeon and DungeonConfig.instance:getEpisodeCO(slot1[4]) then
		if slot3.chapterId == VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard then
			slot4, slot5, slot6 = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen()

			if not slot4 then
				return false, slot6 == 1 and ToastEnum.Acticity1_2HardLock1 or ToastEnum.Acticity1_2HardLock2
			elseif not DungeonModel.instance:isUnlock(slot3) then
				return false, ToastEnum.DungeonIsLockNormal
			end
		elseif not DungeonModel.instance:isUnlock(slot3) then
			return false, ToastEnum.DungeonIsLockNormal
		end
	end

	return slot0:defaultCanJump()
end

function slot0.canJump2Activity1_3Dungeon(slot0, slot1)
	if slot1[3] and slot2 == JumpEnum.Activity1_3DungeonJump.Hard then
		return VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapterAndGetToast(slot1[2])
	end

	if slot2 == JumpEnum.Activity1_3DungeonJump.Daily then
		-- Nothing
	elseif slot2 == JumpEnum.Activity1_3DungeonJump.Astrology then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30102) then
			slot3, slot4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Act_30102)

			return false, slot3
		end
	elseif slot2 == JumpEnum.Activity1_3DungeonJump.Buff and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30101) then
		slot3, slot4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Act_30101)

		return false, slot3
	end

	return slot0:defaultCanJump()
end

function slot0.canJumpToAct1_3DungeonView(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_8Enum.ActivityId.ReactivityStore)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	if not DungeonConfig.instance:getEpisodeCO(string.splitToNumber(slot1, "#")[2]) then
		logError("not found episode : " .. slot1)

		return false, ToastEnum.EpisodeNotExist, uv0.DefaultToastParam
	end

	if ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_3Enum.ActivityId.Dungeon) and slot8.hardChapterId and slot7.chapterId == slot8.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_3Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, uv0.DefaultToastParam
	end

	if not DungeonModel.instance:getEpisodeInfo(slot6) then
		return false, ToastEnum.WarmUpGotoOrder, uv0.DefaultToastParam
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToAct1_3Act306(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.Act306)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToAct1_3Act305(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.Act305)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToTurnback(slot0, slot1)
	if not TurnbackModel.instance:isNewType() and not TurnbackModel.instance:canShowTurnbackPop() then
		return false, ToastEnum.ActivityNotInOpenTime
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToAchievement(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		slot2, slot3 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement)

		return false, slot2, slot3
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.activateCanJumpFuncController()
end

function slot0.canJumpToBossRush(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")
	slot3 = slot2[2]
	slot4 = slot2[3] or 1

	if not BossRushModel.instance:isActOnLine() then
		return false, ToastEnum.ActivityNotInOpenTime
	end

	if slot3 then
		if not BossRushModel.instance:isBossOnline(slot3) then
			return false, ToastEnum.V1a4_BossRushBossLockTip
		end

		if not BossRushModel.instance:isBossLayerOpen(slot3, slot4) then
			return false, ToastEnum.V1a4_BossRushBossLockTip
		end
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToSeasonMainView(slot0, slot1)
	if (string.splitToNumber(slot1, "#") and slot2[2]) == Activity104Enum.JumpId.Trail then
		slot5 = Activity104Model.instance:getCurSeasonId()

		if SeasonConfig.instance:getTrialConfig(slot5, slot2[3]) and Activity104Model.instance:getAct104CurLayer(slot5) <= slot6.unlockLayer then
			return false, ToastEnum.SeasonTrialLockTip, {
				GameUtil.getNum2Chinese(slot6.unlockLayer)
			}
		end
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToAct1_5DungeonView(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_1Enum.ActivityId.EnterView)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	if not DungeonConfig.instance:getEpisodeCO(string.splitToNumber(slot1, "#")[2]) then
		logError("not found episode : " .. slot1)

		return false, ToastEnum.EpisodeNotExist, uv0.DefaultToastParam
	end

	if ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_5Enum.ActivityId.Dungeon) and slot8.hardChapterId and slot7.chapterId == slot8.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_5Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, uv0.DefaultToastParam
	end

	if not DungeonModel.instance:getEpisodeInfo(slot6) then
		return false, ToastEnum.WarmUpGotoOrder, uv0.DefaultToastParam
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToActivity142(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_5Enum.ActivityId.Activity142)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToAct1_6DungeonView(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.EnterView)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	if not DungeonConfig.instance:getEpisodeCO(string.splitToNumber(slot1, "#")[2]) then
		logError("not found episode : " .. slot1)

		return false, ToastEnum.EpisodeNotExist, uv0.DefaultToastParam
	end

	if ActivityConfig.instance:getActivityDungeonConfig(VersionActivity1_6Enum.ActivityId.Dungeon) and slot8.hardChapterId and slot7.chapterId == slot8.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(VersionActivity1_6Enum.ActivityId.Dungeon) then
		return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, uv0.DefaultToastParam
	end

	if not DungeonModel.instance:getEpisodeInfo(slot6) then
		return false, ToastEnum.WarmUpGotoOrder, uv0.DefaultToastParam
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToSeason123(slot0, slot1)
	if Season123Model.instance:getCurSeasonId() then
		if not ActivityModel.instance:getActMO(slot2) or not slot3:isOpen() then
			return false, ToastEnum.ActivityNotOpen, uv0.DefaultToastParam
		end
	else
		return false, ToastEnum.ActivityNotOpen, uv0.DefaultToastParam
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToVersionEnterView(slot0, slot1)
	if string.splitToNumber(slot1, "#")[2] then
		if not ActivityModel.instance:getActMO(slot3) or not slot4:isOpen() then
			return false, ToastEnum.ActivityNotOpen, uv0.DefaultToastParam
		end
	else
		return false, ToastEnum.ActivityNotOpen, uv0.DefaultToastParam
	end

	return slot0:defaultCanJump(slot1)
end

function slot0.canJumpToRougeMainView(slot0, slot1)
	slot2 = true
	slot3, slot4 = nil

	if not RougeOutsideModel.instance:isUnlock() then
		slot2 = false
		slot3, slot4 = OpenHelper.getToastIdAndParam(RougeOutsideModel.instance:openUnlockId())
	end

	return slot2, slot3, slot4
end

function slot0.canJumpToRougeRewardView(slot0, slot1)
	slot2 = true
	slot3, slot4 = nil

	if not RougeOutsideModel.instance:isUnlock() then
		slot2 = false
		slot3, slot4 = OpenHelper.getToastIdAndParam(RougeOutsideModel.instance:openUnlockId())
	elseif not RougeRewardModel.instance:isStageOpen(string.splitToNumber(slot1, "#")[3]) then
		slot2 = false
		slot3 = ToastEnum.RougeRewardStageLock
	end

	return slot2, slot3, slot4
end

function slot0.canJumpToTower(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		slot2, slot3 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Tower)

		return false, slot2, slot3
	end

	if string.splitToNumber(slot1, "#")[2] == TowerEnum.TowerType.Boss then
		if not TowerController.instance:isBossTowerOpen() or not TowerModel.instance:checkHasOpenStateTower(TowerEnum.TowerType.Boss) then
			return false, ToastEnum.TowerNotOpen
		end
	elseif slot3 == TowerEnum.TowerType.Limited then
		if not TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() or not TowerController.instance:isTimeLimitTowerOpen() then
			return false, ToastEnum.TowerNotOpen
		end
	end

	return slot0:defaultCanJump(slot1)
end

slot0.JumpViewToCanJumpFunc = {
	[JumpEnum.JumpView.StoreView] = slot0.canJumpToStoreView,
	[JumpEnum.JumpView.SummonView] = slot0.canJumpToSummonView,
	[JumpEnum.JumpView.DungeonViewWithType] = slot0.canJumpToDungeonViewWithType,
	[JumpEnum.JumpView.DungeonViewWithChapter] = slot0.canJumpToDungeonViewWithChapter,
	[JumpEnum.JumpView.DungeonViewWithEpisode] = slot0.canJumpToDungeonViewWithEpisode,
	[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = slot0.canJumpToCharacterBackpackViewWithCharacter,
	[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = slot0.canJumpToCharacterBackpackViewWithEquip,
	[JumpEnum.JumpView.BackpackView] = slot0.canJumpToCharacterBackpackView,
	[JumpEnum.JumpView.PlayerClothView] = slot0.canJumpToPlayerClothView,
	[JumpEnum.JumpView.TaskView] = slot0.canJumpToTaskView,
	[JumpEnum.JumpView.RoomView] = slot0.canJumpToRoomView,
	[JumpEnum.JumpView.RoomProductLineView] = slot0.canJumpToRoomProductLineView,
	[JumpEnum.JumpView.EquipView] = slot0.canJumpToEquipView,
	[JumpEnum.JumpView.HandbookView] = slot0.canJumpToHandbookView,
	[JumpEnum.JumpView.SocialView] = slot0.canJumpToSocialView,
	[JumpEnum.JumpView.NoticeView] = slot0.canJumpToNoticeView,
	[JumpEnum.JumpView.ActivityView] = slot0.canJumpToActivityView,
	[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = slot0.canJumpToLeiMiTeBeiDungeonView,
	[JumpEnum.JumpView.Act1_3DungeonView] = slot0.canJumpToAct1_3DungeonView,
	[JumpEnum.JumpView.PushBox] = slot0.canJumpToPushBox,
	[JumpEnum.JumpView.Turnback] = slot0.canJumpToTurnback,
	[JumpEnum.JumpView.Achievement] = slot0.canJumpToAchievement,
	[JumpEnum.JumpView.BossRush] = slot0.canJumpToBossRush,
	[JumpEnum.JumpView.SeasonMainView] = slot0.canJumpToSeasonMainView,
	[JumpEnum.JumpView.Tower] = slot0.canJumpToTower,
	[JumpEnum.JumpView.V1a5Dungeon] = slot0.canJumpToAct1_5DungeonView,
	[JumpEnum.JumpView.V1a6Dungeon] = slot0.canJumpToAct1_6DungeonView,
	[JumpEnum.JumpView.Season123] = slot0.canJumpToSeason123,
	[JumpEnum.JumpView.VersionEnterView] = slot0.canJumpToVersionEnterView,
	[JumpEnum.JumpView.RougeRewardView] = slot0.canJumpToRougeRewardView,
	[JumpEnum.JumpView.RougeMainView] = slot0.canJumpToRougeMainView
}
slot0.CanJumpActFunc = {
	[JumpEnum.ActIdEnum.Act113] = slot0.canJump2Activity1_1Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Dungeon] = slot0.canJump2Activity1_3Dungeon,
	[JumpEnum.ActIdEnum.Act1_2Dungeon] = slot0.canJump2Activity1_2Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Act305] = slot0.canJumpToAct1_3Act305,
	[JumpEnum.ActIdEnum.Act1_3Act306] = slot0.canJumpToAct1_3Act306,
	[JumpEnum.ActIdEnum.Activity142] = slot0.canJumpToActivity142
}

return slot0

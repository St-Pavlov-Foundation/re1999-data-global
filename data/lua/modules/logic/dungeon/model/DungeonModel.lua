module("modules.logic.dungeon.model.DungeonModel", package.seeall)

slot0 = class("DungeonModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._dungeonChapterDic = {}
	slot0._dungeonEpisodeDic = {}
	slot0.curLookChapterId = nil
	slot0.curSelectTicketId = 0
	slot0.curSpeed = 1
	slot0.curChapterType = nil
	slot0.curSendChapterId = nil
	slot0.curSendEpisodeId = nil
	slot0.curSendEpisodePrePass = false
	slot0.curSendEpisodePass = false
	slot0.lastSendEpisodeId = nil
	slot0.curLookEpisodeId = nil
	slot0.unlockNewChapterId = nil
	slot0.chapterTriggerNewChapter = nil
	slot0._lastSelectEpisodeId = nil
	slot0.chapterBgTweening = false
	slot0._chapterStatus = nil
	slot0._cacheChapterOpenHardDungeon = {}
	slot0._isDungeonStoryView = false
	slot0._chapterTypeNums = nil
	slot0._lastSelectChapterType = 0
	slot0.jumpEpisodeId = nil
	slot0.versionActivityChapterType = nil
	slot0.dungeonInfoCount = 0
	slot0.dungeonInfoCacheList = {}
	slot0.canGetDramaReward = false
	slot0.initAllDungeonInfo = false
end

function slot0.setLastSendEpisodeId(slot0, slot1)
	slot0.lastSendEpisodeId = slot1
end

function slot0.setChapterTypeNums(slot0, slot1)
	slot0._chapterTypeNums = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0._chapterTypeNums[slot6.chapterType] or UserChapterTypeNumMO.New()

		slot7:init(slot6)

		slot0._chapterTypeNums[slot6.chapterType] = slot7
	end
end

function slot0.getChapterTypeNum(slot0, slot1)
	return slot0._chapterTypeNums[slot1] and slot2.todayPassNum or 0
end

function slot0.getEquipRemainingNum(slot0)
	return slot0:getChapterRemainingNum(DungeonEnum.ChapterType.Equip)
end

function slot0.getChapterRemainingNum(slot0, slot1)
	return math.max(DungeonConfig.instance:getDungeonEveryDayCount(slot1) - uv0.instance:getChapterTypeNum(slot1), 0)
end

function slot0.resetSendChapterEpisodeId(slot0)
	slot0.curSendEpisodeId = nil
end

function slot0.SetSendChapterEpisodeId(slot0, slot1, slot2)
	slot0.curSendEpisodeId = slot2
	slot0.lastSendEpisodeId = slot2

	if slot1 then
		slot0.curSendChapterId = slot1
	elseif DungeonConfig.instance:getEpisodeCO(slot2) then
		slot0.curSendChapterId = slot3.chapterId
	end

	slot0.curLookChapterId = slot0.curSendChapterId

	if DungeonConfig.instance:getEpisodeCO(slot2) then
		slot5 = nil

		if DungeonConfig.instance:getChapterCO(slot3.chapterId) then
			if slot4.type == DungeonEnum.ChapterType.Hard then
				slot5 = DungeonConfig.instance:getEpisodeCO(slot3.preEpisode)
			elseif slot4.type == DungeonEnum.ChapterType.Simple then
				slot5 = DungeonConfig.instance:getEpisodeCO(slot3.normalEpisodeId)
			end

			if slot5 then
				slot0.curLookChapterId = slot5.chapterId
				slot0.curSendEpisodeId = slot5.id
			end
		end
	end

	if not slot0.curChapterType then
		slot0.curChapterType = DungeonConfig.instance:getChapterCO(slot0.curLookChapterId) and slot4.type
	end

	slot0.curSendEpisodePrePass = slot0:getEpisodeInfo(slot2) and slot4.star > 0
end

function slot0.initDungeonInfoList(slot0, slot1)
	for slot7 = 1, #slot1 do
		slot0.dungeonInfoCacheList[#slot0.dungeonInfoCacheList + slot7] = slot1[slot7]
	end

	slot0.dungeonInfoCount = slot0.dungeonInfoCount - slot2

	if slot0.dungeonInfoCount > 0 then
		return
	end

	slot1 = slot0.dungeonInfoCacheList
	slot0.dungeonInfoCacheList = {}
	slot0.dungeonInfoCount = 0

	table.sort(slot1, function (slot0, slot1)
		return slot0.chapterId < slot1.chapterId
	end)

	for slot7, slot8 in ipairs(slot1) do
		slot0:updateDungeonInfo(slot8)
	end

	slot0.initAllDungeonInfo = true

	return true
end

function slot0.updateDungeonInfo(slot0, slot1)
	slot3 = slot0._dungeonChapterDic[slot1.chapterId] or {}
	slot4 = slot3[slot1.episodeId] or UserDungeonMO.New()

	slot4:init(slot1)

	slot2[slot1.chapterId] = slot3
	slot3[slot1.episodeId] = slot4
	slot0._dungeonEpisodeDic[slot1.episodeId] = slot4
end

function slot0.resetEpisodeInfoByChapterId(slot0, slot1)
	for slot6, slot7 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot1)) do
		slot0._dungeonEpisodeDic[slot7.id].star = DungeonEnum.StarType.None
	end
end

function slot0.initModel(slot0)
	slot0:changeCategory(DungeonEnum.ChapterType.Normal)
end

function slot0.changeCategory(slot0, slot1, slot2)
	slot0.curChapterType = slot1

	if slot2 == false then
		return
	end

	DungeonChapterListModel.instance:setFbList()
end

function slot0.getLastEpisodeConfigAndInfo(slot0)
	for slot5 = #DungeonConfig.instance:getChapterCOList(), 1, -1 do
		if slot0:chapterIsLock(slot1[slot5].id) == false and slot6.type == DungeonEnum.ChapterType.Normal and DungeonConfig.instance:getChapterEpisodeCOList(slot6.id) then
			for slot11 = #slot7, 1, -1 do
				if slot0:getEpisodeInfo(slot7[slot11].id) then
					return slot12, slot13
				end
			end
		end
	end
end

function slot0.getLastEpisodeShowData(slot0)
	slot2 = nil

	for slot6 = #DungeonConfig.instance:getChapterCOList(), 1, -1 do
		if slot0:chapterIsLock(slot1[slot6].id) == false and slot7.type == DungeonEnum.ChapterType.Normal and DungeonConfig.instance:getChapterEpisodeCOList(slot7.id) then
			for slot12 = #slot8, 1, -1 do
				if slot0:getEpisodeInfo(slot8[slot12].id) and slot0:isFinishElementList(slot13) then
					if slot13.type ~= DungeonEnum.EpisodeType.Sp then
						return slot13, slot14
					elseif slot2 and slot2.type ~= DungeonEnum.EpisodeType.Sp and slot2.preEpisode == slot13.id then
						return slot13, slot14
					end
				end

				slot2 = slot13
			end
		end
	end
end

function slot0.getEpisodeInfo(slot0, slot1)
	if not slot0._dungeonEpisodeDic[slot1] and slot0:isUnlock(DungeonConfig.instance:getEpisodeCO(slot1)) then
		slot2 = UserDungeonMO.New()

		slot2:initFromManual(slot3.chapterId, slot3.id, 0, 0)

		slot0._dungeonEpisodeDic[slot1] = slot2
	end

	return slot2
end

function slot0.getEpisodeChallengeCount(slot0, slot1)
	slot4 = -1
	slot5 = -1

	if not string.nilorempty(DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot1).chapterId).challengeCountLimit) then
		slot6 = string.split(slot3.challengeCountLimit, "#")
		slot4 = tonumber(slot6[1])
		slot5 = tonumber(slot6[2])
	end

	return slot4, slot5, slot0:getEpisodeInfo(slot1).challengeCount
end

function slot0.chapterIsLock(slot0, slot1)
	slot2 = true
	slot3, slot4 = nil
	slot5 = DungeonConfig.instance:getChapterCO(slot1)

	if VersionValidator.instance:isInReviewing() and not ResSplitConfig.instance:getAllChapterIds()[slot1] then
		return true
	end

	if not slot5 then
		return true
	end

	if slot5.type == DungeonEnum.ChapterType.Gold then
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon)
		slot3, slot4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GoldDungeon)
	elseif slot5.type == DungeonEnum.ChapterType.Exp then
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon)
		slot3, slot4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ExperienceDungeon)
	elseif slot5.type == DungeonEnum.ChapterType.Buildings then
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings)
		slot3, slot4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Buildings)
	elseif slot5.type == DungeonEnum.ChapterType.Equip then
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)
		slot3, slot4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.EquipDungeon)
	end

	if slot1 == DungeonEnum.ChapterId.HeroInvitation then
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HeroInvitation)
		slot3, slot4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HeroInvitation)
	end

	if not slot2 then
		return true, -4, slot3
	end

	if slot0._dungeonChapterDic[slot1] then
		return false
	end

	slot6 = false

	if DungeonConfig.instance:getChapterEpisodeCOList(slot1) and #slot7 > 0 then
		for slot11, slot12 in ipairs(slot7) do
			if slot0:isUnlock(slot12) then
				slot6 = true

				break
			end
		end
	elseif slot5.preChapter > 0 and not slot0:chapterIsLock(slot5.preChapter) then
		return false
	end

	slot9 = (slot1 == 103 or slot1 == 104) and ToastEnum.DungeonChapterLine3 or ToastEnum.UnreachUnlockCondition

	if slot6 == false then
		return true, -1, 114
	end

	if slot5.rewardPoint > 0 and slot5.preChapter > 0 and DungeonMapModel.instance:getRewardPointValue(slot5.preChapter) < slot5.rewardPoint then
		return true, -3, 133, slot5.rewardPoint
	end

	if PlayerModel.instance:getPlayinfo().level < slot5.openLevel then
		return true, -2, 134, slot5.openLevel
	end

	return false
end

function slot0.getCantChallengeToast(slot0, slot1)
	slot2, slot3 = slot0:isCanChallenge(slot1)

	if slot2 then
		return nil
	end

	slot4 = nil

	if slot3 == -1 then
		slot4 = slot1.preEpisode
	elseif slot3 == -2 then
		slot4 = slot1.unlockEpisode
	end

	if not slot4 then
		return
	end

	if not DungeonConfig.instance:getEpisodeCO(slot4) then
		return
	end

	if not DungeonConfig.instance:getChapterCO(slot5.chapterId) then
		return
	end

	slot7 = DungeonConfig.instance:getChapterIndex(slot6.type, slot6.id)
	slot8 = slot5
	slot9 = slot6

	if slot6.type == DungeonEnum.ChapterType.Hard then
		slot9 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot5.preEpisode).chapterId)
	elseif slot6.type == DungeonEnum.ChapterType.Simple then
		slot9 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot5.normalEpisodeId).chapterId)
	end

	slot10 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot9.id, slot8.id)
	slot11 = ""
	slot11 = (slot1.type ~= DungeonEnum.EpisodeType.Sp or string.format("SP-%s", slot10)) and string.format("%s-%s", GameUtil.getRomanNums(slot7), slot10)
	slot12 = ""

	if slot6.type == DungeonEnum.ChapterType.Normal then
		slot12 = luaLang("dungeon_lock_tips_normal")
	elseif slot6.type == DungeonEnum.ChapterType.Hard then
		slot12 = luaLang("dungeon_lock_tips_hard")
	elseif slot6.type == DungeonEnum.ChapterType.Simple then
		slot12 = luaLang("dungeon_simple_mode")
	end

	return string.format("%s%s", slot12, slot11)
end

function slot0.getChallengeUnlockText(slot0, slot1)
	slot2, slot3 = slot0:isCanChallenge(slot1)
	slot4 = nil

	if slot3 == -1 then
		slot4 = slot1.preEpisode
	elseif slot3 == -2 then
		slot4 = slot1.unlockEpisode
	end

	if not slot4 then
		return
	end

	if not DungeonConfig.instance:getEpisodeCO(slot4) then
		return
	end

	if not DungeonConfig.instance:getChapterCO(slot5.chapterId) then
		return
	end

	slot7 = DungeonConfig.instance:getChapterIndex(slot6.type, slot6.id)
	slot8 = slot5
	slot9 = slot6

	if slot6.type == DungeonEnum.ChapterType.Hard then
		slot9 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot5.preEpisode).chapterId)
	elseif slot6.type == DungeonEnum.ChapterType.Simple then
		slot9 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot5.normalEpisodeId).chapterId)
	end

	slot10 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot9.id, slot8.id)
	slot11 = ""
	slot11 = (slot5.type ~= DungeonEnum.EpisodeType.Sp or string.format("SP-%s", slot10)) and string.format("%s-%s", slot7, slot10)
	slot12 = ""

	if slot6.type == DungeonEnum.ChapterType.Normal then
		slot12 = luaLang("dungeon_story_mode")
	elseif slot6.type == DungeonEnum.ChapterType.Hard then
		slot12 = luaLang("dungeon_hard_mode")
	elseif slot6.type == DungeonEnum.ChapterType.Simple then
		slot12 = luaLang("dungeon_simple_mode")
	end

	return string.format("%s %s", slot12, slot11)
end

function slot0.isCanChallenge(slot0, slot1)
	if not slot0:isUnlock(slot1) then
		return false, -1
	end

	if slot1.unlockEpisode == 0 then
		return true
	end

	if slot0._dungeonEpisodeDic[slot1.unlockEpisode] and slot2.star > 0 then
		return true
	end

	return false, -2
end

function slot0.startCheckUnlockChapter(slot0)
	if slot0._chapterStatus then
		return
	end

	slot0._chapterStatus = {}
	slot0._otherChapterUnlock = {}

	for slot5, slot6 in ipairs(DungeonConfig.instance:getNormalChapterList()) do
		slot0._chapterStatus[slot6.id] = slot0:chapterIsLock(slot6.id)
	end
end

function slot0.endCheckUnlockChapter(slot0)
	if not slot0._chapterStatus then
		return
	end

	for slot4, slot5 in pairs(slot0._chapterStatus) do
		if slot5 and slot5 ~= slot0:chapterIsLock(slot4) then
			slot0._chapterStatus[slot4] = false
			slot0.unlockNewChapterId = slot4
			slot0.chapterTriggerNewChapter = true

			if DungeonConfig.instance:getChapterCO(slot4) and slot6.rewardPoint > 0 then
				GameFacade.showToast(ToastEnum.UnlockChapter)
			end

			break
		end
	end

	for slot4, slot5 in pairs(slot0._chapterStatus) do
		if slot5 and slot5 ~= slot0:chapterIsLock(slot4) then
			slot0._chapterStatus[slot4] = false
			slot0._otherChapterUnlock[slot4] = true
		end
	end
end

function slot0.needUnlockChapterAnim(slot0, slot1)
	return slot0._otherChapterUnlock and slot0._otherChapterUnlock[slot1]
end

function slot0.clearUnlockChapterAnim(slot0, slot1)
	if not slot0._otherChapterUnlock then
		return
	end

	slot0._otherChapterUnlock[slot1] = nil
end

function slot0.clearUnlockNewChapterId(slot0, slot1)
	if slot1 == slot0.unlockNewChapterId then
		slot0.chapterTriggerNewChapter = nil
		slot0.unlockNewChapterId = nil
	end
end

function slot0.isFinishElementList(slot0, slot1)
	if not slot1 then
		return false
	end

	if string.nilorempty(slot1.elementList) then
		return true
	end

	for slot6, slot7 in ipairs(string.splitToNumber(slot1.elementList, "#")) do
		if DungeonMapModel.instance:getElementById(slot7) then
			return false
		end
	end

	return true
end

function slot0.isUnlock(slot0, slot1)
	if not slot1 then
		return false
	end

	if slot1.preEpisode2 == 0 then
		return true
	end

	if slot0._dungeonEpisodeDic[slot1.preEpisode] and slot2.star > 0 then
		if DungeonConfig.instance:getEpisodeCO(slot1.preEpisode).afterStory > 0 then
			if StoryModel.instance:isStoryFinished(slot3.afterStory) then
				return true
			end
		else
			return true
		end
	end

	if slot0._dungeonEpisodeDic[slot1.preEpisode2] and slot3.star > 0 then
		if DungeonConfig.instance:getEpisodeCO(slot1.preEpisode2).afterStory > 0 then
			if StoryModel.instance:isStoryFinished(slot4.afterStory) then
				return true
			end
		else
			return true
		end
	end

	return false
end

slot1 = {
	[DungeonEnum.EpisodeType.Sp] = true,
	[DungeonEnum.EpisodeType.Equip] = true,
	[DungeonEnum.EpisodeType.SpecialEquip] = true,
	[DungeonEnum.EpisodeType.WeekWalk] = true,
	[DungeonEnum.EpisodeType.Season] = true,
	[DungeonEnum.EpisodeType.SeasonRetail] = true,
	[DungeonEnum.EpisodeType.SeasonSpecial] = true,
	[DungeonEnum.EpisodeType.SeasonTrial] = true,
	[DungeonEnum.EpisodeType.Explore] = true,
	[DungeonEnum.EpisodeType.Meilanni] = true,
	[DungeonEnum.EpisodeType.Dog] = true,
	[DungeonEnum.EpisodeType.Jiexika] = true,
	[DungeonEnum.EpisodeType.YaXian] = true,
	[DungeonEnum.EpisodeType.Daily1_2] = true,
	[DungeonEnum.EpisodeType.DreamTailNormal] = true,
	[DungeonEnum.EpisodeType.DreamTailHard] = true,
	[DungeonEnum.EpisodeType.Act1_2Daily] = true,
	[DungeonEnum.EpisodeType.Act1_3Dungeon] = true,
	[DungeonEnum.EpisodeType.Act1_3Daily] = true,
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Operation] = true,
	[DungeonEnum.EpisodeType.BossRush] = true,
	[DungeonEnum.EpisodeType.Act1_4Role6] = true,
	[DungeonEnum.EpisodeType.RoleStoryChallenge] = true,
	[DungeonEnum.EpisodeType.Act1_5Dungeon] = true,
	[DungeonEnum.EpisodeType.Cachot] = true,
	[DungeonEnum.EpisodeType.RoleTryFight] = true,
	[DungeonEnum.EpisodeType.Act1_6Dungeon] = true,
	[DungeonEnum.EpisodeType.Act1_6DungeonBoss] = true,
	[DungeonEnum.EpisodeType.Season123] = true,
	[DungeonEnum.EpisodeType.Season123Retail] = true,
	[DungeonEnum.EpisodeType.Act1_8Dungeon] = true,
	[DungeonEnum.EpisodeType.ToughBattle] = true,
	[DungeonEnum.EpisodeType.ToughBattleStory] = true,
	[DungeonEnum.EpisodeType.Rouge] = true,
	[DungeonEnum.EpisodeType.TrialHero] = true,
	[DungeonEnum.EpisodeType.Season166Base] = true,
	[DungeonEnum.EpisodeType.Season166Train] = true,
	[DungeonEnum.EpisodeType.Season166Teach] = true
}

function slot0.isBattleEpisode(slot0)
	return slot0.type <= DungeonEnum.EpisodeType.Boss or uv0[slot0.type]
end

function slot0.getEpisodeBonus(slot0, slot1, slot2)
	slot5 = slot0:isPermanentEpisode(slot1) and "permanentBonus" or slot0:isReactivityEpisode(slot1) and "retroBonus" or "bonus"

	if slot2 and not DungeonConfig.instance:isNewReward(slot1, slot5) then
		return {}
	end

	return slot0:_getEpisodeBonusByType(slot1, slot5)
end

function slot0.getEpisodeFreeBonus(slot0, slot1)
	return slot0:_getEpisodeBonusByType(slot1, "freeBonus")
end

function slot0._getEpisodeBonusByType(slot0, slot1, slot2)
	slot5 = {}

	if DungeonConfig.instance:getBonusCO(DungeonConfig.instance:getEpisodeCO(slot1)[slot2]) and not string.nilorempty(slot4.fixBonus) then
		for slot11, slot12 in ipairs(string.split(slot6, "|")) do
			table.insert(slot5, string.split(slot12, "#"))
		end
	end

	if DungeonConfig.instance:getRewardItems(slot3[slot2]) then
		for slot10, slot11 in ipairs(slot6) do
			table.insert(slot5, slot11)
		end
	end

	return slot5
end

function slot0.getEpisodeReward(slot0, slot1)
	for slot9, slot10 in pairs(slot0:_getEpisodeBonusByType(slot1, slot0:isPermanentEpisode(slot1) and "permanentReward" or slot0:isReactivityEpisode(slot1) and "retroReward" or "reward")) do
		slot10.starType = DungeonEnum.StarType.Normal
	end

	return slot5
end

function slot0.getEpisodeFirstBonus(slot0, slot1)
	for slot9, slot10 in pairs(slot0:_getEpisodeBonusByType(slot1, slot0:isPermanentEpisode(slot1) and "permanentFirstBonus" or slot0:isReactivityEpisode(slot1) and "retroFirstBonus" or "firstBonus")) do
		slot10.starType = DungeonEnum.StarType.Normal
	end

	return slot5
end

function slot0.getEpisodeAdvancedBonus(slot0, slot1)
	for slot9, slot10 in pairs(slot0:_getEpisodeBonusByType(slot1, slot0:isPermanentEpisode(slot1) and "permanentAdvancedBonus" or slot0:isReactivityEpisode(slot1) and "retroAdvancedBonus" or "advancedBonus")) do
		slot10.starType = DungeonEnum.StarType.Advanced
	end

	return slot5
end

function slot0.isReactivityEpisode(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(slot1) then
		return false
	end

	if not DungeonConfig.instance:getChapterCO(slot2.chapterId) then
		return false
	end

	return ReactivityModel.instance:isReactivity(slot4.actId)
end

function slot0.isPermanentEpisode(slot0, slot1)
	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot1).chapterId).actId == 0 then
		return false
	end

	return ActivityConfig.instance:getActivityCo(slot4).isRetroAcitivity == ActivityEnum.RetroType.Permanent
end

function slot0.getEpisodeRewardDisplayList(slot0, slot1)
	return slot0:_getEpisodeDisplayList(slot1, slot0:isPermanentEpisode(slot1) and "permanentRewardDisplayList" or slot0:isReactivityEpisode(slot1) and "retroRewardDisplayList" or "rewardDisplayList")
end

function slot0.getEpisodeRewardList(slot0, slot1)
	return slot0:_getEpisodeDisplayList(slot1, slot0:isPermanentEpisode(slot1) and "permanentRewardList" or slot0:isReactivityEpisode(slot1) and "retroRewardList" or "rewardList")
end

function slot0.getEpisodeFreeDisplayList(slot0, slot1)
	return slot0:_getEpisodeDisplayList(slot1, "freeDisplayList")
end

function slot0._getEpisodeDisplayList(slot0, slot1, slot2)
	if string.nilorempty(DungeonConfig.instance:getEpisodeCO(slot1)[slot2]) then
		return {}
	end

	for slot10, slot11 in ipairs(string.split(slot5, "|")) do
		table.insert(slot4, string.split(slot11, "#"))
	end

	return slot4
end

function slot0.getMonsterDisplayList(slot0, slot1)
	slot2 = {}
	slot6 = "#"

	for slot6, slot7 in ipairs(string.splitToNumber(slot1, slot6)) do
		table.insert(slot2, lua_monster.configDict[slot7])
	end

	return slot2
end

function slot0.chapterListIsNormalType(slot0, slot1)
	return DungeonEnum.ChapterType.Normal == (slot1 or slot0.curChapterType)
end

function slot0.chapterListIsResType(slot0, slot1)
	slot2 = slot1 or slot0.curChapterType

	return DungeonEnum.ChapterType.Gold <= slot2 and slot2 <= DungeonEnum.ChapterType.Equip or DungeonEnum.ChapterType.SpecialEquip == slot2 or DungeonEnum.ChapterType.Buildings == slot2
end

function slot0.chapterListIsBreakType(slot0, slot1)
	return DungeonEnum.ChapterType.Break == (slot1 or slot0.curChapterType)
end

function slot0.chapterListIsWeekWalkType(slot0, slot1)
	return (slot1 or slot0.curChapterType) == DungeonEnum.ChapterType.WeekWalk
end

function slot0.chapterListIsSeasonType(slot0, slot1)
	return (slot1 or slot0.curChapterType) == DungeonEnum.ChapterType.Season
end

function slot0.chapterListIsExploreType(slot0, slot1)
	return (slot1 or slot0.curChapterType) == DungeonEnum.ChapterType.Explore
end

function slot0.chapterListIsRoleStory(slot0, slot1)
	return (slot1 or slot0.curChapterType) == DungeonEnum.ChapterType.RoleStory
end

function slot0.chapterListIsPermanent(slot0, slot1)
	return (slot1 or slot0.curChapterType) == DungeonEnum.ChapterType.PermanentActivity
end

function slot0.getChapterListTypes(slot0, slot1)
	return slot0:chapterListIsNormalType(slot1), slot0:chapterListIsResType(slot1), slot0:chapterListIsBreakType(slot1), slot0:chapterListIsWeekWalkType(slot1), slot0:chapterListIsSeasonType(slot1), slot0:chapterListIsExploreType(slot1)
end

function slot0.getChapterListOpenTimeValid(slot0, slot1)
	slot2 = {}
	slot3, slot4, slot5, slot6, slot7, slot8 = slot0:getChapterListTypes(slot1)

	if slot3 then
		slot2 = DungeonConfig.instance:getChapterCOListByType(slot1)
	elseif slot4 then
		tabletool.addValues(slot2, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold))
		tabletool.addValues(slot2, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp))
		tabletool.addValues(slot2, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip))
	elseif slot5 then
		slot2 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
	elseif slot6 then
		slot2 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.WeekWalk)
	elseif slot8 then
		slot2 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Explore)
	end

	for slot12, slot13 in ipairs(slot2) do
		if slot0:getChapterOpenTimeValid(slot13) then
			return true
		end
	end

	return false
end

function slot0.getChapterOpenTimeValid(slot0, slot1)
	if LuaUtil.isEmptyStr(slot1.openDay) then
		return true
	end

	slot2 = ServerTime.weekDayInServerLocal()
	slot7 = "#"

	for slot7, slot8 in ipairs(GameUtil.splitString2(slot1.openDay, true, "|", slot7)) do
		for slot12, slot13 in ipairs(slot8) do
			if tonumber(slot13) == slot2 then
				return true
			end
		end
	end

	return false
end

function slot0.isOpenHardDungeon(slot0, slot1, slot2)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		return false
	end

	if slot2 and (not slot0:getEpisodeInfo(slot2) or slot4.star < DungeonEnum.StarType.Advanced) then
		return false
	end

	return true
end

function slot0.chapterIsPass(slot0, slot1)
	if DungeonConfig.instance:getChapterEpisodeCOList(slot1) then
		for slot6, slot7 in ipairs(slot2) do
			if not slot0:hasPassLevelAndStory(slot7.id) then
				return false
			end
		end
	end

	return true
end

function slot0.hasPassLevel(slot0, slot1)
	return slot0:getEpisodeInfo(slot1) and DungeonEnum.StarType.None < slot2.star
end

function slot0.hasPassLevelAndStory(slot0, slot1)
	if not slot0:hasPassLevel(slot1) then
		return false
	end

	if DungeonConfig.instance:getEpisodeCO(slot1).afterStory > 0 and not StoryModel.instance:isStoryFinished(slot2.afterStory) then
		return false
	end

	return true
end

function slot0.getUnlockContentList(slot0, slot1)
	slot2 = {}

	if OpenConfig.instance:getOpenShowInEpisode(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if lua_open.configDict[slot8].bindActivityId ~= 0 then
				if (ActivityHelper.getActivityStatus(slot10) == ActivityEnum.ActivityStatus.Normal or slot11 == ActivityEnum.ActivityStatus.NotUnlock) and slot0:getUnlockContent(DungeonEnum.UnlockContentType.Open, slot8) then
					table.insert(slot2, slot12)
				end
			elseif slot0:getUnlockContent(DungeonEnum.UnlockContentType.Open, slot8) then
				table.insert(slot2, slot11)
			end
		end
	end

	if DungeonConfig.instance:getUnlockEpisodeList(slot1) then
		for slot8, slot9 in ipairs(slot4) do
			if slot0:getUnlockContent(DungeonEnum.UnlockContentType.Episode, slot9) then
				table.insert(slot2, slot10)
			end
		end
	end

	if OpenConfig.instance:getOpenGroupShowInEpisode(slot1) then
		for slot9, slot10 in ipairs(slot5) do
			if slot0:getUnlockContent(DungeonEnum.UnlockContentType.OpenGroup, slot10) then
				table.insert(slot2, slot11)
			end
		end
	end

	return slot2
end

function slot0.getUnlockContent(slot0, slot1, slot2)
	if slot1 == DungeonEnum.UnlockContentType.Open then
		return string.format(luaLang("dungeon_unlock_content_1"), lua_open.configDict[slot2].name)
	elseif slot1 == DungeonEnum.UnlockContentType.Episode then
		slot3 = DungeonConfig.instance:getEpisodeCO(slot2)

		return string.format(luaLang("dungeon_unlock_content_2"), string.format("%s %s", DungeonController.getEpisodeName(slot3), slot3.name))
	elseif slot1 == DungeonEnum.UnlockContentType.OpenGroup then
		return string.format(luaLang("dungeon_unlock_content_3"), slot2)
	elseif slot1 == DungeonEnum.UnlockContentType.ActivityOpen then
		return string.format(luaLang("dungeon_unlock_content_4"), lua_open.configDict[slot2].name)
	end
end

function slot0.setDungeonStoryviewState(slot0, slot1)
	slot0._isDungeonStoryView = slot1
end

function slot0.getDungeonStoryState(slot0)
	return slot0._isDungeonStoryView
end

function slot0.setLastSelectMode(slot0, slot1, slot2)
	slot0._lastSelectEpisodeId = slot2
	slot0._lastSelectChapterType = slot1
end

function slot0.getLastSelectMode(slot0)
	return slot0._lastSelectChapterType, slot0._lastSelectEpisodeId
end

function slot0.hasPassAllChapterEpisode(slot0, slot1)
	for slot6, slot7 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot1)) do
		if not slot0:hasPassLevelAndStory(slot7.id) then
			return false
		end
	end

	return true
end

function slot0.chapterIsUnLock(slot0, slot1)
	return DungeonConfig.instance:getChapterEpisodeCOList(slot1) and #slot2 > 0 and slot0:hasPassLevelAndStory(slot2[1].preEpisode), slot2[1].preEpisode
end

function slot0.episodeIsInLockTime(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(slot1) or string.nilorempty(slot2.lockTime) then
		return false
	end

	slot3 = ServerTime.now() * 1000

	if string.splitToNumber(slot2.lockTime, "#")[1] and slot4[2] then
		return slot4[1] < slot3 and slot3 < slot4[2]
	end

	return false
end

function slot0.getMapElementReward(slot0, slot1)
	if not lua_chapter_map_element.configDict[slot1] then
		return
	end

	slot6 = DungeonConfig.instance:getChapterCO(lua_chapter_map.configDict[slot2.mapId].chapterId) and ReactivityModel.instance:isReactivity(slot5.actId) or false

	if slot5.actId ~= 0 and ActivityConfig.instance:isPermanent(slot5.actId) then
		return slot2.permanentReward
	else
		return slot6 and slot2.retroReward or slot2.reward
	end
end

function slot0.isSpecialMainPlot(slot0, slot1)
	return DungeonEnum.SpecialMainPlot[slot1] ~= nil
end

function slot0.getChapterRedId(slot0, slot1)
	if slot1 == DungeonEnum.ChapterId.HeroInvitation then
		return RedDotEnum.DotNode.HeroInvitationReward
	end
end

function slot0.setCanGetDramaReward(slot0, slot1)
	slot0.canGetDramaReward = slot1
end

function slot0.isCanGetDramaReward(slot0)
	return slot0.canGetDramaReward
end

function slot0.getLastFightEpisodePassMode(slot0, slot1)
	while slot2.type == DungeonEnum.EpisodeType.Story and slot1.chapterId == DungeonConfig.instance:getEpisodeCO(slot1.preEpisode).chapterId do
		slot3 = slot1.chapterId == DungeonConfig.instance:getEpisodeCO(slot2.preEpisode).chapterId
	end

	if slot3 and not slot0:hasPassLevel(slot2.id) then
		return DungeonEnum.ChapterType.Simple
	end

	return DungeonEnum.ChapterType.Normal
end

slot0.instance = slot0.New()

return slot0

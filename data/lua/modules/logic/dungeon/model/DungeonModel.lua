module("modules.logic.dungeon.model.DungeonModel", package.seeall)

local var_0_0 = class("DungeonModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._dungeonChapterDic = {}
	arg_2_0._dungeonEpisodeDic = {}
	arg_2_0.curLookChapterId = nil
	arg_2_0.curSelectTicketId = 0
	arg_2_0.curSpeed = 1
	arg_2_0.curChapterType = nil
	arg_2_0.curSendChapterId = nil
	arg_2_0.curSendEpisodeId = nil
	arg_2_0.curSendEpisodePrePass = false
	arg_2_0.curSendEpisodePass = false
	arg_2_0.lastSendEpisodeId = nil
	arg_2_0.curLookEpisodeId = nil
	arg_2_0.unlockNewChapterId = nil
	arg_2_0.chapterTriggerNewChapter = nil
	arg_2_0._lastSelectEpisodeId = nil
	arg_2_0.chapterBgTweening = false
	arg_2_0._chapterStatus = nil
	arg_2_0._cacheChapterOpenHardDungeon = {}
	arg_2_0._isDungeonStoryView = false
	arg_2_0._chapterTypeNums = nil
	arg_2_0._lastSelectChapterType = 0
	arg_2_0.jumpEpisodeId = nil
	arg_2_0.versionActivityChapterType = nil
	arg_2_0.dungeonInfoCount = 0
	arg_2_0.dungeonInfoCacheList = {}
	arg_2_0.canGetDramaReward = false
	arg_2_0.initAllDungeonInfo = false
end

function var_0_0.setLastSendEpisodeId(arg_3_0, arg_3_1)
	arg_3_0.lastSendEpisodeId = arg_3_1
end

function var_0_0.setChapterTypeNums(arg_4_0, arg_4_1)
	arg_4_0._chapterTypeNums = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = arg_4_0._chapterTypeNums[iter_4_1.chapterType] or UserChapterTypeNumMO.New()

		var_4_0:init(iter_4_1)

		arg_4_0._chapterTypeNums[iter_4_1.chapterType] = var_4_0
	end
end

function var_0_0.getChapterTypeNum(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._chapterTypeNums[arg_5_1]

	return var_5_0 and var_5_0.todayPassNum or 0
end

function var_0_0.getEquipRemainingNum(arg_6_0)
	return arg_6_0:getChapterRemainingNum(DungeonEnum.ChapterType.Equip)
end

function var_0_0.getChapterRemainingNum(arg_7_0, arg_7_1)
	local var_7_0 = DungeonConfig.instance:getDungeonEveryDayCount(arg_7_1) - var_0_0.instance:getChapterTypeNum(arg_7_1)

	return math.max(var_7_0, 0)
end

function var_0_0.resetSendChapterEpisodeId(arg_8_0)
	arg_8_0.curSendEpisodeId = nil
end

function var_0_0.SetSendChapterEpisodeId(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.curSendEpisodeId = arg_9_2
	arg_9_0.lastSendEpisodeId = arg_9_2

	if arg_9_1 then
		arg_9_0.curSendChapterId = arg_9_1
	else
		local var_9_0 = DungeonConfig.instance:getEpisodeCO(arg_9_2)

		if var_9_0 then
			arg_9_0.curSendChapterId = var_9_0.chapterId
		end
	end

	arg_9_0.curLookChapterId = arg_9_0.curSendChapterId

	local var_9_1 = DungeonConfig.instance:getEpisodeCO(arg_9_2)

	if var_9_1 then
		local var_9_2 = DungeonConfig.instance:getChapterCO(var_9_1.chapterId)
		local var_9_3

		if var_9_2 then
			if var_9_2.type == DungeonEnum.ChapterType.Hard then
				var_9_3 = DungeonConfig.instance:getEpisodeCO(var_9_1.preEpisode)
			elseif var_9_2.type == DungeonEnum.ChapterType.Simple then
				var_9_3 = DungeonConfig.instance:getEpisodeCO(var_9_1.normalEpisodeId)
			end

			if var_9_3 then
				arg_9_0.curLookChapterId = var_9_3.chapterId
				arg_9_0.curSendEpisodeId = var_9_3.id
			end
		end
	end

	if not arg_9_0.curChapterType then
		local var_9_4 = DungeonConfig.instance:getChapterCO(arg_9_0.curLookChapterId)

		arg_9_0.curChapterType = var_9_4 and var_9_4.type
	end

	local var_9_5 = arg_9_0:getEpisodeInfo(arg_9_2)

	arg_9_0.curSendEpisodePrePass = var_9_5 and var_9_5.star > 0
end

function var_0_0.initDungeonInfoList(arg_10_0, arg_10_1)
	local var_10_0 = #arg_10_1
	local var_10_1 = #arg_10_0.dungeonInfoCacheList

	for iter_10_0 = 1, var_10_0 do
		arg_10_0.dungeonInfoCacheList[var_10_1 + iter_10_0] = arg_10_1[iter_10_0]
	end

	arg_10_0.dungeonInfoCount = arg_10_0.dungeonInfoCount - var_10_0

	if arg_10_0.dungeonInfoCount > 0 then
		return
	end

	arg_10_1 = arg_10_0.dungeonInfoCacheList
	arg_10_0.dungeonInfoCacheList = {}
	arg_10_0.dungeonInfoCount = 0

	table.sort(arg_10_1, function(arg_11_0, arg_11_1)
		return arg_11_0.chapterId < arg_11_1.chapterId
	end)

	for iter_10_1, iter_10_2 in ipairs(arg_10_1) do
		arg_10_0:updateDungeonInfo(iter_10_2)
	end

	arg_10_0.initAllDungeonInfo = true

	return true
end

function var_0_0.updateDungeonInfo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._dungeonChapterDic
	local var_12_1 = var_12_0[arg_12_1.chapterId] or {}
	local var_12_2 = var_12_1[arg_12_1.episodeId] or UserDungeonMO.New()

	var_12_2:init(arg_12_1)

	var_12_0[arg_12_1.chapterId] = var_12_1
	var_12_1[arg_12_1.episodeId] = var_12_2
	arg_12_0._dungeonEpisodeDic[arg_12_1.episodeId] = var_12_2
end

function var_0_0.resetEpisodeInfoByChapterId(arg_13_0, arg_13_1)
	local var_13_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		arg_13_0._dungeonEpisodeDic[iter_13_1.id].star = DungeonEnum.StarType.None
	end
end

function var_0_0.initModel(arg_14_0)
	arg_14_0:changeCategory(DungeonEnum.ChapterType.Normal)
end

function var_0_0.changeCategory(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.curChapterType = arg_15_1

	if arg_15_2 == false then
		return
	end

	DungeonChapterListModel.instance:setFbList()
end

function var_0_0.getLastEpisodeConfigAndInfo(arg_16_0)
	local var_16_0 = DungeonConfig.instance:getChapterCOList()

	for iter_16_0 = #var_16_0, 1, -1 do
		local var_16_1 = var_16_0[iter_16_0]

		if arg_16_0:chapterIsLock(var_16_1.id) == false and var_16_1.type == DungeonEnum.ChapterType.Normal then
			local var_16_2 = DungeonConfig.instance:getChapterEpisodeCOList(var_16_1.id)

			if var_16_2 then
				for iter_16_1 = #var_16_2, 1, -1 do
					local var_16_3 = var_16_2[iter_16_1]
					local var_16_4 = arg_16_0:getEpisodeInfo(var_16_3.id)

					if var_16_4 then
						return var_16_3, var_16_4
					end
				end
			end
		end
	end
end

function var_0_0.getLastEpisodeShowData(arg_17_0)
	local var_17_0 = DungeonConfig.instance:getChapterCOList()
	local var_17_1

	for iter_17_0 = #var_17_0, 1, -1 do
		local var_17_2 = var_17_0[iter_17_0]

		if arg_17_0:chapterIsLock(var_17_2.id) == false and var_17_2.type == DungeonEnum.ChapterType.Normal then
			local var_17_3 = DungeonConfig.instance:getChapterEpisodeCOList(var_17_2.id)

			if var_17_3 then
				for iter_17_1 = #var_17_3, 1, -1 do
					local var_17_4 = var_17_3[iter_17_1]
					local var_17_5 = arg_17_0:getEpisodeInfo(var_17_4.id)

					if var_17_5 and arg_17_0:isFinishElementList(var_17_4) then
						if var_17_4.type ~= DungeonEnum.EpisodeType.Sp then
							return var_17_4, var_17_5
						elseif var_17_1 and var_17_1.type ~= DungeonEnum.EpisodeType.Sp and var_17_1.preEpisode == var_17_4.id then
							return var_17_4, var_17_5
						end
					end

					var_17_1 = var_17_4
				end
			end
		end
	end
end

function var_0_0.getEpisodeInfo(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._dungeonEpisodeDic[arg_18_1]

	if not var_18_0 then
		local var_18_1 = DungeonConfig.instance:getEpisodeCO(arg_18_1)

		if arg_18_0:isUnlock(var_18_1) then
			var_18_0 = UserDungeonMO.New()

			var_18_0:initFromManual(var_18_1.chapterId, var_18_1.id, 0, 0)

			arg_18_0._dungeonEpisodeDic[arg_18_1] = var_18_0
		end
	end

	return var_18_0
end

function var_0_0.getEpisodeChallengeCount(arg_19_0, arg_19_1)
	local var_19_0 = DungeonConfig.instance:getEpisodeCO(arg_19_1)
	local var_19_1 = DungeonConfig.instance:getChapterCO(var_19_0.chapterId)
	local var_19_2 = -1
	local var_19_3 = -1

	if not string.nilorempty(var_19_1.challengeCountLimit) then
		local var_19_4 = string.split(var_19_1.challengeCountLimit, "#")

		var_19_2 = tonumber(var_19_4[1])
		var_19_3 = tonumber(var_19_4[2])
	end

	local var_19_5 = arg_19_0:getEpisodeInfo(arg_19_1)

	return var_19_2, var_19_3, var_19_5.challengeCount
end

function var_0_0.chapterIsLock(arg_20_0, arg_20_1)
	local var_20_0 = true
	local var_20_1
	local var_20_2
	local var_20_3 = DungeonConfig.instance:getChapterCO(arg_20_1)

	if VersionValidator.instance:isInReviewing() and not ResSplitConfig.instance:getAllChapterIds()[arg_20_1] then
		return true
	end

	if not var_20_3 then
		return true
	end

	if var_20_3.type == DungeonEnum.ChapterType.Gold then
		var_20_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon)

		local var_20_4

		var_20_1, var_20_4 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GoldDungeon)
	elseif var_20_3.type == DungeonEnum.ChapterType.Exp then
		var_20_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon)

		local var_20_5

		var_20_1, var_20_5 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ExperienceDungeon)
	elseif var_20_3.type == DungeonEnum.ChapterType.Buildings then
		var_20_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings)

		local var_20_6

		var_20_1, var_20_6 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Buildings)
	elseif var_20_3.type == DungeonEnum.ChapterType.Equip then
		var_20_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)

		local var_20_7

		var_20_1, var_20_7 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.EquipDungeon)
	end

	if arg_20_1 == DungeonEnum.ChapterId.HeroInvitation then
		var_20_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HeroInvitation)

		local var_20_8

		var_20_1, var_20_8 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HeroInvitation)
	end

	if not var_20_0 then
		return true, -4, var_20_1
	end

	if arg_20_0._dungeonChapterDic[arg_20_1] then
		return false
	end

	local var_20_9 = false
	local var_20_10 = DungeonConfig.instance:getChapterEpisodeCOList(arg_20_1)

	if var_20_10 and #var_20_10 > 0 then
		for iter_20_0, iter_20_1 in ipairs(var_20_10) do
			if arg_20_0:isUnlock(iter_20_1) then
				var_20_9 = true

				break
			end
		end
	elseif var_20_3.preChapter > 0 and not arg_20_0:chapterIsLock(var_20_3.preChapter) then
		return false
	end

	if not (arg_20_1 == 103 or arg_20_1 == 104) or not ToastEnum.DungeonChapterLine3 then
		local var_20_11 = ToastEnum.UnreachUnlockCondition
	end

	if var_20_9 == false then
		return true, -1, 114
	end

	if var_20_3.rewardPoint > 0 and var_20_3.preChapter > 0 and DungeonMapModel.instance:getRewardPointValue(var_20_3.preChapter) < var_20_3.rewardPoint then
		return true, -3, 133, var_20_3.rewardPoint
	end

	if PlayerModel.instance:getPlayinfo().level < var_20_3.openLevel then
		return true, -2, 134, var_20_3.openLevel
	end

	return false
end

function var_0_0.getCantChallengeToast(arg_21_0, arg_21_1)
	local var_21_0, var_21_1 = arg_21_0:isCanChallenge(arg_21_1)

	if var_21_0 then
		return nil
	end

	local var_21_2

	if var_21_1 == -1 then
		var_21_2 = arg_21_1.preEpisode
	elseif var_21_1 == -2 then
		var_21_2 = arg_21_1.unlockEpisode
	end

	if not var_21_2 then
		return
	end

	local var_21_3 = DungeonConfig.instance:getEpisodeCO(var_21_2)

	if not var_21_3 then
		return
	end

	local var_21_4 = DungeonConfig.instance:getChapterCO(var_21_3.chapterId)

	if not var_21_4 then
		return
	end

	local var_21_5 = DungeonConfig.instance:getChapterIndex(var_21_4.type, var_21_4.id)
	local var_21_6 = var_21_3
	local var_21_7 = var_21_4

	if var_21_4.type == DungeonEnum.ChapterType.Hard then
		var_21_6 = DungeonConfig.instance:getEpisodeCO(var_21_3.preEpisode)
		var_21_7 = DungeonConfig.instance:getChapterCO(var_21_6.chapterId)
	elseif var_21_4.type == DungeonEnum.ChapterType.Simple then
		var_21_6 = DungeonConfig.instance:getEpisodeCO(var_21_3.normalEpisodeId)
		var_21_7 = DungeonConfig.instance:getChapterCO(var_21_6.chapterId)
	end

	local var_21_8 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_21_7.id, var_21_6.id)
	local var_21_9 = ""

	if arg_21_1.type == DungeonEnum.EpisodeType.Sp then
		var_21_9 = string.format("SP-%s", var_21_8)
	else
		var_21_9 = string.format("%s-%s", GameUtil.getRomanNums(var_21_5), var_21_8)
	end

	local var_21_10 = ""

	if var_21_4.type == DungeonEnum.ChapterType.Normal then
		var_21_10 = luaLang("dungeon_lock_tips_normal")
	elseif var_21_4.type == DungeonEnum.ChapterType.Hard then
		var_21_10 = luaLang("dungeon_lock_tips_hard")
	elseif var_21_4.type == DungeonEnum.ChapterType.Simple then
		var_21_10 = luaLang("dungeon_simple_mode")
	end

	return string.format("%s%s", var_21_10, var_21_9)
end

function var_0_0.getChallengeUnlockText(arg_22_0, arg_22_1)
	local var_22_0, var_22_1 = arg_22_0:isCanChallenge(arg_22_1)
	local var_22_2

	if var_22_1 == -1 then
		var_22_2 = arg_22_1.preEpisode
	elseif var_22_1 == -2 then
		var_22_2 = arg_22_1.unlockEpisode
	end

	if not var_22_2 then
		return
	end

	local var_22_3 = DungeonConfig.instance:getEpisodeCO(var_22_2)

	if not var_22_3 then
		return
	end

	local var_22_4 = DungeonConfig.instance:getChapterCO(var_22_3.chapterId)

	if not var_22_4 then
		return
	end

	local var_22_5 = DungeonConfig.instance:getChapterIndex(var_22_4.type, var_22_4.id)
	local var_22_6 = var_22_3
	local var_22_7 = var_22_4

	if var_22_4.type == DungeonEnum.ChapterType.Hard then
		var_22_6 = DungeonConfig.instance:getEpisodeCO(var_22_3.preEpisode)
		var_22_7 = DungeonConfig.instance:getChapterCO(var_22_6.chapterId)
	elseif var_22_4.type == DungeonEnum.ChapterType.Simple then
		var_22_6 = DungeonConfig.instance:getEpisodeCO(var_22_3.normalEpisodeId)
		var_22_7 = DungeonConfig.instance:getChapterCO(var_22_6.chapterId)
	end

	local var_22_8 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_22_7.id, var_22_6.id)
	local var_22_9 = ""

	if var_22_3.type == DungeonEnum.EpisodeType.Sp then
		var_22_9 = string.format("SP-%s", var_22_8)
	else
		var_22_9 = string.format("%s-%s", var_22_5, var_22_8)
	end

	local var_22_10 = ""

	if var_22_4.type == DungeonEnum.ChapterType.Normal then
		var_22_10 = luaLang("dungeon_story_mode")
	elseif var_22_4.type == DungeonEnum.ChapterType.Hard then
		var_22_10 = luaLang("dungeon_hard_mode")
	elseif var_22_4.type == DungeonEnum.ChapterType.Simple then
		var_22_10 = luaLang("dungeon_simple_mode")
	end

	return string.format("%s %s", var_22_10, var_22_9)
end

function var_0_0.isCanChallenge(arg_23_0, arg_23_1)
	if not arg_23_0:isUnlock(arg_23_1) then
		return false, -1
	end

	if arg_23_1.unlockEpisode == 0 then
		return true
	end

	local var_23_0 = arg_23_0._dungeonEpisodeDic[arg_23_1.unlockEpisode]

	if var_23_0 and var_23_0.star > 0 then
		return true
	end

	return false, -2
end

function var_0_0.startCheckUnlockChapter(arg_24_0)
	if arg_24_0._chapterStatus then
		return
	end

	arg_24_0._chapterStatus = {}
	arg_24_0._otherChapterUnlock = {}

	local var_24_0 = DungeonConfig.instance:getNormalChapterList()

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		arg_24_0._chapterStatus[iter_24_1.id] = arg_24_0:chapterIsLock(iter_24_1.id)
	end
end

function var_0_0.endCheckUnlockChapter(arg_25_0)
	if not arg_25_0._chapterStatus then
		return
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0._chapterStatus) do
		if iter_25_1 and iter_25_1 ~= arg_25_0:chapterIsLock(iter_25_0) then
			arg_25_0._chapterStatus[iter_25_0] = false
			arg_25_0.unlockNewChapterId = iter_25_0
			arg_25_0.chapterTriggerNewChapter = true

			local var_25_0 = DungeonConfig.instance:getChapterCO(iter_25_0)

			if var_25_0 and var_25_0.rewardPoint > 0 then
				GameFacade.showToast(ToastEnum.UnlockChapter)
			end

			break
		end
	end

	for iter_25_2, iter_25_3 in pairs(arg_25_0._chapterStatus) do
		if iter_25_3 and iter_25_3 ~= arg_25_0:chapterIsLock(iter_25_2) then
			arg_25_0._chapterStatus[iter_25_2] = false
			arg_25_0._otherChapterUnlock[iter_25_2] = true
		end
	end
end

function var_0_0.needUnlockChapterAnim(arg_26_0, arg_26_1)
	return arg_26_0._otherChapterUnlock and arg_26_0._otherChapterUnlock[arg_26_1]
end

function var_0_0.clearUnlockChapterAnim(arg_27_0, arg_27_1)
	if not arg_27_0._otherChapterUnlock then
		return
	end

	arg_27_0._otherChapterUnlock[arg_27_1] = nil
end

function var_0_0.clearUnlockNewChapterId(arg_28_0, arg_28_1)
	if arg_28_1 == arg_28_0.unlockNewChapterId then
		arg_28_0.chapterTriggerNewChapter = nil
		arg_28_0.unlockNewChapterId = nil
	end
end

function var_0_0.isFinishElementList(arg_29_0, arg_29_1)
	if not arg_29_1 then
		return false
	end

	if string.nilorempty(arg_29_1.elementList) then
		return true
	end

	local var_29_0 = string.splitToNumber(arg_29_1.elementList, "#")

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		if DungeonMapModel.instance:getElementById(iter_29_1) then
			return false
		end
	end

	return true
end

function var_0_0.isUnlock(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return false
	end

	if arg_30_1.preEpisode2 == 0 then
		return true
	end

	local var_30_0 = arg_30_0._dungeonEpisodeDic[arg_30_1.preEpisode]

	if var_30_0 and var_30_0.star > 0 then
		local var_30_1 = DungeonConfig.instance:getEpisodeCO(arg_30_1.preEpisode)

		if var_30_1.afterStory > 0 then
			if StoryModel.instance:isStoryFinished(var_30_1.afterStory) then
				return true
			end
		else
			return true
		end
	end

	local var_30_2 = arg_30_0._dungeonEpisodeDic[arg_30_1.preEpisode2]

	if var_30_2 and var_30_2.star > 0 then
		local var_30_3 = DungeonConfig.instance:getEpisodeCO(arg_30_1.preEpisode2)

		if var_30_3.afterStory > 0 then
			if StoryModel.instance:isStoryFinished(var_30_3.afterStory) then
				return true
			end
		else
			return true
		end
	end

	return false
end

local var_0_1 = {
	[DungeonEnum.EpisodeType.Sp] = true,
	[DungeonEnum.EpisodeType.Equip] = true,
	[DungeonEnum.EpisodeType.SpecialEquip] = true,
	[DungeonEnum.EpisodeType.WeekWalk] = true,
	[DungeonEnum.EpisodeType.WeekWalk_2] = true,
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
	[DungeonEnum.EpisodeType.Season166Teach] = true,
	[DungeonEnum.EpisodeType.TowerPermanent] = true,
	[DungeonEnum.EpisodeType.TowerBoss] = true,
	[DungeonEnum.EpisodeType.TowerLimited] = true,
	[DungeonEnum.EpisodeType.TowerBossTeach] = true,
	[DungeonEnum.EpisodeType.Act183] = true,
	[DungeonEnum.EpisodeType.Act191] = true,
	[DungeonEnum.EpisodeType.Odyssey] = true,
	[DungeonEnum.EpisodeType.Assassin2Outside] = true
}

function var_0_0.isBattleEpisode(arg_31_0)
	return arg_31_0.type <= DungeonEnum.EpisodeType.Boss or var_0_1[arg_31_0.type]
end

function var_0_0.getEpisodeBonus(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:isReactivityEpisode(arg_32_1)
	local var_32_1 = arg_32_0:isPermanentEpisode(arg_32_1) and "permanentBonus" or var_32_0 and "retroBonus" or "bonus"

	if arg_32_2 and not DungeonConfig.instance:isNewReward(arg_32_1, var_32_1) then
		return {}
	end

	return arg_32_0:_getEpisodeBonusByType(arg_32_1, var_32_1)
end

function var_0_0.getEpisodeFreeBonus(arg_33_0, arg_33_1)
	return arg_33_0:_getEpisodeBonusByType(arg_33_1, "freeBonus")
end

function var_0_0._getEpisodeBonusByType(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = DungeonConfig.instance:getEpisodeCO(arg_34_1)
	local var_34_1 = DungeonConfig.instance:getBonusCO(var_34_0[arg_34_2])
	local var_34_2 = {}

	if var_34_1 then
		local var_34_3 = var_34_1.fixBonus

		if not string.nilorempty(var_34_3) then
			local var_34_4 = string.split(var_34_3, "|")

			for iter_34_0, iter_34_1 in ipairs(var_34_4) do
				local var_34_5 = string.split(iter_34_1, "#")

				table.insert(var_34_2, var_34_5)
			end
		end
	end

	local var_34_6 = DungeonConfig.instance:getRewardItems(var_34_0[arg_34_2])

	if var_34_6 then
		for iter_34_2, iter_34_3 in ipairs(var_34_6) do
			table.insert(var_34_2, iter_34_3)
		end
	end

	return var_34_2
end

function var_0_0.getEpisodeReward(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:isReactivityEpisode(arg_35_1)
	local var_35_1 = arg_35_0:isPermanentEpisode(arg_35_1) and "permanentReward" or var_35_0 and "retroReward" or "reward"
	local var_35_2 = arg_35_0:_getEpisodeBonusByType(arg_35_1, var_35_1)

	for iter_35_0, iter_35_1 in pairs(var_35_2) do
		iter_35_1.starType = DungeonEnum.StarType.Normal
	end

	return var_35_2
end

function var_0_0.getEpisodeFirstBonus(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:isReactivityEpisode(arg_36_1)
	local var_36_1 = arg_36_0:isPermanentEpisode(arg_36_1) and "permanentFirstBonus" or var_36_0 and "retroFirstBonus" or "firstBonus"
	local var_36_2 = arg_36_0:_getEpisodeBonusByType(arg_36_1, var_36_1)

	for iter_36_0, iter_36_1 in pairs(var_36_2) do
		iter_36_1.starType = DungeonEnum.StarType.Normal
	end

	return var_36_2
end

function var_0_0.getEpisodeAdvancedBonus(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:isReactivityEpisode(arg_37_1)
	local var_37_1 = arg_37_0:isPermanentEpisode(arg_37_1) and "permanentAdvancedBonus" or var_37_0 and "retroAdvancedBonus" or "advancedBonus"
	local var_37_2 = arg_37_0:_getEpisodeBonusByType(arg_37_1, var_37_1)

	for iter_37_0, iter_37_1 in pairs(var_37_2) do
		iter_37_1.starType = DungeonEnum.StarType.Advanced
	end

	return var_37_2
end

function var_0_0.isReactivityEpisode(arg_38_0, arg_38_1)
	local var_38_0 = DungeonConfig.instance:getEpisodeCO(arg_38_1)

	if not var_38_0 then
		return false
	end

	local var_38_1 = var_38_0.chapterId
	local var_38_2 = DungeonConfig.instance:getChapterCO(var_38_1)

	if not var_38_2 then
		return false
	end

	local var_38_3 = var_38_2.actId

	return ReactivityModel.instance:isReactivity(var_38_3)
end

function var_0_0.isPermanentEpisode(arg_39_0, arg_39_1)
	local var_39_0 = DungeonConfig.instance:getEpisodeCO(arg_39_1)
	local var_39_1 = DungeonConfig.instance:getChapterCO(var_39_0.chapterId).actId

	if var_39_1 == 0 then
		return false
	end

	return ActivityConfig.instance:getActivityCo(var_39_1).isRetroAcitivity == ActivityEnum.RetroType.Permanent
end

function var_0_0.getEpisodeRewardDisplayList(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:isReactivityEpisode(arg_40_1)
	local var_40_1 = arg_40_0:isPermanentEpisode(arg_40_1) and "permanentRewardDisplayList" or var_40_0 and "retroRewardDisplayList" or "rewardDisplayList"

	return arg_40_0:_getEpisodeDisplayList(arg_40_1, var_40_1)
end

function var_0_0.getEpisodeRewardList(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:isReactivityEpisode(arg_41_1)
	local var_41_1 = arg_41_0:isPermanentEpisode(arg_41_1) and "permanentRewardList" or var_41_0 and "retroRewardList" or "rewardList"

	return arg_41_0:_getEpisodeDisplayList(arg_41_1, var_41_1)
end

function var_0_0.getEpisodeFreeDisplayList(arg_42_0, arg_42_1)
	return arg_42_0:_getEpisodeDisplayList(arg_42_1, "freeDisplayList")
end

function var_0_0._getEpisodeDisplayList(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = DungeonConfig.instance:getEpisodeCO(arg_43_1)
	local var_43_1 = {}
	local var_43_2 = var_43_0[arg_43_2]

	if string.nilorempty(var_43_2) then
		return var_43_1
	end

	local var_43_3 = string.split(var_43_2, "|")

	for iter_43_0, iter_43_1 in ipairs(var_43_3) do
		local var_43_4 = string.split(iter_43_1, "#")

		table.insert(var_43_1, var_43_4)
	end

	return var_43_1
end

function var_0_0.getMonsterDisplayList(arg_44_0, arg_44_1)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(string.splitToNumber(arg_44_1, "#")) do
		table.insert(var_44_0, lua_monster.configDict[iter_44_1])
	end

	return var_44_0
end

function var_0_0.chapterListIsNormalType(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_1 or arg_45_0.curChapterType

	return DungeonEnum.ChapterType.Normal == var_45_0
end

function var_0_0.chapterListIsResType(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_1 or arg_46_0.curChapterType

	return var_46_0 >= DungeonEnum.ChapterType.Gold and var_46_0 <= DungeonEnum.ChapterType.Equip or DungeonEnum.ChapterType.SpecialEquip == var_46_0 or DungeonEnum.ChapterType.Buildings == var_46_0
end

function var_0_0.chapterListIsBreakType(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1 or arg_47_0.curChapterType

	return DungeonEnum.ChapterType.Break == var_47_0
end

function var_0_0.chapterListIsWeekWalkType(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1 or arg_48_0.curChapterType

	return var_48_0 == DungeonEnum.ChapterType.WeekWalk or var_48_0 == DungeonEnum.ChapterType.WeekWalk_2
end

function var_0_0.chapterListIsSeasonType(arg_49_0, arg_49_1)
	return (arg_49_1 or arg_49_0.curChapterType) == DungeonEnum.ChapterType.Season
end

function var_0_0.chapterListIsExploreType(arg_50_0, arg_50_1)
	return (arg_50_1 or arg_50_0.curChapterType) == DungeonEnum.ChapterType.Explore
end

function var_0_0.chapterListIsRoleStory(arg_51_0, arg_51_1)
	return (arg_51_1 or arg_51_0.curChapterType) == DungeonEnum.ChapterType.RoleStory
end

function var_0_0.chapterListIsPermanent(arg_52_0, arg_52_1)
	return (arg_52_1 or arg_52_0.curChapterType) == DungeonEnum.ChapterType.PermanentActivity
end

function var_0_0.chapterListIsTower(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1 or arg_53_0.curChapterType
	local var_53_1 = var_53_0 == DungeonEnum.ChapterType.TowerPermanent

	var_53_1 = var_53_1 or var_53_0 == DungeonEnum.ChapterType.TowerBoss
	var_53_1 = var_53_1 or var_53_0 == DungeonEnum.ChapterType.TowerLimited

	return var_53_1
end

function var_0_0.getChapterListTypes(arg_54_0, arg_54_1)
	return arg_54_0:chapterListIsNormalType(arg_54_1), arg_54_0:chapterListIsResType(arg_54_1), arg_54_0:chapterListIsBreakType(arg_54_1), arg_54_0:chapterListIsWeekWalkType(arg_54_1), arg_54_0:chapterListIsSeasonType(arg_54_1), arg_54_0:chapterListIsExploreType(arg_54_1)
end

function var_0_0.getChapterListOpenTimeValid(arg_55_0, arg_55_1)
	local var_55_0 = {}
	local var_55_1, var_55_2, var_55_3, var_55_4, var_55_5, var_55_6 = arg_55_0:getChapterListTypes(arg_55_1)

	if var_55_1 then
		var_55_0 = DungeonConfig.instance:getChapterCOListByType(arg_55_1)
	elseif var_55_2 then
		local var_55_7 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold)

		tabletool.addValues(var_55_0, var_55_7)

		local var_55_8 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp)

		tabletool.addValues(var_55_0, var_55_8)

		local var_55_9 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip)

		tabletool.addValues(var_55_0, var_55_9)
	elseif var_55_3 then
		var_55_0 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
	elseif var_55_4 then
		var_55_0 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.WeekWalk)
	elseif var_55_6 then
		var_55_0 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Explore)
	end

	for iter_55_0, iter_55_1 in ipairs(var_55_0) do
		if arg_55_0:getChapterOpenTimeValid(iter_55_1) then
			return true
		end
	end

	return false
end

function var_0_0.getChapterOpenTimeValid(arg_56_0, arg_56_1)
	if LuaUtil.isEmptyStr(arg_56_1.openDay) then
		return true
	end

	local var_56_0 = ServerTime.weekDayInServerLocal()
	local var_56_1 = GameUtil.splitString2(arg_56_1.openDay, true, "|", "#")

	for iter_56_0, iter_56_1 in ipairs(var_56_1) do
		for iter_56_2, iter_56_3 in ipairs(iter_56_1) do
			if tonumber(iter_56_3) == var_56_0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.isOpenHardDungeon(arg_57_0, arg_57_1, arg_57_2)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		return false
	end

	if arg_57_2 then
		local var_57_0 = arg_57_0:getEpisodeInfo(arg_57_2)

		if not var_57_0 or var_57_0.star < DungeonEnum.StarType.Advanced then
			return false
		end
	end

	return true
end

function var_0_0.chapterIsPass(arg_58_0, arg_58_1)
	local var_58_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_58_1)

	if var_58_0 then
		for iter_58_0, iter_58_1 in ipairs(var_58_0) do
			if not arg_58_0:hasPassLevelAndStory(iter_58_1.id) then
				return false
			end
		end
	end

	return true
end

function var_0_0.hasPassLevel(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0:getEpisodeInfo(arg_59_1)

	return var_59_0 and var_59_0.star > DungeonEnum.StarType.None
end

function var_0_0.hasPassLevelAndStory(arg_60_0, arg_60_1)
	if not arg_60_0:hasPassLevel(arg_60_1) then
		return false
	end

	local var_60_0 = DungeonConfig.instance:getEpisodeCO(arg_60_1)

	if var_60_0.afterStory > 0 and not StoryModel.instance:isStoryFinished(var_60_0.afterStory) then
		return false
	end

	return true
end

function var_0_0.getUnlockContentList(arg_61_0, arg_61_1)
	local var_61_0 = {}
	local var_61_1 = OpenConfig.instance:getOpenShowInEpisode(arg_61_1)

	if var_61_1 then
		for iter_61_0, iter_61_1 in ipairs(var_61_1) do
			local var_61_2 = lua_open.configDict[iter_61_1].bindActivityId

			if var_61_2 ~= 0 then
				local var_61_3 = ActivityHelper.getActivityStatus(var_61_2)

				if var_61_3 == ActivityEnum.ActivityStatus.Normal or var_61_3 == ActivityEnum.ActivityStatus.NotUnlock then
					local var_61_4 = arg_61_0:getUnlockContent(DungeonEnum.UnlockContentType.Open, iter_61_1)

					if var_61_4 then
						table.insert(var_61_0, var_61_4)
					end
				end
			else
				local var_61_5 = arg_61_0:getUnlockContent(DungeonEnum.UnlockContentType.Open, iter_61_1)

				if var_61_5 then
					table.insert(var_61_0, var_61_5)
				end
			end
		end
	end

	local var_61_6 = DungeonConfig.instance:getUnlockEpisodeList(arg_61_1)

	if var_61_6 then
		for iter_61_2, iter_61_3 in ipairs(var_61_6) do
			local var_61_7 = arg_61_0:getUnlockContent(DungeonEnum.UnlockContentType.Episode, iter_61_3)

			if var_61_7 then
				table.insert(var_61_0, var_61_7)
			end
		end
	end

	local var_61_8 = OpenConfig.instance:getOpenGroupShowInEpisode(arg_61_1)

	if var_61_8 then
		for iter_61_4, iter_61_5 in ipairs(var_61_8) do
			local var_61_9 = arg_61_0:getUnlockContent(DungeonEnum.UnlockContentType.OpenGroup, iter_61_5)

			if var_61_9 then
				table.insert(var_61_0, var_61_9)
			end
		end
	end

	return var_61_0
end

function var_0_0.getUnlockContent(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_1 == DungeonEnum.UnlockContentType.Open then
		return string.format(luaLang("dungeon_unlock_content_1"), lua_open.configDict[arg_62_2].name)
	elseif arg_62_1 == DungeonEnum.UnlockContentType.Episode then
		local var_62_0 = DungeonConfig.instance:getEpisodeCO(arg_62_2)

		return string.format(luaLang("dungeon_unlock_content_2"), string.format("%s %s", DungeonController.getEpisodeName(var_62_0), var_62_0.name))
	elseif arg_62_1 == DungeonEnum.UnlockContentType.OpenGroup then
		return string.format(luaLang("dungeon_unlock_content_3"), arg_62_2)
	elseif arg_62_1 == DungeonEnum.UnlockContentType.ActivityOpen then
		return string.format(luaLang("dungeon_unlock_content_4"), lua_open.configDict[arg_62_2].name)
	end
end

function var_0_0.setDungeonStoryviewState(arg_63_0, arg_63_1)
	arg_63_0._isDungeonStoryView = arg_63_1
end

function var_0_0.getDungeonStoryState(arg_64_0)
	return arg_64_0._isDungeonStoryView
end

function var_0_0.setLastSelectMode(arg_65_0, arg_65_1, arg_65_2)
	arg_65_0._lastSelectEpisodeId = arg_65_2
	arg_65_0._lastSelectChapterType = arg_65_1
end

function var_0_0.getLastSelectMode(arg_66_0)
	return arg_66_0._lastSelectChapterType, arg_66_0._lastSelectEpisodeId
end

function var_0_0.hasPassAllChapterEpisode(arg_67_0, arg_67_1)
	local var_67_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_67_1)

	for iter_67_0, iter_67_1 in ipairs(var_67_0) do
		if not arg_67_0:hasPassLevelAndStory(iter_67_1.id) then
			return false
		end
	end

	return true
end

function var_0_0.chapterIsUnLock(arg_68_0, arg_68_1)
	local var_68_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_68_1)

	if var_68_0 and #var_68_0 > 0 then
		return arg_68_0:hasPassLevelAndStory(var_68_0[1].preEpisode), var_68_0[1].preEpisode
	end

	return false, nil
end

function var_0_0.episodeIsInLockTime(arg_69_0, arg_69_1)
	local var_69_0 = DungeonConfig.instance:getEpisodeCO(arg_69_1)

	if not var_69_0 or string.nilorempty(var_69_0.lockTime) then
		return false
	end

	local var_69_1 = ServerTime.now() * 1000
	local var_69_2 = string.splitToNumber(var_69_0.lockTime, "#")

	if var_69_2[1] and var_69_2[2] then
		return var_69_1 > var_69_2[1] and var_69_1 < var_69_2[2]
	end

	return false
end

function var_0_0.getMapElementReward(arg_70_0, arg_70_1)
	local var_70_0 = lua_chapter_map_element.configDict[arg_70_1]

	if not var_70_0 then
		return
	end

	local var_70_1 = lua_chapter_map.configDict[var_70_0.mapId].chapterId
	local var_70_2 = DungeonConfig.instance:getChapterCO(var_70_1)
	local var_70_3 = var_70_2 and ReactivityModel.instance:isReactivity(var_70_2.actId) or false

	if var_70_2.actId ~= 0 and ActivityConfig.instance:isPermanent(var_70_2.actId) then
		return var_70_0.permanentReward
	else
		return var_70_3 and var_70_0.retroReward or var_70_0.reward
	end
end

function var_0_0.isSpecialMainPlot(arg_71_0, arg_71_1)
	return DungeonEnum.SpecialMainPlot[arg_71_1] ~= nil
end

function var_0_0.getChapterRedId(arg_72_0, arg_72_1)
	if arg_72_1 == DungeonEnum.ChapterId.HeroInvitation then
		return RedDotEnum.DotNode.HeroInvitationReward
	end
end

function var_0_0.setCanGetDramaReward(arg_73_0, arg_73_1)
	arg_73_0.canGetDramaReward = arg_73_1
end

function var_0_0.isCanGetDramaReward(arg_74_0)
	return arg_74_0.canGetDramaReward
end

function var_0_0.getLastFightEpisodePassMode(arg_75_0, arg_75_1)
	local var_75_0 = DungeonConfig.instance:getEpisodeCO(arg_75_1.preEpisode)
	local var_75_1 = arg_75_1.chapterId == var_75_0.chapterId

	while var_75_0.type == DungeonEnum.EpisodeType.Story and var_75_1 do
		var_75_0 = DungeonConfig.instance:getEpisodeCO(var_75_0.preEpisode)
		var_75_1 = arg_75_1.chapterId == var_75_0.chapterId
	end

	if var_75_1 and not arg_75_0:hasPassLevel(var_75_0.id) then
		return DungeonEnum.ChapterType.Simple
	end

	return DungeonEnum.ChapterType.Normal
end

var_0_0.instance = var_0_0.New()

return var_0_0

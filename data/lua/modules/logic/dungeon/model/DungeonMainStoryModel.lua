module("modules.logic.dungeon.model.DungeonMainStoryModel", package.seeall)

local var_0_0 = class("DungeonMainStoryModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._selectedSectionId = nil
	arg_2_0._clickChapterId = nil
	arg_2_0._chapterList = nil
	arg_2_0._jumpFocusChapterId = nil
	arg_2_0._guides = nil
end

function var_0_0.getConflictGuides(arg_3_0)
	if not arg_3_0._guides then
		arg_3_0._guides = {
			102,
			116,
			122,
			132,
			136,
			501,
			14500,
			19317,
			19319,
			19701,
			23201
		}
	end

	return arg_3_0._guides
end

function var_0_0.setChapterList(arg_4_0, arg_4_1)
	arg_4_0._chapterList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = DungeonConfig.instance:getChapterDivideSectionId(iter_4_1.id)
		local var_4_1 = arg_4_0._chapterList[var_4_0] or {}

		table.insert(var_4_1, iter_4_1)

		if var_4_0 then
			arg_4_0._chapterList[var_4_0] = var_4_1
		else
			logError(string.format("chapterId:%s 未加入主线分节配置,获取不到大章节id", iter_4_1.id))
		end
	end
end

function var_0_0.getChapterList(arg_5_0, arg_5_1)
	if not arg_5_0._chapterList then
		arg_5_0:forceUpdateChapterList()
	end

	return arg_5_1 and arg_5_0._chapterList[arg_5_1]
end

function var_0_0.forceUpdateChapterList(arg_6_0)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal, true)
end

function var_0_0.setSectionSelected(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._selectedSectionId = arg_7_1

	local var_7_0 = var_0_0.getKey(PlayerPrefsKey.SelectDungeonSection)

	PlayerPrefsHelper.setNumber(var_7_0, arg_7_1 or 0)

	if not arg_7_1 or arg_7_2 then
		arg_7_0:saveClickChapterId()
	end
end

function var_0_0.clearSectionSelected(arg_8_0)
	arg_8_0._selectedSectionId = nil
end

function var_0_0.getSelectedSectionId(arg_9_0)
	return arg_9_0._selectedSectionId
end

function var_0_0.initSelectedSectionId(arg_10_0)
	local var_10_0 = var_0_0.getKey(PlayerPrefsKey.SelectDungeonSection)

	arg_10_0._selectedSectionId = PlayerPrefsHelper.getNumber(var_10_0)
end

function var_0_0.saveClickChapterId(arg_11_0, arg_11_1)
	arg_11_0._clickChapterId = arg_11_1

	local var_11_0 = var_0_0.getKey(PlayerPrefsKey.SelectDungeonChapter)

	PlayerPrefsHelper.setNumber(var_11_0, arg_11_1 or 0)
end

function var_0_0.saveBattleChapterId(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = DungeonConfig.instance:getEpisodeCO(arg_12_1)

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.chapterId
	local var_12_2 = DungeonConfig.instance:getChapterCO(var_12_1)

	if not var_12_2 then
		return
	end

	if var_12_2.type == DungeonEnum.ChapterType.Normal then
		if not DungeonConfig.instance:getChapterDivideSectionId(var_12_1) then
			return
		end

		arg_12_0:saveClickChapterId(var_12_1)
	end
end

function var_0_0.getClickChapterId(arg_13_0)
	if not arg_13_0._clickChapterId then
		local var_13_0 = var_0_0.getKey(PlayerPrefsKey.SelectDungeonChapter)
		local var_13_1 = PlayerPrefsHelper.getNumber(var_13_0, 0)

		if var_13_1 ~= 0 then
			arg_13_0._clickChapterId = var_13_1
		end
	end

	return arg_13_0._clickChapterId
end

function var_0_0.sectionIsSelected(arg_14_0, arg_14_1)
	return arg_14_0._selectedSectionId == arg_14_1
end

function var_0_0.setJumpFocusChapterId(arg_15_0, arg_15_1)
	arg_15_0._jumpFocusChapterId = arg_15_1
end

function var_0_0.getJumpFocusChapterIdOnce(arg_16_0)
	local var_16_0 = arg_16_0._jumpFocusChapterId

	arg_16_0._jumpFocusChapterId = nil

	return var_16_0
end

function var_0_0.sectionChapterAllPassed(arg_17_0, arg_17_1)
	local var_17_0 = lua_chapter_divide.configDict[arg_17_1]
	local var_17_1 = var_17_0 and var_17_0.chapterId

	if not var_17_1 then
		return false
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if not DungeonModel.instance:chapterIsPass(iter_17_1) then
			return false
		end
	end

	return true
end

function var_0_0.isUnlockInPreviewChapter(arg_18_0)
	local var_18_0 = DungeonConfig.instance:getEpisodeCO(arg_18_0)

	if not var_18_0 then
		return false
	end

	local var_18_1 = DungeonConfig.instance:getChapterCO(var_18_0.chapterId)

	if not var_18_1 then
		return false
	end

	local var_18_2 = var_18_1.eaActivityId

	if var_18_2 == 0 then
		return false
	end

	local var_18_3 = DungeonConfig.instance:getPreviewChapterList(var_18_1.id)
	local var_18_4 = false
	local var_18_5 = false

	for iter_18_0, iter_18_1 in ipairs(var_18_3) do
		local var_18_6 = DungeonConfig.instance:getChapterEpisodeCOList(iter_18_1.id)

		if var_18_6 and var_18_6[1] then
			local var_18_7 = var_18_6[1].id

			if arg_18_0 == var_18_7 then
				var_18_4 = true
			end

			if DungeonModel.instance:onlyCheckPassLevel(var_18_7) then
				var_18_5 = true
			end
		end
	end

	if not var_18_4 then
		return false
	end

	return ActivityHelper.getActivityStatus(var_18_2) == ActivityEnum.ActivityStatus.Normal or var_18_5
end

function var_0_0.showPreviewChapterFlag(arg_19_0, arg_19_1)
	if not DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_1) then
		return false
	end

	local var_19_0 = DungeonConfig.instance:getChapterCO(arg_19_1)

	if not var_19_0 then
		return false
	end

	local var_19_1 = var_19_0.eaActivityId

	if var_19_1 == 0 then
		return false
	end

	if ActivityHelper.getActivityStatus(var_19_1) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	if var_19_0.preChapter > 0 and arg_19_0:_bothPreChaptersFinished(var_19_0.preChapter) then
		return false
	end

	return true
end

function var_0_0._bothPreChaptersFinished(arg_20_0, arg_20_1)
	if arg_20_1 <= 0 then
		return true
	end

	local var_20_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_20_1)

	if var_20_0 then
		local var_20_1 = var_20_0[#var_20_0]

		if var_20_1 and (DungeonModel.instance:hasPassLevelAndStory(var_20_1.id) or DungeonModel.instance:hasPassLevelAndStory(var_20_1.chainEpisode)) then
			return true
		end
	end

	return false
end

function var_0_0.hasPreviewChapterHistory(arg_21_0, arg_21_1)
	if not DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_1) then
		return false
	end

	local var_21_0 = DungeonConfig.instance:getChapterCO(arg_21_1)

	if var_21_0 and var_21_0.eaActivityId ~= 0 then
		if arg_21_0:_bothPreChaptersFinished(var_21_0.preChapter) then
			return true
		end

		local var_21_1 = DungeonConfig.instance:getPreviewChapterList(var_21_0.id)

		for iter_21_0, iter_21_1 in ipairs(var_21_1) do
			local var_21_2 = DungeonConfig.instance:getChapterEpisodeCOList(iter_21_1.id)

			if var_21_2 and var_21_2[1] and DungeonModel.instance:hasPassLevel(var_21_2[1].id) then
				return true
			end
		end
	end

	return false
end

function var_0_0.isPreviewChapter(arg_22_0, arg_22_1)
	return arg_22_0:showPreviewChapterFlag(arg_22_1) or arg_22_0:hasPreviewChapterHistory(arg_22_1)
end

function var_0_0.hasKey(arg_23_0, arg_23_1)
	local var_23_0 = var_0_0.getKey(arg_23_0, arg_23_1)

	return PlayerPrefsHelper.hasKey(var_23_0)
end

function var_0_0.getKey(arg_24_0, arg_24_1)
	return (string.format("%s%s_%s", arg_24_0, PlayerModel.instance:getPlayinfo().userId, arg_24_1))
end

var_0_0.instance = var_0_0.New()

return var_0_0

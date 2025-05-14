module("modules.logic.dungeon.audio.DungeonAudio", package.seeall)

local var_0_0 = class("DungeonAudio")
local var_0_1 = {
	[DungeonEnum.ChapterListType.Story] = {
		changeCategory = AudioEnum.UI.UI_checkpoint_story_Click,
		openChapter = AudioEnum.UI.UI_checkpoint_story_open,
		closeChapter = AudioEnum.UI.UI_checkpoint_story_close,
		chapterListBoundary = AudioEnum.UI.UI_checkpoint_story_rebound,
		cardPass = AudioEnum.UI.UI_checkpoint_story_cardpass
	},
	[DungeonEnum.ChapterListType.Resource] = {
		changeCategory = AudioEnum.UI.UI_checkpoint_resources_Click,
		openChapter = AudioEnum.UI.UI_checkpoint_resources_open,
		closeChapter = AudioEnum.UI.UI_checkpoint_resources_close,
		chapterListBoundary = AudioEnum.UI.UI_checkpoint_resources_rebound,
		cardPass = AudioEnum.UI.UI_checkpoint_resources_cardpass
	},
	[DungeonEnum.ChapterListType.Insight] = {
		changeCategory = AudioEnum.UI.UI_checkpoint_Insight_Click,
		openChapter = AudioEnum.UI.UI_checkpoint_Insight_open,
		closeChapter = AudioEnum.UI.UI_checkpoint_Insight_close,
		chapterListBoundary = AudioEnum.UI.UI_checkpoint_Insight_rebound,
		cardPass = AudioEnum.UI.UI_checkpoint_Insight_cardpass
	},
	[DungeonEnum.ChapterListType.WeekWalk] = {
		changeCategory = AudioEnum.UI.UI_checkpoint_Insight_Click,
		openChapter = AudioEnum.UI.UI_checkpoint_Insight_open,
		closeChapter = AudioEnum.UI.UI_checkpoint_Insight_close,
		chapterListBoundary = AudioEnum.UI.UI_checkpoint_Insight_rebound,
		cardPass = AudioEnum.UI.UI_checkpoint_Insight_cardpass
	}
}

function var_0_0._trigger(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:getChapterListType()
	local var_1_1 = var_0_1[var_1_0] and var_0_1[var_1_0][arg_1_1]

	if var_1_1 then
		AudioMgr.instance:trigger(var_1_1)
	end
end

function var_0_0.changeCategory(arg_2_0)
	arg_2_0:_trigger("changeCategory")
end

function var_0_0.openChapter(arg_3_0)
	arg_3_0:_trigger("openChapter")
end

function var_0_0.closeChapter(arg_4_0)
	arg_4_0:_trigger("closeChapter")
end

function var_0_0.openChapterAmbientSound(arg_5_0)
	local var_5_0 = arg_5_0:getChapterAmbientMusic()

	if var_5_0 <= 0 then
		return
	end

	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.DungeonAmbientSound, var_5_0, AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(var_5_0)
end

function var_0_0.closeChapterAmbientSound(arg_6_0, arg_6_1)
	if arg_6_0:getChapterAmbientMusic(arg_6_1) <= 0 then
		return
	end

	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.DungeonAmbientSound, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

function var_0_0.chapterListBoundary(arg_7_0)
	arg_7_0:_trigger("chapterListBoundary")
end

function var_0_0.cardPass(arg_8_0)
	arg_8_0:_trigger("cardPass")
end

function var_0_0.getChapterListType(arg_9_0)
	local var_9_0, var_9_1, var_9_2, var_9_3 = DungeonModel.instance:getChapterListTypes()

	if var_9_0 then
		return DungeonEnum.ChapterListType.Story
	end

	if var_9_1 then
		return DungeonEnum.ChapterListType.Resource
	end

	if var_9_2 then
		return DungeonEnum.ChapterListType.Insight
	end

	if var_9_3 then
		return DungeonEnum.ChapterListType.WeekWalk
	end
end

function var_0_0.getChapterAmbientMusic(arg_10_0, arg_10_1)
	local var_10_0 = DungeonConfig.instance:getChapterCO(arg_10_1 or DungeonModel.instance.curLookChapterId)

	return var_10_0 and var_10_0.ambientMusic or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0

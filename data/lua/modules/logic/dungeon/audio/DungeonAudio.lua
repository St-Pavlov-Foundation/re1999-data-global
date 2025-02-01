module("modules.logic.dungeon.audio.DungeonAudio", package.seeall)

slot0 = class("DungeonAudio")
slot1 = {
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

function slot0._trigger(slot0, slot1)
	if uv0[slot0:getChapterListType()] and uv0[slot2][slot1] then
		AudioMgr.instance:trigger(slot3)
	end
end

function slot0.changeCategory(slot0)
	slot0:_trigger("changeCategory")
end

function slot0.openChapter(slot0)
	slot0:_trigger("openChapter")
end

function slot0.closeChapter(slot0)
	slot0:_trigger("closeChapter")
end

function slot0.openChapterAmbientSound(slot0)
	if slot0:getChapterAmbientMusic() <= 0 then
		return
	end

	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.DungeonAmbientSound, slot1, AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(slot1)
end

function slot0.closeChapterAmbientSound(slot0, slot1)
	if slot0:getChapterAmbientMusic(slot1) <= 0 then
		return
	end

	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.DungeonAmbientSound, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

function slot0.chapterListBoundary(slot0)
	slot0:_trigger("chapterListBoundary")
end

function slot0.cardPass(slot0)
	slot0:_trigger("cardPass")
end

function slot0.getChapterListType(slot0)
	slot1, slot2, slot3, slot4 = DungeonModel.instance:getChapterListTypes()

	if slot1 then
		return DungeonEnum.ChapterListType.Story
	end

	if slot2 then
		return DungeonEnum.ChapterListType.Resource
	end

	if slot3 then
		return DungeonEnum.ChapterListType.Insight
	end

	if slot4 then
		return DungeonEnum.ChapterListType.WeekWalk
	end
end

function slot0.getChapterAmbientMusic(slot0, slot1)
	return DungeonConfig.instance:getChapterCO(slot1 or DungeonModel.instance.curLookChapterId) and slot2.ambientMusic or 0
end

slot0.instance = slot0.New()

return slot0

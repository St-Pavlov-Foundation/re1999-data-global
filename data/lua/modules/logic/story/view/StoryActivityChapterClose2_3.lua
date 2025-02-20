module("modules.logic.story.view.StoryActivityChapterClose2_3", package.seeall)

slot0 = class("StoryActivityChapterClose2_3", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v2a3/storyactivitychapterclose.prefab"
end

function slot0.onInitView(slot0)
	slot0.goEnd = gohelper.findChild(slot0.viewGO, "#simage_FullBG/end")
	slot0.goContinued = gohelper.findChild(slot0.viewGO, "#simage_FullBG/continue")
end

function slot0.onUpdateView(slot0)
	slot1 = tonumber(slot0.data) == 2

	gohelper.setActive(slot0.goEnd, slot1)
	gohelper.setActive(slot0.goContinued, not slot1)

	slot0._audioId = AudioEnum.Story.play_activitysfx_shenghuo_chapter_continue

	slot0:_playAudio()
end

function slot0._playAudio(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:playAudio(slot0._audioId)
	end
end

function slot0.onHide(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end
end

function slot0.onDestory(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end

	uv0.super.onDestory(slot0)
end

return slot0

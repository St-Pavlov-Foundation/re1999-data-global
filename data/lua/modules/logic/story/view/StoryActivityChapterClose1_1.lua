module("modules.logic.story.view.StoryActivityChapterClose1_1", package.seeall)

slot0 = class("StoryActivityChapterClose1_1", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v1a1/storyactivitychapterclose.prefab"
end

function slot0.onInitView(slot0)
	slot0._txtCloseNum = gohelper.findChildText(slot0.viewGO, "icon/#txt_chaptercloseNum")
end

function slot0.onUpdateView(slot0)
	slot0._txtCloseNum.text = slot0.data or ""
	slot0._audioId = slot0:getAudioId()

	TaskDispatcher.cancelTask(slot0._playAudio, slot0)
	TaskDispatcher.runDelay(slot0._playAudio, slot0, 1)
end

function slot0.getAudioId(slot0, slot1)
	return AudioEnum.Story.Activity_Chapter_End
end

function slot0._playAudio(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:playAudio(slot0._audioId)
	end
end

function slot0.onHide(slot0)
	TaskDispatcher.cancelTask(slot0._playAudio, slot0)

	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end
end

function slot0.onDestory(slot0)
	TaskDispatcher.cancelTask(slot0._playAudio, slot0)

	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end

	uv0.super.onDestory(slot0)
end

return slot0

module("modules.logic.story.view.StoryActivityChapterClose1_2", package.seeall)

slot0 = class("StoryActivityChapterClose1_2", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v1a2/storyactivitychapterclose.prefab"
end

function slot0.onInitView(slot0)
	slot0.node1 = gohelper.findChild(slot0.viewGO, "1")
	slot0.node2 = gohelper.findChild(slot0.viewGO, "2")
end

function slot0.onUpdateView(slot0)
	slot1 = tonumber(slot0.data) == 2

	gohelper.setActive(slot0.node1, not slot1)
	gohelper.setActive(slot0.node2, slot1)

	slot0._audioId = slot1 and AudioEnum.Story.Activity1_2_Chapter_End or AudioEnum.Story.Activity1_2_Chapter_Continue

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

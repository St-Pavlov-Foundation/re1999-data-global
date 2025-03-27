module("modules.logic.story.view.StoryActivityChapterClose2_4", package.seeall)

slot0 = class("StoryActivityChapterClose2_4", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v2a4/storyactivitychapterclose.prefab"
end

function slot0.onInitView(slot0)
	slot0.goEnd = gohelper.findChild(slot0.viewGO, "#simage_FullBG/end")
	slot0.goContinued = gohelper.findChild(slot0.viewGO, "#simage_FullBG/continue")
	slot0.simageBg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG/simagebg")
end

function slot0.onUpdateView(slot0)
	slot1 = tonumber(slot0.data) == 2

	gohelper.setActive(slot0.goEnd, slot1)
	gohelper.setActive(slot0.goContinued, not slot1)

	slot0._audioId = AudioEnum.Story.play_activitysfx_diqiu_chapter_continue

	slot0.simageBg:LoadImage(string.format("singlebg/v2a4_opening_singlebg/bg%s.jpg", slot1 and 3 or 2))
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

	slot0.simageBg:UnLoadImage()
	uv0.super.onDestory(slot0)
end

return slot0

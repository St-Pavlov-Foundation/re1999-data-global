module("modules.logic.story.view.StoryActivityChapterClose1_3", package.seeall)

slot0 = class("StoryActivityChapterClose1_3", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v1a3/storyactivitychapterclose.prefab"
end

function slot0.onInitView(slot0)
	slot0._simageFullBg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageIcon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG/title")

	slot0._simageFullBg:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_tobecontinued_bg.png")
end

function slot0.onUpdateView(slot0)
	slot0._audioId = AudioEnum.Story.Activity1_3_Chapter_End

	if not (tonumber(slot0.data) == 2) then
		slot0._simageIcon:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_tobecontinued.png")
	else
		slot0._simageIcon:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_theend.png")
	end

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
	if slot0._simageFullBg then
		slot0._simageFullBg:UnLoadImage()
	end

	if slot0._simageIcon then
		slot0._simageIcon:UnLoadImage()
	end

	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end

	uv0.super.onDestory(slot0)
end

return slot0

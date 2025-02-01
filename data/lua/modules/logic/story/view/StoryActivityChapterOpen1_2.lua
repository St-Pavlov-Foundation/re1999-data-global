module("modules.logic.story.view.StoryActivityChapterOpen1_2", package.seeall)

slot0 = class("StoryActivityChapterOpen1_2", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v1a2/storyactivitychapteropen.prefab"
end

function slot0.onInitView(slot0)
	slot0._goVideo = gohelper.findChild(slot0.viewGO, "#go_video")
	slot0._goMaskBg = gohelper.findChild(slot0.viewGO, "#maskBg")
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._singleBgTitle = gohelper.findChildSingleImage(slot0._goBg, "#simage_bgtitle")
end

function slot0.onUpdateView(slot0)
	slot3 = string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1

	if slot0:getVideoName(slot2[2] or 1) then
		if not slot0._videoItem then
			slot0._videoItem = StoryActivityVideoItem.New(slot0._goVideo)
		end

		slot0._videoItem:playVideo(slot5, {
			loop = false,
			outCallback = slot0.playStartVideoOut,
			outCallbackObj = slot0,
			audioId = slot0:getAudioId(slot4)
		})
	end

	gohelper.setActive(slot0._goMaskBg, true)

	if not string.nilorempty(string.format("bg_xiaobiaoti_%s", slot4)) then
		slot0._singleBgTitle:LoadImage(ResUrl.getActivityChapterLangPath(slot6))
	end

	if slot0:getDelayTime(slot4) and slot7 > 0 then
		TaskDispatcher.runDelay(slot0._playChapter2Anim, slot0, slot7)
	else
		slot0:_playChapter2Anim()
	end
end

function slot0.getVideoName(slot0, slot1)
	if slot1 == 0 then
		return "1_2_opening_0"
	end

	if slot1 < 18 or slot1 > 26 then
		return "1_2_opening_1"
	end
end

function slot0.getDelayTime(slot0, slot1)
	if slot1 == 0 then
		return 9.8
	end

	if slot1 < 18 or slot1 > 26 then
		return 6.96
	end

	return 0
end

function slot0.getAudioId(slot0, slot1)
	if slot1 == 0 then
		return AudioEnum.Story.Activity1_2_Chapter_Start
	end

	if slot1 < 18 or slot1 > 26 then
		return AudioEnum.Story.Activity1_2_Part_Start
	end
end

function slot0.playStartVideoOut(slot0)
end

function slot0._playChapter2Anim(slot0)
	gohelper.setActive(slot0._goBg, true)
end

function slot0.onHide(slot0)
	if slot0._videoItem then
		slot0._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(slot0._playChapter2Anim, slot0)
end

function slot0.onDestory(slot0)
	if slot0._videoItem then
		slot0._videoItem:onDestroy()

		slot0._videoItem = nil
	end

	if slot0._singleBgTitle then
		slot0._singleBgTitle:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0._playChapter2Anim, slot0)
	uv0.super.onDestory(slot0)
end

return slot0

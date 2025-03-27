module("modules.logic.story.view.StoryActivityChapterOpen2_4", package.seeall)

slot0 = class("StoryActivityChapterOpen2_4", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v2a4/storyactivitychapteropen.prefab"
end

function slot0.onInitView(slot0)
	slot0._goVideo = gohelper.findChild(slot0.viewGO, "#go_video")
	slot0._goChapter = gohelper.findChild(slot0.viewGO, "#go_chapter")
	slot0._simageSection = gohelper.findChildSingleImage(slot0._goChapter, "simageChapter")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0._goChapter, "simageTitle")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goMaskBg = gohelper.findChild(slot0.viewGO, "#gomask")
end

function slot0.onUpdateView(slot0)
	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.runDelay(slot0.play, slot0, 2)
end

function slot0.play(slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot4 = slot2[2] or 1

	gohelper.setActive(slot0._goMaskBg, true)
	slot0._simageSection:LoadImage(slot0:getLangResBg(string.format("chapter_%s", StoryConfig.instance:getActivityOpenConfig(string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1, slot4) and slot5.labelRes)), slot0.onSectionLoaded, slot0)
	slot0._simageTitle:LoadImage(slot0:getLangResBg(string.format("title_%s", slot4)), slot0.onTitleLoaded, slot0)

	slot0._anim.speed = 0

	slot0:playVideo()
end

function slot0.playVideo(slot0)
	slot3 = string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1
	slot5 = slot0:getVideoName(slot2[2] or 1)

	if not slot0._videoItem then
		slot0._videoItem = StoryActivityVideoItem.New(slot0._goVideo)
	end

	slot0._videoItem:playVideo(slot5, {
		loop = false,
		audioNoStopByFinish = true,
		audioId = slot0:getAudioId(slot4),
		startCallback = slot0.onVideoStart,
		startCallbackObj = slot0
	})
end

function slot0.onVideoStart(slot0)
	gohelper.setActive(slot0._goMaskBg, false)

	slot0._anim.speed = 1
	slot3 = string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1

	if (slot2[2] or 1) == 1 then
		slot0._anim:Play("open", 0, 0)
	else
		slot0._anim:Play("open1", 0, 0)
	end
end

function slot0.onSectionLoaded(slot0)
	if gohelper.findChildImage(slot0._goChapter, "#simageChapter") then
		slot1:SetNativeSize()
	end
end

function slot0.onTitleLoaded(slot0)
	if gohelper.findChildImage(slot0._goChapter, "#simageTitle") then
		slot1:SetNativeSize()
	end
end

function slot0.getVideoName(slot0, slot1)
	return slot1 == 1 and "2_4_opening_1"
end

function slot0.getLangResBg(slot0, slot1)
	return string.format("singlebg_lang/txt_v2a4_storyactivityopenclose/%s.png", slot1)
end

function slot0.getAudioId(slot0, slot1)
	return slot1 == 1 and AudioEnum.Story.play_activitysfx_diqiu_chapter_open or AudioEnum.Story.play_activitysfx_shiji_subsection_open
end

function slot0.onHide(slot0)
	if slot0._videoItem then
		slot0._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(slot0.play, slot0)
end

function slot0.onDestory(slot0)
	if slot0._simageTitle then
		slot0._simageTitle:UnLoadImage()
	end

	if slot0._simageSection then
		slot0._simageSection:UnLoadImage()
	end

	if slot0._videoItem then
		slot0._videoItem:onDestroy()

		slot0._videoItem = nil
	end

	TaskDispatcher.cancelTask(slot0.play, slot0)
	uv0.super.onDestory(slot0)
end

return slot0

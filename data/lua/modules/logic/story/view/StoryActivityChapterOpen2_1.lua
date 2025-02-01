module("modules.logic.story.view.StoryActivityChapterOpen2_1", package.seeall)

slot0 = class("StoryActivityChapterOpen2_1", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v2a1/storyactivitychapteropen.prefab"
end

function slot0.onInitView(slot0)
	slot0._goVideo = gohelper.findChild(slot0.viewGO, "#go_video")
	slot0._goMaskBg = gohelper.findChild(slot0.viewGO, "#maskBg")
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._simageSection = gohelper.findChildSingleImage(slot0._goBg, "#simage_Section")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0._goBg, "#simage_Title")
	slot0._simageTitleen = gohelper.findChildSingleImage(slot0._goBg, "#simage_Titleen")
	slot0._simageTitleBg = gohelper.findChildSingleImage(slot0._goBg, "#simage_titleBg")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._simageBg = gohelper.findChildSingleImage(slot0._goBg, "image_BG")
end

function slot0.onUpdateView(slot0)
	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.runDelay(slot0.play, slot0, 2)
end

function slot0.play(slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot4 = slot2[2] or 1

	gohelper.setActive(slot0._goMaskBg, true)

	slot5 = StoryConfig.instance:getActivityOpenConfig(string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1, slot4)

	slot0._simageSection:LoadImage(slot0:getLangResBg(string.format("section_%s", slot5.labelRes)), slot0.onSectionLoaded, slot0)
	slot0._simageTitle:LoadImage(slot0:getLangResBg(string.format("title_%s", slot4)), slot0.onTitleLoaded, slot0)
	slot0._simageTitleen:LoadImage(slot0:getLangResBg(string.format("titleen_%s", slot4)), slot0.onTitleenLoaded, slot0)

	slot10 = "arttext_4"

	if GameUtil.utf8len(slot5.title) < 3 then
		slot10 = "arttext_1"
	elseif slot9 < 5 then
		slot10 = "arttext_2"
	elseif slot9 < 7 then
		slot10 = "arttext_3"
	end

	slot0._simageTitleBg:LoadImage(string.format("singlebg/v2a1_opening_singlebg/%s.png", slot10))

	slot0._anim.speed = 0

	gohelper.setActive(slot0._simageBg.gameObject, false)
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
	slot0._anim.speed = 1
	slot3 = string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1

	if (slot2[2] or 1) == 1 then
		slot0._anim:Play("open", 0, 0)
	else
		slot0._anim:Play("open1", 0, 0)
	end

	gohelper.setActive(slot0._simageBg.gameObject, true)
	slot0._simageBg:LoadImage(StoryConfig.instance:getActivityOpenConfig(slot3, slot4).storyBg, slot0.onBgLoaded, slot0)
end

function slot0.onSectionLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "#simage_Section") then
		slot1:SetNativeSize()
	end
end

function slot0.onTitleLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "#simage_Title") then
		slot1:SetNativeSize()
	end
end

function slot0.onTitleenLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "#simage_Titleen") then
		slot1:SetNativeSize()
	end
end

function slot0.onBgLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "image_BG") then
		slot1:SetNativeSize()
	end
end

function slot0.getLangResBg(slot0, slot1)
	return string.format("singlebg_lang/txt_v2a1_opening_singlebg/%s.png", slot1)
end

function slot0.getVideoName(slot0, slot1)
	return slot1 == 1 and "2_1_opening_1"
end

function slot0.getAudioId(slot0, slot1)
	return slot1 == 1 and AudioEnum.Story.play_activitysfx_wangshi_chapter_open or AudioEnum.Story.play_activitysfx_wangshi_subsection_open
end

function slot0.onHide(slot0)
	if slot0._videoItem then
		slot0._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(slot0.play, slot0)
end

function slot0.onDestory(slot0)
	if slot0._videoItem then
		slot0._videoItem:onDestroy()

		slot0._videoItem = nil
	end

	if slot0._simageTitle then
		slot0._simageTitle:UnLoadImage()
	end

	if slot0._simageName then
		slot0._simageName:UnLoadImage()
	end

	if slot0._simageTitleBg then
		slot0._simageTitleBg:UnLoadImage()
	end

	if slot0._simageBg then
		slot0._simageBg:UnLoadImage()
	end

	if slot0._simageTitleen then
		slot0._simageTitleen:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0.play, slot0)
	uv0.super.onDestory(slot0)
end

return slot0

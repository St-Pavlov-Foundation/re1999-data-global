module("modules.logic.story.view.StoryActivityChapterOpen1_3", package.seeall)

slot0 = class("StoryActivityChapterOpen1_3", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v1a3/storyactivitychapteropen.prefab"
end

function slot0.onInitView(slot0)
	slot0._goVideo = gohelper.findChild(slot0.viewGO, "#go_video")
	slot0._goMaskBg = gohelper.findChild(slot0.viewGO, "#maskBg")
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._simageFullBg = gohelper.findChildSingleImage(slot0._goBg, "#simage_FullBG")
	slot0._simageFullBg1 = gohelper.findChildSingleImage(slot0._goBg, "#simage_FullBG/simage_FullBG1")
	slot0._simageSection = gohelper.findChildSingleImage(slot0._goBg, "#simage_Section")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0._goBg, "#simage_Title")
	slot0._simageName = gohelper.findChildSingleImage(slot0._goBg, "#simage_Name")
	slot0._simagePart = gohelper.findChildSingleImage(slot0._goBg, "#simage_Chapter")

	slot0._simageFullBg:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_xiaojie_bg.png")
	slot0._simageFullBg1:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_xiaojie_bg.png")

	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateView(slot0)
	slot3 = string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1
	slot5 = slot0:getVideoName(slot2[2] or 1)

	if not slot0._videoItem then
		slot0._videoItem = StoryActivityVideoItem.New(slot0._goVideo)
	end

	slot0._videoItem:playVideo(slot5, {
		loop = false,
		audioNoStopByFinish = true,
		audioId = slot0:getAudioId(slot4)
	})
	gohelper.setActive(slot0._goMaskBg, true)
	slot0._simageTitle:LoadImage(slot0:getLangResBg(string.format("v1a3_title_en_%s", slot4)))
	slot0._simageName:LoadImage(slot0:getLangResBg(string.format("v1a3_title_%s", slot4)))
	slot0._simageSection:LoadImage(slot0:getLangResBg(string.format("v1a3_section_%s", StoryConfig.instance:getActivityOpenConfig(slot3, slot4) and slot8.labelRes)))
	slot0._simagePart:LoadImage(slot0:getLangResBg(string.format("v1a3_part_%s", slot8 and slot8.labelRes)))

	if slot4 == 1 then
		slot0._anim:Play("open", 0, 0)
	else
		slot0._anim:Play("open1", 0, 0)
	end
end

function slot0.getLangResBg(slot0, slot1)
	return string.format("singlebg_lang/txt_v1a3_opening_singlebg/%s.png", slot1)
end

function slot0.getVideoName(slot0, slot1)
	return slot1 == 1 and "1_3_opening_1"
end

function slot0.getAudioId(slot0, slot1)
	return slot1 == 1 and AudioEnum.Story.Activity1_3_Chapter_Start or AudioEnum.Story.Activity1_3_Part_Start
end

function slot0.onHide(slot0)
	if slot0._videoItem then
		slot0._videoItem:onVideoOut()
	end
end

function slot0.onDestory(slot0)
	if slot0._videoItem then
		slot0._videoItem:onDestroy()

		slot0._videoItem = nil
	end

	if slot0._simageFullBg then
		slot0._simageFullBg:UnLoadImage()
	end

	if slot0._simageFullBg1 then
		slot0._simageFullBg1:UnLoadImage()
	end

	if slot0._simageSection then
		slot0._simageSection:UnLoadImage()
	end

	if slot0._simageTitle then
		slot0._simageTitle:UnLoadImage()
	end

	if slot0._simageName then
		slot0._simageName:UnLoadImage()
	end

	if slot0._simagePart then
		slot0._simagePart:UnLoadImage()
	end

	uv0.super.onDestory(slot0)
end

return slot0

module("modules.logic.story.view.StoryActivityChapterOpen1_1", package.seeall)

slot0 = class("StoryActivityChapterOpen1_1", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v1a1/storyactivitychapteropen.prefab"
end

function slot0.onInitView(slot0)
	slot0._goVideo = gohelper.findChild(slot0.viewGO, "#go_video")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._singleBg = gohelper.findChildSingleImage(slot0._goContent, "#single_bg")
	slot0._singleMask = gohelper.findChildSingleImage(slot0._goContent, "#single_mask")
	slot0._singleTitle = gohelper.findChildSingleImage(slot0._goContent, "#simage_title")
	slot0._singleSignaturebg = gohelper.findChildSingleImage(slot0._goContent, "#simage_title/#simage_signaturebg")
	slot0._singleSignature = gohelper.findChildSingleImage(slot0._goContent, "#simage_title/#simage_signaturebg/#simage_signature")
	slot0._singleWenli = gohelper.findChildSingleImage(slot0._goContent, "#simage_title/#simage_wenli")
	slot0._txtTitlecn = gohelper.findChildText(slot0._goContent, "#simage_title/#txt_titlecn")
	slot0._txtTitleen = gohelper.findChildText(slot0._goContent, "#simage_title/#txt_titleen")
end

function slot0.onUpdateView(slot0)
	slot3 = string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1
	slot5 = slot0:getVideoName(slot2[2] or 1)

	if not slot0._videoItem then
		slot0._videoItem = StoryActivityVideoItem.New(slot0._goVideo)
	end

	slot0._videoItem:playVideo(slot5, {
		loop = false,
		outCallback = slot0.playStartVideoOut,
		outCallbackObj = slot0,
		audioId = slot0:getAudioId(slot4)
	})

	slot0._txtTitlecn.text = StoryConfig.instance:getActivityOpenConfig(slot3, slot4) and slot8.title or ""
	slot0._txtTitleen.text = slot8 and slot8.titleEn or ""

	if string.nilorempty(slot8 and slot8.labelRes) then
		gohelper.setActive(slot0._singleSignature.gameObject, false)
	else
		gohelper.setActive(slot0._singleSignature.gameObject, true)
		slot0._singleSignature:LoadImage(ResUrl.getVersionActivityOpenPath(slot9), slot0.onTitileLoaded, slot0)
	end

	slot0._singleBg:LoadImage(ResUrl.getVersionActivityOpenPath("full/bg_h"))
	slot0._singleMask:LoadImage(ResUrl.getVersionActivityOpenPath("full/mask"))
	slot0._singleWenli:LoadImage(ResUrl.getVersionActivityOpenPath("2wenli"))
	slot0._singleSignaturebg:LoadImage(ResUrl.getVersionActivityOpenPath("1img_zhuangshi"))
	slot0._singleTitle:LoadImage(ResUrl.getVersionActivityOpenPath("4img_green"))
end

function slot0.getVideoName(slot0, slot1)
	return slot1 % 100 == 1 and "1_1_opening_0" or "1_1_opening_1"
end

function slot0.getAudioId(slot0, slot1)
	return slot1 % 100 == 1 and AudioEnum.Story.Activity_Chapter_Start or AudioEnum.Story.Activity_Part_Start
end

function slot0.playStartVideoOut(slot0)
	gohelper.setActive(slot0._goContent, true)
end

function slot0.onTitileLoaded(slot0)
	slot0._singleSignature.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
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

	if slot0._singleTitle then
		slot0._singleTitle:UnLoadImage()
	end

	if slot0._singleBg then
		slot0._singleBg:UnLoadImage()
	end

	if slot0._singleMask then
		slot0._singleMask:UnLoadImage()
	end

	if slot0._singleWenli then
		slot0._singleWenli:UnLoadImage()
	end

	if slot0._singleSignaturebg then
		slot0._singleSignaturebg:UnLoadImage()
	end

	uv0.super.onDestory(slot0)
end

return slot0

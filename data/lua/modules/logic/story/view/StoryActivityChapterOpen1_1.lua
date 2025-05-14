module("modules.logic.story.view.StoryActivityChapterOpen1_1", package.seeall)

local var_0_0 = class("StoryActivityChapterOpen1_1", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v1a1/storyactivitychapteropen.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goVideo = gohelper.findChild(arg_2_0.viewGO, "#go_video")
	arg_2_0._goContent = gohelper.findChild(arg_2_0.viewGO, "#go_content")
	arg_2_0._singleBg = gohelper.findChildSingleImage(arg_2_0._goContent, "#single_bg")
	arg_2_0._singleMask = gohelper.findChildSingleImage(arg_2_0._goContent, "#single_mask")
	arg_2_0._singleTitle = gohelper.findChildSingleImage(arg_2_0._goContent, "#simage_title")
	arg_2_0._singleSignaturebg = gohelper.findChildSingleImage(arg_2_0._goContent, "#simage_title/#simage_signaturebg")
	arg_2_0._singleSignature = gohelper.findChildSingleImage(arg_2_0._goContent, "#simage_title/#simage_signaturebg/#simage_signature")
	arg_2_0._singleWenli = gohelper.findChildSingleImage(arg_2_0._goContent, "#simage_title/#simage_wenli")
	arg_2_0._txtTitlecn = gohelper.findChildText(arg_2_0._goContent, "#simage_title/#txt_titlecn")
	arg_2_0._txtTitleen = gohelper.findChildText(arg_2_0._goContent, "#simage_title/#txt_titleen")
end

function var_0_0.onUpdateView(arg_3_0)
	local var_3_0 = arg_3_0.data
	local var_3_1 = string.splitToNumber(var_3_0.navigateChapterEn, "#")
	local var_3_2 = var_3_1[1] or 1
	local var_3_3 = var_3_1[2] or 1
	local var_3_4 = arg_3_0:getVideoName(var_3_3)

	if not arg_3_0._videoItem then
		arg_3_0._videoItem = StoryActivityVideoItem.New(arg_3_0._goVideo)
	end

	local var_3_5 = arg_3_0:getAudioId(var_3_3)
	local var_3_6 = {
		loop = false,
		outCallback = arg_3_0.playStartVideoOut,
		outCallbackObj = arg_3_0,
		audioId = var_3_5
	}

	arg_3_0._videoItem:playVideo(var_3_4, var_3_6)

	local var_3_7 = StoryConfig.instance:getActivityOpenConfig(var_3_2, var_3_3)

	arg_3_0._txtTitlecn.text = var_3_7 and var_3_7.title or ""
	arg_3_0._txtTitleen.text = var_3_7 and var_3_7.titleEn or ""

	local var_3_8 = var_3_7 and var_3_7.labelRes

	if string.nilorempty(var_3_8) then
		gohelper.setActive(arg_3_0._singleSignature.gameObject, false)
	else
		gohelper.setActive(arg_3_0._singleSignature.gameObject, true)
		arg_3_0._singleSignature:LoadImage(ResUrl.getVersionActivityOpenPath(var_3_8), arg_3_0.onTitileLoaded, arg_3_0)
	end

	arg_3_0._singleBg:LoadImage(ResUrl.getVersionActivityOpenPath("full/bg_h"))
	arg_3_0._singleMask:LoadImage(ResUrl.getVersionActivityOpenPath("full/mask"))
	arg_3_0._singleWenli:LoadImage(ResUrl.getVersionActivityOpenPath("2wenli"))
	arg_3_0._singleSignaturebg:LoadImage(ResUrl.getVersionActivityOpenPath("1img_zhuangshi"))
	arg_3_0._singleTitle:LoadImage(ResUrl.getVersionActivityOpenPath("4img_green"))
end

function var_0_0.getVideoName(arg_4_0, arg_4_1)
	return arg_4_1 % 100 == 1 and "1_1_opening_0" or "1_1_opening_1"
end

function var_0_0.getAudioId(arg_5_0, arg_5_1)
	return arg_5_1 % 100 == 1 and AudioEnum.Story.Activity_Chapter_Start or AudioEnum.Story.Activity_Part_Start
end

function var_0_0.playStartVideoOut(arg_6_0)
	gohelper.setActive(arg_6_0._goContent, true)
end

function var_0_0.onTitileLoaded(arg_7_0)
	arg_7_0._singleSignature.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function var_0_0.onHide(arg_8_0)
	if arg_8_0._videoItem then
		arg_8_0._videoItem:onVideoOut()
	end
end

function var_0_0.onDestory(arg_9_0)
	if arg_9_0._videoItem then
		arg_9_0._videoItem:onDestroy()

		arg_9_0._videoItem = nil
	end

	if arg_9_0._singleTitle then
		arg_9_0._singleTitle:UnLoadImage()
	end

	if arg_9_0._singleBg then
		arg_9_0._singleBg:UnLoadImage()
	end

	if arg_9_0._singleMask then
		arg_9_0._singleMask:UnLoadImage()
	end

	if arg_9_0._singleWenli then
		arg_9_0._singleWenli:UnLoadImage()
	end

	if arg_9_0._singleSignaturebg then
		arg_9_0._singleSignaturebg:UnLoadImage()
	end

	var_0_0.super.onDestory(arg_9_0)
end

return var_0_0

module("modules.logic.story.view.StoryActivityChapterOpen1_3", package.seeall)

local var_0_0 = class("StoryActivityChapterOpen1_3", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v1a3/storyactivitychapteropen.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goVideo = gohelper.findChild(arg_2_0.viewGO, "#go_video")
	arg_2_0._goMaskBg = gohelper.findChild(arg_2_0.viewGO, "#maskBg")
	arg_2_0._goBg = gohelper.findChild(arg_2_0.viewGO, "#go_bg")
	arg_2_0._simageFullBg = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_FullBG")
	arg_2_0._simageFullBg1 = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_FullBG/simage_FullBG1")
	arg_2_0._simageSection = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Section")
	arg_2_0._simageTitle = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Title")
	arg_2_0._simageName = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Name")
	arg_2_0._simagePart = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Chapter")

	arg_2_0._simageFullBg:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_xiaojie_bg.png")
	arg_2_0._simageFullBg1:LoadImage("singlebg/v1a3_opening_singlebg/v1a3_xiaojie_bg.png")

	arg_2_0._anim = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
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
		audioNoStopByFinish = true,
		audioId = var_3_5
	}

	arg_3_0._videoItem:playVideo(var_3_4, var_3_6)
	gohelper.setActive(arg_3_0._goMaskBg, true)

	local var_3_7 = StoryConfig.instance:getActivityOpenConfig(var_3_2, var_3_3)
	local var_3_8 = string.format("v1a3_title_en_%s", var_3_3)
	local var_3_9 = string.format("v1a3_title_%s", var_3_3)
	local var_3_10 = string.format("v1a3_section_%s", var_3_7 and var_3_7.labelRes)
	local var_3_11 = string.format("v1a3_part_%s", var_3_7 and var_3_7.labelRes)

	arg_3_0._simageTitle:LoadImage(arg_3_0:getLangResBg(var_3_8))
	arg_3_0._simageName:LoadImage(arg_3_0:getLangResBg(var_3_9))
	arg_3_0._simageSection:LoadImage(arg_3_0:getLangResBg(var_3_10))
	arg_3_0._simagePart:LoadImage(arg_3_0:getLangResBg(var_3_11))

	if var_3_3 == 1 then
		arg_3_0._anim:Play("open", 0, 0)
	else
		arg_3_0._anim:Play("open1", 0, 0)
	end
end

function var_0_0.getLangResBg(arg_4_0, arg_4_1)
	return string.format("singlebg_lang/txt_v1a3_opening_singlebg/%s.png", arg_4_1)
end

function var_0_0.getVideoName(arg_5_0, arg_5_1)
	return arg_5_1 == 1 and "1_3_opening_1"
end

function var_0_0.getAudioId(arg_6_0, arg_6_1)
	return arg_6_1 == 1 and AudioEnum.Story.Activity1_3_Chapter_Start or AudioEnum.Story.Activity1_3_Part_Start
end

function var_0_0.onHide(arg_7_0)
	if arg_7_0._videoItem then
		arg_7_0._videoItem:onVideoOut()
	end
end

function var_0_0.onDestory(arg_8_0)
	if arg_8_0._videoItem then
		arg_8_0._videoItem:onDestroy()

		arg_8_0._videoItem = nil
	end

	if arg_8_0._simageFullBg then
		arg_8_0._simageFullBg:UnLoadImage()
	end

	if arg_8_0._simageFullBg1 then
		arg_8_0._simageFullBg1:UnLoadImage()
	end

	if arg_8_0._simageSection then
		arg_8_0._simageSection:UnLoadImage()
	end

	if arg_8_0._simageTitle then
		arg_8_0._simageTitle:UnLoadImage()
	end

	if arg_8_0._simageName then
		arg_8_0._simageName:UnLoadImage()
	end

	if arg_8_0._simagePart then
		arg_8_0._simagePart:UnLoadImage()
	end

	var_0_0.super.onDestory(arg_8_0)
end

return var_0_0

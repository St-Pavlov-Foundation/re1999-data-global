﻿module("modules.logic.story.view.StoryActivityChapterOpen1_8", package.seeall)

local var_0_0 = class("StoryActivityChapterOpen1_8", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v1a8/storyactivitychapteropen.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goVideo = gohelper.findChild(arg_2_0.viewGO, "#go_video")
	arg_2_0._goMaskBg = gohelper.findChild(arg_2_0.viewGO, "#maskBg")
	arg_2_0._goBg = gohelper.findChild(arg_2_0.viewGO, "#go_bg")
	arg_2_0._simageSection = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Section")
	arg_2_0._simageTitle = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Title")
	arg_2_0._simageTitleen = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Titleen")
	arg_2_0._anim = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._simageBg = gohelper.findChildSingleImage(arg_2_0._goBg, "image_BG")
end

function var_0_0.onUpdateView(arg_3_0)
	gohelper.setActive(arg_3_0.viewGO, false)
	TaskDispatcher.runDelay(arg_3_0.play, arg_3_0, 2)
end

function var_0_0.play(arg_4_0)
	gohelper.setActive(arg_4_0.viewGO, true)

	local var_4_0 = arg_4_0.data
	local var_4_1 = string.splitToNumber(var_4_0.navigateChapterEn, "#")
	local var_4_2 = var_4_1[1] or 1
	local var_4_3 = var_4_1[2] or 1
	local var_4_4 = arg_4_0:getVideoName(var_4_3)

	if not arg_4_0._videoItem then
		arg_4_0._videoItem = StoryActivityVideoItem.New(arg_4_0._goVideo)
	end

	local var_4_5 = arg_4_0:getAudioId(var_4_3)
	local var_4_6 = {
		loop = false,
		audioNoStopByFinish = true,
		audioId = var_4_5
	}

	arg_4_0._videoItem:playVideo(var_4_4, var_4_6)
	gohelper.setActive(arg_4_0._goMaskBg, true)

	local var_4_7 = StoryConfig.instance:getActivityOpenConfig(var_4_2, var_4_3)
	local var_4_8 = string.format("section_%s", var_4_7.labelRes)
	local var_4_9 = string.format("titleen_%s", var_4_3)
	local var_4_10 = string.format("title_%s", var_4_3)

	arg_4_0._simageSection:LoadImage(arg_4_0:getLangResBg(var_4_8), arg_4_0.onSectionLoaded, arg_4_0)
	arg_4_0._simageTitle:LoadImage(arg_4_0:getLangResBg(var_4_10), arg_4_0.onTitleLoaded, arg_4_0)
	arg_4_0._simageTitleen:LoadImage(arg_4_0:getLangResBg(var_4_9), arg_4_0.onTitleenLoaded, arg_4_0)
	arg_4_0._simageBg:LoadImage(var_4_7.storyBg, arg_4_0.onBgLoaded, arg_4_0)

	if var_4_3 == 1 then
		arg_4_0._anim:Play("open", 0, 0)
	else
		arg_4_0._anim:Play("open1", 0, 0)
	end
end

function var_0_0.onSectionLoaded(arg_5_0)
	local var_5_0 = gohelper.findChildImage(arg_5_0._goBg, "#simage_Section")

	if var_5_0 then
		var_5_0:SetNativeSize()
	end
end

function var_0_0.onTitleLoaded(arg_6_0)
	local var_6_0 = gohelper.findChildImage(arg_6_0._goBg, "#simage_Title")

	if var_6_0 then
		var_6_0:SetNativeSize()
	end
end

function var_0_0.onTitleenLoaded(arg_7_0)
	local var_7_0 = gohelper.findChildImage(arg_7_0._goBg, "#simage_Titleen")

	if var_7_0 then
		var_7_0:SetNativeSize()
	end
end

function var_0_0.onBgLoaded(arg_8_0)
	local var_8_0 = gohelper.findChildImage(arg_8_0._goBg, "image_BG")

	if var_8_0 then
		var_8_0:SetNativeSize()
	end
end

function var_0_0.getLangResBg(arg_9_0, arg_9_1)
	return string.format("singlebg_lang/txt_v1a8_storyactivityopenclose/%s.png", arg_9_1)
end

function var_0_0.getVideoName(arg_10_0, arg_10_1)
	return arg_10_1 == 1 and "1_8_opening_1"
end

function var_0_0.getAudioId(arg_11_0, arg_11_1)
	return arg_11_1 == 1 and AudioEnum.Story.play_activitysfx_shiji_chapter_open or AudioEnum.Story.play_activitysfx_shiji_subsection_open
end

function var_0_0.onHide(arg_12_0)
	if arg_12_0._videoItem then
		arg_12_0._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(arg_12_0.play, arg_12_0)
end

function var_0_0.onDestory(arg_13_0)
	if arg_13_0._videoItem then
		arg_13_0._videoItem:onDestroy()

		arg_13_0._videoItem = nil
	end

	if arg_13_0._simageTitle then
		arg_13_0._simageTitle:UnLoadImage()
	end

	if arg_13_0._simageName then
		arg_13_0._simageName:UnLoadImage()
	end

	if arg_13_0._simageBg then
		arg_13_0._simageBg:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_13_0.play, arg_13_0)
	var_0_0.super.onDestory(arg_13_0)
end

return var_0_0

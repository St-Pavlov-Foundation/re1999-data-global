module("modules.logic.story.view.StoryActivityChapterOpen2_1", package.seeall)

local var_0_0 = class("StoryActivityChapterOpen2_1", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v2a1/storyactivitychapteropen.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goVideo = gohelper.findChild(arg_2_0.viewGO, "#go_video")
	arg_2_0._goMaskBg = gohelper.findChild(arg_2_0.viewGO, "#maskBg")
	arg_2_0._goBg = gohelper.findChild(arg_2_0.viewGO, "#go_bg")
	arg_2_0._simageSection = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Section")
	arg_2_0._simageTitle = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Title")
	arg_2_0._simageTitleen = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_Titleen")
	arg_2_0._simageTitleBg = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_titleBg")
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

	gohelper.setActive(arg_4_0._goMaskBg, true)

	local var_4_4 = StoryConfig.instance:getActivityOpenConfig(var_4_2, var_4_3)
	local var_4_5 = string.format("section_%s", var_4_4.labelRes)
	local var_4_6 = string.format("title_%s", var_4_3)
	local var_4_7 = string.format("titleen_%s", var_4_3)

	arg_4_0._simageSection:LoadImage(arg_4_0:getLangResBg(var_4_5), arg_4_0.onSectionLoaded, arg_4_0)
	arg_4_0._simageTitle:LoadImage(arg_4_0:getLangResBg(var_4_6), arg_4_0.onTitleLoaded, arg_4_0)
	arg_4_0._simageTitleen:LoadImage(arg_4_0:getLangResBg(var_4_7), arg_4_0.onTitleenLoaded, arg_4_0)

	local var_4_8 = GameUtil.utf8len(var_4_4.title)
	local var_4_9 = "arttext_4"

	if var_4_8 < 3 then
		var_4_9 = "arttext_1"
	elseif var_4_8 < 5 then
		var_4_9 = "arttext_2"
	elseif var_4_8 < 7 then
		var_4_9 = "arttext_3"
	end

	arg_4_0._simageTitleBg:LoadImage(string.format("singlebg/v2a1_opening_singlebg/%s.png", var_4_9))

	arg_4_0._anim.speed = 0

	gohelper.setActive(arg_4_0._simageBg.gameObject, false)
	arg_4_0:playVideo()
end

function var_0_0.playVideo(arg_5_0)
	local var_5_0 = arg_5_0.data
	local var_5_1 = string.splitToNumber(var_5_0.navigateChapterEn, "#")

	if not var_5_1[1] then
		local var_5_2 = 1
	end

	local var_5_3 = var_5_1[2] or 1
	local var_5_4 = arg_5_0:getVideoName(var_5_3)

	if not arg_5_0._videoItem then
		arg_5_0._videoItem = StoryActivityVideoItem.New(arg_5_0._goVideo)
	end

	local var_5_5 = arg_5_0:getAudioId(var_5_3)
	local var_5_6 = {
		loop = false,
		audioNoStopByFinish = true,
		audioId = var_5_5,
		startCallback = arg_5_0.onVideoStart,
		startCallbackObj = arg_5_0
	}

	arg_5_0._videoItem:playVideo(var_5_4, var_5_6)
end

function var_0_0.onVideoStart(arg_6_0)
	arg_6_0._anim.speed = 1

	local var_6_0 = arg_6_0.data
	local var_6_1 = string.splitToNumber(var_6_0.navigateChapterEn, "#")
	local var_6_2 = var_6_1[1] or 1
	local var_6_3 = var_6_1[2] or 1

	if var_6_3 == 1 then
		arg_6_0._anim:Play("open", 0, 0)
	else
		arg_6_0._anim:Play("open1", 0, 0)
	end

	local var_6_4 = StoryConfig.instance:getActivityOpenConfig(var_6_2, var_6_3)

	gohelper.setActive(arg_6_0._simageBg.gameObject, true)
	arg_6_0._simageBg:LoadImage(var_6_4.storyBg, arg_6_0.onBgLoaded, arg_6_0)
end

function var_0_0.onSectionLoaded(arg_7_0)
	local var_7_0 = gohelper.findChildImage(arg_7_0._goBg, "#simage_Section")

	if var_7_0 then
		var_7_0:SetNativeSize()
	end
end

function var_0_0.onTitleLoaded(arg_8_0)
	local var_8_0 = gohelper.findChildImage(arg_8_0._goBg, "#simage_Title")

	if var_8_0 then
		var_8_0:SetNativeSize()
	end
end

function var_0_0.onTitleenLoaded(arg_9_0)
	local var_9_0 = gohelper.findChildImage(arg_9_0._goBg, "#simage_Titleen")

	if var_9_0 then
		var_9_0:SetNativeSize()
	end
end

function var_0_0.onBgLoaded(arg_10_0)
	local var_10_0 = gohelper.findChildImage(arg_10_0._goBg, "image_BG")

	if var_10_0 then
		var_10_0:SetNativeSize()
	end
end

function var_0_0.getLangResBg(arg_11_0, arg_11_1)
	return string.format("singlebg_lang/txt_v2a1_opening_singlebg/%s.png", arg_11_1)
end

function var_0_0.getVideoName(arg_12_0, arg_12_1)
	return arg_12_1 == 1 and "2_1_opening_1"
end

function var_0_0.getAudioId(arg_13_0, arg_13_1)
	return arg_13_1 == 1 and AudioEnum.Story.play_activitysfx_wangshi_chapter_open or AudioEnum.Story.play_activitysfx_wangshi_subsection_open
end

function var_0_0.onHide(arg_14_0)
	if arg_14_0._videoItem then
		arg_14_0._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(arg_14_0.play, arg_14_0)
end

function var_0_0.onDestory(arg_15_0)
	if arg_15_0._videoItem then
		arg_15_0._videoItem:onDestroy()

		arg_15_0._videoItem = nil
	end

	if arg_15_0._simageTitle then
		arg_15_0._simageTitle:UnLoadImage()
	end

	if arg_15_0._simageName then
		arg_15_0._simageName:UnLoadImage()
	end

	if arg_15_0._simageTitleBg then
		arg_15_0._simageTitleBg:UnLoadImage()
	end

	if arg_15_0._simageBg then
		arg_15_0._simageBg:UnLoadImage()
	end

	if arg_15_0._simageTitleen then
		arg_15_0._simageTitleen:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_15_0.play, arg_15_0)
	var_0_0.super.onDestory(arg_15_0)
end

return var_0_0

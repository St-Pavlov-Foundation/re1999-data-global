module("modules.logic.story.view.StoryActivityChapterOpen2_3", package.seeall)

local var_0_0 = class("StoryActivityChapterOpen2_3", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v2a3/storyactivitychapteropen.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goChapter = gohelper.findChild(arg_2_0.viewGO, "#go_chapter")
	arg_2_0._simageSection = gohelper.findChildSingleImage(arg_2_0._goChapter, "simageChapter")
	arg_2_0._simageTitle = gohelper.findChildSingleImage(arg_2_0._goChapter, "simageTitle")
	arg_2_0._anim = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
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
	local var_4_5 = string.format("chapter_%s", var_4_4 and var_4_4.labelRes)
	local var_4_6 = string.format("title_%s", var_4_3)

	arg_4_0._simageSection:LoadImage(arg_4_0:getLangResBg(var_4_5), arg_4_0.onSectionLoaded, arg_4_0)
	arg_4_0._simageTitle:LoadImage(arg_4_0:getLangResBg(var_4_6), arg_4_0.onTitleLoaded, arg_4_0)

	arg_4_0._anim.speed = 0

	arg_4_0:onVideoStart()
end

function var_0_0.onVideoStart(arg_5_0)
	arg_5_0._anim.speed = 1

	local var_5_0 = arg_5_0.data
	local var_5_1 = string.splitToNumber(var_5_0.navigateChapterEn, "#")

	if not var_5_1[1] then
		local var_5_2 = 1
	end

	local var_5_3 = var_5_1[2] or 1

	if var_5_3 == 1 then
		arg_5_0._anim:Play("open", 0, 0)
	else
		arg_5_0._anim:Play("open1", 0, 0)
	end

	arg_5_0._audioId = arg_5_0:getAudioId(var_5_3)

	arg_5_0:_playAudio()
end

function var_0_0.onSectionLoaded(arg_6_0)
	local var_6_0 = gohelper.findChildImage(arg_6_0._goChapter, "#simageChapter")

	if var_6_0 then
		var_6_0:SetNativeSize()
	end
end

function var_0_0.onTitleLoaded(arg_7_0)
	local var_7_0 = gohelper.findChildImage(arg_7_0._goChapter, "#simageTitle")

	if var_7_0 then
		var_7_0:SetNativeSize()
	end
end

function var_0_0.getLangResBg(arg_8_0, arg_8_1)
	return string.format("singlebg_lang/txt_v2a3_storyactivityopenclose/%s.png", arg_8_1)
end

function var_0_0.getAudioId(arg_9_0, arg_9_1)
	return arg_9_1 == 1 and AudioEnum.Story.play_activitysfx_shenghuo_chapter_open or AudioEnum.Story.play_activitysfx_shenghuo_subsection_open
end

function var_0_0.onHide(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.play, arg_10_0)
	arg_10_0:_stopAudio()
end

function var_0_0._playAudio(arg_11_0)
	if arg_11_0._audioId then
		AudioEffectMgr.instance:playAudio(arg_11_0._audioId)
	end
end

function var_0_0._stopAudio(arg_12_0)
	if arg_12_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_12_0._audioId)

		arg_12_0._audioId = nil
	end
end

function var_0_0.onDestory(arg_13_0)
	if arg_13_0._simageTitle then
		arg_13_0._simageTitle:UnLoadImage()
	end

	if arg_13_0._simageSection then
		arg_13_0._simageSection:UnLoadImage()
	end

	arg_13_0:_stopAudio()
	TaskDispatcher.cancelTask(arg_13_0.play, arg_13_0)
	var_0_0.super.onDestory(arg_13_0)
end

return var_0_0

module("modules.logic.story.view.StoryActivityChapterOpen1_2", package.seeall)

local var_0_0 = class("StoryActivityChapterOpen1_2", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v1a2/storyactivitychapteropen.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goVideo = gohelper.findChild(arg_2_0.viewGO, "#go_video")
	arg_2_0._goMaskBg = gohelper.findChild(arg_2_0.viewGO, "#maskBg")
	arg_2_0._goBg = gohelper.findChild(arg_2_0.viewGO, "#go_bg")
	arg_2_0._singleBgTitle = gohelper.findChildSingleImage(arg_2_0._goBg, "#simage_bgtitle")
end

function var_0_0.onUpdateView(arg_3_0)
	local var_3_0 = arg_3_0.data
	local var_3_1 = string.splitToNumber(var_3_0.navigateChapterEn, "#")

	if not var_3_1[1] then
		local var_3_2 = 1
	end

	local var_3_3 = var_3_1[2] or 1
	local var_3_4 = arg_3_0:getVideoName(var_3_3)

	if var_3_4 then
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
	end

	gohelper.setActive(arg_3_0._goMaskBg, true)

	local var_3_7 = string.format("bg_xiaobiaoti_%s", var_3_3)

	if not string.nilorempty(var_3_7) then
		arg_3_0._singleBgTitle:LoadImage(ResUrl.getActivityChapterLangPath(var_3_7))
	end

	local var_3_8 = arg_3_0:getDelayTime(var_3_3)

	if var_3_8 and var_3_8 > 0 then
		TaskDispatcher.runDelay(arg_3_0._playChapter2Anim, arg_3_0, var_3_8)
	else
		arg_3_0:_playChapter2Anim()
	end
end

function var_0_0.getVideoName(arg_4_0, arg_4_1)
	if arg_4_1 == 0 then
		return "1_2_opening_0"
	end

	if arg_4_1 < 18 or arg_4_1 > 26 then
		return "1_2_opening_1"
	end
end

function var_0_0.getDelayTime(arg_5_0, arg_5_1)
	if arg_5_1 == 0 then
		return 9.8
	end

	if arg_5_1 < 18 or arg_5_1 > 26 then
		return 6.96
	end

	return 0
end

function var_0_0.getAudioId(arg_6_0, arg_6_1)
	if arg_6_1 == 0 then
		return AudioEnum.Story.Activity1_2_Chapter_Start
	end

	if arg_6_1 < 18 or arg_6_1 > 26 then
		return AudioEnum.Story.Activity1_2_Part_Start
	end
end

function var_0_0.playStartVideoOut(arg_7_0)
	return
end

function var_0_0._playChapter2Anim(arg_8_0)
	gohelper.setActive(arg_8_0._goBg, true)
end

function var_0_0.onHide(arg_9_0)
	if arg_9_0._videoItem then
		arg_9_0._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(arg_9_0._playChapter2Anim, arg_9_0)
end

function var_0_0.onDestory(arg_10_0)
	if arg_10_0._videoItem then
		arg_10_0._videoItem:onDestroy()

		arg_10_0._videoItem = nil
	end

	if arg_10_0._singleBgTitle then
		arg_10_0._singleBgTitle:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_10_0._playChapter2Anim, arg_10_0)
	var_0_0.super.onDestory(arg_10_0)
end

return var_0_0

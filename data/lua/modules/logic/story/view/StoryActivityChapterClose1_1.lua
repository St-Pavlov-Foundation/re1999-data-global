module("modules.logic.story.view.StoryActivityChapterClose1_1", package.seeall)

local var_0_0 = class("StoryActivityChapterClose1_1", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v1a1/storyactivitychapterclose.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._txtCloseNum = gohelper.findChildText(arg_2_0.viewGO, "icon/#txt_chaptercloseNum")
end

function var_0_0.onUpdateView(arg_3_0)
	arg_3_0._txtCloseNum.text = arg_3_0.data or ""
	arg_3_0._audioId = arg_3_0:getAudioId()

	local var_3_0 = 1

	TaskDispatcher.cancelTask(arg_3_0._playAudio, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._playAudio, arg_3_0, var_3_0)
end

function var_0_0.getAudioId(arg_4_0, arg_4_1)
	return AudioEnum.Story.Activity_Chapter_End
end

function var_0_0._playAudio(arg_5_0)
	if arg_5_0._audioId then
		AudioEffectMgr.instance:playAudio(arg_5_0._audioId)
	end
end

function var_0_0.onHide(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._playAudio, arg_6_0)

	if arg_6_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_6_0._audioId)

		arg_6_0._audioId = nil
	end
end

function var_0_0.onDestory(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._playAudio, arg_7_0)

	if arg_7_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_7_0._audioId)

		arg_7_0._audioId = nil
	end

	var_0_0.super.onDestory(arg_7_0)
end

return var_0_0

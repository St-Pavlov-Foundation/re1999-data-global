module("modules.logic.story.view.StoryActivityChapterClose2_7", package.seeall)

local var_0_0 = class("StoryActivityChapterClose2_7", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v2a7/storyactivitychapterclose.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.goEnd = gohelper.findChild(arg_2_0.viewGO, "#simage_FullBG/end")
	arg_2_0.goContinued = gohelper.findChild(arg_2_0.viewGO, "#simage_FullBG/continue")
	arg_2_0._anim = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateView(arg_3_0)
	local var_3_0 = tonumber(arg_3_0.data) == 2

	if var_3_0 then
		arg_3_0._anim:Play("close1", 0, 0)
	else
		arg_3_0._anim:Play("close", 0, 0)
	end

	gohelper.setActive(arg_3_0.goEnd, var_3_0)
	gohelper.setActive(arg_3_0.goContinued, not var_3_0)

	arg_3_0._audioId = arg_3_0:getAudioId(tonumber(arg_3_0.data))

	arg_3_0:_playAudio()
end

function var_0_0.getAudioId(arg_4_0, arg_4_1)
	return AudioEnum.Story.play_activitysfx_yuzhou_chapter_continue
end

function var_0_0._playAudio(arg_5_0)
	if arg_5_0._audioId then
		AudioEffectMgr.instance:playAudio(arg_5_0._audioId)
	end
end

function var_0_0.onHide(arg_6_0)
	if arg_6_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_6_0._audioId)

		arg_6_0._audioId = nil
	end
end

function var_0_0.onDestory(arg_7_0)
	if arg_7_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_7_0._audioId)

		arg_7_0._audioId = nil
	end

	var_0_0.super.onDestory(arg_7_0)
end

return var_0_0

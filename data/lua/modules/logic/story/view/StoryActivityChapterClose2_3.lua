module("modules.logic.story.view.StoryActivityChapterClose2_3", package.seeall)

local var_0_0 = class("StoryActivityChapterClose2_3", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v2a3/storyactivitychapterclose.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.goEnd = gohelper.findChild(arg_2_0.viewGO, "#simage_FullBG/end")
	arg_2_0.goContinued = gohelper.findChild(arg_2_0.viewGO, "#simage_FullBG/continue")
end

function var_0_0.onUpdateView(arg_3_0)
	local var_3_0 = tonumber(arg_3_0.data) == 2

	gohelper.setActive(arg_3_0.goEnd, var_3_0)
	gohelper.setActive(arg_3_0.goContinued, not var_3_0)

	arg_3_0._audioId = AudioEnum.Story.play_activitysfx_shenghuo_chapter_continue

	arg_3_0:_playAudio()
end

function var_0_0._playAudio(arg_4_0)
	if arg_4_0._audioId then
		AudioEffectMgr.instance:playAudio(arg_4_0._audioId)
	end
end

function var_0_0.onHide(arg_5_0)
	if arg_5_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_5_0._audioId)

		arg_5_0._audioId = nil
	end
end

function var_0_0.onDestory(arg_6_0)
	if arg_6_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_6_0._audioId)

		arg_6_0._audioId = nil
	end

	var_0_0.super.onDestory(arg_6_0)
end

return var_0_0

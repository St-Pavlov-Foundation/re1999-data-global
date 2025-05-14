module("modules.logic.story.view.StoryActivityChapterClose1_2", package.seeall)

local var_0_0 = class("StoryActivityChapterClose1_2", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/v1a2/storyactivitychapterclose.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.node1 = gohelper.findChild(arg_2_0.viewGO, "1")
	arg_2_0.node2 = gohelper.findChild(arg_2_0.viewGO, "2")
end

function var_0_0.onUpdateView(arg_3_0)
	local var_3_0 = tonumber(arg_3_0.data) == 2

	gohelper.setActive(arg_3_0.node1, not var_3_0)
	gohelper.setActive(arg_3_0.node2, var_3_0)

	arg_3_0._audioId = var_3_0 and AudioEnum.Story.Activity1_2_Chapter_End or AudioEnum.Story.Activity1_2_Chapter_Continue

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

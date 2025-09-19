module("modules.logic.story.view.StoryGMView", package.seeall)

local var_0_0 = class("StoryGMView", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._btnLog = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_storylog")

	arg_1_0._btnLog:AddClickListener(arg_1_0._btnLogClick, arg_1_0)
end

function var_0_0._btnLogClick(arg_2_0)
	local var_2_0 = StoryController.instance._curStoryId
	local var_2_1 = StoryController.instance._curStepId

	logError(string.format("curStoryId : %s  curStepId : %s", var_2_0, var_2_1))
end

function var_0_0.destroy(arg_3_0)
	arg_3_0._btnLog:RemoveClickListener()
end

return var_0_0

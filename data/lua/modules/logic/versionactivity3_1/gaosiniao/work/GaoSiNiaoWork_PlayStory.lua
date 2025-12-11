module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_PlayStory", package.seeall)

local var_0_0 = class("GaoSiNiaoWork_PlayStory", GaoSiNiaoWorkBase)

function var_0_0.s_create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0._storyId = arg_1_0

	return var_1_0
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:clearWork()

	if not arg_2_0._storyId then
		logWarn("_storyId is null")
		arg_2_0:onSucc()

		return
	end

	if arg_2_0._storyId ~= 0 then
		arg_2_0:startBlock(nil, 1)
		arg_2_0:_playStory()
	else
		arg_2_0:onSucc()
	end
end

function var_0_0._playStory(arg_3_0)
	local var_3_0 = {}

	var_3_0.blur = true
	var_3_0.hideStartAndEndDark = true
	var_3_0.mark = true

	StoryController.instance:playStory(arg_3_0._storyId, var_3_0, arg_3_0._onStoryEnterFinishCallback, arg_3_0)
end

function var_0_0._onStoryEnterFinishCallback(arg_4_0)
	arg_4_0:onSucc()
end

return var_0_0

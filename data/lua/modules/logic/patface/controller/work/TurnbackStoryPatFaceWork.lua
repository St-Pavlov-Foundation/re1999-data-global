module("modules.logic.patface.controller.work.TurnbackStoryPatFaceWork", package.seeall)

local var_0_0 = class("TurnbackStoryPatFaceWork", PatFaceWorkBase)

function var_0_0.checkCanPat(arg_1_0)
	local var_1_0 = false
	local var_1_1 = TurnbackModel.instance:canShowTurnbackPop()
	local var_1_2 = TurnbackModel.instance:getCurTurnbackId()
	local var_1_3 = TurnbackController.instance:hasPlayedStoryVideo(var_1_2)

	if var_1_1 and not var_1_3 then
		var_1_0 = true
	end

	return var_1_0
end

function var_0_0.startPat(arg_2_0)
	local var_2_0 = TurnbackModel.instance:getCurTurnbackMo()
	local var_2_1 = var_2_0 and var_2_0.config and var_2_0.config.startStory

	if var_2_1 then
		StoryController.instance:playStory(var_2_1, nil, arg_2_0.onPlayPatStoryFinish, arg_2_0)
	else
		logError(string.format("TurnbackStoryPatFaceWork:startPat error, storyId is nil", var_2_1))
		arg_2_0:onPlayPatStoryFinish()
	end
end

return var_0_0

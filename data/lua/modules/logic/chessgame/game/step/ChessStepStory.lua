module("modules.logic.chessgame.game.step.ChessStepStory", package.seeall)

local var_0_0 = class("ChessStepStory", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0.onDoneTrue, arg_2_0)

	local var_2_0 = arg_2_0.originData.storyId
	local var_2_1 = ChessModel.instance:getActId()

	if ChessConfig.instance:getTipsCo(var_2_1, var_2_0) ~= nil then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameToastUpdate, var_2_0)
		TaskDispatcher.runDelay(arg_2_0.onDoneTrue, arg_2_0, 1)

		return
	end

	local var_2_2 = var_2_0

	if var_2_2 then
		local var_2_3 = {}

		var_2_3.blur = true
		var_2_3.hideStartAndEndDark = true
		var_2_3.mark = true
		var_2_3.isReplay = false
		arg_2_0._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
		arg_2_0._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
		PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
		PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", 0)
		StoryController.instance:playStory(var_2_2, var_2_3, arg_2_0.afterPlayStory, arg_2_0)
		ChessGameModel.instance:setPlayingStory(true)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0.onDoneTrue(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.afterPlayStory(arg_4_0)
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", arg_4_0._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", arg_4_0._initDistortStrength)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.PlayStoryonDone)
	ChessGameModel.instance:setPlayingStory(false)
	TaskDispatcher.runDelay(arg_4_0.onDoneTrue, arg_4_0, 0.3)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.onDoneTrue, arg_5_0)
end

return var_0_0

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepStory", package.seeall)

local var_0_0 = class("Va3ChessStepStory", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0.finish, arg_1_0)

	local var_1_0 = arg_1_0.originData.storyId
	local var_1_1 = Va3ChessModel.instance:getActId()

	if Va3ChessConfig.instance:getTipsCfg(var_1_1, var_1_0) ~= nil then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameToastUpdate, var_1_0)
		TaskDispatcher.runDelay(arg_1_0.finish, arg_1_0, 1)

		return
	end

	local var_1_2 = var_1_0

	if var_1_2 then
		local var_1_3 = {}

		var_1_3.blur = true
		var_1_3.hideStartAndEndDark = true
		var_1_3.mark = true
		var_1_3.isReplay = false
		arg_1_0._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
		arg_1_0._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
		PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
		PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", 0)
		StoryController.instance:playStory(var_1_2, var_1_3, arg_1_0.afterPlayStory, arg_1_0)
		Va3ChessGameModel.instance:setPlayingStory(true)
	else
		arg_1_0:finish()
	end
end

function var_0_0.afterPlayStory(arg_2_0)
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", arg_2_0._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", arg_2_0._initDistortStrength)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.PlayStoryFinish)
	Va3ChessGameModel.instance:setPlayingStory(false)
	TaskDispatcher.runDelay(arg_2_0.finish, arg_2_0, 0.3)
end

function var_0_0.dispose(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.finish, arg_3_0)
	var_0_0.super.dispose(arg_3_0)
end

return var_0_0

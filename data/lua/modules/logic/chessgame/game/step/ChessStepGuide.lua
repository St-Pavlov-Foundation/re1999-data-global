module("modules.logic.chessgame.game.step.ChessStepGuide", package.seeall)

local var_0_0 = class("ChessStepGuide", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	if GuideController.instance:isForbidGuides() then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._guideId = tonumber(arg_2_0.originData.guideId)

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_2_0._onGuideFinish, arg_2_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GuideStart, tostring(arg_2_0._guideId))
end

function var_0_0._onGuideFinish(arg_3_0, arg_3_1)
	if arg_3_0._guideId ~= arg_3_1 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_3_0._onGuideFinish, arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_4_0._onGuideFinish, arg_4_0)
end

return var_0_0

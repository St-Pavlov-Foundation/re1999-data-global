module("modules.logic.guide.controller.action.impl.GuideActionPlayAudio", package.seeall)

local var_0_0 = class("GuideActionPlayAudio", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0._audioId = tonumber(arg_1_3) or nil
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	if arg_2_0._audioId then
		GuideAudioMgr.instance:playAudio(arg_2_0._audioId)
	else
		logError("Guide audio id nil, guide_" .. arg_2_0.guideId .. "_" .. arg_2_0.stepId)
	end

	arg_2_0:onDone(true)
end

function var_0_0.onDestroy(arg_3_0, arg_3_1)
	if arg_3_0._audioId then
		GuideAudioMgr.instance:stopAudio()
	end
end

return var_0_0

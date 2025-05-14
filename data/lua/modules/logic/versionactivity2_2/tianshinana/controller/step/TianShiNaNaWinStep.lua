module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaWinStep", package.seeall)

local var_0_0 = class("TianShiNaNaWinStep", TianShiNaNaStepBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = TianShiNaNaModel.instance.episodeCo.storyClear

	if var_1_0 > 0 then
		arg_1_0._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
		arg_1_0._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
		PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
		StoryController.instance:playStory(var_1_0, nil, arg_1_0._onStoryEnd, arg_1_0)
	else
		arg_1_0:_onStoryEnd()
	end
end

function var_0_0._onStoryEnd(arg_2_0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaResultView, {
		isWin = true,
		star = arg_2_0._data.star
	})
	arg_2_0:onDone(false)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._initMaskActive ~= nil then
		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", arg_3_0._initMaskActive)
		PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", arg_3_0._initDistortStrength)
	end
end

return var_0_0

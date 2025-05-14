module("modules.logic.main.controller.work.MainParallelGuideWork", package.seeall)

local var_0_0 = class("MainParallelGuideWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if GuideController.instance:isForbidGuides() then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_0:_checkDoGuide()

	arg_1_0:onDone(not var_1_0)
end

function var_0_0._checkDoGuide(arg_2_0)
	local var_2_0 = tonumber(GuideModel.instance:getFlagValue(GuideModel.GuideFlag.MainViewGuideId))

	if var_2_0 and var_2_0 > 0 then
		local var_2_1 = MainViewGuideCondition.getCondition(var_2_0)

		if var_2_1 == nil and true or var_2_1() then
			GuideController.instance:dispatchEvent(GuideEvent.DoMainViewGuide, var_2_0)

			return true
		end
	end

	return false
end

return var_0_0

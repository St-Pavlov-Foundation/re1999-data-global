module("modules.logic.guide.controller.GuideJumpHandler", package.seeall)

local var_0_0 = class("GuideJumpHandler")
local var_0_1 = {
	"113#OnGuideFightEndContinue",
	"116#"
}

function var_0_0.ctor(arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, arg_1_0._onOneKeyFinishGuides, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0._onOneKeyFinishGuides(arg_3_0, arg_3_1)
	arg_3_0._guideSteps = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = GuideModel.instance:getById(iter_3_1).currStepId
		local var_3_1 = GuideConfig.instance:getNextStepId(iter_3_1, var_3_0)

		while var_3_1 > 0 do
			local var_3_2 = GuideConfig.instance:getStepCO(iter_3_1, var_3_1)
			local var_3_3 = string.split(var_3_2.action, "|")

			for iter_3_2 = 1, #var_3_3 do
				local var_3_4 = var_3_3[iter_3_2]

				for iter_3_3, iter_3_4 in ipairs(var_0_1) do
					if string.find(var_3_4, iter_3_4) == 1 then
						local var_3_5 = GuideActionBuilder.buildAction(iter_3_1, var_3_0, var_3_4)

						if var_3_5 then
							var_3_5:onStart()
							var_3_5:clearWork()
							logError("跳过指引，执行必要的收尾动作 guide_" .. iter_3_1 .. "_" .. var_3_1 .. " " .. var_3_4)
						end

						break
					end
				end
			end

			var_3_1 = GuideConfig.instance:getNextStepId(iter_3_1, var_3_1)
		end
	end
end

return var_0_0

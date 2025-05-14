module("modules.logic.guide.rpc.GuideRpc", package.seeall)

local var_0_0 = class("GuideRpc", BaseRpc)

function var_0_0.sendGetGuideInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = GuideModule_pb.GetGuideInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetGuideInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		GuideModel.instance:setGuideList(arg_2_2.guideInfos)
		GuideController.instance:dispatchEvent(GuideEvent.GetGuideInfoSuccess)
	end
end

function var_0_0.sendFinishGuideRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = GuideModule_pb.FinishGuideRequest()

	var_3_0.guideId = arg_3_1
	var_3_0.stepId = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveFinishGuideReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		-- block empty
	else
		GuideController.instance:dispatchEvent(GuideEvent.FinishGuideFail)
	end
end

function var_0_0.onReceiveUpdateGuidePush(arg_5_0, arg_5_1, arg_5_2)
	GuideModel.instance:updateGuideList(arg_5_2.guideInfos)

	for iter_5_0 = 1, #arg_5_2.guideInfos do
		local var_5_0 = arg_5_2.guideInfos[iter_5_0]

		logNormal(string.format("<color=#3E7E00>update guide push guide_%d_%d</color>", var_5_0.guideId, var_5_0.stepId))

		local var_5_1 = GuideModel.instance:getById(var_5_0.guideId)

		if arg_5_2.guideInfos[iter_5_0].stepId == 0 then
			GuideController.instance:dispatchEvent(GuideEvent.StartGuide, var_5_1.id)
		else
			GuideStepController.instance:clearFlow(var_5_1.id)

			local var_5_2 = var_5_1.serverStepId > 0 and var_5_1.serverStepId or var_5_1.clientStepId

			if var_5_2 == -1 then
				local var_5_3 = GuideConfig.instance:getStepList(var_5_1.id)

				var_5_2 = var_5_3[#var_5_3].stepId
			end

			GuideController.instance:dispatchEvent(GuideEvent.FinishStep, var_5_1.id, var_5_2)

			if var_5_1.isFinish then
				GuideController.instance:dispatchEvent(GuideEvent.FinishGuide, var_5_1.id)
			end
		end

		GuideController.instance:statFinishStep(var_5_1.id, var_5_1.clientStepId, false)
		GuideController.instance:execNextStep(var_5_1.id)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

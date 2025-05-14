module("modules.logic.main.controller.work.MainGuideWork", package.seeall)

local var_0_0 = class("MainGuideWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	GuideModel.instance:onOpenMainView()

	if GuideController.instance:isForbidGuides() then
		if isDebugBuild then
			local var_1_0 = arg_1_0:_getDoingGuideId()

			if var_1_0 then
				logError("登录主界面，屏蔽了强指引：" .. var_1_0)
			end
		end

		arg_1_0:onDone(true)

		return
	end

	if arg_1_0:_getDoingGuideId() then
		arg_1_0:_checkInvalid()
	elseif GuideTriggerController.instance:hasSatisfyGuide() then
		GuideController.instance:registerCallback(GuideEvent.StartGuide, arg_1_0._checkInvalid, arg_1_0)
	else
		arg_1_0:_checkInvalid()
	end

	GuideTriggerController.instance:startTrigger()
end

function var_0_0._checkInvalid(arg_2_0)
	if GuideInvalidController.instance:hasInvalidGuide() then
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_2_0._checkDoGuide, arg_2_0)
		GuideController.instance:registerCallback(GuideEvent.FinishGuideFail, arg_2_0._exceptionDone, arg_2_0)
		GuideInvalidController.instance:checkInvalid()
	else
		arg_2_0:_checkDoGuide()
	end
end

function var_0_0._exceptionDone(arg_3_0)
	logNormal("完成指引出异常，跳过")
	arg_3_0:onDone(true)
end

function var_0_0._checkDoGuide(arg_4_0)
	local var_4_0 = GuideModel.instance:getDoingGuideIdList()

	if var_4_0 then
		for iter_4_0 = #var_4_0, 1, -1 do
			if GuideConfig.instance:getGuideCO(var_4_0[iter_4_0]).parallel == 1 then
				GuideController.instance:execNextStep(var_4_0[iter_4_0])
				table.remove(var_4_0, iter_4_0)
			end
		end

		local var_4_1 = GuideConfig.instance:getHighestPriorityGuideId(var_4_0)

		if var_4_1 then
			GuideController.instance:execNextStep(var_4_1)
			GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
			BGMSwitchController.instance:startAllOnLogin()
			arg_4_0:onDone(false)

			return
		end
	end

	arg_4_0:onDone(true)
end

function var_0_0._getDoingGuideId(arg_5_0)
	local var_5_0 = GuideModel.instance:getDoingGuideIdList()

	if var_5_0 then
		for iter_5_0 = #var_5_0, 1, -1 do
			if GuideConfig.instance:getGuideCO(var_5_0[iter_5_0]).parallel == 1 then
				table.remove(var_5_0, iter_5_0)
			end
		end

		return (GuideConfig.instance:getHighestPriorityGuideId(var_5_0))
	end
end

function var_0_0.clearWork(arg_6_0)
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, arg_6_0._checkInvalid, arg_6_0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, arg_6_0._checkDoGuide, arg_6_0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideFail, arg_6_0._exceptionDone, arg_6_0)
end

return var_0_0

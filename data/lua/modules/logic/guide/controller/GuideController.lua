module("modules.logic.guide.controller.GuideController", package.seeall)

local var_0_0 = class("GuideController", BaseController)

var_0_0.EnableLog = true
var_0_0.FirstGuideId = 101

function var_0_0.onInit(arg_1_0)
	arg_1_0._toStartGuides = {}
	arg_1_0._enableGuides = true
	arg_1_0._forbidGuides = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewForbidGuide) == 1
	arg_1_0._sendingStartGuideIdDict = {}
	arg_1_0._statDict = nil

	GuideConfigChecker.instance:onInit()
end

function var_0_0.addConstEvents(arg_2_0)
	LuaSocketMgr.instance:registerPreSender(arg_2_0)
	var_0_0.instance:registerCallback(GuideEvent.StartGuide, arg_2_0._onReceiveStartGuide, arg_2_0)
	GuideConfigChecker.instance:addConstEvents()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0._enableGuides = true
	arg_3_0._sendingStartGuideIdDict = {}
	arg_3_0._guideContinueEvent = nil

	GuideConfigChecker.instance:reInit()
end

function var_0_0._onReceiveStartGuide(arg_4_0, arg_4_1)
	if arg_4_0._sendingStartGuideIdDict and arg_4_0._sendingStartGuideIdDict[arg_4_1] then
		arg_4_0._sendingStartGuideIdDict[arg_4_1] = nil
	end
end

function var_0_0.disableGuides(arg_5_0)
	arg_5_0._enableGuides = false

	GuideStepController.instance:clearStep()
end

function var_0_0.enableGuides(arg_6_0)
	arg_6_0._enableGuides = true

	local var_6_0 = GuideModel.instance:getDoingGuideIdList()

	if var_6_0 then
		for iter_6_0 = #var_6_0, 1, -1 do
			if GuideConfig.instance:getGuideCO(var_6_0[iter_6_0]).parallel == 1 then
				arg_6_0:execNextStep(var_6_0[iter_6_0])
				table.remove(var_6_0, iter_6_0)
			end
		end

		local var_6_1 = GuideConfig.instance:getHighestPriorityGuideId(var_6_0)

		if var_6_1 then
			arg_6_0:execNextStep(var_6_1)
		end
	end
end

function var_0_0.isGuiding(arg_7_0)
	if arg_7_0._forbidGuides then
		return false
	end

	if GuideModel.instance:getDoingGuideId() then
		return true
	else
		return GuideTriggerController.instance:hasSatisfyGuide()
	end
end

function var_0_0.hideGuideUIs(arg_8_0)
	local var_8_0 = ViewMgr.instance:getContainer(ViewName.GuideView)

	if var_8_0 and not gohelper.isNil(var_8_0.viewGO) then
		transformhelper.setLocalScale(var_8_0.viewGO.transform, 0, 0, 0)
	end

	local var_8_1 = ViewMgr.instance:getContainer(ViewName.GuideView2)

	if var_8_1 and not gohelper.isNil(var_8_1.viewGO) then
		transformhelper.setLocalScale(var_8_1.viewGO.transform, 0, 0, 0)
	end
end

function var_0_0.showGuideUIs(arg_9_0)
	local var_9_0 = ViewMgr.instance:getContainer(ViewName.GuideView)

	if var_9_0 and not gohelper.isNil(var_9_0.viewGO) then
		transformhelper.setLocalScale(var_9_0.viewGO.transform, 1, 1, 1)
	end

	local var_9_1 = ViewMgr.instance:getContainer(ViewName.GuideView2)

	if var_9_1 and not gohelper.isNil(var_9_1.viewGO) then
		transformhelper.setLocalScale(var_9_1.viewGO.transform, 1, 1, 1)
	end
end

function var_0_0.isForbidGuides(arg_10_0)
	return arg_10_0._forbidGuides
end

function var_0_0.tempForbidGuides(arg_11_0, arg_11_1)
	arg_11_0._forbidGuides = arg_11_1

	logError("is forbid " .. (arg_11_0._forbidGuides and "true" or "false"))
end

function var_0_0.forbidGuides(arg_12_0, arg_12_1)
	if arg_12_0._forbidGuides then
		arg_12_0._forbidGuides = false

		GameFacade.showToast(ToastEnum.GuideForbid)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewForbidGuide, 0)
	else
		arg_12_0._forbidGuides = true

		GameFacade.showToast(ToastEnum.GuideUnForbid)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewForbidGuide, 1)
	end
end

function var_0_0.oneKeyFinishGuide(arg_13_0, arg_13_1, arg_13_2)
	GuideModel.instance:clearFlagByGuideId(arg_13_1)
	arg_13_0:statFinishAllStep(true)

	local var_13_0
	local var_13_1 = GuideModel.instance:getById(arg_13_1)

	if var_13_1 == nil then
		GuideModel.instance:addEmptyGuide(arg_13_1)

		var_13_1 = GuideModel.instance:getById(arg_13_1)

		local var_13_2 = GuideConfig.instance:getStepList(arg_13_1)[1].id
	else
		local var_13_3 = var_13_1.currStepId
	end

	local var_13_4 = GuideConfig.instance:getStepList(arg_13_1)

	if var_13_1.isFinish then
		var_13_1:setClientStep(-1)
	else
		var_13_1.isJumpPass = true

		local var_13_5 = false

		for iter_13_0 = #var_13_4, 1, -1 do
			local var_13_6 = var_13_4[iter_13_0]

			if var_13_6.keyStep == 1 then
				arg_13_0._toFinishGuides = arg_13_0._toFinishGuides or {}

				table.insert(arg_13_0._toFinishGuides, {
					arg_13_1,
					var_13_6.stepId
				})
				TaskDispatcher.runRepeat(arg_13_0._onFrameFinishGuides, arg_13_0, 0.1)

				var_13_5 = true

				break
			end
		end

		if not var_13_5 then
			logError(string.format("GuideController oneKeyFinishGuide guide:%s no keyStep", arg_13_1))
		end
	end

	GuideStepController.instance:clearFlow(arg_13_1)
end

function var_0_0._onFrameFinishGuides(arg_14_0)
	if arg_14_0._toFinishGuides and #arg_14_0._toFinishGuides > 0 then
		local var_14_0 = table.remove(arg_14_0._toFinishGuides, 1)
		local var_14_1 = var_14_0[1]
		local var_14_2 = var_14_0[2]

		logNormal("One key finish guide " .. var_14_1)
		GuideRpc.instance:sendFinishGuideRequest(var_14_1, var_14_2)
	end

	if not arg_14_0._toFinishGuides or #arg_14_0._toFinishGuides == 0 then
		arg_14_0._toFinishGuides = nil

		TaskDispatcher.cancelTask(arg_14_0._onFrameFinishGuides, arg_14_0)
	end
end

function var_0_0.oneKeyFinishGuides(arg_15_0)
	arg_15_0:statFinishAllStep(true)

	local var_15_0 = GuideModel.instance:getList()
	local var_15_1

	for iter_15_0 = 1, #var_15_0 do
		local var_15_2 = var_15_0[iter_15_0]

		if var_15_2.isFinish then
			var_15_2:setClientStep(-1)
		else
			var_15_2.isJumpPass = true

			local var_15_3 = GuideConfig.instance:getStepList(var_15_2.id)

			logNormal("One key finish guides")

			for iter_15_1 = #var_15_3, 1, -1 do
				local var_15_4 = var_15_3[iter_15_1]

				if var_15_4.keyStep == 1 then
					var_15_1 = var_15_1 or {}

					table.insert(var_15_1, var_15_2.id)
					GuideRpc.instance:sendFinishGuideRequest(var_15_2.id, var_15_4.stepId)

					break
				end
			end
		end
	end

	if var_15_1 then
		var_0_0.instance:dispatchEvent(GuideEvent.OneKeyFinishGuides, var_15_1)
	end
end

function var_0_0.toStartGudie(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._sendingStartGuideIdDict[arg_16_1] and true or false

	if var_0_0.EnableLog then
		logNormal("to start guide: " .. arg_16_1 .. ", is sending guide: " .. (var_16_0 and "true" or "false") .. debug.traceback("", 2))
	end

	if not var_16_0 then
		table.insert(arg_16_0._toStartGuides, arg_16_1)

		local var_16_1 = GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and 1 or 0.1

		UIBlockMgr.instance:startBlock(UIBlockKey.Guide)
		TaskDispatcher.runDelay(arg_16_0._selectOneGuideToStart, arg_16_0, var_16_1)
	end
end

function var_0_0._selectOneGuideToStart(arg_17_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.Guide)
	TaskDispatcher.cancelTask(arg_17_0._selectOneGuideToStart, arg_17_0)

	local var_17_0 = GuideConfig.instance:getHighestPriorityGuideId(arg_17_0._toStartGuides)

	arg_17_0._toStartGuides = {}

	if var_17_0 then
		arg_17_0:startGudie(var_17_0)
	end
end

function var_0_0.startGudie(arg_18_0, arg_18_1)
	if not GuideConfig.instance:getGuideCO(arg_18_1) then
		logError("guide config not exist " .. arg_18_1)

		return
	end

	if GuideInvalidController.instance:isInvalid(arg_18_1) then
		local var_18_0 = GuideModel.instance:getById(arg_18_1)

		if not var_18_0 or not var_18_0.isFinish then
			arg_18_0:oneKeyFinishGuide(arg_18_1, true)
		end
	else
		if var_0_0.EnableLog then
			logNormal("send start guide: " .. arg_18_1 .. debug.traceback("", 2))
		end

		if not arg_18_0._sendingStartGuideIdDict[arg_18_1] then
			arg_18_0._sendingStartGuideIdDict[arg_18_1] = true

			GuideRpc.instance:sendFinishGuideRequest(arg_18_1, 0)
		end
	end
end

function var_0_0.checkStartFirstGuide(arg_19_0)
	if arg_19_0._enableGuides and arg_19_0._forbidGuides == false then
		local var_19_0 = GuideModel.instance:getById(var_0_0.FirstGuideId)

		if var_19_0 and var_19_0.isFinish then
			return false
		elseif GuideInvalidController.instance:isInvalid(var_0_0.FirstGuideId) then
			arg_19_0:oneKeyFinishGuide(var_0_0.FirstGuideId, true)

			return false
		else
			if var_19_0 then
				arg_19_0:execNextStep(var_0_0.FirstGuideId)
			else
				arg_19_0:startGudie(var_0_0.FirstGuideId)
			end

			return true
		end
	else
		return false
	end
end

function var_0_0.startStep(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0:statStartStep(arg_20_3 or arg_20_1, arg_20_2)
end

function var_0_0.finishStep(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	arg_21_0:statFinishStep(arg_21_1, arg_21_2, arg_21_4)

	if arg_21_4 then
		arg_21_0:_tLogEndGuide(arg_21_1, arg_21_2, arg_21_4 and 2 or 1)
	end

	local var_21_0 = GuideModel.instance:getById(arg_21_1)

	if not var_21_0 then
		return
	end

	local var_21_1 = var_21_0:getCurStepCO()

	if not var_21_1 then
		return
	end

	if var_21_1.keyStep == 1 then
		arg_21_0._targetAdditionCmd = var_21_1.additionCmd

		if arg_21_3 == true or string.nilorempty(arg_21_0._targetAdditionCmd) then
			GuideRpc.instance:sendFinishGuideRequest(arg_21_1, var_21_0.currStepId)
		elseif not string.nilorempty(arg_21_0._targetAdditionCmd) and arg_21_0._targetAdditionCmd ~= arg_21_0._hasSendAdditionCmd then
			arg_21_0._guideId = arg_21_1
			arg_21_0._stepId = arg_21_2

			TaskDispatcher.runDelay(arg_21_0._delayCheckSendProtoAdditionException, arg_21_0, 2)
		end
	else
		GuideModel.instance:clientFinishStep(arg_21_1, var_21_0.currStepId)
		GuideStepController.instance:clearFlow(arg_21_1)
		var_0_0.instance:dispatchEvent(GuideEvent.FinishStep, arg_21_1, var_21_0.clientStepId)
		arg_21_0:execNextStep(arg_21_1)
	end

	arg_21_0._hasSendAdditionCmd = nil
end

function var_0_0._delayCheckSendProtoAdditionException(arg_22_0)
	if arg_22_0._targetAdditionCmd then
		var_0_0.instance:oneKeyFinishGuide(arg_22_0._guideId, true)
		logError(string.format("出bug了，附加协议没发出去，把指引结束吧 guide_%d_%d", arg_22_0._guideId, arg_22_0._stepId))
	end
end

function var_0_0.execNextStep(arg_23_0, arg_23_1)
	if arg_23_0._enableGuides and arg_23_0._forbidGuides == false then
		local var_23_0 = GuideModel.instance:getById(arg_23_1)

		if var_23_0.currStepId > 0 then
			GuideModel.instance:execStep(var_23_0.currGuideId, var_23_0.currStepId)
			GuideStepController.instance:execStep(arg_23_1, var_23_0.currStepId, var_23_0.currGuideId)
		elseif var_23_0.isFinish then
			var_0_0.instance:dispatchEvent(GuideEvent.FinishGuideLastStep, var_23_0.id)
		end
	elseif isDebugBuild then
		logNormal("disable guides, can't exec step")
	else
		logError("disable guides, can't exec step")
	end
end

function var_0_0.preSendProto(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = GuideModel.instance:getDoingGuideIdList()

	if var_24_0 then
		for iter_24_0 = 1, #var_24_0 do
			local var_24_1 = GuideModel.instance:getById(var_24_0[iter_24_0])
			local var_24_2 = GuideConfig.instance:getStepCO(var_24_1.id, var_24_1.currStepId)

			if var_24_2 and not string.nilorempty(var_24_2.additionCmd) then
				local var_24_3 = string.split(var_24_2.additionKey, ":")
				local var_24_4 = #var_24_3 >= 2 and tonumber(var_24_3[2])

				logNormal(string.format("<color=red>指引_%d_%d, 附加协议_%d</color>", var_24_1.id, var_24_1.currStepId, arg_24_1))
				logNormal(string.format("<color=red>目标步骤_%d</color>", var_24_4 or var_24_2.stepId))

				if var_24_4 then
					arg_24_2.guideIdE = var_24_1.id
					arg_24_2.stepIdE = var_24_4
				else
					arg_24_2.guideId = var_24_1.id
					arg_24_2.stepId = var_24_2.stepId
				end

				arg_24_0._hasSendAdditionCmd = arg_24_1

				TaskDispatcher.cancelTask(arg_24_0._delayCheckSendProtoAdditionException, arg_24_0)
			end
		end
	end
end

function var_0_0.statStartStep(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = GuideConfig.instance:getStepCO(arg_25_1, arg_25_2)

	if var_25_0.stat and var_25_0.stat <= 0 then
		return
	end

	arg_25_0._statDict = arg_25_0._statDict or {}
	arg_25_0._statDict[arg_25_1] = arg_25_0._statDict[arg_25_1] or {}
	arg_25_0._statDict[arg_25_1][arg_25_2] = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.GuideStart, {
		[StatEnum.EventProperties.GuideId] = arg_25_1,
		[StatEnum.EventProperties.StepId] = arg_25_2
	})
end

function var_0_0.statFinishStep(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0._statDict = arg_26_0._statDict or {}
	arg_26_0._statDict[arg_26_1] = arg_26_0._statDict[arg_26_1] or {}

	if arg_26_0._statDict[arg_26_1][arg_26_2] then
		local var_26_0 = ServerTime.now() - arg_26_0._statDict[arg_26_1][arg_26_2]

		StatController.instance:track(StatEnum.EventName.GuideEnd, {
			[StatEnum.EventProperties.GuideId] = arg_26_1,
			[StatEnum.EventProperties.StepId] = arg_26_2,
			[StatEnum.EventProperties.UseTime] = var_26_0,
			[StatEnum.EventProperties.IsException] = arg_26_3 and true or false
		})
	end

	arg_26_0._statDict[arg_26_1][arg_26_2] = nil
end

function var_0_0.statFinishAllStep(arg_27_0, arg_27_1)
	arg_27_0._statDict = arg_27_0._statDict or {}

	for iter_27_0, iter_27_1 in pairs(arg_27_0._statDict) do
		for iter_27_2, iter_27_3 in pairs(iter_27_1) do
			local var_27_0 = ServerTime.now() - iter_27_3

			StatController.instance:track(StatEnum.EventName.GuideEnd, {
				[StatEnum.EventProperties.GuideId] = iter_27_0,
				[StatEnum.EventProperties.StepId] = iter_27_2,
				[StatEnum.EventProperties.UseTime] = var_27_0,
				[StatEnum.EventProperties.IsException] = arg_27_1 and true or false
			})
		end
	end
end

function var_0_0.shouldBlockDungeonBack(arg_28_0)
	if arg_28_0:isForbidGuides() then
		return false
	end

	return not DungeonModel.instance:hasPassLevel(CommonConfig.instance:getConstNum(ConstEnum.NewbieTermEpisode))
end

function var_0_0.shouldPlayStory(arg_29_0)
	if arg_29_0:isForbidGuides() then
		return false
	end

	local var_29_0 = DungeonConfig.instance:getEpisodeCO(CommonConfig.instance:getConstNum(ConstEnum.NewbieTermEpisode))

	return var_29_0 and var_29_0.afterStory > 0 and not StoryModel.instance:isStoryFinished(var_29_0.afterStory)
end

function var_0_0.GuideFlowPauseAndContinue(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8)
	local var_30_0 = GuideModel.instance:getGuideParam()

	var_0_0.instance:dispatchEvent(arg_30_2, var_30_0, arg_30_6, arg_30_7, arg_30_8)

	if var_30_0[arg_30_1] then
		var_30_0[arg_30_1] = false

		if arg_30_0._guideContinueEvent then
			logError("guiding event: " .. arg_30_0._guideContinueEvent .. ", try to replase with: " .. arg_30_3)
			var_0_0.instance:unregisterCallback(arg_30_0._guideContinueEvent, arg_30_0._continueCallback, arg_30_0)
		end

		arg_30_0._guideContinueEvent = arg_30_3
		arg_30_0._guideCallback = arg_30_4
		arg_30_0._guideCallbackObj = arg_30_5

		var_0_0.instance:registerCallback(arg_30_0._guideContinueEvent, arg_30_0._continueCallback, arg_30_0)

		return true
	else
		arg_30_4(arg_30_5)

		if arg_30_0._guideContinueEvent == arg_30_2 then
			var_0_0.instance:unregisterCallback(arg_30_0._guideContinueEvent, arg_30_0._continueCallback, arg_30_0)

			arg_30_0._guideContinueEvent = nil
			arg_30_0._guideCallback = nil
			arg_30_0._guideCallbackObj = nil
		end
	end

	return false
end

function var_0_0._continueCallback(arg_31_0)
	if arg_31_0._guideContinueEvent then
		var_0_0.instance:unregisterCallback(arg_31_0._guideContinueEvent, arg_31_0._continueCallback, arg_31_0)

		local var_31_0 = arg_31_0._guideCallback
		local var_31_1 = arg_31_0._guideCallbackObj

		arg_31_0._guideContinueEvent = nil
		arg_31_0._guideCallback = nil
		arg_31_0._guideCallbackObj = nil

		var_31_0(var_31_1)
	end
end

function var_0_0.isAnyGuideRunning(arg_32_0)
	return ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2) or UIBlockMgr.instance:isBlock() and true or false
end

function var_0_0.isAnyGuideRunningNoBlock(arg_33_0)
	return ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2) and true or false
end

var_0_0.instance = var_0_0.New()

return var_0_0

module("modules.logic.guide.controller.GuideController", package.seeall)

slot0 = class("GuideController", BaseController)
slot0.EnableLog = true
slot0.FirstGuideId = 101

function slot0.onInit(slot0)
	slot0._toStartGuides = {}
	slot0._enableGuides = true
	slot0._forbidGuides = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewForbidGuide) == 1
	slot0._sendingStartGuideIdDict = {}
	slot0._statDict = nil

	GuideConfigChecker.instance:onInit()
end

function slot0.addConstEvents(slot0)
	LuaSocketMgr.instance:registerPreSender(slot0)
	uv0.instance:registerCallback(GuideEvent.StartGuide, slot0._onReceiveStartGuide, slot0)
	GuideConfigChecker.instance:addConstEvents()
end

function slot0.reInit(slot0)
	slot0._enableGuides = true
	slot0._sendingStartGuideIdDict = {}
	slot0._guideContinueEvent = nil

	GuideConfigChecker.instance:reInit()
end

function slot0._onReceiveStartGuide(slot0, slot1)
	if slot0._sendingStartGuideIdDict and slot0._sendingStartGuideIdDict[slot1] then
		slot0._sendingStartGuideIdDict[slot1] = nil
	end
end

function slot0.disableGuides(slot0)
	slot0._enableGuides = false

	GuideStepController.instance:clearStep()
end

function slot0.enableGuides(slot0)
	slot0._enableGuides = true

	if GuideModel.instance:getDoingGuideIdList() then
		for slot5 = #slot1, 1, -1 do
			if GuideConfig.instance:getGuideCO(slot1[slot5]).parallel == 1 then
				slot0:execNextStep(slot1[slot5])
				table.remove(slot1, slot5)
			end
		end

		if GuideConfig.instance:getHighestPriorityGuideId(slot1) then
			slot0:execNextStep(slot2)
		end
	end
end

function slot0.isGuiding(slot0)
	if slot0._forbidGuides then
		return false
	end

	if GuideModel.instance:getDoingGuideId() then
		return true
	else
		return GuideTriggerController.instance:hasSatisfyGuide()
	end
end

function slot0.hideGuideUIs(slot0)
	if ViewMgr.instance:getContainer(ViewName.GuideView) and not gohelper.isNil(slot1.viewGO) then
		transformhelper.setLocalScale(slot1.viewGO.transform, 0, 0, 0)
	end

	if ViewMgr.instance:getContainer(ViewName.GuideView2) and not gohelper.isNil(slot1.viewGO) then
		transformhelper.setLocalScale(slot1.viewGO.transform, 0, 0, 0)
	end
end

function slot0.showGuideUIs(slot0)
	if ViewMgr.instance:getContainer(ViewName.GuideView) and not gohelper.isNil(slot1.viewGO) then
		transformhelper.setLocalScale(slot1.viewGO.transform, 1, 1, 1)
	end

	if ViewMgr.instance:getContainer(ViewName.GuideView2) and not gohelper.isNil(slot1.viewGO) then
		transformhelper.setLocalScale(slot1.viewGO.transform, 1, 1, 1)
	end
end

function slot0.isForbidGuides(slot0)
	return slot0._forbidGuides
end

function slot0.tempForbidGuides(slot0, slot1)
	slot0._forbidGuides = slot1

	logError("is forbid " .. (slot0._forbidGuides and "true" or "false"))
end

function slot0.forbidGuides(slot0, slot1)
	if slot0._forbidGuides then
		slot0._forbidGuides = false

		GameFacade.showToast(ToastEnum.GuideForbid)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewForbidGuide, 0)
	else
		slot0._forbidGuides = true

		GameFacade.showToast(ToastEnum.GuideUnForbid)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewForbidGuide, 1)
	end
end

function slot0.oneKeyFinishGuide(slot0, slot1, slot2)
	GuideModel.instance:clearFlagByGuideId(slot1)
	slot0:statFinishAllStep(true)

	slot3 = nil

	if GuideModel.instance:getById(slot1) == nil then
		GuideModel.instance:addEmptyGuide(slot1)

		slot4 = GuideModel.instance:getById(slot1)
		slot3 = GuideConfig.instance:getStepList(slot1)[1].id
	else
		slot3 = slot4.currStepId
	end

	slot5 = GuideConfig.instance:getStepList(slot1)

	if slot4.isFinish then
		slot4:setClientStep(-1)
	else
		slot4.isJumpPass = true

		for slot9 = #slot5, 1, -1 do
			if slot5[slot9].keyStep == 1 then
				slot0._toFinishGuides = slot0._toFinishGuides or {}

				table.insert(slot0._toFinishGuides, {
					slot1,
					slot10.stepId
				})
				TaskDispatcher.runRepeat(slot0._onFrameFinishGuides, slot0, 0.1)

				break
			end
		end
	end

	GuideStepController.instance:clearFlow(slot1)
end

function slot0._onFrameFinishGuides(slot0)
	if slot0._toFinishGuides and #slot0._toFinishGuides > 0 then
		slot1 = table.remove(slot0._toFinishGuides, 1)
		slot2 = slot1[1]

		logNormal("One key finish guide " .. slot2)
		GuideRpc.instance:sendFinishGuideRequest(slot2, slot1[2])
	end

	if not slot0._toFinishGuides or #slot0._toFinishGuides == 0 then
		slot0._toFinishGuides = nil

		TaskDispatcher.cancelTask(slot0._onFrameFinishGuides, slot0)
	end
end

function slot0.oneKeyFinishGuides(slot0)
	slot0:statFinishAllStep(true)

	slot2 = nil

	for slot6 = 1, #GuideModel.instance:getList() do
		if slot1[slot6].isFinish then
			slot7:setClientStep(-1)
		else
			slot7.isJumpPass = true

			logNormal("One key finish guides")

			for slot12 = #GuideConfig.instance:getStepList(slot7.id), 1, -1 do
				if slot8[slot12].keyStep == 1 then
					table.insert(slot2 or {}, slot7.id)
					GuideRpc.instance:sendFinishGuideRequest(slot7.id, slot13.stepId)

					break
				end
			end
		end
	end

	if slot2 then
		uv0.instance:dispatchEvent(GuideEvent.OneKeyFinishGuides, slot2)
	end
end

function slot0.toStartGudie(slot0, slot1)
	slot2 = slot0._sendingStartGuideIdDict[slot1] and true or false

	if uv0.EnableLog then
		logNormal("to start guide: " .. slot1 .. ", is sending guide: " .. (slot2 and "true" or "false") .. debug.traceback("", 2))
	end

	if not slot2 then
		table.insert(slot0._toStartGuides, slot1)
		UIBlockMgr.instance:startBlock(UIBlockKey.Guide)
		TaskDispatcher.runDelay(slot0._selectOneGuideToStart, slot0, GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and 1 or 0.1)
	end
end

function slot0._selectOneGuideToStart(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.Guide)
	TaskDispatcher.cancelTask(slot0._selectOneGuideToStart, slot0)

	slot0._toStartGuides = {}

	if GuideConfig.instance:getHighestPriorityGuideId(slot0._toStartGuides) then
		slot0:startGudie(slot1)
	end
end

function slot0.startGudie(slot0, slot1)
	if not GuideConfig.instance:getGuideCO(slot1) then
		logError("guide config not exist " .. slot1)

		return
	end

	if GuideInvalidController.instance:isInvalid(slot1) then
		if not GuideModel.instance:getById(slot1) or not slot3.isFinish then
			slot0:oneKeyFinishGuide(slot1, true)
		end
	else
		if uv0.EnableLog then
			logNormal("send start guide: " .. slot1 .. debug.traceback("", 2))
		end

		if not slot0._sendingStartGuideIdDict[slot1] then
			slot0._sendingStartGuideIdDict[slot1] = true

			GuideRpc.instance:sendFinishGuideRequest(slot1, 0)
		end
	end
end

function slot0.checkStartFirstGuide(slot0)
	if slot0._enableGuides and slot0._forbidGuides == false then
		if GuideModel.instance:getById(uv0.FirstGuideId) and slot1.isFinish then
			return false
		elseif GuideInvalidController.instance:isInvalid(uv0.FirstGuideId) then
			slot0:oneKeyFinishGuide(uv0.FirstGuideId, true)

			return false
		else
			if slot1 then
				slot0:execNextStep(uv0.FirstGuideId)
			else
				slot0:startGudie(uv0.FirstGuideId)
			end

			return true
		end
	else
		return false
	end
end

function slot0.startStep(slot0, slot1, slot2, slot3)
	slot0:statStartStep(slot3 or slot1, slot2)
end

function slot0.finishStep(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:statFinishStep(slot1, slot2, slot4)

	if slot4 then
		slot0:_tLogEndGuide(slot1, slot2, slot4 and 2 or 1)
	end

	if not GuideModel.instance:getById(slot1) then
		return
	end

	if not slot6:getCurStepCO() then
		return
	end

	if slot7.keyStep == 1 then
		slot0._targetAdditionCmd = slot7.additionCmd

		if slot3 == true or string.nilorempty(slot0._targetAdditionCmd) then
			GuideRpc.instance:sendFinishGuideRequest(slot1, slot6.currStepId)
		elseif not string.nilorempty(slot0._targetAdditionCmd) and slot0._targetAdditionCmd ~= slot0._hasSendAdditionCmd then
			slot0._guideId = slot1
			slot0._stepId = slot2

			TaskDispatcher.runDelay(slot0._delayCheckSendProtoAdditionException, slot0, 2)
		end
	else
		GuideModel.instance:clientFinishStep(slot1, slot6.currStepId)
		GuideStepController.instance:clearFlow(slot1)
		uv0.instance:dispatchEvent(GuideEvent.FinishStep, slot1, slot6.clientStepId)
		slot0:execNextStep(slot1)
	end

	slot0._hasSendAdditionCmd = nil
end

function slot0._delayCheckSendProtoAdditionException(slot0)
	if slot0._targetAdditionCmd then
		uv0.instance:oneKeyFinishGuide(slot0._guideId, true)
		logError(string.format("出bug了，附加协议没发出去，把指引结束吧 guide_%d_%d", slot0._guideId, slot0._stepId))
	end
end

function slot0.execNextStep(slot0, slot1)
	if slot0._enableGuides and slot0._forbidGuides == false then
		if GuideModel.instance:getById(slot1).currStepId > 0 then
			GuideModel.instance:execStep(slot2.currGuideId, slot2.currStepId)
			GuideStepController.instance:execStep(slot1, slot2.currStepId, slot2.currGuideId)
		elseif slot2.isFinish then
			uv0.instance:dispatchEvent(GuideEvent.FinishGuideLastStep, slot2.id)
		end
	elseif isDebugBuild then
		logNormal("disable guides, can't exec step")
	else
		logError("disable guides, can't exec step")
	end
end

function slot0.preSendProto(slot0, slot1, slot2, slot3)
	if GuideModel.instance:getDoingGuideIdList() then
		for slot8 = 1, #slot4 do
			slot9 = GuideModel.instance:getById(slot4[slot8])

			if GuideConfig.instance:getStepCO(slot9.id, slot9.currStepId) and not string.nilorempty(slot10.additionCmd) then
				slot12 = #string.split(slot10.additionKey, ":") >= 2 and tonumber(slot11[2])

				logNormal(string.format("<color=red>指引_%d_%d, 附加协议_%d</color>", slot9.id, slot9.currStepId, slot1))
				logNormal(string.format("<color=red>目标步骤_%d</color>", slot12 or slot10.stepId))

				if slot12 then
					slot2.guideIdE = slot9.id
					slot2.stepIdE = slot12
				else
					slot2.guideId = slot9.id
					slot2.stepId = slot10.stepId
				end

				slot0._hasSendAdditionCmd = slot1

				TaskDispatcher.cancelTask(slot0._delayCheckSendProtoAdditionException, slot0)
			end
		end
	end
end

function slot0.statStartStep(slot0, slot1, slot2)
	if GuideConfig.instance:getStepCO(slot1, slot2).stat and slot3.stat <= 0 then
		return
	end

	slot0._statDict = slot0._statDict or {}
	slot0._statDict[slot1] = slot0._statDict[slot1] or {}
	slot0._statDict[slot1][slot2] = ServerTime.now()

	StatController.instance:track(StatEnum.EventName.GuideStart, {
		[StatEnum.EventProperties.GuideId] = slot1,
		[StatEnum.EventProperties.StepId] = slot2
	})
end

function slot0.statFinishStep(slot0, slot1, slot2, slot3)
	slot0._statDict = slot0._statDict or {}
	slot0._statDict[slot1] = slot0._statDict[slot1] or {}

	if slot0._statDict[slot1][slot2] then
		StatController.instance:track(StatEnum.EventName.GuideEnd, {
			[StatEnum.EventProperties.GuideId] = slot1,
			[StatEnum.EventProperties.StepId] = slot2,
			[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0._statDict[slot1][slot2],
			[StatEnum.EventProperties.IsException] = slot3 and true or false
		})
	end

	slot0._statDict[slot1][slot2] = nil
end

function slot0.statFinishAllStep(slot0, slot1)
	slot0._statDict = slot0._statDict or {}

	for slot5, slot6 in pairs(slot0._statDict) do
		for slot10, slot11 in pairs(slot6) do
			StatController.instance:track(StatEnum.EventName.GuideEnd, {
				[StatEnum.EventProperties.GuideId] = slot5,
				[StatEnum.EventProperties.StepId] = slot10,
				[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot11,
				[StatEnum.EventProperties.IsException] = slot1 and true or false
			})
		end
	end
end

function slot0.shouldBlockDungeonBack(slot0)
	if slot0:isForbidGuides() then
		return false
	end

	return not DungeonModel.instance:hasPassLevel(CommonConfig.instance:getConstNum(ConstEnum.NewbieTermEpisode))
end

function slot0.shouldPlayStory(slot0)
	if slot0:isForbidGuides() then
		return false
	end

	return DungeonConfig.instance:getEpisodeCO(CommonConfig.instance:getConstNum(ConstEnum.NewbieTermEpisode)) and slot1.afterStory > 0 and not StoryModel.instance:isStoryFinished(slot1.afterStory)
end

function slot0.GuideFlowPauseAndContinue(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = GuideModel.instance:getGuideParam()

	uv0.instance:dispatchEvent(slot2, slot9, slot6, slot7, slot8)

	if slot9[slot1] then
		slot9[slot1] = false

		if slot0._guideContinueEvent then
			logError("guiding event: " .. slot0._guideContinueEvent .. ", try to replase with: " .. slot3)
			uv0.instance:unregisterCallback(slot0._guideContinueEvent, slot0._continueCallback, slot0)
		end

		slot0._guideContinueEvent = slot3
		slot0._guideCallback = slot4
		slot0._guideCallbackObj = slot5

		uv0.instance:registerCallback(slot0._guideContinueEvent, slot0._continueCallback, slot0)

		return true
	else
		slot4(slot5)

		if slot0._guideContinueEvent == slot2 then
			uv0.instance:unregisterCallback(slot0._guideContinueEvent, slot0._continueCallback, slot0)

			slot0._guideContinueEvent = nil
			slot0._guideCallback = nil
			slot0._guideCallbackObj = nil
		end
	end

	return false
end

function slot0._continueCallback(slot0)
	if slot0._guideContinueEvent then
		uv0.instance:unregisterCallback(slot0._guideContinueEvent, slot0._continueCallback, slot0)

		slot0._guideContinueEvent = nil
		slot0._guideCallback = nil
		slot0._guideCallbackObj = nil

		slot0._guideCallback(slot0._guideCallbackObj)
	end
end

function slot0.isAnyGuideRunning(slot0)
	return ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2) or UIBlockMgr.instance:isBlock() and true or false
end

function slot0.isAnyGuideRunningNoBlock(slot0)
	return ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2) and true or false
end

slot0.instance = slot0.New()

return slot0

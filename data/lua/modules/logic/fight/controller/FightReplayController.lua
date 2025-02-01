module("modules.logic.fight.controller.FightReplayController", package.seeall)

slot0 = class("FightReplayController", BaseController)

function slot0.onInit(slot0)
	slot0._replayErrorFix = FightReplayErrorFix.New()
end

function slot0.reInit(slot0)
	slot0._replayErrorFix:reInit()
	slot0:_stopReplay()

	slot0._callback = nil
	slot0._calbackObj = nil
end

function slot0.addConstEvents(slot0)
	FightController.instance:registerCallback(FightEvent.StartReplay, slot0._startReplay, slot0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._stopReplay, slot0)
	FightController.instance:registerCallback(FightEvent.RespGetFightOperReplay, slot0._onGetOperReplay, slot0)
	FightController.instance:registerCallback(FightEvent.RespGetFightOperReplayFail, slot0._onGetOperReplayFail, slot0)
	slot0._replayErrorFix:addConstEvents()
end

function slot0.reqReplay(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._calbackObj = slot2

	FightRpc.instance:sendGetFightOperRequest()
end

function slot0._setQuality(slot0, slot1)
	if slot1 then
		if not slot0._quality then
			slot0._quality = SettingsModel.instance:getModelGraphicsQuality()
			slot0._frameRate = SettingsModel.instance:getModelTargetFrameRate()

			GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low, true)
			GameGlobalMgr.instance:getScreenState():setTargetFrameRate(ModuleEnum.TargetFrameRate.Low, true)
		end
	elseif slot0._quality then
		GameGlobalMgr.instance:getScreenState():setLocalQuality(slot0._quality, true)
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(slot0._frameRate, true)

		slot0._quality = nil
		slot0._frameRate = nil
	end
end

function slot0._onGetOperReplay(slot0)
	FightController.instance:dispatchEvent(FightEvent.StartReplay)
	FightReplayModel.instance:setReplay(true)
	slot0:_reqReplayCallback()
end

function slot0._onGetOperReplayFail(slot0)
	slot0:_reqReplayCallback()
end

function slot0._reqReplayCallback(slot0)
	slot0._callback = nil
	slot0._calbackObj = nil

	if slot0._callback then
		slot1(slot0._calbackObj)
	end
end

function slot0._startReplay(slot0)
	slot0:_setQuality(true)
	slot0:_stopReplayFlow()

	slot0._replayFlow = FightReplayStepBuilder.buildReplaySequence()

	slot0._replayFlow:registerDoneListener(slot0._onReplayDone, slot0)
	slot0._replayFlow:start({})
end

function slot0.doneCardStage(slot0)
	if slot0._replayFlow and slot0._replayFlow.status == WorkStatus.Running then
		slot1 = slot0._replayFlow:getWorkList()
		slot3 = slot0._replayFlow._workList and slot0._replayFlow._workList[slot0._replayFlow._curIndex]

		for slot7 = slot2, #slot1 do
			if isTypeOf(slot1[slot7], FightReplayWorkWaitRoundEnd) then
				slot0._replayFlow._curIndex = slot7 - 1

				slot0._replayFlow:_runNext()

				break
			end
		end

		if slot3 then
			slot3:onDone(true)
		end
	end
end

function slot0._onReplayDone(slot0)
	slot0:_stopReplayFlow()
end

function slot0._stopReplay(slot0)
	slot0:_setQuality(false)
	FightReplayModel.instance:setReplay(false)
	slot0:_stopReplayFlow()
end

function slot0._stopReplayFlow(slot0)
	if slot0._replayFlow then
		if slot0._replayFlow.status == WorkStatus.Running then
			slot0._replayFlow:stop()
		end

		slot0._replayFlow:unregisterDoneListener(slot0._onReplayDone, slot0)

		slot0._replayFlow = nil
	end
end

slot0.instance = slot0.New()

return slot0

module("modules.logic.fight.controller.FightReplayController", package.seeall)

local var_0_0 = class("FightReplayController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._replayErrorFix = FightReplayErrorFix.New()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._replayErrorFix:reInit()
	arg_2_0:_stopReplay()

	arg_2_0._callback = nil
	arg_2_0._calbackObj = nil
end

function var_0_0.addConstEvents(arg_3_0)
	FightController.instance:registerCallback(FightEvent.StartReplay, arg_3_0._startReplay, arg_3_0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_3_0._stopReplay, arg_3_0)
	FightController.instance:registerCallback(FightEvent.RespGetFightOperReplay, arg_3_0._onGetOperReplay, arg_3_0)
	FightController.instance:registerCallback(FightEvent.RespGetFightOperReplayFail, arg_3_0._onGetOperReplayFail, arg_3_0)
	arg_3_0._replayErrorFix:addConstEvents()
end

function var_0_0.reqReplay(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._callback = arg_4_1
	arg_4_0._calbackObj = arg_4_2

	FightRpc.instance:sendGetFightOperRequest()
end

function var_0_0._setQuality(arg_5_0, arg_5_1)
	if arg_5_1 then
		if not arg_5_0._quality then
			arg_5_0._quality = SettingsModel.instance:getModelGraphicsQuality()
			arg_5_0._frameRate = SettingsModel.instance:getModelTargetFrameRate()

			GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low, true)
			GameGlobalMgr.instance:getScreenState():setTargetFrameRate(ModuleEnum.TargetFrameRate.Low, true)
		end
	elseif arg_5_0._quality then
		GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_5_0._quality, true)
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(arg_5_0._frameRate, true)

		arg_5_0._quality = nil
		arg_5_0._frameRate = nil
	end
end

function var_0_0._onGetOperReplay(arg_6_0)
	FightController.instance:dispatchEvent(FightEvent.StartReplay)
	FightReplayModel.instance:setReplay(true)
	arg_6_0:_reqReplayCallback()
end

function var_0_0._onGetOperReplayFail(arg_7_0)
	arg_7_0:_reqReplayCallback()
end

function var_0_0._reqReplayCallback(arg_8_0)
	local var_8_0 = arg_8_0._callback
	local var_8_1 = arg_8_0._calbackObj

	arg_8_0._callback = nil
	arg_8_0._calbackObj = nil

	if var_8_0 then
		var_8_0(var_8_1)
	end
end

function var_0_0._startReplay(arg_9_0)
	arg_9_0:_setQuality(true)
	arg_9_0:_stopReplayFlow()

	arg_9_0._replayFlow = FightReplayStepBuilder.buildReplaySequence()

	arg_9_0._replayFlow:registerDoneListener(arg_9_0._onReplayDone, arg_9_0)
	arg_9_0._replayFlow:start({})
end

function var_0_0.doneCardStage(arg_10_0)
	if arg_10_0._replayFlow and arg_10_0._replayFlow.status == WorkStatus.Running then
		local var_10_0 = arg_10_0._replayFlow:getWorkList()
		local var_10_1 = arg_10_0._replayFlow._curIndex
		local var_10_2 = arg_10_0._replayFlow._workList and arg_10_0._replayFlow._workList[var_10_1]

		for iter_10_0 = var_10_1, #var_10_0 do
			local var_10_3 = var_10_0[iter_10_0]

			if isTypeOf(var_10_3, FightReplayWorkWaitRoundEnd) then
				arg_10_0._replayFlow._curIndex = iter_10_0 - 1

				arg_10_0._replayFlow:_runNext()

				break
			end
		end

		if var_10_2 then
			var_10_2:onDone(true)
		end
	end
end

function var_0_0._onReplayDone(arg_11_0)
	arg_11_0:_stopReplayFlow()
end

function var_0_0._stopReplay(arg_12_0)
	arg_12_0:_setQuality(false)
	FightReplayModel.instance:setReplay(false)
	arg_12_0:_stopReplayFlow()
end

function var_0_0._stopReplayFlow(arg_13_0)
	if arg_13_0._replayFlow then
		if arg_13_0._replayFlow.status == WorkStatus.Running then
			arg_13_0._replayFlow:stop()
		end

		arg_13_0._replayFlow:unregisterDoneListener(arg_13_0._onReplayDone, arg_13_0)

		arg_13_0._replayFlow = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

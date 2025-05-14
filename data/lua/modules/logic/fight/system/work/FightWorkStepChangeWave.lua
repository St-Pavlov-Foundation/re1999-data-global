module("modules.logic.fight.system.work.FightWorkStepChangeWave", package.seeall)

local var_0_0 = class("FightWorkStepChangeWave", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._flow = FlowSequence.New()

	arg_1_0._flow:addWork(FightWorkWaveEndDialog.New())
	arg_1_0._flow:addWork(FightWorkStepShowNoteWhenChangeWave.New())
	arg_1_0._flow:addWork(WorkWaitSeconds.New(0.01))
	arg_1_0._flow:addWork(FightWorkChangeWaveView.New())
	arg_1_0._flow:addWork(FightWorkChangeWaveStartDialog.New())
	arg_1_0._flow:registerDoneListener(arg_1_0._startChangeWave, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0._startChangeWave(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.ChangeWaveStart)
	FightPlayCardModel.instance:onEndRound()

	arg_2_0.context.oldEntityIdDict = {}

	local var_2_0 = FightHelper.getAllEntitys()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		iter_2_1:resetEntity()

		arg_2_0.context.oldEntityIdDict[iter_2_1.id] = true
	end

	local var_2_1 = FightModel.instance:getAndRemoveNextWaveMsg()

	if var_2_1 then
		arg_2_0:_changeWave(var_2_1)
	else
		logNormal("还没收到FightWavePush，继续等待")
		FightController.instance:registerCallback(FightEvent.PushFightWave, arg_2_0._onPushFightWave, arg_2_0)
	end
end

function var_0_0._onPushFightWave(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, arg_3_0._onPushFightWave, arg_3_0)

	local var_3_0 = FightModel.instance:getAndRemoveNextWaveMsg()

	if var_3_0 then
		logNormal("终于等待换波次的信息了")
		arg_3_0:_changeWave(var_3_0)
		arg_3_0:onDone(true)
	else
		logError("没有换波次的信息")
		arg_3_0:onDone(true)
	end
end

function var_0_0._changeWave(arg_4_0, arg_4_1)
	FightDataHelper.calMgr:playChangeWave()

	arg_4_0._nextWaveMsg = arg_4_1

	local var_4_0 = FightModel.instance:getFightParam()
	local var_4_1 = FightModel.instance:getCurWaveId()
	local var_4_2 = var_4_1 + 1
	local var_4_3 = var_4_0:getSceneLevel(var_4_1)
	local var_4_4 = var_4_0:getSceneLevel(var_4_2)

	if var_4_4 and var_4_4 ~= var_4_3 then
		arg_4_0._nextLevelId = var_4_4

		local var_4_5 = FightModel.instance:getSpeed()

		TaskDispatcher.runDelay(arg_4_0._delayDone, arg_4_0, 5)
		TaskDispatcher.runDelay(arg_4_0._startLoadLevel, arg_4_0, 0.25 / var_4_5)
	else
		arg_4_0:_changeEntity()
		FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
		arg_4_0:onDone(true)
	end
end

function var_0_0._changeEntity(arg_5_0)
	logNormal("结束中准备下一波怪")

	local var_5_0 = arg_5_0:_cacheExpoint()
	local var_5_1 = GameSceneMgr.instance:getScene(SceneType.Fight)
	local var_5_2 = FightModel.instance.power

	var_5_1.entityMgr:changeWave(arg_5_0._nextWaveMsg.fight)

	FightModel.instance.power = var_5_2

	arg_5_0:_applyExpoint(var_5_0)
end

function var_0_0._startLoadLevel(arg_6_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_6_0._onLevelLoaded, arg_6_0)
	GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelWithSwitchEffect(arg_6_0._nextLevelId)
end

function var_0_0._delayDone(arg_7_0)
	arg_7_0:_changeEntity()
	FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
	arg_7_0:onDone(true)
end

function var_0_0._onLevelLoaded(arg_8_0)
	arg_8_0:_changeEntity()

	local var_8_0 = FightHelper.getAllEntitys()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		iter_8_1:resetStandPos()
	end

	FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
	arg_8_0:onDone(true)
end

function var_0_0.clearWork(arg_9_0)
	if arg_9_0._flow then
		arg_9_0._flow:unregisterDoneListener(arg_9_0._startChangeWave, arg_9_0)
		arg_9_0._flow:stop()

		arg_9_0._flow = nil
	end

	TaskDispatcher.cancelTask(arg_9_0._delayDone, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._startLoadLevel, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayCheckNextWaveDialog, arg_9_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_9_0._onLevelLoaded, arg_9_0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, arg_9_0._onPushFightWave, arg_9_0)
end

function var_0_0._cacheExpoint(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = FightHelper.getAllEntitys()

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		var_10_0[iter_10_1.id] = iter_10_1:getMO().exPoint
	end

	return var_10_0
end

function var_0_0._applyExpoint(arg_11_0, arg_11_1)
	local var_11_0 = FightHelper.getAllEntitys()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_1[iter_11_1.id]

		if var_11_1 then
			iter_11_1:getMO():setExPoint(var_11_1)
		end
	end
end

return var_0_0

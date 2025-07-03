module("modules.logic.fight.system.work.FightWorkStepChangeWave", package.seeall)

local var_0_0 = class("FightWorkStepChangeWave", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.nextWaveData = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0._flow = FlowSequence.New()

	arg_2_0._flow:addWork(FightWorkWaveEndDialog.New())
	arg_2_0._flow:addWork(FightWorkStepShowNoteWhenChangeWave.New())
	arg_2_0._flow:addWork(WorkWaitSeconds.New(0.01))
	arg_2_0._flow:addWork(FightWorkChangeWaveView.New())
	arg_2_0._flow:addWork(FightWorkChangeWaveStartDialog.New())
	arg_2_0._flow:registerDoneListener(arg_2_0._startChangeWave, arg_2_0)
	arg_2_0._flow:start()
end

function var_0_0._startChangeWave(arg_3_0)
	FightController.instance:dispatchEvent(FightEvent.ChangeWaveStart)
	FightPlayCardModel.instance:onEndRound()

	arg_3_0.context.oldEntityIdDict = {}

	local var_3_0 = FightHelper.getAllEntitys()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		iter_3_1:resetEntity()

		arg_3_0.context.oldEntityIdDict[iter_3_1.id] = true
	end

	local var_3_1 = arg_3_0.nextWaveData or FightDataHelper.cacheFightMgr:getNextFightData()

	if var_3_1 then
		arg_3_0:_changeWave(var_3_1)
	else
		logNormal("还没收到FightWavePush，继续等待")
		FightController.instance:registerCallback(FightEvent.PushFightWave, arg_3_0._onPushFightWave, arg_3_0)
	end
end

function var_0_0._onPushFightWave(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, arg_4_0._onPushFightWave, arg_4_0)

	local var_4_0 = arg_4_0.nextWaveData or FightDataHelper.cacheFightMgr:getNextFightData()

	if var_4_0 then
		logNormal("终于等待换波次的信息了")
		arg_4_0:_changeWave(var_4_0)
		arg_4_0:onDone(true)
	else
		logError("没有换波次的信息")
		arg_4_0:onDone(true)
	end
end

function var_0_0._changeWave(arg_5_0, arg_5_1)
	FightDataHelper.calMgr:playChangeWave()

	arg_5_0.fightData = arg_5_1

	local var_5_0 = FightModel.instance:getFightParam()
	local var_5_1 = FightModel.instance:getCurWaveId()
	local var_5_2 = var_5_1 + 1
	local var_5_3 = var_5_0:getSceneLevel(var_5_1)
	local var_5_4 = var_5_0:getSceneLevel(var_5_2)

	if var_5_4 and var_5_4 ~= var_5_3 then
		arg_5_0._nextLevelId = var_5_4

		local var_5_5 = FightModel.instance:getSpeed()

		TaskDispatcher.runDelay(arg_5_0._delayDone, arg_5_0, 5)
		TaskDispatcher.runDelay(arg_5_0._startLoadLevel, arg_5_0, 0.25 / var_5_5)
	else
		arg_5_0:_changeEntity()
		FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
		arg_5_0:onDone(true)
	end
end

function var_0_0._changeEntity(arg_6_0)
	logNormal("结束中准备下一波怪")

	local var_6_0 = arg_6_0:_cacheExpoint()
	local var_6_1 = GameSceneMgr.instance:getScene(SceneType.Fight)
	local var_6_2 = FightModel.instance.power

	var_6_1.entityMgr:changeWave(arg_6_0.fightData)

	FightModel.instance.power = var_6_2

	arg_6_0:_applyExpoint(var_6_0)
end

function var_0_0._startLoadLevel(arg_7_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_7_0._onLevelLoaded, arg_7_0)
	GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelWithSwitchEffect(arg_7_0._nextLevelId)
end

function var_0_0._delayDone(arg_8_0)
	arg_8_0:_changeEntity()
	FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
	arg_8_0:onDone(true)
end

function var_0_0._onLevelLoaded(arg_9_0)
	arg_9_0:_changeEntity()

	local var_9_0 = FightHelper.getAllEntitys()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		iter_9_1:resetStandPos()
	end

	FightController.instance:dispatchEvent(FightEvent.ChangeWaveEnd)
	arg_9_0:onDone(true)
end

function var_0_0.clearWork(arg_10_0)
	if arg_10_0._flow then
		arg_10_0._flow:unregisterDoneListener(arg_10_0._startChangeWave, arg_10_0)
		arg_10_0._flow:stop()

		arg_10_0._flow = nil
	end

	TaskDispatcher.cancelTask(arg_10_0._delayDone, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._startLoadLevel, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayCheckNextWaveDialog, arg_10_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_10_0._onLevelLoaded, arg_10_0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, arg_10_0._onPushFightWave, arg_10_0)
end

function var_0_0._cacheExpoint(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = FightHelper.getAllEntitys()

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		var_11_0[iter_11_1.id] = iter_11_1:getMO().exPoint
	end

	return var_11_0
end

function var_0_0._applyExpoint(arg_12_0, arg_12_1)
	local var_12_0 = FightHelper.getAllEntitys()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_1[iter_12_1.id]

		if var_12_1 then
			iter_12_1:getMO():setExPoint(var_12_1)
		end
	end
end

return var_0_0

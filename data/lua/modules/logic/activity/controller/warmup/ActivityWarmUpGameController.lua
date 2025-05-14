module("modules.logic.activity.controller.warmup.ActivityWarmUpGameController", package.seeall)

local var_0_0 = class("ActivityWarmUpGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openGameView(arg_3_0, arg_3_1)
	math.randomseed((tonumber(tostring(ServerTime.now()):reverse():sub(1, 7))))
	var_0_0.instance:initSettings(arg_3_1)
	ViewMgr.instance:openView(ViewName.ActivityWarmUpGameView)
end

function var_0_0.initSettings(arg_4_0, arg_4_1)
	arg_4_0:defaultSettings()
	arg_4_0:overrideSettings(arg_4_1)

	arg_4_0._isPlaying = false
	arg_4_0._startTime = -1
	arg_4_0._finishTime = -1
end

function var_0_0.defaultSettings(arg_5_0)
	logNormal("defaultSettings")

	arg_5_0.settings = {
		minBlock = 0.08,
		pointerSpeed = 0.012,
		cdTime = 1,
		randomLength = 0,
		blockCount = 4,
		victoryRound = 3,
		stayProb = 0.2,
		levelTime = 30,
		blockInterval = 0.05
	}
	arg_5_0.poolTargetIds = {
		110404,
		110501,
		110502,
		110503,
		110504,
		111001,
		111002,
		111003,
		111004
	}
end

function var_0_0.overrideSettings(arg_6_0, arg_6_1)
	local var_6_0 = Activity106Config.instance:getMiniGameSettings(arg_6_1)

	if not var_6_0 then
		logError("minigame settings config not found : " .. tostring(arg_6_1))

		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.settings) do
		if var_6_0[iter_6_0] ~= nil then
			arg_6_0.settings[iter_6_0] = var_6_0[iter_6_0]
		end
	end

	arg_6_0.settings.minBlock = tonumber(arg_6_0.settings.minBlock)
	arg_6_0.settings.randomLength = tonumber(arg_6_0.settings.randomLength)
	arg_6_0.settings.pointerSpeed = tonumber(arg_6_0.settings.pointerSpeed)

	if not string.nilorempty(var_6_0.matPool) then
		arg_6_0.poolTargetIds = string.splitToNumber(var_6_0.matPool, ",")
	end
end

function var_0_0.prepareGame(arg_7_0)
	ActivityWarmUpGameModel.instance:init(arg_7_0.settings, arg_7_0.poolTargetIds)
end

function var_0_0.startGame(arg_8_0)
	arg_8_0:clearLastResult()

	arg_8_0._isPlaying = true
	arg_8_0._moveDir = 1
	arg_8_0._startTime = ServerTime.now()
	arg_8_0._finishTime = arg_8_0._startTime + arg_8_0.settings.levelTime
	arg_8_0._cdStartTime = 0
	ActivityWarmUpGameModel.instance.round = 1
end

function var_0_0.stopGame(arg_9_0)
	arg_9_0._isPlaying = false
	arg_9_0._cdStartTime = 0
end

function var_0_0.saveGameClearResult(arg_10_0)
	arg_10_0._gameResult = true
end

function var_0_0.clearLastResult(arg_11_0)
	arg_11_0._gameResult = false
	arg_11_0._costTime = -1
end

function var_0_0.getGameCostTime(arg_12_0)
	return arg_12_0._costTime
end

function var_0_0.goNextRound(arg_13_0)
	if ActivityWarmUpGameModel.instance.round then
		ActivityWarmUpGameModel.instance.round = ActivityWarmUpGameModel.instance.round + 1

		logNormal("round = " .. tostring(ActivityWarmUpGameModel.instance.round))
	end

	ActivityWarmUpGameModel.instance:init(arg_13_0.settings, arg_13_0.poolTargetIds, true)
end

function var_0_0.gameClear(arg_14_0)
	arg_14_0:dispatchEvent(ActivityWarmUpEvent.NotifyGameClear)
end

local var_0_1 = 0

function var_0_0.onGameUpdate(arg_15_0)
	if arg_15_0._isPlaying then
		if arg_15_0:checkTimeOut() then
			return
		end

		local var_15_0 = ActivityWarmUpGameModel.instance.pointerVal
		local var_15_1 = arg_15_0.settings.pointerSpeed * (Time.deltaTime / 0.016667)
		local var_15_2 = var_15_0 + arg_15_0._moveDir * var_15_1

		if arg_15_0._moveDir > 0 then
			if var_15_2 >= 1 then
				arg_15_0._moveDir = -1
				var_15_2 = 1
			end
		elseif var_15_2 <= 0 then
			arg_15_0._moveDir = 1
			var_15_2 = 0
		end

		ActivityWarmUpGameModel.instance.pointerVal = var_15_2
		var_0_1 = var_0_1 + 1
	end
end

function var_0_0.checkTimeOut(arg_16_0)
	if ServerTime.now() >= arg_16_0._finishTime then
		arg_16_0:dispatchEvent(ActivityWarmUpEvent.GameOverTimeOut)

		return true
	end

	return false
end

function var_0_0.pointerTrigger(arg_17_0)
	local var_17_0 = ActivityWarmUpGameModel.instance.pointerVal
	local var_17_1 = ActivityWarmUpGameModel.instance:getBlockDataByPointer(var_17_0)
	local var_17_2 = true

	if var_17_1 ~= nil and ActivityWarmUpGameModel.instance:isCurrentTarget(var_17_1) then
		var_17_2 = false

		ActivityWarmUpGameModel.instance:gotoNextTarget()

		if ActivityWarmUpGameModel.instance:isAllTargetClean() then
			arg_17_0:dispatchEvent(ActivityWarmUpEvent.GameTriggerHit, var_17_1)

			if ActivityWarmUpGameModel.instance.round >= arg_17_0.settings.victoryRound then
				arg_17_0._costTime = ServerTime.now() - arg_17_0._startTime

				arg_17_0:dispatchEvent(ActivityWarmUpEvent.GameOverFinished)
			else
				arg_17_0:dispatchEvent(ActivityWarmUpEvent.GameNextRound)
			end

			return
		end
	end

	if var_17_2 then
		arg_17_0:dispatchEvent(ActivityWarmUpEvent.GameTriggerNoHit)
	else
		arg_17_0:dispatchEvent(ActivityWarmUpEvent.GameTriggerHit, var_17_1)
	end
end

function var_0_0.markCDTime(arg_18_0)
	arg_18_0._cdStartTime = ServerTime.now()
end

function var_0_0.getIsCD(arg_19_0)
	local var_19_0 = ServerTime.now()

	if not arg_19_0._cdStartTime then
		return false
	end

	return var_19_0 - arg_19_0._cdStartTime <= arg_19_0.settings.cdTime
end

function var_0_0.getIsPlaying(arg_20_0)
	return arg_20_0._isPlaying
end

function var_0_0.getRemainTime(arg_21_0)
	if arg_21_0._isPlaying then
		return arg_21_0._finishTime - ServerTime.now()
	else
		return nil
	end
end

function var_0_0.getSettingRemainTime(arg_22_0)
	return arg_22_0.settings.levelTime
end

function var_0_0.getSaveResult(arg_23_0)
	return arg_23_0._gameResult
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0

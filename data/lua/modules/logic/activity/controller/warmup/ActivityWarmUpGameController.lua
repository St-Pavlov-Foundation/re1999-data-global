module("modules.logic.activity.controller.warmup.ActivityWarmUpGameController", package.seeall)

slot0 = class("ActivityWarmUpGameController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openGameView(slot0, slot1)
	math.randomseed(tonumber(tostring(ServerTime.now()):reverse():sub(1, 7)))
	uv0.instance:initSettings(slot1)
	ViewMgr.instance:openView(ViewName.ActivityWarmUpGameView)
end

function slot0.initSettings(slot0, slot1)
	slot0:defaultSettings()
	slot0:overrideSettings(slot1)

	slot0._isPlaying = false
	slot0._startTime = -1
	slot0._finishTime = -1
end

function slot0.defaultSettings(slot0)
	logNormal("defaultSettings")

	slot0.settings = {
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
	slot0.poolTargetIds = {
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

function slot0.overrideSettings(slot0, slot1)
	if not Activity106Config.instance:getMiniGameSettings(slot1) then
		logError("minigame settings config not found : " .. tostring(slot1))

		return
	end

	for slot6, slot7 in pairs(slot0.settings) do
		if slot2[slot6] ~= nil then
			slot0.settings[slot6] = slot2[slot6]
		end
	end

	slot0.settings.minBlock = tonumber(slot0.settings.minBlock)
	slot0.settings.randomLength = tonumber(slot0.settings.randomLength)
	slot0.settings.pointerSpeed = tonumber(slot0.settings.pointerSpeed)

	if not string.nilorempty(slot2.matPool) then
		slot0.poolTargetIds = string.splitToNumber(slot2.matPool, ",")
	end
end

function slot0.prepareGame(slot0)
	ActivityWarmUpGameModel.instance:init(slot0.settings, slot0.poolTargetIds)
end

function slot0.startGame(slot0)
	slot0:clearLastResult()

	slot0._isPlaying = true
	slot0._moveDir = 1
	slot0._startTime = ServerTime.now()
	slot0._finishTime = slot0._startTime + slot0.settings.levelTime
	slot0._cdStartTime = 0
	ActivityWarmUpGameModel.instance.round = 1
end

function slot0.stopGame(slot0)
	slot0._isPlaying = false
	slot0._cdStartTime = 0
end

function slot0.saveGameClearResult(slot0)
	slot0._gameResult = true
end

function slot0.clearLastResult(slot0)
	slot0._gameResult = false
	slot0._costTime = -1
end

function slot0.getGameCostTime(slot0)
	return slot0._costTime
end

function slot0.goNextRound(slot0)
	if ActivityWarmUpGameModel.instance.round then
		ActivityWarmUpGameModel.instance.round = ActivityWarmUpGameModel.instance.round + 1

		logNormal("round = " .. tostring(ActivityWarmUpGameModel.instance.round))
	end

	ActivityWarmUpGameModel.instance:init(slot0.settings, slot0.poolTargetIds, true)
end

function slot0.gameClear(slot0)
	slot0:dispatchEvent(ActivityWarmUpEvent.NotifyGameClear)
end

slot1 = 0

function slot0.onGameUpdate(slot0)
	if slot0._isPlaying then
		if slot0:checkTimeOut() then
			return
		end

		if slot0._moveDir > 0 then
			if ActivityWarmUpGameModel.instance.pointerVal + slot0._moveDir * slot0.settings.pointerSpeed * Time.deltaTime / 0.016667 >= 1 then
				slot0._moveDir = -1
				slot3 = 1
			end
		elseif slot3 <= 0 then
			slot0._moveDir = 1
			slot3 = 0
		end

		ActivityWarmUpGameModel.instance.pointerVal = slot3
		uv0 = uv0 + 1
	end
end

function slot0.checkTimeOut(slot0)
	if slot0._finishTime <= ServerTime.now() then
		slot0:dispatchEvent(ActivityWarmUpEvent.GameOverTimeOut)

		return true
	end

	return false
end

function slot0.pointerTrigger(slot0)
	slot3 = true

	if ActivityWarmUpGameModel.instance:getBlockDataByPointer(ActivityWarmUpGameModel.instance.pointerVal) ~= nil and ActivityWarmUpGameModel.instance:isCurrentTarget(slot2) then
		slot3 = false

		ActivityWarmUpGameModel.instance:gotoNextTarget()

		if ActivityWarmUpGameModel.instance:isAllTargetClean() then
			slot0:dispatchEvent(ActivityWarmUpEvent.GameTriggerHit, slot2)

			if slot0.settings.victoryRound <= ActivityWarmUpGameModel.instance.round then
				slot0._costTime = ServerTime.now() - slot0._startTime

				slot0:dispatchEvent(ActivityWarmUpEvent.GameOverFinished)
			else
				slot0:dispatchEvent(ActivityWarmUpEvent.GameNextRound)
			end

			return
		end
	end

	if slot3 then
		slot0:dispatchEvent(ActivityWarmUpEvent.GameTriggerNoHit)
	else
		slot0:dispatchEvent(ActivityWarmUpEvent.GameTriggerHit, slot2)
	end
end

function slot0.markCDTime(slot0)
	slot0._cdStartTime = ServerTime.now()
end

function slot0.getIsCD(slot0)
	slot1 = ServerTime.now()

	if not slot0._cdStartTime then
		return false
	end

	return slot1 - slot0._cdStartTime <= slot0.settings.cdTime
end

function slot0.getIsPlaying(slot0)
	return slot0._isPlaying
end

function slot0.getRemainTime(slot0)
	if slot0._isPlaying then
		return slot0._finishTime - ServerTime.now()
	else
		return nil
	end
end

function slot0.getSettingRemainTime(slot0)
	return slot0.settings.levelTime
end

function slot0.getSaveResult(slot0)
	return slot0._gameResult
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0

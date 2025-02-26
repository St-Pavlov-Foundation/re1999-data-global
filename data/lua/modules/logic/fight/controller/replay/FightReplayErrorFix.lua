module("modules.logic.fight.controller.replay.FightReplayErrorFix", package.seeall)

slot0 = class("FightReplayErrorFix")
slot1 = 2

function slot0.ctor(slot0)
	slot0._hasStartErrorCheck = false
	slot0._lostConnect = false
	slot0._startTime = Time.time
end

function slot0.addConstEvents(slot0)
	FightController.instance:registerCallback(FightEvent.StartReplay, slot0._startReplay, slot0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._stopReplay, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, slot0._onLostConnect, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, slot0._onReconnectSucc, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnServerKickedOut, slot0._onServerKickedOut, slot0)
end

function slot0.reInit(slot0)
	slot0:_stopReplay()
end

function slot0._startReplay(slot0)
	slot0._lostConnect = false
	slot0._hasStartErrorCheck = true
	slot0._startTime = Time.time
	slot4 = 1

	TaskDispatcher.runRepeat(slot0._onSecond, slot0, slot4)

	slot0._callbackDict = {}

	for slot4, slot5 in pairs(FightEvent) do
		function slot6()
			uv0._startTime = Time.time
			slot0 = "nil"

			for slot4, slot5 in pairs(FightEvent) do
				if slot5 == uv1 then
					slot0 = slot4
				end
			end
		end

		slot0._callbackDict[slot5] = slot6

		FightController.instance:registerCallback(slot5, slot6, nil)
	end

	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, slot0._onApplicationPause, slot0)
end

function slot0._onApplicationPause(slot0)
	slot0._startTime = Time.time
end

function slot0._onLostConnect(slot0)
	slot0._lostConnect = true
end

function slot0._onReconnectSucc(slot0)
	slot0._startTime = Time.time
	slot0._lostConnect = false
end

function slot0._onServerKickedOut(slot0)
	slot0:_stopReplay()
end

function slot0._stopReplay(slot0)
	if slot0._hasStartErrorCheck then
		slot0._hasStartErrorCheck = false

		TaskDispatcher.cancelTask(slot0._onSecond, slot0)
		slot0:_clearEvtCbs()
	end

	slot0._hasLog = nil
end

function slot0._clearEvtCbs(slot0)
	if slot0._callbackDict then
		for slot4, slot5 in pairs(slot0._callbackDict) do
			FightController.instance:unregisterCallback(slot4, slot5, nil)
		end

		slot0._callbackDict = nil
	end

	GameStateMgr.instance:unregisterCallback(GameStateEvent.onApplicationPause, slot0._onApplicationPause, slot0)
end

function slot0._onSecond(slot0)
	if slot0._lostConnect then
		return
	end

	if #ConnectAliveMgr.instance:getUnresponsiveMsgList() > 0 then
		return
	end

	if uv0 < Time.time - slot0._startTime then
		slot0:_fixErrorState()
	end
end

function slot0._fixErrorState(slot0)
	slot2 = FightSystem.instance:getRoundSequence()
	slot3 = FightSystem.instance:getClothSkillSequence()
	slot4 = FightSystem.instance:getEndSequence()
	slot5 = FightModel.instance:getCurStage()

	if FightSystem.instance:getStartSequence():isRunning() then
		slot0:_log("行为复现出错，起始回合卡住")
		slot1:doneRunningWork()
	elseif slot2:isRunning() then
		slot0:_log("行为复现出错，回合卡住")
		slot2:doneRunningWork()
	elseif slot3:isRunning() then
		slot0:_log("行为复现出错，主角技能卡住")
		slot3:doneRunningWork()
	elseif slot4:isRunning() then
		slot0:_log("行为复现出错，结算卡住")
		slot4:doneRunningWork()
	elseif slot5 == FightEnum.Stage.Card or slot5 == FightEnum.Stage.AutoCard then
		slot0:_log("行为复现出错，出牌阶段卡住")
		FightCardModel.instance:setDissolving(false)
		FightCardModel.instance:setChanging(false)
		FightReplayController.instance:doneCardStage()
		FightRpc.instance:sendBeginRoundRequest({})
	end
end

function slot0._log(slot0, slot1)
	if not slot0._hasLog then
		slot0._hasLog = true
		slot4 = slot2 and slot2.battleId

		if FightModel.instance:getFightParam() and slot2.episodeId then
			logError(slot1 .. " episode_" .. slot3)
		else
			logError(slot1 .. " battle_" .. (slot4 or "nil"))
		end
	end
end

return slot0

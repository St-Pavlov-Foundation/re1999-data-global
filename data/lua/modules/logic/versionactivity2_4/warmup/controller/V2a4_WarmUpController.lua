module("modules.logic.versionactivity2_4.warmup.controller.V2a4_WarmUpController", package.seeall)

slot0 = class("V2a4_WarmUpController", BaseController)
slot1 = table.insert

function slot0.onInit(slot0)
	slot0._battle = V2a4_WarmUpBattleModel.instance
	slot0._gacha = V2a4_WarmUpGachaModel.instance

	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._gacha:clean()
end

function slot0.config(slot0)
	return V2a4_WarmUpConfig.instance
end

function slot0.actId(slot0)
	return slot0:config():actId()
end

function slot0.addConstEvents(slot0)
end

function slot0.isTimeout(slot0)
	return slot0._battle:isTimeout()
end

function slot0.restart(slot0, slot1)
	slot0._gacha:restart(slot1)
	slot0._battle:restart(slot1)
	slot0:waveStart(slot1)
end

function slot0.abort(slot0)
	slot1 = slot0._battle:getResultInfo()

	ViewMgr.instance:openView(ViewName.V2a4_WarmUp_ResultView, {
		isSucc = slot2,
		desc = GameUtil.getSubPlaceholderLuaLang(V2a4_WarmUpConfig.instance:getConstStr(slot1.isWin and 4 or 3), {
			V2a4_WarmUpConfig.instance:getDurationSec(),
			slot1.totWaveCnt,
			slot1.totAnsYesCnt,
			slot1.totAnsNoCnt,
			slot1.sucHelpCnt
		}),
		closeCb = slot0._onCloseV2a4_WarmUp_ResultView,
		closeCbObj = slot0
	})

	if slot2 then
		slot0:_sendFinishAct125EpisodeRequest()
	end
end

function slot0._onCloseV2a4_WarmUp_ResultView(slot0)
	if ViewMgr.instance:isOpen(ViewName.V2a4_WarmUp_DialogueView) then
		ViewMgr.instance:closeView(slot1, nil, true)
	end
end

function slot0.waveStart(slot0, slot1)
	slot0:dispatchEvent(V2a4_WarmUpEvent.onWaveStart, slot0:genWave(slot1))
end

function slot0.postWaveStart(slot0, slot1)
	if slot1:nextRound() then
		slot0:roundStart(slot1, slot1:curRound())
	else
		slot0:waveEnd(slot1)
	end
end

function slot0.roundStart(slot0, slot1, slot2)
	slot0:dispatchEvent(V2a4_WarmUpEvent.onRoundStart, slot1, slot2)
end

function slot0.postRoundStart(slot0, slot1, slot2)
	if slot0:isTimeout() then
		slot0:roundEnd(slot1, slot2)

		return
	end

	slot0:moveStep(slot1, slot2)
end

function slot0.moveStep(slot0, slot1, slot2)
	slot3, slot4 = slot2:moveStep()

	if slot3 and not slot0:isTimeout() then
		slot0:dispatchEvent(V2a4_WarmUpEvent.onMoveStep, slot1, slot2, slot4)
	else
		slot0:roundEnd(slot1, slot2)
	end
end

function slot0.stepEnd(slot0, slot1, slot2)
	slot0:moveStep(slot1, slot2)
end

function slot0.roundEnd(slot0, slot1, slot2)
	if slot0:isTimeout() then
		slot0:abort()

		return
	end

	if slot2:isWin() and slot1:nextRound() then
		slot0:roundStart(slot1, slot1:curRound())

		return
	end

	slot0:waveEnd(slot1)
end

function slot0.waveEnd(slot0, slot1)
	slot0:dispatchEvent(V2a4_WarmUpEvent.onWaveEnd, slot1)
end

function slot0.genWave(slot0, slot1)
	return slot0._battle:genWave(slot0._gacha:genWave(slot1))
end

function slot0.timeout(slot0)
	slot0:abort()
end

function slot0.commitAnswer(slot0, slot1)
	if slot0:isTimeout() then
		return
	end

	if not slot0._battle:curWave():curRound() then
		return
	end

	slot3:answer(slot1)
	slot0:moveStep(slot2, slot3)
end

function slot0.log(slot0)
	slot1 = {}

	slot0._battle:dump(slot1)
	logError(table.concat(slot1, "\n"))
end

function slot0.uploadToServer(slot0)
	slot1 = Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)
	slot2 = slot0._battle:getResultInfo()
	slot4 = slot2.isPerfectWin and 1 or 0

	if slot2.sucHelpCnt > 0 then
		Activity125Controller.instance:set_V2a4_WarmUp_sum_help_npc(slot1 + slot3)
	end

	slot5 = {}
	slot6 = ActivityWarmUpEnum.Activity125TaskTag

	slot0:_checkSingleClientlistenerParam(slot5, slot6.sum_help_npc, slot1)
	slot0:_checkSingleClientlistenerParam(slot5, slot6.perfect_win, slot4)
	slot0:_checkSingleClientlistenerParam(slot5, slot6.help_npc, slot3)
	slot0:sendFinishReadTaskRequest(slot5)
end

function slot0._checkSingleClientlistenerParam(slot0, slot1, slot2, slot3)
	for slot9, slot10 in pairs(Activity125Config.instance:getTaskCO_ReadTask_Tag(slot0:actId(), slot2) or {}) do
		slot0:appendCompleteTask(slot1, TaskEnum.TaskType.Activity125, slot9, slot3, tonumber(slot10.clientlistenerParam) or slot3 + 1)
	end
end

function slot0.appendCompleteTask(slot0, slot1, slot2, slot3, slot4, slot5)
	if not TaskModel.instance:isTaskUnlock(slot2, slot3) then
		return
	end

	if TaskModel.instance:taskHasFinished(slot2, slot3) then
		return
	end

	if slot4 < slot5 then
		return
	end

	uv0(slot1, slot3)
end

function slot0._sendFinishAct125EpisodeRequest(slot0)
	if Activity125Model.instance:isEpisodeFinished(slot0:actId(), slot0._battle:levelId()) then
		return
	end

	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(slot0:actId(), slot1, Activity125Config.instance:getEpisodeConfig(slot0:actId(), slot1).targetFrequency)
end

function slot0.sendFinishReadTaskRequest(slot0, slot1)
	if not slot1 or #slot1 == 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		TaskRpc.instance:sendFinishReadTaskRequest(slot6)
	end

	slot0:dispatchEventUpdateActTag()
end

slot2 = "V2a4_WarmUpController|"

function slot0.getPrefsKeyPrefix(slot0)
	return uv0 .. tostring(slot0:actId())
end

function slot0.saveInt(slot0, slot1, slot2)
	GameUtil.playerPrefsSetNumberByUserId(slot1, slot2)
end

function slot0.getInt(slot0, slot1, slot2)
	return GameUtil.playerPrefsGetNumberByUserId(slot1, slot2)
end

slot3 = "Preface"

function slot0.setIsShownPreface(slot0, slot1)
	slot0:saveInt(slot0:getPrefsKeyPrefix() .. uv0, slot1 and 1 or 0)
end

function slot0.getIsShownPreface(slot0)
	return slot0:getInt(slot0:getPrefsKeyPrefix() .. uv0, 0) ~= 0
end

function slot0.dispatchEventUpdateActTag(slot0)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(RedDotConfig.instance:getParentRedDotId(ActivityConfig.instance:getActivityCenterRedDotId(ActivityEnum.ActivityType.Beginner)))] = true,
		[tonumber(ActivityConfig.instance:getActivityRedDotId(slot0:actId()))] = true,
		[RedDotEnum.DotNode.Activity125Task] = true
	})
end

slot0.instance = slot0.New()

return slot0

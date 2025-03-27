module("modules.logic.fight.system.FightSystem", package.seeall)

slot0 = class("FightSystem")

function slot0.ctor(slot0)
	slot0._reconnectSequence = FightReconnectSequence.New()
	slot0._startSequence = FightStartSequence.New()
	slot0._roundSequence = FightRoundSequence.New()
	slot0._clothSkillSequence = FightClothSkillSequence.New()
	slot0._endSequence = FightEndSequence.New()
	slot0._restartSequence = FightRestartSequence.New()
	slot0._fastRestartSequence = FightFastRestartSequence.New()
end

function slot0.reconnectFight(slot0)
	FightController.instance:setCurStage(FightEnum.Stage.StartRound)
	FightController.instance:dispatchEvent(FightEvent.OnFightReconnect)

	if FightModel.instance:isFinish() then
		FightRpc.instance:sendEndFightRequest(false)
	else
		slot0._reconnectSequence:buildFlow(FightModel.instance:getCurRoundMO())
		slot0._reconnectSequence:start(slot0._onStartFinish, slot0)
	end
end

function slot0.startFight(slot0)
	FightController.instance:setCurStage(FightEnum.Stage.StartRound)
	FightController.instance:dispatchEvent(FightEvent.OnStartSequenceStart)
	slot0._startSequence:buildFlow(FightModel.instance:getCurRoundMO())
	slot0._startSequence:start(slot0._onStartFinish, slot0)
end

function slot0.restartFight(slot0)
	uv0.instance.restarting = true

	slot0._restartSequence:buildFlow()
	slot0._restartSequence:start(slot0._onRestartFightFinish, slot0)
end

function slot0.cancelRestart(slot0)
	slot0._restartSequence:stop()
	slot0._restartSequence:dispose()

	uv0.instance.restarting = false
end

function slot0._onRestartFightFinish(slot0)
	uv0.instance.restarting = false
end

function slot0.restartFightFail(slot0)
	ToastController.instance:showToast(-80)
	slot0:cancelRestart()
	FightController.instance:exitFightScene()
end

function slot0.startRound(slot0)
	FightController.instance:setCurStage(FightEnum.Stage.Play)
	FightController.instance:dispatchEvent(FightEvent.OnRoundSequenceStart)

	slot1 = FightModel.instance:getCurRoundMO()

	slot1:onBeginRound()
	slot0._roundSequence:buildFlow(slot1)
	FightMgr.instance:enterStage(FightStageMgr.StageType.Play, FightStageMgr.PlayType.Normal)
	slot0._roundSequence:start(slot0._onRoundFinish, slot0)
end

function slot0.startClothSkillRound(slot0)
	slot0._beforeClothSkillStage = FightModel.instance:getCurStage()

	FightController.instance:setCurStage(FightEnum.Stage.ClothSkill)
	slot0._clothSkillSequence:buildFlow(FightModel.instance:getCurRoundMO())
	FightMgr.instance:enterStage(FightStageMgr.StageType.Play, FightStageMgr.PlayType.ClothSkill)
	slot0._clothSkillSequence:start(slot0._onClothSkillRoundFinish, slot0)
end

function slot0.endFight(slot0)
	FightController.instance:setCurStage(FightEnum.Stage.EndRound)
	slot0._startSequence:stop()
	slot0._roundSequence:stop()
	slot0._clothSkillSequence:stop()

	if uv0.instance.restarting then
		return
	end

	if FightRestartHelper.tryRestart() then
		return
	end

	slot0._endSequence:buildFlow()
	slot0._endSequence:start(slot0._onEndFinish, slot0)
end

function slot0._onRestart(slot0)
	uv0.instance.restarting = true

	slot0._fastRestartSequence:buildFlow()
	slot0._fastRestartSequence:start(slot0._onRestartFightFinish, slot0)
end

function slot0._onEndFight(slot0)
	slot0._endSequence:buildFlow()
	slot0._endSequence:start(slot0._onEndFinish, slot0)
end

function slot0._onStartFinish(slot0)
	FightMgr.instance:exitStage(FightStageMgr.StageType.Play)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Enter)

	if FightModel.instance:isAuto() then
		FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
	else
		FightController.instance:setCurStage(FightEnum.Stage.Card)
	end

	FightViewPartVisible.set(true, true, true, false, false)
	FightController.instance:dispatchEvent(FightEvent.OnStartSequenceFinish)
end

function slot0.getReconnectSequence(slot0)
	return slot0._reconnectSequence
end

function slot0.getStartSequence(slot0)
	return slot0._startSequence
end

function slot0.getRoundSequence(slot0)
	return slot0._roundSequence
end

function slot0.getClothSkillSequence(slot0)
	return slot0._clothSkillSequence
end

function slot0.getEndSequence(slot0)
	return slot0._endSequence
end

function slot0.getRestartSequence(slot0)
	return slot0._restartSequence
end

function slot0._onRoundFinish(slot0)
	FightMgr.instance:exitStage(FightStageMgr.StageType.Play)
	FightModel.instance:onEndRound()

	if not FightModel.instance:isFinish() then
		if FightModel.instance:isAuto() then
			FightController.instance:setCurStage(FightEnum.Stage.AutoCard)
		else
			FightController.instance:setCurStage(FightEnum.Stage.Card)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnRoundSequenceFinish)
end

function slot0._onClothSkillRoundFinish(slot0)
	FightMgr.instance:exitStage(FightStageMgr.StageType.Play)
	FightController.instance:setCurStage(slot0._beforeClothSkillStage)

	if FightModel.instance:getCurStage() == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard then
		FightViewPartVisible.set(true, true, true, false, false)
	end

	FightController.instance:dispatchEvent(FightEvent.OnClothSkillRoundSequenceFinish)
end

function slot0._onEndFinish(slot0)
	FightController.instance:setCurStage(FightEnum.Stage.End)
	FightController.instance:dispatchEvent(FightEvent.OnEndSequenceFinish)
end

function slot0.dispose(slot0)
	slot0._reconnectSequence:stop()
	slot0._startSequence:stop()
	slot0._roundSequence:stop()
	slot0._clothSkillSequence:stop()
	slot0._endSequence:stop()
	slot0._reconnectSequence:dispose()
	slot0._startSequence:dispose()
	slot0._roundSequence:dispose()
	slot0._clothSkillSequence:dispose()
	slot0._endSequence:dispose()
	FightPlayCardModel.instance:onEndRound()
	FightModel.instance:clear()
	FightModel.instance:setCurStage(nil)
	FightCardModel.instance:clear()
end

function slot0.dumpStates(slot0)
	slot0:_dumpSequence(slot0._reconnectSequence, "reconnectSequence")
	slot0:_dumpSequence(slot0._startSequence, "startSequence")
	slot0:_dumpSequence(slot0._roundSequence, "roundSequence")
	slot0:_dumpSequence(slot0._clothSkillSequence, "clothSkillSequence")
	slot0:_dumpSequence(slot0._endSequence, "endSequence")
end

function slot0._dumpSequence(slot0, slot1, slot2)
	if slot1._sequence and slot1._sequence.status == WorkStatus.Running then
		slot3 = {
			slot2
		}

		if slot1._sequence then
			slot0:_getWorks(slot4, slot3, 0)
		end

		logError(table.concat(slot3, "\n"))
	end
end

function slot0._getWorks(slot0, slot1, slot2, slot3)
	for slot8 = 1, slot3 do
		slot4 = "" .. "  "
	end

	if slot1.status == WorkStatus.Running then
		slot4 = slot4 .. slot1.__cname .. "(running)"
	end

	table.insert(slot2, slot4)

	if isTypeOf(slot1, FlowSequence) then
		for slot9, slot10 in ipairs(slot1._workList) do
			slot0:_getWorks(slot10, slot2, slot3 + 1)
		end
	elseif isTypeOf(slot1, FlowParallel) then
		for slot9, slot10 in ipairs(slot1._workList) do
			slot0:_getWorks(slot10, slot2, slot3 + 1)
		end
	elseif isTypeOf(slot1, FightSkillFlow) and slot1._sequence then
		slot0:_getWorks(slot1._sequence, slot2, slot3 + 1)
	end
end

slot0.instance = slot0.New()

return slot0

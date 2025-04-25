module("modules.logic.fight.view.FightViewExPoint", package.seeall)

slot0 = class("FightViewExPoint", BaseView)

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMoveHandCard, slot0._onMoveHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCombineOneCard, slot0._onCombineOneCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, slot0._onPlayHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRevertCard, slot0._onRevertCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CancelOperation, slot0._onCancelOperation, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnResetCard, slot0._onResetCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginRound, slot0._respBeginRound, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnMoveHandCard, slot0._onMoveHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCombineOneCard, slot0._onCombineOneCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, slot0._onPlayHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRevertCard, slot0._onRevertCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.CancelOperation, slot0._onCancelOperation, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnResetCard, slot0._onResetCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RespBeginRound, slot0._respBeginRound, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0._onStartSequenceFinish(slot0)
	FightCardModel.instance:applyNextRoundActPoint()
end

function slot0._onRoundSequenceFinish(slot0)
	FightCardModel.instance:applyNextRoundActPoint()
end

function slot0._onMoveHandCard(slot0, slot1, slot2, slot3)
	if slot2 == slot3 then
		return
	end

	if not slot1.moveCanAddExpoint then
		return
	end

	if FightCardModel.instance:getCardMO().extraMoveAct > 0 then
		if slot4 < #FightCardModel.instance:getMoveCardOpCostActList() then
			slot0:_onMoveOrCombine(slot1.uid, true)
		end
	else
		slot0:_onMoveOrCombine(slot1.uid, true)
	end
end

function slot0._onCombineOneCard(slot0, slot1, slot2)
	if not slot1.combineCanAddExpoint then
		return
	end

	if not slot2 then
		slot0:_onMoveOrCombine(slot1.uid, false)
	end
end

function slot0._onMoveOrCombine(slot0, slot1, slot2)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot1) then
		return
	end

	if slot3:getMoveCardAddExPoint() < 1 then
		return
	end

	if FightBuffHelper.getTransferExPointUid(slot3) then
		if FightDataHelper.entityMgr:getById(slot5) then
			slot6:onMoveCardExPoint(slot2)
			FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, slot5)
		else
			slot3:onMoveCardExPoint(slot2)
			FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, slot1)
		end
	else
		slot3:onMoveCardExPoint(slot2)
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, slot1)
	end
end

function slot0._onPlayHandCard(slot0, slot1)
	if not slot1.playCanAddExpoint then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot1.uid) then
		return
	end

	if slot2:getPlayCardAddExPoint() < 1 then
		return
	end

	if FightBuffHelper.getTransferExPointUid(slot2) then
		if FightDataHelper.entityMgr:getById(slot4) then
			slot5:onPlayCardExPoint(slot1.skillId)
			FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, slot4)
		else
			slot2:onPlayCardExPoint(slot1.skillId)
			FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, slot1.uid)
		end
	else
		slot2:onPlayCardExPoint(slot1.skillId)
		FightController.instance:dispatchEvent(FightEvent.AddPlayCardClientExPoint, slot1.uid)
	end
end

function slot0._onRevertCard(slot0, slot1)
end

function slot0._onCancelOperation(slot0)
	slot0.last_move_point = {}

	for slot5, slot6 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)) do
		if slot6:getMO() then
			slot0.last_move_point[slot7.uid] = slot7.moveCardExPoint
		end
	end
end

function slot0._onResetCard(slot0)
	for slot5, slot6 in pairs(FightDataHelper.entityMgr:getAllEntityData()) do
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, slot6.id)
	end
end

function slot0._respBeginRound(slot0)
	for slot5, slot6 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		slot6:applyMoveCardExPoint()
	end

	for slot5, slot6 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)) do
		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, slot6.id)
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
end

function slot0._onStageChange(slot0, slot1)
	if slot1 ~= FightEnum.Stage.Card and slot1 == FightEnum.Stage.AutoCard then
		-- Nothing
	end
end

return slot0

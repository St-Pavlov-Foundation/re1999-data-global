module("modules.logic.fight.entity.comp.FightPlayerReadyAttackComp", package.seeall)

slot0 = class("FightPlayerReadyAttackComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, slot0._onPlayHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRevertCard, slot0._onRevertCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnResetCard, slot0._onResetCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, slot0._beforePlaySkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, slot0._onPlayHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRevertCard, slot0._onRevertCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnResetCard, slot0._onResetCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforePlaySkill, slot0._beforePlaySkill, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0.onDestroy(slot0)
	slot0:_clearReadyAttackWork()
end

function slot0._onPlayHandCard(slot0, slot1)
	if slot1.uid ~= slot0.entity.id then
		return
	end

	if #FightCardModel.instance:getEntityOps(slot1.uid, FightEnum.CardOpType.PlayCard) > 0 and not slot0._readyAttackWork then
		slot4 = FightDataHelper.entityMgr:getById(slot1.uid) and FightCardModel.instance:getCardOps()

		if FightViewHandCardItemLock.canUseCardSkill(slot1.uid, slot1.skillId, slot4 and FightBuffHelper.simulateBuffList(slot3, slot4[#slot4])) then
			slot0._readyAttackWork = FightReadyAttackWork.New()

			slot0._readyAttackWork:onStart(slot0.entity)
		end
	end
end

function slot0._onRevertCard(slot0, slot1)
	if slot1.belongToEntityId ~= slot0.entity.id then
		return
	end

	if slot1:isPlayCard() and (not FightCardModel.instance:getEntityOps(slot0.entity.id) or #slot2 == 0) and slot0._readyAttackWork then
		slot0.entity:resetAnimState()
		slot0:_clearReadyAttackWork()
	end
end

function slot0._onResetCard(slot0)
	if slot0._readyAttackWork then
		slot0.entity:resetAnimState()
		slot0:_clearReadyAttackWork()
	end
end

function slot0._beforePlaySkill(slot0, slot1, slot2, slot3)
	if slot0.entity == slot1 then
		slot0:_clearReadyAttackWork()
	end
end

function slot0._onStageChange(slot0)
	slot0:_clearReadyAttackWork()
end

function slot0._clearReadyAttackWork(slot0)
	if slot0._readyAttackWork then
		slot0._readyAttackWork:onStop()

		slot0._readyAttackWork = nil
	end
end

return slot0

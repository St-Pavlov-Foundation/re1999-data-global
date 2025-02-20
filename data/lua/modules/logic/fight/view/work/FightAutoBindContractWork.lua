module("modules.logic.fight.view.work.FightAutoBindContractWork", package.seeall)

slot0 = class("FightAutoBindContractWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)

	if string.nilorempty(FightModel.instance.notifyEntityId) then
		return slot0:onDone(true)
	end

	if not FightHelper.getEntity(slot1) then
		return slot0:onDone(true)
	end

	if not FightModel.instance.canContractList or #slot3 < 1 then
		return slot0:onDone(true)
	end

	return slot0:autoContract(slot3, slot1)
end

function slot0.autoContract(slot0, slot1, slot2)
	slot3 = nil

	for slot8, slot9 in ipairs(slot1) do
		if slot9 ~= slot2 then
			slot11 = FightDataHelper.entityMgr:getById(slot9) and slot10.attrMO

			if slot11 and slot11.attack and 0 < slot12 then
				slot3 = slot9
				slot4 = slot12
			end
		end
	end

	if not slot3 then
		return slot0:onDone(true)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, slot0._onRespUseClothSkillFail, slot0)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	FightRpc.instance:sendUseClothSkillRequest(0, slot2, slot3, FightEnum.ClothSkillType.Contract)
end

function slot0._delayDone(slot0)
	slot0:onDone(false)
end

function slot0._onRespUseClothSkillFail(slot0)
	slot0:onDone(false)
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, slot0._onRespUseClothSkillFail, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
end

return slot0

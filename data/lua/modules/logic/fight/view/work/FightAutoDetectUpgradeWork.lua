module("modules.logic.fight.view.work.FightAutoDetectUpgradeWork", package.seeall)

slot0 = class("FightAutoDetectUpgradeWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	if #FightPlayerOperateMgr.detectUpgrade() > 0 then
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 20)
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, slot0._onRespUseClothSkillFail, slot0)

		slot6 = slot0._onClothSkillRoundSequenceFinish

		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot6, slot0)

		slot0._count = #slot2

		for slot6 = #slot2, 1, -1 do
			slot7 = slot2[slot6]

			FightRpc.instance:sendUseClothSkillRequest(slot7.id, slot7.entityId, slot7.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
			table.remove(slot2, slot6)
		end

		return
	end

	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._onRespUseClothSkillFail(slot0)
	slot0:_onClothSkillRoundSequenceFinish()
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	slot0._count = slot0._count - 1

	if slot0._count == 0 then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, slot0._onRespUseClothSkillFail, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
end

return slot0

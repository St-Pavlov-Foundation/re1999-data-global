module("modules.logic.fight.system.work.FightWorkZXQRemoveCard", package.seeall)

slot0 = class("FightWorkZXQRemoveCard", FightEffectBase)

function slot0.onStart(slot0)
	if slot0._actEffectMO.teamType ~= FightEnum.TeamType.MySide then
		slot0:onDone(true)

		return
	end

	if FightCardModel.instance:getHandCards()[slot0._actEffectMO.effectNum] then
		table.remove(slot1, slot2)
		FightCardModel.instance:coverCard(slot1)
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0

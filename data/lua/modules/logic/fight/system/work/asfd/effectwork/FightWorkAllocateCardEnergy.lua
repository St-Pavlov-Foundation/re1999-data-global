module("modules.logic.fight.system.work.asfd.effectwork.FightWorkAllocateCardEnergy", package.seeall)

slot0 = class("FightWorkAllocateCardEnergy", FightEffectBase)

function slot0.onConstructor(slot0)
	slot0.SAFETIME = 3
end

slot0.AllocateEnum = {
	Clear = 0,
	Allocate = 1
}

function slot0.onStart(slot0)
	if slot0._actEffectMO.effectNum1 ~= uv0.AllocateEnum.Allocate then
		slot0:onDone(true)

		return
	end

	slot3 = slot0._actEffectMO.cardInfoList

	for slot7, slot8 in ipairs(FightCardModel.instance:getHandCardData()) do
		if slot3 and slot3[slot7] then
			slot8:init(slot9)
		end
	end

	FightController.instance:registerCallback(FightEvent.ASFD_AllocateCardEnergyDone, slot0.allocateCardEnergyDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_StartAllocateCardEnergy)
end

function slot0.allocateCardEnergyDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_AllocateCardEnergyDone, slot0.allocateCardEnergyDone, slot0)
end

return slot0

module("modules.logic.summon.controller.SummonLuckyBagController", package.seeall)

slot0 = class("SummonLuckyBagController", BaseController)

function slot0.skipOpenGetChar(slot0, slot1, slot2, slot3)
	if not slot3 then
		return
	end

	slot4 = SummonConfig.instance:getSummonPool(slot3)

	if SummonController.instance:getMvSkinIdByHeroId(slot1) then
		-- Nothing
	end

	if slot4 and slot4.ticketId ~= 0 then
		slot5.summonTicketId = slot4.ticketId
	end

	CharacterController.instance:openCharacterGetView({
		heroId = slot1,
		duplicateCount = slot2,
		isSummon = true,
		skipVideo = true,
		mvSkinId = slot6
	})
end

function slot0.skipOpenGetLuckyBag(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	if SummonConfig.instance:getSummonPool(slot2) and slot4.ticketId ~= 0 then
		-- Nothing
	end

	ViewMgr.instance:openView(ViewName.SummonGetLuckyBag, {
		luckyBagId = slot1,
		poolId = slot2,
		summonTicketId = slot4.ticketId
	})
end

slot0.instance = slot0.New()

return slot0

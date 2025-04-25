module("modules.logic.versionactivity2_5.act186.model.Activity186MileStoneListModel", package.seeall)

slot0 = class("Activity186MileStoneListModel", MixScrollModel)

function slot0.init(slot0, slot1)
	slot0.actMo = slot1
end

function slot0.refresh(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(Activity186Config.instance:getMileStoneList(slot0.actMo.id)) do
		table.insert(slot2, {
			id = slot7.rewardId,
			rewardId = slot7.rewardId,
			activityId = slot7.activityId,
			isLoopBonus = slot7.isLoopBonus,
			bonus = slot7.bonus,
			isSpBonus = slot7.isSpBonus
		})
	end

	slot0:setList(slot2)
end

function slot0.caleProgressIndex(slot0)
	slot2 = 0
	slot4 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId))
	slot5 = 0

	for slot9, slot10 in ipairs(Activity186Config.instance:getMileStoneList(slot0.actMo.id)) do
		if slot4 < slot10.coinNum then
			return slot9 + (slot4 - slot5) / (slot11 - slot5) - 1
		end

		slot5 = slot11
	end

	slot5 = slot1[#slot1 - 1] and slot1[slot6 - 1].coinNum or 0
	slot8 = slot0.actMo.getMilestoneProgress
	slot9 = slot1[slot6].loopBonusIntervalNum or 1

	return slot8 < slot7.coinNum and slot6 or math.floor((slot8 - slot10) / slot9) < math.floor((slot4 - slot10) / slot9) and slot6 or slot6 - 1 + slot11 - slot12
end

slot0.instance = slot0.New()

return slot0

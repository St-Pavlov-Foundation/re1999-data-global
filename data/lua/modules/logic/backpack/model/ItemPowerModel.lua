module("modules.logic.backpack.model.ItemPowerModel", package.seeall)

slot0 = class("ItemPowerModel", BaseModel)

function slot0.onInit(slot0)
	slot0._powerItemList = {}
	slot0._latestPushItemUids = {}
end

function slot0.reInit(slot0)
	slot0._powerItemList = {}
	slot0._latestPushItemUids = {}
end

function slot0.getPowerItem(slot0, slot1)
	return slot0._powerItemList[tonumber(slot1)]
end

function slot0.getPowerItemList(slot0)
	return slot0._powerItemList
end

function slot0.setPowerItemList(slot0, slot1)
	slot0._powerItemList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = ItemPowerMo.New()

		slot7:init(slot6)

		slot0._powerItemList[tonumber(slot6.uid)] = slot7
	end

	CurrencyController.instance:checkToUseExpirePowerItem()
end

function slot0.changePowerItemList(slot0, slot1)
	if not slot1 or #slot1 < 1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = tonumber(slot6.uid)

		table.insert(slot0._latestPushItemUids, {
			itemid = slot6.itemId,
			uid = slot7
		})

		if not slot0._powerItemList[slot7] then
			slot9 = ItemPowerMo.New()

			slot9:init(slot6)

			slot0._powerItemList[slot7] = slot9
		else
			slot0._powerItemList[slot7]:reset(slot6)
		end
	end
end

function slot0.getLatestPowerChange(slot0)
	return slot0._latestPushItemUids
end

function slot0.getPowerItemCount(slot0, slot1)
	return slot0._powerItemList[slot1] and slot0._powerItemList[slot1].quantity or 0
end

function slot0.getPowerItemCountById(slot0, slot1)
	for slot6, slot7 in pairs(slot0._powerItemList) do
		if slot7.id == slot1 then
			slot2 = 0 + slot7.quantity
		end
	end

	return slot2
end

function slot0.getPowerItemDeadline(slot0, slot1)
	return slot0._powerItemList[slot1] and tonumber(slot0._powerItemList[slot1].expireTime) or 0
end

function slot0.getPowerItemCo(slot0, slot1)
	return slot0._powerItemList[slot1] and ItemConfig.instance:getPowerItemCo(slot0._powerItemList[slot1].id) or nil
end

function slot0.getPowerCount(slot0, slot1)
	for slot6, slot7 in pairs(slot0._powerItemList) do
		if slot7.id == slot1 and (slot7.expireTime == 0 or ServerTime.now() < slot7.expireTime) then
			slot2 = 0 + slot7.quantity
		end
	end

	return slot2
end

function slot0.getPowerMinExpireTimeOffset(slot0, slot1)
	slot3 = false

	for slot8, slot9 in pairs(slot0._powerItemList) do
		if slot9.id == slot1 and slot9.expireTime ~= 0 and slot9.quantity > 0 and slot9.expireTime - ServerTime.now() > 0 then
			if slot3 then
				if slot10 < nil then
					slot2 = slot10
				end
			else
				slot2 = slot10
			end

			slot3 = true
		end
	end

	return slot3 and slot2 or 0
end

function slot0.getPowerByType(slot0, slot1)
	if slot1 == MaterialEnum.PowerType.Small then
		if not slot0:getExpirePower(MaterialEnum.PowerId.SmallPower_Expire) or slot2.quantity == 0 then
			slot2 = slot0:getNoExpirePower(MaterialEnum.PowerId.SmallPower)
		end

		return slot2
	elseif slot1 == MaterialEnum.PowerType.Big then
		if not slot0:getExpirePower(MaterialEnum.PowerId.BigPower_Expire) or slot2.quantity == 0 then
			slot2 = slot0:getNoExpirePower(MaterialEnum.PowerId.BigPower)
		end

		return slot2
	else
		return slot0:getExpirePower(MaterialEnum.PowerId.ActPowerId)
	end
end

function slot0.getNoExpirePower(slot0, slot1)
	for slot5, slot6 in pairs(slot0._powerItemList) do
		if slot6.id == slot1 and slot6.expireTime == 0 then
			return slot6
		end
	end

	return nil
end

function slot0.getExpirePower(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in pairs(slot0._powerItemList) do
		if slot8.id == slot1 and slot8.quantity > 0 and slot8.expireTime ~= 0 and ServerTime.now() < slot8.expireTime then
			if slot2 then
				if slot8.expireTime < slot2.expireTime then
					slot2 = slot8
				end
			else
				slot2 = slot8
			end
		end
	end

	return slot2
end

function slot0.getUsePower(slot0, slot1, slot2)
	slot3 = ServerTime.now()

	for slot9, slot10 in pairs(slot0._powerItemList) do
		if slot10.id == slot1 and slot10.quantity > 0 then
			if slot10.expireTime == 0 then
				table.insert({}, slot10)

				slot5 = 0 + slot10.quantity
			elseif slot3 < slot10.expireTime then
				table.insert(slot4, slot10)

				slot5 = slot5 + slot10.quantity
			end
		end
	end

	slot6 = {}

	if slot5 <= slot2 then
		for slot10, slot11 in pairs(slot4) do
			table.insert(slot6, {
				uid = slot11.uid,
				num = slot11.quantity
			})
		end

		return slot6
	end

	slot5 = 0

	table.sort(slot4, uv0.sortPowerMoFunc)

	for slot10, slot11 in pairs(slot4) do
		slot12 = slot11.quantity

		if slot2 < slot5 + slot11.quantity then
			slot12 = slot2 - slot5
		end

		table.insert(slot6, {
			uid = slot11.uid,
			num = slot12
		})

		if slot2 <= slot5 + slot12 then
			break
		end
	end

	return slot6
end

function slot0.sortPowerMoFunc(slot0, slot1)
	if slot0.expireTime == 0 and slot1.expireTime == 0 then
		return false
	end

	if slot0.expireTime == 0 then
		return false
	end

	if slot1.expireTime == 0 then
		return true
	end

	return slot0.expireTime < slot1.expireTime
end

slot0.instance = slot0.New()

return slot0

module("modules.logic.versionactivity1_2.trade.config.Activity117Config", package.seeall)

slot0 = class("Activity117Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._actAllBonus = nil
	slot0._act117Bonus = nil
	slot0._act117Order = nil
	slot0._act117Talk = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity117_bonus",
		"activity117_order",
		"activity117_talk"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity117_bonus" then
		slot0._act117Bonus = slot2
	elseif slot1 == "activity117_order" then
		slot0._act117Order = slot2
	elseif slot1 == "activity117_talk" then
		slot0._act117Talk = slot2
	end
end

function slot0.getOrderConfig(slot0, slot1, slot2)
	if slot0._act117Order.configDict[slot1] then
		return slot0._act117Order.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getAllBonusConfig(slot0, slot1)
	slot0._actAllBonus = slot0._actAllBonus or {}

	if not slot0._actAllBonus[slot1] then
		slot0._actAllBonus[slot1] = {}

		for slot6, slot7 in pairs(slot0._act117Bonus.configDict[slot1]) do
			table.insert(slot0._actAllBonus[slot1], slot7)
		end
	end

	return slot0._actAllBonus[slot1]
end

function slot0.getBonusConfig(slot0, slot1, slot2)
	if not slot0._act117Bonus.configDict[slot1] then
		return
	end

	return slot3[slot2]
end

function slot0.getTotalActivityDays(slot0, slot1)
	for slot7, slot8 in pairs(slot0._act117Order.configDict[slot1]) do
		slot3 = math.max(slot8.openDay, 0)
	end

	return slot3
end

function slot0.getTalkCo(slot0, slot1, slot2)
	if slot0._act117Talk.configDict[slot1] then
		return slot0._act117Talk.configDict[slot1][slot2]
	end

	return nil
end

slot0.instance = slot0.New()

return slot0

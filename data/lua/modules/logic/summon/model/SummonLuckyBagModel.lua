module("modules.logic.summon.model.SummonLuckyBagModel", package.seeall)

slot0 = class("SummonLuckyBagModel", BaseModel)

function slot0.isLuckyBagOpened(slot0, slot1, slot2)
	if SummonMainModel.instance:getPoolServerMO(slot1) and slot3.luckyBagMO then
		return slot3.luckyBagMO:isOpened()
	end

	return false
end

function slot0.getGachaRemainTimes(slot0, slot1)
	slot4 = SummonConfig.getSummonSSRTimes(SummonConfig.instance:getSummonPool(slot1))

	if SummonMainModel.instance:getPoolServerMO(slot1) and slot3.luckyBagMO then
		return slot4 - slot3.luckyBagMO.summonTimes
	end

	return slot4
end

function slot0.isLuckyBagGot(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1) and slot2.luckyBagMO then
		return slot2.luckyBagMO:isGot(), slot2.luckyBagMO.luckyBagId
	end

	return false
end

function slot0.needAutoPopup(slot0, slot1)
	if not PlayerModel.instance:getPlayinfo() or slot2.userId == 0 then
		return nil
	end

	if string.nilorempty(PlayerPrefsHelper.getString(string.format("LuckyBagAutoPopup_%s_%s", slot2.userId, slot1), "")) then
		return true
	end

	return false
end

function slot0.recordAutoPopup(slot0, slot1)
	if not PlayerModel.instance:getPlayinfo() or slot2.userId == 0 then
		return nil
	end

	PlayerPrefsHelper.setString(string.format("LuckyBagAutoPopup_%s_%s", slot2.userId, slot1), "1")
end

slot0.instance = slot0.New()

return slot0

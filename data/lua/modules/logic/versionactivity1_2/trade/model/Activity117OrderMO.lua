module("modules.logic.versionactivity1_2.trade.model.Activity117OrderMO", package.seeall)

slot0 = pureTable("Activity117OrderMO")

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1

	slot0:resetCo(Activity117Config.instance:getOrderConfig(slot1, slot2))
	slot0:resetData()
end

function slot0.resetCo(slot0, slot1)
	slot0.co = slot1
	slot0.id = slot1.id
	slot0.order = slot1.order
	slot0.minScore = slot1.minDealScore
	slot0.maxScore = slot1.maxDealScore
	slot0.maxAcceptScore = slot1.maxAcceptScore
	slot0.maxProgress = slot1.maxProgress
	slot0.desc = slot1.name or ""
	slot0.jumpId = slot1.jumpId
end

function slot0.resetData(slot0)
	slot0.hasGetBonus = false
	slot0.userDealScores = {}
	slot0.progress = 0
end

function slot0.updateServerData(slot0, slot1)
	slot0.hasGetBonus = slot1.hasGetBonus
	slot0.userDealScores = slot1.userDealScores
	slot0.progress = slot1.progress

	slot0:updateStatus()
end

function slot0.getLastRound(slot0)
	return slot0.userDealScores[#slot0.userDealScores]
end

function slot0.sortOrderFunc(slot0, slot1)
	if slot0.hasGetBonus and slot1.hasGetBonus then
		return slot0.order < slot1.order
	end

	if not slot0.hasGetBonus and not slot1.hasGetBonus then
		if slot0:isProgressEnough() and not slot1:isProgressEnough() then
			return true
		end

		if not slot0:isProgressEnough() and slot1:isProgressEnough() then
			return false
		end

		return slot0.order < slot1.order
	end

	return not slot0.hasGetBonus
end

function slot0.getDesc(slot0)
	return slot0.desc
end

function slot0.isProgressEnough(slot0)
	return slot0.maxProgress <= slot0.progress
end

function slot0.updateStatus(slot0)
	if slot0.hasGetBonus then
		slot0.status = Activity117Enum.Status.AlreadyGot

		return
	end

	if slot0:isProgressEnough() then
		slot0.status = Activity117Enum.Status.CanGet

		return
	end

	slot0.status = Activity117Enum.Status.NotEnough
end

function slot0.getStatus(slot0)
	return slot0.status
end

function slot0.checkPrice(slot0, slot1)
	slot2 = slot0.minScore

	if slot0.maxAcceptScore < slot1 then
		return Activity117Enum.PriceType.Bad
	end

	if slot1 <= slot2 + (slot3 - slot2) / 3 then
		return Activity117Enum.PriceType.Best
	end

	if slot1 <= slot2 + 2 * slot4 then
		return Activity117Enum.PriceType.Better
	end

	return Activity117Enum.PriceType.Common
end

function slot0.getMinPrice(slot0)
	for slot4 = #slot0.userDealScores, 1, -1 do
		if slot0:checkPrice(slot0.userDealScores[slot4]) ~= Activity117Enum.PriceType.Bad then
			return slot0.userDealScores[slot4]
		end
	end

	return slot0.minScore
end

return slot0

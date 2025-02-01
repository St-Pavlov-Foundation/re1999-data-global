module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueEndingInfoMO", package.seeall)

slot0 = pureTable("RogueEndingInfoMO")

function slot0.init(slot0, slot1)
	slot0._activityId = slot1.activityId
	slot0._difficulty = slot1.difficulty
	slot0._heros = slot1.heroId
	slot0._roomId = slot1.roomId
	slot0._roomNum = slot1.roomNum
	slot0._currencyTotal = slot1.currencyTotal
	slot0._collections = slot1.collections
	slot0._isFinish = slot1.isFinish
	slot0._score = slot1.score
	slot0._doubleScore = slot1.doubleScore
	slot0._bonus = slot1.bonus
	slot0._ending = slot1.ending
	slot0._layer = slot1.layer
	slot0._failReason = slot1.failReason

	slot0:initFinishEvents(slot1)

	slot0._isEnterEndingFlow = false
end

function slot0.initFinishEvents(slot0, slot1)
	slot0.finishEventList = slot0.finishEventList or {}

	tabletool.clear(slot0.finishEventList)

	if slot1.finishEvents then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot0.finishEventList, slot7)
		end
	end
end

function slot0.getFinishEventList(slot0)
	return slot0.finishEventList
end

function slot0.getFinishEventNum(slot0)
	return slot0.finishEventList and #slot0.finishEventList or 0
end

function slot0.getLayer(slot0)
	return slot0._layer
end

function slot0.getRoomNum(slot0)
	return slot0._roomNum
end

function slot0.getDifficulty(slot0)
	return slot0._difficulty
end

function slot0.getScore(slot0)
	return slot0._score
end

function slot0.isDoubleScore(slot0)
	return slot0._doubleScore > 0
end

function slot0.isFinish(slot0)
	return slot0._isFinish
end

function slot0.getFailReason(slot0)
	return slot0._failReason
end

function slot0.onEnterEndingFlow(slot0)
	slot0._isEnterEndingFlow = true
end

function slot0.isEnterEndingFlow(slot0)
	return slot0._isEnterEndingFlow
end

return slot0

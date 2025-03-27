module("modules.logic.turnback.model.TurnbackInfoMo", package.seeall)

slot0 = pureTable("TurnbackInfoMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.tasks = {}
	slot0.bonusPoint = 0
	slot0.firstShow = true
	slot0.hasGetTaskBonus = {}
	slot0.signInDay = 0
	slot0.signInInfos = {}
	slot0.onceBonus = false
	slot0.endTime = 0
	slot0.startTime = 0
	slot0.remainAdditionCount = 0
	slot0.leaveTime = 0
	slot0.monthCardAddedBuyCount = 0
	slot0.newType = true
	slot0.hasBuyDoubleBonus = false
	slot0.config = nil
	slot0.dropinfos = {}
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.tasks = slot1.tasks
	slot0.bonusPoint = slot1.bonusPoint
	slot0.firstShow = slot1.firstShow
	slot0.hasGetTaskBonus = slot1.hasGetTaskBonus
	slot0.signInDay = slot1.signInDay
	slot0.signInInfos = slot1.signInInfos
	slot0.onceBonus = slot1.onceBonus
	slot0.startTime = tonumber(slot1.startTime)
	slot0.endTime = tonumber(slot1.endTime)
	slot0.leaveTime = tonumber(slot1.leaveTime)
	slot0.monthCardAddedBuyCount = tonumber(slot1.monthCardAddedBuyCount)

	slot0:setRemainAdditionCount(slot1.remainAdditionCount, true)

	slot0.newType = slot1.version == TurnbackEnum.type.New and true or false
	slot0.hasBuyDoubleBonus = slot1.buyDoubleBonus
	slot0.config = TurnbackConfig.instance:getTurnbackCo(slot0.id)
	slot0.dropinfos = slot1.dropInfos
end

function slot0.isStart(slot0)
	return ServerTime.now() - slot0.startTime >= 0
end

function slot0.isEnd(slot0)
	return ServerTime.now() - slot0.endTime > 0
end

function slot0.isInReommendTime(slot0)
	return slot0.leaveTime > 0 and ServerTime.now() - slot0.leaveTime >= 0
end

function slot0.isInOpenTime(slot0)
	return slot0:isStart() and not slot0:isEnd()
end

function slot0.isNewType(slot0)
	return slot0.newType
end

function slot0.updateHasGetTaskBonus(slot0, slot1)
	slot0.hasGetTaskBonus = slot1
end

function slot0.setRemainAdditionCount(slot0, slot1, slot2)
	slot3 = 0

	if slot1 and slot1 > 0 then
		slot3 = slot1
	end

	slot0.remainAdditionCount = slot3

	if slot0.remainAdditionCount ~= slot3 and not slot2 then
		TurnbackController.instance:dispatchEvent(TurnbackEvent.AdditionCountChange, slot0.id)
	end
end

function slot0.isRemainAdditionCount(slot0)
	return slot0:getRemainAdditionCount() > 0
end

function slot0.isAdditionInOpenTime(slot0)
	return ServerTime.now() - slot0.startTime < TurnbackConfig.instance:getAdditionDurationDays(slot0.id) * TimeUtil.OneDaySecond
end

function slot0.isAdditionValid(slot0)
	return slot0:isInOpenTime() and slot0:isAdditionInOpenTime() and slot0:isRemainAdditionCount()
end

function slot0.getRemainAdditionCount(slot0)
	return slot0.remainAdditionCount
end

function slot0.getBuyDoubleBonus(slot0)
	return slot0.hasBuyDoubleBonus
end

return slot0

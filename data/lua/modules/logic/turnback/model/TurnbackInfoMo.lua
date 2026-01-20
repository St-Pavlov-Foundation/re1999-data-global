-- chunkname: @modules/logic/turnback/model/TurnbackInfoMo.lua

module("modules.logic.turnback.model.TurnbackInfoMo", package.seeall)

local TurnbackInfoMo = pureTable("TurnbackInfoMo")

function TurnbackInfoMo:ctor()
	self.id = 0
	self.tasks = {}
	self.bonusPoint = 0
	self.firstShow = true
	self.hasGetTaskBonus = {}
	self.signInDay = 0
	self.signInInfos = {}
	self.onceBonus = false
	self.endTime = 0
	self.startTime = 0
	self.remainAdditionCount = 0
	self.leaveTime = 0
	self.monthCardAddedBuyCount = 0
	self.newType = true
	self.hasBuyDoubleBonus = false
	self.config = nil
	self.dropinfos = {}
	self.getDailyBonus = nil
end

function TurnbackInfoMo:init(info)
	self.id = info.id
	self.tasks = info.tasks
	self.bonusPoint = info.bonusPoint
	self.firstShow = info.firstShow
	self.hasGetTaskBonus = info.hasGetTaskBonus
	self.signInDay = info.signInDay
	self.signInInfos = info.signInInfos
	self.onceBonus = info.onceBonus
	self.startTime = tonumber(info.startTime)
	self.endTime = tonumber(info.endTime)
	self.leaveTime = tonumber(info.leaveTime)
	self.monthCardAddedBuyCount = tonumber(info.monthCardAddedBuyCount)

	self:setRemainAdditionCount(info.remainAdditionCount, true)

	self.newType = info.version == TurnbackEnum.type.New and true or false
	self.hasBuyDoubleBonus = info.buyDoubleBonus
	self.config = TurnbackConfig.instance:getTurnbackCo(self.id)
	self.dropinfos = info.dropInfos
	self.dailyBonus = info.getDailyBonus
end

function TurnbackInfoMo:isStart()
	return ServerTime.now() - self.startTime >= 0
end

function TurnbackInfoMo:isEnd()
	return ServerTime.now() - self.endTime > 0
end

function TurnbackInfoMo:isInReommendTime()
	return self.leaveTime > 0 and ServerTime.now() - self.leaveTime >= 0
end

function TurnbackInfoMo:isInOpenTime()
	local isStart = self:isStart()
	local isEnd = self:isEnd()

	return isStart and not isEnd
end

function TurnbackInfoMo:isNewType()
	return self.newType
end

function TurnbackInfoMo:updateHasGetTaskBonus(hasGetTaskBonus)
	self.hasGetTaskBonus = hasGetTaskBonus
end

function TurnbackInfoMo:setRemainAdditionCount(newCount, isInit)
	local tmpNewCount = 0

	if newCount and newCount > 0 then
		tmpNewCount = newCount
	end

	local isChange = self.remainAdditionCount ~= tmpNewCount

	self.remainAdditionCount = tmpNewCount

	if isChange and not isInit then
		TurnbackController.instance:dispatchEvent(TurnbackEvent.AdditionCountChange, self.id)
	end
end

function TurnbackInfoMo:isRemainAdditionCount()
	local remainCount = self:getRemainAdditionCount()

	return remainCount > 0
end

function TurnbackInfoMo:isAdditionInOpenTime()
	local additionDurationDays = TurnbackConfig.instance:getAdditionDurationDays(self.id)
	local turnbackElapsedTime = ServerTime.now() - self.startTime
	local result = turnbackElapsedTime < additionDurationDays * TimeUtil.OneDaySecond

	return result
end

function TurnbackInfoMo:isAdditionValid()
	local isInOpenTime = self:isInOpenTime()
	local isAdditionInOpenTime = self:isAdditionInOpenTime()
	local isRemainCount = self:isRemainAdditionCount()

	return isInOpenTime and isAdditionInOpenTime and isRemainCount
end

function TurnbackInfoMo:getRemainAdditionCount()
	return self.remainAdditionCount
end

function TurnbackInfoMo:getBuyDoubleBonus()
	return self.hasBuyDoubleBonus
end

function TurnbackInfoMo:setDailyBonus(getDailyBonus)
	self.dailyBonus = getDailyBonus
end

function TurnbackInfoMo:isClaimedDailyBonus(day)
	day = day - 1

	local bits = Bitwise["<<"](1, day)

	return Bitwise.has(self.dailyBonus, bits)
end

return TurnbackInfoMo

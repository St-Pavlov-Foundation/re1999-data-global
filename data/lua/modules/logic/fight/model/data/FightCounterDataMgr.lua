-- chunkname: @modules/logic/fight/model/data/FightCounterDataMgr.lua

module("modules.logic.fight.model.data.FightCounterDataMgr", package.seeall)

local FightCounterDataMgr = FightDataClass("FightCounterDataMgr", FightDataMgrBase)

FightCounterDataMgr.CounterType = {}

local id2Name = {}

for k, v in pairs(FightCounterDataMgr.CounterType) do
	id2Name[v] = k
end

function FightCounterDataMgr:onConstructor()
	self.counterDic = {}
end

function FightCounterDataMgr:getCounter(counterType)
	local counter = self.counterDic[counterType] or 0

	return counter
end

function FightCounterDataMgr:addCounter(counterType)
	local counter = self.counterDic[counterType] or 0

	self.counterDic[counterType] = counter + 1
end

function FightCounterDataMgr:removeCounter(counterType)
	local counter = self.counterDic[counterType] or 0

	self.counterDic[counterType] = counter - 1
end

function FightCounterDataMgr:printCounterInfo()
	for k, v in pairs(self.counterDic) do
		logError("计数器 key = " .. id2Name[k] .. ", value = " .. v)
	end
end

return FightCounterDataMgr

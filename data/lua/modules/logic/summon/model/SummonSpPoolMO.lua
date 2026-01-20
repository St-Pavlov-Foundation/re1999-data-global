-- chunkname: @modules/logic/summon/model/SummonSpPoolMO.lua

module("modules.logic.summon.model.SummonSpPoolMO", package.seeall)

local SummonSpPoolMO = pureTable("SummonSpPoolMO", SummonCustomPickMO)

function SummonSpPoolMO:ctor()
	self.type = 0
	self.openTime = 0

	SummonCustomPickMO.ctor(self)
end

function SummonSpPoolMO:isValid()
	return self.type ~= 0
end

function SummonSpPoolMO:update(info)
	SummonCustomPickMO.update(self, info)

	self.type = info.type
	self.openTime = tonumber(info.openTime) or 0
end

function SummonSpPoolMO:isOpening()
	if not self:isValid() then
		return nil
	end

	local now = ServerTime.now()

	return now >= self:onlineTs() and now <= self:offlineTs()
end

function SummonSpPoolMO:onlineTs()
	return self.openTime / 1000
end

function SummonSpPoolMO:offlineTs()
	if self:onlineTs() <= 0 then
		return 0
	end

	local duration = SummonConfig.instance:getDurationByPoolType(self.type)

	if duration <= 0 then
		return 0
	end

	return self:onlineTs() + duration
end

function SummonSpPoolMO:onOffTimestamp()
	return self:onlineTs(), self:offlineTs()
end

return SummonSpPoolMO

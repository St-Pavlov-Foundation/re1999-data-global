-- chunkname: @modules/logic/partygamelobby/model/rpcmo/ProcessInfoMO.lua

module("modules.logic.partygamelobby.model.rpcmo.ProcessInfoMO", package.seeall)

local ProcessInfoMO = pureTable("ProcessInfoMO")

function ProcessInfoMO:startPing(pingObj)
	pingObj:setCompletedCb(self._onPingCompletedCb, self)
	pingObj:setTimeoutCb(self._onPingTimeoutCb, self)
	pingObj:reset(self.outerIp)
end

function ProcessInfoMO:_onPingCompletedCb(pingObj)
	self._ms = pingObj:ms()

	PartyGameRoomModel.instance:onOnePingObjCompleted(pingObj)
end

function ProcessInfoMO:_onPingTimeoutCb(pingObj)
	self._ms = -1

	PartyGameRoomModel.instance:onOnePingObjCompleted(pingObj)
end

function ProcessInfoMO:getMs()
	return self._ms or -1
end

function ProcessInfoMO:bNeedAlertMs()
	local ms = self:getMs()

	if ms == -1 then
		return true
	end

	return ms >= PartyGameConfig.instance:getAlertMaxMs()
end

function ProcessInfoMO:areaId()
	local areaId = math.floor(self.id / 10000)

	return areaId
end

function ProcessInfoMO:init(info)
	self.id = info.id
	self.outerIp = info.outerIp
	self.outerPort = info.outerPort
	self.innerIp = info.innerIp
	self.innerPort = info.innerPort
end

return ProcessInfoMO

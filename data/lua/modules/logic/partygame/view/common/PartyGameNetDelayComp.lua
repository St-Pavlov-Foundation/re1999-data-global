-- chunkname: @modules/logic/partygame/view/common/PartyGameNetDelayComp.lua

module("modules.logic.partygame.view.common.PartyGameNetDelayComp", package.seeall)

local PartyGameNetDelayComp = class("PartyGameNetDelayComp", LuaCompBase)

require("tolua.reflection")
tolua.loadassembly("Assembly-CSharp")

local KcpSocketAliveMgr_Type = tolua.findtype("System.Net.Sockets.Kcp.KcpSocketAliveMgr")
local KcpSocketAliveMgr_Instance = tolua.getproperty(KcpSocketAliveMgr_Type, "Instance")
local getLatency_method = tolua.getmethod(KcpSocketAliveMgr_Type, "GetLatency")
local resetLatency_method = tolua.getmethod(KcpSocketAliveMgr_Type, "ResetLatency")

function PartyGameNetDelayComp:init(go)
	self.go = go
	self._txt = gohelper.findChildText(go, "txt_time")
	self._txt.text = ""

	self:onInitView()
end

function PartyGameNetDelayComp:onInitView()
	TaskDispatcher.runDelay(self._start, self, 3)
end

function PartyGameNetDelayComp:_start()
	if resetLatency_method then
		resetLatency_method:Call(KcpSocketAliveMgr_Instance:Get(nil, nil))
	end

	self:updatetText()
	TaskDispatcher.runRepeat(self.updatetText, self, 1)
end

function PartyGameNetDelayComp:updatetText()
	local netDelay = tonumber(tostring(getLatency_method:Call(KcpSocketAliveMgr_Instance:Get(nil, nil))))

	netDelay = math.max(netDelay, 10)
	netDelay = math.min(netDelay, 999)

	local color = "00FF64"

	if netDelay > 200 then
		color = "CF1C00"
	elseif netDelay > 100 then
		color = "EC8E00"
	end

	self._txt.text = string.format("<color=#%s>%sms</color>", color, netDelay)
end

function PartyGameNetDelayComp:addEventListeners()
	return
end

function PartyGameNetDelayComp:removeEventListeners()
	TaskDispatcher.cancelTask(self.updatetText, self)
	TaskDispatcher.cancelTask(self._start, self)
end

function PartyGameNetDelayComp:onDestroy()
	TaskDispatcher.cancelTask(self.updatetText, self)
	TaskDispatcher.cancelTask(self._start, self)
end

return PartyGameNetDelayComp

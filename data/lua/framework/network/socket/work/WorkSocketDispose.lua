-- chunkname: @framework/network/socket/work/WorkSocketDispose.lua

module("framework.network.socket.work.WorkSocketDispose", package.seeall)

local WorkSocketDispose = class("WorkSocketDispose", BaseWork)

function WorkSocketDispose:onStart(context)
	if SDKMgr.instance:isAccelerating() then
		ZProj.LinkBoostController.Instance:Setup()
	else
		ZProj.LinkBoostController.Instance:Close()
	end

	LuaSocketMgr.instance:reInit()
	self:onDone(true)
end

return WorkSocketDispose

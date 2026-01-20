-- chunkname: @modules/logic/voyage/rpc/Activity1001Rpc.lua

module("modules.logic.voyage.rpc.Activity1001Rpc", package.seeall)

local Activity1001Rpc = class("Activity1001Rpc", BaseRpc)

function Activity1001Rpc:sendAct1001GetInfoRequest(activityId, callback, callbackObj, socketId)
	local req = Activity1001Module_pb.Act1001GetInfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj, socketId)
end

function Activity1001Rpc:onReceiveAct1001GetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VoyageController.instance:_onReceiveAct1001GetInfoReply(msg)
end

function Activity1001Rpc:onReceiveAct1001UpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	VoyageController.instance:_onReceiveAct1001UpdatePush(msg)
end

Activity1001Rpc.instance = Activity1001Rpc.New()

return Activity1001Rpc

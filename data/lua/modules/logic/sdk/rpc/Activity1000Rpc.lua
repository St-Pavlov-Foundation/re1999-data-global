-- chunkname: @modules/logic/sdk/rpc/Activity1000Rpc.lua

module("modules.logic.sdk.rpc.Activity1000Rpc", package.seeall)

local Activity1000Rpc = class("Activity1000Rpc", BaseRpc)

function Activity1000Rpc:sendAct1000GetInfoRequest(activityId, callback, callbackObj, socketId)
	local req = Activity1000Module_pb.Act1000GetInfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj, socketId)
end

function Activity1000Rpc:onReceiveAct1000GetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(msg.accountBindBonus)
end

function Activity1000Rpc:sendAct1000AccountBindBonusRequest(activityId)
	local req = Activity1000Module_pb.Act1000AccountBindBonusRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity1000Rpc:onReceiveAct1000AccountBindBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SDKModel.instance:setAccountBindBonus(SDKEnum.RewardType.Got)
end

Activity1000Rpc.instance = Activity1000Rpc.New()

return Activity1000Rpc

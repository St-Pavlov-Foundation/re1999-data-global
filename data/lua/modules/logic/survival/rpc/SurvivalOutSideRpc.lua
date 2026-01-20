-- chunkname: @modules/logic/survival/rpc/SurvivalOutSideRpc.lua

module("modules.logic.survival.rpc.SurvivalOutSideRpc", package.seeall)

local SurvivalOutSideRpc = class("SurvivalOutSideRpc", BaseRpc)

function SurvivalOutSideRpc:sendSurvivalOutSideGetInfo(callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalOutSideGetInfoRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalOutSideRpc:onReceiveSurvivalOutSideGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		SurvivalModel.instance:onGetInfo(msg.info)
	end
end

function SurvivalOutSideRpc:sendSurvivalOutSideGainReward(rewardId, callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalOutSideGainRewardRequest()

	req.rewardId = rewardId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalOutSideRpc:onReceiveSurvivalOutSideGainRewardReply(resultCode, msg)
	if resultCode == 0 then
		local outSideMo = SurvivalModel.instance:getOutSideInfo()

		outSideMo:onGainReward(msg.rewardId)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnGainReward)
	end
end

function SurvivalOutSideRpc:sendSurvivalSurvivalOutSideClientData(data, callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalSurvivalOutSideClientDataRequest()

	req.data = data

	return self:sendMsg(req, callback, callobj)
end

function SurvivalOutSideRpc:onReceiveSurvivalSurvivalOutSideClientDataReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalOutSideRpc:onReceiveSurvivalHandbookPush(resultCode, msg)
	return
end

function SurvivalOutSideRpc:onReceiveSurvivalMarkNewHandbookReply(resultCode, msg)
	SurvivalHandbookModel.instance:onReceiveSurvivalMarkNewHandbookReply(resultCode, msg)
end

function SurvivalOutSideRpc:sendSurvivalMarkNewHandbook(ids, callback, callobj)
	local req = SurvivalOutSideModule_pb.SurvivalMarkNewHandbookRequest()

	for i, v in ipairs(ids) do
		table.insert(req.ids, v)
	end

	return self:sendMsg(req, callback, callobj)
end

SurvivalOutSideRpc.instance = SurvivalOutSideRpc.New()

return SurvivalOutSideRpc

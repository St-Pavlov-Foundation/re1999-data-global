-- chunkname: @modules/logic/bossrush/rpc/BossRushRpc.lua

module("modules.logic.bossrush.rpc.BossRushRpc", package.seeall)

local BossRushRpc = class("BossRushRpc", Activity128Rpc)

function BossRushRpc:ctor()
	Activity128Rpc.instance = self
end

local function _isValid(resultCode, msg)
	local activityId = msg.activityId

	if not BossRushConfig.instance:checkActivityId(activityId) then
		return false
	end

	if resultCode ~= 0 then
		return false
	end

	return true
end

function BossRushRpc:sendGet128InfosRequest(callback, cbObj)
	local activityId = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendGet128InfosRequest(self, activityId, callback, cbObj)
end

function BossRushRpc:sendAct128GetTotalRewardsRequest(bossId)
	local activityId = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128GetTotalRewardsRequest(self, activityId, bossId)
end

function BossRushRpc:sendAct128DoublePointRequest(bossId)
	local activityId = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128DoublePointRequest(self, activityId, bossId)
end

function BossRushRpc:sendAct128GetTotalSingleRewardRequest(bossId, index)
	local activityId = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128GetTotalSingleRewardRequest(self, activityId, bossId, index)
end

function BossRushRpc:_onReceiveGet128InfosReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveGet128InfosReply(msg)
	V2a9BossRushModel.instance:onRefresh128InfosReply(msg)
	V3a2_BossRushModel.instance:onRefresh128InfosReply(msg)
end

function BossRushRpc:_onReceiveAct128GetTotalRewardsReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveAct128GetTotalRewardsReply(msg)
end

function BossRushRpc:_onReceiveAct128DoublePointReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveAct128DoublePointReply(msg)
end

function BossRushRpc:_onReceiveAct128InfoUpdatePush(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveAct128InfoUpdatePush(msg)
	V2a9BossRushModel.instance:onRefresh128InfosReply(msg)
	V3a2_BossRushModel.instance:onRefresh128InfosReply(msg)
end

function BossRushRpc:_onReceiveAct128GetTotalSingleRewardReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveAct128SingleRewardReply(msg)
end

function BossRushRpc:_onReceiveAct128SpFirstHalfSelectItemReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V2a9BossRushModel.instance:onReceiveAct128SpFirstHalfSelectItemReply(msg)
	BossRushController.instance:dispatchEvent(BossRushEvent.onReceiveAct128SpFirstHalfSelectItemReply)
end

function BossRushRpc:_onReceiveAct128GetExpReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V3a2_BossRushModel.instance:onReceiveAct128GetExpReply(msg)
	BossRushController.instance:dispatchEvent(BossRushEvent.onReceiveAct128GetExpReply)
end

function BossRushRpc:_onReceiveAct128GetMilestoneBonusReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V3a2_BossRushModel.instance:_onReceiveAct128GetMilestoneBonusReply(msg)
end

function BossRushRpc:_onReceiveGetGalleryInfosReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V3a2_BossRushModel.instance:onRefreshHandBookInfo(msg)
end

BossRushRpc.instance = BossRushRpc.New()

return BossRushRpc

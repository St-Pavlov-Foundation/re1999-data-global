module("modules.logic.bossrush.rpc.BossRushRpc", package.seeall)

slot0 = class("BossRushRpc", Activity128Rpc)

function slot0.ctor(slot0)
	Activity128Rpc.instance = slot0
end

function slot1(slot0, slot1)
	if not BossRushConfig.instance:checkActivityId(slot1.activityId) then
		return false
	end

	if slot0 ~= 0 then
		return false
	end

	return true
end

function slot0.sendGet128InfosRequest(slot0, slot1, slot2)
	Activity128Rpc.sendGet128InfosRequest(slot0, BossRushConfig.instance:getActivityId(), slot1, slot2)
end

function slot0.sendAct128GetTotalRewardsRequest(slot0, slot1)
	Activity128Rpc.sendAct128GetTotalRewardsRequest(slot0, BossRushConfig.instance:getActivityId(), slot1)
end

function slot0.sendAct128DoublePointRequest(slot0, slot1)
	Activity128Rpc.sendAct128DoublePointRequest(slot0, BossRushConfig.instance:getActivityId(), slot1)
end

function slot0.sendAct128GetTotalSingleRewardRequest(slot0, slot1, slot2)
	Activity128Rpc.sendAct128GetTotalSingleRewardRequest(slot0, BossRushConfig.instance:getActivityId(), slot1, slot2)
end

function slot0._onReceiveGet128InfosReply(slot0, slot1, slot2)
	if not uv0(slot1, slot2) then
		return
	end

	BossRushModel.instance:onReceiveGet128InfosReply(slot2)
end

function slot0._onReceiveAct128GetTotalRewardsReply(slot0, slot1, slot2)
	if not uv0(slot1, slot2) then
		return
	end

	BossRushModel.instance:onReceiveAct128GetTotalRewardsReply(slot2)
end

function slot0._onReceiveAct128DoublePointReply(slot0, slot1, slot2)
	if not uv0(slot1, slot2) then
		return
	end

	BossRushModel.instance:onReceiveAct128DoublePointReply(slot2)
end

function slot0._onReceiveAct128InfoUpdatePush(slot0, slot1, slot2)
	if not uv0(slot1, slot2) then
		return
	end

	BossRushModel.instance:onReceiveAct128InfoUpdatePush(slot2)
end

function slot0._onReceiveAct128GetTotalSingleRewardReply(slot0, slot1, slot2)
	if not uv0(slot1, slot2) then
		return
	end

	BossRushModel.instance:onReceiveAct128SingleRewardReply(slot2)
end

slot0.instance = slot0.New()

return slot0

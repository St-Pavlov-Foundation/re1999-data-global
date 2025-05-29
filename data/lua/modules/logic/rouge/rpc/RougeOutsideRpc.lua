module("modules.logic.rouge.rpc.RougeOutsideRpc", package.seeall)

local var_0_0 = class("RougeOutsideRpc", BaseRpc)

function var_0_0.sendGetRougeOutSideInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()

	var_1_0.season = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetRougeOutsideInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	RougeOutsideModel.instance:onReceiveGetRougeOutsideInfoReply(arg_2_2)
	RougeTalentModel.instance:setOutsideInfo(arg_2_2.rougeInfo)
	RougeRewardModel.instance:setReward(arg_2_2.rougeInfo)
	RougeDLCModel101.instance:initLimiterInfo(arg_2_2.rougeInfo)
end

function var_0_0.sendRougeActiveGeniusRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = RougeOutsideModule_pb.RougeActiveGeniusRequest()

	var_3_0.season = arg_3_1
	var_3_0.geniusId = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveRougeActiveGeniusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	RougeTalentModel.instance:updateGeniusIDs(arg_4_2)
end

function var_0_0.onReceiveRougeUpdateGeniusPointPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	RougeTalentModel.instance:setOutsideInfo(arg_5_2)
end

function var_0_0.sendRougeReceivePointBonusRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = RougeOutsideModule_pb.RougeReceivePointBonusRequest()

	var_6_0.season = arg_6_1
	var_6_0.bonusId = arg_6_2

	arg_6_0:sendMsg(var_6_0)
end

function var_0_0.onReceiveRougeReceivePointBonusReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	if arg_7_2.bonusId and arg_7_2.bonusStage then
		RougeRewardModel.instance:updateReward(arg_7_2.bonusStage)
		RougeController.instance:dispatchEvent(RougeEvent.OnGetRougeReward, arg_7_2.bonusId)
	else
		RougeRewardModel.instance:setReward(arg_7_2)
	end
end

function var_0_0.onReceiveRougeUpdatePointPush(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	RougeRewardModel.instance:setReward(arg_8_2)
end

function var_0_0.sendRougeGetUnlockCollectionsRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = RougeOutsideModule_pb.RougeGetUnlockCollectionsRequest()

	var_9_0.season = arg_9_1

	arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveRougeGetUnlockCollectionsReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.season
	local var_10_1 = arg_10_2.unlockCollectionIds

	RougeFavoriteModel.instance:initUnlockCollectionIds(var_10_1)
end

function var_0_0.sendRougeGetNewReddotInfoRequest(arg_11_0, arg_11_1)
	local var_11_0 = RougeOutsideModule_pb.RougeGetNewReddotInfoRequest()

	var_11_0.season = arg_11_1

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveRougeGetNewReddotInfoReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.season
	local var_12_1 = arg_12_2.newReddots

	RougeFavoriteModel.instance:initReddots(var_12_1)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
end

function var_0_0.sendRougeMarkNewReddotRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = RougeOutsideModule_pb.RougeMarkNewReddotRequest()

	var_13_0.season = arg_13_1
	var_13_0.type = arg_13_2
	var_13_0.id = arg_13_3

	arg_13_0:sendMsg(var_13_0, arg_13_4, arg_13_5)

	if arg_13_3 == 0 then
		RougeFavoriteModel.instance:deleteReddotId(arg_13_2, arg_13_3)
		RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
	end
end

function var_0_0.onReceiveRougeMarkNewReddotReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	local var_14_0 = arg_14_2.season
	local var_14_1 = arg_14_2.type
	local var_14_2 = arg_14_2.id

	if var_14_2 == 0 then
		return
	end

	RougeFavoriteModel.instance:deleteReddotId(var_14_1, var_14_2)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
end

function var_0_0.sendRougeMarkGeniusNewStageRequest(arg_15_0, arg_15_1)
	local var_15_0 = RougeOutsideModule_pb.RougeMarkGeniusNewStageRequest()

	var_15_0.season = arg_15_1

	arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveRougeMarkGeniusNewStageReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	RougeTalentModel.instance:setNewStage(false)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo)
end

function var_0_0.sendRougeMarkBonusNewStageRequest(arg_17_0, arg_17_1)
	local var_17_0 = RougeOutsideModule_pb.RougeMarkBonusNewStageRequest()

	var_17_0.season = arg_17_1

	arg_17_0:sendMsg(var_17_0)
end

function var_0_0.onReceiveRougeMarkBonusNewStageReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	RougeRewardModel.instance:setNewStage(false)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function var_0_0.onReceiveRougeReddotUpdatePush(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end

	local var_19_0 = arg_19_2.season
	local var_19_1 = arg_19_2.newReddots
end

function var_0_0.sendRougeUnlockStoryRequest(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = RougeOutsideModule_pb.RougeUnlockStoryRequest()

	var_20_0.season = arg_20_1
	var_20_0.storyId = arg_20_2

	arg_20_0:sendMsg(var_20_0)
end

function var_0_0.onReceiveRougeUnlockStoryReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		return
	end

	local var_21_0 = arg_21_2.season
	local var_21_1 = arg_21_2.storyId
end

function var_0_0.sendRougeLimiterSettingSaveRequest(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = RougeOutsideModule_pb.RougeLimiterSettingSaveRequest()

	var_22_0.season = arg_22_1

	if arg_22_2 then
		local var_22_1 = arg_22_2:getLimitIds()

		for iter_22_0, iter_22_1 in ipairs(var_22_1) do
			var_22_0.clientNO.limitIds:append(iter_22_1)
		end

		local var_22_2 = arg_22_2:getLimitBuffIds()

		for iter_22_2, iter_22_3 in ipairs(var_22_2) do
			var_22_0.clientNO.limitBuffIds:append(iter_22_3)
		end
	end

	arg_22_0:sendMsg(var_22_0)
end

function var_0_0.onReceiveRougeLimiterSettingSaveReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= 0 then
		return
	end

	local var_23_0 = arg_23_2.season
	local var_23_1 = arg_23_2.clientNO

	RougeDLCModel101.instance:onGetLimiterClientMo(var_23_1)
end

function var_0_0.sendRougeDLCSettingSaveRequest(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = RougeOutsideModule_pb.RougeDLCSettingSaveRequest()

	var_24_0.season = arg_24_1

	for iter_24_0, iter_24_1 in ipairs(arg_24_2 or {}) do
		var_24_0.dlcVersionIds:append(iter_24_1)
	end

	arg_24_0:sendMsg(var_24_0)
end

function var_0_0.onReceiveRougeDLCSettingSaveReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 ~= 0 then
		return
	end

	local var_25_0 = arg_25_2.season
	local var_25_1 = arg_25_2.dlcVersionIds

	RougeOutsideModel.instance:getRougeGameRecord():_updateVersionIds(var_25_1)
	RougeDLCController.instance:dispatchEvent(RougeEvent.OnGetVersionInfo)
end

function var_0_0.sendRougeLimiterUnlockBuffRequest(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = RougeOutsideModule_pb.RougeLimiterUnlockBuffRequest()

	var_26_0.season = arg_26_1
	var_26_0.limitBuffId = arg_26_2

	arg_26_0:sendMsg(var_26_0)
end

function var_0_0.onReceiveRougeLimiterUnlockBuffReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 ~= 0 then
		return
	end

	local var_27_0 = arg_27_2.season
	local var_27_1 = arg_27_2.limitBuffId

	RougeDLCController101.instance:onGetUnlockLimiterBuffInfo(var_27_1)
end

function var_0_0.sendRougeLimiterSpeedUpBuffCdRequest(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = RougeOutsideModule_pb.RougeLimiterSpeedUpBuffCdRequest()

	var_28_0.season = arg_28_1
	var_28_0.limitBuffId = arg_28_2

	arg_28_0:sendMsg(var_28_0)
end

function var_0_0.onReceiveRougeLimiterSpeedUpBuffCdReply(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 ~= 0 then
		return
	end

	local var_29_0 = arg_29_2.season
	local var_29_1 = arg_29_2.limitBuffId

	RougeDLCController101.instance:onGetSpeedupLimiterBuffInfo(var_29_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0

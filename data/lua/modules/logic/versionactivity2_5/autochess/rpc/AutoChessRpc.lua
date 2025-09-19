module("modules.logic.versionactivity2_5.autochess.rpc.AutoChessRpc", package.seeall)

local var_0_0 = class("AutoChessRpc", BaseRpc)

function var_0_0.sendAutoChessGetSceneRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = AutoChessModule_pb.AutoChessGetSceneRequest()

	var_1_0.moduleId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveAutoChessGetSceneReply(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.sendAutoChessEnterSceneRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.episodeId = arg_3_3
	arg_3_0.firstEnter = arg_3_5

	local var_3_0 = AutoChessModule_pb.AutoChessEnterSceneRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.moduleId = arg_3_2
	var_3_0.episodeId = arg_3_3
	var_3_0.masterId = arg_3_4

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAutoChessEnterSceneReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		AutoChessModel.instance:enterSceneReply(arg_4_2.moduleId, arg_4_2.scene, arg_4_2.activityId)
		AutoChessController.instance:enterGame(arg_4_0.episodeId, arg_4_0.firstEnter)
	end

	arg_4_0.firstEnter = nil
	arg_4_0.episodeId = nil
end

function var_0_0.sendAutoChessEnterFightRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = AutoChessModule_pb.AutoChessEnterFightRequest()

	var_5_0.moduleId = arg_5_1

	arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveAutoChessEnterFightReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = AutoChessModel.instance:getChessMo()

	var_6_0.sceneRound = arg_6_2.sceneRound

	var_6_0:cacheSvrFight()
	var_6_0:updateSvrTurn(arg_6_2.turn)
	var_6_0:updateSvrMall(arg_6_2.mall)
	var_6_0:updateSvrBaseInfo(arg_6_2.baseInfo)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.EnterFightReply)
end

function var_0_0.sendAutoChessBuyChessRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = AutoChessModule_pb.AutoChessBuyChessRequest()

	var_7_0.moduleId = arg_7_1
	var_7_0.mallId = arg_7_2
	var_7_0.itemUid = arg_7_3
	var_7_0.warZoneId = arg_7_4
	var_7_0.position = arg_7_5

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveAutoChessBuyChessReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = AutoChessModel.instance:getChessMo()

	var_8_0:updateSvrTurn(arg_8_2.turn)
	var_8_0:updateSvrMall(arg_8_2.mall)
	var_8_0:updateSvrBaseInfo(arg_8_2.baseInfo)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.BuyChessReply)
end

function var_0_0.sendAutoChessBuildRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8, arg_9_9)
	local var_9_0 = AutoChessModule_pb.AutoChessBuildRequest()

	var_9_0.moduleId = arg_9_1
	var_9_0.type = arg_9_2
	var_9_0.fromWarZoneId = arg_9_3
	var_9_0.fromPosition = arg_9_4
	var_9_0.fromUid = arg_9_5
	var_9_0.toWarZoneId = arg_9_6 or 0
	var_9_0.toPosition = arg_9_7 or 0
	var_9_0.toUid = arg_9_8 or 0
	var_9_0.extraParam = arg_9_9 or 0

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveAutoChessBuildReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = AutoChessModel.instance:getChessMo()

	var_10_0:updateSvrTurn(arg_10_2.turn)
	var_10_0:updateSvrMall(arg_10_2.mall)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.BuildReply)
end

function var_0_0.sendAutoChessRefreshMallRequest(arg_11_0, arg_11_1)
	local var_11_0 = AutoChessModule_pb.AutoChessRefreshMallRequest()

	var_11_0.moduleId = arg_11_1

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveAutoChessRefreshMallReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = AutoChessModel.instance:getChessMo()

	var_12_0:updateSvrMall(arg_12_2.mall, true)
	var_12_0:updateSvrTurn(arg_12_2.turn)
end

function var_0_0.sendAutoChessFreezeItemRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	local var_13_0 = AutoChessModule_pb.AutoChessFreezeItemRequest()

	var_13_0.moduleId = arg_13_1
	var_13_0.mallId = arg_13_2
	var_13_0.itemUid = arg_13_3
	var_13_0.type = arg_13_4

	arg_13_0:sendMsg(var_13_0, arg_13_5, arg_13_6)
end

function var_0_0.onReceiveAutoChessFreezeItemReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	AutoChessModel.instance:getChessMo():freezeReply(arg_14_2.mallId, arg_14_2.type)
end

function var_0_0.sendAutoChessMallRegionSelectItemRequest(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.select = arg_15_2 ~= 0

	local var_15_0 = AutoChessModule_pb.AutoChessMallRegionSelectItemRequest()

	var_15_0.moduleId = arg_15_1
	var_15_0.itemId = arg_15_2

	arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveAutoChessMallRegionSelectItemReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	AutoChessModel.instance:getChessMo():updateSvrMallRegion(arg_16_2.region)

	if arg_16_0.select then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ForcePickReply)

		arg_16_0.select = nil
	end
end

function var_0_0.sendAutoChessUseMasterSkillRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = AutoChessModule_pb.AutoChessUseMasterSkillRequest()

	var_17_0.moduleId = arg_17_1
	var_17_0.skillId = arg_17_2
	var_17_0.targetUid = arg_17_3 or 0

	arg_17_0:sendMsg(var_17_0)
end

function var_0_0.onReceiveAutoChessUseMasterSkillReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	local var_18_0 = AutoChessModel.instance:getChessMo()

	var_18_0:updateSvrTurn(arg_18_2.turn)
	var_18_0.svrFight:updateMasterSkill(arg_18_2.skill)
end

function var_0_0.sendAutoChessPreviewFightRequest(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = AutoChessModule_pb.AutoChessPreviewFightRequest()

	var_19_0.moduleId = arg_19_1

	arg_19_0:sendMsg(var_19_0, arg_19_2, arg_19_3)
end

function var_0_0.onReceiveAutoChessPreviewFightReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		return
	end

	local var_20_0 = AutoChessModel.instance:getChessMo()

	var_20_0.preview = true

	if var_20_0.previewCoin ~= 0 then
		var_20_0:updateSvrMallCoin(var_20_0.svrMall.coin - var_20_0.previewCoin)
	end
end

function var_0_0.sendAutoChessGiveUpRequest(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = AutoChessModule_pb.AutoChessGiveUpRequest()

	var_21_0.moduleId = arg_21_1

	arg_21_0:sendMsg(var_21_0, arg_21_2, arg_21_3)
end

function var_0_0.onReceiveAutoChessGiveUpReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 ~= 0 then
		return
	end

	local var_22_0 = AutoChessModel.instance:getChessMo(true)

	if var_22_0 then
		var_22_0:clearData()
	end
end

function var_0_0.onReceiveAutoChessScenePush(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= 0 then
		return
	end

	AutoChessModel.instance:getChessMo():updateSvrScene(arg_23_2.scene)
end

function var_0_0.onReceiveAutoChessRoundSettlePush(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 ~= 0 then
		return
	end

	AutoChessModel.instance:svrResultData(arg_24_2)
end

function var_0_0.onReceiveAutoChessSettlePush(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 ~= 0 then
		return
	end

	AutoChessModel.instance:svrSettleData(arg_25_2)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SettlePush)
end

function var_0_0.sendAutoChessEnterFriendFightSceneRequest(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = AutoChessModule_pb.AutoChessEnterFriendFightSceneRequest()

	var_26_0.activityId = arg_26_1
	var_26_0.moduleId = arg_26_2
	var_26_0.userId = arg_26_3

	arg_26_0:sendMsg(var_26_0)
end

function var_0_0.onReceiveAutoChessEnterFriendFightSceneReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 ~= 0 then
		return
	end

	AutoChessModel.instance:enterSceneReply(arg_27_2.moduleId, arg_27_2.scene)

	local var_27_0 = AutoChessModel.instance:getChessMo()

	if var_27_0 then
		var_27_0:cacheSvrFight()
		var_27_0:updateSvrTurn(arg_27_2.turn)
		AutoChessController.instance:enterSingleGame()
	end
end

function var_0_0.sendAutoChessUseSkillRequest(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = AutoChessModule_pb.AutoChessUseSkillRequest()

	var_28_0.moduleId = arg_28_1
	var_28_0.chessUid = arg_28_2

	arg_28_0:sendMsg(var_28_0)
end

function var_0_0.onReceiveAutoChessUseSkillReply(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 ~= 0 then
		return
	end

	local var_29_0 = AutoChessModel.instance:getChessMo()

	if var_29_0 then
		var_29_0:updateSvrTurn(arg_29_2.turn)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

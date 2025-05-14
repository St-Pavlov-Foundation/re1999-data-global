module("modules.logic.weekwalk.rpc.WeekwalkRpc", package.seeall)

local var_0_0 = class("WeekwalkRpc", BaseRpc)

function var_0_0.sendGetWeekwalkInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = WeekwalkModule_pb.GetWeekwalkInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetWeekwalkInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.info

	WeekWalkModel.instance:initInfo(var_2_0, true)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetInfo)
end

function var_0_0.sendBeforeStartWeekwalkBattleRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._isRestar = arg_3_3

	local var_3_0 = WeekwalkModule_pb.BeforeStartWeekwalkBattleRequest()

	var_3_0.elementId = arg_3_1
	var_3_0.layerId = arg_3_2 or WeekWalkModel.instance:getCurMapId()

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveBeforeStartWeekwalkBattleReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.elementId
	local var_4_1 = arg_4_2.layerId

	if arg_4_0._isRestar then
		arg_4_0._isRestar = nil

		return
	end

	WeekWalkController.instance:enterWeekwalkFight(var_4_0)
end

function var_0_0.sendWeekwalkGeneralRequest(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = WeekwalkModule_pb.WeekwalkGeneralRequest()

	var_5_0.elementId = arg_5_1
	var_5_0.layerId = arg_5_2 or WeekWalkModel.instance:getCurMapId()

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveWeekwalkGeneralReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.elementId
	local var_6_1 = arg_6_2.layerId
	local var_6_2 = WeekWalkModel.instance:getMapInfo(var_6_1)
	local var_6_3 = var_6_2 and var_6_2:getElementInfo(var_6_0)

	if var_6_3 then
		var_6_3.isFinish = true
	end
end

function var_0_0.onReceiveWeekwalkInfoUpdatePush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	local var_7_0 = arg_7_2.info

	WeekWalkModel.instance:updateInfo(var_7_0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnWeekwalkInfoUpdate)
end

function var_0_0.sendWeekwalkDialogRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = WeekwalkModule_pb.WeekwalkDialogRequest()

	var_8_0.elementId = arg_8_1
	var_8_0.option = arg_8_2
	var_8_0.layerId = arg_8_3 or WeekWalkModel.instance:getCurMapId()

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveWeekwalkDialogReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	local var_9_0 = arg_9_2.elementId
	local var_9_1 = arg_9_2.option
	local var_9_2 = arg_9_2.layerId
end

function var_0_0.sendWeekwalkHeroRecommendRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = WeekwalkModule_pb.WeekwalkHeroRecommendRequest()

	var_10_0.elementId = arg_10_1
	var_10_0.layerId = WeekWalkModel.instance:getCurMapId()

	arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveWeekwalkHeroRecommendReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	local var_11_0 = arg_11_2.racommends
end

function var_0_0.sendWeekwalkDialogHistoryRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = WeekwalkModule_pb.WeekwalkDialogHistoryRequest()

	var_12_0.elementId = arg_12_1
	var_12_0.layerId = arg_12_3 or WeekWalkModel.instance:getCurMapId()

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		table.insert(var_12_0.historylist, iter_12_1)
	end

	arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveWeekwalkDialogHistoryReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	local var_13_0 = arg_13_2.elementId
	local var_13_1 = arg_13_2.historylist
	local var_13_2 = arg_13_2.layerId
end

function var_0_0.sendResetLayerRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = WeekwalkModule_pb.ResetLayerRequest()

	var_14_0.layerId = arg_14_1
	var_14_0.battleId = arg_14_2

	return arg_14_0:sendMsg(var_14_0, arg_14_3, arg_14_4)
end

function var_0_0.onReceiveResetLayerReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	local var_15_0 = arg_15_2.info

	WeekWalkModel.instance:initInfo(var_15_0, true)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnWeekwalkResetLayer)
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
end

function var_0_0.sendMarkShowBuffRequest(arg_16_0, arg_16_1)
	local var_16_0 = WeekwalkModule_pb.MarkShowBuffRequest()

	var_16_0.layerId = arg_16_1 or WeekWalkModel.instance:getCurMapId()

	arg_16_0:sendMsg(var_16_0)
end

function var_0_0.onReceiveMarkShowBuffReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= 0 then
		return
	end

	local var_17_0 = arg_17_2.layerId

	WeekWalkModel.instance:getMapInfo(var_17_0).isShowBuff = false
end

function var_0_0.sendMarkShowFinishedRequest(arg_18_0, arg_18_1)
	local var_18_0 = WeekwalkModule_pb.MarkShowFinishedRequest()

	var_18_0.layerId = arg_18_1 or WeekWalkModel.instance:getCurMapId()

	arg_18_0:sendMsg(var_18_0)
end

function var_0_0.onReceiveMarkShowFinishedReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end

	local var_19_0 = arg_19_2.layerId

	WeekWalkModel.instance:getMapInfo(var_19_0).isShowFinished = false
end

function var_0_0.sendSelectNotCdHeroRequest(arg_20_0, arg_20_1)
	local var_20_0 = WeekwalkModule_pb.SelectNotCdHeroRequest()

	var_20_0.layerId = WeekWalkModel.instance:getCurMapId()

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		table.insert(var_20_0.heroId, iter_20_1)
	end

	arg_20_0:sendMsg(var_20_0)
end

function var_0_0.onReceiveSelectNotCdHeroReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		return
	end

	local var_21_0 = arg_21_2.layerId
	local var_21_1 = arg_21_2.heroId

	WeekWalkModel.instance:getMapInfo(var_21_0):clearHeroCd(var_21_1)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSelectNotCdHeroReply)
end

function var_0_0.sendMarkPopDeepRuleRequest(arg_22_0)
	local var_22_0 = WeekwalkModule_pb.MarkPopDeepRuleRequest()

	arg_22_0:sendMsg(var_22_0)
end

function var_0_0.onReceiveMarkPopDeepRuleReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= 0 then
		return
	end
end

function var_0_0.sendMarkPopShallowSettleRequest(arg_24_0)
	local var_24_0 = WeekwalkModule_pb.MarkPopShallowSettleRequest()

	arg_24_0:sendMsg(var_24_0)
end

function var_0_0.onReceiveMarkPopShallowSettleReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 ~= 0 then
		return
	end
end

function var_0_0.sendMarkPopDeepSettleRequest(arg_26_0)
	local var_26_0 = WeekwalkModule_pb.MarkPopDeepSettleRequest()

	arg_26_0:sendMsg(var_26_0)
end

function var_0_0.onReceiveMarkPopDeepSettleReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 ~= 0 then
		return
	end
end

function var_0_0.sendChangeWeekwalkHeroGroupSelectRequest(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = WeekwalkModule_pb.ChangeWeekwalkHeroGroupSelectRequest()

	var_28_0.layerId = arg_28_1
	var_28_0.battleId = arg_28_2
	var_28_0.select = arg_28_3

	arg_28_0:sendMsg(var_28_0)
end

function var_0_0.onReceiveChangeWeekwalkHeroGroupSelectReply(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 ~= 0 then
		return
	end

	local var_29_0 = arg_29_2.layerId
	local var_29_1 = arg_29_2.battleId
	local var_29_2 = arg_29_2.select
	local var_29_3 = WeekWalkModel.instance:getBattleInfo(var_29_0, var_29_1)

	if var_29_3 then
		var_29_3.heroGroupSelect = var_29_2
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

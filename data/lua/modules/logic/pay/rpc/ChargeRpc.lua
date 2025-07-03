module("modules.logic.pay.rpc.ChargeRpc", package.seeall)

local var_0_0 = class("ChargeRpc", BaseRpc)

function var_0_0.sendGetChargeInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ChargeModule_pb.GetChargeInfoRequest()

	PayController.instance:getAllQueryProductDetails()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetChargeInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		PayModel.instance:setSandboxInfo(arg_2_2.sandboxEnable, arg_2_2.sandboxBalance)
		PayModel.instance:setChargeInfo(arg_2_2.infos)
		StoreModel.instance:initChargeInfo(arg_2_2.infos)
		PayController.instance:dispatchEvent(PayEvent.PayInfoChanged)
	end
end

function var_0_0.sendNewOrderRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ChargeModule_pb.NewOrderRequest()

	var_3_0.id = arg_3_1
	var_3_0.originCurrency = PayModel.instance:getProductOriginCurrency(arg_3_1)
	var_3_0.originAmount = PayModel.instance:getProductOriginAmount(arg_3_1)

	if arg_3_2 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			local var_3_1 = ChargeModule_pb.SelectionInfo()

			var_3_1.regionId = iter_3_0
			var_3_1.selectionPos = iter_3_1 - 1

			table.insert(var_3_0.selectionInfos, var_3_1)
		end
	end

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveNewOrderReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		PayModel.instance:setOrderInfo(arg_4_2)
		PayController.instance:dispatchEvent(PayEvent.GetSignSuccess)

		return
	end

	PayController.instance:dispatchEvent(PayEvent.GetSignFailed)
end

function var_0_0.onReceiveOrderCompletePush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		local var_5_0 = arg_5_2.id

		StoreModel.instance:chargeOrderComplete(var_5_0)
		arg_5_0:_tryUpdateMonthCard(arg_5_2)

		if StoreConfig.instance:getChargeGoodsConfig(var_5_0) then
			var_0_0.instance:sendGetChargeInfoRequest()
		end

		PayController.instance:dispatchEvent(PayEvent.PayFinished, arg_5_2.id)
	else
		PayController.instance:dispatchEvent(PayEvent.PayFailed)
	end
end

function var_0_0.sendGetMonthCardInfoRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ChargeModule_pb.GetMonthCardInfoRequest()

	return arg_6_0:sendMsg(var_6_0, arg_6_1, arg_6_2)
end

function var_0_0.onReceiveGetMonthCardInfoReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	StoreModel.instance:updateMonthCardInfo(arg_7_2.infos[1])
	StoreController.instance:dispatchEvent(StoreEvent.MonthCardInfoChanged)
end

function var_0_0.sendGetMonthCardBonusRequest(arg_8_0, arg_8_1)
	local var_8_0 = ChargeModule_pb.GetMonthCardBonusRequest()

	var_8_0.id = arg_8_1

	return arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveGetMonthCardBonusReply(arg_9_0, arg_9_1, arg_9_2)
	return
end

function var_0_0.sendSandboxChargeRequset(arg_10_0, arg_10_1)
	local var_10_0 = ChargeModule_pb.SandboxChargeRequset()

	var_10_0.gameOrderId = arg_10_1

	return arg_10_0:sendMsg(var_10_0)
end

function var_0_0.onReceiveSandboxChargeReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	PayModel.instance:updateSandboxBalance(arg_11_2.sandboxBalance)
end

function var_0_0.sendReadChargeNewRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = ChargeModule_pb.ReadChargeNewRequest()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		table.insert(var_12_0.goodsIds, iter_12_1)
	end

	return arg_12_0:sendMsg(var_12_0, arg_12_2, arg_12_3)
end

function var_0_0.onReceiveReadChargeNewReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		-- block empty
	end
end

function var_0_0._tryUpdateMonthCard(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.id
	local var_14_1 = StoreConfig.instance:getMonthCardConfig(var_14_0) and true or false

	if not var_14_1 and StoreConfig.instance:getChargeGoodsConfig(var_14_0) then
		var_14_1 = var_14_0 == StoreEnum.SeasonCardGoodsId
	end

	if not var_14_1 then
		return
	end

	SignInController.instance:sendGetSignInInfoRequestIfUnlock()
end

var_0_0.instance = var_0_0.New()

return var_0_0

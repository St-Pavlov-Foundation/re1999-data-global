module("modules.logic.chargepush.controller.ChargePushStatController", package.seeall)

local var_0_0 = class("ChargePushStatController")

function var_0_0.statShow(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	arg_1_0.config = arg_1_1

	local var_1_0 = arg_1_1.goodpushsId
	local var_1_1 = arg_1_1.className

	StatController.instance:track(StatEnum.EventName.ChargePushShow, {
		[StatEnum.EventProperties.ChargePushId] = var_1_0,
		[StatEnum.EventProperties.ChargePushType] = var_1_1
	})
end

function var_0_0.statClick(arg_2_0, arg_2_1)
	if not arg_2_0.config then
		return
	end

	if not ChargePushController.instance:isInPushViewShow() then
		return
	end

	local var_2_0 = arg_2_0.config.goodpushsId
	local var_2_1 = arg_2_0.config.className

	StatController.instance:track(StatEnum.EventName.ChargePushClick, {
		[StatEnum.EventProperties.ChargePushId] = var_2_0,
		[StatEnum.EventProperties.ChargePushType] = var_2_1,
		[StatEnum.EventProperties.ChargePushGoodsId] = arg_2_1
	})

	return true
end

function var_0_0.statBuyFinished(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.config then
		return
	end

	if not ChargePushController.instance:isInPushViewShow() then
		return
	end

	local var_3_0 = arg_3_2.goodsId
	local var_3_1 = arg_3_2.storeId
	local var_3_2 = arg_3_2.num
	local var_3_3 = StoreConfig.instance:getGoodsConfig(var_3_0)
	local var_3_4 = StoreController.instance:_itemsMultipleWithBuyCount(var_3_3.cost, var_3_2, 0)
	local var_3_5 = arg_3_1 == 0 and StatEnum.Result.Success or StatEnum.Result.Fail

	arg_3_0:statBuy(arg_3_0.config, var_3_0, var_3_4, var_3_5)
end

function var_0_0.statPayFinished(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.config then
		return
	end

	if not ChargePushController.instance:isInPushViewShow() then
		return
	end

	local var_4_0 = arg_4_2.id or arg_4_2.gameOrderId
	local var_4_1 = {}
	local var_4_2 = arg_4_1 == 0 and StatEnum.Result.Success or StatEnum.Result.Fail

	arg_4_0:statBuy(arg_4_0.config, var_4_0, var_4_1, var_4_2)
end

function var_0_0.statBuy(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if not arg_5_1 then
		return
	end

	local var_5_0 = arg_5_1.goodpushsId
	local var_5_1 = arg_5_1.className

	StatController.instance:track(StatEnum.EventName.ChargePushBuy, {
		[StatEnum.EventProperties.ChargePushId] = var_5_0,
		[StatEnum.EventProperties.ChargePushType] = var_5_1,
		[StatEnum.EventProperties.ChargePushGoodsId] = arg_5_2,
		[StatEnum.EventProperties.ChargePushCost] = arg_5_3,
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[arg_5_4]
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0

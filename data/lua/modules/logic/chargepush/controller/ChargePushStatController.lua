-- chunkname: @modules/logic/chargepush/controller/ChargePushStatController.lua

module("modules.logic.chargepush.controller.ChargePushStatController", package.seeall)

local ChargePushStatController = class("ChargePushStatController")

function ChargePushStatController:statShow(config)
	if not config then
		return
	end

	self.config = config

	local pushId = config.goodpushsId
	local pushType = config.className

	StatController.instance:track(StatEnum.EventName.ChargePushShow, {
		[StatEnum.EventProperties.ChargePushId] = pushId,
		[StatEnum.EventProperties.ChargePushType] = pushType
	})
end

function ChargePushStatController:statClick(goodsId)
	if not self.config then
		return
	end

	if not ChargePushController.instance:isInPushViewShow() then
		return
	end

	local pushId = self.config.goodpushsId
	local pushType = self.config.className

	StatController.instance:track(StatEnum.EventName.ChargePushClick, {
		[StatEnum.EventProperties.ChargePushId] = pushId,
		[StatEnum.EventProperties.ChargePushType] = pushType,
		[StatEnum.EventProperties.ChargePushGoodsId] = goodsId
	})

	return true
end

function ChargePushStatController:statBuyFinished(resultCode, info)
	if not self.config then
		return
	end

	if not ChargePushController.instance:isInPushViewShow() then
		return
	end

	local goodsId = info.goodsId
	local storeId = info.storeId
	local buyCount = info.num
	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)
	local cost = StoreController.instance:_itemsMultipleWithBuyCount(goodsConfig.cost, buyCount, 0)
	local result = resultCode == 0 and StatEnum.Result.Success or StatEnum.Result.Fail

	self:statBuy(self.config, goodsId, cost, result)
end

function ChargePushStatController:statPayFinished(resultCode, info)
	if not self.config then
		return
	end

	if not ChargePushController.instance:isInPushViewShow() then
		return
	end

	local goodsId = info.id or info.gameOrderId
	local cost = {}
	local result = resultCode == 0 and StatEnum.Result.Success or StatEnum.Result.Fail

	self:statBuy(self.config, goodsId, cost, result)
end

function ChargePushStatController:statBuy(config, goodsId, cost, result)
	if not config then
		return
	end

	local pushId = config.goodpushsId
	local pushType = config.className

	StatController.instance:track(StatEnum.EventName.ChargePushBuy, {
		[StatEnum.EventProperties.ChargePushId] = pushId,
		[StatEnum.EventProperties.ChargePushType] = pushType,
		[StatEnum.EventProperties.ChargePushGoodsId] = goodsId,
		[StatEnum.EventProperties.ChargePushCost] = cost,
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[result]
	})
end

ChargePushStatController.instance = ChargePushStatController.New()

return ChargePushStatController

module("modules.logic.store.model.StorePackageGoodsItemListModel", package.seeall)

local var_0_0 = class("StorePackageGoodsItemListModel", ListScrollModel)

function var_0_0.setMOList(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = {}
	local var_1_1 = {}

	arg_1_0._moList = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_2 or {}) do
		if iter_1_1.config.preGoodsId then
			var_1_1[iter_1_1.config.preGoodsId] = true
		end

		if arg_1_0:checkShow(iter_1_1, true) then
			table.insert(var_1_0, iter_1_1)
		end
	end

	if arg_1_1 then
		local var_1_2 = arg_1_1:getGoodsList()

		for iter_1_2, iter_1_3 in pairs(var_1_2) do
			if iter_1_3.config.preGoodsId then
				var_1_1[iter_1_3.config.preGoodsId] = true
			end

			if arg_1_0:checkShow(iter_1_3) then
				local var_1_3 = StorePackageGoodsMO.New()

				var_1_3:init(arg_1_1.id, iter_1_3.goodsId, iter_1_3.buyCount, iter_1_3.offlineTime)
				table.insert(var_1_0, var_1_3)
			end
		end
	end

	local var_1_4 = {}

	if arg_1_3 then
		for iter_1_4, iter_1_5 in ipairs(arg_1_3) do
			var_1_4[iter_1_5.goodsId] = true
		end
	end

	for iter_1_6, iter_1_7 in ipairs(var_1_0) do
		if not var_1_4[iter_1_7.goodsId] and (var_1_1[iter_1_7.goodsId] ~= true or (iter_1_7.buyLevel > 0 and iter_1_7:isSoldOut()) == false) then
			table.insert(arg_1_0._moList, iter_1_7)
		end
	end

	table.sort(arg_1_0._moList, arg_1_0._sortFunction)

	local var_1_5 = StoreModel.instance:getCurBuyPackageId()

	if #arg_1_0._moList == 0 and var_1_5 == nil then
		StoreController.instance:dispatchEvent(StoreEvent.CurPackageListEmpty)
	end

	StoreController.instance:dispatchEvent(StoreEvent.BeforeUpdatePackageStore)
	arg_1_0:setList(arg_1_0._moList)
	StoreController.instance:dispatchEvent(StoreEvent.AfterUpdatePackageStore)
end

function var_0_0.checkShow(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or false

	local var_2_0 = true

	if arg_2_1:isSoldOut() then
		if arg_2_2 and arg_2_1.refreshTime == StoreEnum.ChargeRefreshTime.Forever then
			var_2_0 = false
		end

		if arg_2_2 == false and arg_2_1.config.refreshTime == StoreEnum.RefreshTime.Forever then
			var_2_0 = false
		end
	end

	if arg_2_1.isChargeGoods == false then
		var_2_0 = var_2_0 and arg_2_0:checkPreGoodsId(arg_2_1.config.preGoodsId)
	end

	return var_2_0
end

function var_0_0.checkPreGoodsId(arg_3_0, arg_3_1)
	if arg_3_1 == 0 then
		return true
	end

	local var_3_0 = StoreModel.instance:getGoodsMO(arg_3_1)

	return var_3_0 and var_3_0:isSoldOut()
end

function var_0_0._sortFunction(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.config
	local var_4_1 = arg_4_1.config
	local var_4_2 = arg_4_0:isSoldOut()
	local var_4_3 = arg_4_1:isSoldOut()

	if var_4_2 ~= var_4_3 then
		return var_4_3
	end

	local var_4_4 = arg_4_0.goodsId == StoreEnum.MonthCardGoodsId
	local var_4_5 = arg_4_1.goodsId == StoreEnum.MonthCardGoodsId

	if var_4_4 ~= var_4_5 and StoreModel.instance:IsMonthCardDaysEnough() then
		return var_4_5
	end

	local var_4_6 = arg_4_0:isLevelOpen()

	if var_4_6 ~= arg_4_1:isLevelOpen() then
		return var_4_6
	end

	local var_4_7 = arg_4_0:checkPreGoodsSoldOut()

	if var_4_7 ~= arg_4_1:checkPreGoodsSoldOut() then
		return var_4_7
	end

	if var_4_0.order ~= var_4_1.order then
		return var_4_0.order < var_4_1.order
	end

	return var_4_0.id < var_4_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0

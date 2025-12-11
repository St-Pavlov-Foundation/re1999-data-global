module("modules.logic.store.model.StoreClothesGoodsItemListModel", package.seeall)

local var_0_0 = class("StoreClothesGoodsItemListModel", StoreNormalGoodsItemListModel)

function var_0_0.setMOList(arg_1_0, arg_1_1)
	arg_1_0._moList = {}

	if arg_1_1 then
		for iter_1_0, iter_1_1 in pairs(arg_1_1) do
			table.insert(arg_1_0._moList, iter_1_1)
		end

		if #arg_1_0._moList > 1 then
			table.sort(arg_1_0._moList, StoreNormalGoodsItemListModel._sortFunction)
		end
	end

	if next(arg_1_0._moList) then
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, false)
	else
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, true)
	end

	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0.findMOByProduct(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:getList()
	local var_2_1 = #var_2_0

	for iter_2_0 = 1, var_2_1 do
		local var_2_2 = var_2_0[iter_2_0]

		if var_2_2 and var_2_2:hasProduct(arg_2_1, arg_2_2) then
			return var_2_2
		end
	end

	return nil
end

function var_0_0.getGoodIndex(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getList()

	for iter_3_0 = 1, #var_3_0 do
		if var_3_0[iter_3_0].goodsId == arg_3_1 then
			return iter_3_0
		end
	end

	return 1
end

function var_0_0.initViewParam(arg_4_0)
	arg_4_0._isLive2d = false
	arg_4_0._selectIndex = nil
	arg_4_0.startTime = ServerTime.now()
end

function var_0_0.getSelectIndex(arg_5_0)
	return arg_5_0._selectIndex or 1
end

function var_0_0.getSelectGoods(arg_6_0)
	local var_6_0 = arg_6_0:getSelectIndex()

	return arg_6_0:getGoodsByIndex(var_6_0)
end

function var_0_0.getGoodsByIndex(arg_7_0, arg_7_1)
	return arg_7_0:getList()[arg_7_1]
end

function var_0_0.setSelectIndex(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getSelectIndex()

	if var_8_0 == arg_8_1 then
		return
	end

	local var_8_1 = ServerTime.now()

	if arg_8_0.startTime then
		local var_8_2 = arg_8_0:getGoodsByIndex(var_8_0)
		local var_8_3 = arg_8_0:getGoodsByIndex(arg_8_1)
		local var_8_4 = var_8_1 - arg_8_0.startTime

		StatController.instance:track(StatEnum.EventName.SkinStoreSwitchSkin, {
			[StatEnum.EventProperties.SkinStoreBeforeGoodsId] = var_8_2 and var_8_2.goodsId,
			[StatEnum.EventProperties.SkinStoreAfterGoodsId] = var_8_3 and var_8_3.goodsId,
			[StatEnum.EventProperties.SkinStoreBrowseTime] = var_8_4
		})
	end

	arg_8_0.startTime = var_8_1
	arg_8_0._selectIndex = arg_8_1

	StoreController.instance:dispatchEvent(StoreEvent.SkinPreviewChanged, arg_8_2)
end

function var_0_0.getIsLive2d(arg_9_0)
	return arg_9_0._isLive2d
end

function var_0_0.switchIsLive2d(arg_10_0)
	arg_10_0._isLive2d = not arg_10_0._isLive2d
end

function var_0_0.moveToNewGoods(arg_11_0)
	local var_11_0 = arg_11_0._scrollViews[1]

	if not var_11_0 then
		return
	end

	local var_11_1 = arg_11_0:findNewGoodsIndex()

	if not var_11_1 then
		return
	end

	var_11_0:moveToByIndex(var_11_1, 0.1)
end

function var_0_0.findNewGoodsIndex(arg_12_0)
	local var_12_0 = arg_12_0._scrollViews[1]

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0:getCsListScroll()
	local var_12_2 = arg_12_0:getList()
	local var_12_3
	local var_12_4 = false
	local var_12_5 = false

	for iter_12_0 = 1, #var_12_2 do
		local var_12_6 = var_12_2[iter_12_0]
		local var_12_7 = var_12_1:IsVisual(iter_12_0 - 1)

		if not var_12_4 and var_12_7 then
			var_12_4 = true
		end

		if var_12_4 and not var_12_7 and var_12_6:checkShowNewRedDot() then
			var_12_3 = iter_12_0

			break
		end
	end

	return var_12_3
end

function var_0_0.isEmpty(arg_13_0)
	return arg_13_0:getCount() == 0
end

var_0_0.instance = var_0_0.New()

return var_0_0

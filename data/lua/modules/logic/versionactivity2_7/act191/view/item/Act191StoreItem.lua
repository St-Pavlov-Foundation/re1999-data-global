module("modules.logic.versionactivity2_7.act191.view.item.Act191StoreItem", package.seeall)

local var_0_0 = class("Act191StoreItem", UserDataDispose)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = VersionActivity3_1Enum.ActivityId.DouQuQu3Store
	local var_1_1 = arg_1_0.maxBuyCount ~= 0 and arg_1_0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(var_1_0, arg_1_0.id) <= 0
	local var_1_2 = arg_1_1.maxBuyCount ~= 0 and arg_1_1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(var_1_0, arg_1_1.id) <= 0

	if var_1_1 ~= var_1_2 then
		return var_1_2
	end

	return arg_1_0.id < arg_1_1.id
end

function var_0_0.onInitView(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0.goStoreGoodsItem = gohelper.findChild(arg_2_0.go, "#go_storegoodsitem")

	gohelper.setActive(arg_2_0.goStoreGoodsItem, false)

	arg_2_0.goodsItemList = arg_2_0:getUserDataTb_()

	arg_2_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_2_0.onBuyGoodsSuccess, arg_2_0)
end

function var_0_0.onBuyGoodsSuccess(arg_3_0)
	arg_3_0:sortGoodsCoList()
	arg_3_0:refreshGoods()
end

function var_0_0.updateInfo(arg_4_0, arg_4_1, arg_4_2)
	gohelper.setActive(arg_4_0.go, true)

	arg_4_0.groupGoodsCoList = arg_4_2 or {}
	arg_4_0.groupId = arg_4_1

	arg_4_0:sortGoodsCoList()
	arg_4_0:refreshGoods()
end

function var_0_0.sortGoodsCoList(arg_5_0)
	table.sort(arg_5_0.groupGoodsCoList, var_0_1)
end

function var_0_0.refreshGoods(arg_6_0)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.groupGoodsCoList) do
		local var_6_1 = arg_6_0.goodsItemList[iter_6_0]

		if not var_6_1 then
			local var_6_2 = gohelper.cloneInPlace(arg_6_0.goStoreGoodsItem)

			var_6_1 = Act191StoreGoodsItem.New()

			var_6_1:onInitView(var_6_2)
			table.insert(arg_6_0.goodsItemList, var_6_1)
		end

		var_6_1:updateInfo(iter_6_1)
	end

	for iter_6_2 = #arg_6_0.groupGoodsCoList + 1, #arg_6_0.goodsItemList do
		arg_6_0.goodsItemList[iter_6_2]:hide()
	end
end

function var_0_0.onDestroy(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.goodsItemList) do
		iter_7_1:onDestroy()
	end

	arg_7_0:__onDispose()
end

return var_0_0

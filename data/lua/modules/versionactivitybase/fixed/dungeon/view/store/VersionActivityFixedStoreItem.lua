module("modules.versionactivitybase.fixed.dungeon.view.store.VersionActivityFixedStoreItem", package.seeall)

local var_0_0 = class("VersionActivityFixedStoreItem", UserDataDispose)
local var_0_1 = 424
local var_0_2 = 382.32
local var_0_3 = 300

local function var_0_4(arg_1_0, arg_1_1)
	local var_1_0 = VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.DungeonStore
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

	for iter_2_0 = 1, 3 do
		local var_2_0 = gohelper.findChild(arg_2_0.go, "tag" .. iter_2_0)

		gohelper.setActive(var_2_0, false)
	end

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
	arg_4_0:refreshTag()
	arg_4_0:refreshGoods()
end

function var_0_0.sortGoodsCoList(arg_5_0)
	table.sort(arg_5_0.groupGoodsCoList, var_0_4)
end

function var_0_0.refreshTag(arg_6_0)
	if arg_6_0.gotag then
		return
	end

	arg_6_0.gotag = gohelper.findChild(arg_6_0.go, "tag" .. arg_6_0.groupId)
	arg_6_0.tagCanvasGroup = arg_6_0.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_6_0.imageTagType = gohelper.findChildImage(arg_6_0.gotag, "image_tagType")
	arg_6_0.txtTagName = gohelper.findChildText(arg_6_0.gotag, "txt_tagName")

	gohelper.setActive(arg_6_0.gotag, true)

	arg_6_0.tagMaskList = arg_6_0:getUserDataTb_()

	table.insert(arg_6_0.tagMaskList, arg_6_0.imageTagType)
	table.insert(arg_6_0.tagMaskList, arg_6_0.txtTagName)
end

function var_0_0.refreshTagClip(arg_7_0, arg_7_1)
	if not arg_7_0.tagCanvasGroup then
		return
	end

	local var_7_0 = recthelper.rectToRelativeAnchorPos(arg_7_0.gotag.transform.position, arg_7_1.transform)
	local var_7_1 = Mathf.Clamp((var_0_1 - var_7_0.y) / (var_0_1 - var_0_2), 0, 1)

	arg_7_0.tagCanvasGroup.alpha = var_7_1

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.tagMaskList) do
		iter_7_1.maskable = var_7_0.y <= var_0_3
	end
end

function var_0_0.refreshGoods(arg_8_0)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.groupGoodsCoList) do
		local var_8_1 = arg_8_0.goodsItemList[iter_8_0]

		if not var_8_1 then
			local var_8_2 = gohelper.cloneInPlace(arg_8_0.goStoreGoodsItem)

			var_8_1 = VersionActivityFixedHelper.getVersionActivityStoreGoodsItem().New()

			var_8_1:onInitView(var_8_2)
			table.insert(arg_8_0.goodsItemList, var_8_1)
		end

		var_8_1:updateInfo(iter_8_1)
	end

	for iter_8_2 = #arg_8_0.groupGoodsCoList + 1, #arg_8_0.goodsItemList do
		arg_8_0.goodsItemList[iter_8_2]:hide()
	end
end

function var_0_0.getHeight(arg_9_0)
	return recthelper.getHeight(arg_9_0.go.transform)
end

function var_0_0.onDestroy(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.goodsItemList) do
		iter_10_1:onDestroy()
	end

	arg_10_0:__onDispose()
end

return var_0_0

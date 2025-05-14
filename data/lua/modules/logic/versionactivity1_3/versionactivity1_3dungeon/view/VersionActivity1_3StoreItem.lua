module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3StoreItem", package.seeall)

local var_0_0 = class("VersionActivity1_3StoreItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.goStoreGoodsItem = gohelper.findChild(arg_1_0.go, "#go_storegoodsitem")

	gohelper.setActive(arg_1_0.goStoreGoodsItem, false)

	arg_1_0.goodsItemList = arg_1_0:getUserDataTb_()
	arg_1_0._clipPosY = 424
	arg_1_0._startFadePosY = 382.32
	arg_1_0._showTagPosY = 300

	arg_1_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_1_0.onBuyGoodsSuccess, arg_1_0)
end

function var_0_0.onBuyGoodsSuccess(arg_2_0)
	arg_2_0:sortGoodsCoList()
	arg_2_0:refreshGoods()
end

function var_0_0.sortGoodsCoList(arg_3_0)
	table.sort(arg_3_0.groupGoodsCoList, var_0_0.sortGoods)
end

function var_0_0.updateInfo(arg_4_0, arg_4_1, arg_4_2)
	gohelper.setActive(arg_4_0.go, true)

	arg_4_0.groupGoodsCoList = arg_4_2
	arg_4_0.groupId = arg_4_1

	arg_4_0:sortGoodsCoList()
	arg_4_0:_initTag()
	arg_4_0:refreshGoods()
end

function var_0_0._initTag(arg_5_0)
	if arg_5_0.gotag then
		return
	end

	arg_5_0.gotag = gohelper.findChild(arg_5_0.go, "tag" .. arg_5_0.groupId)

	gohelper.setActive(arg_5_0.gotag, true)

	arg_5_0.canvasGroup = arg_5_0.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_5_0.imageTagType = gohelper.findChildImage(arg_5_0.gotag, "image_tagType")
	arg_5_0.txtTagName1 = gohelper.findChildText(arg_5_0.gotag, "txt_tagName1")
	arg_5_0.txtTagName2 = gohelper.findChildText(arg_5_0.gotag, "txt_tagName2")
	arg_5_0.tagName = luaLang("versionactivity1_3_store_tag_" .. arg_5_0.groupId)
	arg_5_0.txtTagName1.text = arg_5_0.tagName
	arg_5_0.tagMaskList = arg_5_0:getUserDataTb_()

	table.insert(arg_5_0.tagMaskList, arg_5_0.imageTagType)
	table.insert(arg_5_0.tagMaskList, arg_5_0.txtTagName1)
	table.insert(arg_5_0.tagMaskList, arg_5_0.txtTagName2)
end

function var_0_0.refreshTag(arg_6_0)
	arg_6_0.tagName = luaLang("versionactivity1_3_store_tag_" .. arg_6_0.groupId)

	UISpriteSetMgr.instance:setV1a3StoreSprite(arg_6_0.imageTagType, "v1a3_store_smalltitlebg_" .. arg_6_0.groupId)

	arg_6_0.firstName = GameUtil.utf8sub(arg_6_0.tagName, 1, 1)
	arg_6_0.remainName = ""

	local var_6_0 = GameUtil.utf8len(arg_6_0.tagName)

	if var_6_0 > 1 then
		arg_6_0.remainName = GameUtil.utf8sub(arg_6_0.tagName, 2, var_6_0 - 1)
	end

	arg_6_0.txtTagFirstName.text = arg_6_0.firstName
	arg_6_0.txtTagRemainName.text = arg_6_0.remainName
end

function var_0_0.refreshGoods(arg_7_0)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.groupGoodsCoList) do
		local var_7_1 = arg_7_0.goodsItemList[iter_7_0]

		if not var_7_1 then
			var_7_1 = VersionActivity1_3StoreGoodsItem.New()

			var_7_1:onInitView(gohelper.cloneInPlace(arg_7_0.goStoreGoodsItem))
			table.insert(arg_7_0.goodsItemList, var_7_1)
		end

		var_7_1:updateInfo(iter_7_1)
	end

	for iter_7_2 = #arg_7_0.groupGoodsCoList + 1, #arg_7_0.goodsItemList do
		arg_7_0.goodsItemList[iter_7_2]:hide()
	end
end

function var_0_0.refreshTagClip(arg_8_0, arg_8_1)
	if not arg_8_0.canvasGroup then
		return
	end

	local var_8_0 = recthelper.rectToRelativeAnchorPos(arg_8_0.gotag.transform.position, arg_8_1.transform)
	local var_8_1 = Mathf.Clamp((arg_8_0._clipPosY - var_8_0.y) / (arg_8_0._clipPosY - arg_8_0._startFadePosY), 0, 1)

	arg_8_0.canvasGroup.alpha = var_8_1

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tagMaskList) do
		iter_8_1.maskable = var_8_0.y <= arg_8_0._showTagPosY
	end
end

function var_0_0.sortGoods(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.maxBuyCount ~= 0 and arg_9_0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_3Enum.ActivityId.DungeonStore, arg_9_0.id) <= 0

	if var_9_0 ~= (arg_9_1.maxBuyCount ~= 0 and arg_9_1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_3Enum.ActivityId.DungeonStore, arg_9_1.id) <= 0) then
		if var_9_0 then
			return false
		end

		return true
	end

	return arg_9_0.id < arg_9_1.id
end

function var_0_0.onDestroy(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.goodsItemList) do
		iter_10_1:onDestroy()
	end

	arg_10_0:__onDispose()
end

return var_0_0

module("modules.logic.versionactivity.view.VersionActivityStoreItem", package.seeall)

local var_0_0 = class("VersionActivityStoreItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.gotag = gohelper.findChild(arg_1_0.go, "tag")
	arg_1_0.canvasGroup = arg_1_0.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0.imageTagType = gohelper.findChildImage(arg_1_0.go, "tag/image_tagType")
	arg_1_0.txtTagFirstName = gohelper.findChildText(arg_1_0.go, "tag/image_tagType/txt_tagNameFirst")
	arg_1_0.txtTagRemainName = gohelper.findChildText(arg_1_0.go, "tag/image_tagType/txt_tagNameRemain")
	arg_1_0.goStoreGoodsItem = gohelper.findChild(arg_1_0.go, "#go_storegoodsitem")

	gohelper.setActive(arg_1_0.goStoreGoodsItem, false)

	arg_1_0.goodsItemList = arg_1_0:getUserDataTb_()
	arg_1_0.tagMaskList = arg_1_0:getUserDataTb_()

	table.insert(arg_1_0.tagMaskList, arg_1_0.imageTagType)
	table.insert(arg_1_0.tagMaskList, arg_1_0.txtTagFirstName)
	table.insert(arg_1_0.tagMaskList, arg_1_0.txtTagRemainName)

	arg_1_0._clipPosY = 424
	arg_1_0._startFadePosY = 382.32
	arg_1_0._showTagPosY = 300

	arg_1_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_1_0.onBuyGoodsSuccess, arg_1_0)

	arg_1_0._contentHorizontal = arg_1_0.imageTagType.gameObject:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_1_0._adjustcontent = gohelper.findChild(arg_1_0.go, "tag/langadjust")
	arg_1_0._contentHorizontal.padding.left = arg_1_0._adjustcontent.transform.localPosition.x
	arg_1_0._contentHorizontal.padding.top = arg_1_0._adjustcontent.transform.localPosition.y
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
	arg_4_0:refreshTag()
	arg_4_0:refreshGoods()
end

function var_0_0.refreshTag(arg_5_0)
	arg_5_0.tagName = luaLang("versionactivity_store_tag_" .. arg_5_0.groupId)

	UISpriteSetMgr.instance:setVersionActivitySprite(arg_5_0.imageTagType, "img_title_label_" .. arg_5_0.groupId)

	arg_5_0.firstName = GameUtil.utf8sub(arg_5_0.tagName, 1, 1)
	arg_5_0.remainName = ""

	local var_5_0 = GameUtil.utf8len(arg_5_0.tagName)

	if var_5_0 > 1 then
		arg_5_0.remainName = GameUtil.utf8sub(arg_5_0.tagName, 2, var_5_0 - 1)
	end

	arg_5_0.txtTagFirstName.text = arg_5_0.firstName
	arg_5_0.txtTagRemainName.text = arg_5_0.remainName
end

function var_0_0.refreshGoods(arg_6_0)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.groupGoodsCoList) do
		local var_6_1 = arg_6_0.goodsItemList[iter_6_0]

		if not var_6_1 then
			var_6_1 = VersionActivityStoreGoodsItem.New()

			var_6_1:onInitView(gohelper.cloneInPlace(arg_6_0.goStoreGoodsItem))
			table.insert(arg_6_0.goodsItemList, var_6_1)
		end

		var_6_1:updateInfo(iter_6_1)
	end

	for iter_6_2 = #arg_6_0.groupGoodsCoList + 1, #arg_6_0.goodsItemList do
		arg_6_0.goodsItemList[iter_6_2]:hide()
	end
end

function var_0_0.refreshTagClip(arg_7_0, arg_7_1)
	local var_7_0 = recthelper.rectToRelativeAnchorPos(arg_7_0.gotag.transform.position, arg_7_1.transform)
	local var_7_1 = Mathf.Clamp((arg_7_0._clipPosY - var_7_0.y) / (arg_7_0._clipPosY - arg_7_0._startFadePosY), 0, 1)

	arg_7_0.canvasGroup.alpha = var_7_1

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.tagMaskList) do
		iter_7_1.maskable = var_7_0.y <= arg_7_0._showTagPosY
	end
end

function var_0_0.sortGoods(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.maxBuyCount ~= 0 and arg_8_0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivityEnum.ActivityId.Act107, arg_8_0.id) <= 0

	if var_8_0 ~= (arg_8_1.maxBuyCount ~= 0 and arg_8_1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivityEnum.ActivityId.Act107, arg_8_1.id) <= 0) then
		if var_8_0 then
			return false
		end

		return true
	end

	return arg_8_0.id < arg_8_1.id
end

function var_0_0.onDestroy(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.goodsItemList) do
		iter_9_1:onDestroy()
	end

	arg_9_0:__onDispose()
end

return var_0_0

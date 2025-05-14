module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreItem", package.seeall)

local var_0_0 = class("VersionActivity1_2StoreItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.gotag = gohelper.findChild(arg_1_0.go, "tag")
	arg_1_0.canvasGroup = arg_1_0.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0.imageTagType = gohelper.findChildImage(arg_1_0.go, "tag/image_tagType")
	arg_1_0.imageframebg = gohelper.findChildImage(arg_1_0.go, "image_framebg")
	arg_1_0.imageframeicon = gohelper.findChildImage(arg_1_0.go, "image_framebg/image_frameicon")
	arg_1_0.simagespecialframebg = gohelper.findChildSingleImage(arg_1_0.go, "image_framebg/simage_specialframebg")
	arg_1_0.txtTagName = gohelper.findChildText(arg_1_0.go, "tag/image_tagType/txt_tagName")
	arg_1_0.txtTagNameSpecial = gohelper.findChildText(arg_1_0.go, "tag/image_tagType/txt_tagNameSpecial")
	arg_1_0.goStoreGoodsItem = gohelper.findChild(arg_1_0.go, "#go_storegoodsitem")

	gohelper.setActive(arg_1_0.goStoreGoodsItem, false)

	arg_1_0.goodsItemList = {}
	arg_1_0.tagMaskList = arg_1_0:getUserDataTb_()

	table.insert(arg_1_0.tagMaskList, arg_1_0.imageTagType)
	table.insert(arg_1_0.tagMaskList, arg_1_0.txtTagName)

	arg_1_0._clipPosY = 437
	arg_1_0._startFadePosY = 382.32
	arg_1_0._showTagPosY = 300
	arg_1_0._groupTxtColors = {
		"#884315",
		"#f2cf6d",
		"#98d999"
	}
	arg_1_0._groupTagColors = {
		"#884315",
		"#4c3a15",
		"#304032"
	}
	arg_1_0._specialFrameWidth = 1246
	arg_1_0._normalFrameWidth = 452

	arg_1_0.simagespecialframebg:LoadImage(ResUrl.getVersionTradeBargainBg("framebg"))
	arg_1_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_1_0.onBuyGoodsSuccess, arg_1_0)
end

function var_0_0.onBuyGoodsSuccess(arg_2_0)
	arg_2_0:sortGoodsCoList()
	arg_2_0:refreshGoods()
end

function var_0_0.sortGoodsCoList(arg_3_0)
	table.sort(arg_3_0.groupGoodsCoList, arg_3_0.sortGoods)
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
	arg_5_0.tagName = luaLang("versionactivity_store_1_2_tag_" .. arg_5_0.groupId)

	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(arg_5_0.imageframeicon, "bg_quyudi_" .. arg_5_0.groupId)
	recthelper.setWidth(arg_5_0.imageframeicon.transform, arg_5_0.groupId == 1 and arg_5_0._specialFrameWidth or arg_5_0._normalFrameWidth)

	local var_5_0 = utf8.next_raw(arg_5_0.tagName, 1)

	arg_5_0.firstName = arg_5_0.tagName:sub(1, var_5_0 - 1)
	arg_5_0.remainName = arg_5_0.tagName:sub(var_5_0)

	gohelper.setActive(arg_5_0.txtTagNameSpecial, arg_5_0.groupId == 1)
	gohelper.setActive(arg_5_0.txtTagName, arg_5_0.groupId ~= 1)
	gohelper.setActive(arg_5_0.simagespecialframebg.gameObject, arg_5_0.groupId == 1)

	arg_5_0.txtTagName.text = string.format("<size=50>%s</size>%s", arg_5_0.firstName, arg_5_0.remainName)
	arg_5_0.txtTagNameSpecial.text = string.format("<size=50>%s</size>%s", arg_5_0.firstName, arg_5_0.remainName)

	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0.imageTagType, arg_5_0._groupTagColors[arg_5_0.groupId])
	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0.imageframebg, arg_5_0.groupId == 1 and "#88431566" or "#FFFFFF38")
	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0.txtTagName, arg_5_0._groupTxtColors[arg_5_0.groupId])
end

function var_0_0.refreshGoods(arg_6_0)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.groupGoodsCoList) do
		local var_6_1 = arg_6_0.goodsItemList[iter_6_0]

		if not var_6_1 then
			var_6_1 = VersionActivity1_2StoreGoodsItem.New()

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

function var_0_0.getHeight(arg_8_0)
	return recthelper.getHeight(arg_8_0.go.transform)
end

function var_0_0.sortGoods(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.maxBuyCount ~= 0 and arg_9_0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, arg_9_0.id) <= 0

	if var_9_0 ~= (arg_9_1.maxBuyCount ~= 0 and arg_9_1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, arg_9_1.id) <= 0) then
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

	arg_10_0.goodsItemList = nil
	arg_10_0.tagMaskList = nil

	arg_10_0.simagespecialframebg:UnLoadImage()
	arg_10_0:__onDispose()
end

return var_0_0

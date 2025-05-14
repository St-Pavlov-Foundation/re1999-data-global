module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreItem", package.seeall)

local var_0_0 = class("V1a6_BossRush_StoreItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.goStoreGoodsItem = gohelper.findChild(arg_1_0.go, "#go_storegoodsitem")
	arg_1_0._btnTips = gohelper.findChildButtonWithAudio(arg_1_0.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#btn_Tips")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips")
	arg_1_0._txtTimeTips = gohelper.findChildText(arg_1_0.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/image_Tips/#txt_TimeTips")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/#btn_closetip")

	gohelper.setActive(arg_1_0.goStoreGoodsItem, false)

	arg_1_0.goodsItemList = arg_1_0:getUserDataTb_()
	arg_1_0._clipPosY = 424
	arg_1_0._startFadePosY = 382.32
	arg_1_0._showTagPosY = 300

	arg_1_0._btnTips:AddClickListener(arg_1_0._btnTipsOnClick, arg_1_0)
	arg_1_0._btnclosetip:AddClickListener(arg_1_0._btnclosetipOnClick, arg_1_0)
	gohelper.setActive(arg_1_0._goTips, false)
end

function var_0_0._btnclosetipOnClick(arg_2_0)
	gohelper.setActive(arg_2_0._goTips, false)
end

function var_0_0._btnTipsOnClick(arg_3_0)
	gohelper.setActive(arg_3_0._goTips, true)
end

function var_0_0._updateInfo(arg_4_0)
	arg_4_0:sortGoodsMoList()
	arg_4_0:refreshGoods()
end

function var_0_0.sortGoodsMoList(arg_5_0)
	if arg_5_0.groupGoodsMoList then
		table.sort(arg_5_0.groupGoodsMoList:getGoodsList(), var_0_0.sortGoods)
	end
end

function var_0_0.updateInfo(arg_6_0, arg_6_1, arg_6_2)
	gohelper.setActive(arg_6_0.go, true)

	arg_6_0.groupGoodsMoList = arg_6_2
	arg_6_0.groupId = arg_6_1

	arg_6_0:sortGoodsMoList()
	arg_6_0:refreshTag()
	arg_6_0:refreshGoods()
	arg_6_0:_updateInfo()

	local var_6_0 = next(arg_6_0.groupGoodsMoList:getGoodsList()) == nil

	gohelper.setActive(arg_6_0.gotag, not var_6_0)
end

function var_0_0.refreshTag(arg_7_0)
	arg_7_0.gotag = gohelper.findChild(arg_7_0.go, "tag" .. arg_7_0.groupId)
	arg_7_0.canvasGroup = arg_7_0.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_7_0.imageTagType = gohelper.findChildImage(arg_7_0.gotag, "image_tagType")
	arg_7_0.txtTagName = gohelper.findChildText(arg_7_0.gotag, "txt_tagName")

	gohelper.setActive(arg_7_0.gotag, true)

	local var_7_0 = V1a6_BossRush_StoreModel.instance:getStore()
	local var_7_1, var_7_2 = V1a6_BossRush_StoreModel.instance:getStoreGroupName(var_7_0[arg_7_0.groupId])

	arg_7_0.txtTagName.text = var_7_1
	arg_7_0.tagMaskList = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0.tagMaskList, arg_7_0.imageTagType)
	table.insert(arg_7_0.tagMaskList, arg_7_0.txtTagName)
end

function var_0_0.refreshGoods(arg_8_0)
	if not arg_8_0.groupGoodsMoList then
		return
	end

	local var_8_0 = arg_8_0.groupGoodsMoList:getGoodsList()

	if not var_8_0 then
		return
	end

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		local var_8_1 = arg_8_0.goodsItemList[iter_8_0]

		if not var_8_1 then
			var_8_1 = V1a6_BossRush_StoreGoodsItem.New()

			local var_8_2 = gohelper.cloneInPlace(arg_8_0.goStoreGoodsItem)

			var_8_1:onInitView(var_8_2)
			table.insert(arg_8_0.goodsItemList, var_8_1)
		end

		var_8_1:updateInfo(iter_8_1)

		local var_8_3 = V1a6_BossRush_StoreModel.instance:getStoreGoodsNewData(arg_8_0.groupGoodsMoList.id, iter_8_1.goodsId)

		var_8_1:updateNewData(var_8_3)
	end

	gohelper.setAsLastSibling(arg_8_0.gotag.gameObject)

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.goodsItemList do
		arg_8_0.goodsItemList[iter_8_2]:hide()
	end
end

function var_0_0.refreshTagClip(arg_9_0, arg_9_1)
	if not arg_9_0.canvasGroup then
		return
	end

	local var_9_0 = recthelper.rectToRelativeAnchorPos(arg_9_0.gotag.transform.position, arg_9_1.transform)
	local var_9_1 = Mathf.Clamp((arg_9_0._clipPosY - var_9_0.y) / (arg_9_0._clipPosY - arg_9_0._startFadePosY), 0, 1)

	arg_9_0.canvasGroup.alpha = var_9_1

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.tagMaskList) do
		iter_9_1.maskable = var_9_0.y <= arg_9_0._showTagPosY
	end
end

function var_0_0.sortGoods(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.config
	local var_10_1 = arg_10_1.config
	local var_10_2 = arg_10_0:isSoldOut()

	if var_10_2 ~= arg_10_1:isSoldOut() then
		if var_10_2 then
			return false
		end

		return true
	end

	if var_10_0.order ~= var_10_1.order then
		return var_10_0.order < var_10_1.order
	end

	return var_10_0.id < var_10_1.id
end

function var_0_0.getHeight(arg_11_0)
	ZProj.UGUIHelper.RebuildLayout(arg_11_0.go.transform)

	return (recthelper.getHeight(arg_11_0.go.transform))
end

function var_0_0.onDestroy(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.goodsItemList) do
		iter_12_1:onDestroy()
	end

	arg_12_0:__onDispose()
end

function var_0_0.onClose(arg_13_0)
	arg_13_0._btnTips:RemoveClickListener()
	arg_13_0._btnclosetip:RemoveClickListener()
end

return var_0_0

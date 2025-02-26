module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreItem", package.seeall)

slot0 = class("V1a6_BossRush_StoreItem", UserDataDispose)

function slot0.onInitView(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.goStoreGoodsItem = gohelper.findChild(slot0.go, "#go_storegoodsitem")
	slot0._btnTips = gohelper.findChildButtonWithAudio(slot0.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#btn_Tips")
	slot0._goTips = gohelper.findChild(slot0.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips")
	slot0._txtTimeTips = gohelper.findChildText(slot0.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/image_Tips/#txt_TimeTips")
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.go, "tag2/#go_Time/image_TipsBG/#txt_Time/#go_Tips/#btn_closetip")

	gohelper.setActive(slot0.goStoreGoodsItem, false)

	slot0.goodsItemList = slot0:getUserDataTb_()
	slot0._clipPosY = 424
	slot0._startFadePosY = 382.32
	slot0._showTagPosY = 300

	slot0._btnTips:AddClickListener(slot0._btnTipsOnClick, slot0)
	slot0._btnclosetip:AddClickListener(slot0._btnclosetipOnClick, slot0)
	gohelper.setActive(slot0._goTips, false)
end

function slot0._btnclosetipOnClick(slot0)
	gohelper.setActive(slot0._goTips, false)
end

function slot0._btnTipsOnClick(slot0)
	gohelper.setActive(slot0._goTips, true)
end

function slot0._updateInfo(slot0)
	slot0:sortGoodsMoList()
	slot0:refreshGoods()
end

function slot0.sortGoodsMoList(slot0)
	if slot0.groupGoodsMoList then
		table.sort(slot0.groupGoodsMoList:getGoodsList(), uv0.sortGoods)
	end
end

function slot0.updateInfo(slot0, slot1, slot2)
	gohelper.setActive(slot0.go, true)

	slot0.groupGoodsMoList = slot2
	slot0.groupId = slot1

	slot0:sortGoodsMoList()
	slot0:refreshTag()
	slot0:refreshGoods()
	slot0:_updateInfo()
	gohelper.setActive(slot0.gotag, not (next(slot0.groupGoodsMoList:getGoodsList()) == nil))
end

function slot0.refreshTag(slot0)
	slot0.gotag = gohelper.findChild(slot0.go, "tag" .. slot0.groupId)
	slot0.canvasGroup = slot0.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.imageTagType = gohelper.findChildImage(slot0.gotag, "image_tagType")
	slot0.txtTagName = gohelper.findChildText(slot0.gotag, "txt_tagName")

	gohelper.setActive(slot0.gotag, true)

	slot0.txtTagName.text, slot3 = V1a6_BossRush_StoreModel.instance:getStoreGroupName(V1a6_BossRush_StoreModel.instance:getStore()[slot0.groupId])
	slot0.tagMaskList = slot0:getUserDataTb_()

	table.insert(slot0.tagMaskList, slot0.imageTagType)
	table.insert(slot0.tagMaskList, slot0.txtTagName)
end

function slot0.refreshGoods(slot0)
	if not slot0.groupGoodsMoList then
		return
	end

	if not slot0.groupGoodsMoList:getGoodsList() then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		if not slot0.goodsItemList[slot5] then
			slot7 = V1a6_BossRush_StoreGoodsItem.New()

			slot7:onInitView(gohelper.cloneInPlace(slot0.goStoreGoodsItem))
			table.insert(slot0.goodsItemList, slot7)
		end

		slot7:updateInfo(slot6)
		slot7:updateNewData(V1a6_BossRush_StoreModel.instance:getStoreGoodsNewData(slot0.groupGoodsMoList.id, slot6.goodsId))
	end

	gohelper.setAsLastSibling(slot0.gotag.gameObject)

	for slot5 = #slot1 + 1, #slot0.goodsItemList do
		slot0.goodsItemList[slot5]:hide()
	end
end

function slot0.refreshTagClip(slot0, slot1)
	if not slot0.canvasGroup then
		return
	end

	slot0.canvasGroup.alpha = Mathf.Clamp((slot0._clipPosY - recthelper.rectToRelativeAnchorPos(slot0.gotag.transform.position, slot1.transform).y) / (slot0._clipPosY - slot0._startFadePosY), 0, 1)

	for slot7, slot8 in ipairs(slot0.tagMaskList) do
		slot8.maskable = slot2.y <= slot0._showTagPosY
	end
end

function slot0.sortGoods(slot0, slot1)
	slot2 = slot0.config
	slot3 = slot1.config

	if slot0:isSoldOut() ~= slot1:isSoldOut() then
		if slot4 then
			return false
		end

		return true
	end

	if slot2.order ~= slot3.order then
		return slot2.order < slot3.order
	end

	return slot2.id < slot3.id
end

function slot0.getHeight(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0.go.transform)

	return recthelper.getHeight(slot0.go.transform)
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in ipairs(slot0.goodsItemList) do
		slot5:onDestroy()
	end

	slot0:__onDispose()
end

function slot0.onClose(slot0)
	slot0._btnTips:RemoveClickListener()
	slot0._btnclosetip:RemoveClickListener()
end

return slot0

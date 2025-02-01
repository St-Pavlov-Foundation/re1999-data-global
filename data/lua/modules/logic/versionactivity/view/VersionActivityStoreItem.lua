module("modules.logic.versionactivity.view.VersionActivityStoreItem", package.seeall)

slot0 = class("VersionActivityStoreItem", UserDataDispose)

function slot0.onInitView(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.gotag = gohelper.findChild(slot0.go, "tag")
	slot0.canvasGroup = slot0.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.imageTagType = gohelper.findChildImage(slot0.go, "tag/image_tagType")
	slot0.txtTagFirstName = gohelper.findChildText(slot0.go, "tag/image_tagType/txt_tagNameFirst")
	slot0.txtTagRemainName = gohelper.findChildText(slot0.go, "tag/image_tagType/txt_tagNameRemain")
	slot0.goStoreGoodsItem = gohelper.findChild(slot0.go, "#go_storegoodsitem")

	gohelper.setActive(slot0.goStoreGoodsItem, false)

	slot0.goodsItemList = slot0:getUserDataTb_()
	slot0.tagMaskList = slot0:getUserDataTb_()

	table.insert(slot0.tagMaskList, slot0.imageTagType)
	table.insert(slot0.tagMaskList, slot0.txtTagFirstName)
	table.insert(slot0.tagMaskList, slot0.txtTagRemainName)

	slot0._clipPosY = 424
	slot0._startFadePosY = 382.32
	slot0._showTagPosY = 300

	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0.onBuyGoodsSuccess, slot0)

	slot0._contentHorizontal = slot0.imageTagType.gameObject:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	slot0._adjustcontent = gohelper.findChild(slot0.go, "tag/langadjust")
	slot0._contentHorizontal.padding.left = slot0._adjustcontent.transform.localPosition.x
	slot0._contentHorizontal.padding.top = slot0._adjustcontent.transform.localPosition.y
end

function slot0.onBuyGoodsSuccess(slot0)
	slot0:sortGoodsCoList()
	slot0:refreshGoods()
end

function slot0.sortGoodsCoList(slot0)
	table.sort(slot0.groupGoodsCoList, uv0.sortGoods)
end

function slot0.updateInfo(slot0, slot1, slot2)
	gohelper.setActive(slot0.go, true)

	slot0.groupGoodsCoList = slot2
	slot0.groupId = slot1

	slot0:sortGoodsCoList()
	slot0:refreshTag()
	slot0:refreshGoods()
end

function slot0.refreshTag(slot0)
	slot0.tagName = luaLang("versionactivity_store_tag_" .. slot0.groupId)

	UISpriteSetMgr.instance:setVersionActivitySprite(slot0.imageTagType, "img_title_label_" .. slot0.groupId)

	slot0.firstName = GameUtil.utf8sub(slot0.tagName, 1, 1)
	slot0.remainName = ""

	if GameUtil.utf8len(slot0.tagName) > 1 then
		slot0.remainName = GameUtil.utf8sub(slot0.tagName, 2, slot1 - 1)
	end

	slot0.txtTagFirstName.text = slot0.firstName
	slot0.txtTagRemainName.text = slot0.remainName
end

function slot0.refreshGoods(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.groupGoodsCoList) do
		if not slot0.goodsItemList[slot5] then
			slot1 = VersionActivityStoreGoodsItem.New()

			slot1:onInitView(gohelper.cloneInPlace(slot0.goStoreGoodsItem))
			table.insert(slot0.goodsItemList, slot1)
		end

		slot1:updateInfo(slot6)
	end

	for slot5 = #slot0.groupGoodsCoList + 1, #slot0.goodsItemList do
		slot0.goodsItemList[slot5]:hide()
	end
end

function slot0.refreshTagClip(slot0, slot1)
	slot0.canvasGroup.alpha = Mathf.Clamp((slot0._clipPosY - recthelper.rectToRelativeAnchorPos(slot0.gotag.transform.position, slot1.transform).y) / (slot0._clipPosY - slot0._startFadePosY), 0, 1)

	for slot7, slot8 in ipairs(slot0.tagMaskList) do
		slot8.maskable = slot2.y <= slot0._showTagPosY
	end
end

function slot0.sortGoods(slot0, slot1)
	if (slot0.maxBuyCount ~= 0 and slot0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivityEnum.ActivityId.Act107, slot0.id) <= 0) ~= (slot1.maxBuyCount ~= 0 and slot1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivityEnum.ActivityId.Act107, slot1.id) <= 0) then
		if slot2 then
			return false
		end

		return true
	end

	return slot0.id < slot1.id
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in ipairs(slot0.goodsItemList) do
		slot5:onDestroy()
	end

	slot0:__onDispose()
end

return slot0

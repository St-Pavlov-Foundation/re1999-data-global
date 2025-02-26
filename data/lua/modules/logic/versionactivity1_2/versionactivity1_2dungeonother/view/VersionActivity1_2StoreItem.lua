module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreItem", package.seeall)

slot0 = class("VersionActivity1_2StoreItem", UserDataDispose)

function slot0.onInitView(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.gotag = gohelper.findChild(slot0.go, "tag")
	slot0.canvasGroup = slot0.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.imageTagType = gohelper.findChildImage(slot0.go, "tag/image_tagType")
	slot0.imageframebg = gohelper.findChildImage(slot0.go, "image_framebg")
	slot0.imageframeicon = gohelper.findChildImage(slot0.go, "image_framebg/image_frameicon")
	slot0.simagespecialframebg = gohelper.findChildSingleImage(slot0.go, "image_framebg/simage_specialframebg")
	slot0.txtTagName = gohelper.findChildText(slot0.go, "tag/image_tagType/txt_tagName")
	slot0.txtTagNameSpecial = gohelper.findChildText(slot0.go, "tag/image_tagType/txt_tagNameSpecial")
	slot0.goStoreGoodsItem = gohelper.findChild(slot0.go, "#go_storegoodsitem")

	gohelper.setActive(slot0.goStoreGoodsItem, false)

	slot0.goodsItemList = {}
	slot0.tagMaskList = slot0:getUserDataTb_()

	table.insert(slot0.tagMaskList, slot0.imageTagType)
	table.insert(slot0.tagMaskList, slot0.txtTagName)

	slot0._clipPosY = 437
	slot0._startFadePosY = 382.32
	slot0._showTagPosY = 300
	slot0._groupTxtColors = {
		"#884315",
		"#f2cf6d",
		"#98d999"
	}
	slot0._groupTagColors = {
		"#884315",
		"#4c3a15",
		"#304032"
	}
	slot0._specialFrameWidth = 1246
	slot0._normalFrameWidth = 452

	slot0.simagespecialframebg:LoadImage(ResUrl.getVersionTradeBargainBg("framebg"))
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0.onBuyGoodsSuccess, slot0)
end

function slot0.onBuyGoodsSuccess(slot0)
	slot0:sortGoodsCoList()
	slot0:refreshGoods()
end

function slot0.sortGoodsCoList(slot0)
	table.sort(slot0.groupGoodsCoList, slot0.sortGoods)
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
	slot0.tagName = luaLang("versionactivity_store_1_2_tag_" .. slot0.groupId)

	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot0.imageframeicon, "bg_quyudi_" .. slot0.groupId)
	recthelper.setWidth(slot0.imageframeicon.transform, slot0.groupId == 1 and slot0._specialFrameWidth or slot0._normalFrameWidth)

	slot1 = utf8.next_raw(slot0.tagName, 1)
	slot0.firstName = slot0.tagName:sub(1, slot1 - 1)
	slot0.remainName = slot0.tagName:sub(slot1)

	gohelper.setActive(slot0.txtTagNameSpecial, slot0.groupId == 1)
	gohelper.setActive(slot0.txtTagName, slot0.groupId ~= 1)
	gohelper.setActive(slot0.simagespecialframebg.gameObject, slot0.groupId == 1)

	slot0.txtTagName.text = string.format("<size=50>%s</size>%s", slot0.firstName, slot0.remainName)
	slot0.txtTagNameSpecial.text = string.format("<size=50>%s</size>%s", slot0.firstName, slot0.remainName)

	SLFramework.UGUI.GuiHelper.SetColor(slot0.imageTagType, slot0._groupTagColors[slot0.groupId])
	SLFramework.UGUI.GuiHelper.SetColor(slot0.imageframebg, slot0.groupId == 1 and "#88431566" or "#FFFFFF38")
	SLFramework.UGUI.GuiHelper.SetColor(slot0.txtTagName, slot0._groupTxtColors[slot0.groupId])
end

function slot0.refreshGoods(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.groupGoodsCoList) do
		if not slot0.goodsItemList[slot5] then
			slot1 = VersionActivity1_2StoreGoodsItem.New()

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

function slot0.getHeight(slot0)
	return recthelper.getHeight(slot0.go.transform)
end

function slot0.sortGoods(slot0, slot1)
	if (slot0.maxBuyCount ~= 0 and slot0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, slot0.id) <= 0) ~= (slot1.maxBuyCount ~= 0 and slot1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, slot1.id) <= 0) then
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

	slot0.goodsItemList = nil
	slot0.tagMaskList = nil

	slot0.simagespecialframebg:UnLoadImage()
	slot0:__onDispose()
end

return slot0

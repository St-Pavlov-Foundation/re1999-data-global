module("modules.logic.act189.view.ShortenActStyleItem_impl", package.seeall)

slot0 = table.insert
slot1 = class("ShortenActStyleItem_impl", RougeSimpleItemBase)

function slot1.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)
end

function slot1._getStyleCO(slot0)
	return slot0:_assetGetParent():getStyleCO()
end

function slot1._getBonusList(slot0)
	return slot0:_assetGetParent():getBonusList()
end

function slot1._isClaimable(slot0)
	return slot0:_assetGetParent():isClaimable()
end

function slot1._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot1 = gohelper.findChild(slot0.viewGO, "1")
	slot0._simagerewardicon1Go = gohelper.findChild(slot1, "#simage_rewardicon1")
	slot0._simagerewardicon2Go = gohelper.findChild(slot1, "#simage_rewardicon2")
	slot0._goisget1 = gohelper.findChild(slot1, "#go_isget1")
	slot0._goisget2 = gohelper.findChild(slot1, "#go_isget2")
	slot0._gocanget1 = gohelper.findChild(slot1, "#go_canget1")
	slot0._gocanget2 = gohelper.findChild(slot1, "#go_canget2")
	slot0._txtnumbg1 = gohelper.findChildImage(slot1, "numbg1")
	slot0._txtnumbg2 = gohelper.findChildImage(slot1, "numbg2")
	slot0._txtnum1 = gohelper.findChildText(slot1, "numbg1/#txt_num1")
	slot0._txtnum2 = gohelper.findChildText(slot1, "numbg2/#txt_num2")
	slot0._gotimebg1 = gohelper.findChild(slot1, "#go_timebg1")
	slot0._gotimebg2 = gohelper.findChild(slot1, "#go_timebg2")
	slot0._gotimebgImg1 = slot0._gotimebg1:GetComponent(gohelper.Type_Image)
	slot0._gotimebgImg2 = slot0._gotimebg2:GetComponent(gohelper.Type_Image)
	slot0._commonPropItemIconList = {}

	uv1(slot0._commonPropItemIconList, IconMgr.instance:getCommonPropItemIcon(slot0._simagerewardicon1Go))
	uv1(slot0._commonPropItemIconList, IconMgr.instance:getCommonPropItemIcon(slot0._simagerewardicon2Go))

	slot0._txtList = slot0:getUserDataTb_()

	uv1(slot0._txtList, slot0._txtnum1)
	uv1(slot0._txtList, slot0._txtnum2)

	slot0._txtBgList = slot0:getUserDataTb_()

	uv1(slot0._txtBgList, slot0._txtnumbg1)
	uv1(slot0._txtBgList, slot0._txtnumbg2)

	slot0._goisgetList = slot0:getUserDataTb_()

	uv1(slot0._goisgetList, slot0._goisget1)
	uv1(slot0._goisgetList, slot0._goisget2)

	slot0._gocangetList = slot0:getUserDataTb_()

	uv1(slot0._gocangetList, slot0._gocanget1)
	uv1(slot0._gocangetList, slot0._gocanget2)

	slot0._gotimebgList = slot0:getUserDataTb_()

	uv1(slot0._gotimebgList, slot0._gotimebg1)
	uv1(slot0._gotimebgList, slot0._gotimebg2)

	slot0._gotimebgImgList = slot0:getUserDataTb_()

	uv1(slot0._gotimebgImgList, slot0._gotimebgImg1)
	uv1(slot0._gotimebgImgList, slot0._gotimebgImg2)
end

slot2 = "#A5A5A5A0"

function slot1.setData(slot0, slot1)
	uv0.super.setData(slot0, slot1)

	slot5 = not slot0:_isClaimable() and uv1 or "#FFFFFF"

	for slot9, slot10 in ipairs(slot0:_getBonusList()) do
		slot11 = slot0._commonPropItemIconList[slot9]
		slot12 = slot0._txtList[slot9]

		slot11:setMOValue(slot10[1], slot10[2], slot10[3])
		slot11:isShowQuality(false)
		slot11:isShowEquipAndItemCount(false)
		slot11:setItemColor(slot4 and uv1 or nil)
		slot11:customOnClickCallback(slot0["_onClickItem" .. slot9], slot0)
		slot11:setCanShowDeadLine(false)

		slot12.text = slot20 and luaLang("multiple") .. slot20 or ""

		gohelper.setActive(slot0._goisgetList[slot9], slot4)
		gohelper.setActive(slot0._gocangetList[slot9], slot3)
		gohelper.setActive(slot0._gotimebgList[slot9], slot11:isExpiredItem())
		SLFramework.UGUI.GuiHelper.SetColor(slot12, slot5)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtBgList[slot9], slot5)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._gotimebgImgList[slot9], slot5)
	end
end

function slot1._onClickItem(slot0, slot1, slot2)
	if not slot0:parent():onItemClick() then
		return
	end

	MaterialTipController.instance:showMaterialInfo(slot1, slot2)
end

function slot1._onClickItem2(slot0)
	slot1 = slot0:_getBonusList()[2]

	slot0:_onClickItem(slot1[1], slot1[2])
end

function slot1._onClickItem1(slot0)
	slot1 = slot0:_getBonusList()[1]

	slot0:_onClickItem(slot1[1], slot1[2])
end

function slot1.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_commonPropItemIconList")
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

return slot1

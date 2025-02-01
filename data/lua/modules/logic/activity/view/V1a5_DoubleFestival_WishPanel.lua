module("modules.logic.activity.view.V1a5_DoubleFestival_WishPanel", package.seeall)

slot0 = class("V1a5_DoubleFestival_WishPanel", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "#txt_TitleEn")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "scroll/viewport/content/#txt_Descr")
	slot0._imageIcon = gohelper.findChildImage(slot0.viewGO, "scroll/viewport/content/#txt_Descr/#image_Icon")
	slot0._txtDec = gohelper.findChildText(slot0.viewGO, "#txt_Dec")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = ActivityEnum.Activity.DoubleFestivalSign_1_5
slot2 = nil
slot3 = 294

function slot0._editableInitView(slot0)
	slot0._txtDescrTran = slot0._txtDescr.transform
	slot0._scroll = gohelper.findChildComponent(slot0.viewGO, "scroll", gohelper.Type_ScrollRect)
	slot0._imageIconTran = slot0._imageIcon.transform
	slot0._scrollContentTran = slot0._scroll.content

	slot0._simagePanelBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_news_bigitembg"))

	uv0 = uv0 or recthelper.getHeight(slot0._imageIconTran)
	slot0._txtDescr.text = ""
	slot0._txtTitle.text = ""
	slot0._txtTitleEn.text = ""
	slot0._txtDec.text = ""
end

function slot0.onOpen(slot0)
	slot0:_refresh(slot0.viewParam.day)

	slot3 = slot0._txtDescrTran.sizeDelta.y
	slot4 = slot3 + uv0

	if slot3 <= uv1 then
		slot4 = 630
	end

	recthelper.setHeight(slot0._scrollContentTran, slot4)
end

function slot0._refresh(slot0, slot1)
	GameUtil.setActive01(slot0._imageIconTran, ActivityType101Config.instance:getDoubleFestivalCOByDay(uv0, slot1) ~= nil)

	if not slot2 then
		return
	end

	UISpriteSetMgr.instance:setV1a5DfSignSprite(slot0._imageIcon, slot2.blessSpriteName)

	slot0._txtTitle.text = slot2.blessTitle
	slot0._txtTitleEn.text = slot2.blessTitleEn
	slot0._txtDescr.text = slot2.blessContent
	slot0._txtDec.text = slot2.blessDesc
	slot0._txtDescrTran.sizeDelta = Vector2(slot0._txtDescrTran.sizeDelta.x, math.max(uv1, slot0._txtDescr.preferredHeight))
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	if slot0.viewParam.popupViewBlockKey then
		PopupController.instance:setPause(slot1.popupViewBlockKey, false)

		slot1.popupViewBlockKey = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0

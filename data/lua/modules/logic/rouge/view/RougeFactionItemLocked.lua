module("modules.logic.rouge.view.RougeFactionItemLocked", package.seeall)

slot0 = class("RougeFactionItemLocked", RougeFactionItem_Base)

function slot0.onInitView(slot0)
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_Bg")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_en")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._txtscrollDesc = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#txt_scrollDesc")
	slot0._txtlocked = gohelper.findChildText(slot0.viewGO, "bg/#txt_locked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	RougeFactionItem_Base._editableInitView(slot0)
	slot0:_onSetScrollParentGameObject(slot0._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect))

	slot0._txtlocked.text = ""
end

function slot0._onItemClick(slot0)
end

function slot0.onDestroyView(slot0)
	RougeFactionItem_Base.onDestroyView(slot0)
end

function slot0.setData(slot0, slot1)
	RougeFactionItem_Base.setData(slot0, slot1)

	slot0._txtlocked.text = RougeOutsideModel.instance:config():getStyleLockDesc(slot1.styleCO.id)
end

return slot0

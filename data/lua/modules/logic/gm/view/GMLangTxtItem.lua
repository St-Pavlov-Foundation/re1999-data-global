module("modules.logic.gm.view.GMLangTxtItem", package.seeall)

slot0 = class("GMLangTxtItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._txt = gohelper.findChildText(slot1, "txt")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot1)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._data = slot1.txt
	slot0._txt.text = slot1.txt
end

function slot0._onClick(slot0)
	slot0._view.viewContainer:onLangTxtClick(slot0._data)
end

return slot0

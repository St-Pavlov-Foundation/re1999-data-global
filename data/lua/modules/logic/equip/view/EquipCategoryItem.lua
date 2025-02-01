module("modules.logic.equip.view.EquipCategoryItem", package.seeall)

slot0 = class("EquipCategoryItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gounselected = gohelper.findChild(slot0.viewGO, "#go_unselected")
	slot0._txtitemcn1 = gohelper.findChildText(slot0.viewGO, "#go_unselected/#txt_itemcn1")
	slot0._txtitemen1 = gohelper.findChildText(slot0.viewGO, "#go_unselected/#txt_itemen1")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._txtitemcn2 = gohelper.findChildText(slot0.viewGO, "#go_selected/#txt_itemcn2")
	slot0._txtitemen2 = gohelper.findChildText(slot0.viewGO, "#go_selected/#txt_itemen2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onClick(slot0)
	if slot0._isSelect then
		return
	end

	slot0._view:selectCell(slot0._index, true)

	EquipCategoryListModel.instance.curCategoryIndex = slot0._mo.resIndex

	slot0._view.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot0._mo.resIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtitemcn1.text = slot1.cnName
	slot0._txtitemcn2.text = slot1.cnName
	slot0._txtitemen1.text = slot1.enName
	slot0._txtitemen2.text = slot1.enName
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	slot0._gounselected:SetActive(not slot0._isSelect)
	slot0._goselected:SetActive(slot0._isSelect)
end

function slot0.onDestroyView(slot0)
end

return slot0

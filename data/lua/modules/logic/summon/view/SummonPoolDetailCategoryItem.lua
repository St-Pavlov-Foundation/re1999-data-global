module("modules.logic.summon.view.SummonPoolDetailCategoryItem", package.seeall)

slot0 = class("SummonPoolDetailCategoryItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "#go_unselect")
	slot0._txttitle1 = gohelper.findChildText(slot0.viewGO, "#go_unselect/#txt_title1")
	slot0._txttitle1En = gohelper.findChildText(slot0.viewGO, "#go_unselect/#txt_title1En")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._txttitle2 = gohelper.findChildText(slot0.viewGO, "#go_select/#txt_title2")
	slot0._txttitle2En = gohelper.findChildText(slot0.viewGO, "#go_select/#txt_title2En")

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
	slot0._view.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot0._mo.resIndex)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolDetailCategoryClick, slot0._mo.resIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txttitle1.text = slot1.cnName
	slot0._txttitle2.text = slot1.cnName
	slot0._txttitle1En.text = slot1.enName
	slot0._txttitle2En.text = slot1.enName
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	slot0._gounselect:SetActive(not slot0._isSelect)
	slot0._goselect:SetActive(slot0._isSelect)
end

function slot0.onDestroyView(slot0)
end

return slot0

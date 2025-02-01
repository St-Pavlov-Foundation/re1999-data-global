module("modules.logic.summon.view.SummonPoolHistoryTypeItem", package.seeall)

slot0 = class("SummonPoolHistoryTypeItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "go_unselect")
	slot0._txtunname = gohelper.findChildText(slot0.viewGO, "go_unselect/txt_name")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "go_select/txt_name")
	slot0._btnitem = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_item")
end

function slot0._editableAddEvents(slot0)
	slot0._btnitem:AddClickListener(slot0._onClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._btnitem:RemoveClickListener()
end

function slot0._onClick(slot0)
	if slot0._isSelect then
		return
	end

	SummonPoolHistoryTypeListModel.instance:setSelectId(slot0._mo.id)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolHistorySelect, slot0._mo.id)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Pool_History_Type_Switch)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtunname.text = slot1.config.name
	slot0._txtname.text = slot1.config.name
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	slot0._gounselect:SetActive(not slot0._isSelect)
	slot0._goselect:SetActive(slot0._isSelect)
end

function slot0.onDestroyView(slot0)
end

return slot0

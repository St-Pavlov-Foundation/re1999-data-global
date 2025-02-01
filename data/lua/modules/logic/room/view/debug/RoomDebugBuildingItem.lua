module("modules.logic.room.view.debug.RoomDebugBuildingItem", package.seeall)

slot0 = class("RoomDebugBuildingItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtbuildingid = gohelper.findChildText(slot0.viewGO, "#txt_buildingid")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	RoomDebugBuildingListModel.instance:setSelect(slot0._mo.id)
end

function slot0._editableInitView(slot0)
	slot0._isSelect = false

	gohelper.addUIClickAudio(slot0._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function slot0._refreshUI(slot0)
	slot0._txtbuildingid.text = slot0._mo.id
	slot0._txtname.text = slot0._mo.config.name
end

function slot0.onUpdateMO(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot0._isSelect)

	slot0._mo = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)

	slot0._isSelect = slot1
end

function slot0.onDestroy(slot0)
end

return slot0

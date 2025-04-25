module("modules.logic.room.view.critter.RoomCritterTrainItem", package.seeall)

slot0 = class("RoomCritterTrainItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_info/#txt_name")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_base")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#scroll_base/viewport/content/#go_baseitem")
	slot0._btnclickitem = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_clickitem")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnclickitem:AddClickListener(slot0._btnclickitemOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnclickitem:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	slot0:_btnclickitemOnClick()
end

function slot0._btndetailOnClick(slot0)
	CritterController.instance:openRoomCritterDetailView(true, slot0._mo, true)
end

function slot0._btnclickitemOnClick(slot0)
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectCritter, slot0:getDataMO())
	end
end

function slot0._editableInitView(slot0)
	slot0._goScrollbaseContent = gohelper.findChild(slot0.viewGO, "#scroll_base/viewport/content")
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.getDataMO(slot0)
	return slot0._mo
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	if slot0._mo then
		if not slot0.critterIcon then
			slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._goicon)
		end

		slot0.critterIcon:setMOValue(slot1:getId(), slot1:getDefineId())

		slot0._txtname.text = slot1:getName()

		slot0:_refreshLineLinkUI()
	end
end

function slot0._refreshLineLinkUI(slot0)
	if slot0._mo then
		slot0._dataList = slot0._mo:getAttributeInfos()

		gohelper.CreateObjList(slot0, slot0._onCritterArrComp, slot0._dataList, slot0._goScrollbaseContent, slot0._gobaseitem, RoomCritterAttrScrollCell)
	end
end

function slot0._onCritterArrComp(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)

	if not slot1._view then
		slot1._view = slot0._view
	end
end

slot0.prefabPath = "ui/viewres/room/critter/roomcrittertrainitem.prefab"

return slot0

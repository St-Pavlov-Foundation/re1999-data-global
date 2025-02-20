module("modules.logic.room.view.interact.RoomInteractSelectItem", package.seeall)

slot0 = class("RoomInteractSelectItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gohas = gohelper.findChild(slot0.viewGO, "#go_has")
	slot0._goheroicon = gohelper.findChild(slot0.viewGO, "#go_has/#go_heroicon")
	slot0._goloading = gohelper.findChild(slot0.viewGO, "#go_loading")
	slot0._goheroicon2 = gohelper.findChild(slot0.viewGO, "#go_loading/#go_heroicon")
	slot0._gonone = gohelper.findChild(slot0.viewGO, "#go_none")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "#go_tag")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

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
	if slot0._view and slot0._view.viewContainer and slot0._characterMO then
		slot0._view.viewContainer:dispatchEvent(RoomEvent.InteractBuildingSelectHero, slot0._characterMO.heroId)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gotag, false)
	gohelper.setActive(slot0._goloading, false)

	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_has/#go_heroicon")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_loading/#go_heroicon")
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._characterMO = slot1

	slot0:refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simageicon2:UnLoadImage()
end

function slot0.refreshUI(slot0)
	if slot0._lastIsHas ~= (slot0._characterMO and true or false) then
		slot0._lastIsHas = slot2

		gohelper.setActive(slot0._gohas, slot2)
		gohelper.setActive(slot0._gonone, not slot2)
	end

	if slot2 and slot0._lastMOid ~= slot1.id then
		slot0._lastMOid = slot1.id
		slot3 = ResUrl.getRoomHeadIcon(slot1.skinConfig.headIcon)

		slot0._simageicon:LoadImage(slot3)
		slot0._simageicon2:LoadImage(slot3)
	end
end

return slot0

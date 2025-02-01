module("modules.logic.room.view.manufacture.RoomManufactureCritterInfo", package.seeall)

slot0 = class("RoomManufactureCritterInfo", LuaCompBase)
slot1 = "critterInfo"

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gohas = gohelper.findChild(slot0.go, "#go_has")
	slot0._gocrittericon = gohelper.findChild(slot0.go, "#go_has/#go_critterIcon")
	slot0._gonone = gohelper.findChild(slot0.go, "#go_none")
	slot0._goselected = gohelper.findChild(slot0.go, "#go_selected")
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#btn_click")
	slot0._goplaceEff = gohelper.findChild(slot0.go, "#add")

	slot0:reset()
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._onClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, slot0._onChangeSelectedCritterSlotItem, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, slot0._onCritterWorkInfoChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.PlayAddCritterEff, slot0._onAddCritter, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, slot0._onChangeSelectedCritterSlotItem, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, slot0._onCritterWorkInfoChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.PlayAddCritterEff, slot0._onAddCritter, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onClick(slot0)
	slot1 = slot0:getViewBuilding()

	if slot0.parent and slot0.parent.setViewBuildingUid then
		slot0.parent:setViewBuildingUid()
	end

	ManufactureController.instance:clickCritterSlotItem(slot1, slot0.critterSlotId)
end

function slot0._onChangeSelectedCritterSlotItem(slot0)
	slot0:refreshSelected()
end

function slot0._onCritterWorkInfoChange(slot0)
	slot0:setCritter()
	slot0:refresh()
end

function slot0._onAddCritter(slot0, slot1, slot2)
	if not slot1 or slot2 then
		return
	end

	if slot1[slot0:getViewBuilding()] and slot1[slot3][slot0.critterSlotId] then
		slot0:playPlaceCritterEff()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.RoomCritterOneKeyView and slot0._playEffWaitCloseView then
		slot0:playPlaceCritterEff()
	end
end

function slot0.getViewBuilding(slot0)
	slot1, slot2 = nil

	if slot0.parent then
		slot1, slot2 = slot0.parent:getViewBuilding()
	end

	return slot1, slot2
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0.critterSlotId = slot1
	slot0.index = slot2
	slot0.parent = slot3
	slot0._playEffWaitCloseView = false
	slot0.go.name = string.format("id-%s_i-%s", slot0.critterSlotId, slot0.index)

	slot0:setCritter()
	slot0:refresh()
	gohelper.setActive(slot0._goplaceEff, false)
	gohelper.setActive(slot0.go, true)
end

function slot0.setCritter(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	if slot2 and slot2:getWorkingCritter(slot0.critterSlotId) then
		if not slot0.critterIcon then
			slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocrittericon)
		end

		slot0.critterIcon:setMOValue(slot3)
		slot0.critterIcon:showMood()
	end

	gohelper.setActive(slot0._gohas, slot3)
	gohelper.setActive(slot0._gonone, not slot3)
end

function slot0.refresh(slot0)
	slot0:refreshSelected()
end

function slot0.refreshSelected(slot0)
	slot1 = false

	if slot0.critterSlotId then
		slot3, slot4 = ManufactureModel.instance:getSelectedCritterSlot()

		if slot0:getViewBuilding() and slot2 == slot3 then
			slot1 = true
		end
	end

	gohelper.setActive(slot0._goselected, slot1)
end

function slot0.playPlaceCritterEff(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterOneKeyView) then
		slot0._playEffWaitCloseView = true
	else
		gohelper.setActive(slot0._goplaceEff, false)
		gohelper.setActive(slot0._goplaceEff, true)

		slot0._playEffWaitCloseView = false
	end
end

function slot0.reset(slot0)
	slot0.critterSlotId = nil
	slot0.index = nil
	slot0.parent = nil
	slot0.go.name = uv0
	slot0._playEffWaitCloseView = false

	gohelper.setActive(slot0._goplaceEff, false)
	gohelper.setActive(slot0.go, false)
end

function slot0.onDestroy(slot0)
end

return slot0

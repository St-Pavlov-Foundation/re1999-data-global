module("modules.logic.room.view.manufacture.RoomTransportCritterInfo", package.seeall)

slot0 = class("RoomTransportCritterInfo", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gohas = gohelper.findChild(slot0.go, "#go_has")
	slot0._gocrittericon = gohelper.findChild(slot0.go, "#go_has/#go_critterIcon")
	slot0._gonone = gohelper.findChild(slot0.go, "#go_none")
	slot0._goselected = gohelper.findChild(slot0.go, "#go_selected")
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#btn_click")
	slot0._goplaceEff = gohelper.findChild(slot0.go, "#add")
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._onClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, slot0._onChangeSelectedTransportPath, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.PlayAddCritterEff, slot0._onAddCritter, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, slot0._onChangeSelectedTransportPath, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.PlayAddCritterEff, slot0._onAddCritter, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onClick(slot0)
	ManufactureController.instance:clickTransportCritterSlotItem(slot0.pathId)
end

function slot0._onChangeSelectedTransportPath(slot0)
	slot0:refreshSelected()
end

function slot0._onAddCritter(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if slot1[slot0.pathId] then
		for slot6, slot7 in ipairs(slot1[slot0.pathId]) do
			if slot0.critterUid == slot7 then
				slot0:playPlaceCritterEff()

				break
			end
		end
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.RoomCritterOneKeyView and slot0._playEffWaitCloseView then
		slot0:playPlaceCritterEff()
	end
end

function slot0.setData(slot0, slot1, slot2)
	slot0.critterUid = slot1
	slot0.pathId = slot2
	slot0._playEffWaitCloseView = false

	slot0:setCritter()
	slot0:refresh()
	gohelper.setActive(slot0.go, true)
end

function slot0.setCritter(slot0)
	if slot0.critterUid then
		if not slot0.critterIcon then
			slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocrittericon)
		end

		slot0.critterIcon:setMOValue(slot0.critterUid)
		slot0.critterIcon:showMood()
	end

	gohelper.setActive(slot0._gohas, slot0.critterUid)
	gohelper.setActive(slot0._gonone, not slot0.critterUid)
end

function slot0.refresh(slot0)
	slot0:refreshSelected()
end

function slot0.refreshSelected(slot0)
	slot1 = false

	if slot0.pathId and ManufactureModel.instance:getSelectedTransportPath() == slot0.pathId then
		slot1 = true
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

function slot0.onDestroy(slot0)
end

return slot0

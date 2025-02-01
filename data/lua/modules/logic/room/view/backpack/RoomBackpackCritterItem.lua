module("modules.logic.room.view.backpack.RoomBackpackCritterItem", package.seeall)

slot0 = class("RoomBackpackCritterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goCritterIcon = gohelper.findChild(slot0.viewGO, "#go_critterIcon")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoUpdate, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, slot0._onCritterLockStatusChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoUpdate, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, slot0._onCritterLockStatusChange, slot0)
end

function slot0._onCritterInfoUpdate(slot0, slot1)
	slot2 = slot0._mo and slot0._mo:getId()

	if not slot0._critterIcon or not slot2 or slot1 and not slot1[slot2] then
		return
	end

	slot0._critterIcon:refreshLockIcon()
	slot0._critterIcon:refreshMaturityIcon()
end

function slot0._onCritterLockStatusChange(slot0, slot1)
	slot2 = slot0._mo and slot0._mo:getId()

	if not slot0._critterIcon or not slot2 or slot2 ~= slot1 then
		return
	end

	slot0._critterIcon:refreshLockIcon()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not slot0._critterIcon then
		slot0._critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._goCritterIcon)

		slot0._critterIcon:setLockIconShow(true)
		slot0._critterIcon:setMaturityIconShow(true)
	end

	slot0._critterIcon:onUpdateMO(slot0._mo)
	slot0._critterIcon:setCustomClick(slot0.onClickCB, slot0)
	slot0._critterIcon:setIsShowBuildingIcon(true)
end

function slot0.onClickCB(slot0)
	CritterController.instance:openRoomCritterDetailView(not slot0._mo:isMaturity(), slot0._mo)
end

function slot0.onDestroyView(slot0)
end

return slot0

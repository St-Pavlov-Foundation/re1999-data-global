module("modules.logic.room.view.critter.RoomTrainSlotItem", package.seeall)

slot0 = class("RoomTrainSlotItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goadd = gohelper.findChild(slot0.viewGO, "#go_add")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_unlock")
	slot0._gocrittenIcon = gohelper.findChild(slot0.viewGO, "#go_unlock/#go_crittenIcon")
	slot0._simageheroIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_unlock/#simage_heroIcon")
	slot0._simagetotalBarValue = gohelper.findChildSingleImage(slot0.viewGO, "#go_unlock/ProgressBg/#simage_totalBarValue")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_unlock/#go_select")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_unlock/#go_finish")
	slot0._gobubble = gohelper.findChild(slot0.viewGO, "#go_unlock/#go_bubble")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickitemOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickitemOnClick(slot0)
	if slot0._view and slot0._view.viewContainer then
		if not slot0._slotMO or slot0._slotMO.isLock then
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

			return
		end

		slot0._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, slot0:getDataMO())
	end
end

function slot0._editableInitView(slot0)
	slot0._imageTrainBarValue = gohelper.findChildImage(slot0.viewGO, "#go_unlock/ProgressBg/#simage_totalBarValue")
end

function slot0._editableAddEvents(slot0)
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:registerCallback(CritterEvent.UITrainCdTime, slot0._opTranCdTimeUpdate, slot0)
	end
end

function slot0._editableRemoveEvents(slot0)
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:unregisterCallback(CritterEvent.UITrainCdTime, slot0._opTranCdTimeUpdate, slot0)
	end
end

function slot0.getDataMO(slot0)
	return slot0._slotMO
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._slotMO = slot1

	slot0:refreshUI()
end

function slot0._opTranCdTimeUpdate(slot0)
	slot0:_refreshTrainProgressUI()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	slot1 = slot0._slotMO.isLock
	slot2 = slot0._slotMO.critterMO ~= nil

	gohelper.setActive(slot0._golock, slot1)
	gohelper.setActive(slot0._goadd, not slot2)
	gohelper.setActive(slot0._gounlock, not slot1 and slot2)

	if not slot1 and slot2 then
		slot0:_refreshCritterUI()
		slot0:_refreshTrainProgressUI()
	end

	slot3 = not slot1 and slot0._slotMO.id == 1

	gohelper.setActive(slot0._goreddot, slot3)

	if slot3 then
		RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomCritterTrainOcne)
	end
end

function slot0._refreshCritterUI(slot0)
	if slot0._slotMO.critterMO then
		if not slot0.critterIcon then
			slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocrittenIcon)
		end

		slot0.critterIcon:setMOValue(slot1:getId(), slot1:getDefineId())

		if HeroModel.instance:getByHeroId(slot1.trainInfo.heroId) and SkinConfig.instance:getSkinCo(slot2.skin) then
			slot0._simageheroIcon:LoadImage(ResUrl.getRoomHeadIcon(slot3.headIcon))
		end
	end
end

function slot0._refreshTrainProgressUI(slot0)
	if slot0._slotMO and slot0._slotMO.critterMO and slot1.trainInfo then
		gohelper.setActive(slot0._gofinish, slot1.trainInfo:isTrainFinish())
		gohelper.setActive(slot0._gobubble, slot1.trainInfo:isHasEventTrigger())

		slot4 = 0.05
		slot0._imageTrainBarValue.fillAmount = slot4 + slot1.trainInfo:getProcess() * (0.638 - slot4)
	end
end

slot0.prefabPath = "ui/viewres/room/critter/roomtrainslotitem.prefab"

return slot0

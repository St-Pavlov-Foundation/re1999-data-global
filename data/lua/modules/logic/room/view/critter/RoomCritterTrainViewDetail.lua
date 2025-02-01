module("modules.logic.room.view.critter.RoomCritterTrainViewDetail", package.seeall)

slot0 = class("RoomCritterTrainViewDetail", BaseView)

function slot0.onInitView(slot0)
	slot0._gotrainingdetail = gohelper.findChild(slot0.viewGO, "bottom/#go_trainingdetail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntrainevent:AddClickListener(slot0._btntraineventOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntrainevent:RemoveClickListener()
end

function slot0._btntrainfinishOnClick(slot0)
	if slot0._slotMO and slot0._slotMO.critterMO and slot1.trainInfo then
		if slot1.trainInfo:isFinishAllEvent() then
			RoomCritterController.instance:sendFinishTrainCritter(slot1.id)
		else
			RoomCritterController.instance:openTrainEventView(slot1.id)
		end
	end
end

function slot0._btntraineventOnClick(slot0)
	if slot0:_isHasEventTrigger() then
		RoomCritterController.instance:openTrainEventView(slot0._critterMO.id)
	end
end

function slot0._editableInitView(slot0)
	slot0.detailItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(RoomCritterTrainDetailItem.prefabPath, slot0._gotrainingdetail), RoomCritterTrainDetailItem, slot0)
	slot0._gomapui = gohelper.findChild(slot0.viewGO, "#go_mapui")
	slot0._goeventicon = gohelper.findChild(slot0.viewGO, "#go_mapui/go_eventicon")
	slot0._btntrainevent = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mapui/go_eventicon/btn_trainevent")
	slot0._goeventiconTrs = slot0._goeventicon.transform
	slot0._gomapuiTrs = slot0._gomapui.transform
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._scene = RoomCameraController.instance:getRoomScene()

	slot0:addEventCb(CritterController.instance, CritterEvent.TrainStartTrainCritterReply, slot0._onTrainStartTrainCritterReply, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoChanged, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.TrainSelectEventOptionReply, slot0._onTrainSelectEventOptionReply, slot0)

	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainSelectSlot, slot0._onSelectSlotItem, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainCdTime, slot0._opTranCdTimeUpdate, slot0)
	end

	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._refreshPosition, slot0)
	slot0.detailItem:setCritterChanageCallback(slot0._critterChangeCallblck, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.detailItem:onDestroy()
	TaskDispatcher.cancelTask(slot0._playLevelUp, slot0)

	slot0._specialEventIds = nil
end

function slot0._critterChangeCallblck(slot0)
	slot0.viewContainer:dispatchEvent(CritterEvent.UIChangeTrainCritter, slot0._slotMO)
end

function slot0._onSelectSlotItem(slot0, slot1)
	slot0._slotMO = slot1
	slot0._critterMO = slot1.critterMO
	slot0._critterUid = slot0._critterMO and slot0._critterMO.id

	slot0.detailItem:onUpdateMO(slot1.critterMO)
	slot0:_refreshUI()
end

function slot0._opTranCdTimeUpdate(slot0)
	if not slot0._specialEventIds or #slot0._specialEventIds < 1 then
		slot0.detailItem:tranCdTimeUpdate()
	end

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if slot0._isLastHasTrigger ~= slot0:_isHasEventTrigger() then
		slot0._isLastHasTrigger = slot1

		gohelper.setActive(slot0._goeventicon, slot1)
		slot0:_refreshPosition()
	end
end

function slot0._onTrainStartTrainCritterReply(slot0, slot1, slot2)
	slot0.detailItem:refreshUI()
end

function slot0._onTrainSelectEventOptionReply(slot0, slot1, slot2, slot3)
	if CritterConfig.instance:getCritterTrainEventCfg(slot2) and slot4.type == CritterEnum.EventType.Special then
		slot0._specialEventIds = slot0._specialEventIds or {}

		if #slot0._specialEventIds < 1 then
			TaskDispatcher.runDelay(slot0._playLevelUp, slot0, 0.1)
		end

		table.insert(slot0._specialEventIds, slot2)
	end
end

function slot0._onCritterInfoChanged(slot0)
	slot0._critterMO = CritterModel.instance:getCritterMOByUid(slot0._critterUid)

	slot0.detailItem:onUpdateMO(slot0._critterMO)
end

function slot0._isHasEventTrigger(slot0)
	if slot0._critterMO and slot0._critterMO.trainInfo:isHasEventTrigger() then
		return true
	end

	return false
end

function slot0._playLevelUp(slot0)
	slot0._specialEventIds = nil
	slot2 = slot0._critterMO

	if slot0._specialEventIds and slot2 and slot2:isCultivating() then
		slot3 = {}

		for slot8 = 1, #slot2.trainInfo.events do
			if tabletool.indexOf(slot1, slot4[slot8].eventId) then
				tabletool.addValues(slot3, slot9.addAttributes)
			end
		end

		ViewMgr.instance:openView(ViewName.RoomCritterTrainEventResultView, {
			critterMO = slot2,
			addAttributeMOs = slot3
		})
	end
end

function slot0._refreshPosition(slot0)
	if not slot0._isLastHasTrigger then
		return
	end

	if not slot0:_getCritterEntity() then
		return
	end

	if not (slot1.critterspine:getMountheadGOTrs() or slot1.goTrs) then
		return
	end

	slot3, slot4, slot5 = transformhelper.getPos(slot2)

	if RoomBendingHelper.worldPosToAnchorPos(RoomBendingHelper.worldToBendingSimple(Vector3(slot3, slot4, slot5)), slot0._gomapuiTrs) then
		recthelper.setAnchor(slot0._goeventiconTrs, slot7.x, slot7.y)
	end
end

function slot0._getCritterEntity(slot0)
	if not slot0._scene then
		return nil
	end

	if slot0._scene.cameraFollow:isFollowing() then
		return slot0._scene.crittermgr:getCritterEntity(slot0._critterUid, SceneTag.RoomCharacter)
	end

	return slot0._scene.crittermgr:getTempCritterEntity()
end

return slot0

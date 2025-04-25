module("modules.logic.room.view.manufacture.RoomCritterRestViewMapUI", package.seeall)

slot0 = class("RoomCritterRestViewMapUI", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._gomap = gohelper.findChild(slot0.viewGO, "content/go_map")
	slot0._gomood = gohelper.findChild(slot0.viewGO, "content/#go_select/mood")
	slot0._moodItemCompList = {}
	slot0._critterMoodShowDict = {}
	slot0._gomapTrs = slot0._gomap.transform
	slot0._offX, slot0._offY = recthelper.getAnchor(slot0._gomood.transform)

	gohelper.setActive(slot0._gomood, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingSelectCritter, slot0._startRefreshMoodTask, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, slot0._startRefreshMoodTask, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, slot0._startRefreshMoodTask, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, slot0._startRefreshMoodTask, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, slot0._startRefreshMoodTask, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, slot0._startRefreshMoodTask, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	slot0:addEventCb(slot0.viewContainer, CritterEvent.UICritterDragIng, slot0._cameraTransformUpdate, slot0)
	slot0:addEventCb(slot0.viewContainer, CritterEvent.UICritterDragEnd, slot0._startRefreshMoodTask, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, slot0._startRequestTask, slot0)

	slot0._scene = RoomCameraController.instance:getRoomScene()

	slot0:_startRefreshMoodTask()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_stopRefreshMoodTask()
end

function slot0._startRequestTask(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	CritterController.instance:waitSendBuildManufacturAttrByBuid(slot1)
end

function slot0._startRefreshMoodTask(slot0)
	if not slot0._hasWaitRefreshMoodTask then
		slot0._hasWaitRefreshMoodTask = true

		TaskDispatcher.runDelay(slot0._onRunRefreshMoodTask, slot0, 0.1)
	end
end

function slot0._stopRefreshMoodTask(slot0)
	slot0._hasWaitRefreshMoodTask = false

	TaskDispatcher.cancelTask(slot0._onRunRefreshMoodTask, slot0)
end

function slot0._onRunRefreshMoodTask(slot0)
	slot0._hasWaitRefreshMoodTask = false

	if not slot0:_refreshMood() then
		slot0:_startRefreshMoodTask()
	end

	if not slot0._isSendCritterRequest then
		slot2, slot3 = slot0:getViewBuilding()

		if slot3 and slot3.config and slot3.config.buildingType then
			slot0._isSendCritterRequest = true

			CritterController.instance:sendBuildManufacturAttrByBtype(slot3.config.buildingType)
		end
	end
end

function slot0._cameraTransformUpdate(slot0)
	slot0:_refreshMood()
end

slot1 = {}

function slot0._refreshMood(slot0)
	slot3, slot4 = slot0:getViewBuilding()
	slot5 = true

	for slot9, slot10 in ipairs(CritterModel.instance:getAllCritters()) do
		slot11 = slot10:getId()

		if slot4 and slot4:isCritterInSeatSlot(slot11) then
			if not slot0._moodItemCompList[0 + 1] then
				slot13 = gohelper.clone(slot0._gomood, slot0._gomap)
				slot12 = MonoHelper.addNoUpdateLuaComOnceToGo(slot13, CritterMoodItem)
				slot12.goViewTrs = slot13.transform

				table.insert(slot0._moodItemCompList, slot12)
				slot12:setShowMoodRestore(false)
			end

			slot12:setCritterUid(slot11)

			slot13 = slot0:_updateMoodPos(slot11, slot12.goViewTrs)
			slot0._critterMoodShowDict[slot11] = slot13

			if not slot13 then
				slot5 = false
			end
		end
	end

	for slot9 = 1, #slot0._moodItemCompList do
		slot10 = slot0._moodItemCompList[slot9]

		gohelper.setActive(slot10.go, slot0._critterMoodShowDict[slot10.critterUid] and slot9 <= slot2)
	end

	return slot5
end

function slot0._updateMoodPos(slot0, slot1, slot2)
	if not slot0._scene then
		return false
	end

	if gohelper.isNil(slot0._scene.buildingcrittermgr:getCritterEntity(slot1) and slot3.critterspine:getMountheadGOTrs()) then
		return false
	end

	if RoomBendingHelper.worldPosToAnchorPos(RoomBendingHelper.worldToBendingSimple(slot4.position), slot0._gomapTrs) then
		recthelper.setAnchor(slot2, slot7.x + slot0._offX, slot7.y + slot0._offY)

		return true
	end

	return false
end

function slot0.getViewBuilding(slot0)
	return slot0.viewContainer:getContainerViewBuilding()
end

return slot0

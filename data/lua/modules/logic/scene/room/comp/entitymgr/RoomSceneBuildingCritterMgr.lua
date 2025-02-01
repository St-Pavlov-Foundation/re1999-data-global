module("modules.logic.scene.room.comp.entitymgr.RoomSceneBuildingCritterMgr", package.seeall)

slot0 = class("RoomSceneBuildingCritterMgr", BaseSceneUnitMgr)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	if RoomController.instance:isEditMode() then
		return
	end

	slot0:addEventListeners()
	slot0:refreshAllCritterEntities()
end

function slot0.addEventListeners(slot0)
	if slot0._isInitAddEvent then
		return
	end

	slot0._isInitAddEvent = true

	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureInfoUpdate, slot0._startRefreshAllTask, slot0)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, slot0._startRefreshAllTask, slot0)
	ManufactureController.instance:registerCallback(ManufactureEvent.CritterWorkInfoChange, slot0._startRefreshAllTask, slot0)
	CritterController.instance:registerCallback(CritterEvent.CritterBuildingChangeRestingCritter, slot0._startRefreshAllTask, slot0)
end

function slot0.removeEventListeners(slot0)
	if not slot0._isInitAddEvent then
		return
	end

	slot0._isInitAddEvent = false

	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureInfoUpdate, slot0._startRefreshAllTask, slot0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, slot0._startRefreshAllTask, slot0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.CritterWorkInfoChange, slot0._startRefreshAllTask, slot0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterBuildingChangeRestingCritter, slot0._startRefreshAllTask, slot0)
end

function slot0._startRefreshAllTask(slot0)
	if not slot0._isHasWaitRefreshAllTask then
		slot0._isHasWaitRefreshAllTask = true

		TaskDispatcher.runDelay(slot0._onRunRefreshAllTask, slot0, 0.1)
	end
end

function slot0._stopRefreshAllTask(slot0)
	if slot0._isHasWaitRefreshAllTask then
		slot0._isHasWaitRefreshAllTask = false

		TaskDispatcher.cancelTask(slot0._onRunRefreshAllTask, slot0)
	end
end

function slot0._onRunRefreshAllTask(slot0)
	slot0._isHasWaitRefreshAllTask = false

	slot0:refreshAllCritterEntities()
end

function slot0.refreshAllCritterEntities(slot0)
	slot3 = {}

	for slot9, slot10 in pairs(slot0:getRoomCritterEntityDict()) do
		slot11, slot12 = nil

		if RoomModel.instance:getGameMode() == RoomEnum.GameMode.Ob and RoomCritterModel.instance:getCritterMOById(slot10.id) then
			slot11, slot12 = slot13:getStayBuilding()
		end

		if slot11 and slot12 then
			if slot0._scene.buildingmgr:getBuildingEntity(slot11, SceneTag.RoomBuilding) and not gohelper.isNil(slot13:getCritterPoint(slot12)) then
				slot15, slot16, slot17 = transformhelper.getPos(slot14.transform)

				slot10:setLocalPos(slot15, slot16, slot17)
				slot10.critterspine:refreshAnimState()
			end
		else
			slot3[#slot3 + 1] = slot10
		end
	end

	for slot9, slot10 in ipairs(slot3) do
		slot0:destroyCritter(slot10)
	end

	if slot2 then
		for slot10, slot11 in ipairs(slot5:getRoomBuildingCritterList() or {}) do
			if not slot0:getCritterEntity(slot11:getId()) then
				slot0:spawnRoomCritter(slot11)
			end
		end
	end
end

function slot0.spawnRoomCritter(slot0, slot1)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() or not slot1 then
		return
	end

	slot4, slot5 = slot1:getStayBuilding()

	if not slot4 or not slot5 then
		return
	end

	slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.create3d(slot0._scene.go.critterRoot, string.format("%s", slot1.id)), RoomCritterEntity, slot1.id)
	slot9 = {
		z = 0,
		x = 0,
		y = 0,
		x = transformhelper.getPos(slot11.transform)
	}

	if slot0._scene.buildingmgr:getBuildingEntity(slot4, SceneTag.RoomBuilding) then
		if not gohelper.isNil(slot10:getCritterPoint(slot5)) then
			-- Nothing
		else
			logError(string.format("RoomSceneBuildingCritterMgr:spawnRoomCritter error, no critter point, buildingUid:%s,index:%s", slot4, slot5 + 1))
		end
	end

	slot8:setLocalPos(slot9.x, slot9.y, slot9.z)

	if slot1:isRestingCritter() then
		slot8.critterspine:setScale(CritterEnum.CritterScaleInSeatSlot)
	end

	slot0:addUnit(slot8)
	gohelper.addChild(slot6, slot7)

	return slot8
end

function slot0.refreshAllCritterEntityPos(slot0)
	if not slot0._scene then
		return
	end

	for slot5, slot6 in pairs(slot0:getRoomCritterEntityDict()) do
		slot8, slot9 = nil

		if slot6:getMO() then
			slot8, slot9 = slot7:getStayBuilding()
		end

		if not slot8 or not slot9 then
			return
		end

		if gohelper.isNil(slot0._scene.buildingmgr:getBuildingEntity(slot8, SceneTag.RoomBuilding) and slot10:getCritterPoint(slot9)) then
			return
		end

		slot12, slot13, slot14 = transformhelper.getPos(slot11.transform)

		slot6:setLocalPos(slot12, slot13, slot14)
	end
end

function slot0.refreshCritterPosByBuilding(slot0, slot1)
	if not slot0._scene then
		return
	end

	slot2 = RoomMapBuildingModel.instance:getBuildingMOById(slot1)

	if not slot0._scene.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) or not slot2 then
		return
	end

	slot4 = nil

	if not (ManufactureConfig.instance:isManufactureBuilding(slot2.buildingId) and ManufactureModel.instance:getManufactureMOById(slot1) and slot6:getSlot2CritterDict() or ManufactureModel.instance:getCritterBuildingMOById(slot1) and slot6:getSeatSlot2CritterDict()) then
		return
	end

	for slot9, slot10 in pairs(slot4) do
		slot12 = slot3:getCritterPoint(slot9)

		if not slot0:getCritterEntity(slot10) or gohelper.isNil(slot12) then
			return
		end

		slot13, slot14, slot15 = transformhelper.getPos(slot12.transform)

		slot11:setLocalPos(slot13, slot14, slot15)
	end
end

function slot0.destroyCritter(slot0, slot1)
	slot0:removeUnit(slot1:getTag(), slot1.id)
end

function slot0._onUpdate(slot0)
end

function slot0.getCritterEntity(slot0, slot1, slot2)
	slot3 = (not slot2 or slot2 == SceneTag.RoomCharacter) and slot0:getTagUnitDict(SceneTag.RoomCharacter)

	return slot3 and slot3[slot1]
end

function slot0.getRoomCritterEntityDict(slot0)
	return slot0._tagUnitDict[SceneTag.RoomCharacter] or {}
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)
	slot0:removeEventListeners()
	slot0:_stopRefreshAllTask()
end

return slot0

module("modules.logic.scene.room.comp.entitymgr.RoomSceneVehicleEntityMgr", package.seeall)

slot0 = class("RoomSceneVehicleEntityMgr", BaseSceneUnitMgr)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	slot0:_startSpawnVehicle()
end

function slot0.onStopMode(slot0)
	slot0:_onSwitchMode(true)
end

function slot0.onSwitchMode(slot0)
	slot0:_onSwitchMode(RoomController.instance:isEditMode())
end

function slot0._onSwitchMode(slot0, slot1)
	slot3 = slot0:getTagUnitDict(RoomMapVehicleEntity:getTag())

	if slot1 then
		slot0:_stopSpawnVehicle()

		if slot3 then
			for slot7, slot8 in pairs(slot3) do
				slot8:setShow(false)
			end
		end
	else
		if slot3 then
			for slot8, slot9 in pairs(slot3) do
				if RoomMapVehicleModel.instance:getById(slot8) then
					slot0:setVehiclePosByMO(slot9, slot10)
					slot9:setShow(true)
				else
					slot0:removeUnit(slot2, slot8)
				end
			end
		end

		slot0:_startSpawnVehicle()
	end
end

function slot0._stopSpawnVehicle(slot0)
	if slot0._isRuningSpawnVehicle then
		slot0._isRuningSpawnVehicle = false

		TaskDispatcher.cancelTask(slot0._onRepeatSpawnVehicle, slot0)
	end
end

function slot0._startSpawnVehicle(slot0)
	slot0._waitVehicleMOList = nil

	for slot6, slot7 in ipairs(RoomMapVehicleModel.instance:getList()) do
		if not slot0:getUnit(RoomMapVehicleEntity:getTag(), slot7.id) then
			slot0._waitVehicleMOList = slot0._waitVehicleMOList or {}

			table.insert(slot0._waitVehicleMOList, slot7)
		end
	end

	if slot0._waitVehicleMOList and not slot0._isRuningSpawnVehicle then
		slot0._isRuningSpawnVehicle = true

		TaskDispatcher.runRepeat(slot0._onRepeatSpawnVehicle, slot0, 0)
	end
end

function slot0._onRepeatSpawnVehicle(slot0)
	if slot0._waitVehicleMOList and #slot0._waitVehicleMOList > 0 then
		table.remove(slot0._waitVehicleMOList, 1)
		slot0:spawnMapVehicle(slot0._waitVehicleMOList[1])
	else
		slot0:_stopSpawnVehicle()
	end
end

function slot0.spawnMapVehicle(slot0, slot1)
	slot2 = slot0._scene.go.vehicleRoot
	slot3 = gohelper.create3d(slot2, slot1.id)
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot3, RoomMapVehicleEntity, slot1.id)

	slot0:addUnit(slot4)
	gohelper.addChild(slot2, slot3)
	slot0:setVehiclePosByMO(slot4, slot1)

	return slot4
end

function slot0.setVehiclePosByMO(slot0, slot1, slot2)
	if not ((slot2 or slot1:getMO()):getCurNode() and slot4.hexPoint) then
		logError("RoomSceneVehicleEntityMgr: 没有位置信息")

		return
	end

	slot6 = HexMath.hexToPosition(slot5, RoomBlockEnum.BlockSize)

	slot1:setLocalPos(slot6.x, RoomBuildingEnum.VehicleInitOffestY, slot6.y)
end

function slot0.getVehicleEntity(slot0, slot1)
	return slot0:getUnit(RoomMapVehicleEntity:getTag(), slot1)
end

function slot0.destroyVehicle(slot0, slot1)
	slot0:removeUnit(slot1:getTag(), slot1.id)
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)
	slot0:_stopSpawnVehicle()
end

return slot0

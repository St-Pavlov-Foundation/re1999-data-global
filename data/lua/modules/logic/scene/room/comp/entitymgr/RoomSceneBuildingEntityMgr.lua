module("modules.logic.scene.room.comp.entitymgr.RoomSceneBuildingEntityMgr", package.seeall)

slot0 = class("RoomSceneBuildingEntityMgr", BaseSceneUnitMgr)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	slot0:_spawnInitBuilding()
	slot0:_spawnPartBuilding()

	for slot7, slot8 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot8.buildingType ~= RoomBuildingEnum.BuildingType.Transport then
			slot0:spawnMapBuilding(slot8)
		end
	end

	for slot7 = 1, RoomBuildingEnum.MaxBuildingOccupyNum do
		slot0:spawnMapBuildingOccupy(slot7)
	end
end

function slot0._spawnInitBuilding(slot0)
	if not slot0:getUnit(SceneTag.RoomInitBuilding, 0) then
		slot3 = gohelper.findChild(slot0._scene.go.initbuildingRoot, "main")
		slot4 = gohelper.create3d(slot3, "initbuilding")

		slot0:addUnit(MonoHelper.addNoUpdateLuaComOnceToGo(slot4, RoomInitBuildingEntity, 0))
		gohelper.addChild(slot3, slot4)
		transformhelper.setLocalPos(slot4.transform, 0, 0, 0)

		slot0._initBuildingGO = slot4
	end

	slot1:refreshBuilding()
end

function slot0._spawnPartBuilding(slot0)
	slot0._partBuildingGODict = slot0._partBuildingGODict or {}

	for slot4, slot5 in ipairs(lua_production_part.configList) do
		if not slot0:getUnit(SceneTag.RoomPartBuilding, slot5.id) then
			slot8 = slot0:getPartContainerGO(slot6)
			slot9 = gohelper.create3d(slot8, "partbuilding")

			slot0:addUnit(MonoHelper.addNoUpdateLuaComOnceToGo(slot9, RoomPartBuildingEntity, slot6))
			gohelper.addChild(slot8, slot9)
			transformhelper.setLocalPos(slot9.transform, 0, 0, 0)

			slot0._partBuildingGODict[slot6] = slot9
		end

		slot7:refreshBuilding()
	end
end

function slot0.spawnMapBuilding(slot0, slot1)
	slot2 = slot0._scene.go.buildingRoot

	if not slot1.hexPoint then
		logError("RoomSceneBuildingEntityMgr: 没有位置信息")

		return
	end

	slot4 = HexMath.hexToPosition(slot3, RoomBlockEnum.BlockSize)

	if not slot0:getBuildingEntity(slot1.id, SceneTag.RoomBuilding) then
		slot6 = gohelper.create3d(slot2, RoomResHelper.getBlockName(slot3))

		slot0:addUnit(MonoHelper.addNoUpdateLuaComOnceToGo(slot6, RoomBuildingEntity, slot1.id))
		gohelper.addChild(slot2, slot6)
	end

	slot5:setLocalPos(slot4.x, 0, slot4.y)
	slot5:refreshBuilding()
	slot5:refreshRotation()

	return slot5
end

function slot0.spawnMapBuildingOccupy(slot0, slot1)
	if not slot0:getBuildingOccupy(slot1) then
		slot3 = slot0._scene.go.buildingRoot
		slot4 = gohelper.create3d(slot3, "BuildingOccupy_" .. slot1)

		gohelper.addChild(slot3, slot4)
		slot0:addUnit(MonoHelper.addNoUpdateLuaComOnceToGo(slot4, RoomBuildingOccupyEntity, slot1))
	end

	return slot2
end

function slot0.onSwitchMode(slot0)
	if slot0:getMapBuildingEntityDict() then
		slot3 = SceneTag.RoomBuilding
		slot4 = {}

		for slot8, slot9 in pairs(slot1) do
			if not RoomMapBuildingModel.instance:getBuildingMOById(slot8) then
				table.insert(slot4, slot8)
			end
		end

		for slot8 = 1, #slot4 do
			slot0:removeUnit(slot3, slot4[slot8])
		end
	end
end

function slot0.getBuildingOccupy(slot0, slot1)
	return slot0:getUnit(RoomBuildingOccupyEntity:getTag(), slot1)
end

function slot0.moveTo(slot0, slot1, slot2)
	slot3 = HexMath.hexToPosition(slot2, RoomBlockEnum.BlockSize)

	slot1:setLocalPos(slot3.x, 0, slot3.y)
end

function slot0.destroyBuilding(slot0, slot1)
	slot0:removeUnit(slot1:getTag(), slot1.id)
end

function slot0.getBuildingEntity(slot0, slot1, slot2)
	slot3 = (not slot2 or slot2 == SceneTag.RoomBuilding) and slot0:getTagUnitDict(SceneTag.RoomBuilding)

	return slot3 and slot3[slot1]
end

function slot0.changeBuildingEntityId(slot0, slot1, slot2)
	if slot1 and slot1 ~= slot2 and slot0:getMapBuildingEntityDict() and slot3[slot1] and not slot3[slot2] then
		slot4 = slot3[slot1]
		slot3[slot2] = slot4
		slot3[slot1] = nil

		slot4:setEntityId(slot2)
	end
end

function slot0.getMapBuildingEntityDict(slot0)
	return slot0._tagUnitDict[SceneTag.RoomBuilding]
end

function slot0.getInitBuildingGO(slot0)
	return slot0._initBuildingGO
end

function slot0.getPartBuildingGO(slot0, slot1)
	return slot0._partBuildingGODict and slot0._partBuildingGODict[slot1]
end

function slot0.getPartContainerGO(slot0, slot1)
	if slot0._scene then
		return slot0._scene.go:getPartGOById(slot1)
	end
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)

	slot0._initBuildingGO = nil
	slot0._partBuildingGODict = nil
end

return slot0

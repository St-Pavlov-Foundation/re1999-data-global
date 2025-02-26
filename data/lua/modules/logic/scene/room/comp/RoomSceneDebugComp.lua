module("modules.logic.scene.room.comp.RoomSceneDebugComp", package.seeall)

slot0 = class("RoomSceneDebugComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	if RoomController.instance:isDebugMode() then
		RoomDebugController.instance:registerCallback(RoomEvent.DebugConfirmPlaceBlock, slot0._debugConfirmPlaceBlock, slot0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRotateBlock, slot0._debugRotateBlock, slot0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBlock, slot0._debugRootOutBlock, slot0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugReplaceBlock, slot0._debugReplaceBlock, slot0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, slot0._debugSetPackage, slot0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugPlaceBuilding, slot0._debugPlaceBuilding, slot0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRotateBuilding, slot0._debugRotateBuilding, slot0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBuilding, slot0._debugRootOutBuilding, slot0)
	end

	if isDebugBuild then
		TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.01)
	end
end

function slot0._onFrame(slot0)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.S) then
		logNormal(string.format("一共放置了%d个地块", RoomMapBlockModel.instance:getConfirmBlockCount()))
	end
end

function slot0._debugConfirmPlaceBlock(slot0, slot1, slot2, slot3)
	if slot0._scene.mapmgr:getBlockEntity(slot3 and slot3.id, SceneTag.RoomEmptyBlock) then
		slot0._scene.mapmgr:destroyBlock(slot4)
	end

	slot5 = slot0._scene.mapmgr:spawnMapBlock(slot2)

	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(false, slot1, 1, true), "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(true, slot1, 1, true), "refreshWaveEffect")

	for slot13, slot14 in ipairs(slot2.hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)) do
		if RoomMapBlockModel.instance:getBlockMO(slot14.x, slot14.y) and slot15.blockState == RoomBlockEnum.BlockState.Water then
			slot16 = slot0._scene.mapmgr:getBlockEntity(slot15.id, SceneTag.RoomEmptyBlock) or slot0._scene.mapmgr:spawnMapBlock(slot15)
		end
	end
end

function slot0._debugRotateBlock(slot0, slot1, slot2)
	if slot0._scene.mapmgr:getBlockEntity(slot2.id, SceneTag.RoomMapBlock) then
		slot3:refreshRotation()
		slot3:refreshBlock()
	end

	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(false, slot1, 1, true), "refreshBlock")
end

function slot0._debugRootOutBlock(slot0, slot1, slot2, slot3)
	if slot0._scene.mapmgr:getBlockEntity(slot2.id, SceneTag.RoomMapBlock) then
		slot0._scene.mapmgr:destroyBlock(slot4)
	end

	if RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y) and slot5.blockState == RoomBlockEnum.BlockState.Water then
		slot6 = slot0._scene.mapmgr:getBlockEntity(slot5.id, SceneTag.RoomEmptyBlock) or slot0._scene.mapmgr:spawnMapBlock(slot5)
	end

	for slot9, slot10 in ipairs(slot3) do
		if slot0._scene.mapmgr:getBlockEntity(slot10.id, SceneTag.RoomEmptyBlock) then
			slot0._scene.mapmgr:destroyBlock(slot11)
		end
	end

	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(false, slot1, 1, true), "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(true, slot1, 1, true), "refreshWaveEffect")
end

function slot0._debugReplaceBlock(slot0, slot1, slot2)
	if slot0._scene.mapmgr:getBlockEntity(slot2.id, SceneTag.RoomMapBlock) then
		slot3:refreshBlock()
	end

	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(false, slot1, 1, true), "refreshBlock")
end

function slot0._debugSetPackage(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	if slot0._scene.mapmgr:getBlockEntity(slot2.id, SceneTag.RoomMapBlock) then
		slot3:refreshPackage()
	end

	RoomDebugPackageListModel.instance:setDebugPackageList()
end

function slot0._debugPlaceBuilding(slot0, slot1, slot2)
	slot3 = slot0._scene.buildingmgr:spawnMapBuilding(slot2)
	slot4 = RoomBlockHelper.getNearBlockEntityByBuilding(false, slot2.buildingId, slot2.hexPoint, slot2.rotate)

	RoomBlockHelper.refreshBlockResourceType(slot4)
	RoomBlockHelper.refreshBlockEntity(slot4, "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntityByBuilding(true, slot2.buildingId, slot2.hexPoint, slot2.rotate), "refreshWaveEffect")
end

function slot0._debugRotateBuilding(slot0, slot1, slot2, slot3)
	if slot0._scene.buildingmgr:getBuildingEntity(slot2.id, SceneTag.RoomBuilding) then
		slot4:refreshRotation()
	end

	slot5 = RoomBlockHelper.getNearBlockEntityByBuilding(false, slot2.buildingId, slot2.hexPoint, slot3)

	RoomBlockHelper.refreshBlockResourceType(slot5)
	RoomBlockHelper.refreshBlockEntity(slot5, "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntityByBuilding(true, slot2.buildingId, slot2.hexPoint, slot3), "refreshWaveEffect")

	slot7 = RoomBlockHelper.getNearBlockEntityByBuilding(false, slot2.buildingId, slot2.hexPoint, slot2.rotate)

	RoomBlockHelper.refreshBlockResourceType(slot7)
	RoomBlockHelper.refreshBlockEntity(slot7, "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntityByBuilding(true, slot2.buildingId, slot2.hexPoint, slot2.rotate), "refreshWaveEffect")
end

function slot0._debugRootOutBuilding(slot0, slot1, slot2)
	if slot0._scene.buildingmgr:getBuildingEntity(slot2.id, SceneTag.RoomBuilding) then
		slot0._scene.buildingmgr:destroyBuilding(slot3)
	end

	slot4 = RoomBlockHelper.getNearBlockEntityByBuilding(false, slot2.buildingId, slot2.hexPoint, slot2.rotate)

	RoomBlockHelper.refreshBlockResourceType(slot4)
	RoomBlockHelper.refreshBlockEntity(slot4, "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntityByBuilding(true, slot2.buildingId, slot2.hexPoint, slot2.rotate), "refreshWaveEffect")
end

function slot0.onSceneClose(slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugConfirmPlaceBlock, slot0._debugConfirmPlaceBlock, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRotateBlock, slot0._debugRotateBlock, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBlock, slot0._debugRootOutBlock, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugReplaceBlock, slot0._debugReplaceBlock, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, slot0._debugSetPackage, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPlaceBuilding, slot0._debugPlaceBuilding, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRotateBuilding, slot0._debugRotateBuilding, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBuilding, slot0._debugRootOutBuilding, slot0)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
end

return slot0

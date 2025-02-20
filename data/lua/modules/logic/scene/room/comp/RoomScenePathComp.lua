module("modules.logic.scene.room.comp.RoomScenePathComp", package.seeall)

slot0 = class("RoomScenePathComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	if RoomEnum.UseAStarPath then
		if RoomEnum.MeshUseOptimize then
			slot3, slot4, slot5, slot6 = RoomMapBlockModel.instance:getFullMapSizeAndCenter()

			ZProj.AStarPathBridge.ScanAStarMesh(slot3, slot4, slot5, slot6)
		else
			ZProj.AStarPathBridge.ScanAStarMesh()
		end
	end

	slot0._isInited = true
end

function slot0.tryGetPath(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0._scene.charactermgr:getCharacterEntity(slot1.id) then
		return
	end

	if not slot7.charactermove:getSeeker() then
		return
	end

	slot8:RemoveOnPathCall()
	slot8:AddOnPathCall(slot4, slot5, slot6)
	slot8:StartPath(slot2, slot3)
end

function slot0.stopGetPath(slot0, slot1)
	if not slot0._scene.charactermgr:getCharacterEntity(slot1.id) then
		return
	end

	if not slot2.charactermove:getSeeker() then
		return
	end

	slot3:RemoveOnPathCall()
end

function slot0.updatePathGraphic(slot0, slot1)
	if not slot0._isInited then
		return
	end

	ZProj.AStarPathBridge.UpdateColliderGrid(slot1, GameSceneMgr.instance:isLoading() and 0 or 0.1)
	RoomCharacterModel.instance:clearNodePositionList()
end

function slot0.addPathCollider(slot0, slot1)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		slot0._needPathGOs = slot0._needPathGOs or {}

		table.insert(slot0._needPathGOs, slot1)

		return
	end

	if not gohelper.isNil(slot1) then
		slot2 = {}
		slot6 = "#collider"
		slot7 = slot2

		ZProj.AStarPathBridge.FindChildrenByName(slot1, slot6, slot7)

		for slot6, slot7 in ipairs(slot2) do
			gohelper.setLayer(slot7, UnityLayer.Scene, true)
			slot0:updatePathGraphic(slot7)
		end
	end
end

function slot0.doNeedPathGOs(slot0)
	if slot0._needPathGOs then
		for slot5, slot6 in ipairs(tabletool.copy(slot0._needPathGOs)) do
			if not gohelper.isNil(slot6) then
				slot0:addPathCollider(slot6)
			end
		end
	end

	slot0._needPathGOs = nil
end

function slot0.onSceneClose(slot0)
	slot0._isInited = false
	slot0._needPathGOs = nil

	if RoomEnum.UseAStarPath then
		ZProj.AStarPathBridge.StopScan()
	end

	RoomVectorPool.instance:clean()
	ZProj.AStarPathBridge.CleanCache()
end

function slot0.addEntityCollider(slot0)
	if not RoomEnum.UseAStarPath then
		return
	end

	if GameSceneMgr.instance:getCurScene().path and not gohelper.isNil(slot0) then
		slot1.path:addPathCollider(slot0)
	end
end

function slot0.getNearestNodeHeight(slot0, slot1)
	if not RoomEnum.UseAStarPath or not slot0._isInited then
		return 0
	end

	slot2, slot3 = ZProj.AStarPathBridge.GetNearestNodeHeight(slot1, 0)

	if not slot2 then
		return 0
	end

	return slot3
end

return slot0

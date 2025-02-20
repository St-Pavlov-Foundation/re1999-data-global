module("modules.logic.scene.room.comp.RoomSceneWaterComp", package.seeall)

slot0 = class("RoomSceneWaterComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._waterGODict = {}
	slot0._waterRes = RoomResHelper.getWaterPath()
	slot0._waterRoot = slot0._scene.go.waterRoot

	RoomMapController.instance:registerCallback(RoomEvent.UpdateWater, slot0._updateWater, slot0)
	slot0:_refreshWaterGO()
end

function slot0._updateWater(slot0)
	slot0:_refreshWaterGO()
end

function slot0._refreshWaterGO(slot0)
	slot1 = RoomMapBlockModel.instance:getConvexHull()

	for slot6, slot7 in pairs(RoomMapBlockModel.instance:getConvexHexPointDict()) do
		for slot11, slot12 in pairs(slot7) do
			if RoomMapBlockModel.instance:getBlockMO(slot6, slot11) then
				slot2[slot6][slot11] = nil
			end
		end
	end

	for slot6, slot7 in pairs(slot2) do
		for slot11, slot12 in pairs(slot7) do
			if not slot0._waterGODict[slot6] or not slot0._waterGODict[slot6][slot11] then
				slot0._waterGODict[slot6] = slot0._waterGODict[slot6] or {}

				if RoomGOPool.getInstance(slot0._waterRes, slot0._waterRoot, RoomResHelper.getBlockName(HexPoint(slot6, slot11))) then
					slot15 = HexMath.hexToPosition(slot13, RoomBlockEnum.BlockSize)

					transformhelper.setLocalPos(slot14.transform, slot15.x, 0, slot15.y)

					slot0._waterGODict[slot6][slot11] = slot14
				end
			end
		end
	end

	for slot6, slot7 in pairs(slot0._waterGODict) do
		for slot11, slot12 in pairs(slot7) do
			if not slot2[slot6] or not slot2[slot6][slot11] then
				RoomGOPool.returnInstance(slot0._waterRes, slot12)

				slot0._waterGODict[slot6][slot11] = nil
			end
		end
	end
end

function slot0.onSceneClose(slot0)
	slot4 = RoomEvent.UpdateWater
	slot5 = slot0._updateWater

	RoomMapController.instance:unregisterCallback(slot4, slot5, slot0)

	for slot4, slot5 in pairs(slot0._waterGODict) do
		for slot9, slot10 in pairs(slot5) do
			RoomGOPool.returnInstance(slot0._waterRes, slot10)
		end
	end

	slot0._waterGODict = nil
	slot0._prefab = nil
	slot0._waterRoot = nil
end

return slot0

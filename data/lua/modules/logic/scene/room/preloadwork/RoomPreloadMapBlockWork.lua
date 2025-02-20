module("modules.logic.scene.room.preloadwork.RoomPreloadMapBlockWork", package.seeall)

slot0 = class("RoomPreloadMapBlockWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot2 = slot0:_getMapBlockUrlList()
	slot0._loader = MultiAbLoader.New()

	if GameResMgr.IsFromEditorDir then
		for slot6, slot7 in ipairs(slot2) do
			slot0._loader:addPath(slot7)
		end
	else
		for slot6, slot7 in pairs(slot2) do
			slot0._loader:addPath(slot6)
		end
	end

	slot3 = tabletool.len(slot2)
	slot0._timestamp = Time.GetTimestamp()

	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0, slot1)
	for slot6, slot7 in pairs(slot1:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot6, slot7)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("RoomPreloadMapBlockWork: 加载失败, url: " .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getMapBlockUrlList(slot0)
	slot1 = {}
	slot2 = {}
	slot8 = "ground/water/water"

	table.insert(slot1, ResUrl.getRoomRes(slot8))
	table.insert(slot1, RoomScenePreloader.InitLand)

	slot3, slot4 = slot0:_findDefineBlockAndWaterTypes()

	for slot8 = 1, #slot3 do
		slot9 = slot3[slot8]

		slot0:_addRiverFloorUrlByBlockType(slot1, RoomRiverEnum.LakeFloorType, slot9)
		slot0:_addRiverFloorUrlByBlockType(slot1, RoomRiverEnum.LakeFloorBType, slot9)
		slot0:_addRiverFloorUrlByBlockType(slot1, RoomRiverEnum.RiverBlockType, slot9)
		table.insert(slot1, RoomResHelper.getBlockLandPath(slot9, false)[1])
		table.insert(slot1, RoomResHelper.getBlockLandPath(slot9, true)[1])
	end

	for slot8 = 1, #slot4 do
		slot9 = slot4[slot8]

		slot0:_addWaterBlockUrlByWaterType(slot1, RoomRiverEnum.RiverBlockType, slot9)
		slot0:_addWaterBlockUrlByWaterType(slot1, RoomRiverEnum.LakeBlockType, slot9)
	end

	for slot9, slot10 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		table.insert(slot1, RoomResHelper.getBuildingPath(slot10.buildingId, slot10.level))
	end

	for slot9, slot10 in ipairs(slot1) do
		slot0.context.poolGODict[slot10] = 1
		slot2[slot10] = 1
	end

	if GameResMgr.IsFromEditorDir then
		return slot1
	else
		return slot2
	end
end

function slot0._addRiverFloorUrlByBlockType(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot2) do
		slot9, slot10 = RoomResHelper.getMapRiverFloorResPath(slot8, slot3)

		table.insert(slot1, slot10)
	end
end

function slot0._addWaterBlockUrlByWaterType(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot2) do
		slot9, slot10 = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, slot8, slot3)

		table.insert(slot1, slot10)
	end
end

function slot0._findDefineBlockAndWaterTypes(slot0)
	slot2 = {}
	slot3 = {}

	for slot7 = 1, #RoomMapBlockModel.instance:getFullBlockMOList() do
		slot8 = slot1[slot7]
		slot10 = slot8:getDefineWaterType()

		if not tabletool.indexOf(slot2, slot8:getDefineBlockType()) then
			table.insert(slot2, slot9)
		end

		if not tabletool.indexOf(slot3, slot10) then
			table.insert(slot3, slot10)
		end
	end

	return slot2, slot3
end

return slot0

module("modules.logic.rouge.map.map.RougeLayerMap", package.seeall)

slot0 = class("RougeLayerMap", RougeBaseMap)

function slot0.initMap(slot0)
	uv0.super.initMap(slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onMapPosChange, slot0.setMapPos, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onNodeEventStatusChange, slot0.onNodeEventStatusChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onFocusNormalLayerActor, slot0.focusActor, slot0)
	RougeMapModel.instance:setCameraSize(slot0:getCameraSize())
	slot0:updateMapXRange()
	RougeMapModel.instance:setMapPosX(RougeMapModel.instance.maxX)
	slot0:setMapPos(RougeMapModel.instance:getMapPosX())
end

function slot0.updateMapXRange(slot0)
	slot3 = RougeMapHelper.getUIRoot().transform:GetWorldCorners()
	slot9 = (slot3[3].x - slot3[1].x) * RougeMapModel.instance:getCameraSize() / CameraMgr.instance:getUICamera().orthographicSize
	slot12 = -slot9 / 2
	slot13 = nil

	RougeMapModel.instance:setMapXRange(RougeMapModel.instance:getMapSize().x <= slot9 and slot12 or slot12 - (slot11 - slot9), slot12)
end

function slot0.getCameraSize(slot0)
	return RougeMapHelper.getNormalLayerCameraSize()
end

function slot0.onScreenSizeChanged(slot0)
	uv0.super.onScreenSizeChanged(slot0)
	slot0:updateMapXRange()
	RougeMapModel.instance:setMapPosX(RougeMapModel.instance:getMapPosX())
end

function slot0.createMapNodeContainer(slot0)
	slot0.goLayerNodeContainer = gohelper.create3d(slot0.mapGo, "layerNodeContainer")
	slot0.goLayerLinePathContainer = gohelper.create3d(slot0.mapGo, "layerLinePathContainer")

	transformhelper.setLocalPos(slot0.goLayerNodeContainer.transform, 0, 0, RougeMapEnum.OffsetZ.NodeContainer)
	transformhelper.setLocalPos(slot0.goLayerLinePathContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PathContainer)

	slot0.goLayerPiecesContainer = gohelper.findChild(slot0.mapGo, "layerPiecesContainer")
	slot0.trLayerPiecesContainer = slot0.goLayerPiecesContainer.transform

	transformhelper.setLocalPos(slot0.goLayerPiecesContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PiecesContainer)
end

function slot0.handleOtherRes(slot0, slot1)
	slot0.linePrefab = slot1:getAssetItem(RougeMapEnum.LinePrefabRes):GetResource()
	slot0.lineIconDict = slot0:getUserDataTb_()

	for slot6, slot7 in pairs(RougeMapEnum.LineIconRes) do
		slot0.lineIconDict[slot6] = slot1:getAssetItem(slot7):GetResource()
	end

	slot0.iconPrefabDict = slot0:getUserDataTb_()

	for slot6, slot7 in pairs(RougeMapEnum.EventType) do
		if not string.nilorempty(RougeMapEnum.IconPath[slot7]) then
			slot0.iconPrefabDict[slot7] = slot1:getAssetItem(RougeMapHelper.getScenePath(slot8)):GetResource()
		end
	end

	slot0.nodeBgPrefabDict = {}

	for slot6, slot7 in pairs(RougeMapEnum.NodeBgPath) do
		slot0.nodeBgPrefabDict[slot6] = slot0:getUserDataTb_()

		for slot12, slot13 in pairs(slot7) do
			slot8[slot12] = slot1:getAssetItem(RougeMapHelper.getScenePath(slot13)):GetResource()
		end
	end

	slot0.startBgPrefab = slot1:getAssetItem(RougeMapHelper.getScenePath(RougeMapEnum.StartNodeBgPath)):GetResource()
end

function slot0.handleDLCRes(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		RougeMapDLCResHelper.handleLoadMapDLCRes(slot7, slot1, slot0)
	end
end

function slot0.createMap(slot0)
	slot0.episodeItemList = {}
	slot0.lineItemList = {}

	for slot5, slot6 in ipairs(RougeMapModel.instance:getEpisodeList()) do
		slot7 = RougeMapEpisodeItem.New()

		slot7:init(slot6, slot0)
		table.insert(slot0.episodeItemList, slot7)
		slot0:addMapItemList(slot7:getNodeItemList())
		slot0:createLinePath(slot5)
	end

	slot0.goActor = gohelper.findChild(slot0.mapGo, "layerPiecesContainer/actor")
	slot0.actorComp = RougeMapNormalLayerActorComp.New()

	slot0.actorComp:init(slot0.goActor, slot0)
	slot0:createDLCMap()
	uv0.super.createMap(slot0)
end

function slot0.createDLCMap(slot0)
	for slot5, slot6 in ipairs(RougeModel.instance:getVersion()) do
		RougeMapDLCResHelper.handleCreateMapDLC(slot6, slot0)
	end
end

function slot0.getNodeBgPrefab(slot0, slot1, slot2)
	slot4 = nil

	return ((not (slot1 and slot1.specialUI == 1) or slot0.nodeBgPrefabDict.Special) and slot0.nodeBgPrefabDict.Normal)[slot2]
end

function slot0.getNodeIconPrefab(slot0, slot1)
	if not slot0.iconPrefabDict[slot1.type] then
		logError(string.format("not icon prefab, eventCo.id : %s, type : %s", slot1.id, slot1.type))

		return slot0.iconPrefabDict[RougeMapEnum.EventType.NormalFight]
	end

	return slot0.iconPrefabDict[slot1.type]
end

function slot0.createLinePath(slot0, slot1)
	if slot1 == 1 then
		return
	end

	for slot7, slot8 in ipairs(slot0.episodeItemList[slot1].episodeMo:getNodeMoList()) do
		for slot13, slot14 in ipairs(slot8.preNodeList) do
			slot0:getMapItem(slot8.nodeId).lineItem = slot0:createLineItem(slot8, RougeMapModel.instance:getNode(slot14))
		end
	end
end

function slot0.createLineItem(slot0, slot1, slot2)
	slot3 = RougeMapLineItem.New()

	slot3:init(gohelper.clone(slot0.linePrefab, slot0.goLayerLinePathContainer), slot0)
	slot3:drawLine(slot1, slot2)
	table.insert(slot0.lineItemList, slot3)

	return slot3
end

function slot0.setMapPos(slot0, slot1)
	transformhelper.setLocalPos(slot0.mapTransform, slot1, RougeMapModel.instance:getMapSize().y / 2, RougeMapEnum.OffsetZ.Map)
end

function slot0.onNodeEventStatusChange(slot0, slot1, slot2)
	if slot2 == RougeMapEnum.EventState.Finish then
		slot0:focusActor()
	end
end

function slot0.focusActor(slot0)
	slot2 = slot0.actorComp:getActorWordPos()

	RougeMapModel.instance:setMapPosX(RougeMapModel.instance:getMapPosX() - (slot2.x - recthelper.screenPosToWorldPos3(Vector2(RougeMapModel.instance:getFocusScreenPosX(), 0), nil, slot2)))
end

function slot0.getActorPos(slot0)
	return slot0:getMapItem(RougeMapModel.instance:getCurNode().nodeId):getActorPos()
end

function slot0.destroy(slot0)
	for slot4, slot5 in ipairs(slot0.lineItemList) do
		slot5:destroy()
	end

	for slot4, slot5 in ipairs(slot0.episodeItemList) do
		slot5:destroy()
	end

	uv0.super.destroy(slot0)
end

return slot0

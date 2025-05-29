module("modules.logic.rouge.map.map.RougeLayerMap", package.seeall)

local var_0_0 = class("RougeLayerMap", RougeBaseMap)

function var_0_0.initMap(arg_1_0)
	var_0_0.super.initMap(arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onMapPosChange, arg_1_0.setMapPos, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onNodeEventStatusChange, arg_1_0.onNodeEventStatusChange, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onFocusNormalLayerActor, arg_1_0.focusActor, arg_1_0)

	local var_1_0 = arg_1_0:getCameraSize()

	RougeMapModel.instance:setCameraSize(var_1_0)
	arg_1_0:updateMapXRange()
	RougeMapModel.instance:setMapPosX(RougeMapModel.instance.maxX)
	arg_1_0:setMapPos(RougeMapModel.instance:getMapPosX())
end

function var_0_0.updateMapXRange(arg_2_0)
	local var_2_0 = RougeMapModel.instance:getCameraSize()
	local var_2_1 = RougeMapHelper.getUIRoot().transform:GetWorldCorners()
	local var_2_2 = var_2_0 / CameraMgr.instance:getUICamera().orthographicSize
	local var_2_3 = var_2_1[1]
	local var_2_4 = (var_2_1[3].x - var_2_3.x) * var_2_2
	local var_2_5 = RougeMapModel.instance:getMapSize().x
	local var_2_6 = -var_2_4 / 2 - RougeMapModel.instance:getMapStartOffsetX() + RougeMapEnum.MapStartOffsetX
	local var_2_7

	if var_2_5 <= var_2_4 then
		var_2_7 = var_2_6
	else
		var_2_7 = var_2_6 - (var_2_5 - var_2_4)
	end

	RougeMapModel.instance:setMapXRange(var_2_7, var_2_6)
end

function var_0_0.getCameraSize(arg_3_0)
	return RougeMapHelper.getNormalLayerCameraSize()
end

function var_0_0.onScreenSizeChanged(arg_4_0)
	var_0_0.super.onScreenSizeChanged(arg_4_0)

	local var_4_0 = RougeMapModel.instance:getMapPosX()

	arg_4_0:updateMapXRange()
	RougeMapModel.instance:setMapPosX(var_4_0)
end

function var_0_0.createMapNodeContainer(arg_5_0)
	arg_5_0.goLayerNodeContainer = gohelper.create3d(arg_5_0.mapGo, "layerNodeContainer")
	arg_5_0.goLayerLinePathContainer = gohelper.create3d(arg_5_0.mapGo, "layerLinePathContainer")

	transformhelper.setLocalPos(arg_5_0.goLayerNodeContainer.transform, 0, 0, RougeMapEnum.OffsetZ.NodeContainer)
	transformhelper.setLocalPos(arg_5_0.goLayerLinePathContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PathContainer)

	arg_5_0.goLayerPiecesContainer = gohelper.findChild(arg_5_0.mapGo, "layerPiecesContainer")
	arg_5_0.trLayerPiecesContainer = arg_5_0.goLayerPiecesContainer.transform

	transformhelper.setLocalPos(arg_5_0.goLayerPiecesContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PiecesContainer)
end

function var_0_0.handleOtherRes(arg_6_0, arg_6_1)
	arg_6_0.linePrefab = arg_6_1:getAssetItem(RougeMapEnum.LinePrefabRes):GetResource()
	arg_6_0.lineIconDict = arg_6_0:getUserDataTb_()

	for iter_6_0, iter_6_1 in pairs(RougeMapEnum.LineIconRes) do
		arg_6_0.lineIconDict[iter_6_0] = arg_6_1:getAssetItem(iter_6_1):GetResource()
	end

	arg_6_0.iconPrefabDict = arg_6_0:getUserDataTb_()

	for iter_6_2, iter_6_3 in pairs(RougeMapEnum.EventType) do
		local var_6_0 = RougeMapEnum.IconPath[iter_6_3]

		if not string.nilorempty(var_6_0) then
			local var_6_1 = RougeMapHelper.getScenePath(var_6_0)

			arg_6_0.iconPrefabDict[iter_6_3] = arg_6_1:getAssetItem(var_6_1):GetResource()
		end
	end

	arg_6_0.nodeBgPrefabDict = {}

	for iter_6_4, iter_6_5 in pairs(RougeMapEnum.NodeBgPath) do
		local var_6_2 = arg_6_0:getUserDataTb_()

		arg_6_0.nodeBgPrefabDict[iter_6_4] = var_6_2

		for iter_6_6, iter_6_7 in pairs(iter_6_5) do
			local var_6_3 = RougeMapHelper.getScenePath(iter_6_7)

			var_6_2[iter_6_6] = arg_6_1:getAssetItem(var_6_3):GetResource()
		end
	end

	arg_6_0.startBgPrefab = arg_6_1:getAssetItem(RougeMapHelper.getScenePath(RougeMapEnum.StartNodeBgPath)):GetResource()
end

function var_0_0.handleDLCRes(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		RougeMapDLCResHelper.handleLoadMapDLCRes(iter_7_1, arg_7_1, arg_7_0)
	end
end

function var_0_0.createMap(arg_8_0)
	local var_8_0 = RougeMapModel.instance:getEpisodeList()

	arg_8_0.episodeItemList = {}
	arg_8_0.lineItemList = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = RougeMapEpisodeItem.New()

		var_8_1:init(iter_8_1, arg_8_0)
		table.insert(arg_8_0.episodeItemList, var_8_1)
		arg_8_0:addMapItemList(var_8_1:getNodeItemList())
		arg_8_0:createLinePath(iter_8_0)
	end

	arg_8_0.goActor = gohelper.findChild(arg_8_0.mapGo, "layerPiecesContainer/actor")
	arg_8_0.actorComp = RougeMapNormalLayerActorComp.New()

	arg_8_0.actorComp:init(arg_8_0.goActor, arg_8_0)
	arg_8_0:createDLCMap()
	var_0_0.super.createMap(arg_8_0)
end

function var_0_0.createDLCMap(arg_9_0)
	local var_9_0 = RougeModel.instance:getVersion()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		RougeMapDLCResHelper.handleCreateMapDLC(iter_9_1, arg_9_0)
	end
end

function var_0_0.getNodeBgPrefab(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1 and arg_10_1.specialUI == 1
	local var_10_1

	if var_10_0 then
		var_10_1 = arg_10_0.nodeBgPrefabDict.Special
	else
		var_10_1 = arg_10_0.nodeBgPrefabDict.Normal
	end

	return var_10_1[arg_10_2]
end

function var_0_0.getNodeIconPrefab(arg_11_0, arg_11_1)
	if not arg_11_0.iconPrefabDict[arg_11_1.type] then
		logError(string.format("not icon prefab, eventCo.id : %s, type : %s", arg_11_1.id, arg_11_1.type))

		return arg_11_0.iconPrefabDict[RougeMapEnum.EventType.NormalFight]
	end

	return arg_11_0.iconPrefabDict[arg_11_1.type]
end

function var_0_0.createLinePath(arg_12_0, arg_12_1)
	if arg_12_1 == 1 then
		return
	end

	local var_12_0 = arg_12_0.episodeItemList[arg_12_1].episodeMo

	for iter_12_0, iter_12_1 in ipairs(var_12_0:getNodeMoList()) do
		local var_12_1 = iter_12_1.nodeId

		for iter_12_2, iter_12_3 in ipairs(iter_12_1.preNodeList) do
			local var_12_2 = RougeMapModel.instance:getNode(iter_12_3)

			arg_12_0:getMapItem(var_12_1).lineItem = arg_12_0:createLineItem(iter_12_1, var_12_2)
		end
	end
end

function var_0_0.createLineItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = RougeMapLineItem.New()
	local var_13_1 = gohelper.clone(arg_13_0.linePrefab, arg_13_0.goLayerLinePathContainer)

	var_13_0:init(var_13_1, arg_13_0)
	var_13_0:drawLine(arg_13_1, arg_13_2)
	table.insert(arg_13_0.lineItemList, var_13_0)

	return var_13_0
end

function var_0_0.setMapPos(arg_14_0, arg_14_1)
	local var_14_0 = RougeMapModel.instance:getMapSize()

	transformhelper.setLocalPos(arg_14_0.mapTransform, arg_14_1, var_14_0.y / 2, RougeMapEnum.OffsetZ.Map)
end

function var_0_0.onNodeEventStatusChange(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 == RougeMapEnum.EventState.Finish then
		arg_15_0:focusActor()
	end
end

function var_0_0.focusActor(arg_16_0)
	local var_16_0 = RougeMapModel.instance:getFocusScreenPosX()
	local var_16_1 = arg_16_0.actorComp:getActorWordPos()
	local var_16_2 = recthelper.screenPosToWorldPos3(Vector2(var_16_0, 0), nil, var_16_1)
	local var_16_3 = var_16_1.x - var_16_2
	local var_16_4 = RougeMapModel.instance:getMapPosX() - var_16_3

	RougeMapModel.instance:setMapPosX(var_16_4)
end

function var_0_0.getActorPos(arg_17_0)
	local var_17_0 = RougeMapModel.instance:getCurNode()

	return arg_17_0:getMapItem(var_17_0.nodeId):getActorPos()
end

function var_0_0.destroy(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.lineItemList) do
		iter_18_1:destroy()
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_0.episodeItemList) do
		iter_18_3:destroy()
	end

	var_0_0.super.destroy(arg_18_0)
end

return var_0_0

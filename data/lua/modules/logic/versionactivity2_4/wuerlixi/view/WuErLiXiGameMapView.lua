module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapView", package.seeall)

local var_0_0 = class("WuErLiXiGameMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomaproot = gohelper.findChild(arg_1_0.viewGO, "#go_maproot")
	arg_1_0._gonodes = gohelper.findChild(arg_1_0.viewGO, "#go_maproot/#go_nodes")
	arg_1_0._gonodeitem = gohelper.findChild(arg_1_0.viewGO, "#go_maproot/#go_nodes/#scroll_node/viewport/content/#go_nodeitem")
	arg_1_0._gorays = gohelper.findChild(arg_1_0.viewGO, "#go_maproot/#go_ray")
	arg_1_0._gorayitem = gohelper.findChild(arg_1_0.viewGO, "#go_maproot/#go_ray/#go_rayitem")
	arg_1_0._gounits = gohelper.findChild(arg_1_0.viewGO, "#go_maproot/#go_units")
	arg_1_0._gounititem = gohelper.findChild(arg_1_0.viewGO, "#go_maproot/#go_units/#go_unititem")
	arg_1_0._godragitem = gohelper.findChild(arg_1_0.viewGO, "#go_dragitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._gocontent = gohelper.findChild(arg_4_0.viewGO, "#go_maproot/#go_nodes/#scroll_node/viewport/content")
	arg_4_0._grid = arg_4_0._gocontent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)

	arg_4_0:_addEvents()
end

function var_0_0._addEvents(arg_5_0)
	arg_5_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.ActUnitDragEnd, arg_5_0._onActUnitDragEnd, arg_5_0)
	arg_5_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitDragEnd, arg_5_0._onNodeUnitDragEnd, arg_5_0)
	arg_5_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.UnitDraging, arg_5_0._onUnitDraging, arg_5_0)
	arg_5_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeClicked, arg_5_0._onNodeChange, arg_5_0)
	arg_5_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, arg_5_0._onMapReset, arg_5_0)
	arg_5_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.StartGuideDragUnit, arg_5_0._startGuideDragUnit, arg_5_0)
end

function var_0_0._removeEvents(arg_6_0)
	arg_6_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.ActUnitDragEnd, arg_6_0._onActUnitDragEnd, arg_6_0)
	arg_6_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitDragEnd, arg_6_0._onNodeUnitDragEnd, arg_6_0)
	arg_6_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.UnitDraging, arg_6_0._onUnitDraging, arg_6_0)
	arg_6_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeClicked, arg_6_0._onNodeChange, arg_6_0)
	arg_6_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, arg_6_0._onMapReset, arg_6_0)
	arg_6_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.StartGuideDragUnit, arg_6_0._startGuideDragUnit, arg_6_0)
end

function var_0_0._startGuideDragUnit(arg_7_0, arg_7_1)
	if arg_7_0._dragEffectLoader then
		arg_7_0._dragEffectLoader:dispose()

		arg_7_0._dragEffectLoader = nil
	end

	local var_7_0 = tonumber(arg_7_1) == 1

	gohelper.setActive(arg_7_0._goblock, var_7_0)

	if var_7_0 then
		arg_7_0._dragEffectLoader = PrefabInstantiate.Create(arg_7_0.viewGO)

		arg_7_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_wuerlixi.prefab", arg_7_0._onDragEffectLoaded, arg_7_0)
	end
end

function var_0_0._onDragEffectLoaded(arg_8_0)
	local var_8_0 = arg_8_0._dragEffectLoader:getInstGO()

	gohelper.setActive(gohelper.findChild(var_8_0, "guide1").gameObject, true)
end

function var_0_0._onNodeUnitDragEnd(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._nodeItems) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			iter_9_3:showHightLight(false)
			iter_9_3:showPlaceable(false)
			iter_9_3:showUnplace(false)
		end
	end

	local var_9_0 = arg_9_0._nodeItems[arg_9_2.y][arg_9_2.x]:getNodeMo()
	local var_9_1 = arg_9_2.unitType
	local var_9_2 = arg_9_2.dir
	local var_9_3 = arg_9_0:_getTargetNodeItems(arg_9_1, var_9_1, var_9_2)

	if not var_9_3 or #var_9_3 < 1 then
		WuErLiXiMapModel.instance:addOperation(arg_9_2.id, var_9_1, var_9_0.x, var_9_0.y, "Null", "Null")
		WuErLiXiMapModel.instance:clearSelectUnit()
		arg_9_0._unitItems[arg_9_2.y][arg_9_2.x]:destroy()

		arg_9_0._unitItems[arg_9_2.y][arg_9_2.x] = nil

		WuErLiXiMapModel.instance:clearNodeUnit(var_9_0)
		WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaceBack)
		arg_9_0:_refreshMap()

		return
	elseif arg_9_2.unitType == WuErLiXiEnum.UnitType.SignalMulti and #var_9_3 < 3 then
		return
	end

	local var_9_4 = true

	for iter_9_4, iter_9_5 in pairs(var_9_3) do
		if WuErLiXiMapModel.instance:isNodeHasUnit(iter_9_5:getNodeMo()) then
			local var_9_5 = iter_9_5:getNodeMo():getNodeUnit()

			if var_9_5.x ~= arg_9_2.x or var_9_5.y ~= arg_9_2.y then
				var_9_4 = false
			end
		end
	end

	if not var_9_4 then
		return
	end

	local var_9_6 = var_9_3[1]:getNodeMo()

	if var_9_6.x == var_9_0.x and var_9_6.y == var_9_0.y then
		return
	end

	arg_9_0._unitItems[arg_9_2.y][arg_9_2.x]:destroy()

	arg_9_0._unitItems[arg_9_2.y][arg_9_2.x] = nil

	local var_9_7 = false

	WuErLiXiMapModel.instance:addOperation(arg_9_2.id, var_9_1, var_9_0.x, var_9_0.y, var_9_6.x, var_9_6.y)

	local var_9_8 = var_9_0:getNodeRay()
	local var_9_9 = var_9_6:getNodeRay()

	if not WuErLiXiMapModel.instance:isKeyActiveSelf(arg_9_2.id, var_9_6) and var_9_8 and arg_9_2.unitType == WuErLiXiEnum.UnitType.Key then
		if var_9_9 then
			if var_9_9.rayType == WuErLiXiEnum.RayType.SwitchSignal then
				var_9_7 = true
			end
		elseif var_9_8 then
			if (var_9_8.rayDir == WuErLiXiEnum.Dir.Up or var_9_8.rayDir == WuErLiXiEnum.Dir.Down) and var_9_0.x == var_9_6.x and var_9_0.y ~= var_9_6.y and not WuErLiXiMapModel.instance:hasBlockRayUnit(var_9_0, var_9_6, var_9_8.rayType, var_9_8.rayDir) then
				var_9_7 = true
			end

			if (var_9_8.rayDir == WuErLiXiEnum.Dir.Left or var_9_8.rayDir == WuErLiXiEnum.Dir.Right) and var_9_0.y == var_9_6.y and var_9_0.x ~= var_9_6.x and not WuErLiXiMapModel.instance:hasBlockRayUnit(var_9_0, var_9_6, var_9_8.rayType, var_9_8.rayDir) then
				var_9_7 = true
			end
		end
	end

	WuErLiXiMapModel.instance:clearNodeUnit(var_9_0, var_9_7)
	WuErLiXiMapModel.instance:setNodeUnitByUnitMo(var_9_6, arg_9_2, var_9_7)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.PutUnitGuideFinish)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaced)
	arg_9_0:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_put)

	arg_9_0._targetUnitItem = arg_9_0._unitItems[var_9_6.y][var_9_6.x]

	arg_9_0._targetUnitItem:showPut(true)
	TaskDispatcher.runDelay(arg_9_0._resetShowPut, arg_9_0, 0.7)
end

function var_0_0._resetShowPut(arg_10_0)
	if arg_10_0._targetUnitItem then
		arg_10_0._targetUnitItem:showPut(false)

		arg_10_0._targetUnitItem = nil
	end

	TaskDispatcher.cancelTask(arg_10_0._resetShowPut, arg_10_0)
end

function var_0_0._onActUnitDragEnd(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._nodeItems) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			iter_11_3:showPlaceable(false)
			iter_11_3:showHightLight(false)
			iter_11_3:showUnplace(false)
		end
	end

	local var_11_0 = arg_11_2.type
	local var_11_1 = arg_11_2.dir
	local var_11_2 = arg_11_0:_getTargetNodeItems(arg_11_1, var_11_0, var_11_1)

	if not var_11_2 or #var_11_2 < 1 then
		return
	end

	local var_11_3 = true

	for iter_11_4, iter_11_5 in pairs(var_11_2) do
		local var_11_4 = iter_11_5:getNodeMo()

		if WuErLiXiMapModel.instance:isNodeHasUnit(var_11_4) then
			var_11_3 = false
		end
	end

	if not var_11_3 then
		return
	end

	WuErLiXiMapModel.instance:setNodeUnitByActUnitMo(var_11_2[1]:getNodeMo(), arg_11_2)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.PutUnitGuideFinish)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaced)
	arg_11_0:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_put)

	local var_11_5 = var_11_2[1]:getNodeMo()

	WuErLiXiMapModel.instance:addOperation(arg_11_2.id, var_11_0, "Null", "Null", var_11_5.x, var_11_5.y)

	arg_11_0._targetUnitItem = arg_11_0._unitItems[var_11_5.y][var_11_5.x]

	arg_11_0._targetUnitItem:showPut(true)
	TaskDispatcher.runDelay(arg_11_0._resetShowPut, arg_11_0, 0.7)
end

function var_0_0._onUnitDraging(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0:_resetShowPut()

	for iter_12_0, iter_12_1 in pairs(arg_12_0._nodeItems) do
		for iter_12_2, iter_12_3 in pairs(iter_12_1) do
			iter_12_3:showHightLight(true)
			iter_12_3:showUnplace(false)
			iter_12_3:showPlaceable(false)
		end
	end

	local var_12_0 = arg_12_2.dir or arg_12_2:getNodeUnit().dir
	local var_12_1 = arg_12_0:_getTargetNodeItems(arg_12_1, arg_12_3, var_12_0)

	if not var_12_1 or #var_12_1 < 1 then
		return
	end

	for iter_12_4, iter_12_5 in pairs(var_12_1) do
		local var_12_2 = iter_12_5:getNodeMo()
		local var_12_3 = WuErLiXiMapModel.instance:isNodeHasUnit(var_12_2)
		local var_12_4 = var_12_2:getNodeUnit()
		local var_12_5 = arg_12_2.x and var_12_4 and arg_12_2.x == var_12_4.x and arg_12_2.y == var_12_4.y

		iter_12_5:showUnplace(var_12_3 and not var_12_5)
		iter_12_5:showPlaceable(not var_12_3 or var_12_5)
	end
end

function var_0_0._getTargetNodeItems(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = WuErLiXiMapModel.instance:getMapLineCount()
	local var_13_1 = WuErLiXiMapModel.instance:getMapRowCount()
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._nodeItems) do
		for iter_13_2, iter_13_3 in pairs(iter_13_1) do
			local var_13_3 = iter_13_3.go.transform
			local var_13_4 = recthelper.screenPosToAnchorPos(arg_13_1, var_13_3)

			if math.abs(var_13_4.x) * 2 <= recthelper.getWidth(iter_13_3.go.transform) and math.abs(var_13_4.y) * 2 <= recthelper.getHeight(iter_13_3.go.transform) then
				table.insert(var_13_2, iter_13_3)

				local var_13_5 = iter_13_3:getNodeMo()

				if arg_13_2 == WuErLiXiEnum.UnitType.SignalMulti then
					if arg_13_3 == WuErLiXiEnum.Dir.Up or arg_13_3 == WuErLiXiEnum.Dir.Down then
						if var_13_5.x > 1 then
							table.insert(var_13_2, arg_13_0._nodeItems[var_13_5.y][var_13_5.x - 1])
						end

						if var_13_1 > var_13_5.x then
							table.insert(var_13_2, arg_13_0._nodeItems[var_13_5.y][var_13_5.x + 1])
						end
					else
						if var_13_5.y > 1 then
							table.insert(var_13_2, arg_13_0._nodeItems[var_13_5.y - 1][var_13_5.x])
						end

						if var_13_0 > var_13_5.y then
							table.insert(var_13_2, arg_13_0._nodeItems[var_13_5.y + 1][var_13_5.x])
						end
					end
				end

				return var_13_2
			end
		end
	end

	return var_13_2
end

function var_0_0._onNodeChange(arg_14_0)
	arg_14_0:_refreshMap()
end

function var_0_0._checkMapSuccess(arg_15_0)
	if not WuErLiXiMapModel.instance:isAllSignalEndActive(arg_15_0._mapId) then
		return
	end

	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.MapConnectSuccess)
end

function var_0_0._onMapReset(arg_16_0)
	arg_16_0:_refreshMap()
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	arg_17_0._mapId = WuErLiXiConfig.instance:getEpisodeCo(arg_17_0._actId, arg_17_0.viewParam.episodeId).mapId
	arg_17_0._mapMo = WuErLiXiMapModel.instance:getMap(arg_17_0._mapId)
	arg_17_0._nodeItems = {}
	arg_17_0._rayItems = {}
	arg_17_0._unitItems = {}

	arg_17_0:_refreshMap()
end

function var_0_0._refreshMap(arg_18_0)
	WuErLiXiMapModel.instance:setMapData()
	arg_18_0:_refreshNodes()
	arg_18_0:_refreshRays()
	arg_18_0:_checkMapSuccess()
end

function var_0_0._refreshNodes(arg_19_0)
	local var_19_0 = WuErLiXiMapModel.instance:getMapRowCount(arg_19_0._mapId)
	local var_19_1 = WuErLiXiMapModel.instance:getMapNodes(arg_19_0._mapId)

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			if not arg_19_0._nodeItems[iter_19_3.y] then
				arg_19_0._nodeItems[iter_19_3.y] = {}
			end

			if not arg_19_0._nodeItems[iter_19_3.y][iter_19_3.x] then
				arg_19_0._nodeItems[iter_19_3.y][iter_19_3.x] = WuErLiXiGameMapNodeItem.New()

				local var_19_2 = gohelper.cloneInPlace(arg_19_0._gonodeitem)

				arg_19_0._nodeItems[iter_19_3.y][iter_19_3.x]:init(var_19_2)
			end

			arg_19_0._nodeItems[iter_19_3.y][iter_19_3.x]:setItem(iter_19_3)

			if iter_19_3.unit and iter_19_3.x == iter_19_3.unit.x and iter_19_3.y == iter_19_3.unit.y then
				if not arg_19_0._unitItems[iter_19_3.y] then
					arg_19_0._unitItems[iter_19_3.y] = {}
				end

				if not arg_19_0._unitItems[iter_19_3.y][iter_19_3.x] then
					arg_19_0._unitItems[iter_19_3.y][iter_19_3.x] = WuErLiXiGameMapUnitItem.New()

					local var_19_3 = gohelper.cloneInPlace(arg_19_0._gounititem)

					arg_19_0._unitItems[iter_19_3.y][iter_19_3.x]:init(var_19_3, arg_19_0._godragitem)
				end

				arg_19_0._unitItems[iter_19_3.y][iter_19_3.x]:setItem(iter_19_3.unit, arg_19_0._nodeItems[iter_19_3.y][iter_19_3.x])
			elseif arg_19_0._unitItems[iter_19_3.y] and arg_19_0._unitItems[iter_19_3.y][iter_19_3.x] then
				arg_19_0._unitItems[iter_19_3.y][iter_19_3.x]:destroy()

				arg_19_0._unitItems[iter_19_3.y][iter_19_3.x] = nil
			end
		end
	end

	arg_19_0._grid.constraintCount = var_19_0
end

function var_0_0._refreshRays(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = WuErLiXiMapModel.instance:getMapRays(arg_20_0._mapId)

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		if not arg_20_0._rayItems[iter_20_0] then
			arg_20_0._rayItems[iter_20_0] = WuErLiXiGameMapRayItem.New()

			local var_20_2 = gohelper.cloneInPlace(arg_20_0._gorayitem)

			arg_20_0._rayItems[iter_20_0]:init(var_20_2)
			arg_20_0._rayItems[iter_20_0]:setItem(iter_20_1, arg_20_0._nodeItems[iter_20_1.startPos[2]][iter_20_1.startPos[1]], arg_20_0._nodeItems[iter_20_1.endPos[2]][iter_20_1.endPos[1]])
		else
			arg_20_0._rayItems[iter_20_0]:resetItem(iter_20_1, arg_20_0._nodeItems[iter_20_1.endPos[2]][iter_20_1.endPos[1]])
		end

		var_20_0[iter_20_0] = true
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0._rayItems) do
		if not var_20_0[iter_20_2] then
			iter_20_3:hide()
		end
	end
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._refreshRaysAndUnits, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0:_removeEvents()

	for iter_22_0, iter_22_1 in pairs(arg_22_0._unitItems) do
		for iter_22_2, iter_22_3 in pairs(iter_22_1) do
			iter_22_3:destroy()
		end
	end

	for iter_22_4, iter_22_5 in pairs(arg_22_0._rayItems) do
		iter_22_5:destroy()
	end

	for iter_22_6, iter_22_7 in pairs(arg_22_0._nodeItems) do
		for iter_22_8, iter_22_9 in pairs(iter_22_7) do
			iter_22_9:destroy()
		end
	end
end

return var_0_0

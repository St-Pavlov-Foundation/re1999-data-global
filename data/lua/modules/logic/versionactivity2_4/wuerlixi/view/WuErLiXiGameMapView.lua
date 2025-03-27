module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapView", package.seeall)

slot0 = class("WuErLiXiGameMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomaproot = gohelper.findChild(slot0.viewGO, "#go_maproot")
	slot0._gonodes = gohelper.findChild(slot0.viewGO, "#go_maproot/#go_nodes")
	slot0._gonodeitem = gohelper.findChild(slot0.viewGO, "#go_maproot/#go_nodes/#scroll_node/viewport/content/#go_nodeitem")
	slot0._gorays = gohelper.findChild(slot0.viewGO, "#go_maproot/#go_ray")
	slot0._gorayitem = gohelper.findChild(slot0.viewGO, "#go_maproot/#go_ray/#go_rayitem")
	slot0._gounits = gohelper.findChild(slot0.viewGO, "#go_maproot/#go_units")
	slot0._gounititem = gohelper.findChild(slot0.viewGO, "#go_maproot/#go_units/#go_unititem")
	slot0._godragitem = gohelper.findChild(slot0.viewGO, "#go_dragitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_maproot/#go_nodes/#scroll_node/viewport/content")
	slot0._grid = slot0._gocontent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)

	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.ActUnitDragEnd, slot0._onActUnitDragEnd, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitDragEnd, slot0._onNodeUnitDragEnd, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.UnitDraging, slot0._onUnitDraging, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeClicked, slot0._onNodeChange, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, slot0._onMapReset, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.StartGuideDragUnit, slot0._startGuideDragUnit, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.ActUnitDragEnd, slot0._onActUnitDragEnd, slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitDragEnd, slot0._onNodeUnitDragEnd, slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.UnitDraging, slot0._onUnitDraging, slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeClicked, slot0._onNodeChange, slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, slot0._onMapReset, slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.StartGuideDragUnit, slot0._startGuideDragUnit, slot0)
end

function slot0._startGuideDragUnit(slot0, slot1)
	if slot0._dragEffectLoader then
		slot0._dragEffectLoader:dispose()

		slot0._dragEffectLoader = nil
	end

	slot2 = tonumber(slot1) == 1

	gohelper.setActive(slot0._goblock, slot2)

	if slot2 then
		slot0._dragEffectLoader = PrefabInstantiate.Create(slot0.viewGO)

		slot0._dragEffectLoader:startLoad("ui/viewres/guide/guide_wuerlixi.prefab", slot0._onDragEffectLoaded, slot0)
	end
end

function slot0._onDragEffectLoaded(slot0)
	gohelper.setActive(gohelper.findChild(slot0._dragEffectLoader:getInstGO(), "guide1").gameObject, true)
end

function slot0._onNodeUnitDragEnd(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._nodeItems) do
		for slot11, slot12 in pairs(slot7) do
			slot12:showHightLight(false)
			slot12:showPlaceable(false)
			slot12:showUnplace(false)
		end
	end

	slot3 = slot0._nodeItems[slot2.y][slot2.x]:getNodeMo()

	if not slot0:_getTargetNodeItems(slot1, slot2.unitType, slot2.dir) or #slot6 < 1 then
		WuErLiXiMapModel.instance:addOperation(slot2.id, slot4, slot3.x, slot3.y, "Null", "Null")
		WuErLiXiMapModel.instance:clearSelectUnit()
		slot0._unitItems[slot2.y][slot2.x]:destroy()

		slot0._unitItems[slot2.y][slot2.x] = nil

		WuErLiXiMapModel.instance:clearNodeUnit(slot3)
		WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaceBack)
		slot0:_refreshMap()

		return
	elseif slot2.unitType == WuErLiXiEnum.UnitType.SignalMulti and #slot6 < 3 then
		return
	end

	slot7 = true

	for slot11, slot12 in pairs(slot6) do
		if WuErLiXiMapModel.instance:isNodeHasUnit(slot12:getNodeMo()) and (slot12:getNodeMo():getNodeUnit().x ~= slot2.x or slot13.y ~= slot2.y) then
			slot7 = false
		end
	end

	if not slot7 then
		return
	end

	if slot6[1]:getNodeMo().x == slot3.x and slot8.y == slot3.y then
		return
	end

	slot0._unitItems[slot2.y][slot2.x]:destroy()

	slot0._unitItems[slot2.y][slot2.x] = nil
	slot9 = false

	WuErLiXiMapModel.instance:addOperation(slot2.id, slot4, slot3.x, slot3.y, slot8.x, slot8.y)

	slot11 = slot8:getNodeRay()

	if not WuErLiXiMapModel.instance:isKeyActiveSelf(slot2.id, slot8) and slot3:getNodeRay() and slot2.unitType == WuErLiXiEnum.UnitType.Key then
		if slot11 then
			if slot11.rayType == WuErLiXiEnum.RayType.SwitchSignal then
				slot9 = true
			end
		elseif slot10 then
			if (slot10.rayDir == WuErLiXiEnum.Dir.Up or slot10.rayDir == WuErLiXiEnum.Dir.Down) and slot3.x == slot8.x and slot3.y ~= slot8.y and not WuErLiXiMapModel.instance:hasBlockRayUnit(slot3, slot8, slot10.rayType, slot10.rayDir) then
				slot9 = true
			end

			if (slot10.rayDir == WuErLiXiEnum.Dir.Left or slot10.rayDir == WuErLiXiEnum.Dir.Right) and slot3.y == slot8.y and slot3.x ~= slot8.x and not WuErLiXiMapModel.instance:hasBlockRayUnit(slot3, slot8, slot10.rayType, slot10.rayDir) then
				slot9 = true
			end
		end
	end

	WuErLiXiMapModel.instance:clearNodeUnit(slot3, slot9)
	WuErLiXiMapModel.instance:setNodeUnitByUnitMo(slot8, slot2, slot9)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.PutUnitGuideFinish)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaced)
	slot0:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_put)

	slot0._targetUnitItem = slot0._unitItems[slot8.y][slot8.x]

	slot0._targetUnitItem:showPut(true)
	TaskDispatcher.runDelay(slot0._resetShowPut, slot0, 0.7)
end

function slot0._resetShowPut(slot0)
	if slot0._targetUnitItem then
		slot0._targetUnitItem:showPut(false)

		slot0._targetUnitItem = nil
	end

	TaskDispatcher.cancelTask(slot0._resetShowPut, slot0)
end

function slot0._onActUnitDragEnd(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._nodeItems) do
		for slot11, slot12 in pairs(slot7) do
			slot12:showPlaceable(false)
			slot12:showHightLight(false)
			slot12:showUnplace(false)
		end
	end

	if not slot0:_getTargetNodeItems(slot1, slot2.type, slot2.dir) or #slot5 < 1 then
		return
	end

	slot6 = true

	for slot10, slot11 in pairs(slot5) do
		if WuErLiXiMapModel.instance:isNodeHasUnit(slot11:getNodeMo()) then
			slot6 = false
		end
	end

	if not slot6 then
		return
	end

	WuErLiXiMapModel.instance:setNodeUnitByActUnitMo(slot5[1]:getNodeMo(), slot2)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.PutUnitGuideFinish)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitPlaced)
	slot0:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_put)

	slot7 = slot5[1]:getNodeMo()

	WuErLiXiMapModel.instance:addOperation(slot2.id, slot3, "Null", "Null", slot7.x, slot7.y)

	slot0._targetUnitItem = slot0._unitItems[slot7.y][slot7.x]

	slot0._targetUnitItem:showPut(true)
	TaskDispatcher.runDelay(slot0._resetShowPut, slot0, 0.7)
end

function slot0._onUnitDraging(slot0, slot1, slot2, slot3)
	slot0:_resetShowPut()

	for slot7, slot8 in pairs(slot0._nodeItems) do
		for slot12, slot13 in pairs(slot8) do
			slot13:showHightLight(true)
			slot13:showUnplace(false)
			slot13:showPlaceable(false)
		end
	end

	if not slot0:_getTargetNodeItems(slot1, slot3, slot2.dir or slot2:getNodeUnit().dir) or #slot5 < 1 then
		return
	end

	for slot9, slot10 in pairs(slot5) do
		slot11 = slot10:getNodeMo()
		slot12 = WuErLiXiMapModel.instance:isNodeHasUnit(slot11)
		slot13 = slot11:getNodeUnit()
		slot14 = slot2.x and slot13 and slot2.x == slot13.x and slot2.y == slot13.y

		slot10:showUnplace(slot12 and not slot14)
		slot10:showPlaceable(not slot12 or slot14)
	end
end

function slot0._getTargetNodeItems(slot0, slot1, slot2, slot3)
	slot4 = WuErLiXiMapModel.instance:getMapLineCount()
	slot5 = WuErLiXiMapModel.instance:getMapRowCount()
	slot6 = {}

	for slot10, slot11 in pairs(slot0._nodeItems) do
		for slot15, slot16 in pairs(slot11) do
			if math.abs(recthelper.screenPosToAnchorPos(slot1, slot16.go.transform).x) * 2 <= recthelper.getWidth(slot16.go.transform) and math.abs(slot18.y) * 2 <= recthelper.getHeight(slot16.go.transform) then
				table.insert(slot6, slot16)

				slot19 = slot16:getNodeMo()

				if slot2 == WuErLiXiEnum.UnitType.SignalMulti then
					if slot3 == WuErLiXiEnum.Dir.Up or slot3 == WuErLiXiEnum.Dir.Down then
						if slot19.x > 1 then
							table.insert(slot6, slot0._nodeItems[slot19.y][slot19.x - 1])
						end

						if slot19.x < slot5 then
							table.insert(slot6, slot0._nodeItems[slot19.y][slot19.x + 1])
						end
					else
						if slot19.y > 1 then
							table.insert(slot6, slot0._nodeItems[slot19.y - 1][slot19.x])
						end

						if slot19.y < slot4 then
							table.insert(slot6, slot0._nodeItems[slot19.y + 1][slot19.x])
						end
					end
				end

				return slot6
			end
		end
	end

	return slot6
end

function slot0._onNodeChange(slot0)
	slot0:_refreshMap()
end

function slot0._checkMapSuccess(slot0)
	if not WuErLiXiMapModel.instance:isAllSignalEndActive(slot0._mapId) then
		return
	end

	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.MapConnectSuccess)
end

function slot0._onMapReset(slot0)
	slot0:_refreshMap()
end

function slot0.onOpen(slot0)
	slot0._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	slot0._mapId = WuErLiXiConfig.instance:getEpisodeCo(slot0._actId, slot0.viewParam.episodeId).mapId
	slot0._mapMo = WuErLiXiMapModel.instance:getMap(slot0._mapId)
	slot0._nodeItems = {}
	slot0._rayItems = {}
	slot0._unitItems = {}

	slot0:_refreshMap()
end

function slot0._refreshMap(slot0)
	WuErLiXiMapModel.instance:setMapData()
	slot0:_refreshNodes()
	slot0:_refreshRays()
	slot0:_checkMapSuccess()
end

function slot0._refreshNodes(slot0)
	slot1 = WuErLiXiMapModel.instance:getMapRowCount(slot0._mapId)

	for slot6, slot7 in pairs(WuErLiXiMapModel.instance:getMapNodes(slot0._mapId)) do
		for slot11, slot12 in pairs(slot7) do
			if not slot0._nodeItems[slot12.y] then
				slot0._nodeItems[slot12.y] = {}
			end

			if not slot0._nodeItems[slot12.y][slot12.x] then
				slot0._nodeItems[slot12.y][slot12.x] = WuErLiXiGameMapNodeItem.New()

				slot0._nodeItems[slot12.y][slot12.x]:init(gohelper.cloneInPlace(slot0._gonodeitem))
			end

			slot0._nodeItems[slot12.y][slot12.x]:setItem(slot12)

			if slot12.unit and slot12.x == slot12.unit.x and slot12.y == slot12.unit.y then
				if not slot0._unitItems[slot12.y] then
					slot0._unitItems[slot12.y] = {}
				end

				if not slot0._unitItems[slot12.y][slot12.x] then
					slot0._unitItems[slot12.y][slot12.x] = WuErLiXiGameMapUnitItem.New()

					slot0._unitItems[slot12.y][slot12.x]:init(gohelper.cloneInPlace(slot0._gounititem), slot0._godragitem)
				end

				slot0._unitItems[slot12.y][slot12.x]:setItem(slot12.unit, slot0._nodeItems[slot12.y][slot12.x])
			elseif slot0._unitItems[slot12.y] and slot0._unitItems[slot12.y][slot12.x] then
				slot0._unitItems[slot12.y][slot12.x]:destroy()

				slot0._unitItems[slot12.y][slot12.x] = nil
			end
		end
	end

	slot0._grid.constraintCount = slot1
end

function slot0._refreshRays(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(WuErLiXiMapModel.instance:getMapRays(slot0._mapId)) do
		if not slot0._rayItems[slot6] then
			slot0._rayItems[slot6] = WuErLiXiGameMapRayItem.New()

			slot0._rayItems[slot6]:init(gohelper.cloneInPlace(slot0._gorayitem))
			slot0._rayItems[slot6]:setItem(slot7, slot0._nodeItems[slot7.startPos[2]][slot7.startPos[1]], slot0._nodeItems[slot7.endPos[2]][slot7.endPos[1]])
		else
			slot0._rayItems[slot6]:resetItem(slot7, slot0._nodeItems[slot7.endPos[2]][slot7.endPos[1]])
		end

		slot1[slot6] = true
	end

	for slot6, slot7 in pairs(slot0._rayItems) do
		if not slot1[slot6] then
			slot7:hide()
		end
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshRaysAndUnits, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()

	for slot4, slot5 in pairs(slot0._unitItems) do
		for slot9, slot10 in pairs(slot5) do
			slot10:destroy()
		end
	end

	for slot4, slot5 in pairs(slot0._rayItems) do
		slot5:destroy()
	end

	for slot4, slot5 in pairs(slot0._nodeItems) do
		for slot9, slot10 in pairs(slot5) do
			slot10:destroy()
		end
	end
end

return slot0

module("modules.logic.rouge.map.model.mapmodel.RougeMapModel", package.seeall)

slot0 = class("RougeMapModel")

function slot0.init(slot0, slot1)
	slot0.mapType = slot1
end

function slot0.getMapType(slot0)
	return slot0.mapType
end

function slot0.setMapSize(slot0, slot1)
	slot0.mapSize = slot1

	slot0:calculateMapEpisodeIntervalX()
end

function slot0.getMapSize(slot0)
	return slot0.mapSize
end

function slot0.calculateMapEpisodeIntervalX(slot0)
	if not slot0:isNormalLayer() then
		slot0.mapEpisodeIntervalX = 0

		return
	end

	slot0.mapEpisodeIntervalX = RougeMapHelper.retain2decimals((slot0.mapSize.x - RougeMapEnum.MapStartOffsetX * 2) / (#slot0:getEpisodeList() - 1))
end

function slot0.getMapEpisodeIntervalX(slot0)
	return slot0.mapEpisodeIntervalX
end

function slot0.setCameraSize(slot0, slot1)
	slot0.cameraSize = slot1
end

function slot0.setMapXRange(slot0, slot1, slot2)
	slot0.minX = slot1
	slot0.maxX = slot2
end

function slot0.getCameraSize(slot0)
	return slot0.cameraSize
end

function slot0.setMapPosX(slot0, slot1)
	if slot1 < slot0.minX then
		slot1 = slot0.minX
	end

	if slot0.maxX < slot1 then
		slot1 = slot0.maxX
	end

	if slot0.mapPosX == slot1 then
		return
	end

	slot0.mapPosX = slot1

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMapPosChange, slot0.mapPosX)
end

function slot0.getMapPosX(slot0)
	return slot0.mapPosX
end

function slot0.setFocusScreenPosX(slot0, slot1)
	slot0.focusScreenPosX = slot1
end

function slot0.getFocusScreenPosX(slot0)
	return slot0.focusScreenPosX
end

function slot0.getLayerId(slot0)
	return slot0.mapModel and slot0.mapModel.layerId
end

function slot0.getLayerCo(slot0)
	return slot0.mapModel and slot0.mapModel.layerCo
end

function slot0.isNormalLayer(slot0)
	return slot0.mapType == RougeMapEnum.MapType.Normal
end

function slot0.isMiddle(slot0)
	return slot0.mapType == RougeMapEnum.MapType.Middle
end

function slot0.isPathSelect(slot0)
	return slot0.mapType == RougeMapEnum.MapType.PathSelect
end

function slot0.getMiddleLayerId(slot0)
	return slot0.mapModel and slot0.mapModel.middleLayerId
end

function slot0.getMiddleLayerCo(slot0)
	return slot0.mapModel and slot0.mapModel.middleCo
end

function slot0.getPathSelectCo(slot0)
	return slot0.mapModel and slot0.mapModel.pathSelectCo
end

function slot0.setWaitLeaveMiddleLayerReply(slot0, slot1)
	slot0.waitMiddleLayerReply = slot1
end

function slot0.updateSimpleMapInfo(slot0, slot1)
	if slot0.waitMiddleLayerReply then
		return
	end

	if not slot0:_isSameMap(slot1) then
		return
	end

	if slot0.mapType == RougeMapEnum.MapType.Middle or slot0.mapType == RougeMapEnum.MapType.PathSelect then
		slot0.mapModel:updateSimpleMapInfo(slot1.middleLayerInfo)
	else
		slot0.mapModel:updateSimpleMapInfo(slot1.layerInfo)
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onUpdateMapInfo)
end

function slot0.updateMapInfo(slot0, slot1)
	if slot0.waitMiddleLayerReply then
		return
	end

	if slot0.inited then
		if slot0:_isSameMap(slot1) then
			slot0:_updateMapInfo(slot1)
		else
			slot0:_changeMapInfo(slot1)
		end
	else
		slot0:_initMapInfo(slot1)
	end
end

function slot0._isSameMap(slot0, slot1)
	if not slot0.inited then
		return false
	end

	if slot0.mapType ~= slot0:_getTypeByInfo(slot1) then
		return false
	end

	if slot0.mapType == RougeMapEnum.MapType.Normal then
		return slot0.mapModel.layerId == slot1.layerInfo.layerId
	end

	return slot0.mapModel.layerId == slot1.middleLayerInfo.layerId and slot0.mapModel.middleLayerId == slot2.middleLayerId
end

function slot0._getTypeByInfo(slot0, slot1)
	if slot1.mapType ~= RougeMapEnum.MapType.Middle then
		return slot1.mapType
	end

	if slot1.middleLayerInfo.positionIndex == RougeMapEnum.PathSelectIndex then
		return RougeMapEnum.MapType.PathSelect
	end

	return RougeMapEnum.MapType.Middle
end

function slot0._initMapInfo(slot0, slot1)
	slot0.inited = true
	slot0.mapType = slot0:_getTypeByInfo(slot1)
	slot0.mapModel = RougeMapEnum.MapType2ModelCls[slot0.mapType].New()

	if slot0.mapType == RougeMapEnum.MapType.Middle or slot0.mapType == RougeMapEnum.MapType.PathSelect then
		slot0.mapModel:initMap(slot1.middleLayerInfo)
	else
		slot0.mapModel:initMap(slot1.layerInfo)
	end

	slot0:setMapEntrustInfo(slot1)
	slot0:initMapInteractive(slot1)
	slot0:setMapSkillInfo(slot1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onInitMapInfoDone)
end

function slot0._updateMapInfo(slot0, slot1)
	if slot0.mapType == RougeMapEnum.MapType.Middle or slot0.mapType == RougeMapEnum.MapType.PathSelect then
		slot0.mapModel:updateMapInfo(slot1.middleLayerInfo)
	else
		slot0.mapModel:updateMapInfo(slot1.layerInfo)
	end

	slot0:setMapEntrustInfo(slot1)
	slot0:setMapCurInteractive(slot1)
	slot0:setMapSkillInfo(slot1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onUpdateMapInfo)
end

function slot0._changeMapInfo(slot0, slot1)
	if RougeMapHelper.getChangeMapEnum(slot0.mapType, slot0:_getTypeByInfo(slot1)) == RougeMapEnum.ChangeMapEnum.NormalToMiddle then
		slot0._newInfo = slot1

		slot0:clearInteractive()

		if slot0:getMapState() == RougeMapEnum.MapState.Normal then
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeActorMoveToEnd)
		end

		return
	end

	slot0:_initMapInfo(slot1)
	slot0:dispatchChangeMapEvent()
end

function slot0.updateToNewMapInfo(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeNormalToMiddle)
	slot0:setMapState(RougeMapEnum.MapState.SwitchMapAnim)

	if slot0.mapModel then
		slot0.mapModel:clear()
	end

	slot0._newInfo = nil

	slot0:_initMapInfo(slot0._newInfo)
	slot0:dispatchChangeMapEvent()
end

function slot0.dispatchChangeMapEvent(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeChangeMapInfo)
	TaskDispatcher.runDelay(slot0._dispatchChangeMapEvent, slot0, RougeMapEnum.WaitSwitchMapAnim)
end

function slot0._dispatchChangeMapEvent(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChangeMapInfo)
end

function slot0.needPlayMoveToEndAnim(slot0)
	return slot0._newInfo ~= nil
end

function slot0.initMapInteractive(slot0, slot1)
	if not slot1:HasField("curInteractiveIndex") then
		slot0:clearInteractive()

		return
	end

	slot0.interactiveJson = cjson.decode(slot1.interactiveJson)

	if slot0:checkDropIsEmpty(slot1.curInteractive) then
		logError(string.format("触发掉落，但是掉落列表是空! interactive : %s, json : %s", slot1.curInteractive, slot1.interactiveJson))
		slot0:clearInteractive()

		return
	end

	slot0.curInteractive = slot1.curInteractive
	slot0.curInteractType = string.splitToNumber(slot0.curInteractive, "#")[1]
	slot0.curInteractiveIndex = slot1.curInteractiveIndex
end

function slot0.setMapCurInteractive(slot0, slot1)
	if not slot1:HasField("curInteractiveIndex") then
		slot0:clearInteractive()

		return
	end

	slot0.interactiveJson = cjson.decode(slot1.interactiveJson)

	if slot0:checkDropIsEmpty(slot1.curInteractive) then
		logError(string.format("触发掉落，但是掉落列表是空! interactive : %s, json : %s", slot1.curInteractive, slot1.interactiveJson))
		slot0:clearInteractive()

		return
	end

	if slot0.curInteractiveIndex == slot1.curInteractiveIndex then
		return
	end

	slot0.curInteractive = slot1.curInteractive
	slot0.curInteractType = string.splitToNumber(slot0.curInteractive, "#")[1]
	slot0.curInteractiveIndex = slot1.curInteractiveIndex

	RougeMapController.instance:dispatchEvent(RougeMapEvent.triggerInteract)
end

function slot0.clearInteractive(slot0)
	logNormal("清理交互数据")

	slot0.curInteractiveIndex = nil
	slot0.curInteractive = nil
	slot0.interactiveJson = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClearInteract)
end

function slot0.checkDropIsEmpty(slot0, slot1)
	if string.splitToNumber(slot1, "#")[1] == RougeMapEnum.InteractType.Drop or slot3 == RougeMapEnum.InteractType.DropGroup or slot3 == RougeMapEnum.InteractType.AdvanceDrop then
		return not slot0.interactiveJson.dropCollectList or #slot4 < 1
	end

	return false
end

function slot0.setMapEntrustInfo(slot0, slot1)
	if not slot1:HasField("rougeEntrust") then
		slot0:clearEntrustInfo()
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)

		return
	end

	slot2 = slot1.rougeEntrust

	if slot0.entrustId == slot2.id and slot0.entrustProgress == slot2.count then
		return
	end

	if slot0.entrustId ~= slot3 then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onAcceptEntrust)
	end

	slot0.entrustId = slot3
	slot0.entrustProgress = slot4

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)
end

function slot0.updateEntrustInfo(slot0, slot1)
	if slot1.id == 0 then
		slot0:clearEntrustInfo()
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)

		return
	end

	slot0.entrustId = slot1.id
	slot0.entrustProgress = slot1.count

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)
end

function slot0.clearEntrustInfo(slot0)
	slot0.entrustId = nil
	slot0.entrustProgress = nil
end

function slot0.getEntrustId(slot0)
	return slot0.entrustId
end

function slot0.getEntrustProgress(slot0)
	return slot0.entrustProgress
end

function slot0.setMapSkillInfo(slot0, slot1)
	slot0._mapSkills = {}
	slot0._mapSkillMap = {}

	for slot5, slot6 in ipairs(slot1.mapSkill) do
		slot7 = RougeMapSkillMO.New()

		slot7:init(slot6)

		slot0._mapSkillMap[slot7.id] = slot7

		table.insert(slot0._mapSkills, slot7)
	end
end

function slot0.clearMapSkillInfo(slot0)
	slot0._mapSkills = nil
end

function slot0.getMapSkillList(slot0)
	return slot0._mapSkills
end

function slot0.onUpdateMapSkillInfo(slot0, slot1)
	if slot0._mapSkillMap and slot0._mapSkillMap[slot1.id] then
		slot2:init(slot1)
	end
end

function slot0.getEpisodeList(slot0)
	return slot0.mapModel and slot0.mapModel:getEpisodeList()
end

function slot0.getNode(slot0, slot1)
	return slot0.mapModel and slot0.mapModel:getNode(slot1)
end

function slot0.getEndNodeId(slot0)
	return slot0.mapModel and slot0.mapModel:getEndNodeId()
end

function slot0.getCurEpisodeId(slot0)
	return slot0.mapModel and slot0.mapModel:getCurEpisodeId()
end

function slot0.getCurNode(slot0)
	return slot0.mapModel and slot0.mapModel.getCurNode and slot0.mapModel:getCurNode()
end

function slot0.getCurEvent(slot0)
	if not slot0.mapModel then
		return
	end

	return slot0:getCurNode() and slot1:getEventCo()
end

function slot0.getCurPieceMo(slot0)
	return slot0.mapModel.getCurPieceMo and slot0.mapModel:getCurPieceMo()
end

function slot0.getNodeDict(slot0)
	return slot0.mapModel and slot0.mapModel:getNodeDict()
end

function slot0.getCurInteractType(slot0)
	return slot0.curInteractType
end

function slot0.getCurInteractive(slot0)
	return slot0.curInteractive
end

function slot0.getCurInteractiveJson(slot0)
	return slot0.interactiveJson
end

function slot0.isInteractiving(slot0)
	return slot0.curInteractive ~= nil
end

function slot0.getPieceList(slot0)
	return slot0.mapModel and slot0.mapModel:getPieceList()
end

function slot0.getPieceMo(slot0, slot1)
	return slot0.mapModel and slot0.mapModel:getPieceMo(slot1)
end

function slot0.getMiddleLayerPosByIndex(slot0, slot1)
	return slot0.mapModel and slot0.mapModel:getMiddleLayerPosByIndex(slot1)
end

function slot0.getPathIndex(slot0, slot1)
	if not slot0.mapModel then
		return
	end

	return slot0:getMiddleLayerPosByIndex(slot1).z
end

function slot0.getMiddleLayerPathPos(slot0, slot1)
	return slot0.mapModel and slot0.mapModel:getMiddleLayerPathPos(slot1)
end

function slot0.getMiddleLayerPathPosByPathIndex(slot0, slot1)
	return slot0.mapModel and slot0.mapModel:getMiddleLayerPathPosByPathIndex(slot1)
end

function slot0.getMiddleLayerLeavePos(slot0)
	if not slot0.mapModel then
		return
	end

	return slot0.mapModel:getMiddleLayerLeavePos()
end

function slot0.hadLeavePos(slot0)
	if not slot0.mapModel then
		return
	end

	return slot0.mapModel:hadLeavePos()
end

function slot0.getMiddleLayerLeavePathIndex(slot0)
	return slot0.mapModel and slot0.mapModel:getMiddleLayerLeavePathIndex()
end

function slot0.getCurPosIndex(slot0)
	return slot0.mapModel and slot0.mapModel:getCurPosIndex()
end

function slot0.getMapName(slot0)
	if not slot0.mapModel then
		return
	end

	if slot0.mapType == RougeMapEnum.MapType.Normal then
		return slot0.mapModel.layerCo.name
	elseif slot0.mapType == RougeMapEnum.MapType.Middle then
		return slot0.mapModel.middleCo.name
	elseif slot0.mapType == RougeMapEnum.MapType.PathSelect then
		return slot0.mapModel.pathSelectCo.name
	end
end

function slot0.getNextLayerList(slot0)
	return slot0.mapModel and slot0.mapModel:getNextLayerList()
end

function slot0.setEndId(slot0, slot1)
	slot0.endId = slot1
end

function slot0.getEndId(slot0)
	if slot0.endId then
		return slot0.endId
	end

	return RougeMapHelper.getEndId()
end

function slot0.updateSelectLayerId(slot0, slot1)
	if not slot0.mapModel then
		return
	end

	slot0.mapModel:updateSelectLayerId(slot1)
end

function slot0.getSelectLayerId(slot0)
	return slot0.mapModel and slot0.mapModel:getSelectLayerId()
end

function slot0.getFogNodeList(slot0)
	if slot0.mapModel and slot0.mapModel.getFogNodeList then
		return slot0.mapModel:getFogNodeList()
	end
end

function slot0.getHoleNodeList(slot0)
	if slot0.mapModel and slot0.mapModel.getFogNodeList then
		return slot0.mapModel:getHoleNodeList()
	end
end

function slot0.isHoleNode(slot0, slot1)
	if slot0.mapModel and slot0.mapModel.isHoleNode then
		return slot0.mapModel:isHoleNode(slot1)
	end
end

function slot0.clear(slot0)
	slot0.inited = nil
	slot0.mapType = nil
	slot0.mapEpisodeIntervalX = nil
	slot0.mapSize = nil
	slot0.cameraSize = nil
	slot0.minX = nil
	slot0.maxX = nil
	slot0.mapPosX = nil
	slot0.focusScreenPosX = nil
	slot0._newInfo = nil
	slot0.interactiveJson = nil
	slot0.curInteractive = nil
	slot0.curInteractType = nil
	slot0.curInteractiveIndex = nil
	slot0.entrustId = nil
	slot0.entrustProgress = nil
	slot0.endId = nil
	slot0.loading = nil
	slot0.curChoiceId = nil
	slot0.playingDialogue = nil
	slot0.state = nil
	slot0.mapState = nil
	slot0.finalMap = nil
	slot0.firstEnterMapFlag = nil

	TaskDispatcher.cancelTask(slot0._dispatchChangeMapEvent, slot0)

	if slot0.mapModel then
		slot0.mapModel:clear()

		slot0.mapModel = nil

		return
	end

	if slot0.preMapModel then
		slot0.preMapModel:clear()

		slot0.preMapModel = nil
	end
end

function slot0.setLoadingMap(slot0, slot1)
	slot0.loading = slot1
end

function slot0.checkIsLoading(slot0)
	return slot0.loading
end

function slot0.recordCurChoiceEventSelectId(slot0, slot1)
	slot0.curChoiceId = slot1
end

function slot0.getCurChoiceId(slot0)
	return slot0.curChoiceId
end

function slot0.setPlayingDialogue(slot0, slot1)
	slot0.playingDialogue = slot1
end

function slot0.isPlayingDialogue(slot0)
	return slot0.playingDialogue
end

function slot0.setChoiceViewState(slot0, slot1)
	slot0.state = slot1
end

function slot0.getChoiceViewState(slot0)
	return slot0.state
end

function slot0.setMapState(slot0, slot1)
	slot0.mapState = slot1
end

function slot0.getMapState(slot0)
	return slot0.mapState or RougeMapEnum.MapState.Empty
end

function slot0.setFinalMapInfo(slot0, slot1)
	slot0.finalMap = slot1
end

function slot0.getFinalMapInfo(slot0)
	return slot0.finalMap
end

function slot0.getExchangeMaxDisplaceNum(slot0)
	slot1 = RougeMapConfig.instance:getRestExchangeCount()

	if RougeModel.instance:getEffectDict() then
		for slot6, slot7 in pairs(slot2) do
			if slot7.type == RougeMapEnum.EffectType.UpdateExchangeDisplaceNum then
				slot1 = slot1 + tonumber(slot7.typeParam)
			end
		end
	end

	return slot1
end

function slot0.setFirstEnterMap(slot0, slot1)
	slot0.firstEnterMapFlag = slot1
end

function slot0.getFirstEnterMapFlag(slot0)
	return slot0.firstEnterMapFlag
end

slot0.instance = slot0.New()

return slot0

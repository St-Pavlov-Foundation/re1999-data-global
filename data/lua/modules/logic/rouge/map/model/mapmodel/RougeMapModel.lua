module("modules.logic.rouge.map.model.mapmodel.RougeMapModel", package.seeall)

local var_0_0 = class("RougeMapModel")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.mapType = arg_1_1
end

function var_0_0.getMapType(arg_2_0)
	return arg_2_0.mapType
end

function var_0_0.setMapSize(arg_3_0, arg_3_1)
	arg_3_0.mapSize = arg_3_1

	arg_3_0:calculateMapEpisodeIntervalX()
end

function var_0_0.getMapSize(arg_4_0)
	return arg_4_0.mapSize
end

function var_0_0.calculateMapEpisodeIntervalX(arg_5_0)
	if not arg_5_0:isNormalLayer() then
		arg_5_0.mapEpisodeIntervalX = 0

		return
	end

	local var_5_0 = arg_5_0.mapSize.x - RougeMapEnum.MapStartOffsetX * 2
	local var_5_1 = #arg_5_0:getEpisodeList() - 1

	arg_5_0.mapEpisodeIntervalX = RougeMapHelper.retain2decimals(var_5_0 / var_5_1)
end

function var_0_0.getMapEpisodeIntervalX(arg_6_0)
	return arg_6_0.mapEpisodeIntervalX
end

function var_0_0.setCameraSize(arg_7_0, arg_7_1)
	arg_7_0.cameraSize = arg_7_1
end

function var_0_0.setMapXRange(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.minX = arg_8_1
	arg_8_0.maxX = arg_8_2
end

function var_0_0.getCameraSize(arg_9_0)
	return arg_9_0.cameraSize
end

function var_0_0.setMapPosX(arg_10_0, arg_10_1)
	if arg_10_1 < arg_10_0.minX then
		arg_10_1 = arg_10_0.minX
	end

	if arg_10_1 > arg_10_0.maxX then
		arg_10_1 = arg_10_0.maxX
	end

	if arg_10_0.mapPosX == arg_10_1 then
		return
	end

	arg_10_0.mapPosX = arg_10_1

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMapPosChange, arg_10_0.mapPosX)
end

function var_0_0.getMapPosX(arg_11_0)
	return arg_11_0.mapPosX
end

function var_0_0.setFocusScreenPosX(arg_12_0, arg_12_1)
	arg_12_0.focusScreenPosX = arg_12_1
end

function var_0_0.getFocusScreenPosX(arg_13_0)
	return arg_13_0.focusScreenPosX
end

function var_0_0.getLayerId(arg_14_0)
	return arg_14_0.mapModel and arg_14_0.mapModel.layerId
end

function var_0_0.getLayerCo(arg_15_0)
	return arg_15_0.mapModel and arg_15_0.mapModel.layerCo
end

function var_0_0.isNormalLayer(arg_16_0)
	return arg_16_0.mapType == RougeMapEnum.MapType.Normal
end

function var_0_0.isMiddle(arg_17_0)
	return arg_17_0.mapType == RougeMapEnum.MapType.Middle
end

function var_0_0.isPathSelect(arg_18_0)
	return arg_18_0.mapType == RougeMapEnum.MapType.PathSelect
end

function var_0_0.getMiddleLayerId(arg_19_0)
	return arg_19_0.mapModel and arg_19_0.mapModel.middleLayerId
end

function var_0_0.getMiddleLayerCo(arg_20_0)
	return arg_20_0.mapModel and arg_20_0.mapModel.middleCo
end

function var_0_0.getPathSelectCo(arg_21_0)
	return arg_21_0.mapModel and arg_21_0.mapModel.pathSelectCo
end

function var_0_0.setWaitLeaveMiddleLayerReply(arg_22_0, arg_22_1)
	arg_22_0.waitMiddleLayerReply = arg_22_1
end

function var_0_0.updateSimpleMapInfo(arg_23_0, arg_23_1)
	if arg_23_0.waitMiddleLayerReply then
		return
	end

	if not arg_23_0:_isSameMap(arg_23_1) then
		return
	end

	if arg_23_0.mapType == RougeMapEnum.MapType.Middle or arg_23_0.mapType == RougeMapEnum.MapType.PathSelect then
		arg_23_0.mapModel:updateSimpleMapInfo(arg_23_1.middleLayerInfo)
	else
		arg_23_0.mapModel:updateSimpleMapInfo(arg_23_1.layerInfo)
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onUpdateMapInfo)
end

function var_0_0.updateMapInfo(arg_24_0, arg_24_1)
	if arg_24_0.waitMiddleLayerReply then
		return
	end

	if arg_24_0.inited then
		if arg_24_0:_isSameMap(arg_24_1) then
			arg_24_0:_updateMapInfo(arg_24_1)
		else
			arg_24_0:_changeMapInfo(arg_24_1)
		end
	else
		arg_24_0:_initMapInfo(arg_24_1)
	end
end

function var_0_0._isSameMap(arg_25_0, arg_25_1)
	if not arg_25_0.inited then
		return false
	end

	if arg_25_0.mapType ~= arg_25_0:_getTypeByInfo(arg_25_1) then
		return false
	end

	if arg_25_0.mapType == RougeMapEnum.MapType.Normal then
		return arg_25_0.mapModel.layerId == arg_25_1.layerInfo.layerId
	end

	local var_25_0 = arg_25_1.middleLayerInfo

	return arg_25_0.mapModel.layerId == var_25_0.layerId and arg_25_0.mapModel.middleLayerId == var_25_0.middleLayerId
end

function var_0_0._getTypeByInfo(arg_26_0, arg_26_1)
	if arg_26_1.mapType ~= RougeMapEnum.MapType.Middle then
		return arg_26_1.mapType
	end

	if arg_26_1.middleLayerInfo.positionIndex == RougeMapEnum.PathSelectIndex then
		return RougeMapEnum.MapType.PathSelect
	end

	return RougeMapEnum.MapType.Middle
end

function var_0_0._initMapInfo(arg_27_0, arg_27_1)
	arg_27_0.inited = true
	arg_27_0.mapType = arg_27_0:_getTypeByInfo(arg_27_1)
	arg_27_0.mapModel = RougeMapEnum.MapType2ModelCls[arg_27_0.mapType].New()

	if arg_27_0.mapType == RougeMapEnum.MapType.Middle or arg_27_0.mapType == RougeMapEnum.MapType.PathSelect then
		arg_27_0.mapModel:initMap(arg_27_1.middleLayerInfo)
	else
		arg_27_0.mapModel:initMap(arg_27_1.layerInfo)
	end

	arg_27_0:setMapEntrustInfo(arg_27_1)
	arg_27_0:initMapInteractive(arg_27_1)
	arg_27_0:setMapSkillInfo(arg_27_1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onInitMapInfoDone)
end

function var_0_0._updateMapInfo(arg_28_0, arg_28_1)
	if arg_28_0.mapType == RougeMapEnum.MapType.Middle or arg_28_0.mapType == RougeMapEnum.MapType.PathSelect then
		arg_28_0.mapModel:updateMapInfo(arg_28_1.middleLayerInfo)
	else
		arg_28_0.mapModel:updateMapInfo(arg_28_1.layerInfo)
	end

	arg_28_0:setMapEntrustInfo(arg_28_1)
	arg_28_0:setMapCurInteractive(arg_28_1)
	arg_28_0:setMapSkillInfo(arg_28_1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onUpdateMapInfo)
end

function var_0_0._changeMapInfo(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:_getTypeByInfo(arg_29_1)

	if RougeMapHelper.getChangeMapEnum(arg_29_0.mapType, var_29_0) == RougeMapEnum.ChangeMapEnum.NormalToMiddle then
		arg_29_0._newInfo = arg_29_1

		arg_29_0:clearInteractive()

		if arg_29_0:getMapState() == RougeMapEnum.MapState.Normal then
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeActorMoveToEnd)
		end

		return
	end

	arg_29_0:_initMapInfo(arg_29_1)
	arg_29_0:dispatchChangeMapEvent()
end

function var_0_0.updateToNewMapInfo(arg_30_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeNormalToMiddle)
	arg_30_0:setMapState(RougeMapEnum.MapState.SwitchMapAnim)

	if arg_30_0.mapModel then
		arg_30_0.mapModel:clear()
	end

	local var_30_0 = arg_30_0._newInfo

	arg_30_0._newInfo = nil

	arg_30_0:_initMapInfo(var_30_0)
	arg_30_0:dispatchChangeMapEvent()
end

function var_0_0.dispatchChangeMapEvent(arg_31_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeChangeMapInfo)
	TaskDispatcher.runDelay(arg_31_0._dispatchChangeMapEvent, arg_31_0, RougeMapEnum.WaitSwitchMapAnim)
end

function var_0_0._dispatchChangeMapEvent(arg_32_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChangeMapInfo)
end

function var_0_0.needPlayMoveToEndAnim(arg_33_0)
	return arg_33_0._newInfo ~= nil
end

function var_0_0.initMapInteractive(arg_34_0, arg_34_1)
	if not arg_34_1:HasField("curInteractiveIndex") then
		arg_34_0:clearInteractive()

		return
	end

	arg_34_0.interactiveJson = cjson.decode(arg_34_1.interactiveJson)

	if arg_34_0:checkDropIsEmpty(arg_34_1.curInteractive) then
		logError(string.format("触发掉落，但是掉落列表是空! interactive : %s, json : %s", arg_34_1.curInteractive, arg_34_1.interactiveJson))
		arg_34_0:clearInteractive()

		return
	end

	arg_34_0.curInteractive = arg_34_1.curInteractive
	arg_34_0.curInteractType = string.splitToNumber(arg_34_0.curInteractive, "#")[1]
	arg_34_0.curInteractiveIndex = arg_34_1.curInteractiveIndex
end

function var_0_0.setMapCurInteractive(arg_35_0, arg_35_1)
	if not arg_35_1:HasField("curInteractiveIndex") then
		arg_35_0:clearInteractive()

		return
	end

	arg_35_0.interactiveJson = cjson.decode(arg_35_1.interactiveJson)

	if arg_35_0:checkDropIsEmpty(arg_35_1.curInteractive) then
		logError(string.format("触发掉落，但是掉落列表是空! interactive : %s, json : %s", arg_35_1.curInteractive, arg_35_1.interactiveJson))
		arg_35_0:clearInteractive()

		return
	end

	if arg_35_0.curInteractiveIndex == arg_35_1.curInteractiveIndex then
		return
	end

	arg_35_0.curInteractive = arg_35_1.curInteractive
	arg_35_0.curInteractType = string.splitToNumber(arg_35_0.curInteractive, "#")[1]
	arg_35_0.curInteractiveIndex = arg_35_1.curInteractiveIndex

	RougeMapController.instance:dispatchEvent(RougeMapEvent.triggerInteract)
end

function var_0_0.clearInteractive(arg_36_0)
	logNormal("清理交互数据")

	arg_36_0.curInteractiveIndex = nil
	arg_36_0.curInteractive = nil
	arg_36_0.interactiveJson = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClearInteract)
end

function var_0_0.checkDropIsEmpty(arg_37_0, arg_37_1)
	local var_37_0 = string.splitToNumber(arg_37_1, "#")[1]

	if var_37_0 == RougeMapEnum.InteractType.Drop or var_37_0 == RougeMapEnum.InteractType.DropGroup or var_37_0 == RougeMapEnum.InteractType.AdvanceDrop then
		local var_37_1 = arg_37_0.interactiveJson.dropCollectList

		return not var_37_1 or #var_37_1 < 1
	end

	return false
end

function var_0_0.setMapEntrustInfo(arg_38_0, arg_38_1)
	if not arg_38_1:HasField("rougeEntrust") then
		arg_38_0:clearEntrustInfo()
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)

		return
	end

	local var_38_0 = arg_38_1.rougeEntrust
	local var_38_1 = var_38_0.id
	local var_38_2 = var_38_0.count

	if arg_38_0.entrustId == var_38_1 and arg_38_0.entrustProgress == var_38_2 then
		return
	end

	if arg_38_0.entrustId ~= var_38_1 then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onAcceptEntrust)
	end

	arg_38_0.entrustId = var_38_1
	arg_38_0.entrustProgress = var_38_2

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)
end

function var_0_0.updateEntrustInfo(arg_39_0, arg_39_1)
	if arg_39_1.id == 0 then
		arg_39_0:clearEntrustInfo()
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)

		return
	end

	arg_39_0.entrustId = arg_39_1.id
	arg_39_0.entrustProgress = arg_39_1.count

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)
end

function var_0_0.clearEntrustInfo(arg_40_0)
	arg_40_0.entrustId = nil
	arg_40_0.entrustProgress = nil
end

function var_0_0.getEntrustId(arg_41_0)
	return arg_41_0.entrustId
end

function var_0_0.getEntrustProgress(arg_42_0)
	return arg_42_0.entrustProgress
end

function var_0_0.setMapSkillInfo(arg_43_0, arg_43_1)
	arg_43_0._mapSkills = {}
	arg_43_0._mapSkillMap = {}

	for iter_43_0, iter_43_1 in ipairs(arg_43_1.mapSkill) do
		local var_43_0 = RougeMapSkillMO.New()

		var_43_0:init(iter_43_1)

		arg_43_0._mapSkillMap[var_43_0.id] = var_43_0

		table.insert(arg_43_0._mapSkills, var_43_0)
	end
end

function var_0_0.clearMapSkillInfo(arg_44_0)
	arg_44_0._mapSkills = nil
end

function var_0_0.getMapSkillList(arg_45_0)
	return arg_45_0._mapSkills
end

function var_0_0.onUpdateMapSkillInfo(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0._mapSkillMap and arg_46_0._mapSkillMap[arg_46_1.id]

	if var_46_0 then
		var_46_0:init(arg_46_1)
	end
end

function var_0_0.getEpisodeList(arg_47_0)
	return arg_47_0.mapModel and arg_47_0.mapModel:getEpisodeList()
end

function var_0_0.getNode(arg_48_0, arg_48_1)
	return arg_48_0.mapModel and arg_48_0.mapModel:getNode(arg_48_1)
end

function var_0_0.getEndNodeId(arg_49_0)
	return arg_49_0.mapModel and arg_49_0.mapModel:getEndNodeId()
end

function var_0_0.getCurEpisodeId(arg_50_0)
	return arg_50_0.mapModel and arg_50_0.mapModel:getCurEpisodeId()
end

function var_0_0.getCurNode(arg_51_0)
	return arg_51_0.mapModel and arg_51_0.mapModel.getCurNode and arg_51_0.mapModel:getCurNode()
end

function var_0_0.getCurEvent(arg_52_0)
	if not arg_52_0.mapModel then
		return
	end

	local var_52_0 = arg_52_0:getCurNode()

	return var_52_0 and var_52_0:getEventCo()
end

function var_0_0.getCurPieceMo(arg_53_0)
	return arg_53_0.mapModel.getCurPieceMo and arg_53_0.mapModel:getCurPieceMo()
end

function var_0_0.getNodeDict(arg_54_0)
	return arg_54_0.mapModel and arg_54_0.mapModel:getNodeDict()
end

function var_0_0.getCurInteractType(arg_55_0)
	return arg_55_0.curInteractType
end

function var_0_0.getCurInteractive(arg_56_0)
	return arg_56_0.curInteractive
end

function var_0_0.getCurInteractiveJson(arg_57_0)
	return arg_57_0.interactiveJson
end

function var_0_0.isInteractiving(arg_58_0)
	return arg_58_0.curInteractive ~= nil
end

function var_0_0.getPieceList(arg_59_0)
	return arg_59_0.mapModel and arg_59_0.mapModel:getPieceList()
end

function var_0_0.getPieceMo(arg_60_0, arg_60_1)
	return arg_60_0.mapModel and arg_60_0.mapModel:getPieceMo(arg_60_1)
end

function var_0_0.getMiddleLayerPosByIndex(arg_61_0, arg_61_1)
	return arg_61_0.mapModel and arg_61_0.mapModel:getMiddleLayerPosByIndex(arg_61_1)
end

function var_0_0.getPathIndex(arg_62_0, arg_62_1)
	if not arg_62_0.mapModel then
		return
	end

	return arg_62_0:getMiddleLayerPosByIndex(arg_62_1).z
end

function var_0_0.getMiddleLayerPathPos(arg_63_0, arg_63_1)
	return arg_63_0.mapModel and arg_63_0.mapModel:getMiddleLayerPathPos(arg_63_1)
end

function var_0_0.getMiddleLayerPathPosByPathIndex(arg_64_0, arg_64_1)
	return arg_64_0.mapModel and arg_64_0.mapModel:getMiddleLayerPathPosByPathIndex(arg_64_1)
end

function var_0_0.getMiddleLayerLeavePos(arg_65_0)
	if not arg_65_0.mapModel then
		return
	end

	return arg_65_0.mapModel:getMiddleLayerLeavePos()
end

function var_0_0.hadLeavePos(arg_66_0)
	if not arg_66_0.mapModel then
		return
	end

	return arg_66_0.mapModel:hadLeavePos()
end

function var_0_0.getMiddleLayerLeavePathIndex(arg_67_0)
	return arg_67_0.mapModel and arg_67_0.mapModel:getMiddleLayerLeavePathIndex()
end

function var_0_0.getCurPosIndex(arg_68_0)
	return arg_68_0.mapModel and arg_68_0.mapModel:getCurPosIndex()
end

function var_0_0.getMapName(arg_69_0)
	if not arg_69_0.mapModel then
		return
	end

	if arg_69_0.mapType == RougeMapEnum.MapType.Normal then
		return arg_69_0.mapModel.layerCo.name
	elseif arg_69_0.mapType == RougeMapEnum.MapType.Middle then
		return arg_69_0.mapModel.middleCo.name
	elseif arg_69_0.mapType == RougeMapEnum.MapType.PathSelect then
		return arg_69_0.mapModel.pathSelectCo.name
	end
end

function var_0_0.getNextLayerList(arg_70_0)
	return arg_70_0.mapModel and arg_70_0.mapModel:getNextLayerList()
end

function var_0_0.setEndId(arg_71_0, arg_71_1)
	arg_71_0.endId = arg_71_1
end

function var_0_0.getEndId(arg_72_0)
	if arg_72_0.endId then
		return arg_72_0.endId
	end

	return RougeMapHelper.getEndId()
end

function var_0_0.updateSelectLayerId(arg_73_0, arg_73_1)
	if not arg_73_0.mapModel then
		return
	end

	arg_73_0.mapModel:updateSelectLayerId(arg_73_1)
end

function var_0_0.getSelectLayerId(arg_74_0)
	return arg_74_0.mapModel and arg_74_0.mapModel:getSelectLayerId()
end

function var_0_0.getFogNodeList(arg_75_0)
	if arg_75_0.mapModel and arg_75_0.mapModel.getFogNodeList then
		return arg_75_0.mapModel:getFogNodeList()
	end
end

function var_0_0.getHoleNodeList(arg_76_0)
	if arg_76_0.mapModel and arg_76_0.mapModel.getFogNodeList then
		return arg_76_0.mapModel:getHoleNodeList()
	end
end

function var_0_0.isHoleNode(arg_77_0, arg_77_1)
	if arg_77_0.mapModel and arg_77_0.mapModel.isHoleNode then
		return arg_77_0.mapModel:isHoleNode(arg_77_1)
	end
end

function var_0_0.clear(arg_78_0)
	arg_78_0.inited = nil
	arg_78_0.mapType = nil
	arg_78_0.mapEpisodeIntervalX = nil
	arg_78_0.mapSize = nil
	arg_78_0.cameraSize = nil
	arg_78_0.minX = nil
	arg_78_0.maxX = nil
	arg_78_0.mapPosX = nil
	arg_78_0.focusScreenPosX = nil
	arg_78_0._newInfo = nil
	arg_78_0.interactiveJson = nil
	arg_78_0.curInteractive = nil
	arg_78_0.curInteractType = nil
	arg_78_0.curInteractiveIndex = nil
	arg_78_0.entrustId = nil
	arg_78_0.entrustProgress = nil
	arg_78_0.endId = nil
	arg_78_0.loading = nil
	arg_78_0.curChoiceId = nil
	arg_78_0.playingDialogue = nil
	arg_78_0.state = nil
	arg_78_0.mapState = nil
	arg_78_0.finalMap = nil
	arg_78_0.firstEnterMapFlag = nil

	TaskDispatcher.cancelTask(arg_78_0._dispatchChangeMapEvent, arg_78_0)

	if arg_78_0.mapModel then
		arg_78_0.mapModel:clear()

		arg_78_0.mapModel = nil

		return
	end

	if arg_78_0.preMapModel then
		arg_78_0.preMapModel:clear()

		arg_78_0.preMapModel = nil
	end
end

function var_0_0.setLoadingMap(arg_79_0, arg_79_1)
	arg_79_0.loading = arg_79_1
end

function var_0_0.checkIsLoading(arg_80_0)
	return arg_80_0.loading
end

function var_0_0.recordCurChoiceEventSelectId(arg_81_0, arg_81_1)
	arg_81_0.curChoiceId = arg_81_1
end

function var_0_0.getCurChoiceId(arg_82_0)
	return arg_82_0.curChoiceId
end

function var_0_0.setPlayingDialogue(arg_83_0, arg_83_1)
	arg_83_0.playingDialogue = arg_83_1
end

function var_0_0.isPlayingDialogue(arg_84_0)
	return arg_84_0.playingDialogue
end

function var_0_0.setChoiceViewState(arg_85_0, arg_85_1)
	arg_85_0.state = arg_85_1
end

function var_0_0.getChoiceViewState(arg_86_0)
	return arg_86_0.state
end

function var_0_0.setMapState(arg_87_0, arg_87_1)
	arg_87_0.mapState = arg_87_1
end

function var_0_0.getMapState(arg_88_0)
	return arg_88_0.mapState or RougeMapEnum.MapState.Empty
end

function var_0_0.setFinalMapInfo(arg_89_0, arg_89_1)
	arg_89_0.finalMap = arg_89_1
end

function var_0_0.getFinalMapInfo(arg_90_0)
	return arg_90_0.finalMap
end

function var_0_0.getExchangeMaxDisplaceNum(arg_91_0)
	local var_91_0 = RougeMapConfig.instance:getRestExchangeCount()
	local var_91_1 = RougeModel.instance:getEffectDict()

	if var_91_1 then
		for iter_91_0, iter_91_1 in pairs(var_91_1) do
			if iter_91_1.type == RougeMapEnum.EffectType.UpdateExchangeDisplaceNum then
				var_91_0 = var_91_0 + tonumber(iter_91_1.typeParam)
			end
		end
	end

	return var_91_0
end

function var_0_0.setFirstEnterMap(arg_92_0, arg_92_1)
	arg_92_0.firstEnterMapFlag = arg_92_1
end

function var_0_0.getFirstEnterMapFlag(arg_93_0)
	return arg_93_0.firstEnterMapFlag
end

var_0_0.instance = var_0_0.New()

return var_0_0

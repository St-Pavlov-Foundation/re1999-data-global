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

	arg_5_0.mapStartOffsetX = RougeMapEnum.MapStartOffsetX

	local var_5_0 = arg_5_0.mapSize.x - RougeMapEnum.MapStartOffsetX - RougeMapEnum.MapEndOffsetX
	local var_5_1 = #arg_5_0:getEpisodeList() - 1
	local var_5_2 = var_5_0 / var_5_1

	if var_5_2 > RougeMapEnum.MaxMapEpisodeIntervalX then
		var_5_2 = RougeMapEnum.MaxMapEpisodeIntervalX

		local var_5_3 = var_5_2 * var_5_1 + RougeMapEnum.MapStartOffsetX + RougeMapEnum.MapEndOffsetX

		arg_5_0.mapStartOffsetX = (arg_5_0.mapSize.x - var_5_3) / 2 + RougeMapEnum.MapStartOffsetX
		arg_5_0.mapSize.x = var_5_3
	end

	arg_5_0.mapEpisodeIntervalX = RougeMapHelper.retain2decimals(var_5_2)
end

function var_0_0.getMapStartOffsetX(arg_6_0)
	return arg_6_0.mapStartOffsetX or RougeMapEnum.MapStartOffsetX
end

function var_0_0.getMapEpisodeIntervalX(arg_7_0)
	return arg_7_0.mapEpisodeIntervalX
end

function var_0_0.setCameraSize(arg_8_0, arg_8_1)
	arg_8_0.cameraSize = arg_8_1
end

function var_0_0.setMapXRange(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.minX = arg_9_1
	arg_9_0.maxX = arg_9_2
end

function var_0_0.getCameraSize(arg_10_0)
	return arg_10_0.cameraSize
end

function var_0_0.setMapPosX(arg_11_0, arg_11_1)
	if arg_11_1 < arg_11_0.minX then
		arg_11_1 = arg_11_0.minX
	end

	if arg_11_1 > arg_11_0.maxX then
		arg_11_1 = arg_11_0.maxX
	end

	if arg_11_0.mapPosX == arg_11_1 then
		return
	end

	arg_11_0.mapPosX = arg_11_1

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMapPosChange, arg_11_0.mapPosX)
end

function var_0_0.getMapPosX(arg_12_0)
	return arg_12_0.mapPosX
end

function var_0_0.setFocusScreenPosX(arg_13_0, arg_13_1)
	arg_13_0.focusScreenPosX = arg_13_1
end

function var_0_0.getFocusScreenPosX(arg_14_0)
	return arg_14_0.focusScreenPosX
end

function var_0_0.getLayerId(arg_15_0)
	return arg_15_0.mapModel and arg_15_0.mapModel.layerId
end

function var_0_0.getLayerCo(arg_16_0)
	return arg_16_0.mapModel and arg_16_0.mapModel.layerCo
end

function var_0_0.isNormalLayer(arg_17_0)
	return arg_17_0.mapType == RougeMapEnum.MapType.Normal
end

function var_0_0.isMiddle(arg_18_0)
	return arg_18_0.mapType == RougeMapEnum.MapType.Middle
end

function var_0_0.isPathSelect(arg_19_0)
	return arg_19_0.mapType == RougeMapEnum.MapType.PathSelect
end

function var_0_0.getMiddleLayerId(arg_20_0)
	return arg_20_0.mapModel and arg_20_0.mapModel.middleLayerId
end

function var_0_0.getMiddleLayerCo(arg_21_0)
	return arg_21_0.mapModel and arg_21_0.mapModel.middleCo
end

function var_0_0.getPathSelectCo(arg_22_0)
	return arg_22_0.mapModel and arg_22_0.mapModel.pathSelectCo
end

function var_0_0.setWaitLeaveMiddleLayerReply(arg_23_0, arg_23_1)
	arg_23_0.waitMiddleLayerReply = arg_23_1
end

function var_0_0.updateSimpleMapInfo(arg_24_0, arg_24_1)
	if arg_24_0.waitMiddleLayerReply then
		return
	end

	if not arg_24_0:_isSameMap(arg_24_1) then
		return
	end

	if arg_24_0.mapType == RougeMapEnum.MapType.Middle or arg_24_0.mapType == RougeMapEnum.MapType.PathSelect then
		arg_24_0.mapModel:updateSimpleMapInfo(arg_24_1.middleLayerInfo)
	else
		arg_24_0.mapModel:updateSimpleMapInfo(arg_24_1.layerInfo)
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onUpdateMapInfo)
end

function var_0_0.updateMapInfo(arg_25_0, arg_25_1)
	if arg_25_0.waitMiddleLayerReply then
		return
	end

	if arg_25_0.inited then
		if arg_25_0:_isSameMap(arg_25_1) then
			arg_25_0:_updateMapInfo(arg_25_1)
		else
			arg_25_0:_changeMapInfo(arg_25_1)
		end
	else
		arg_25_0:_initMapInfo(arg_25_1)
	end
end

function var_0_0._isSameMap(arg_26_0, arg_26_1)
	if not arg_26_0.inited then
		return false
	end

	if arg_26_0.mapType ~= arg_26_0:_getTypeByInfo(arg_26_1) then
		return false
	end

	if arg_26_0.mapType == RougeMapEnum.MapType.Normal then
		return arg_26_0.mapModel.layerId == arg_26_1.layerInfo.layerId
	end

	local var_26_0 = arg_26_1.middleLayerInfo

	return arg_26_0.mapModel.layerId == var_26_0.layerId and arg_26_0.mapModel.middleLayerId == var_26_0.middleLayerId
end

function var_0_0._getTypeByInfo(arg_27_0, arg_27_1)
	if arg_27_1.mapType ~= RougeMapEnum.MapType.Middle then
		return arg_27_1.mapType
	end

	if arg_27_1.middleLayerInfo.positionIndex == RougeMapEnum.PathSelectIndex then
		return RougeMapEnum.MapType.PathSelect
	end

	return RougeMapEnum.MapType.Middle
end

function var_0_0._initMapInfo(arg_28_0, arg_28_1)
	arg_28_0.inited = true
	arg_28_0.mapType = arg_28_0:_getTypeByInfo(arg_28_1)
	arg_28_0.mapModel = RougeMapEnum.MapType2ModelCls[arg_28_0.mapType].New()

	if arg_28_0.mapType == RougeMapEnum.MapType.Middle or arg_28_0.mapType == RougeMapEnum.MapType.PathSelect then
		arg_28_0.mapModel:initMap(arg_28_1.middleLayerInfo)
	else
		arg_28_0.mapModel:initMap(arg_28_1.layerInfo)
	end

	arg_28_0:setMapEntrustInfo(arg_28_1)
	arg_28_0:initMapInteractive(arg_28_1)
	arg_28_0:setMapSkillInfo(arg_28_1)
	arg_28_0:setDLCInfo_103(arg_28_1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onInitMapInfoDone)
end

function var_0_0._updateMapInfo(arg_29_0, arg_29_1)
	if arg_29_0.mapType == RougeMapEnum.MapType.Middle or arg_29_0.mapType == RougeMapEnum.MapType.PathSelect then
		arg_29_0.mapModel:updateMapInfo(arg_29_1.middleLayerInfo)
	else
		arg_29_0.mapModel:updateMapInfo(arg_29_1.layerInfo)
	end

	arg_29_0:setMapEntrustInfo(arg_29_1)
	arg_29_0:setMapCurInteractive(arg_29_1)
	arg_29_0:setMapSkillInfo(arg_29_1)
	arg_29_0:setDLCInfo_103(arg_29_1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onUpdateMapInfo)
end

function var_0_0._changeMapInfo(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:_getTypeByInfo(arg_30_1)

	if RougeMapHelper.getChangeMapEnum(arg_30_0.mapType, var_30_0) == RougeMapEnum.ChangeMapEnum.NormalToMiddle then
		arg_30_0._newInfo = arg_30_1

		arg_30_0:clearInteractive()

		if arg_30_0:getMapState() == RougeMapEnum.MapState.Normal then
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeActorMoveToEnd)
		end

		return
	end

	arg_30_0:_initMapInfo(arg_30_1)
	arg_30_0:dispatchChangeMapEvent()
end

function var_0_0.updateToNewMapInfo(arg_31_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeNormalToMiddle)
	arg_31_0:setMapState(RougeMapEnum.MapState.SwitchMapAnim)

	if arg_31_0.mapModel then
		arg_31_0.mapModel:clear()
	end

	local var_31_0 = arg_31_0._newInfo

	arg_31_0._newInfo = nil

	arg_31_0:_initMapInfo(var_31_0)
	arg_31_0:dispatchChangeMapEvent()
end

function var_0_0.dispatchChangeMapEvent(arg_32_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeChangeMapInfo)
	TaskDispatcher.runDelay(arg_32_0._dispatchChangeMapEvent, arg_32_0, RougeMapEnum.WaitSwitchMapAnim)
end

function var_0_0._dispatchChangeMapEvent(arg_33_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChangeMapInfo)
end

function var_0_0.needPlayMoveToEndAnim(arg_34_0)
	return arg_34_0._newInfo ~= nil
end

function var_0_0.initMapInteractive(arg_35_0, arg_35_1)
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

	arg_35_0.curInteractive = arg_35_1.curInteractive
	arg_35_0.curInteractType = string.splitToNumber(arg_35_0.curInteractive, "#")[1]
	arg_35_0.curInteractiveIndex = arg_35_1.curInteractiveIndex
end

function var_0_0.setMapCurInteractive(arg_36_0, arg_36_1)
	if not arg_36_1:HasField("curInteractiveIndex") then
		arg_36_0:clearInteractive()

		return
	end

	arg_36_0.interactiveJson = cjson.decode(arg_36_1.interactiveJson)

	if arg_36_0:checkDropIsEmpty(arg_36_1.curInteractive) then
		logError(string.format("触发掉落，但是掉落列表是空! interactive : %s, json : %s", arg_36_1.curInteractive, arg_36_1.interactiveJson))
		arg_36_0:clearInteractive()

		return
	end

	if arg_36_0.curInteractiveIndex == arg_36_1.curInteractiveIndex then
		return
	end

	arg_36_0.curInteractive = arg_36_1.curInteractive
	arg_36_0.curInteractType = string.splitToNumber(arg_36_0.curInteractive, "#")[1]
	arg_36_0.curInteractiveIndex = arg_36_1.curInteractiveIndex

	RougeMapController.instance:dispatchEvent(RougeMapEvent.triggerInteract)
end

function var_0_0.clearInteractive(arg_37_0)
	logNormal("清理交互数据")

	arg_37_0.curInteractiveIndex = nil
	arg_37_0.curInteractive = nil
	arg_37_0.interactiveJson = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClearInteract)
end

function var_0_0.checkDropIsEmpty(arg_38_0, arg_38_1)
	local var_38_0 = string.splitToNumber(arg_38_1, "#")[1]

	if var_38_0 == RougeMapEnum.InteractType.Drop or var_38_0 == RougeMapEnum.InteractType.DropGroup or var_38_0 == RougeMapEnum.InteractType.AdvanceDrop then
		local var_38_1 = arg_38_0.interactiveJson.dropCollectList

		return not var_38_1 or #var_38_1 < 1
	end

	return false
end

function var_0_0.setMapEntrustInfo(arg_39_0, arg_39_1)
	if not arg_39_1:HasField("rougeEntrust") then
		arg_39_0:clearEntrustInfo()
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)

		return
	end

	local var_39_0 = arg_39_1.rougeEntrust
	local var_39_1 = var_39_0.id
	local var_39_2 = var_39_0.count

	if arg_39_0.entrustId == var_39_1 and arg_39_0.entrustProgress == var_39_2 then
		return
	end

	if arg_39_0.entrustId ~= var_39_1 then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onAcceptEntrust)
	end

	arg_39_0.entrustId = var_39_1
	arg_39_0.entrustProgress = var_39_2

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)
end

function var_0_0.updateEntrustInfo(arg_40_0, arg_40_1)
	if arg_40_1.id == 0 then
		arg_40_0:clearEntrustInfo()
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)

		return
	end

	arg_40_0.entrustId = arg_40_1.id
	arg_40_0.entrustProgress = arg_40_1.count

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)
end

function var_0_0.clearEntrustInfo(arg_41_0)
	arg_41_0.entrustId = nil
	arg_41_0.entrustProgress = nil
end

function var_0_0.getEntrustId(arg_42_0)
	return arg_42_0.entrustId
end

function var_0_0.getEntrustProgress(arg_43_0)
	return arg_43_0.entrustProgress
end

function var_0_0.setMapSkillInfo(arg_44_0, arg_44_1)
	arg_44_0._mapSkills = {}
	arg_44_0._mapSkillMap = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_1.mapSkill) do
		local var_44_0 = RougeMapSkillMO.New()

		var_44_0:init(iter_44_1)

		arg_44_0._mapSkillMap[var_44_0.id] = var_44_0

		table.insert(arg_44_0._mapSkills, var_44_0)
	end
end

function var_0_0.setDLCInfo_103(arg_45_0, arg_45_1)
	arg_45_0.monsterRuleFreshNum = arg_45_1.monsterRuleFreshNum or 0
	arg_45_0.monsterRuleCanFreshNum = arg_45_1.monsterRuleCanFreshNum or 0
	arg_45_0.choiceCollection = arg_45_1.choiceCollection or 0
	arg_45_0.monsterRuleRemainCanFreshNum = arg_45_0.monsterRuleCanFreshNum - arg_45_0.monsterRuleFreshNum
end

function var_0_0.getMonsterRuleRemainCanFreshNum(arg_46_0)
	return arg_46_0.monsterRuleRemainCanFreshNum or 0
end

function var_0_0.getChoiceCollection(arg_47_0)
	return arg_47_0.choiceCollection
end

function var_0_0.clearMapSkillInfo(arg_48_0)
	arg_48_0._mapSkills = nil
end

function var_0_0.getMapSkillList(arg_49_0)
	return arg_49_0._mapSkills
end

function var_0_0.onUpdateMapSkillInfo(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0._mapSkillMap and arg_50_0._mapSkillMap[arg_50_1.id]

	if var_50_0 then
		var_50_0:init(arg_50_1)
	end
end

function var_0_0.getEpisodeList(arg_51_0)
	return arg_51_0.mapModel and arg_51_0.mapModel:getEpisodeList()
end

function var_0_0.getNode(arg_52_0, arg_52_1)
	return arg_52_0.mapModel and arg_52_0.mapModel:getNode(arg_52_1)
end

function var_0_0.getEndNodeId(arg_53_0)
	return arg_53_0.mapModel and arg_53_0.mapModel:getEndNodeId()
end

function var_0_0.getCurEpisodeId(arg_54_0)
	return arg_54_0.mapModel and arg_54_0.mapModel:getCurEpisodeId()
end

function var_0_0.getCurNode(arg_55_0)
	return arg_55_0.mapModel and arg_55_0.mapModel.getCurNode and arg_55_0.mapModel:getCurNode()
end

function var_0_0.getCurEvent(arg_56_0)
	if not arg_56_0.mapModel then
		return
	end

	local var_56_0 = arg_56_0:getCurNode()

	return var_56_0 and var_56_0:getEventCo()
end

function var_0_0.getCurPieceMo(arg_57_0)
	return arg_57_0.mapModel.getCurPieceMo and arg_57_0.mapModel:getCurPieceMo()
end

function var_0_0.getNodeDict(arg_58_0)
	return arg_58_0.mapModel and arg_58_0.mapModel:getNodeDict()
end

function var_0_0.getCurInteractType(arg_59_0)
	return arg_59_0.curInteractType
end

function var_0_0.getCurInteractive(arg_60_0)
	return arg_60_0.curInteractive
end

function var_0_0.getCurInteractiveJson(arg_61_0)
	return arg_61_0.interactiveJson
end

function var_0_0.isInteractiving(arg_62_0)
	return arg_62_0.curInteractive ~= nil
end

function var_0_0.getPieceList(arg_63_0)
	return arg_63_0.mapModel and arg_63_0.mapModel:getPieceList()
end

function var_0_0.getPieceMo(arg_64_0, arg_64_1)
	return arg_64_0.mapModel and arg_64_0.mapModel:getPieceMo(arg_64_1)
end

function var_0_0.getMiddleLayerPosByIndex(arg_65_0, arg_65_1)
	return arg_65_0.mapModel and arg_65_0.mapModel:getMiddleLayerPosByIndex(arg_65_1)
end

function var_0_0.getPathIndex(arg_66_0, arg_66_1)
	if not arg_66_0.mapModel then
		return
	end

	return arg_66_0:getMiddleLayerPosByIndex(arg_66_1).z
end

function var_0_0.getMiddleLayerPathPos(arg_67_0, arg_67_1)
	return arg_67_0.mapModel and arg_67_0.mapModel:getMiddleLayerPathPos(arg_67_1)
end

function var_0_0.getMiddleLayerPathPosByPathIndex(arg_68_0, arg_68_1)
	return arg_68_0.mapModel and arg_68_0.mapModel:getMiddleLayerPathPosByPathIndex(arg_68_1)
end

function var_0_0.getMiddleLayerLeavePos(arg_69_0)
	if not arg_69_0.mapModel then
		return
	end

	return arg_69_0.mapModel:getMiddleLayerLeavePos()
end

function var_0_0.hadLeavePos(arg_70_0)
	if not arg_70_0.mapModel then
		return
	end

	return arg_70_0.mapModel:hadLeavePos()
end

function var_0_0.getMiddleLayerLeavePathIndex(arg_71_0)
	return arg_71_0.mapModel and arg_71_0.mapModel:getMiddleLayerLeavePathIndex()
end

function var_0_0.getCurPosIndex(arg_72_0)
	return arg_72_0.mapModel and arg_72_0.mapModel:getCurPosIndex()
end

function var_0_0.getMapName(arg_73_0)
	if not arg_73_0.mapModel then
		return
	end

	if arg_73_0.mapType == RougeMapEnum.MapType.Normal then
		return arg_73_0.mapModel.layerCo.name
	elseif arg_73_0.mapType == RougeMapEnum.MapType.Middle then
		return arg_73_0.mapModel.middleCo.name
	elseif arg_73_0.mapType == RougeMapEnum.MapType.PathSelect then
		return arg_73_0.mapModel.pathSelectCo.name
	end
end

function var_0_0.getNextLayerList(arg_74_0)
	return arg_74_0.mapModel and arg_74_0.mapModel:getNextLayerList()
end

function var_0_0.setEndId(arg_75_0, arg_75_1)
	arg_75_0.endId = arg_75_1
end

function var_0_0.getEndId(arg_76_0)
	if arg_76_0.endId then
		return arg_76_0.endId
	end

	return RougeMapHelper.getEndId()
end

function var_0_0.updateSelectLayerId(arg_77_0, arg_77_1)
	if not arg_77_0.mapModel then
		return
	end

	arg_77_0.mapModel:updateSelectLayerId(arg_77_1)
end

function var_0_0.getSelectLayerId(arg_78_0)
	return arg_78_0.mapModel and arg_78_0.mapModel:getSelectLayerId()
end

function var_0_0.getFogNodeList(arg_79_0)
	if arg_79_0.mapModel and arg_79_0.mapModel.getFogNodeList then
		return arg_79_0.mapModel:getFogNodeList()
	end
end

function var_0_0.getHoleNodeList(arg_80_0)
	if arg_80_0.mapModel and arg_80_0.mapModel.getFogNodeList then
		return arg_80_0.mapModel:getHoleNodeList()
	end
end

function var_0_0.isHoleNode(arg_81_0, arg_81_1)
	if arg_81_0.mapModel and arg_81_0.mapModel.isHoleNode then
		return arg_81_0.mapModel:isHoleNode(arg_81_1)
	end
end

function var_0_0.clear(arg_82_0)
	arg_82_0.inited = nil
	arg_82_0.mapType = nil
	arg_82_0.mapEpisodeIntervalX = nil
	arg_82_0.mapSize = nil
	arg_82_0.cameraSize = nil
	arg_82_0.minX = nil
	arg_82_0.maxX = nil
	arg_82_0.mapPosX = nil
	arg_82_0.focusScreenPosX = nil
	arg_82_0._newInfo = nil
	arg_82_0.interactiveJson = nil
	arg_82_0.curInteractive = nil
	arg_82_0.curInteractType = nil
	arg_82_0.curInteractiveIndex = nil
	arg_82_0.entrustId = nil
	arg_82_0.entrustProgress = nil
	arg_82_0.endId = nil
	arg_82_0.loading = nil
	arg_82_0.curChoiceId = nil
	arg_82_0.playingDialogue = nil
	arg_82_0.state = nil
	arg_82_0.mapState = nil
	arg_82_0.finalMap = nil
	arg_82_0.firstEnterMapFlag = nil

	TaskDispatcher.cancelTask(arg_82_0._dispatchChangeMapEvent, arg_82_0)

	if arg_82_0.mapModel then
		arg_82_0.mapModel:clear()

		arg_82_0.mapModel = nil

		return
	end

	if arg_82_0.preMapModel then
		arg_82_0.preMapModel:clear()

		arg_82_0.preMapModel = nil
	end
end

function var_0_0.setLoadingMap(arg_83_0, arg_83_1)
	arg_83_0.loading = arg_83_1
end

function var_0_0.checkIsLoading(arg_84_0)
	return arg_84_0.loading
end

function var_0_0.recordCurChoiceEventSelectId(arg_85_0, arg_85_1)
	arg_85_0.curChoiceId = arg_85_1
end

function var_0_0.getCurChoiceId(arg_86_0)
	return arg_86_0.curChoiceId
end

function var_0_0.setPlayingDialogue(arg_87_0, arg_87_1)
	arg_87_0.playingDialogue = arg_87_1
end

function var_0_0.isPlayingDialogue(arg_88_0)
	return arg_88_0.playingDialogue
end

function var_0_0.setChoiceViewState(arg_89_0, arg_89_1)
	arg_89_0.state = arg_89_1
end

function var_0_0.getChoiceViewState(arg_90_0)
	return arg_90_0.state
end

function var_0_0.setMapState(arg_91_0, arg_91_1)
	arg_91_0.mapState = arg_91_1
end

function var_0_0.getMapState(arg_92_0)
	return arg_92_0.mapState or RougeMapEnum.MapState.Empty
end

function var_0_0.setFinalMapInfo(arg_93_0, arg_93_1)
	arg_93_0.finalMap = arg_93_1
end

function var_0_0.getFinalMapInfo(arg_94_0)
	return arg_94_0.finalMap
end

function var_0_0.getExchangeMaxDisplaceNum(arg_95_0)
	local var_95_0 = RougeMapConfig.instance:getRestExchangeCount()
	local var_95_1 = RougeModel.instance:getEffectDict()

	if var_95_1 then
		for iter_95_0, iter_95_1 in pairs(var_95_1) do
			if iter_95_1.type == RougeMapEnum.EffectType.UpdateExchangeDisplaceNum then
				var_95_0 = var_95_0 + tonumber(iter_95_1.typeParam)
			end
		end
	end

	return var_95_0
end

function var_0_0.setFirstEnterMap(arg_96_0, arg_96_1)
	arg_96_0.firstEnterMapFlag = arg_96_1
end

function var_0_0.getFirstEnterMapFlag(arg_97_0)
	return arg_97_0.firstEnterMapFlag
end

function var_0_0.getLayerChoiceInfo(arg_98_0, arg_98_1)
	if arg_98_0.mapModel and arg_98_0.mapModel.getLayerChoiceInfo then
		return arg_98_0.mapModel:getLayerChoiceInfo(arg_98_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

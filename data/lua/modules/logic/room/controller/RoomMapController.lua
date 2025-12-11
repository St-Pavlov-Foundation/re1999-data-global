module("modules.logic.room.controller.RoomMapController", package.seeall)

local var_0_0 = class("RoomMapController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0._isResetEdit = nil
	arg_3_0._isNeedConfirmRoom = arg_3_0._isResetRoomReply and true or false
	arg_3_0._isHasConfirmOp = false
	arg_3_0._isResetRoomReply = false
	arg_3_0._isUIHide = false

	TaskDispatcher.cancelTask(arg_3_0._realOpenRoomInitBuildingView, arg_3_0)

	arg_3_0._openRoomInitBuildingViewCameraState = nil
	arg_3_0._openRoomInitBuildingViewZoom = nil
end

function var_0_0.addConstEvents(arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	arg_4_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnHour, arg_4_0._onHourReporting, arg_4_0)
end

function var_0_0._onOpenView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.RoomInitBuildingView then
		TaskDispatcher.cancelTask(arg_5_0._realOpenRoomInitBuildingView, arg_5_0)
	end
end

function var_0_0._onHourReporting(arg_6_0)
	local var_6_0 = os.date("*t", ServerTime.nowInLocal()).hour

	arg_6_0:dispatchEvent(RoomEvent.OnHourReporting, var_6_0)
end

function var_0_0.updateBlockReplaceDefineId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 or RoomMapBlockModel.instance:getFullBlockMOList()
	local var_7_1 = RoomMapBuildingModel.instance

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		iter_7_1.replaceDefineId = nil
		iter_7_1.replaceRotate = nil

		if iter_7_1.hexPoint then
			local var_7_2 = var_7_1:getBuildingParam(iter_7_1.hexPoint.x, iter_7_1.hexPoint.y)

			if not var_7_2 and not RoomBuildingController.instance:isPressBuilding() then
				var_7_2 = var_7_1:getTempBuildingParam(iter_7_1.hexPoint.x, iter_7_1.hexPoint.y)
			end

			iter_7_1.replaceDefineId = var_7_2 and var_7_2.blockDefineId
			iter_7_1.replaceRotate = var_7_2 and var_7_2.blockRotate
		end
	end
end

function var_0_0.initMap(arg_8_0)
	local var_8_0 = RoomModel.instance:getEditInfo()

	arg_8_0._isResetEdit = RoomController.instance:isEditMode() and var_8_0 and var_8_0.isReset

	RoomMapModel.instance:init()

	arg_8_0._isHasConfirmOp = false

	local var_8_1 = RoomModel.instance:getGameMode()
	local var_8_2 = arg_8_0:_getInitMapFuncByGameMode(var_8_1)
	local var_8_3 = RoomModel.instance:getInfoByMode(var_8_1)

	if var_8_2 then
		var_8_2(arg_8_0, var_8_0, var_8_3)
	else
		logError(string.format("can not find initMap function by gameModel:%s", var_8_1))
	end

	RoomMapHexPointModel.instance:init()
	RoomResourceModel.instance:init()
	arg_8_0:dispatchEvent(RoomEvent.UpdateInventoryCount)
end

function var_0_0._getInitMapFuncByGameMode(arg_9_0, arg_9_1)
	if not arg_9_0._initMapFuncMap then
		arg_9_0._initMapFuncMap = {
			[RoomEnum.GameMode.Ob] = arg_9_0._initMapOb,
			[RoomEnum.GameMode.Edit] = arg_9_0._initMapEdit,
			[RoomEnum.GameMode.Visit] = arg_9_0._initMapVisit,
			[RoomEnum.GameMode.VisitShare] = arg_9_0._initMapVisit,
			[RoomEnum.GameMode.DebugNormal] = arg_9_0._initMapDebug,
			[RoomEnum.GameMode.DebugInit] = arg_9_0._initMapDebug,
			[RoomEnum.GameMode.DebugPackage] = arg_9_0._initMapDebug,
			[RoomEnum.GameMode.Fishing] = arg_9_0._initMapFishing,
			[RoomEnum.GameMode.FishingVisit] = arg_9_0._initMapFishing
		}
	end

	return arg_9_0._initMapFuncMap[arg_9_1]
end

function var_0_0._initMapOb(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = RoomModel.instance:getEnterParam()

	RoomModel.instance:resetBuildingInfos()
	RoomModel.instance:updateBuildingInfos(arg_10_2.buildingInfos or {})
	RoomMapModel.instance:updateRoomLevel(arg_10_2.roomLevel)
	RoomProductionModel.instance:updateLineMaxLevel()
	RoomMapBlockModel.instance:initMap(arg_10_2.infos)
	RoomMapBuildingModel.instance:initMap(arg_10_2.buildingInfos)
	RoomCharacterModel.instance:initCharacter(arg_10_2.roomHeroDatas)
	RoomCritterModel.instance:initCititer(arg_10_2.roomCititerDatas)
	RoomFormulaModel.instance:initFormula(arg_10_2.formulaInfos)
	RoomMapBuildingAreaModel.instance:init()
	RoomTransportController.instance:initPathData(arg_10_2.roadInfos)
	RoomInventoryBuildingModel.instance:initInventory(RoomModel.instance:getBuildingInfoList())
	RoomShowBuildingListModel.instance:initShowBuilding()
	RoomDebugPlaceListModel.instance:initDebugPlace()
	RoomCharacterPlaceListModel.instance:initCharacterPlace()

	if not var_10_0 or not var_10_0.isFromEditMode then
		RoomShowBuildingListModel.instance:initFilter()
		RoomCharacterPlaceListModel.instance:initFilter()
		RoomCharacterPlaceListModel.instance:initOrder()
	end

	RoomTransportController.instance:updateBlockUseState()
	arg_10_0:updateBlockReplaceDefineId()
	RoomCharacterController.instance:refreshCharacterFaithTimer()
	RoomCharacterController.instance:init()
	RoomVehicleController.instance:init()
	RoomInteractionController.instance:init()
	RoomCritterController.instance:initMapTrainCritter()
	RoomCritterController.instance:init()
	RoomInteractBuildingModel.instance:init()
end

function var_0_0._initMapEdit(arg_11_0, arg_11_1)
	RoomThemeFilterListModel.instance:init()

	local var_11_0 = RoomModel.instance:getInfoByMode(RoomEnum.GameMode.Ob)

	RoomMapModel.instance:updateRoomLevel(var_11_0.roomLevel)
	RoomProductionModel.instance:updateLineMaxLevel()
	RoomMapBlockModel.instance:initMap(arg_11_1.infos)

	local var_11_1 = RoomModel.instance:getBlockPackageIds()
	local var_11_2 = RoomModel.instance:getSpecialBlockIds()

	RoomInventoryBlockModel.instance:initInventory(var_11_1, arg_11_1.blockPackages, arg_11_1.infos, var_11_2)
	RoomMapBuildingModel.instance:initMap(arg_11_1.buildingInfos)
	RoomModel.instance:resetBuildingInfos()
	RoomModel.instance:updateBuildingInfos(arg_11_1.buildingInfos or {})
	RoomInventoryBuildingModel.instance:initInventory(RoomModel.instance:getBuildingInfoList())
	RoomCharacterModel.instance:initCharacter(var_11_0.roomHeroDatas)
	RoomCritterModel.instance:initCititer(var_11_0.roomCititerDatas)
	RoomMapBuildingAreaModel.instance:init()
	RoomTransportController.instance:initPathData(arg_11_1.roadInfos)
	RoomTransportController.instance:updateBlockUseState()
	arg_11_0:updateBlockReplaceDefineId()
	RoomInteractBuildingModel.instance:init()
end

function var_0_0._initMapVisit(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2.infos or {}
	local var_12_1 = arg_12_2.buildingInfos or {}
	local var_12_2 = RoomModel.instance:getVisitParam()

	if RoomLayoutHelper.checkVisitParamCoppare(var_12_2) then
		var_12_0, var_12_1 = RoomLayoutHelper.findHasBlockBuildingInfos(var_12_0, var_12_1)
	end

	RoomMapModel.instance:setOtherLineLevelDict(arg_12_2.productionLines)
	RoomSkinModel.instance:setOtherPlayerRoomSkinDict(arg_12_2.skins)
	RoomMapModel.instance:updateRoomLevel(arg_12_2.roomLevel)
	RoomMapBlockModel.instance:initMap(var_12_0)
	RoomMapBuildingModel.instance:initMap(var_12_1)
	RoomCharacterModel.instance:initCharacter(arg_12_2.roomHeroDatas)
	RoomCritterModel.instance:initCititer(arg_12_2.roomCititerDatas)
	RoomMapBuildingAreaModel.instance:init()
	RoomTransportController.instance:initPathData(arg_12_2.roadInfos)
	RoomTransportController.instance:updateBlockUseState()
	RoomVehicleController.instance:init()
	RoomInteractBuildingModel.instance:init()
end

function var_0_0._initMapDebug(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = RoomModel.instance:getDebugParam()

	RoomMapBlockModel.instance:initMap(arg_13_1.infos)
	RoomMapBuildingModel.instance:initMap(arg_13_1.buildingInfos)

	if RoomController.instance:isDebugMode() then
		logNormal("直接点击放置地块")
		logNormal("点击已放置的地块更改资源样式")
		logNormal("Shift + 点击: 选中地块信息")
		logNormal("Shift + S: 所有地块信息")
		logNormal("Z: 更改地块中心资源样式")
		logNormal("X: 旋转地块")
		logNormal("C: 删除地块")
	end

	if RoomController.instance:isDebugNormalMode() then
		logNormal("V: 放置建筑")
		logNormal("B: 旋转建筑")
		logNormal("N: 删除建筑")
	end

	if RoomController.instance:isDebugPackageMode() then
		logNormal("按住C点击下面地块包UI中的地块: 从地块包中移除地块")
		logNormal("按住Shift点击下面地块包UI中的地块: 指定地块在地块包中的分类")
		logNormal("按住Ctrl点击下面地块包UI中的地块: 指定地块在地块包中的顺序")
	end
end

function var_0_0._initMapFishing(arg_14_0, arg_14_1, arg_14_2)
	RoomMapBlockModel.instance:initMap(arg_14_2.infos)
	RoomMapBuildingModel.instance:initMap(arg_14_2.buildingInfos)
end

function var_0_0.clearMap(arg_15_0)
	RoomModel.instance:updateCharacterPoint()
	RoomMapBlockModel.instance:clear()
	RoomInventoryBlockModel.instance:clear()
	RoomMapModel.instance:clear()
	RoomResourceModel.instance:clear()
	RoomMapBuildingModel.instance:clear()
	RoomFormulaListModel.instance:clear()
	RoomFormulaModel.instance:clear()
	RoomShowBuildingListModel.instance:clearMapData()
	RoomDebugPlaceListModel.instance:clear()
	RoomCharacterPlaceListModel.instance:clearMapData()
	RoomCharacterModel.instance:clear()
	RoomMapBuildingAreaModel.instance:clear()
	RoomTransportController.instance:clear()
	arg_15_0:clear()
	RoomDebugController.instance:clear()
	RoomBuildingController.instance:clear()
	RoomBuildingFormulaController.instance:clear()
	RoomCharacterController.instance:clear()
	RoomVehicleController.instance:clear()
	RoomInteractionController.instance:clear()
	RoomCritterController.instance:clear()
	RoomInteractBuildingModel.instance:clear()
end

function var_0_0.resetRoom(arg_16_0)
	if RoomController.instance:isDebugNormalMode() then
		PlayerPrefsHelper.setString(PlayerPrefsKey.RoomDebugMapParam, "")
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugNormal)
	elseif RoomController.instance:isDebugInitMode() then
		local var_16_0 = RoomModel.instance:getDebugParam()

		RoomDebugController.instance:resetInitJson()
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugInit, nil, nil, var_16_0)
	elseif RoomController.instance:isDebugPackageMode() then
		local var_16_1 = RoomModel.instance:getDebugParam()

		RoomDebugController.instance:resetPackageJson(var_16_1.packageMapId)
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugPackage, nil, nil, var_16_1)
	elseif RoomController.instance:isEditMode() then
		RoomRpc.instance:sendResetRoomRequest(arg_16_0._resetRoomReply, arg_16_0)
	end
end

function var_0_0._resetRoomReply(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_2 ~= 0 then
		return
	end

	arg_17_0._isNeedConfirmRoom = true
	arg_17_0._isResetRoomReply = true

	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit, arg_17_3, RoomModel.instance:getObInfo(), nil, nil, nil, true)
end

function var_0_0.useBlockRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = RoomConfig.instance:getBlock(arg_18_1)

	if var_18_0 then
		RoomRpc.instance:sendUseBlockRequest(arg_18_1, var_18_0.packageId, arg_18_2, arg_18_3, arg_18_4)
	end
end

function var_0_0.unUseBlockListRequest(arg_19_0, arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		local var_19_1 = RoomConfig.instance:getPackageConfigByBlockId(iter_19_1)

		var_19_0 = var_19_0 + (var_19_1 and var_19_1.blockBuildDegree or 0)
	end

	RoomRpc.instance:sendUnUseBlockRequest(arg_19_1)
end

function var_0_0.unUseBlockRequest(arg_20_0, arg_20_1)
	RoomRpc.instance:sendUnUseBlockRequest({
		arg_20_1
	})
end

function var_0_0.unUseBlockReply(arg_21_0, arg_21_1)
	arg_21_0._isNeedConfirmRoom = true

	local var_21_0 = GameSceneMgr.instance:getCurScene()
	local var_21_1 = RoomMapBlockModel.instance
	local var_21_2 = {}
	local var_21_3 = arg_21_1.blockIds
	local var_21_4 = arg_21_1.buildingInfos
	local var_21_5 = {}
	local var_21_6 = arg_21_1.roadInfos

	for iter_21_0 = 1, #var_21_3 do
		local var_21_7 = var_21_1:backBlockById(var_21_3[iter_21_0])

		if var_21_7 then
			table.insert(var_21_2, var_21_7)
		end
	end

	if #var_21_4 > 0 then
		for iter_21_1 = 1, #var_21_4 do
			table.insert(var_21_5, var_21_4[iter_21_1].defineId)
		end
	end

	RoomInventoryBlockModel.instance:blackBlocksByIds(var_21_3)

	local var_21_8 = var_21_1:getTempBlockMO()

	if var_21_8 then
		table.insert(var_21_2, var_21_8)
		var_21_1:removeTempBlockMO()
	end

	RoomResourceModel.instance:unUseBlockList(var_21_2)
	RoomSceneTaskController.instance:dispatchEvent(RoomEvent.TaskUpdate)
	var_0_0.instance:dispatchEvent(RoomEvent.SelectBlock)
	var_21_0.fsm:triggerEvent(RoomSceneEvent.ConfirmBackBlock, {
		blockMOList = var_21_2
	})
	arg_21_0:_unUseBuildings(var_21_4)

	local var_21_9 = RoomShowBlockListModel.instance:getCount()

	arg_21_0:setRoomShowBlockList()
	RoomModel.instance:setEditFlag()

	if var_21_9 <= 0 and RoomShowBlockListModel.instance:getCount() > 0 then
		var_0_0.instance:dispatchEvent(RoomEvent.SelectBlock)
	end

	local var_21_10

	for iter_21_2, iter_21_3 in ipairs(var_21_3) do
		local var_21_11 = RoomShowBlockListModel.instance:getById(iter_21_3)
		local var_21_12 = var_21_11 and RoomShowBlockListModel.instance:getIndex(var_21_11)

		if var_21_12 and (not var_21_10 or var_21_12 < var_21_10) then
			var_21_10 = var_21_12
		end
	end

	arg_21_0:_deleteRoadInfos(var_21_6)

	local var_21_13 = var_21_9 < RoomShowBlockListModel.instance:getCount()

	var_0_0.instance:dispatchEvent(RoomEvent.BackBlockListDataChanged, var_21_3, var_21_13, var_21_5, var_21_10)
end

function var_0_0._deleteRoadInfos(arg_22_0, arg_22_1)
	if arg_22_1 and #arg_22_1 then
		local var_22_0 = {}

		for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
			table.insert(var_22_0, iter_22_1.id)
		end

		RoomTransportController.instance:deleteRoadByIds(var_22_0)
	end
end

function var_0_0.useBlockReply(arg_23_0, arg_23_1)
	arg_23_0._isNeedConfirmRoom = true

	local var_23_0 = GameSceneMgr.instance:getCurScene()
	local var_23_1 = RoomMapBlockModel.instance:getTempBlockMO()

	if var_23_1 and var_23_1.id == arg_23_1.blockId then
		RoomMapBlockModel.instance:placeTempBlockMO(arg_23_1)
		RoomResourceModel.instance:useBlock(var_23_1)
	end

	RoomInventoryBlockModel.instance:placeBlock(arg_23_1.blockId)
	arg_23_0:setRoomShowBlockList()
	RoomResourceModel.instance:clearResourceAreaList()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomSceneTaskController.instance:dispatchEvent(RoomEvent.TaskUpdate)
	RoomModel.instance:setEditFlag()
	var_0_0.instance:dispatchEvent(RoomEvent.SelectBlock)
	var_23_0.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceBlock, {
		tempBlockMO = var_23_1
	})
end

function var_0_0.useBuildingRequest(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	RoomRpc.instance:sendUseBuildingRequest(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
end

function var_0_0.useBuildingReply(arg_25_0, arg_25_1)
	arg_25_0._isNeedConfirmRoom = true

	local var_25_0 = GameSceneMgr.instance:getCurScene()
	local var_25_1 = arg_25_1.buildingInfo
	local var_25_2 = RoomMapBuildingModel.instance:getTempBuildingMO()

	RoomMapBuildingModel.instance:placeTempBuildingMO(var_25_1)
	RoomInventoryBuildingModel.instance:placeBuilding(var_25_1)
	RoomShowBuildingListModel.instance:setShowBuildingList()
	RoomResourceModel.instance:clearResourceAreaList()
	RoomModel.instance:setEditFlag()

	if RoomBuildingAreaHelper.isBuildingArea(var_25_1.defineId) then
		RoomMapBuildingAreaModel.instance:refreshBuildingAreaMOList()
	end

	var_25_0.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceBuilding, {
		buildingInfo = var_25_1,
		tempBuildingMO = var_25_2
	})
	arg_25_0:_unUseBuildings(arg_25_1.deleteBuildingInfos)
	arg_25_0:_deleteRoadInfos(arg_25_1.deleteRoadInfos)
end

function var_0_0.unUseBuildingRequest(arg_26_0, arg_26_1)
	RoomRpc.instance:sendUnUseBuildingRequest(arg_26_1)
end

function var_0_0.unUseBuildingReply(arg_27_0, arg_27_1)
	RoomModel.instance:setEditFlag()

	arg_27_0._isNeedConfirmRoom = true

	arg_27_0:_unUseBuildings(arg_27_1.buildingInfos)
	arg_27_0:_deleteRoadInfos(arg_27_1.roadInfos)
end

function var_0_0._unUseBuildings(arg_28_0, arg_28_1)
	local var_28_0 = GameSceneMgr.instance:getCurScene()
	local var_28_1 = false

	for iter_28_0 = 1, #arg_28_1 do
		RoomInventoryBuildingModel.instance:unUseBuilding(arg_28_1[iter_28_0])

		if not var_28_1 and RoomBuildingAreaHelper.isBuildingArea(arg_28_1[iter_28_0].defineId) then
			var_28_1 = true
		end
	end

	RoomResourceModel.instance:clearResourceAreaList()
	var_28_0.fsm:triggerEvent(RoomSceneEvent.UnUseBuilding, {
		buildingInfos = arg_28_1
	})
	RoomShowBuildingListModel.instance:setShowBuildingList()

	if RoomMapBlockModel.instance:isBackMore() then
		RoomBlockController.instance:refreshBackBuildingEffect()
	end

	if var_28_1 then
		RoomMapBuildingAreaModel.instance:refreshBuildingAreaMOList()
	end
end

function var_0_0.buildingLevelUpByInfos(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = false
	local var_29_1 = {}

	if arg_29_1 and (RoomController.instance:isObMode() or RoomController.instance:isEditMode()) then
		local var_29_2 = RoomMapBuildingModel.instance

		for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
			local var_29_3 = iter_29_1.uid
			local var_29_4 = var_29_2:getBuildingMOById(var_29_3)

			if iter_29_1.level and var_29_4 and var_29_4.config and var_29_4.config.canLevelUp then
				var_29_4.level = iter_29_1.level

				var_29_4:refreshCfg()

				var_29_1[var_29_3] = true
				var_29_0 = true
			end
		end
	end

	if var_29_0 or arg_29_2 then
		arg_29_0:dispatchEvent(RoomEvent.BuildingLevelUpPush, var_29_1)
	end
end

function var_0_0.useCharacterRequest(arg_30_0, arg_30_1)
	local var_30_0 = {}
	local var_30_1 = RoomCharacterModel.instance:getList()

	for iter_30_0, iter_30_1 in ipairs(var_30_1) do
		if iter_30_1:isPlaceSourceState() then
			table.insert(var_30_0, iter_30_1.heroId)
		end
	end

	if not tabletool.indexOf(var_30_0, arg_30_1) then
		table.insert(var_30_0, arg_30_1)
	end

	RoomRpc.instance:sendUpdateRoomHeroDataRequest(var_30_0, arg_30_0.useCharacterReply, arg_30_0)
end

function var_0_0.useCharacterReply(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_2 ~= 0 then
		return
	end

	local var_31_0 = GameSceneMgr.instance:getCurScene()
	local var_31_1 = RoomCharacterModel.instance:getTempCharacterMO()

	if var_31_1 and not var_31_1:isPlaceSourceState() and RoomModel.instance:getCharacterById(var_31_1.id) then
		var_31_1.sourceState = RoomCharacterEnum.SourceState.Place
	end

	RoomCharacterModel.instance:placeTempCharacterMO()
	RoomCharacterController.instance:correctCharacterHeight(var_31_1)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	RoomCharacterController.instance:updateCharacterFaith(arg_31_3.roomHeroDatas)
	var_31_0.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceCharacter, {
		tempCharacterMO = var_31_1
	})
	RoomInteractBuildingModel.instance:checkAllHero()
end

function var_0_0.unUseCharacterRequest(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	arg_32_0._unUseCharacterCallback = arg_32_2
	arg_32_0._unUseCharacterCallbackObj = arg_32_3
	arg_32_0._unUseAnim = arg_32_4

	local var_32_0 = {}
	local var_32_1 = RoomCharacterModel.instance:getList()

	for iter_32_0, iter_32_1 in ipairs(var_32_1) do
		if iter_32_1:isPlaceSourceState() and iter_32_1.heroId ~= arg_32_1 then
			table.insert(var_32_0, iter_32_1.heroId)
		end
	end

	if RoomCharacterController.instance:isCharacterFaithFull(arg_32_1) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(arg_32_1)
	end

	RoomRpc.instance:sendUpdateRoomHeroDataRequest(var_32_0, arg_32_0.unUseCharacterReply, arg_32_0)
end

function var_0_0.unUseCharacterReply(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_2 ~= 0 then
		return
	end

	local var_33_0 = GameSceneMgr.instance:getCurScene()
	local var_33_1 = RoomCharacterModel.instance:getTempCharacterMO()

	var_33_0.fsm:triggerEvent(RoomSceneEvent.UnUseCharacter, {
		heroId = var_33_1.heroId,
		tempCharacterMO = var_33_1,
		anim = arg_33_0._unUseAnim
	})

	if var_33_1:isTrainSourceState() or var_33_1:isTraining() then
		RoomCharacterModel.instance:setHideFaithFull(var_33_1.heroId, false)
	else
		RoomCharacterModel.instance:deleteCharacterMO(var_33_1.heroId)
	end

	RoomCharacterController.instance:updateCharacterFaith(arg_33_3.roomHeroDatas)
	RoomInteractBuildingModel.instance:checkAllHero()

	if arg_33_0._unUseCharacterCallback then
		arg_33_0._unUseCharacterCallback(arg_33_0._unUseCharacterCallbackObj)
	end

	arg_33_0._unUseCharacterCallback = nil
	arg_33_0._unUseCharacterCallbackObj = nil
end

function var_0_0.confirmRoom(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = RoomController.instance:isReset()

	if var_34_0 then
		RoomRpc.instance:sendUpdateRoomHeroDataRequest({})
	end

	local var_34_1 = RoomCharacterHelper.getNeedRemoveCount()

	if not var_34_0 and var_34_1 > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomRemoveCharacter, MsgBoxEnum.BoxType.Yes_No, function()
			ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
				needRemoveCount = var_34_1,
				sureCallback = arg_34_0._confirmYesCallback,
				callbackObj = arg_34_0,
				callbackParam = {
					callback = arg_34_1,
					callbackObj = arg_34_2,
					param = arg_34_3
				}
			})
		end, nil, nil, nil, nil, nil, var_34_1)
	else
		arg_34_0:_confirmYesCallback({
			callback = arg_34_1,
			callbackObj = arg_34_2,
			param = arg_34_3
		})
	end
end

function var_0_0._confirmYesCallback(arg_36_0, arg_36_1)
	RoomRpc.instance:sendRoomConfirmRequest(arg_36_0._confirmRoomReply, arg_36_0)

	if arg_36_1.callback then
		if arg_36_1.callbackObj then
			arg_36_1.callback(arg_36_1.callbackObj, arg_36_1.param)
		else
			arg_36_1.callback(arg_36_1.param)
		end
	end
end

function var_0_0._confirmRoomReply(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_2 == 0 then
		RoomModel.instance:setObInfo(arg_37_3)

		arg_37_0._isNeedConfirmRoom = false
		arg_37_0._isHasConfirmOp = true

		GameFacade.showToast(RoomEnum.Toast.RoomConfirmRoomSuccess)
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
		RoomLayoutController.instance:updateObInfo()
	end
end

function var_0_0.revertRoom(arg_38_0)
	RoomRpc.instance:sendRoomRevertRequest(arg_38_0._revertRoomReply, arg_38_0)
end

function var_0_0._revertRoomReply(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_2 == 0 then
		arg_39_0._isNeedConfirmRoom = false
	end
end

function var_0_0.isResetEdit(arg_40_0)
	return arg_40_0._isResetEdit
end

function var_0_0.isNeedConfirmRoom(arg_41_0)
	return arg_41_0._isNeedConfirmRoom
end

function var_0_0.isHasConfirmOp(arg_42_0)
	return arg_42_0._isHasConfirmOp
end

function var_0_0.openFormulaItemBuildingViewOutSide(arg_43_0)
	RoomFormulaModel.instance:initFormula()
	ViewMgr.instance:openView(ViewName.RoomInitBuildingView, {
		openInOutside = true,
		partId = 3,
		showFormulaView = true
	})
end

function var_0_0.openRoomInitBuildingView(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = GameSceneMgr.instance:getCurScene()

	arg_44_0._openRoomInitBuildingViewCameraState = var_44_0.camera:getCameraState()
	arg_44_0._openRoomInitBuildingViewZoom = var_44_0.camera:getCameraZoom()

	RoomBuildingController.instance:tweenCameraFocusPart(arg_44_2 and arg_44_2.partId, RoomEnum.CameraState.Normal, 0)

	arg_44_0._openRoomInitBuildingViewParam = nil

	var_0_0.instance:dispatchEvent(RoomEvent.WillOpenRoomInitBuildingView)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.RefreshNavigateButton)

	if not arg_44_1 or arg_44_1 <= 0 then
		arg_44_0:_realOpenRoomInitBuildingView(arg_44_2)
		arg_44_0:dispatchEvent(RoomEvent.RefreshUIShow)

		return
	else
		arg_44_0._openRoomInitBuildingViewParam = arg_44_2

		TaskDispatcher.cancelTask(arg_44_0._realOpenRoomInitBuildingView, arg_44_0)
		TaskDispatcher.runDelay(arg_44_0._realOpenRoomInitBuildingView, arg_44_0, arg_44_1)
		arg_44_0:dispatchEvent(RoomEvent.RefreshUIShow)
	end
end

function var_0_0._realOpenRoomInitBuildingView(arg_45_0, arg_45_1)
	arg_45_1 = arg_45_1 or arg_45_0._openRoomInitBuildingViewParam
	arg_45_0._openRoomInitBuildingViewParam = nil

	ViewMgr.instance:openView(ViewName.RoomInitBuildingView, arg_45_1)
	RoomSkinController.instance:clearInitBuildingEntranceReddot(arg_45_1 and arg_45_1.partId)
end

function var_0_0.onCloseRoomInitBuildingView(arg_46_0)
	if arg_46_0._openRoomInitBuildingViewCameraState and arg_46_0._openRoomInitBuildingViewZoom then
		GameSceneMgr.instance:getCurScene().camera:switchCameraState(arg_46_0._openRoomInitBuildingViewCameraState, {
			zoom = arg_46_0._openRoomInitBuildingViewZoom
		})

		arg_46_0._openRoomInitBuildingViewCameraState = nil
		arg_46_0._openRoomInitBuildingViewZoom = nil

		arg_46_0:dispatchEvent(RoomEvent.RefreshUIShow)
		RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
		RoomBuildingController.instance:dispatchEvent(RoomEvent.RefreshNavigateButton)
	end
end

function var_0_0.isInRoomInitBuildingViewCamera(arg_47_0)
	return arg_47_0._openRoomInitBuildingViewCameraState and arg_47_0._openRoomInitBuildingViewZoom
end

function var_0_0.openRoomLevelUpView(arg_48_0)
	ViewMgr.instance:openView(ViewName.RoomLevelUpView)
end

function var_0_0.switchBackBlock(arg_49_0, arg_49_1)
	local var_49_0 = RoomMapBlockModel.instance:isBackMore()

	RoomMapBlockModel.instance:setBackMore(arg_49_1)

	local var_49_1 = GameSceneMgr.instance:getCurScene()

	if not arg_49_1 then
		var_49_1.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	else
		if RoomMapBlockModel.instance:getBackBlockModel():getCount() > 0 and RoomMapBlockModel.instance:isCanBackBlock() == false then
			var_49_1.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		end

		var_49_1.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	var_0_0.instance:dispatchEvent(RoomEvent.BackBlockShowChanged)
	var_0_0.instance:dispatchEvent(RoomEvent.SelectBlock)
	RoomBackBlockHelper.resfreshInitBlockEntityEffect()

	if var_49_0 == true and RoomMapBlockModel.instance:isBackMore() == false then
		TaskDispatcher.cancelTask(arg_49_0._playBackBlockUIAnim, arg_49_0)
		TaskDispatcher.runDelay(arg_49_0._playBackBlockUIAnim, arg_49_0, 0.3333333333333333)
	end

	if var_49_0 ~= RoomMapBlockModel.instance:isBackMore() then
		RoomBlockController.instance:refreshBackBuildingEffect()
	end
end

function var_0_0._playBackBlockUIAnim(arg_50_0)
	if RoomMapBlockModel.instance:isBackMore() == false then
		arg_50_0:dispatchEvent(RoomEvent.BackBlockPlayUIAnim)
	end
end

function var_0_0.switchWaterReform(arg_51_0, arg_51_1)
	local var_51_0 = GameSceneMgr.instance:getCurScene()

	var_51_0.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	var_51_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)

	if arg_51_1 then
		var_51_0.fsm:triggerEvent(RoomSceneEvent.EnterWaterReform)
	else
		var_51_0.fsm:triggerEvent(RoomSceneEvent.CloseWaterReform)
	end

	RoomWaterReformController.instance:dispatchEvent(RoomEvent.WaterReformShowChanged)
end

function var_0_0.statRoomStart(arg_52_0)
	arg_52_0._statTime = ServerTime.now()
end

function var_0_0.statRoomEnd(arg_53_0)
	if not arg_53_0._statTime then
		return
	end

	local var_53_0
	local var_53_1 = ServerTime.now() - arg_53_0._statTime

	if RoomController.instance:isObMode() then
		local var_53_2 = RoomMapBlockModel.instance:getConfirmBlockCount()
		local var_53_3 = {}
		local var_53_4 = RoomCharacterModel.instance:getList()

		for iter_53_0, iter_53_1 in ipairs(var_53_4) do
			table.insert(var_53_3, {
				heroname = iter_53_1.heroConfig.name
			})
		end

		local var_53_5 = {}
		local var_53_6 = RoomMapBuildingModel.instance:getBuildingMOList()

		for iter_53_2, iter_53_3 in ipairs(var_53_6) do
			local var_53_7 = var_53_5[iter_53_3.config.id]

			if not var_53_7 then
				var_53_7 = {
					build_num = 1,
					buildname = iter_53_3.config.name
				}
				var_53_5[iter_53_3.config.id] = var_53_7
			else
				var_53_7.build_num = var_53_7.build_num + 1
			end
		end

		local var_53_8 = {}

		for iter_53_4, iter_53_5 in pairs(var_53_5) do
			table.insert(var_53_8, iter_53_5)
		end

		local var_53_9 = RoomMapModel.instance:getAllBuildDegree()
		local var_53_10 = RoomMapModel.instance:getRoomLevel()

		var_53_0 = {
			[StatEnum.EventProperties.PlacePlotnum] = var_53_2,
			[StatEnum.EventProperties.PlaceHero] = var_53_3,
			[StatEnum.EventProperties.PlaceBuild] = var_53_8,
			[StatEnum.EventProperties.UseTime] = var_53_1,
			[StatEnum.EventProperties.VitalityValue] = var_53_9,
			[StatEnum.EventProperties.PivotLevel] = var_53_10,
			[StatEnum.EventProperties.OwnPlans] = RoomLayoutModel.instance:getLayoutCount(),
			[StatEnum.EventProperties.PlanName] = RoomLayoutModel.instance:getCurrentUsePlanName(),
			[StatEnum.EventProperties.PlotBag] = RoomLayoutModel.instance:getCurrentPlotBagData()
		}
	elseif RoomController.instance:isEditMode() then
		local var_53_11 = RoomModel.instance:getObInfo()
		local var_53_12 = 0
		local var_53_13 = 0

		for iter_53_6, iter_53_7 in ipairs(var_53_11.infos) do
			if iter_53_7.blockId > 0 then
				var_53_13 = var_53_13 + 1
			end

			local var_53_14 = RoomConfig.instance:getPackageConfigByBlockId(iter_53_7.blockId)

			var_53_12 = var_53_12 + (var_53_14 and var_53_14.blockBuildDegree or 0)
		end

		local var_53_15 = {}

		for iter_53_8, iter_53_9 in ipairs(var_53_11.roomHeroDatas) do
			local var_53_16 = HeroConfig.instance:getHeroCO(iter_53_9.heroId)

			table.insert(var_53_15, {
				heroname = var_53_16.name
			})
		end

		local var_53_17 = {}
		local var_53_18 = {}

		for iter_53_10, iter_53_11 in ipairs(var_53_11.buildingInfos) do
			local var_53_19 = var_53_18[iter_53_11.defineId]

			if not var_53_19 then
				local var_53_20 = RoomConfig.instance:getBuildingConfig(iter_53_11.defineId)

				var_53_19 = {
					build_num = 1,
					buildname = var_53_20.name,
					buildDegree = var_53_20.buildDegree
				}
				var_53_18[iter_53_11.defineId] = var_53_19
				var_53_12 = var_53_12 + var_53_20.buildDegree
			else
				var_53_19.build_num = var_53_19.build_num + 1
				var_53_12 = var_53_12 + var_53_19.buildDegree
			end
		end

		for iter_53_12, iter_53_13 in pairs(var_53_18) do
			iter_53_13.buildDegree = nil

			table.insert(var_53_17, iter_53_13)
		end

		local var_53_21 = var_53_11.roomLevel

		var_53_0 = {
			[StatEnum.EventProperties.PlacePlotnum] = var_53_13,
			[StatEnum.EventProperties.PlaceHero] = var_53_15,
			[StatEnum.EventProperties.PlaceBuild] = var_53_17,
			[StatEnum.EventProperties.UseTime] = var_53_1,
			[StatEnum.EventProperties.VitalityValue] = var_53_12,
			[StatEnum.EventProperties.PivotLevel] = var_53_21,
			[StatEnum.EventProperties.OwnPlans] = RoomLayoutModel.instance:getLayoutCount(),
			[StatEnum.EventProperties.PlanName] = RoomLayoutModel.instance:getCurrentUsePlanName(),
			[StatEnum.EventProperties.PlotBag] = RoomLayoutModel.instance:getCurrentPlotBagData()
		}
	end

	if var_53_0 then
		arg_53_0._statTime = nil
		var_53_0[StatEnum.EventProperties.SharePlanNum] = RoomLayoutModel.instance:getSharePlanCount()
		var_53_0[StatEnum.EventProperties.Attention] = RoomLayoutModel.instance:getUseCount()

		StatController.instance:track(StatEnum.EventName.ExitCabin, var_53_0)
	end
end

function var_0_0.isUIHide(arg_54_0)
	return arg_54_0._isUIHide
end

function var_0_0.setUIHide(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_0._isUIHide ~= arg_55_1

	arg_55_0._isUIHide = arg_55_1

	if var_55_0 then
		local var_55_1 = arg_55_1 and RoomEvent.HideUI or RoomEvent.ShowUI

		arg_55_0:dispatchEvent(var_55_1, arg_55_2)
	end
end

function var_0_0.setRoomShowBlockList(arg_56_0)
	RoomShowBlockListModel.instance:setShowBlockList()
	arg_56_0:getNextBlockReformPermanentInfo()
end

function var_0_0.clearRoomShowBlockList(arg_57_0)
	local var_57_0 = GameSceneMgr.instance:getCurScene()

	if not var_57_0 or not var_57_0.inventorymgr then
		return
	end

	local var_57_1 = RoomShowBlockListModel.instance:getList()

	for iter_57_0, iter_57_1 in ipairs(var_57_1) do
		var_57_0.inventorymgr:removeBlockEntity(iter_57_1.id)
	end
end

function var_0_0.getNextBlockReformPermanentInfo(arg_58_0, arg_58_1)
	local var_58_0 = RoomShowBlockListModel.instance:getPreviewBlockIdList(arg_58_1)

	if var_58_0 and #var_58_0 > 0 then
		RoomWaterReformController.instance:getBlockReformPermanentInfo(var_58_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

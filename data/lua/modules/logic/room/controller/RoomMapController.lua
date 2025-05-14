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
			[RoomEnum.GameMode.DebugPackage] = arg_9_0._initMapDebug
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

function var_0_0.clearMap(arg_14_0)
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
	arg_14_0:clear()
	RoomDebugController.instance:clear()
	RoomBuildingController.instance:clear()
	RoomBuildingFormulaController.instance:clear()
	RoomCharacterController.instance:clear()
	RoomVehicleController.instance:clear()
	RoomInteractionController.instance:clear()
	RoomCritterController.instance:clear()
	RoomInteractBuildingModel.instance:clear()
end

function var_0_0.resetRoom(arg_15_0)
	if RoomController.instance:isDebugNormalMode() then
		PlayerPrefsHelper.setString(PlayerPrefsKey.RoomDebugMapParam, "")
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugNormal)
	elseif RoomController.instance:isDebugInitMode() then
		local var_15_0 = RoomModel.instance:getDebugParam()

		RoomDebugController.instance:resetInitJson()
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugInit, nil, nil, var_15_0)
	elseif RoomController.instance:isDebugPackageMode() then
		local var_15_1 = RoomModel.instance:getDebugParam()

		RoomDebugController.instance:resetPackageJson(var_15_1.packageMapId)
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugPackage, nil, nil, var_15_1)
	elseif RoomController.instance:isEditMode() then
		RoomRpc.instance:sendResetRoomRequest(arg_15_0._resetRoomReply, arg_15_0)
	end
end

function var_0_0._resetRoomReply(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 ~= 0 then
		return
	end

	arg_16_0._isNeedConfirmRoom = true
	arg_16_0._isResetRoomReply = true

	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit, arg_16_3, RoomModel.instance:getObInfo(), nil, nil, nil, true)
end

function var_0_0.useBlockRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = RoomConfig.instance:getBlock(arg_17_1)

	if var_17_0 then
		RoomRpc.instance:sendUseBlockRequest(arg_17_1, var_17_0.packageId, arg_17_2, arg_17_3, arg_17_4)
	end
end

function var_0_0.unUseBlockListRequest(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_1 = RoomConfig.instance:getPackageConfigByBlockId(iter_18_1)

		var_18_0 = var_18_0 + (var_18_1 and var_18_1.blockBuildDegree or 0)
	end

	RoomRpc.instance:sendUnUseBlockRequest(arg_18_1)
end

function var_0_0.unUseBlockRequest(arg_19_0, arg_19_1)
	RoomRpc.instance:sendUnUseBlockRequest({
		arg_19_1
	})
end

function var_0_0.unUseBlockReply(arg_20_0, arg_20_1)
	arg_20_0._isNeedConfirmRoom = true

	local var_20_0 = GameSceneMgr.instance:getCurScene()
	local var_20_1 = RoomMapBlockModel.instance
	local var_20_2 = {}
	local var_20_3 = arg_20_1.blockIds
	local var_20_4 = arg_20_1.buildingInfos
	local var_20_5 = {}
	local var_20_6 = arg_20_1.roadInfos

	for iter_20_0 = 1, #var_20_3 do
		local var_20_7 = var_20_1:backBlockById(var_20_3[iter_20_0])

		if var_20_7 then
			table.insert(var_20_2, var_20_7)
		end
	end

	if #var_20_4 > 0 then
		for iter_20_1 = 1, #var_20_4 do
			table.insert(var_20_5, var_20_4[iter_20_1].defineId)
		end
	end

	RoomInventoryBlockModel.instance:blackBlocksByIds(var_20_3)

	local var_20_8 = var_20_1:getTempBlockMO()

	if var_20_8 then
		table.insert(var_20_2, var_20_8)
		var_20_1:removeTempBlockMO()
	end

	RoomResourceModel.instance:unUseBlockList(var_20_2)
	RoomSceneTaskController.instance:dispatchEvent(RoomEvent.TaskUpdate)
	var_0_0.instance:dispatchEvent(RoomEvent.SelectBlock)
	var_20_0.fsm:triggerEvent(RoomSceneEvent.ConfirmBackBlock, {
		blockMOList = var_20_2
	})
	arg_20_0:_unUseBuildings(var_20_4)

	local var_20_9 = RoomShowBlockListModel.instance:getCount()

	RoomShowBlockListModel.instance:setShowBlockList()
	RoomModel.instance:setEditFlag()

	if var_20_9 <= 0 and RoomShowBlockListModel.instance:getCount() > 0 then
		var_0_0.instance:dispatchEvent(RoomEvent.SelectBlock)
	end

	local var_20_10

	for iter_20_2, iter_20_3 in ipairs(var_20_3) do
		local var_20_11 = RoomShowBlockListModel.instance:getById(iter_20_3)
		local var_20_12 = var_20_11 and RoomShowBlockListModel.instance:getIndex(var_20_11)

		if var_20_12 and (not var_20_10 or var_20_12 < var_20_10) then
			var_20_10 = var_20_12
		end
	end

	arg_20_0:_deleteRoadInfos(var_20_6)

	local var_20_13 = var_20_9 < RoomShowBlockListModel.instance:getCount()

	var_0_0.instance:dispatchEvent(RoomEvent.BackBlockListDataChanged, var_20_3, var_20_13, var_20_5, var_20_10)
end

function var_0_0._deleteRoadInfos(arg_21_0, arg_21_1)
	if arg_21_1 and #arg_21_1 then
		local var_21_0 = {}

		for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
			table.insert(var_21_0, iter_21_1.id)
		end

		RoomTransportController.instance:deleteRoadByIds(var_21_0)
	end
end

function var_0_0.useBlockReply(arg_22_0, arg_22_1)
	arg_22_0._isNeedConfirmRoom = true

	local var_22_0 = GameSceneMgr.instance:getCurScene()
	local var_22_1 = RoomMapBlockModel.instance:getTempBlockMO()

	if var_22_1 and var_22_1.id == arg_22_1.blockId then
		RoomMapBlockModel.instance:placeTempBlockMO(arg_22_1)
		RoomResourceModel.instance:useBlock(var_22_1)
	end

	RoomInventoryBlockModel.instance:placeBlock(arg_22_1.blockId)
	RoomShowBlockListModel.instance:setShowBlockList()
	RoomResourceModel.instance:clearResourceAreaList()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomSceneTaskController.instance:dispatchEvent(RoomEvent.TaskUpdate)
	RoomModel.instance:setEditFlag()
	var_0_0.instance:dispatchEvent(RoomEvent.SelectBlock)
	var_22_0.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceBlock, {
		tempBlockMO = var_22_1
	})
end

function var_0_0.useBuildingRequest(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	RoomRpc.instance:sendUseBuildingRequest(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
end

function var_0_0.useBuildingReply(arg_24_0, arg_24_1)
	arg_24_0._isNeedConfirmRoom = true

	local var_24_0 = GameSceneMgr.instance:getCurScene()
	local var_24_1 = arg_24_1.buildingInfo
	local var_24_2 = RoomMapBuildingModel.instance:getTempBuildingMO()

	RoomMapBuildingModel.instance:placeTempBuildingMO(var_24_1)
	RoomInventoryBuildingModel.instance:placeBuilding(var_24_1)
	RoomShowBuildingListModel.instance:setShowBuildingList()
	RoomResourceModel.instance:clearResourceAreaList()
	RoomModel.instance:setEditFlag()

	if RoomBuildingAreaHelper.isBuildingArea(var_24_1.defineId) then
		RoomMapBuildingAreaModel.instance:refreshBuildingAreaMOList()
	end

	var_24_0.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceBuilding, {
		buildingInfo = var_24_1,
		tempBuildingMO = var_24_2
	})
	arg_24_0:_unUseBuildings(arg_24_1.deleteBuildingInfos)
	arg_24_0:_deleteRoadInfos(arg_24_1.deleteRoadInfos)
end

function var_0_0.unUseBuildingRequest(arg_25_0, arg_25_1)
	RoomRpc.instance:sendUnUseBuildingRequest(arg_25_1)
end

function var_0_0.unUseBuildingReply(arg_26_0, arg_26_1)
	RoomModel.instance:setEditFlag()

	arg_26_0._isNeedConfirmRoom = true

	arg_26_0:_unUseBuildings(arg_26_1.buildingInfos)
	arg_26_0:_deleteRoadInfos(arg_26_1.roadInfos)
end

function var_0_0._unUseBuildings(arg_27_0, arg_27_1)
	local var_27_0 = GameSceneMgr.instance:getCurScene()
	local var_27_1 = false

	for iter_27_0 = 1, #arg_27_1 do
		RoomInventoryBuildingModel.instance:unUseBuilding(arg_27_1[iter_27_0])

		if not var_27_1 and RoomBuildingAreaHelper.isBuildingArea(arg_27_1[iter_27_0].defineId) then
			var_27_1 = true
		end
	end

	RoomResourceModel.instance:clearResourceAreaList()
	var_27_0.fsm:triggerEvent(RoomSceneEvent.UnUseBuilding, {
		buildingInfos = arg_27_1
	})
	RoomShowBuildingListModel.instance:setShowBuildingList()

	if RoomMapBlockModel.instance:isBackMore() then
		RoomBlockController.instance:refreshBackBuildingEffect()
	end

	if var_27_1 then
		RoomMapBuildingAreaModel.instance:refreshBuildingAreaMOList()
	end
end

function var_0_0.buildingLevelUpByInfos(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = false
	local var_28_1 = {}

	if arg_28_1 and (RoomController.instance:isObMode() or RoomController.instance:isEditMode()) then
		local var_28_2 = RoomMapBuildingModel.instance

		for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
			local var_28_3 = iter_28_1.uid
			local var_28_4 = var_28_2:getBuildingMOById(var_28_3)

			if iter_28_1.level and var_28_4 and var_28_4.config and var_28_4.config.canLevelUp then
				var_28_4.level = iter_28_1.level

				var_28_4:refreshCfg()

				var_28_1[var_28_3] = true
				var_28_0 = true
			end
		end
	end

	if var_28_0 or arg_28_2 then
		arg_28_0:dispatchEvent(RoomEvent.BuildingLevelUpPush, var_28_1)
	end
end

function var_0_0.useCharacterRequest(arg_29_0, arg_29_1)
	local var_29_0 = {}
	local var_29_1 = RoomCharacterModel.instance:getList()

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		if iter_29_1:isPlaceSourceState() then
			table.insert(var_29_0, iter_29_1.heroId)
		end
	end

	if not tabletool.indexOf(var_29_0, arg_29_1) then
		table.insert(var_29_0, arg_29_1)
	end

	RoomRpc.instance:sendUpdateRoomHeroDataRequest(var_29_0, arg_29_0.useCharacterReply, arg_29_0)
end

function var_0_0.useCharacterReply(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_2 ~= 0 then
		return
	end

	local var_30_0 = GameSceneMgr.instance:getCurScene()
	local var_30_1 = RoomCharacterModel.instance:getTempCharacterMO()

	if var_30_1 and not var_30_1:isPlaceSourceState() and RoomModel.instance:getCharacterById(var_30_1.id) then
		var_30_1.sourceState = RoomCharacterEnum.SourceState.Place
	end

	RoomCharacterModel.instance:placeTempCharacterMO()
	RoomCharacterController.instance:correctCharacterHeight(var_30_1)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	RoomCharacterController.instance:updateCharacterFaith(arg_30_3.roomHeroDatas)
	var_30_0.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceCharacter, {
		tempCharacterMO = var_30_1
	})
	RoomInteractBuildingModel.instance:checkAllHero()
end

function var_0_0.unUseCharacterRequest(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	arg_31_0._unUseCharacterCallback = arg_31_2
	arg_31_0._unUseCharacterCallbackObj = arg_31_3
	arg_31_0._unUseAnim = arg_31_4

	local var_31_0 = {}
	local var_31_1 = RoomCharacterModel.instance:getList()

	for iter_31_0, iter_31_1 in ipairs(var_31_1) do
		if iter_31_1:isPlaceSourceState() and iter_31_1.heroId ~= arg_31_1 then
			table.insert(var_31_0, iter_31_1.heroId)
		end
	end

	if RoomCharacterController.instance:isCharacterFaithFull(arg_31_1) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(arg_31_1)
	end

	RoomRpc.instance:sendUpdateRoomHeroDataRequest(var_31_0, arg_31_0.unUseCharacterReply, arg_31_0)
end

function var_0_0.unUseCharacterReply(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_2 ~= 0 then
		return
	end

	local var_32_0 = GameSceneMgr.instance:getCurScene()
	local var_32_1 = RoomCharacterModel.instance:getTempCharacterMO()

	var_32_0.fsm:triggerEvent(RoomSceneEvent.UnUseCharacter, {
		heroId = var_32_1.heroId,
		tempCharacterMO = var_32_1,
		anim = arg_32_0._unUseAnim
	})

	if var_32_1:isTrainSourceState() or var_32_1:isTraining() then
		RoomCharacterModel.instance:setHideFaithFull(var_32_1.heroId, false)
	else
		RoomCharacterModel.instance:deleteCharacterMO(var_32_1.heroId)
	end

	RoomCharacterController.instance:updateCharacterFaith(arg_32_3.roomHeroDatas)
	RoomInteractBuildingModel.instance:checkAllHero()

	if arg_32_0._unUseCharacterCallback then
		arg_32_0._unUseCharacterCallback(arg_32_0._unUseCharacterCallbackObj)
	end

	arg_32_0._unUseCharacterCallback = nil
	arg_32_0._unUseCharacterCallbackObj = nil
end

function var_0_0.confirmRoom(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = RoomController.instance:isReset()

	if var_33_0 then
		RoomRpc.instance:sendUpdateRoomHeroDataRequest({})
	end

	local var_33_1 = RoomCharacterHelper.getNeedRemoveCount()

	if not var_33_0 and var_33_1 > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomRemoveCharacter, MsgBoxEnum.BoxType.Yes_No, function()
			ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
				needRemoveCount = var_33_1,
				sureCallback = arg_33_0._confirmYesCallback,
				callbackObj = arg_33_0,
				callbackParam = {
					callback = arg_33_1,
					callbackObj = arg_33_2,
					param = arg_33_3
				}
			})
		end, nil, nil, nil, nil, nil, var_33_1)
	else
		arg_33_0:_confirmYesCallback({
			callback = arg_33_1,
			callbackObj = arg_33_2,
			param = arg_33_3
		})
	end
end

function var_0_0._confirmYesCallback(arg_35_0, arg_35_1)
	RoomRpc.instance:sendRoomConfirmRequest(arg_35_0._confirmRoomReply, arg_35_0)

	if arg_35_1.callback then
		if arg_35_1.callbackObj then
			arg_35_1.callback(arg_35_1.callbackObj, arg_35_1.param)
		else
			arg_35_1.callback(arg_35_1.param)
		end
	end
end

function var_0_0._confirmRoomReply(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_2 == 0 then
		RoomModel.instance:setObInfo(arg_36_3)

		arg_36_0._isNeedConfirmRoom = false
		arg_36_0._isHasConfirmOp = true

		GameFacade.showToast(RoomEnum.Toast.RoomConfirmRoomSuccess)
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
		RoomLayoutController.instance:updateObInfo()
	end
end

function var_0_0.revertRoom(arg_37_0)
	RoomRpc.instance:sendRoomRevertRequest(arg_37_0._revertRoomReply, arg_37_0)
end

function var_0_0._revertRoomReply(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if arg_38_2 == 0 then
		arg_38_0._isNeedConfirmRoom = false
	end
end

function var_0_0.isResetEdit(arg_39_0)
	return arg_39_0._isResetEdit
end

function var_0_0.isNeedConfirmRoom(arg_40_0)
	return arg_40_0._isNeedConfirmRoom
end

function var_0_0.isHasConfirmOp(arg_41_0)
	return arg_41_0._isHasConfirmOp
end

function var_0_0.openFormulaItemBuildingViewOutSide(arg_42_0)
	RoomFormulaModel.instance:initFormula()
	ViewMgr.instance:openView(ViewName.RoomInitBuildingView, {
		openInOutside = true,
		partId = 3,
		showFormulaView = true
	})
end

function var_0_0.openRoomInitBuildingView(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = GameSceneMgr.instance:getCurScene()

	arg_43_0._openRoomInitBuildingViewCameraState = var_43_0.camera:getCameraState()
	arg_43_0._openRoomInitBuildingViewZoom = var_43_0.camera:getCameraZoom()

	RoomBuildingController.instance:tweenCameraFocusPart(arg_43_2 and arg_43_2.partId, RoomEnum.CameraState.Normal, 0)

	arg_43_0._openRoomInitBuildingViewParam = nil

	var_0_0.instance:dispatchEvent(RoomEvent.WillOpenRoomInitBuildingView)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.RefreshNavigateButton)

	if not arg_43_1 or arg_43_1 <= 0 then
		arg_43_0:_realOpenRoomInitBuildingView(arg_43_2)
		arg_43_0:dispatchEvent(RoomEvent.RefreshUIShow)

		return
	else
		arg_43_0._openRoomInitBuildingViewParam = arg_43_2

		TaskDispatcher.cancelTask(arg_43_0._realOpenRoomInitBuildingView, arg_43_0)
		TaskDispatcher.runDelay(arg_43_0._realOpenRoomInitBuildingView, arg_43_0, arg_43_1)
		arg_43_0:dispatchEvent(RoomEvent.RefreshUIShow)
	end
end

function var_0_0._realOpenRoomInitBuildingView(arg_44_0, arg_44_1)
	arg_44_1 = arg_44_1 or arg_44_0._openRoomInitBuildingViewParam
	arg_44_0._openRoomInitBuildingViewParam = nil

	ViewMgr.instance:openView(ViewName.RoomInitBuildingView, arg_44_1)
	RoomSkinController.instance:clearInitBuildingEntranceReddot(arg_44_1 and arg_44_1.partId)
end

function var_0_0.onCloseRoomInitBuildingView(arg_45_0)
	if arg_45_0._openRoomInitBuildingViewCameraState and arg_45_0._openRoomInitBuildingViewZoom then
		GameSceneMgr.instance:getCurScene().camera:switchCameraState(arg_45_0._openRoomInitBuildingViewCameraState, {
			zoom = arg_45_0._openRoomInitBuildingViewZoom
		})

		arg_45_0._openRoomInitBuildingViewCameraState = nil
		arg_45_0._openRoomInitBuildingViewZoom = nil

		arg_45_0:dispatchEvent(RoomEvent.RefreshUIShow)
		RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
		RoomBuildingController.instance:dispatchEvent(RoomEvent.RefreshNavigateButton)
	end
end

function var_0_0.isInRoomInitBuildingViewCamera(arg_46_0)
	return arg_46_0._openRoomInitBuildingViewCameraState and arg_46_0._openRoomInitBuildingViewZoom
end

function var_0_0.openRoomLevelUpView(arg_47_0)
	ViewMgr.instance:openView(ViewName.RoomLevelUpView)
end

function var_0_0.switchBackBlock(arg_48_0, arg_48_1)
	local var_48_0 = RoomMapBlockModel.instance:isBackMore()

	RoomMapBlockModel.instance:setBackMore(arg_48_1)

	local var_48_1 = GameSceneMgr.instance:getCurScene()

	if not arg_48_1 then
		var_48_1.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	else
		if RoomMapBlockModel.instance:getBackBlockModel():getCount() > 0 and RoomMapBlockModel.instance:isCanBackBlock() == false then
			var_48_1.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		end

		var_48_1.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	var_0_0.instance:dispatchEvent(RoomEvent.BackBlockShowChanged)
	var_0_0.instance:dispatchEvent(RoomEvent.SelectBlock)
	RoomBackBlockHelper.resfreshInitBlockEntityEffect()

	if var_48_0 == true and RoomMapBlockModel.instance:isBackMore() == false then
		TaskDispatcher.cancelTask(arg_48_0._playBackBlockUIAnim, arg_48_0)
		TaskDispatcher.runDelay(arg_48_0._playBackBlockUIAnim, arg_48_0, 0.3333333333333333)
	end

	if var_48_0 ~= RoomMapBlockModel.instance:isBackMore() then
		RoomBlockController.instance:refreshBackBuildingEffect()
	end
end

function var_0_0._playBackBlockUIAnim(arg_49_0)
	if RoomMapBlockModel.instance:isBackMore() == false then
		arg_49_0:dispatchEvent(RoomEvent.BackBlockPlayUIAnim)
	end
end

function var_0_0.switchWaterReform(arg_50_0, arg_50_1)
	local var_50_0 = GameSceneMgr.instance:getCurScene()

	var_50_0.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	var_50_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)

	if arg_50_1 then
		var_50_0.fsm:triggerEvent(RoomSceneEvent.EnterWaterReform)
	else
		var_50_0.fsm:triggerEvent(RoomSceneEvent.CloseWaterReform)
	end

	RoomWaterReformController.instance:dispatchEvent(RoomEvent.WaterReformShowChanged)
end

function var_0_0.statRoomStart(arg_51_0)
	arg_51_0._statTime = ServerTime.now()
end

function var_0_0.statRoomEnd(arg_52_0)
	if not arg_52_0._statTime then
		return
	end

	local var_52_0
	local var_52_1 = ServerTime.now() - arg_52_0._statTime

	if RoomController.instance:isObMode() then
		local var_52_2 = RoomMapBlockModel.instance:getConfirmBlockCount()
		local var_52_3 = {}
		local var_52_4 = RoomCharacterModel.instance:getList()

		for iter_52_0, iter_52_1 in ipairs(var_52_4) do
			table.insert(var_52_3, {
				heroname = iter_52_1.heroConfig.name
			})
		end

		local var_52_5 = {}
		local var_52_6 = RoomMapBuildingModel.instance:getBuildingMOList()

		for iter_52_2, iter_52_3 in ipairs(var_52_6) do
			local var_52_7 = var_52_5[iter_52_3.config.id]

			if not var_52_7 then
				var_52_7 = {
					build_num = 1,
					buildname = iter_52_3.config.name
				}
				var_52_5[iter_52_3.config.id] = var_52_7
			else
				var_52_7.build_num = var_52_7.build_num + 1
			end
		end

		local var_52_8 = {}

		for iter_52_4, iter_52_5 in pairs(var_52_5) do
			table.insert(var_52_8, iter_52_5)
		end

		local var_52_9 = RoomMapModel.instance:getAllBuildDegree()
		local var_52_10 = RoomMapModel.instance:getRoomLevel()

		var_52_0 = {
			[StatEnum.EventProperties.PlacePlotnum] = var_52_2,
			[StatEnum.EventProperties.PlaceHero] = var_52_3,
			[StatEnum.EventProperties.PlaceBuild] = var_52_8,
			[StatEnum.EventProperties.UseTime] = var_52_1,
			[StatEnum.EventProperties.VitalityValue] = var_52_9,
			[StatEnum.EventProperties.PivotLevel] = var_52_10,
			[StatEnum.EventProperties.OwnPlans] = RoomLayoutModel.instance:getLayoutCount(),
			[StatEnum.EventProperties.PlanName] = RoomLayoutModel.instance:getCurrentUsePlanName(),
			[StatEnum.EventProperties.PlotBag] = RoomLayoutModel.instance:getCurrentPlotBagData()
		}
	elseif RoomController.instance:isEditMode() then
		local var_52_11 = RoomModel.instance:getObInfo()
		local var_52_12 = 0
		local var_52_13 = 0

		for iter_52_6, iter_52_7 in ipairs(var_52_11.infos) do
			if iter_52_7.blockId > 0 then
				var_52_13 = var_52_13 + 1
			end

			local var_52_14 = RoomConfig.instance:getPackageConfigByBlockId(iter_52_7.blockId)

			var_52_12 = var_52_12 + (var_52_14 and var_52_14.blockBuildDegree or 0)
		end

		local var_52_15 = {}

		for iter_52_8, iter_52_9 in ipairs(var_52_11.roomHeroDatas) do
			local var_52_16 = HeroConfig.instance:getHeroCO(iter_52_9.heroId)

			table.insert(var_52_15, {
				heroname = var_52_16.name
			})
		end

		local var_52_17 = {}
		local var_52_18 = {}

		for iter_52_10, iter_52_11 in ipairs(var_52_11.buildingInfos) do
			local var_52_19 = var_52_18[iter_52_11.defineId]

			if not var_52_19 then
				local var_52_20 = RoomConfig.instance:getBuildingConfig(iter_52_11.defineId)

				var_52_19 = {
					build_num = 1,
					buildname = var_52_20.name,
					buildDegree = var_52_20.buildDegree
				}
				var_52_18[iter_52_11.defineId] = var_52_19
				var_52_12 = var_52_12 + var_52_20.buildDegree
			else
				var_52_19.build_num = var_52_19.build_num + 1
				var_52_12 = var_52_12 + var_52_19.buildDegree
			end
		end

		for iter_52_12, iter_52_13 in pairs(var_52_18) do
			iter_52_13.buildDegree = nil

			table.insert(var_52_17, iter_52_13)
		end

		local var_52_21 = var_52_11.roomLevel

		var_52_0 = {
			[StatEnum.EventProperties.PlacePlotnum] = var_52_13,
			[StatEnum.EventProperties.PlaceHero] = var_52_15,
			[StatEnum.EventProperties.PlaceBuild] = var_52_17,
			[StatEnum.EventProperties.UseTime] = var_52_1,
			[StatEnum.EventProperties.VitalityValue] = var_52_12,
			[StatEnum.EventProperties.PivotLevel] = var_52_21,
			[StatEnum.EventProperties.OwnPlans] = RoomLayoutModel.instance:getLayoutCount(),
			[StatEnum.EventProperties.PlanName] = RoomLayoutModel.instance:getCurrentUsePlanName(),
			[StatEnum.EventProperties.PlotBag] = RoomLayoutModel.instance:getCurrentPlotBagData()
		}
	end

	if var_52_0 then
		arg_52_0._statTime = nil
		var_52_0[StatEnum.EventProperties.SharePlanNum] = RoomLayoutModel.instance:getSharePlanCount()
		var_52_0[StatEnum.EventProperties.Attention] = RoomLayoutModel.instance:getUseCount()

		StatController.instance:track(StatEnum.EventName.ExitCabin, var_52_0)
	end
end

function var_0_0.isUIHide(arg_53_0)
	return arg_53_0._isUIHide
end

function var_0_0.setUIHide(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = arg_54_0._isUIHide ~= arg_54_1

	arg_54_0._isUIHide = arg_54_1

	if var_54_0 then
		local var_54_1 = arg_54_1 and RoomEvent.HideUI or RoomEvent.ShowUI

		arg_54_0:dispatchEvent(var_54_1, arg_54_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

module("modules.logic.room.controller.RoomMapController", package.seeall)

slot0 = class("RoomMapController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0._isResetEdit = nil
	slot0._isNeedConfirmRoom = slot0._isResetRoomReply and true or false
	slot0._isHasConfirmOp = false
	slot0._isResetRoomReply = false
	slot0._isUIHide = false

	TaskDispatcher.cancelTask(slot0._realOpenRoomInitBuildingView, slot0)

	slot0._openRoomInitBuildingViewCameraState = nil
	slot0._openRoomInitBuildingViewZoom = nil
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnHour, slot0._onHourReporting, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.RoomInitBuildingView then
		TaskDispatcher.cancelTask(slot0._realOpenRoomInitBuildingView, slot0)
	end
end

function slot0._onHourReporting(slot0)
	slot0:dispatchEvent(RoomEvent.OnHourReporting, os.date("*t", ServerTime.nowInLocal()).hour)
end

function slot0.updateBlockReplaceDefineId(slot0, slot1)
	slot3 = RoomMapBuildingModel.instance

	for slot7, slot8 in ipairs(slot1 or RoomMapBlockModel.instance:getFullBlockMOList()) do
		slot8.replaceDefineId = nil
		slot8.replaceRotate = nil

		if slot8.hexPoint then
			if not slot3:getBuildingParam(slot8.hexPoint.x, slot8.hexPoint.y) and not RoomBuildingController.instance:isPressBuilding() then
				slot9 = slot3:getTempBuildingParam(slot8.hexPoint.x, slot8.hexPoint.y)
			end

			slot8.replaceDefineId = slot9 and slot9.blockDefineId
			slot8.replaceRotate = slot9 and slot9.blockRotate
		end
	end
end

function slot0.initMap(slot0)
	slot1 = RoomModel.instance:getEditInfo()
	slot0._isResetEdit = RoomController.instance:isEditMode() and slot1 and slot1.isReset

	RoomMapModel.instance:init()

	slot0._isHasConfirmOp = false
	slot2 = RoomModel.instance:getGameMode()

	if slot0:_getInitMapFuncByGameMode(slot2) then
		slot3(slot0, slot1, RoomModel.instance:getInfoByMode(slot2))
	else
		logError(string.format("can not find initMap function by gameModel:%s", slot2))
	end

	RoomMapHexPointModel.instance:init()
	RoomResourceModel.instance:init()
	slot0:dispatchEvent(RoomEvent.UpdateInventoryCount)
end

function slot0._getInitMapFuncByGameMode(slot0, slot1)
	if not slot0._initMapFuncMap then
		slot0._initMapFuncMap = {
			[RoomEnum.GameMode.Ob] = slot0._initMapOb,
			[RoomEnum.GameMode.Edit] = slot0._initMapEdit,
			[RoomEnum.GameMode.Visit] = slot0._initMapVisit,
			[RoomEnum.GameMode.VisitShare] = slot0._initMapVisit,
			[RoomEnum.GameMode.DebugNormal] = slot0._initMapDebug,
			[RoomEnum.GameMode.DebugInit] = slot0._initMapDebug,
			[RoomEnum.GameMode.DebugPackage] = slot0._initMapDebug
		}
	end

	return slot0._initMapFuncMap[slot1]
end

function slot0._initMapOb(slot0, slot1, slot2)
	RoomModel.instance:resetBuildingInfos()
	RoomModel.instance:updateBuildingInfos(slot2.buildingInfos or {})
	RoomMapModel.instance:updateRoomLevel(slot2.roomLevel)
	RoomProductionModel.instance:updateLineMaxLevel()
	RoomMapBlockModel.instance:initMap(slot2.infos)
	RoomMapBuildingModel.instance:initMap(slot2.buildingInfos)
	RoomCharacterModel.instance:initCharacter(slot2.roomHeroDatas)
	RoomCritterModel.instance:initCititer(slot2.roomCititerDatas)
	RoomFormulaModel.instance:initFormula(slot2.formulaInfos)
	RoomMapBuildingAreaModel.instance:init()
	RoomTransportController.instance:initPathData(slot2.roadInfos)
	RoomInventoryBuildingModel.instance:initInventory(RoomModel.instance:getBuildingInfoList())
	RoomShowBuildingListModel.instance:initShowBuilding()
	RoomDebugPlaceListModel.instance:initDebugPlace()
	RoomCharacterPlaceListModel.instance:initCharacterPlace()

	if not RoomModel.instance:getEnterParam() or not slot3.isFromEditMode then
		RoomShowBuildingListModel.instance:initFilter()
		RoomCharacterPlaceListModel.instance:initFilter()
		RoomCharacterPlaceListModel.instance:initOrder()
	end

	RoomTransportController.instance:updateBlockUseState()
	slot0:updateBlockReplaceDefineId()
	RoomCharacterController.instance:refreshCharacterFaithTimer()
	RoomCharacterController.instance:init()
	RoomVehicleController.instance:init()
	RoomInteractionController.instance:init()
	RoomCritterController.instance:initMapTrainCritter()
	RoomCritterController.instance:init()
	RoomInteractBuildingModel.instance:init()
end

function slot0._initMapEdit(slot0, slot1)
	RoomThemeFilterListModel.instance:init()
	RoomMapModel.instance:updateRoomLevel(RoomModel.instance:getInfoByMode(RoomEnum.GameMode.Ob).roomLevel)
	RoomProductionModel.instance:updateLineMaxLevel()
	RoomMapBlockModel.instance:initMap(slot1.infos)
	RoomInventoryBlockModel.instance:initInventory(RoomModel.instance:getBlockPackageIds(), slot1.blockPackages, slot1.infos, RoomModel.instance:getSpecialBlockIds())
	RoomMapBuildingModel.instance:initMap(slot1.buildingInfos)
	RoomModel.instance:resetBuildingInfos()
	RoomModel.instance:updateBuildingInfos(slot1.buildingInfos or {})
	RoomInventoryBuildingModel.instance:initInventory(RoomModel.instance:getBuildingInfoList())
	RoomCharacterModel.instance:initCharacter(slot2.roomHeroDatas)
	RoomCritterModel.instance:initCititer(slot2.roomCititerDatas)
	RoomMapBuildingAreaModel.instance:init()
	RoomTransportController.instance:initPathData(slot1.roadInfos)
	RoomTransportController.instance:updateBlockUseState()
	slot0:updateBlockReplaceDefineId()
	RoomInteractBuildingModel.instance:init()
end

function slot0._initMapVisit(slot0, slot1, slot2)
	if RoomLayoutHelper.checkVisitParamCoppare(RoomModel.instance:getVisitParam()) then
		slot3, slot4 = RoomLayoutHelper.findHasBlockBuildingInfos(slot2.infos or {}, slot2.buildingInfos or {})
	end

	RoomMapModel.instance:setOtherLineLevelDict(slot2.productionLines)
	RoomSkinModel.instance:setOtherPlayerRoomSkinDict(slot2.skins)
	RoomMapModel.instance:updateRoomLevel(slot2.roomLevel)
	RoomMapBlockModel.instance:initMap(slot3)
	RoomMapBuildingModel.instance:initMap(slot4)
	RoomCharacterModel.instance:initCharacter(slot2.roomHeroDatas)
	RoomCritterModel.instance:initCititer(slot2.roomCititerDatas)
	RoomMapBuildingAreaModel.instance:init()
	RoomTransportController.instance:initPathData(slot2.roadInfos)
	RoomTransportController.instance:updateBlockUseState()
	RoomVehicleController.instance:init()
	RoomInteractBuildingModel.instance:init()
end

function slot0._initMapDebug(slot0, slot1, slot2)
	slot3 = RoomModel.instance:getDebugParam()

	RoomMapBlockModel.instance:initMap(slot1.infos)
	RoomMapBuildingModel.instance:initMap(slot1.buildingInfos)

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

function slot0.clearMap(slot0)
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
	slot0:clear()
	RoomDebugController.instance:clear()
	RoomBuildingController.instance:clear()
	RoomBuildingFormulaController.instance:clear()
	RoomCharacterController.instance:clear()
	RoomVehicleController.instance:clear()
	RoomInteractionController.instance:clear()
	RoomCritterController.instance:clear()
	RoomInteractBuildingModel.instance:clear()
end

function slot0.resetRoom(slot0)
	if RoomController.instance:isDebugNormalMode() then
		PlayerPrefsHelper.setString(PlayerPrefsKey.RoomDebugMapParam, "")
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugNormal)
	elseif RoomController.instance:isDebugInitMode() then
		RoomDebugController.instance:resetInitJson()
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugInit, nil, , RoomModel.instance:getDebugParam())
	elseif RoomController.instance:isDebugPackageMode() then
		slot1 = RoomModel.instance:getDebugParam()

		RoomDebugController.instance:resetPackageJson(slot1.packageMapId)
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugPackage, nil, , slot1)
	elseif RoomController.instance:isEditMode() then
		RoomRpc.instance:sendResetRoomRequest(slot0._resetRoomReply, slot0)
	end
end

function slot0._resetRoomReply(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0._isNeedConfirmRoom = true
	slot0._isResetRoomReply = true

	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit, slot3, RoomModel.instance:getObInfo(), nil, , , true)
end

function slot0.useBlockRequest(slot0, slot1, slot2, slot3, slot4)
	if RoomConfig.instance:getBlock(slot1) then
		RoomRpc.instance:sendUseBlockRequest(slot1, slot5.packageId, slot2, slot3, slot4)
	end
end

function slot0.unUseBlockListRequest(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		slot2 = 0 + (RoomConfig.instance:getPackageConfigByBlockId(slot7) and slot8.blockBuildDegree or 0)
	end

	RoomRpc.instance:sendUnUseBlockRequest(slot1)
end

function slot0.unUseBlockRequest(slot0, slot1)
	RoomRpc.instance:sendUnUseBlockRequest({
		slot1
	})
end

function slot0.unUseBlockReply(slot0, slot1)
	slot0._isNeedConfirmRoom = true
	slot2 = GameSceneMgr.instance:getCurScene()
	slot6 = slot1.buildingInfos
	slot7 = {}
	slot8 = slot1.roadInfos

	for slot12 = 1, #slot1.blockIds do
		if RoomMapBlockModel.instance:backBlockById(slot5[slot12]) then
			table.insert({}, slot13)
		end
	end

	if #slot6 > 0 then
		for slot12 = 1, #slot6 do
			table.insert(slot7, slot6[slot12].defineId)
		end
	end

	RoomInventoryBlockModel.instance:blackBlocksByIds(slot5)

	if slot3:getTempBlockMO() then
		table.insert(slot4, slot9)
		slot3:removeTempBlockMO()
	end

	RoomResourceModel.instance:unUseBlockList(slot4)
	RoomSceneTaskController.instance:dispatchEvent(RoomEvent.TaskUpdate)
	uv0.instance:dispatchEvent(RoomEvent.SelectBlock)
	slot2.fsm:triggerEvent(RoomSceneEvent.ConfirmBackBlock, {
		blockMOList = slot4
	})
	slot0:_unUseBuildings(slot6)
	RoomShowBlockListModel.instance:setShowBlockList()
	RoomModel.instance:setEditFlag()

	if RoomShowBlockListModel.instance:getCount() <= 0 and RoomShowBlockListModel.instance:getCount() > 0 then
		uv0.instance:dispatchEvent(RoomEvent.SelectBlock)
	end

	slot11 = nil

	for slot15, slot16 in ipairs(slot5) do
		if RoomShowBlockListModel.instance:getById(slot16) and RoomShowBlockListModel.instance:getIndex(slot17) and (not slot11 or slot18 < slot11) then
			slot11 = slot18
		end
	end

	slot0:_deleteRoadInfos(slot8)
	uv0.instance:dispatchEvent(RoomEvent.BackBlockListDataChanged, slot5, slot10 < RoomShowBlockListModel.instance:getCount(), slot7, slot11)
end

function slot0._deleteRoadInfos(slot0, slot1)
	if slot1 and #slot1 then
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			table.insert(slot2, slot7.id)
		end

		RoomTransportController.instance:deleteRoadByIds(slot2)
	end
end

function slot0.useBlockReply(slot0, slot1)
	slot0._isNeedConfirmRoom = true
	slot2 = GameSceneMgr.instance:getCurScene()

	if RoomMapBlockModel.instance:getTempBlockMO() and slot3.id == slot1.blockId then
		RoomMapBlockModel.instance:placeTempBlockMO(slot1)
		RoomResourceModel.instance:useBlock(slot3)
	end

	RoomInventoryBlockModel.instance:placeBlock(slot1.blockId)
	RoomShowBlockListModel.instance:setShowBlockList()
	RoomResourceModel.instance:clearResourceAreaList()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomSceneTaskController.instance:dispatchEvent(RoomEvent.TaskUpdate)
	RoomModel.instance:setEditFlag()
	uv0.instance:dispatchEvent(RoomEvent.SelectBlock)
	slot2.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceBlock, {
		tempBlockMO = slot3
	})
end

function slot0.useBuildingRequest(slot0, slot1, slot2, slot3, slot4)
	RoomRpc.instance:sendUseBuildingRequest(slot1, slot2, slot3, slot4)
end

function slot0.useBuildingReply(slot0, slot1)
	slot0._isNeedConfirmRoom = true
	slot2 = GameSceneMgr.instance:getCurScene()
	slot3 = slot1.buildingInfo
	slot4 = RoomMapBuildingModel.instance:getTempBuildingMO()

	RoomMapBuildingModel.instance:placeTempBuildingMO(slot3)
	RoomInventoryBuildingModel.instance:placeBuilding(slot3)
	RoomShowBuildingListModel.instance:setShowBuildingList()
	RoomResourceModel.instance:clearResourceAreaList()
	RoomModel.instance:setEditFlag()

	if RoomBuildingAreaHelper.isBuildingArea(slot3.defineId) then
		RoomMapBuildingAreaModel.instance:refreshBuildingAreaMOList()
	end

	slot2.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceBuilding, {
		buildingInfo = slot3,
		tempBuildingMO = slot4
	})
	slot0:_unUseBuildings(slot1.deleteBuildingInfos)
	slot0:_deleteRoadInfos(slot1.deleteRoadInfos)
end

function slot0.unUseBuildingRequest(slot0, slot1)
	RoomRpc.instance:sendUnUseBuildingRequest(slot1)
end

function slot0.unUseBuildingReply(slot0, slot1)
	RoomModel.instance:setEditFlag()

	slot0._isNeedConfirmRoom = true

	slot0:_unUseBuildings(slot1.buildingInfos)
	slot0:_deleteRoadInfos(slot1.roadInfos)
end

function slot0._unUseBuildings(slot0, slot1)
	slot2 = GameSceneMgr.instance:getCurScene()

	for slot7 = 1, #slot1 do
		RoomInventoryBuildingModel.instance:unUseBuilding(slot1[slot7])

		if not false and RoomBuildingAreaHelper.isBuildingArea(slot1[slot7].defineId) then
			slot3 = true
		end
	end

	RoomResourceModel.instance:clearResourceAreaList()
	slot2.fsm:triggerEvent(RoomSceneEvent.UnUseBuilding, {
		buildingInfos = slot1
	})
	RoomShowBuildingListModel.instance:setShowBuildingList()

	if RoomMapBlockModel.instance:isBackMore() then
		RoomBlockController.instance:refreshBackBuildingEffect()
	end

	if slot3 then
		RoomMapBuildingAreaModel.instance:refreshBuildingAreaMOList()
	end
end

function slot0.buildingLevelUpByInfos(slot0, slot1, slot2)
	slot3 = false
	slot4 = {}

	if slot1 and (RoomController.instance:isObMode() or RoomController.instance:isEditMode()) then
		for slot9, slot10 in ipairs(slot1) do
			slot12 = RoomMapBuildingModel.instance:getBuildingMOById(slot10.uid)

			if slot10.level and slot12 and slot12.config and slot12.config.canLevelUp then
				slot12.level = slot10.level

				slot12:refreshCfg()

				slot4[slot11] = true
				slot3 = true
			end
		end
	end

	if slot3 or slot2 then
		slot0:dispatchEvent(RoomEvent.BuildingLevelUpPush, slot4)
	end
end

function slot0.useCharacterRequest(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(RoomCharacterModel.instance:getList()) do
		if slot8:isPlaceSourceState() then
			table.insert(slot2, slot8.heroId)
		end
	end

	if not tabletool.indexOf(slot2, slot1) then
		table.insert(slot2, slot1)
	end

	RoomRpc.instance:sendUpdateRoomHeroDataRequest(slot2, slot0.useCharacterReply, slot0)
end

function slot0.useCharacterReply(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot4 = GameSceneMgr.instance:getCurScene()

	if RoomCharacterModel.instance:getTempCharacterMO() and not slot5:isPlaceSourceState() and RoomModel.instance:getCharacterById(slot5.id) then
		slot5.sourceState = RoomCharacterEnum.SourceState.Place
	end

	RoomCharacterModel.instance:placeTempCharacterMO()
	RoomCharacterController.instance:correctCharacterHeight(slot5)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	RoomCharacterController.instance:updateCharacterFaith(slot3.roomHeroDatas)
	slot4.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceCharacter, {
		tempCharacterMO = slot5
	})
	RoomInteractBuildingModel.instance:checkAllHero()
end

function slot0.unUseCharacterRequest(slot0, slot1, slot2, slot3, slot4)
	slot0._unUseCharacterCallback = slot2
	slot0._unUseCharacterCallbackObj = slot3
	slot0._unUseAnim = slot4

	for slot10, slot11 in ipairs(RoomCharacterModel.instance:getList()) do
		if slot11:isPlaceSourceState() and slot11.heroId ~= slot1 then
			table.insert({}, slot11.heroId)
		end
	end

	if RoomCharacterController.instance:isCharacterFaithFull(slot1) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(slot1)
	end

	RoomRpc.instance:sendUpdateRoomHeroDataRequest(slot5, slot0.unUseCharacterReply, slot0)
end

function slot0.unUseCharacterReply(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot5 = RoomCharacterModel.instance:getTempCharacterMO()

	GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.UnUseCharacter, {
		heroId = slot5.heroId,
		tempCharacterMO = slot5,
		anim = slot0._unUseAnim
	})

	if slot5:isTrainSourceState() or slot5:isTraining() then
		RoomCharacterModel.instance:setHideFaithFull(slot5.heroId, false)
	else
		RoomCharacterModel.instance:deleteCharacterMO(slot5.heroId)
	end

	RoomCharacterController.instance:updateCharacterFaith(slot3.roomHeroDatas)
	RoomInteractBuildingModel.instance:checkAllHero()

	if slot0._unUseCharacterCallback then
		slot0._unUseCharacterCallback(slot0._unUseCharacterCallbackObj)
	end

	slot0._unUseCharacterCallback = nil
	slot0._unUseCharacterCallbackObj = nil
end

function slot0.confirmRoom(slot0, slot1, slot2, slot3)
	if RoomController.instance:isReset() then
		RoomRpc.instance:sendUpdateRoomHeroDataRequest({})
	end

	slot5 = RoomCharacterHelper.getNeedRemoveCount()

	if not slot4 and slot5 > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomRemoveCharacter, MsgBoxEnum.BoxType.Yes_No, function ()
			ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
				needRemoveCount = uv0,
				sureCallback = uv1._confirmYesCallback,
				callbackObj = uv1,
				callbackParam = {
					callback = uv2,
					callbackObj = uv3,
					param = uv4
				}
			})
		end, nil, , , , , slot5)
	else
		slot0:_confirmYesCallback({
			callback = slot1,
			callbackObj = slot2,
			param = slot3
		})
	end
end

function slot0._confirmYesCallback(slot0, slot1)
	RoomRpc.instance:sendRoomConfirmRequest(slot0._confirmRoomReply, slot0)

	if slot1.callback then
		if slot1.callbackObj then
			slot1.callback(slot1.callbackObj, slot1.param)
		else
			slot1.callback(slot1.param)
		end
	end
end

function slot0._confirmRoomReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		RoomModel.instance:setObInfo(slot3)

		slot0._isNeedConfirmRoom = false
		slot0._isHasConfirmOp = true

		GameFacade.showToast(RoomEnum.Toast.RoomConfirmRoomSuccess)
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
		RoomLayoutController.instance:updateObInfo()
	end
end

function slot0.revertRoom(slot0)
	RoomRpc.instance:sendRoomRevertRequest(slot0._revertRoomReply, slot0)
end

function slot0._revertRoomReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0._isNeedConfirmRoom = false
	end
end

function slot0.isResetEdit(slot0)
	return slot0._isResetEdit
end

function slot0.isNeedConfirmRoom(slot0)
	return slot0._isNeedConfirmRoom
end

function slot0.isHasConfirmOp(slot0)
	return slot0._isHasConfirmOp
end

function slot0.openFormulaItemBuildingViewOutSide(slot0)
	RoomFormulaModel.instance:initFormula()
	ViewMgr.instance:openView(ViewName.RoomInitBuildingView, {
		openInOutside = true,
		partId = 3,
		showFormulaView = true
	})
end

function slot0.openRoomInitBuildingView(slot0, slot1, slot2)
	slot3 = GameSceneMgr.instance:getCurScene()
	slot0._openRoomInitBuildingViewCameraState = slot3.camera:getCameraState()
	slot0._openRoomInitBuildingViewZoom = slot3.camera:getCameraZoom()

	RoomBuildingController.instance:tweenCameraFocusPart(slot2 and slot2.partId, RoomEnum.CameraState.Normal, 0)

	slot0._openRoomInitBuildingViewParam = nil

	uv0.instance:dispatchEvent(RoomEvent.WillOpenRoomInitBuildingView)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.RefreshNavigateButton)

	if not slot1 or slot1 <= 0 then
		slot0:_realOpenRoomInitBuildingView(slot2)
		slot0:dispatchEvent(RoomEvent.RefreshUIShow)

		return
	else
		slot0._openRoomInitBuildingViewParam = slot2

		TaskDispatcher.cancelTask(slot0._realOpenRoomInitBuildingView, slot0)
		TaskDispatcher.runDelay(slot0._realOpenRoomInitBuildingView, slot0, slot1)
		slot0:dispatchEvent(RoomEvent.RefreshUIShow)
	end
end

function slot0._realOpenRoomInitBuildingView(slot0, slot1)
	slot1 = slot1 or slot0._openRoomInitBuildingViewParam
	slot0._openRoomInitBuildingViewParam = nil

	ViewMgr.instance:openView(ViewName.RoomInitBuildingView, slot1)
	RoomSkinController.instance:clearInitBuildingEntranceReddot(slot1 and slot1.partId)
end

function slot0.onCloseRoomInitBuildingView(slot0)
	if slot0._openRoomInitBuildingViewCameraState and slot0._openRoomInitBuildingViewZoom then
		GameSceneMgr.instance:getCurScene().camera:switchCameraState(slot0._openRoomInitBuildingViewCameraState, {
			zoom = slot0._openRoomInitBuildingViewZoom
		})

		slot0._openRoomInitBuildingViewCameraState = nil
		slot0._openRoomInitBuildingViewZoom = nil

		slot0:dispatchEvent(RoomEvent.RefreshUIShow)
		RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
		RoomBuildingController.instance:dispatchEvent(RoomEvent.RefreshNavigateButton)
	end
end

function slot0.isInRoomInitBuildingViewCamera(slot0)
	return slot0._openRoomInitBuildingViewCameraState and slot0._openRoomInitBuildingViewZoom
end

function slot0.openRoomLevelUpView(slot0)
	ViewMgr.instance:openView(ViewName.RoomLevelUpView)
end

function slot0.switchBackBlock(slot0, slot1)
	slot2 = RoomMapBlockModel.instance:isBackMore()

	RoomMapBlockModel.instance:setBackMore(slot1)

	if not slot1 then
		GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	else
		if RoomMapBlockModel.instance:getBackBlockModel():getCount() > 0 and RoomMapBlockModel.instance:isCanBackBlock() == false then
			slot3.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		end

		slot3.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	uv0.instance:dispatchEvent(RoomEvent.BackBlockShowChanged)
	uv0.instance:dispatchEvent(RoomEvent.SelectBlock)
	RoomBackBlockHelper.resfreshInitBlockEntityEffect()

	if slot2 == true and RoomMapBlockModel.instance:isBackMore() == false then
		TaskDispatcher.cancelTask(slot0._playBackBlockUIAnim, slot0)
		TaskDispatcher.runDelay(slot0._playBackBlockUIAnim, slot0, 0.3333333333333333)
	end

	if slot2 ~= RoomMapBlockModel.instance:isBackMore() then
		RoomBlockController.instance:refreshBackBuildingEffect()
	end
end

function slot0._playBackBlockUIAnim(slot0)
	if RoomMapBlockModel.instance:isBackMore() == false then
		slot0:dispatchEvent(RoomEvent.BackBlockPlayUIAnim)
	end
end

function slot0.switchWaterReform(slot0, slot1)
	slot2 = GameSceneMgr.instance:getCurScene()

	slot2.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	slot2.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)

	if slot1 then
		slot2.fsm:triggerEvent(RoomSceneEvent.EnterWaterReform)
	else
		slot2.fsm:triggerEvent(RoomSceneEvent.CloseWaterReform)
	end

	RoomWaterReformController.instance:dispatchEvent(RoomEvent.WaterReformShowChanged)
end

function slot0.statRoomStart(slot0)
	slot0._statTime = ServerTime.now()
end

function slot0.statRoomEnd(slot0)
	if not slot0._statTime then
		return
	end

	slot1 = nil
	slot2 = ServerTime.now() - slot0._statTime

	if RoomController.instance:isObMode() then
		slot3 = RoomMapBlockModel.instance:getConfirmBlockCount()

		for slot9, slot10 in ipairs(RoomCharacterModel.instance:getList()) do
			table.insert({}, {
				heroname = slot10.heroConfig.name
			})
		end

		slot6 = {}

		for slot11, slot12 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
			if not slot6[slot12.config.id] then
				slot6[slot12.config.id] = {
					build_num = 1,
					buildname = slot12.config.name
				}
			else
				slot13.build_num = slot13.build_num + 1
			end
		end

		slot8 = {}

		for slot12, slot13 in pairs(slot6) do
			table.insert(slot8, slot13)
		end

		slot1 = {
			[StatEnum.EventProperties.PlacePlotnum] = slot3,
			[StatEnum.EventProperties.PlaceHero] = slot4,
			[StatEnum.EventProperties.PlaceBuild] = slot8,
			[StatEnum.EventProperties.UseTime] = slot2,
			[StatEnum.EventProperties.VitalityValue] = RoomMapModel.instance:getAllBuildDegree(),
			[StatEnum.EventProperties.PivotLevel] = RoomMapModel.instance:getRoomLevel(),
			[StatEnum.EventProperties.OwnPlans] = RoomLayoutModel.instance:getLayoutCount(),
			[StatEnum.EventProperties.PlanName] = RoomLayoutModel.instance:getCurrentUsePlanName(),
			[StatEnum.EventProperties.PlotBag] = RoomLayoutModel.instance:getCurrentPlotBagData()
		}
	elseif RoomController.instance:isEditMode() then
		slot4 = 0

		for slot9, slot10 in ipairs(RoomModel.instance:getObInfo().infos) do
			if slot10.blockId > 0 then
				slot5 = 0 + 1
			end

			slot4 = slot4 + (RoomConfig.instance:getPackageConfigByBlockId(slot10.blockId) and slot11.blockBuildDegree or 0)
		end

		for slot10, slot11 in ipairs(slot3.roomHeroDatas) do
			table.insert({}, {
				heroname = HeroConfig.instance:getHeroCO(slot11.heroId).name
			})
		end

		slot7 = {}
		slot8 = {}

		for slot12, slot13 in ipairs(slot3.buildingInfos) do
			if not slot8[slot13.defineId] then
				slot15 = RoomConfig.instance:getBuildingConfig(slot13.defineId)
				slot8[slot13.defineId] = {
					build_num = 1,
					buildname = slot15.name,
					buildDegree = slot15.buildDegree
				}
				slot4 = slot4 + slot15.buildDegree
			else
				slot14.build_num = slot14.build_num + 1
				slot4 = slot4 + slot14.buildDegree
			end
		end

		for slot12, slot13 in pairs(slot8) do
			slot13.buildDegree = nil

			table.insert(slot7, slot13)
		end

		slot1 = {
			[StatEnum.EventProperties.PlacePlotnum] = slot5,
			[StatEnum.EventProperties.PlaceHero] = slot6,
			[StatEnum.EventProperties.PlaceBuild] = slot7,
			[StatEnum.EventProperties.UseTime] = slot2,
			[StatEnum.EventProperties.VitalityValue] = slot4,
			[StatEnum.EventProperties.PivotLevel] = slot3.roomLevel,
			[StatEnum.EventProperties.OwnPlans] = RoomLayoutModel.instance:getLayoutCount(),
			[StatEnum.EventProperties.PlanName] = RoomLayoutModel.instance:getCurrentUsePlanName(),
			[StatEnum.EventProperties.PlotBag] = RoomLayoutModel.instance:getCurrentPlotBagData()
		}
	end

	if slot1 then
		slot0._statTime = nil
		slot1[StatEnum.EventProperties.SharePlanNum] = RoomLayoutModel.instance:getSharePlanCount()
		slot1[StatEnum.EventProperties.Attention] = RoomLayoutModel.instance:getUseCount()

		StatController.instance:track(StatEnum.EventName.ExitCabin, slot1)
	end
end

function slot0.isUIHide(slot0)
	return slot0._isUIHide
end

function slot0.setUIHide(slot0, slot1, slot2)
	slot0._isUIHide = slot1

	if slot0._isUIHide ~= slot1 then
		slot0:dispatchEvent(slot1 and RoomEvent.HideUI or RoomEvent.ShowUI, slot2)
	end
end

slot0.instance = slot0.New()

return slot0

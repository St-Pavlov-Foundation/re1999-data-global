module("modules.logic.room.controller.RoomController", package.seeall)

slot0 = class("RoomController", BaseController)

function slot0.onInit(slot0)
	slot0:_clear()

	slot0._showChangeNotOpenToastDic = {
		[MaterialEnum.MaterialType.Building] = RoomEnum.Toast.RoomLockMaterialChangeTip,
		[MaterialEnum.MaterialType.BlockPackage] = RoomEnum.Toast.RoomLockMaterialChangeTip,
		[MaterialEnum.MaterialType.SpecialBlock] = RoomEnum.Toast.RoomLockMaterialChangeTip
	}
end

function slot0.reInit(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	slot0.rotateSpeed = 1
	slot0.moveSpeed = 1
	slot0.scaleSpeed = 1
	slot0.touchMoveSpeed = 1

	TaskDispatcher.cancelTask(slot0._delaySwitchScene, slot0)

	slot0._isEditorMode = false
	slot0._isReset = false
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onOnCloseViewFinish, slot0)
	slot0:addEventCb(slot0, RoomEvent.OnSwitchModeDone, slot0._onOnSwitchModeDone, slot0)
end

function slot0._onOnCloseViewFinish(slot0, slot1, slot2)
	if slot1 == ViewName.CommonPropView then
		slot0:checkThemeCollerctFullReward()
	end
end

function slot0._onOnSwitchModeDone(slot0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function slot0.sendInitRoomObInfo(slot0)
	RoomRpc.instance:sendGetRoomObInfoRequest(true, slot0._onInitObInfoReply, slot0)
end

function slot0._onInitObInfoReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 and slot3.needBlockData == true then
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
		RoomModel.instance:setObInfo(slot3)
	end
end

function slot0.setEditorMode(slot0, slot1)
	slot0._isEditorMode = slot1
end

function slot0.isEditorMode(slot0)
	return slot0._isEditorMode
end

function slot0.isRoomScene(slot0)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.Room
end

function slot0.isEditMode(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Edit
end

function slot0.isObMode(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Ob
end

function slot0.isVisitMode(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Visit or slot1 == RoomEnum.GameMode.VisitShare
end

function slot0.isVisitShareMode(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.VisitShare
end

function slot0.isDebugMode(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugNormal or RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugInit or RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugPackage
end

function slot0.isDebugNormalMode(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugNormal
end

function slot0.isDebugInitMode(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugInit
end

function slot0.isDebugPackageMode(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugPackage
end

function slot0.getDebugParam(slot0)
	return RoomModel.instance:getDebugParam()
end

function slot0.getOpenViews(slot0)
	return slot0._openViews
end

function slot0.enterRoom(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	RoomHelper.logStart("开始进入小屋")
	slot0:_startEnterRoomBlock()

	slot0._forceStart = slot6
	slot0._isReset = slot7
	slot0._openViews = {}

	tabletool.addValues(slot0._openViews, slot5)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and uv0.instance:isObMode() then
		-- Nothing
	end

	RoomModel.instance:setGameMode(slot1)

	if not slot0:isDebugMode() and (RoomLayoutModel.instance:isNeedRpcGet() or slot0:isObMode()) then
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
	end

	if slot0:_getEnterRoonFuncByGameMode(slot1) then
		slot8(slot0, slot2, slot3, slot4)
	else
		logError(string.format("can not find enter room function by gameModel:%s", slot1))
	end
end

slot0.ENTER_ROOM_BLOCK_KEY = "RoomController_ENTER_ROOM_BLOCK_KEY"

function slot0._startEnterRoomBlock(slot0)
	UIBlockMgr.instance:startBlock(uv0.ENTER_ROOM_BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0._endEnterRoomBlock, slot0)
	TaskDispatcher.runDelay(slot0._endEnterRoomBlock, slot0, 10)
end

function slot0._endEnterRoomBlock(slot0)
	TaskDispatcher.cancelTask(slot0._endEnterRoomBlock, slot0)
	UIBlockMgr.instance:endBlock(uv0.ENTER_ROOM_BLOCK_KEY)
end

function slot0._getEnterRoonFuncByGameMode(slot0, slot1)
	if not slot0._enterRoomFuncMap then
		slot0._enterRoomFuncMap = {
			[RoomEnum.GameMode.Ob] = slot0._enterRoomObOrEdit,
			[RoomEnum.GameMode.Edit] = slot0._enterRoomObOrEdit,
			[RoomEnum.GameMode.Visit] = slot0._enterRoomVisit,
			[RoomEnum.GameMode.VisitShare] = slot0._enterRoomVisitShare,
			[RoomEnum.GameMode.DebugNormal] = slot0._enterRoomDebugNormal,
			[RoomEnum.GameMode.DebugInit] = slot0._enterRoomDebugInit,
			[RoomEnum.GameMode.DebugPackage] = slot0._enterRoomDebugPackage
		}
	end

	return slot0._enterRoomFuncMap[slot1]
end

function slot0._enterRoomObOrEdit(slot0, slot1, slot2, slot3)
	if GameSceneMgr.instance:getCurScene() and slot4.fsm then
		if RoomMapBlockModel.instance:getBackBlockModel() and slot5:getCount() > 0 then
			slot4.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		end

		if RoomMapBlockModel.instance:getTempBlockMO() then
			slot4.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
		end

		if RoomMapBuildingModel.instance:getTempBuildingMO() then
			slot4.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
		end
	end

	RoomModel.instance:setEnterParam(slot3)

	slot0._editInfoReady = false
	slot0._obInfoReady = false

	if slot1 or RoomModel.instance:getGameMode() == RoomEnum.GameMode.Ob then
		slot0._editInfoReady = true

		if slot1 then
			RoomModel.instance:setEditInfo(slot1)
		end
	end

	if slot2 then
		slot0._obInfoReady = true

		RoomModel.instance:setObInfo(slot2)
		RoomLayoutController.instance:updateObInfo()
	end

	if not slot0._editInfoReady then
		RoomRpc.instance:sendGetRoomInfoRequest(slot0.getRoomInfoReply, slot0)
	end

	if not slot0._obInfoReady then
		RoomRpc.instance:sendGetRoomObInfoRequest(true, slot0.getRoomObInfoReply, slot0)
	end

	RoomGiftController.instance:getAct159Info()
	ManufactureController.instance:getManufactureServerInfo()
	slot0:_checkInfo()
end

function slot0._enterRoomVisit(slot0, slot1, slot2, slot3)
	RoomModel.instance:setVisitParam(slot3)

	slot0._obInfoReady = false
	slot0._editInfoReady = true

	RoomRpc.instance:sendGetOtherRoomObInfoRequest(slot3.userId, slot0.getOtherRoomObInfoReply, slot0)
end

function slot0._enterRoomVisitShare(slot0, slot1, slot2, slot3)
	slot0._obInfoReady = false
	slot0._editInfoReady = true
	slot0._isVisitCompareInfo = RoomLayoutHelper.checkVisitParamCoppare(slot3)

	if slot2 and slot2.shareCode == slot3.shareCode and slot2.shareUserId == slot3.userId then
		slot0:getGetRoomShareReply(nil, 0, slot2)
	else
		RoomRpc.instance:sendGetRoomShareRequest(slot3.shareCode, slot0.getGetRoomShareReply, slot0)
	end
end

function slot0._enterRoomDebugNormal(slot0, slot1, slot2, slot3)
	RoomModel.instance:setEditInfo(RoomDebugController.instance:getDebugMapInfo())
	RoomModel.instance:setObInfo(nil)
	slot0:_enterScene()
end

function slot0._enterRoomDebugInit(slot0, slot1, slot2, slot3)
	RoomModel.instance:setDebugParam(slot3)
	RoomDebugController.instance:getDebugInitMapInfo(slot3, slot0._onEnterRoomDebugParam, slot0)
end

function slot0._enterRoomDebugPackage(slot0, slot1, slot2, slot3)
	RoomModel.instance:setDebugParam(slot3)
	RoomDebugController.instance:getDebugPackageMapInfo(slot3, slot0._onEnterRoomDebugParam, slot0)
end

function slot0._onEnterRoomDebugParam(slot0, slot1)
	RoomModel.instance:setEditInfo(slot1)
	RoomModel.instance:setObInfo(nil)
	slot0:_enterScene()
end

function slot0.leaveRoom(slot0)
	RoomMapController.instance:statRoomEnd()
	MainController.instance:enterMainScene()
end

function slot0.getRoomInfoReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		RoomHelper.logElapse("获取小屋协议完成")
		RoomModel.instance:setEditInfo(slot3)

		slot0._editInfoReady = true

		slot0:_checkInfo()
	else
		slot0:_endEnterRoomBlock()
	end
end

function slot0.getRoomObInfoReply(slot0, slot1, slot2, slot3)
	slot0:_roomXObInfoReply(slot1, slot2, slot3, RoomEnum.GameMode.Ob)
end

function slot0.getOtherRoomObInfoReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 and not string.nilorempty(slot3.shareCode) then
		RoomModel.instance:setInfoByMode(slot3, RoomEnum.GameMode.Visit)
		RoomRpc.instance:sendGetRoomShareRequest(slot3.shareCode, slot0._onGetOtherToShareCodeReply, slot0)
	else
		slot0:_roomXObInfoReply(slot1, slot2, slot3, RoomEnum.GameMode.Visit)
	end
end

function slot0._onGetOtherToShareCodeReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		RoomModel.instance:setGameMode(RoomEnum.GameMode.VisitShare)
		slot0:getGetRoomShareReply(slot1, slot2, slot3)
	else
		slot0:_roomXObInfoReply(slot1, 0, RoomModel.instance:getInfoByMode(RoomEnum.GameMode.Visit), RoomEnum.GameMode.Visit)
	end
end

function slot0.getGetRoomShareReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		if slot0._isVisitCompareInfo then
			-- Nothing
		end

		RoomModel.instance:setVisitParam({
			userId = slot3.shareUserId,
			shareCode = slot3.shareCode,
			nickName = slot3.nickName,
			portrait = slot3.portrait,
			useCount = slot3.useCount,
			roomPlanName = slot3.roomPlanName,
			isCompareInfo = true
		})
	end

	slot0:_roomXObInfoReply(slot1, slot2, slot3, RoomEnum.GameMode.VisitShare)
end

function slot0._roomXObInfoReply(slot0, slot1, slot2, slot3, slot4)
	if slot2 == 0 then
		RoomHelper.logElapse("获取小屋 ob协议完成")
		RoomModel.instance:setInfoByMode(slot3, slot4)

		slot0._obInfoReady = true

		slot0:_checkInfo()
	else
		slot0:_endEnterRoomBlock()
	end
end

function slot0.blockPackageGainPush(slot0, slot1)
	RoomModel.instance:blockPackageGainPush(slot1)

	if slot0:isEditMode() then
		RoomInventoryBlockModel.instance:addBlockPackageList(slot1.blockPackages)
	end
end

function slot0.gainSpecialBlockPush(slot0, slot1)
	RoomModel.instance:addSpecialBlockIds(slot1.specialBlocks)

	if slot0:isEditMode() then
		RoomInventoryBlockModel.instance:addSpecialBlockIds(slot1.specialBlocks)
	end
end

function slot0.getBlockPackageInfoReply(slot0, slot1)
	RoomModel.instance:setBlockPackageIds(slot1.blockPackageIds)
	RoomModel.instance:setSpecialBlockInfoList(slot1.specialBlocks)
end

function slot0.getBuildingInfoReply(slot0, slot1)
	RoomModel.instance:setBuildingInfos(slot1.buildingInfos)
end

function slot0.getRoomThemeCollectionBonusReply(slot0, slot1)
	RoomModel.instance:addGetThemeRewardId(slot1.id)
	slot0:dispatchEvent(RoomEvent.UpdateRoomThemeReward, slot1.id)
end

function slot0.checkThemeCollerctFullReward(slot0)
	if RoomModel.instance:findHasGetThemeRewardThemeId() and not ViewMgr.instance:isOpen(ViewName.RoomThemeTipView) then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = MaterialEnum.MaterialType.RoomTheme,
			id = slot1
		})
	end
end

function slot0._checkInfo(slot0)
	if slot0._editInfoReady and slot0._obInfoReady then
		RoomHelper.logElapse("开始加载小屋场景")
		slot0:_enterScene()
	end
end

function slot0._enterScene(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot0:_switchScene()
		slot0:_endEnterRoomBlock()
	else
		GameSceneMgr.instance:startSceneDefaultLevel(SceneType.Room, RoomEnum.RoomSceneId, slot0._forceStart)
		TaskDispatcher.runDelay(slot0._nextFrameStartPreload, slot0, 0.01)
	end
end

function slot0._nextFrameStartPreload(slot0)
	RoomPreloadMgr.instance:startPreload()
	slot0:_endEnterRoomBlock()
end

function slot0._switchScene(slot0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingRoomView)
	GameSceneMgr.instance:showLoading(SceneType.Room)
	TaskDispatcher.runDelay(slot0._delaySwitchScene, slot0, 2)
	slot0:dispatchEvent(RoomEvent.SwitchScene)

	if uv0.instance:isObMode() then
		GameSceneMgr.instance:getCurScene().camera:playCameraAnim("in_show")
	elseif uv0.instance:isEditMode() then
		slot1.camera:playCameraAnim("in_edit")
	end
end

function slot0._delaySwitchScene(slot0)
	GameSceneMgr.instance:getScene(SceneType.Room).director:switchMode()
end

function slot0.MaterialChangeByRoomProductLine(slot0, slot1)
	slot4 = RoomEnum.Toast.MaterialChangeByRoomProductLine_Base

	if RoomConfig.instance:getBuildBonusByBuildDegree(RoomMapModel.instance:getAllBuildDegree()) / 10 > 0 then
		slot4 = RoomEnum.Toast.MaterialChangeByRoomProductLine
	else
		slot3 = nil
	end

	for slot8, slot9 in ipairs(slot1) do
		if LangSettings.instance:isEn() then
			ToastController.instance:showToastWithIcon(slot4, ResUrl.getPropItemIcon(slot9.materilId), string.format("%s +%d", ItemModel.instance:getItemConfig(slot9.materilType, slot9.materilId).name, slot9.quantity), slot3)
		else
			ToastController.instance:showToastWithIcon(slot4, slot10, string.format("%s+%d", slot11.name, slot9.quantity), slot3)
		end
	end
end

function slot0.exitRoom(slot0, slot1)
	if slot0:isEditorMode() then
		GameSceneMgr.instance:closeScene()
		ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
	elseif slot0:isEditMode() then
		slot2 = {
			isFromEditMode = true,
			isConfirm = true
		}

		if RoomMapController.instance:isHasConfirmOp() then
			-- Nothing
		end

		if RoomMapController.instance:isNeedConfirmRoom() then
			slot2.isConfirm = true
			slot2.isHomeClick = slot1

			RoomMapController.instance:confirmRoom(slot0._confirmRoomCallback, slot0, slot2)
		else
			RoomShowBuildingListModel.instance:clearFilterData()
			RoomThemeFilterListModel.instance:clearFilterData()

			if slot1 then
				slot0:leaveRoom()
			else
				slot0:enterRoom(RoomEnum.GameMode.Ob, nil, , slot2)
			end
		end
	elseif slot1 then
		slot0:leaveRoom()
	elseif slot0:isVisitShareMode() then
		slot0:enterRoom(RoomEnum.GameMode.Ob, nil, , , , , true)
	else
		slot0:leaveRoom()

		if slot0:isVisitMode() then
			JumpController.instance:jump(JumpEnum.JumpView.SocialView)
		end
	end
end

function slot0._confirmRoomCallback(slot0, slot1)
	RoomShowBuildingListModel.instance:clearFilterData()

	if slot1.isHomeClick then
		slot0:leaveRoom()
	else
		slot0:enterRoom(RoomEnum.GameMode.Ob, nil, , slot1)
	end
end

function slot0.isReset(slot0)
	return slot0._isReset
end

function slot0.openStoreGoodsTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomStoreGoodsTipView, {
		storeGoodsMO = slot1
	})
end

function slot0.openThemeFilterView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RoomThemeFilterView, {
		isBottom = slot1,
		posX = slot2
	})
end

function slot0.popUpRoomBlockPackageView(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:_showPopupViewChange(slot1)
	slot0:_showTipsMaterialChange(slot1)
end

function slot0._showPopupViewChange(slot0, slot1)
	slot4 = slot1
	slot5 = RoomConfig.instance

	if RoomStoreOrderModel.instance:getMOByList(slot1) then
		RoomStoreOrderModel.instance:remove(slot2)

		if slot2.themeId then
			slot9 = slot2.themeId

			table.insert({}, {
				itemType = MaterialEnum.MaterialType.RoomTheme,
				itemId = slot9
			})

			for slot9, slot10 in ipairs(slot1) do
				if slot2.themeId ~= slot5:getThemeIdByItem(slot10.materilId, slot10.materilType) then
					table.insert({}, slot10)
				end
			end
		end
	end

	for slot9, slot10 in ipairs(slot4) do
		if slot10.materilType == MaterialEnum.MaterialType.BlockPackage and slot5:getBlockPackageConfig(slot10.materilId) and not string.nilorempty(slot11.rewardIcon) and slot0:_containRare(CommonConfig.instance:getConstStr(ConstEnum.RoomBlockPackageGetRare), slot11.rare) then
			table.insert(slot3, {
				itemType = MaterialEnum.MaterialType.BlockPackage,
				itemId = slot10.materilId
			})
		end
	end

	for slot9, slot10 in ipairs(slot4) do
		if slot10.materilType == MaterialEnum.MaterialType.Building and slot5:getBuildingConfig(slot10.materilId) and not string.nilorempty(slot11.rewardIcon) and slot0:_containRare(CommonConfig.instance:getConstStr(ConstEnum.RoomBuildingGetRare), slot11.rare) then
			table.insert(slot3, {
				itemType = MaterialEnum.MaterialType.Building,
				itemId = slot10.materilId,
				roomBuildingLevel = slot10.roomBuildingLevel
			})
		end
	end

	if #slot3 > 0 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
			itemList = slot3
		})
	end
end

function slot0._showTipsMaterialChange(slot0, slot1)
	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]

		if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
			if slot7.materilType == MaterialEnum.MaterialType.SpecialBlock and RoomConfig.instance:getBlock(slot7.materilId) then
				slot10 = RoomConfig.instance:getBlockPackageConfig(slot8.packageId)

				ToastController.instance:showToast(RoomEnum.Toast.SpecialBlockGain, RoomConfig.instance:getSpecialBlockConfig(slot7.materilId) and slot9.name or slot7.materilId, slot10 and slot10.name or slot8.packageId)
			end
		elseif slot0._showChangeNotOpenToastDic and slot0._showChangeNotOpenToastDic[slot7.materilType] then
			ToastController.instance:showToast(slot0._showChangeNotOpenToastDic[slot7.materilType], ItemModel.instance:getItemConfig(slot7.materilType, slot7.materilId) and slot8.name or slot7.materilId)
		end
	end
end

function slot0.showInteractionRewardToast(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7, slot8 = ItemModel.instance:getItemConfigAndIcon(slot6.materilType, slot6.materilId)

		if slot7 then
			GameFacade.showToastWithIcon(ToastEnum.RoomRewardToast, slot8, slot7.name, slot6.quantity)
		end
	end
end

function slot0.homeClick(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	uv0.instance:exitRoom(true)
end

function slot0._containRare(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return false
	end

	return tabletool.indexOf(string.splitToNumber(slot1, "#"), slot2)
end

function slot0.popUpSourceView(slot0, slot1)
	slot2 = false
	slot3 = false
	slot4 = false

	for slot8, slot9 in ipairs(slot1) do
		if slot9.viewName == ViewName.RoomInitBuildingView then
			slot3 = true
		elseif slot9.viewName == ViewName.RoomFormulaView then
			slot2 = true
		elseif slot9.viewName == ViewName.RoomProductLineLevelUpView then
			slot4 = true
		end
	end

	for slot8, slot9 in ipairs(slot1) do
		if slot9.viewName == ViewName.RoomInitBuildingView then
			slot9.viewParam = slot9.viewParam or {}
			slot9.viewParam.showFormulaView = slot2 and slot4 == false

			if uv0.instance:isRoomScene() then
				RoomMapController.instance:openRoomInitBuildingView(0, slot9.viewParam)
			else
				RoomMapController.instance:openFormulaItemBuildingViewOutSide()
			end
		elseif slot9.viewName == ViewName.RoomFormulaView and (not slot3 or slot4) then
			ViewMgr.instance:openView(slot9.viewName, slot9.viewParam)
		end
	end
end

slot0.instance = slot0.New()

return slot0

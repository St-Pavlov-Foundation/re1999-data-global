module("modules.logic.room.controller.RoomController", package.seeall)

local var_0_0 = class("RoomController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clear()

	arg_1_0._showChangeNotOpenToastDic = {
		[MaterialEnum.MaterialType.Building] = RoomEnum.Toast.RoomLockMaterialChangeTip,
		[MaterialEnum.MaterialType.BlockPackage] = RoomEnum.Toast.RoomLockMaterialChangeTip,
		[MaterialEnum.MaterialType.SpecialBlock] = RoomEnum.Toast.RoomLockMaterialChangeTip
	}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clear()
end

function var_0_0._clear(arg_3_0)
	arg_3_0.rotateSpeed = 1
	arg_3_0.moveSpeed = 1
	arg_3_0.scaleSpeed = 1
	arg_3_0.touchMoveSpeed = 1

	TaskDispatcher.cancelTask(arg_3_0._delaySwitchScene, arg_3_0)

	arg_3_0._isEditorMode = false
	arg_3_0._isReset = false
end

function var_0_0.addConstEvents(arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onOnCloseViewFinish, arg_4_0)
	arg_4_0:addEventCb(arg_4_0, RoomEvent.OnSwitchModeDone, arg_4_0._onOnSwitchModeDone, arg_4_0)
end

function var_0_0._onOnCloseViewFinish(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == ViewName.CommonPropView then
		arg_5_0:checkThemeCollerctFullReward()
	end
end

function var_0_0._onOnSwitchModeDone(arg_6_0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function var_0_0.sendInitRoomObInfo(arg_7_0)
	RoomRpc.instance:sendGetRoomObInfoRequest(true, arg_7_0._onInitObInfoReply, arg_7_0)
end

function var_0_0._onInitObInfoReply(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 == 0 and arg_8_3.needBlockData == true then
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
		RoomModel.instance:setObInfo(arg_8_3)
	end
end

function var_0_0.setEditorMode(arg_9_0, arg_9_1)
	arg_9_0._isEditorMode = arg_9_1
end

function var_0_0.isEditorMode(arg_10_0)
	return arg_10_0._isEditorMode
end

function var_0_0.isRoomScene(arg_11_0)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.Room
end

function var_0_0.isEditMode(arg_12_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Edit
end

function var_0_0.isObMode(arg_13_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Ob
end

function var_0_0.isVisitMode(arg_14_0)
	local var_14_0 = RoomModel.instance:getGameMode()

	return var_14_0 == RoomEnum.GameMode.Visit or var_14_0 == RoomEnum.GameMode.VisitShare
end

function var_0_0.isVisitShareMode(arg_15_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.VisitShare
end

function var_0_0.isDebugMode(arg_16_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugNormal or RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugInit or RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugPackage
end

function var_0_0.isDebugNormalMode(arg_17_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugNormal
end

function var_0_0.isDebugInitMode(arg_18_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugInit
end

function var_0_0.isDebugPackageMode(arg_19_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugPackage
end

function var_0_0.getDebugParam(arg_20_0)
	return RoomModel.instance:getDebugParam()
end

function var_0_0.getOpenViews(arg_21_0)
	return arg_21_0._openViews
end

function var_0_0.enterRoom(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)
	RoomHelper.logStart("开始进入小屋")
	arg_22_0:_startEnterRoomBlock()

	arg_22_0._forceStart = arg_22_6
	arg_22_0._isReset = arg_22_7
	arg_22_0._openViews = {}

	tabletool.addValues(arg_22_0._openViews, arg_22_5)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and var_0_0.instance:isObMode() then
		-- block empty
	end

	RoomModel.instance:setGameMode(arg_22_1)

	if not arg_22_0:isDebugMode() and (RoomLayoutModel.instance:isNeedRpcGet() or arg_22_0:isObMode()) then
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
	end

	local var_22_0 = arg_22_0:_getEnterRoonFuncByGameMode(arg_22_1)

	if var_22_0 then
		var_22_0(arg_22_0, arg_22_2, arg_22_3, arg_22_4)
	else
		logError(string.format("can not find enter room function by gameModel:%s", arg_22_1))
	end
end

var_0_0.ENTER_ROOM_BLOCK_KEY = "RoomController_ENTER_ROOM_BLOCK_KEY"

function var_0_0._startEnterRoomBlock(arg_23_0)
	UIBlockMgr.instance:startBlock(var_0_0.ENTER_ROOM_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_23_0._endEnterRoomBlock, arg_23_0)
	TaskDispatcher.runDelay(arg_23_0._endEnterRoomBlock, arg_23_0, 10)
end

function var_0_0._endEnterRoomBlock(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._endEnterRoomBlock, arg_24_0)
	UIBlockMgr.instance:endBlock(var_0_0.ENTER_ROOM_BLOCK_KEY)
end

function var_0_0._getEnterRoonFuncByGameMode(arg_25_0, arg_25_1)
	if not arg_25_0._enterRoomFuncMap then
		arg_25_0._enterRoomFuncMap = {
			[RoomEnum.GameMode.Ob] = arg_25_0._enterRoomObOrEdit,
			[RoomEnum.GameMode.Edit] = arg_25_0._enterRoomObOrEdit,
			[RoomEnum.GameMode.Visit] = arg_25_0._enterRoomVisit,
			[RoomEnum.GameMode.VisitShare] = arg_25_0._enterRoomVisitShare,
			[RoomEnum.GameMode.DebugNormal] = arg_25_0._enterRoomDebugNormal,
			[RoomEnum.GameMode.DebugInit] = arg_25_0._enterRoomDebugInit,
			[RoomEnum.GameMode.DebugPackage] = arg_25_0._enterRoomDebugPackage
		}
	end

	return arg_25_0._enterRoomFuncMap[arg_25_1]
end

function var_0_0._enterRoomObOrEdit(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = GameSceneMgr.instance:getCurScene()

	if var_26_0 and var_26_0.fsm then
		local var_26_1 = RoomMapBlockModel.instance:getBackBlockModel()

		if var_26_1 and var_26_1:getCount() > 0 then
			var_26_0.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		end

		if RoomMapBlockModel.instance:getTempBlockMO() then
			var_26_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
		end

		if RoomMapBuildingModel.instance:getTempBuildingMO() then
			var_26_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
		end
	end

	RoomModel.instance:setEnterParam(arg_26_3)

	arg_26_0._editInfoReady = false
	arg_26_0._obInfoReady = false

	local var_26_2 = RoomModel.instance:getGameMode()

	if arg_26_1 or var_26_2 == RoomEnum.GameMode.Ob then
		arg_26_0._editInfoReady = true

		if arg_26_1 then
			RoomModel.instance:setEditInfo(arg_26_1)
		end
	end

	if arg_26_2 then
		arg_26_0._obInfoReady = true

		RoomModel.instance:setObInfo(arg_26_2)
		RoomLayoutController.instance:updateObInfo()
	end

	if not arg_26_0._editInfoReady then
		RoomRpc.instance:sendGetRoomInfoRequest(arg_26_0.getRoomInfoReply, arg_26_0)
	end

	if not arg_26_0._obInfoReady then
		RoomRpc.instance:sendGetRoomObInfoRequest(true, arg_26_0.getRoomObInfoReply, arg_26_0)
	end

	RoomGiftController.instance:getAct159Info()
	ManufactureController.instance:getManufactureServerInfo()
	arg_26_0:_checkInfo()
end

function var_0_0._enterRoomVisit(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	RoomModel.instance:setVisitParam(arg_27_3)

	arg_27_0._obInfoReady = false
	arg_27_0._editInfoReady = true

	local var_27_0 = arg_27_3.userId

	RoomRpc.instance:sendGetOtherRoomObInfoRequest(var_27_0, arg_27_0.getOtherRoomObInfoReply, arg_27_0)
end

function var_0_0._enterRoomVisitShare(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0._obInfoReady = false
	arg_28_0._editInfoReady = true
	arg_28_0._isVisitCompareInfo = RoomLayoutHelper.checkVisitParamCoppare(arg_28_3)

	if arg_28_2 and arg_28_2.shareCode == arg_28_3.shareCode and arg_28_2.shareUserId == arg_28_3.userId then
		arg_28_0:getGetRoomShareReply(nil, 0, arg_28_2)
	else
		local var_28_0 = arg_28_3.shareCode

		RoomRpc.instance:sendGetRoomShareRequest(var_28_0, arg_28_0.getGetRoomShareReply, arg_28_0)
	end
end

function var_0_0._enterRoomDebugNormal(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = RoomDebugController.instance:getDebugMapInfo()

	RoomModel.instance:setEditInfo(var_29_0)
	RoomModel.instance:setObInfo(nil)
	arg_29_0:_enterScene()
end

function var_0_0._enterRoomDebugInit(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	RoomModel.instance:setDebugParam(arg_30_3)
	RoomDebugController.instance:getDebugInitMapInfo(arg_30_3, arg_30_0._onEnterRoomDebugParam, arg_30_0)
end

function var_0_0._enterRoomDebugPackage(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	RoomModel.instance:setDebugParam(arg_31_3)
	RoomDebugController.instance:getDebugPackageMapInfo(arg_31_3, arg_31_0._onEnterRoomDebugParam, arg_31_0)
end

function var_0_0._onEnterRoomDebugParam(arg_32_0, arg_32_1)
	RoomModel.instance:setEditInfo(arg_32_1)
	RoomModel.instance:setObInfo(nil)
	arg_32_0:_enterScene()
end

function var_0_0.leaveRoom(arg_33_0)
	RoomMapController.instance:statRoomEnd()
	MainController.instance:enterMainScene()
end

function var_0_0.getRoomInfoReply(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if arg_34_2 == 0 then
		RoomHelper.logElapse("获取小屋协议完成")
		RoomModel.instance:setEditInfo(arg_34_3)

		arg_34_0._editInfoReady = true

		arg_34_0:_checkInfo()
	else
		arg_34_0:_endEnterRoomBlock()
	end
end

function var_0_0.getRoomObInfoReply(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0:_roomXObInfoReply(arg_35_1, arg_35_2, arg_35_3, RoomEnum.GameMode.Ob)
end

function var_0_0.getOtherRoomObInfoReply(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_2 == 0 and not string.nilorempty(arg_36_3.shareCode) then
		RoomModel.instance:setInfoByMode(arg_36_3, RoomEnum.GameMode.Visit)
		RoomRpc.instance:sendGetRoomShareRequest(arg_36_3.shareCode, arg_36_0._onGetOtherToShareCodeReply, arg_36_0)
	else
		arg_36_0:_roomXObInfoReply(arg_36_1, arg_36_2, arg_36_3, RoomEnum.GameMode.Visit)
	end
end

function var_0_0._onGetOtherToShareCodeReply(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_2 == 0 then
		RoomModel.instance:setGameMode(RoomEnum.GameMode.VisitShare)
		arg_37_0:getGetRoomShareReply(arg_37_1, arg_37_2, arg_37_3)
	else
		arg_37_0:_roomXObInfoReply(arg_37_1, 0, RoomModel.instance:getInfoByMode(RoomEnum.GameMode.Visit), RoomEnum.GameMode.Visit)
	end
end

function var_0_0.getGetRoomShareReply(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if arg_38_2 == 0 then
		local var_38_0 = {
			userId = arg_38_3.shareUserId,
			shareCode = arg_38_3.shareCode,
			nickName = arg_38_3.nickName,
			portrait = arg_38_3.portrait,
			useCount = arg_38_3.useCount,
			roomPlanName = arg_38_3.roomPlanName
		}

		if arg_38_0._isVisitCompareInfo then
			var_38_0.isCompareInfo = true
		end

		RoomModel.instance:setVisitParam(var_38_0)
	end

	arg_38_0:_roomXObInfoReply(arg_38_1, arg_38_2, arg_38_3, RoomEnum.GameMode.VisitShare)
end

function var_0_0._roomXObInfoReply(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	if arg_39_2 == 0 then
		RoomHelper.logElapse("获取小屋 ob协议完成")
		RoomModel.instance:setInfoByMode(arg_39_3, arg_39_4)

		arg_39_0._obInfoReady = true

		arg_39_0:_checkInfo()
	else
		arg_39_0:_endEnterRoomBlock()
	end
end

function var_0_0.blockPackageGainPush(arg_40_0, arg_40_1)
	RoomModel.instance:blockPackageGainPush(arg_40_1)

	if arg_40_0:isEditMode() then
		RoomInventoryBlockModel.instance:addBlockPackageList(arg_40_1.blockPackages)
	end
end

function var_0_0.gainSpecialBlockPush(arg_41_0, arg_41_1)
	RoomModel.instance:addSpecialBlockIds(arg_41_1.specialBlocks)

	if arg_41_0:isEditMode() then
		RoomInventoryBlockModel.instance:addSpecialBlockIds(arg_41_1.specialBlocks)
	end
end

function var_0_0.getBlockPackageInfoReply(arg_42_0, arg_42_1)
	RoomModel.instance:setBlockPackageIds(arg_42_1.blockPackageIds)
	RoomModel.instance:setSpecialBlockInfoList(arg_42_1.specialBlocks)
end

function var_0_0.getBuildingInfoReply(arg_43_0, arg_43_1)
	RoomModel.instance:setBuildingInfos(arg_43_1.buildingInfos)
end

function var_0_0.getRoomThemeCollectionBonusReply(arg_44_0, arg_44_1)
	RoomModel.instance:addGetThemeRewardId(arg_44_1.id)
	arg_44_0:dispatchEvent(RoomEvent.UpdateRoomThemeReward, arg_44_1.id)
end

function var_0_0.checkThemeCollerctFullReward(arg_45_0)
	local var_45_0 = RoomModel.instance:findHasGetThemeRewardThemeId()

	if var_45_0 and not ViewMgr.instance:isOpen(ViewName.RoomThemeTipView) then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = MaterialEnum.MaterialType.RoomTheme,
			id = var_45_0
		})
	end
end

function var_0_0._checkInfo(arg_46_0)
	if arg_46_0._editInfoReady and arg_46_0._obInfoReady then
		RoomHelper.logElapse("开始加载小屋场景")
		arg_46_0:_enterScene()
	end
end

function var_0_0._enterScene(arg_47_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		arg_47_0:_switchScene()
		arg_47_0:_endEnterRoomBlock()
	else
		GameSceneMgr.instance:startSceneDefaultLevel(SceneType.Room, RoomEnum.RoomSceneId, arg_47_0._forceStart)
		TaskDispatcher.runDelay(arg_47_0._nextFrameStartPreload, arg_47_0, 0.01)
	end
end

function var_0_0._nextFrameStartPreload(arg_48_0)
	RoomPreloadMgr.instance:startPreload()
	arg_48_0:_endEnterRoomBlock()
end

function var_0_0._switchScene(arg_49_0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingRoomView)
	GameSceneMgr.instance:showLoading(SceneType.Room)
	TaskDispatcher.runDelay(arg_49_0._delaySwitchScene, arg_49_0, 2)
	arg_49_0:dispatchEvent(RoomEvent.SwitchScene)

	local var_49_0 = GameSceneMgr.instance:getCurScene()

	if var_0_0.instance:isObMode() then
		var_49_0.camera:playCameraAnim("in_show")
	elseif var_0_0.instance:isEditMode() then
		var_49_0.camera:playCameraAnim("in_edit")
	end
end

function var_0_0._delaySwitchScene(arg_50_0)
	GameSceneMgr.instance:getScene(SceneType.Room).director:switchMode()
end

function var_0_0.MaterialChangeByRoomProductLine(arg_51_0, arg_51_1)
	local var_51_0 = RoomMapModel.instance:getAllBuildDegree()
	local var_51_1 = RoomConfig.instance:getBuildBonusByBuildDegree(var_51_0) / 10
	local var_51_2 = RoomEnum.Toast.MaterialChangeByRoomProductLine_Base

	if var_51_1 > 0 then
		var_51_2 = RoomEnum.Toast.MaterialChangeByRoomProductLine
	else
		var_51_1 = nil
	end

	for iter_51_0, iter_51_1 in ipairs(arg_51_1) do
		local var_51_3 = ResUrl.getPropItemIcon(iter_51_1.materilId)
		local var_51_4 = ItemModel.instance:getItemConfig(iter_51_1.materilType, iter_51_1.materilId)

		if LangSettings.instance:isEn() then
			ToastController.instance:showToastWithIcon(var_51_2, var_51_3, string.format("%s +%d", var_51_4.name, iter_51_1.quantity), var_51_1)
		else
			ToastController.instance:showToastWithIcon(var_51_2, var_51_3, string.format("%s+%d", var_51_4.name, iter_51_1.quantity), var_51_1)
		end
	end
end

function var_0_0.exitRoom(arg_52_0, arg_52_1)
	if arg_52_0:isEditorMode() then
		GameSceneMgr.instance:closeScene()
		ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
	elseif arg_52_0:isEditMode() then
		local var_52_0 = {
			isFromEditMode = true
		}

		if RoomMapController.instance:isHasConfirmOp() then
			var_52_0.isConfirm = true
		end

		if RoomMapController.instance:isNeedConfirmRoom() then
			var_52_0.isConfirm = true
			var_52_0.isHomeClick = arg_52_1

			RoomMapController.instance:confirmRoom(arg_52_0._confirmRoomCallback, arg_52_0, var_52_0)
		else
			RoomShowBuildingListModel.instance:clearFilterData()
			RoomThemeFilterListModel.instance:clearFilterData()

			if arg_52_1 then
				arg_52_0:leaveRoom()
			else
				arg_52_0:enterRoom(RoomEnum.GameMode.Ob, nil, nil, var_52_0)
			end
		end
	elseif arg_52_1 then
		arg_52_0:leaveRoom()
	elseif arg_52_0:isVisitShareMode() then
		arg_52_0:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, nil, true)
	else
		arg_52_0:leaveRoom()

		if arg_52_0:isVisitMode() then
			JumpController.instance:jump(JumpEnum.JumpView.SocialView)
		end
	end
end

function var_0_0._confirmRoomCallback(arg_53_0, arg_53_1)
	RoomShowBuildingListModel.instance:clearFilterData()

	if arg_53_1.isHomeClick then
		arg_53_0:leaveRoom()
	else
		arg_53_0:enterRoom(RoomEnum.GameMode.Ob, nil, nil, arg_53_1)
	end
end

function var_0_0.isReset(arg_54_0)
	return arg_54_0._isReset
end

function var_0_0.openStoreGoodsTipView(arg_55_0, arg_55_1)
	ViewMgr.instance:openView(ViewName.RoomStoreGoodsTipView, {
		storeGoodsMO = arg_55_1
	})
end

function var_0_0.openThemeFilterView(arg_56_0, arg_56_1, arg_56_2)
	ViewMgr.instance:openView(ViewName.RoomThemeFilterView, {
		isBottom = arg_56_1,
		posX = arg_56_2
	})
end

function var_0_0.popUpRoomBlockPackageView(arg_57_0, arg_57_1)
	if not arg_57_1 then
		return
	end

	arg_57_0:_showPopupViewChange(arg_57_1)
	arg_57_0:_showTipsMaterialChange(arg_57_1)
end

function var_0_0._showPopupViewChange(arg_58_0, arg_58_1)
	local var_58_0 = RoomStoreOrderModel.instance:getMOByList(arg_58_1)
	local var_58_1 = {}
	local var_58_2 = arg_58_1
	local var_58_3 = RoomConfig.instance

	if var_58_0 then
		RoomStoreOrderModel.instance:remove(var_58_0)

		if var_58_0.themeId then
			table.insert(var_58_1, {
				itemType = MaterialEnum.MaterialType.RoomTheme,
				itemId = var_58_0.themeId
			})

			var_58_2 = {}

			for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
				local var_58_4 = var_58_3:getThemeIdByItem(iter_58_1.materilId, iter_58_1.materilType)

				if var_58_0.themeId ~= var_58_4 then
					table.insert(var_58_2, iter_58_1)
				end
			end
		end
	end

	for iter_58_2, iter_58_3 in ipairs(var_58_2) do
		if iter_58_3.materilType == MaterialEnum.MaterialType.BlockPackage then
			local var_58_5 = var_58_3:getBlockPackageConfig(iter_58_3.materilId)

			if var_58_5 and not string.nilorempty(var_58_5.rewardIcon) and arg_58_0:_containRare(CommonConfig.instance:getConstStr(ConstEnum.RoomBlockPackageGetRare), var_58_5.rare) then
				table.insert(var_58_1, {
					itemType = MaterialEnum.MaterialType.BlockPackage,
					itemId = iter_58_3.materilId
				})
			end
		end
	end

	for iter_58_4, iter_58_5 in ipairs(var_58_2) do
		if iter_58_5.materilType == MaterialEnum.MaterialType.Building then
			local var_58_6 = var_58_3:getBuildingConfig(iter_58_5.materilId)

			if var_58_6 and not string.nilorempty(var_58_6.rewardIcon) and arg_58_0:_containRare(CommonConfig.instance:getConstStr(ConstEnum.RoomBuildingGetRare), var_58_6.rare) then
				table.insert(var_58_1, {
					itemType = MaterialEnum.MaterialType.Building,
					itemId = iter_58_5.materilId,
					roomBuildingLevel = iter_58_5.roomBuildingLevel
				})
			end
		end
	end

	if #var_58_1 > 0 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
			itemList = var_58_1
		})
	end
end

function var_0_0._showTipsMaterialChange(arg_59_0, arg_59_1)
	local var_59_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room)

	for iter_59_0 = 1, #arg_59_1 do
		local var_59_1 = arg_59_1[iter_59_0]

		if var_59_0 then
			if var_59_1.materilType == MaterialEnum.MaterialType.SpecialBlock then
				local var_59_2 = RoomConfig.instance:getBlock(var_59_1.materilId)

				if var_59_2 then
					local var_59_3 = RoomConfig.instance:getSpecialBlockConfig(var_59_1.materilId)
					local var_59_4 = RoomConfig.instance:getBlockPackageConfig(var_59_2.packageId)

					ToastController.instance:showToast(RoomEnum.Toast.SpecialBlockGain, var_59_3 and var_59_3.name or var_59_1.materilId, var_59_4 and var_59_4.name or var_59_2.packageId)
				end
			end
		elseif arg_59_0._showChangeNotOpenToastDic and arg_59_0._showChangeNotOpenToastDic[var_59_1.materilType] then
			local var_59_5 = ItemModel.instance:getItemConfig(var_59_1.materilType, var_59_1.materilId)

			ToastController.instance:showToast(arg_59_0._showChangeNotOpenToastDic[var_59_1.materilType], var_59_5 and var_59_5.name or var_59_1.materilId)
		end
	end
end

function var_0_0.showInteractionRewardToast(arg_60_0, arg_60_1)
	if not arg_60_1 then
		return
	end

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		local var_60_0, var_60_1 = ItemModel.instance:getItemConfigAndIcon(iter_60_1.materilType, iter_60_1.materilId)

		if var_60_0 then
			GameFacade.showToastWithIcon(ToastEnum.RoomRewardToast, var_60_1, var_60_0.name, iter_60_1.quantity)
		end
	end
end

function var_0_0.homeClick(arg_61_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	var_0_0.instance:exitRoom(true)
end

function var_0_0._containRare(arg_62_0, arg_62_1, arg_62_2)
	if string.nilorempty(arg_62_1) then
		return false
	end

	local var_62_0 = string.splitToNumber(arg_62_1, "#")

	return tabletool.indexOf(var_62_0, arg_62_2)
end

function var_0_0.popUpSourceView(arg_63_0, arg_63_1)
	local var_63_0 = false
	local var_63_1 = false
	local var_63_2 = false

	for iter_63_0, iter_63_1 in ipairs(arg_63_1) do
		if iter_63_1.viewName == ViewName.RoomInitBuildingView then
			var_63_1 = true
		elseif iter_63_1.viewName == ViewName.RoomFormulaView then
			var_63_0 = true
		elseif iter_63_1.viewName == ViewName.RoomProductLineLevelUpView then
			var_63_2 = true
		end
	end

	for iter_63_2, iter_63_3 in ipairs(arg_63_1) do
		if iter_63_3.viewName == ViewName.RoomInitBuildingView then
			iter_63_3.viewParam = iter_63_3.viewParam or {}
			iter_63_3.viewParam.showFormulaView = var_63_0 and var_63_2 == false

			if var_0_0.instance:isRoomScene() then
				RoomMapController.instance:openRoomInitBuildingView(0, iter_63_3.viewParam)
			else
				RoomMapController.instance:openFormulaItemBuildingViewOutSide()
			end
		elseif iter_63_3.viewName == ViewName.RoomFormulaView and (not var_63_1 or var_63_2) then
			ViewMgr.instance:openView(iter_63_3.viewName, iter_63_3.viewParam)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

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

function var_0_0.checkThemeCollerctFullReward(arg_6_0)
	local var_6_0 = RoomModel.instance:findHasGetThemeRewardThemeId()

	if var_6_0 and not ViewMgr.instance:isOpen(ViewName.RoomThemeTipView) then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = MaterialEnum.MaterialType.RoomTheme,
			id = var_6_0
		})
	end
end

function var_0_0._onOnSwitchModeDone(arg_7_0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function var_0_0.sendInitRoomObInfo(arg_8_0)
	RoomRpc.instance:sendGetRoomObInfoRequest(true, arg_8_0._onInitObInfoReply, arg_8_0)
end

function var_0_0._onInitObInfoReply(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 == 0 and arg_9_3.needBlockData == true then
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
		RoomModel.instance:setObInfo(arg_9_3)
	end
end

function var_0_0.setEditorMode(arg_10_0, arg_10_1)
	arg_10_0._isEditorMode = arg_10_1
end

function var_0_0.isRoomScene(arg_11_0)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.Room
end

function var_0_0.isEditorMode(arg_12_0)
	return arg_12_0._isEditorMode
end

function var_0_0.isEditMode(arg_13_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Edit
end

function var_0_0.isObMode(arg_14_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Ob
end

function var_0_0.isVisitMode(arg_15_0)
	local var_15_0 = RoomModel.instance:getGameMode()

	return var_15_0 == RoomEnum.GameMode.Visit or var_15_0 == RoomEnum.GameMode.VisitShare
end

function var_0_0.isVisitShareMode(arg_16_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.VisitShare
end

function var_0_0.isFishingMode(arg_17_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Fishing
end

function var_0_0.isFishingVisitMode(arg_18_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.FishingVisit
end

function var_0_0.isDebugMode(arg_19_0)
	local var_19_0 = RoomModel.instance:getGameMode()

	return var_19_0 == RoomEnum.GameMode.DebugNormal or var_19_0 == RoomEnum.GameMode.DebugInit or var_19_0 == RoomEnum.GameMode.DebugPackage
end

function var_0_0.isDebugNormalMode(arg_20_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugNormal
end

function var_0_0.isDebugInitMode(arg_21_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugInit
end

function var_0_0.isDebugPackageMode(arg_22_0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugPackage
end

function var_0_0.getDebugParam(arg_23_0)
	return RoomModel.instance:getDebugParam()
end

function var_0_0.getOpenViews(arg_24_0)
	return arg_24_0._openViews
end

function var_0_0.enterRoom(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6, arg_25_7)
	RoomHelper.logStart("开始进入小屋")
	arg_25_0:_startEnterRoomBlock()

	arg_25_0._forceStart = arg_25_6
	arg_25_0._isReset = arg_25_7
	arg_25_0._openViews = {}

	tabletool.addValues(arg_25_0._openViews, arg_25_5)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and var_0_0.instance:isObMode() then
		-- block empty
	end

	RoomModel.instance:setGameMode(arg_25_1)

	if not arg_25_0:isDebugMode() and (RoomLayoutModel.instance:isNeedRpcGet() or arg_25_0:isObMode()) then
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
	end

	local var_25_0 = arg_25_0:_getEnterRoonFuncByGameMode(arg_25_1)

	if var_25_0 then
		var_25_0(arg_25_0, arg_25_2, arg_25_3, arg_25_4)
	else
		logError(string.format("can not find enter room function by gameModel:%s", arg_25_1))
	end
end

var_0_0.ENTER_ROOM_BLOCK_KEY = "RoomController_ENTER_ROOM_BLOCK_KEY"

function var_0_0._startEnterRoomBlock(arg_26_0)
	UIBlockMgr.instance:startBlock(var_0_0.ENTER_ROOM_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_26_0._endEnterRoomBlock, arg_26_0)
	TaskDispatcher.runDelay(arg_26_0._endEnterRoomBlock, arg_26_0, 10)
end

function var_0_0._endEnterRoomBlock(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._endEnterRoomBlock, arg_27_0)
	UIBlockMgr.instance:endBlock(var_0_0.ENTER_ROOM_BLOCK_KEY)
end

function var_0_0._getEnterRoonFuncByGameMode(arg_28_0, arg_28_1)
	if not arg_28_0._enterRoomFuncMap then
		arg_28_0._enterRoomFuncMap = {
			[RoomEnum.GameMode.Ob] = arg_28_0._enterRoomObOrEdit,
			[RoomEnum.GameMode.Edit] = arg_28_0._enterRoomObOrEdit,
			[RoomEnum.GameMode.Visit] = arg_28_0._enterRoomVisit,
			[RoomEnum.GameMode.VisitShare] = arg_28_0._enterRoomVisitShare,
			[RoomEnum.GameMode.DebugNormal] = arg_28_0._enterRoomDebugNormal,
			[RoomEnum.GameMode.DebugInit] = arg_28_0._enterRoomDebugInit,
			[RoomEnum.GameMode.DebugPackage] = arg_28_0._enterRoomDebugPackage,
			[RoomEnum.GameMode.Fishing] = arg_28_0._enterRoomFishing,
			[RoomEnum.GameMode.FishingVisit] = arg_28_0._enterRoomFishingVisit
		}
	end

	return arg_28_0._enterRoomFuncMap[arg_28_1]
end

function var_0_0._enterRoomObOrEdit(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = GameSceneMgr.instance:getCurScene()

	if var_29_0 and var_29_0.fsm then
		local var_29_1 = RoomMapBlockModel.instance:getBackBlockModel()

		if var_29_1 and var_29_1:getCount() > 0 then
			var_29_0.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		end

		if RoomMapBlockModel.instance:getTempBlockMO() then
			var_29_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
		end

		if RoomMapBuildingModel.instance:getTempBuildingMO() then
			var_29_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
		end
	end

	RoomModel.instance:setEnterParam(arg_29_3)

	arg_29_0._editInfoReady = false
	arg_29_0._obInfoReady = false

	local var_29_2 = RoomModel.instance:getGameMode()

	if arg_29_1 or var_29_2 == RoomEnum.GameMode.Ob then
		arg_29_0._editInfoReady = true

		if arg_29_1 then
			RoomModel.instance:setEditInfo(arg_29_1)
		end
	end

	if arg_29_2 then
		arg_29_0._obInfoReady = true

		RoomModel.instance:setObInfo(arg_29_2)
		RoomLayoutController.instance:updateObInfo()
	end

	if not arg_29_0._editInfoReady then
		RoomRpc.instance:sendGetRoomInfoRequest(arg_29_0.getRoomInfoReply, arg_29_0)
	end

	if not arg_29_0._obInfoReady then
		RoomRpc.instance:sendGetRoomObInfoRequest(true, arg_29_0.getRoomObInfoReply, arg_29_0)
	end

	RoomGiftController.instance:getAct159Info()
	ManufactureController.instance:getManufactureServerInfo()
	arg_29_0:_checkInfo()
end

function var_0_0.getRoomInfoReply(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_2 == 0 then
		RoomHelper.logElapse("获取小屋协议完成")
		RoomModel.instance:setEditInfo(arg_30_3)

		arg_30_0._editInfoReady = true

		arg_30_0:_checkInfo()
	else
		arg_30_0:_endEnterRoomBlock()
	end
end

function var_0_0.getRoomObInfoReply(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_0:_roomXObInfoReply(arg_31_1, arg_31_2, arg_31_3, RoomEnum.GameMode.Ob)
end

function var_0_0._enterRoomVisit(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	RoomModel.instance:setVisitParam(arg_32_3)

	arg_32_0._obInfoReady = false
	arg_32_0._editInfoReady = true

	local var_32_0 = arg_32_3.userId

	RoomRpc.instance:sendGetOtherRoomObInfoRequest(var_32_0, arg_32_0.getOtherRoomObInfoReply, arg_32_0)
end

function var_0_0.getOtherRoomObInfoReply(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_2 == 0 and not string.nilorempty(arg_33_3.shareCode) then
		RoomModel.instance:setInfoByMode(arg_33_3, RoomEnum.GameMode.Visit)
		RoomRpc.instance:sendGetRoomShareRequest(arg_33_3.shareCode, arg_33_0._onGetOtherToShareCodeReply, arg_33_0)
	else
		arg_33_0:_roomXObInfoReply(arg_33_1, arg_33_2, arg_33_3, RoomEnum.GameMode.Visit)
	end
end

function var_0_0._onGetOtherToShareCodeReply(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if arg_34_2 == 0 then
		RoomModel.instance:setGameMode(RoomEnum.GameMode.VisitShare)
		arg_34_0:getGetRoomShareReply(arg_34_1, arg_34_2, arg_34_3)
	else
		arg_34_0:_roomXObInfoReply(arg_34_1, 0, RoomModel.instance:getInfoByMode(RoomEnum.GameMode.Visit), RoomEnum.GameMode.Visit)
	end
end

function var_0_0._enterRoomVisitShare(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0._obInfoReady = false
	arg_35_0._editInfoReady = true
	arg_35_0._isVisitCompareInfo = RoomLayoutHelper.checkVisitParamCoppare(arg_35_3)

	if arg_35_2 and arg_35_2.shareCode == arg_35_3.shareCode and arg_35_2.shareUserId == arg_35_3.userId then
		arg_35_0:getGetRoomShareReply(nil, 0, arg_35_2)
	else
		local var_35_0 = arg_35_3.shareCode

		RoomRpc.instance:sendGetRoomShareRequest(var_35_0, arg_35_0.getGetRoomShareReply, arg_35_0)
	end
end

function var_0_0.getGetRoomShareReply(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_2 == 0 then
		local var_36_0 = {
			userId = arg_36_3.shareUserId,
			shareCode = arg_36_3.shareCode,
			nickName = arg_36_3.nickName,
			portrait = arg_36_3.portrait,
			useCount = arg_36_3.useCount,
			roomPlanName = arg_36_3.roomPlanName
		}

		if arg_36_0._isVisitCompareInfo then
			var_36_0.isCompareInfo = true
		end

		RoomModel.instance:setVisitParam(var_36_0)
	end

	arg_36_0:_roomXObInfoReply(arg_36_1, arg_36_2, arg_36_3, RoomEnum.GameMode.VisitShare)
end

function var_0_0._enterRoomDebugNormal(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = RoomDebugController.instance:getDebugMapInfo()

	RoomModel.instance:setEditInfo(var_37_0)
	RoomModel.instance:setObInfo(nil)
	arg_37_0:_enterScene()
end

function var_0_0._enterRoomDebugInit(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	RoomModel.instance:setDebugParam(arg_38_3)
	RoomDebugController.instance:getDebugInitMapInfo(arg_38_3, arg_38_0._onEnterRoomDebugParam, arg_38_0)
end

function var_0_0._enterRoomDebugPackage(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	RoomModel.instance:setDebugParam(arg_39_3)
	RoomDebugController.instance:getDebugPackageMapInfo(arg_39_3, arg_39_0._onEnterRoomDebugParam, arg_39_0)
end

function var_0_0._onEnterRoomDebugParam(arg_40_0, arg_40_1)
	RoomModel.instance:setEditInfo(arg_40_1)
	RoomModel.instance:setObInfo(nil)
	arg_40_0:_enterScene()
end

function var_0_0._enterRoomFishing(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	FishingController.instance:getFishingInfo(nil, arg_41_0._afterGetMyFishingInfo, arg_41_0)
end

function var_0_0._afterGetMyFishingInfo(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	if arg_42_2 ~= 0 then
		arg_42_0:_endEnterRoomBlock()

		return
	end

	arg_42_0:_setFinishingMapInfo()
	arg_42_0:_enterScene()
end

function var_0_0._enterRoomFishingVisit(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = arg_43_3 and arg_43_3.userId

	if not var_43_0 then
		return
	end

	if arg_43_3.hasFishingVisitInfo then
		arg_43_0:_afterGetOtherFishingInfo(nil, 0, nil)
	else
		FishingController.instance:getFishingInfo(var_43_0, arg_43_0._afterGetOtherFishingInfo, arg_43_0)
	end
end

function var_0_0._afterGetOtherFishingInfo(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if arg_44_2 ~= 0 then
		arg_44_0:_endEnterRoomBlock()

		return
	end

	arg_44_0:_setFinishingMapInfo(true)
	arg_44_0:_enterScene()
end

function var_0_0._setFinishingMapInfo(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_1 and RoomEnum.GameMode.FishingVisit or RoomEnum.GameMode.Fishing
	local var_45_1 = FishingConfig.instance:getFishingMapInfo()
	local var_45_2 = var_45_1.mapId
	local var_45_3 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MyPoint, true, "#")
	local var_45_4 = FishingConfig.instance:getMaxBuildingUid(var_45_2) + 1
	local var_45_5 = {
		use = true,
		resAreaDirection = 0,
		rotate = 0,
		mapId = var_45_2,
		uid = var_45_4,
		defineId = FishingEnum.Const.FishingBuilding,
		x = var_45_3[1] or 0,
		y = var_45_3[2] or 0,
		belongUserId = FishingModel.instance:getCurShowingUserId()
	}

	var_45_1.buildingInfos[#var_45_1.buildingInfos + 1] = var_45_5

	local var_45_6 = FishingModel.instance:getFriendBoatInfoList()

	if var_45_6 then
		local var_45_7 = 1
		local var_45_8 = 1
		local var_45_9 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FriendPoint, false, "|")
		local var_45_10 = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.StrangerPoint, false, "|")

		for iter_45_0, iter_45_1 in ipairs(var_45_6) do
			local var_45_11
			local var_45_12 = var_45_4 + 1
			local var_45_13 = iter_45_1.userId

			if iter_45_1.isFriend then
				var_45_11 = var_45_9[var_45_7]
				var_45_7 = var_45_7 + 1
			else
				var_45_11 = var_45_10[var_45_8]
				var_45_8 = var_45_8 + 1
			end

			if not string.nilorempty(var_45_11) then
				local var_45_14 = string.splitToNumber(var_45_11, "#")
				local var_45_15 = {
					use = true,
					resAreaDirection = 0,
					rotate = 0,
					mapId = var_45_2,
					uid = var_45_12,
					defineId = FishingEnum.Const.FishingBuilding,
					x = var_45_14[1] or 0,
					y = var_45_14[2] or 0,
					belongUserId = var_45_13
				}

				var_45_1.buildingInfos[#var_45_1.buildingInfos + 1] = var_45_15
				var_45_4 = var_45_12
			end
		end
	end

	RoomModel.instance:setInfoByMode(var_45_1, var_45_0)
end

function var_0_0._roomXObInfoReply(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	if arg_46_2 == 0 then
		RoomHelper.logElapse("获取小屋 ob协议完成")
		RoomModel.instance:setInfoByMode(arg_46_3, arg_46_4)

		arg_46_0._obInfoReady = true

		arg_46_0:_checkInfo()
	else
		arg_46_0:_endEnterRoomBlock()
	end
end

function var_0_0._checkInfo(arg_47_0)
	if arg_47_0._editInfoReady and arg_47_0._obInfoReady then
		RoomHelper.logElapse("开始加载小屋场景")
		arg_47_0:_enterScene()
	end
end

function var_0_0._enterScene(arg_48_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		arg_48_0:_switchScene()
		arg_48_0:_endEnterRoomBlock()
	else
		GameSceneMgr.instance:startSceneDefaultLevel(SceneType.Room, RoomEnum.RoomSceneId, arg_48_0._forceStart)
		TaskDispatcher.runDelay(arg_48_0._nextFrameStartPreload, arg_48_0, 0.01)
	end
end

function var_0_0._nextFrameStartPreload(arg_49_0)
	RoomPreloadMgr.instance:startPreload()
	arg_49_0:_endEnterRoomBlock()
end

function var_0_0._switchScene(arg_50_0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingRoomView)
	GameSceneMgr.instance:showLoading(SceneType.Room)
	TaskDispatcher.runDelay(arg_50_0._delaySwitchScene, arg_50_0, 2)
	arg_50_0:dispatchEvent(RoomEvent.SwitchScene)

	local var_50_0 = GameSceneMgr.instance:getCurScene()

	if var_0_0.instance:isObMode() then
		var_50_0.camera:playCameraAnim("in_show")
	elseif var_0_0.instance:isEditMode() then
		var_50_0.camera:playCameraAnim("in_edit")
	end
end

function var_0_0._delaySwitchScene(arg_51_0)
	GameSceneMgr.instance:getScene(SceneType.Room).director:switchMode()
end

function var_0_0.leaveRoom(arg_52_0)
	RoomMapController.instance:statRoomEnd()
	MainController.instance:enterMainScene()
end

function var_0_0.blockPackageGainPush(arg_53_0, arg_53_1)
	RoomModel.instance:blockPackageGainPush(arg_53_1)

	if arg_53_0:isEditMode() then
		RoomInventoryBlockModel.instance:addBlockPackageList(arg_53_1.blockPackages)
	end
end

function var_0_0.gainSpecialBlockPush(arg_54_0, arg_54_1)
	RoomModel.instance:addSpecialBlockIds(arg_54_1.specialBlocks)

	if arg_54_0:isEditMode() then
		RoomInventoryBlockModel.instance:addSpecialBlockIds(arg_54_1.specialBlocks)
	end
end

function var_0_0.getBlockPackageInfoReply(arg_55_0, arg_55_1)
	RoomModel.instance:setBlockPackageIds(arg_55_1.blockPackageIds)
	RoomModel.instance:setSpecialBlockInfoList(arg_55_1.specialBlocks)
end

function var_0_0.getBuildingInfoReply(arg_56_0, arg_56_1)
	RoomModel.instance:setBuildingInfos(arg_56_1.buildingInfos)
end

function var_0_0.getRoomThemeCollectionBonusReply(arg_57_0, arg_57_1)
	RoomModel.instance:addGetThemeRewardId(arg_57_1.id)
	arg_57_0:dispatchEvent(RoomEvent.UpdateRoomThemeReward, arg_57_1.id)
end

function var_0_0.MaterialChangeByRoomProductLine(arg_58_0, arg_58_1)
	local var_58_0 = RoomMapModel.instance:getAllBuildDegree()
	local var_58_1 = RoomConfig.instance:getBuildBonusByBuildDegree(var_58_0) / 10
	local var_58_2 = RoomEnum.Toast.MaterialChangeByRoomProductLine_Base

	if var_58_1 > 0 then
		var_58_2 = RoomEnum.Toast.MaterialChangeByRoomProductLine
	else
		var_58_1 = nil
	end

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		local var_58_3 = ResUrl.getPropItemIcon(iter_58_1.materilId)
		local var_58_4 = ItemModel.instance:getItemConfig(iter_58_1.materilType, iter_58_1.materilId)

		if LangSettings.instance:isEn() then
			ToastController.instance:showToastWithIcon(var_58_2, var_58_3, string.format("%s +%d", var_58_4.name, iter_58_1.quantity), var_58_1)
		else
			ToastController.instance:showToastWithIcon(var_58_2, var_58_3, string.format("%s+%d", var_58_4.name, iter_58_1.quantity), var_58_1)
		end
	end
end

function var_0_0.exitRoom(arg_59_0, arg_59_1)
	local var_59_0 = FishingModel.instance:isInFishing()
	local var_59_1 = arg_59_0:isFishingVisitMode()

	if arg_59_0:isEditorMode() then
		GameSceneMgr.instance:closeScene()
		ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
	elseif arg_59_0:isEditMode() then
		local var_59_2 = {
			isFromEditMode = true
		}

		if RoomMapController.instance:isHasConfirmOp() then
			var_59_2.isConfirm = true
		end

		if RoomMapController.instance:isNeedConfirmRoom() then
			var_59_2.isConfirm = true
			var_59_2.isHomeClick = arg_59_1

			RoomMapController.instance:confirmRoom(arg_59_0._confirmRoomCallback, arg_59_0, var_59_2)
		else
			RoomShowBuildingListModel.instance:clearFilterData()
			RoomThemeFilterListModel.instance:clearFilterData()

			if arg_59_1 then
				arg_59_0:leaveRoom()
			else
				arg_59_0:enterRoom(RoomEnum.GameMode.Ob, nil, nil, var_59_2)
			end
		end
	elseif arg_59_1 then
		if var_59_0 then
			local var_59_3 = var_59_1 and StatEnum.RoomFishingResult.ExitFriend or StatEnum.RoomFishingResult.Exit
			local var_59_4 = FishingModel.instance:getCurShowingUserId()

			FishingController.instance:sendExitFishingTrack(var_59_3, var_59_4)
		end

		arg_59_0:leaveRoom()
	elseif arg_59_0:isVisitShareMode() or arg_59_0:isFishingMode() then
		local var_59_5 = PlayerModel.instance:getMyUserId()

		FishingController.instance:sendExitFishingTrack(StatEnum.RoomFishingResult.Exit, var_59_5)
		arg_59_0:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, nil, true)
	elseif var_59_1 then
		FishingController.instance:enterFishingMode(true)
	else
		arg_59_0:leaveRoom()

		if arg_59_0:isVisitMode() then
			JumpController.instance:jump(JumpEnum.JumpView.SocialView)
		end
	end
end

function var_0_0._confirmRoomCallback(arg_60_0, arg_60_1)
	RoomShowBuildingListModel.instance:clearFilterData()

	if arg_60_1.isHomeClick then
		arg_60_0:leaveRoom()
	else
		arg_60_0:enterRoom(RoomEnum.GameMode.Ob, nil, nil, arg_60_1)
	end
end

function var_0_0.isReset(arg_61_0)
	return arg_61_0._isReset
end

function var_0_0.openStoreGoodsTipView(arg_62_0, arg_62_1)
	ViewMgr.instance:openView(ViewName.RoomStoreGoodsTipView, {
		storeGoodsMO = arg_62_1
	})
end

function var_0_0.openThemeFilterView(arg_63_0, arg_63_1, arg_63_2)
	ViewMgr.instance:openView(ViewName.RoomThemeFilterView, {
		isBottom = arg_63_1,
		posX = arg_63_2
	})
end

function var_0_0.popUpRoomBlockPackageView(arg_64_0, arg_64_1)
	if not arg_64_1 then
		return
	end

	arg_64_0:_showPopupViewChange(arg_64_1)
	arg_64_0:_showTipsMaterialChange(arg_64_1)
end

function var_0_0._showPopupViewChange(arg_65_0, arg_65_1)
	local var_65_0 = RoomStoreOrderModel.instance:getMOByList(arg_65_1)
	local var_65_1 = {}
	local var_65_2 = arg_65_1
	local var_65_3 = RoomConfig.instance

	if var_65_0 then
		RoomStoreOrderModel.instance:remove(var_65_0)

		if var_65_0.themeId then
			table.insert(var_65_1, {
				itemType = MaterialEnum.MaterialType.RoomTheme,
				itemId = var_65_0.themeId
			})

			var_65_2 = {}

			for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
				local var_65_4 = var_65_3:getThemeIdByItem(iter_65_1.materilId, iter_65_1.materilType)

				if var_65_0.themeId ~= var_65_4 then
					table.insert(var_65_2, iter_65_1)
				end
			end
		end
	end

	for iter_65_2, iter_65_3 in ipairs(var_65_2) do
		if iter_65_3.materilType == MaterialEnum.MaterialType.BlockPackage then
			local var_65_5 = var_65_3:getBlockPackageConfig(iter_65_3.materilId)

			if var_65_5 and not string.nilorempty(var_65_5.rewardIcon) and arg_65_0:_containRare(CommonConfig.instance:getConstStr(ConstEnum.RoomBlockPackageGetRare), var_65_5.rare) then
				table.insert(var_65_1, {
					itemType = MaterialEnum.MaterialType.BlockPackage,
					itemId = iter_65_3.materilId
				})
			end
		end
	end

	for iter_65_4, iter_65_5 in ipairs(var_65_2) do
		if iter_65_5.materilType == MaterialEnum.MaterialType.Building then
			local var_65_6 = var_65_3:getBuildingConfig(iter_65_5.materilId)

			if var_65_6 and not string.nilorempty(var_65_6.rewardIcon) and arg_65_0:_containRare(CommonConfig.instance:getConstStr(ConstEnum.RoomBuildingGetRare), var_65_6.rare) then
				table.insert(var_65_1, {
					itemType = MaterialEnum.MaterialType.Building,
					itemId = iter_65_5.materilId,
					roomBuildingLevel = iter_65_5.roomBuildingLevel
				})
			end
		end
	end

	if #var_65_1 > 0 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
			itemList = var_65_1
		})
	end
end

function var_0_0._showTipsMaterialChange(arg_66_0, arg_66_1)
	local var_66_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room)

	for iter_66_0 = 1, #arg_66_1 do
		local var_66_1 = arg_66_1[iter_66_0]

		if var_66_0 then
			if var_66_1.materilType == MaterialEnum.MaterialType.SpecialBlock then
				local var_66_2 = RoomConfig.instance:getBlock(var_66_1.materilId)

				if var_66_2 then
					local var_66_3 = RoomConfig.instance:getSpecialBlockConfig(var_66_1.materilId)
					local var_66_4 = RoomConfig.instance:getBlockPackageConfig(var_66_2.packageId)

					ToastController.instance:showToast(RoomEnum.Toast.SpecialBlockGain, var_66_3 and var_66_3.name or var_66_1.materilId, var_66_4 and var_66_4.name or var_66_2.packageId)
				end
			end
		elseif arg_66_0._showChangeNotOpenToastDic and arg_66_0._showChangeNotOpenToastDic[var_66_1.materilType] then
			local var_66_5 = ItemModel.instance:getItemConfig(var_66_1.materilType, var_66_1.materilId)

			ToastController.instance:showToast(arg_66_0._showChangeNotOpenToastDic[var_66_1.materilType], var_66_5 and var_66_5.name or var_66_1.materilId)
		end
	end
end

function var_0_0.showInteractionRewardToast(arg_67_0, arg_67_1)
	if not arg_67_1 then
		return
	end

	for iter_67_0, iter_67_1 in ipairs(arg_67_1) do
		local var_67_0, var_67_1 = ItemModel.instance:getItemConfigAndIcon(iter_67_1.materilType, iter_67_1.materilId)

		if var_67_0 then
			GameFacade.showToastWithIcon(ToastEnum.RoomRewardToast, var_67_1, var_67_0.name, iter_67_1.quantity)
		end
	end
end

function var_0_0.homeClick(arg_68_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	var_0_0.instance:exitRoom(true)
end

function var_0_0._containRare(arg_69_0, arg_69_1, arg_69_2)
	if string.nilorempty(arg_69_1) then
		return false
	end

	local var_69_0 = string.splitToNumber(arg_69_1, "#")

	return tabletool.indexOf(var_69_0, arg_69_2)
end

function var_0_0.popUpSourceView(arg_70_0, arg_70_1)
	local var_70_0 = false
	local var_70_1 = false
	local var_70_2 = false

	for iter_70_0, iter_70_1 in ipairs(arg_70_1) do
		if iter_70_1.viewName == ViewName.RoomInitBuildingView then
			var_70_1 = true
		elseif iter_70_1.viewName == ViewName.RoomFormulaView then
			var_70_0 = true
		elseif iter_70_1.viewName == ViewName.RoomProductLineLevelUpView then
			var_70_2 = true
		end
	end

	for iter_70_2, iter_70_3 in ipairs(arg_70_1) do
		if iter_70_3.viewName == ViewName.RoomInitBuildingView then
			iter_70_3.viewParam = iter_70_3.viewParam or {}
			iter_70_3.viewParam.showFormulaView = var_70_0 and var_70_2 == false

			if var_0_0.instance:isRoomScene() then
				RoomMapController.instance:openRoomInitBuildingView(0, iter_70_3.viewParam)
			else
				RoomMapController.instance:openFormulaItemBuildingViewOutSide()
			end
		elseif iter_70_3.viewName == ViewName.RoomFormulaView and (not var_70_1 or var_70_2) then
			ViewMgr.instance:openView(iter_70_3.viewName, iter_70_3.viewParam)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

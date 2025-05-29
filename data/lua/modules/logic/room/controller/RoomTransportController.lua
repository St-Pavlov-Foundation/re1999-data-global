module("modules.logic.room.controller.RoomTransportController", package.seeall)

local var_0_0 = class("RoomTransportController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0:_removeEvents()
	RoomTransportPathModel.instance:clear()
	RoomMapTransportPathModel.instance:clear()
end

function var_0_0.init(arg_4_0)
	arg_4_0:_addEvents()
end

function var_0_0._addEvents(arg_5_0)
	if arg_5_0._isInitAddEvent then
		return
	end
end

function var_0_0._removeEvents(arg_6_0)
	arg_6_0._isInitAddEvent = false
end

function var_0_0.initPathData(arg_7_0, arg_7_1)
	RoomTransportPathModel.instance:initPath(arg_7_1)
	RoomMapTransportPathModel.instance:initPath(arg_7_1)
	RoomMapTransportPathModel.instance:updateSiteHexPoint()
end

var_0_0.SAME_EDIT_PATH_REQUEST = "RoomTransportController.SAME_EDIT_PATH_REQUEST"

function var_0_0.saveEditPath(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = RoomMapTransportPathModel.instance
	local var_8_3 = RoomTransportPathModel.instance:getTransportPathMOList()

	for iter_8_0, iter_8_1 in ipairs(var_8_3) do
		local var_8_4 = var_8_2:getTransportPathMOBy2Type(iter_8_1.fromType, iter_8_1.toType)

		if var_8_4 and var_8_4:isLinkFinish() then
			var_8_4:updateCritterInfo(iter_8_1)
			var_8_4:updateBuildingInfo(iter_8_1)

			var_8_4.id = iter_8_1.id

			table.insert(var_8_1, var_8_4)
		elseif iter_8_1.id > 0 then
			table.insert(var_8_0, iter_8_1.id)

			local var_8_5 = RoomTransportHelper.fromTo2SiteType(iter_8_1.fromType, iter_8_1.toType)

			RoomTransportHelper.saveQuickLink(var_8_5, false)
		end
	end

	local var_8_6 = var_8_2:getTransportPathMOList()
	local var_8_7 = -1

	for iter_8_2, iter_8_3 in ipairs(var_8_6) do
		if iter_8_3:isLinkFinish() then
			if not tabletool.indexOf(var_8_1, iter_8_3) then
				iter_8_3.critterUid = 0
				iter_8_3.buildingUid = 0
				iter_8_3.buildingId = 0
				iter_8_3.buildingSkinId = 0
				iter_8_3.id = var_8_7
				var_8_7 = var_8_7 - 1

				table.insert(var_8_1, iter_8_3)
			end

			if iter_8_3:getIsEdit() and iter_8_3:getIsQuickLink() ~= nil then
				local var_8_8 = RoomTransportHelper.fromTo2SiteType(iter_8_3.fromType, iter_8_3.toType)

				RoomTransportHelper.saveQuickLink(var_8_8, iter_8_3:getIsQuickLink())
			end
		end
	end

	RoomMapTransportPathModel.instance:setList(var_8_1)

	arg_8_0._savePathDeleteOp = #var_8_0 > 0
	arg_8_0._savePathGeneraterOP = #var_8_1 > 0
	arg_8_0._coutWaitSuccess = 0

	if arg_8_0._savePathGeneraterOP then
		arg_8_0._coutWaitSuccess = arg_8_0._coutWaitSuccess + 1

		RoomRpc.instance:sendGenerateRoadRequest(var_8_1, var_8_0, arg_8_0._onGenerateRoadReply, arg_8_0)
	elseif arg_8_0._savePathDeleteOp then
		arg_8_0._coutWaitSuccess = arg_8_0._coutWaitSuccess + 1

		RoomRpc.instance:sendDeleteRoadRequest(var_8_0, arg_8_0._onDeleteRoadReply, arg_8_0)
	end

	if arg_8_0._savePathGeneraterOP or arg_8_0._savePathDeleteOp then
		RoomModel.instance:setEditFlag()
	end

	arg_8_0:waitRefreshPathLineChanged()
	arg_8_0:updateBlockUseState()
end

function var_0_0._onDeleteRoadReply(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0._savePathDeleteOp = false

	if arg_9_2 == 0 then
		arg_9_0._coutWaitSuccess = arg_9_0._coutWaitSuccess - 1

		RoomTransportPathModel.instance:removeByIds(arg_9_3.ids)
		RoomMapTransportPathModel.instance:removeByIds(arg_9_3.ids)
	end

	arg_9_0:_checkSaveEditPath()
end

function var_0_0._onGenerateRoadReply(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._savePathGeneraterOP = false

	if arg_10_2 == 0 then
		arg_10_0._coutWaitSuccess = arg_10_0._coutWaitSuccess - 1

		local var_10_0 = arg_10_3.validRoadInfos

		RoomTransportPathModel.instance:removeByIds(arg_10_3.ids)
		RoomMapTransportPathModel.instance:removeByIds(arg_10_3.ids)
		RoomTransportPathModel.instance:initPath(var_10_0)
		RoomMapTransportPathModel.instance:initPath(var_10_0)
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
	end

	arg_10_0:_checkSaveEditPath()
end

function var_0_0.deleteRoadReply(arg_11_0, arg_11_1)
	arg_11_0:deleteRoadByIds(arg_11_1.ids)
end

function var_0_0.deleteRoadByIds(arg_12_0, arg_12_1)
	if not arg_12_1 or #arg_12_1 < 1 then
		return
	end

	RoomTransportPathModel.instance:removeByIds(arg_12_1)
	RoomMapTransportPathModel.instance:removeByIds(arg_12_1)
	RoomMapTransportPathModel.instance:updateSiteHexPoint()
	arg_12_0:updateBlockUseState()
end

function var_0_0.allotCritterReply(arg_13_0, arg_13_1)
	local var_13_0 = {
		critterUid = arg_13_1.critterUid
	}
	local var_13_1 = arg_13_0:isTransportWorkingById(arg_13_1.id)
	local var_13_2
	local var_13_3 = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		if iter_13_1.id ~= arg_13_1.id and iter_13_1.critterUid == arg_13_1.critterUid then
			var_13_2 = var_13_2 or {}

			table.insert(var_13_2, iter_13_1)
		end
	end

	if var_13_2 then
		local var_13_4 = {
			critterUid = 0
		}

		for iter_13_2, iter_13_3 in ipairs(var_13_2) do
			RoomTransportPathModel.instance:updateInofoById(iter_13_3.id, var_13_4)
			RoomMapTransportPathModel.instance:updateInofoById(iter_13_3.id, var_13_4)
		end
	end

	RoomTransportPathModel.instance:updateInofoById(arg_13_1.id, var_13_0)
	RoomMapTransportPathModel.instance:updateInofoById(arg_13_1.id, var_13_0)

	if not var_13_1 and arg_13_0:isTransportWorkingById(arg_13_1.id) then
		GameFacade.showToast(ToastEnum.RoomTransportStartMove)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TransportCritterChanged)
end

function var_0_0.isTransportWorkingById(arg_14_0, arg_14_1)
	local var_14_0 = RoomMapTransportPathModel.instance:getTransportPathMO(arg_14_1)

	if var_14_0 and var_14_0.critterUid and var_14_0.critterUid ~= 0 and (RoomBuildingAreaHelper.isHasWorkingByType(var_14_0.fromType) or RoomBuildingAreaHelper.isHasWorkingByType(var_14_0.toType)) then
		return true
	end

	return false
end

function var_0_0.batchCritterReply(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = RoomTransportHelper.serverRoadInfo2Info(iter_15_1)

		RoomTransportPathModel.instance:updateInofoById(var_15_0.id, var_15_0)
		RoomMapTransportPathModel.instance:updateInofoById(var_15_0.id, var_15_0)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TransportCritterChanged)
end

function var_0_0.allotVehicleReply(arg_16_0, arg_16_1)
	local var_16_0 = {
		buildingUid = arg_16_1.buildingUid,
		buildingId = arg_16_1.buildingDefineId,
		buildingDefineId = arg_16_1.buildingDefineId,
		buildingSkinId = arg_16_1.skinId
	}
	local var_16_1 = RoomMapTransportPathModel.instance:getTransportPathMO(arg_16_1.id)

	RoomTransportPathModel.instance:updateInofoById(arg_16_1.id, var_16_0)
	RoomMapTransportPathModel.instance:updateInofoById(arg_16_1.id, var_16_0)

	if var_16_1 then
		arg_16_0:_updateVehicle(var_16_1)
	end

	GameFacade.showToast(ToastEnum.RoomTransportSkinChange)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportBuildingChanged)
end

function var_0_0._updateVehicle(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	local var_17_0 = RoomCameraController.instance:getRoomScene()

	if not var_17_0 then
		return
	end

	local var_17_1 = RoomTransportHelper.fromTo2SiteType(arg_17_1.fromType, arg_17_1.toType)
	local var_17_2 = RoomTransportHelper.getVehicleCfgByBuildingId(arg_17_1.buildingId, arg_17_1.buildingSkinId)

	if var_17_2 then
		local var_17_3 = RoomMapVehicleModel.instance:getVehicleMOBySiteType(var_17_1)

		if not var_17_3 then
			var_17_3 = RoomMapVehicleModel.instance:createVehicleMOBySiteType(var_17_1)

			if var_17_3 then
				RoomMapVehicleModel.instance:addAtLast(var_17_3)
			end
		end

		if var_17_3 then
			var_17_3.config = var_17_2
			var_17_3.vehicleId = var_17_2.id

			local var_17_4 = var_17_0.vehiclemgr:getVehicleEntity(var_17_3.id)

			if var_17_4 then
				var_17_4:refreshReplaceType()
				var_17_4:refreshVehicle()
			else
				var_17_0.vehiclemgr:spawnMapVehicle(var_17_3)
			end
		end
	else
		local var_17_5 = RoomMapVehicleModel.instance:getVehicleIdBySiteType(var_17_1)
		local var_17_6 = var_17_0.vehiclemgr:getVehicleEntity(var_17_5)

		if var_17_6 then
			var_17_0.vehiclemgr:destroyVehicle(var_17_6)
		end

		local var_17_7 = RoomMapVehicleModel.instance:getVehicleMOBySiteType(var_17_1)

		if var_17_7 then
			RoomMapVehicleModel.instance:remove(var_17_7)
		end
	end
end

function var_0_0._checkSaveEditPath(arg_18_0)
	if not arg_18_0._savePathDeleteOp and not arg_18_0._savePathGeneraterOP then
		UIBlockMgr.instance:endBlock(var_0_0.SAME_EDIT_PATH_REQUEST)

		if arg_18_0._coutWaitSuccess and arg_18_0._coutWaitSuccess < 1 then
			ViewMgr.instance:closeView(ViewName.RoomTransportPathView)
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanSave)
		end

		arg_18_0:waitRefreshPathLineChanged()
	end
end

function var_0_0.updateBlockUseState(arg_19_0)
	local var_19_0 = RoomMapTransportPathModel.instance:getTransportPathMOList()
	local var_19_1 = RoomMapBlockModel.instance
	local var_19_2 = {}
	local var_19_3 = {}
	local var_19_4 = RoomBlockEnum.UseState.TransportPath

	for iter_19_0 = 1, #var_19_0 do
		local var_19_5 = var_19_0[iter_19_0]
		local var_19_6 = var_19_5:getHexPointList()

		for iter_19_1, iter_19_2 in ipairs(var_19_6) do
			local var_19_7 = var_19_1:getBlockMO(iter_19_2.x, iter_19_2.y)

			if var_19_7 then
				var_19_2[var_19_7.id] = true
				var_19_3[var_19_7.id] = var_19_5.blockCleanType
			end
		end
	end

	local var_19_8 = var_19_1:getFullBlockMOList()

	for iter_19_3, iter_19_4 in ipairs(var_19_8) do
		local var_19_9 = iter_19_4.id
		local var_19_10 = iter_19_4:getUseState()
		local var_19_11 = iter_19_4:getCleanType()

		if var_19_2[var_19_9] then
			local var_19_12 = var_19_3[iter_19_4.id]

			if var_19_10 ~= var_19_4 or var_19_12 ~= var_19_11 then
				iter_19_4:setUseState(var_19_4)
				iter_19_4:setCleanType(var_19_12)
				arg_19_0:waitRefreshBlockById(var_19_9)
			end
		elseif var_19_10 == var_19_4 or var_19_11 ~= RoomBlockEnum.UseState.Normal then
			iter_19_4:setUseState(nil)
			iter_19_4:setCleanType(nil)
			arg_19_0:waitRefreshBlockById(var_19_9)
		end
	end

	arg_19_0:waitRefreshPathLineChanged()
end

function var_0_0.tweenCameraFocusSite(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._tweenCameraFocusSiteParams = nil

	local var_20_0 = GameSceneMgr.instance:getCurScene()
	local var_20_1 = RoomMapVehicleModel.instance:getVehicleMOBySiteType(arg_20_1)

	if var_20_1 then
		arg_20_2 = arg_20_2 == true

		local var_20_2 = var_20_0.vehiclemgr:getVehicleEntity(var_20_1.id)

		var_20_0.cameraFollow:setFollowTarget(var_20_2 and var_20_2.cameraFollowTargetComp, arg_20_2)

		if var_20_2 then
			local var_20_3 = var_20_1.config
			local var_20_4 = RoomEnum.CameraState.ThirdPerson
			local var_20_5 = var_20_3 and var_20_3.thirdCameraId

			if arg_20_2 then
				var_20_5 = var_20_3 and var_20_3.firstCameraId
				var_20_4 = RoomEnum.CameraState.FirstPerson
			end

			var_20_2.cameraFollowTargetComp:setFollowGOPath(arg_20_2 and RoomEnum.EntityChildKey.FirstPersonCameraGOKey or RoomEnum.EntityChildKey.ThirdPersonCameraGOKey)

			local var_20_6, var_20_7, var_20_8 = var_20_2.cameraFollowTargetComp:getPositionXYZ()

			var_20_0.cameraFollow:setIsPass(true, var_20_7)

			local var_20_9 = {
				focusX = var_20_6,
				focusY = var_20_8
			}

			var_20_0.cameraFollow._offsetY = var_20_7

			if arg_20_2 then
				local var_20_10, var_20_11, var_20_12 = var_20_2.cameraFollowTargetComp:getRotateXYZ()

				var_20_9.rotate = RoomRotateHelper.getMod(var_20_11, 360) * Mathf.Deg2Rad
			end

			var_20_0.camera:setChangeCameraParamsById(var_20_4, var_20_5)
			var_20_0.camera:switchCameraState(var_20_4, var_20_9, nil, arg_20_0._onTweenCameraFocusSiteFinsh, arg_20_0)

			arg_20_0._tweenCameraFocusSiteParams = true

			var_20_0.fovblock:setLookVehicleUid(var_20_4, var_20_1.id)
		end

		return
	end

	local var_20_13 = RoomMapTransportPathModel.instance:getSiteHexPointByType(arg_20_1)

	if var_20_13 then
		var_20_0.cameraFollow:setFollowTarget(nil)

		local var_20_14, var_20_15 = HexMath.hexXYToPosXY(var_20_13.x, var_20_13.y, RoomBlockEnum.BlockSize)

		var_20_0.camera:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = var_20_14,
			focusY = var_20_15
		})
	end
end

function var_0_0._onTweenCameraFocusSiteFinsh(arg_21_0)
	if arg_21_0._tweenCameraFocusSiteParams then
		arg_21_0._tweenCameraFocusSiteParams = nil

		local var_21_0 = RoomCameraController.instance:getRoomScene()

		if var_21_0 then
			var_21_0.cameraFollow:setIsPass(false)
		end
	end
end

function var_0_0.openTransportSiteView(arg_22_0, arg_22_1, arg_22_2)
	arg_22_1 = arg_22_0:_findLinkPathSiteType(arg_22_1)

	if arg_22_1 then
		RoomCameraController.instance:saveCameraStateByKey(ViewName.RoomTransportSiteView, arg_22_2)

		local var_22_0 = false

		arg_22_0:tweenCameraFocusSite(arg_22_1, var_22_0)
		ViewMgr.instance:openView(ViewName.RoomTransportSiteView, {
			siteType = arg_22_1,
			isFirstPerson = var_22_0
		})
	end
end

function var_0_0._findLinkPathSiteType(arg_23_0, arg_23_1)
	local var_23_0, var_23_1 = RoomTransportHelper.getSiteFromToByType(arg_23_1)

	if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_23_0, var_23_1) then
		return arg_23_1
	end

	local var_23_2 = RoomTransportHelper.getSiteBuildingTypeList()

	for iter_23_0, iter_23_1 in ipairs(var_23_2) do
		local var_23_3, var_23_4 = RoomTransportHelper.getSiteFromToByType(iter_23_1)

		if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_23_3, var_23_4) and (var_23_3 == arg_23_1 or var_23_4 == arg_23_1) then
			return iter_23_1
		end
	end
end

function var_0_0.openTransportPathView(arg_24_0)
	if RoomMapBuildingAreaModel.instance:getCount() < 2 then
		GameFacade.showToast(ToastEnum.RoomTranspathUnableEdite)

		return
	end

	RoomMapTransportPathModel.instance:setIsRemoveBuilding(false)
	ViewMgr.instance:openView(ViewName.RoomTransportPathView)
end

function var_0_0.isTransportPathShow(arg_25_0)
	return ViewMgr.instance:isOpen(ViewName.RoomTransportPathView)
end

function var_0_0.isTransportSitShow(arg_26_0)
	return ViewMgr.instance:isOpen(ViewName.RoomTransportSiteView)
end

function var_0_0.addConstEvents(arg_27_0)
	return
end

function var_0_0.waitRefreshBlockById(arg_28_0, arg_28_1)
	arg_28_0._waitingBlockIdList = arg_28_0._waitingBlockIdList or {}

	if arg_28_1 and not tabletool.indexOf(arg_28_0._waitingBlockIdList, arg_28_1) then
		table.insert(arg_28_0._waitingBlockIdList, arg_28_1)
		arg_28_0:_startWaitRunRefreshTask()
	end
end

function var_0_0.waitRefreshPathLineChanged(arg_29_0)
	arg_29_0._transportPathLineChanged = true

	arg_29_0:_startWaitRunRefreshTask()
end

function var_0_0._refreshBlockByIds(arg_30_0, arg_30_1)
	if arg_30_1 and #arg_30_1 > 0 then
		local var_30_0 = {}

		for iter_30_0 = 1, #arg_30_1 do
			local var_30_1 = arg_30_1[iter_30_0]
			local var_30_2 = RoomMapBlockModel.instance:getFullBlockMOById(var_30_1)

			if var_30_2 and var_30_2:isInMap() then
				local var_30_3 = GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(var_30_2.id, SceneTag.RoomMapBlock)

				if var_30_3 and not tabletool.indexOf(var_30_0, var_30_3) then
					table.insert(var_30_0, var_30_3)
				end

				local var_30_4 = RoomBlockHelper.getNearBlockEntity(false, var_30_2.hexPoint, 1, false, true)

				for iter_30_1, iter_30_2 in ipairs(var_30_4) do
					if iter_30_2 and not tabletool.indexOf(var_30_0, iter_30_2) then
						table.insert(var_30_0, iter_30_2)
					end
				end
			end
		end

		RoomBlockHelper.refreshBlockResourceType(var_30_0)
		RoomBlockHelper.refreshBlockEntity(var_30_0, "refreshLand")
	end
end

function var_0_0._startWaitRunRefreshTask(arg_31_0)
	if not arg_31_0._hasWaitRunRefreshTask then
		arg_31_0._hasWaitRunRefreshTask = true

		TaskDispatcher.runDelay(arg_31_0._onWaitRunRefreshTask, arg_31_0, 0.001)
	end
end

function var_0_0._onWaitRunRefreshTask(arg_32_0)
	arg_32_0._hasWaitRunRefreshTask = false

	if arg_32_0._waitingBlockIdList and #arg_32_0._waitingBlockIdList > 0 then
		local var_32_0 = arg_32_0._waitingBlockIdList

		arg_32_0._waitingBlockIdList = {}

		arg_32_0:_refreshBlockByIds(var_32_0)

		arg_32_0._transportPathLineChanged = true
	end

	if arg_32_0._transportPathLineChanged then
		arg_32_0._transportPathLineChanged = false

		RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathLineChanged)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

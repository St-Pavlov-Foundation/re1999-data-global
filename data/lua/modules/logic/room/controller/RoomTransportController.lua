module("modules.logic.room.controller.RoomTransportController", package.seeall)

slot0 = class("RoomTransportController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0:_removeEvents()
	RoomTransportPathModel.instance:clear()
	RoomMapTransportPathModel.instance:clear()
end

function slot0.init(slot0)
	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	if slot0._isInitAddEvent then
		return
	end
end

function slot0._removeEvents(slot0)
	slot0._isInitAddEvent = false
end

function slot0.initPathData(slot0, slot1)
	RoomTransportPathModel.instance:initPath(slot1)
	RoomMapTransportPathModel.instance:initPath(slot1)
	RoomMapTransportPathModel.instance:updateSiteHexPoint()
end

slot0.SAME_EDIT_PATH_REQUEST = "RoomTransportController.SAME_EDIT_PATH_REQUEST"

function slot0.saveEditPath(slot0)
	slot1 = {}
	slot3 = RoomMapTransportPathModel.instance

	for slot9, slot10 in ipairs(RoomTransportPathModel.instance:getTransportPathMOList()) do
		if slot3:getTransportPathMOBy2Type(slot10.fromType, slot10.toType) and slot11:isLinkFinish() then
			slot11:updateCritterInfo(slot10)
			slot11:updateBuildingInfo(slot10)

			slot11.id = slot10.id

			table.insert({}, slot11)
		elseif slot10.id > 0 then
			table.insert(slot1, slot10.id)
			RoomTransportHelper.saveQuickLink(RoomTransportHelper.fromTo2SiteType(slot10.fromType, slot10.toType), false)
		end
	end

	slot7 = -1

	for slot11, slot12 in ipairs(slot3:getTransportPathMOList()) do
		if slot12:isLinkFinish() then
			if not tabletool.indexOf(slot2, slot12) then
				slot12.critterUid = 0
				slot12.buildingUid = 0
				slot12.buildingId = 0
				slot12.buildingSkinId = 0
				slot12.id = slot7
				slot7 = slot7 - 1

				table.insert(slot2, slot12)
			end

			if slot12:getIsEdit() and slot12:getIsQuickLink() ~= nil then
				RoomTransportHelper.saveQuickLink(RoomTransportHelper.fromTo2SiteType(slot12.fromType, slot12.toType), slot12:getIsQuickLink())
			end
		end
	end

	RoomMapTransportPathModel.instance:setList(slot2)

	slot0._savePathDeleteOp = #slot1 > 0
	slot0._savePathGeneraterOP = #slot2 > 0
	slot0._coutWaitSuccess = 0

	if slot0._savePathGeneraterOP then
		slot0._coutWaitSuccess = slot0._coutWaitSuccess + 1

		RoomRpc.instance:sendGenerateRoadRequest(slot2, slot1, slot0._onGenerateRoadReply, slot0)
	elseif slot0._savePathDeleteOp then
		slot0._coutWaitSuccess = slot0._coutWaitSuccess + 1

		RoomRpc.instance:sendDeleteRoadRequest(slot1, slot0._onDeleteRoadReply, slot0)
	end

	if slot0._savePathGeneraterOP or slot0._savePathDeleteOp then
		RoomModel.instance:setEditFlag()
	end

	slot0:waitRefreshPathLineChanged()
	slot0:updateBlockUseState()
end

function slot0._onDeleteRoadReply(slot0, slot1, slot2, slot3)
	slot0._savePathDeleteOp = false

	if slot2 == 0 then
		slot0._coutWaitSuccess = slot0._coutWaitSuccess - 1

		RoomTransportPathModel.instance:removeByIds(slot3.ids)
		RoomMapTransportPathModel.instance:removeByIds(slot3.ids)
	end

	slot0:_checkSaveEditPath()
end

function slot0._onGenerateRoadReply(slot0, slot1, slot2, slot3)
	slot0._savePathGeneraterOP = false

	if slot2 == 0 then
		slot0._coutWaitSuccess = slot0._coutWaitSuccess - 1
		slot4 = slot3.validRoadInfos

		RoomTransportPathModel.instance:removeByIds(slot3.ids)
		RoomMapTransportPathModel.instance:removeByIds(slot3.ids)
		RoomTransportPathModel.instance:initPath(slot4)
		RoomMapTransportPathModel.instance:initPath(slot4)
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
	end

	slot0:_checkSaveEditPath()
end

function slot0.deleteRoadReply(slot0, slot1)
	slot0:deleteRoadByIds(slot1.ids)
end

function slot0.deleteRoadByIds(slot0, slot1)
	if not slot1 or #slot1 < 1 then
		return
	end

	RoomTransportPathModel.instance:removeByIds(slot1)
	RoomMapTransportPathModel.instance:removeByIds(slot1)
	RoomMapTransportPathModel.instance:updateSiteHexPoint()
	slot0:updateBlockUseState()
end

function slot0.allotCritterReply(slot0, slot1)
	slot2 = {
		critterUid = slot1.critterUid
	}
	slot3 = slot0:isTransportWorkingById(slot1.id)
	slot4 = nil

	for slot9, slot10 in ipairs(RoomMapTransportPathModel.instance:getTransportPathMOList()) do
		if slot10.id ~= slot1.id and slot10.critterUid == slot1.critterUid then
			table.insert(slot4 or {}, slot10)
		end
	end

	if slot4 then
		slot6 = {
			critterUid = 0
		}

		for slot10, slot11 in ipairs(slot4) do
			RoomTransportPathModel.instance:updateInofoById(slot11.id, slot6)
			RoomMapTransportPathModel.instance:updateInofoById(slot11.id, slot6)
		end
	end

	RoomTransportPathModel.instance:updateInofoById(slot1.id, slot2)
	RoomMapTransportPathModel.instance:updateInofoById(slot1.id, slot2)

	if not slot3 and slot0:isTransportWorkingById(slot1.id) then
		GameFacade.showToast(ToastEnum.RoomTransportStartMove)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TransportCritterChanged)
end

function slot0.isTransportWorkingById(slot0, slot1)
	if RoomMapTransportPathModel.instance:getTransportPathMO(slot1) and slot2.critterUid and slot2.critterUid ~= 0 and (RoomBuildingAreaHelper.isHasWorkingByType(slot2.fromType) or RoomBuildingAreaHelper.isHasWorkingByType(slot2.toType)) then
		return true
	end

	return false
end

function slot0.batchCritterReply(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = RoomTransportHelper.serverRoadInfo2Info(slot6)

		RoomTransportPathModel.instance:updateInofoById(slot7.id, slot7)
		RoomMapTransportPathModel.instance:updateInofoById(slot7.id, slot7)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TransportCritterChanged)
end

function slot0.allotVehicleReply(slot0, slot1)
	slot2 = {
		buildingUid = slot1.buildingUid,
		buildingId = slot1.buildingDefineId,
		buildingDefineId = slot1.buildingDefineId,
		buildingSkinId = slot1.skinId
	}

	RoomTransportPathModel.instance:updateInofoById(slot1.id, slot2)
	RoomMapTransportPathModel.instance:updateInofoById(slot1.id, slot2)

	if RoomMapTransportPathModel.instance:getTransportPathMO(slot1.id) then
		slot0:_updateVehicle(slot3)
	end

	GameFacade.showToast(ToastEnum.RoomTransportSkinChange)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportBuildingChanged)
end

function slot0._updateVehicle(slot0, slot1)
	if not slot1 then
		return
	end

	if not RoomCameraController.instance:getRoomScene() then
		return
	end

	slot3 = RoomTransportHelper.fromTo2SiteType(slot1.fromType, slot1.toType)

	if RoomTransportHelper.getVehicleCfgByBuildingId(slot1.buildingId, slot1.buildingSkinId) then
		if not RoomMapVehicleModel.instance:getVehicleMOBySiteType(slot3) and RoomMapVehicleModel.instance:createVehicleMOBySiteType(slot3) then
			RoomMapVehicleModel.instance:addAtLast(slot5)
		end

		if slot5 then
			slot5.config = slot4
			slot5.vehicleId = slot4.id

			if slot2.vehiclemgr:getVehicleEntity(slot5.id) then
				slot6:refreshReplaceType()
				slot6:refreshVehicle()
			else
				slot2.vehiclemgr:spawnMapVehicle(slot5)
			end
		end
	else
		if slot2.vehiclemgr:getVehicleEntity(RoomMapVehicleModel.instance:getVehicleIdBySiteType(slot3)) then
			slot2.vehiclemgr:destroyVehicle(slot6)
		end

		if RoomMapVehicleModel.instance:getVehicleMOBySiteType(slot3) then
			RoomMapVehicleModel.instance:remove(slot7)
		end
	end
end

function slot0._checkSaveEditPath(slot0)
	if not slot0._savePathDeleteOp and not slot0._savePathGeneraterOP then
		UIBlockMgr.instance:endBlock(uv0.SAME_EDIT_PATH_REQUEST)

		if slot0._coutWaitSuccess and slot0._coutWaitSuccess < 1 then
			ViewMgr.instance:closeView(ViewName.RoomTransportPathView)
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanSave)
		end

		slot0:waitRefreshPathLineChanged()
	end
end

function slot0.updateBlockUseState(slot0)
	slot2 = RoomMapBlockModel.instance
	slot3 = {}
	slot4 = {}
	slot5 = RoomBlockEnum.UseState.TransportPath

	for slot9 = 1, #RoomMapTransportPathModel.instance:getTransportPathMOList() do
		for slot15, slot16 in ipairs(slot1[slot9]:getHexPointList()) do
			if slot2:getBlockMO(slot16.x, slot16.y) then
				slot3[slot17.id] = true
				slot4[slot17.id] = slot10.blockCleanType
			end
		end
	end

	for slot10, slot11 in ipairs(slot2:getFullBlockMOList()) do
		if slot3[slot11.id] then
			slot15 = slot4[slot11.id]

			if slot11:getUseState() ~= slot5 or slot15 ~= slot11:getCleanType() then
				slot11:setUseState(slot5)
				slot11:setCleanType(slot15)
				slot0:waitRefreshBlockById(slot12)
			end
		elseif slot13 == slot5 or slot14 ~= RoomBlockEnum.UseState.Normal then
			slot11:setUseState(nil)
			slot11:setCleanType(nil)
			slot0:waitRefreshBlockById(slot12)
		end
	end

	slot0:waitRefreshPathLineChanged()
end

function slot0.tweenCameraFocusSite(slot0, slot1, slot2)
	slot0._tweenCameraFocusSiteParams = nil
	slot3 = GameSceneMgr.instance:getCurScene()

	if RoomMapVehicleModel.instance:getVehicleMOBySiteType(slot1) then
		slot3.cameraFollow:setFollowTarget(slot3.vehiclemgr:getVehicleEntity(slot4.id) and slot5.cameraFollowTargetComp, slot2 == true)

		if slot5 then
			slot7 = RoomEnum.CameraState.ThirdPerson
			slot8 = slot4.config and slot6.thirdCameraId

			if slot2 then
				slot8 = slot6 and slot6.firstCameraId
				slot7 = RoomEnum.CameraState.FirstPerson
			end

			slot5.cameraFollowTargetComp:setFollowGOPath(slot2 and RoomEnum.EntityChildKey.FirstPersonCameraGOKey or RoomEnum.EntityChildKey.ThirdPersonCameraGOKey)

			slot9, slot10, slot11 = slot5.cameraFollowTargetComp:getPositionXYZ()

			slot3.cameraFollow:setIsPass(true, slot10)

			slot3.cameraFollow._offsetY = slot10

			if slot2 then
				slot13, slot14, slot15 = slot5.cameraFollowTargetComp:getRotateXYZ()
			end

			slot3.camera:setChangeCameraParamsById(slot7, slot8)
			slot3.camera:switchCameraState(slot7, {
				focusX = slot9,
				focusY = slot11,
				rotate = RoomRotateHelper.getMod(slot14, 360) * Mathf.Deg2Rad
			}, nil, slot0._onTweenCameraFocusSiteFinsh, slot0)

			slot0._tweenCameraFocusSiteParams = true

			slot3.fovblock:setLookVehicleUid(slot7, slot4.id)
		end

		return
	end

	if RoomMapTransportPathModel.instance:getSiteHexPointByType(slot1) then
		slot3.cameraFollow:setFollowTarget(nil)

		slot6, slot7 = HexMath.hexXYToPosXY(slot5.x, slot5.y, RoomBlockEnum.BlockSize)

		slot3.camera:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = slot6,
			focusY = slot7
		})
	end
end

function slot0._onTweenCameraFocusSiteFinsh(slot0)
	if slot0._tweenCameraFocusSiteParams then
		slot0._tweenCameraFocusSiteParams = nil

		if RoomCameraController.instance:getRoomScene() then
			slot1.cameraFollow:setIsPass(false)
		end
	end
end

function slot0.openTransportSiteView(slot0, slot1, slot2)
	if slot0:_findLinkPathSiteType(slot1) then
		RoomCameraController.instance:saveCameraStateByKey(ViewName.RoomTransportSiteView, slot2)

		slot3 = false

		slot0:tweenCameraFocusSite(slot1, slot3)
		ViewMgr.instance:openView(ViewName.RoomTransportSiteView, {
			siteType = slot1,
			isFirstPerson = slot3
		})
	end
end

function slot0._findLinkPathSiteType(slot0, slot1)
	slot2, slot3 = RoomTransportHelper.getSiteFromToByType(slot1)

	if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot2, slot3) then
		return slot1
	end

	for slot9, slot10 in ipairs(RoomTransportHelper.getSiteBuildingTypeList()) do
		slot11, slot12 = RoomTransportHelper.getSiteFromToByType(slot10)

		if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot11, slot12) and (slot11 == slot1 or slot12 == slot1) then
			return slot10
		end
	end
end

function slot0.openTransportPathView(slot0)
	if RoomMapBuildingAreaModel.instance:getCount() < 2 then
		GameFacade.showToast(ToastEnum.RoomTranspathUnableEdite)

		return
	end

	RoomMapTransportPathModel.instance:setIsRemoveBuilding(false)
	ViewMgr.instance:openView(ViewName.RoomTransportPathView)
end

function slot0.isTransportPathShow(slot0)
	return ViewMgr.instance:isOpen(ViewName.RoomTransportPathView)
end

function slot0.isTransportSitShow(slot0)
	return ViewMgr.instance:isOpen(ViewName.RoomTransportSiteView)
end

function slot0.addConstEvents(slot0)
end

function slot0.waitRefreshBlockById(slot0, slot1)
	slot0._waitingBlockIdList = slot0._waitingBlockIdList or {}

	if slot1 and not tabletool.indexOf(slot0._waitingBlockIdList, slot1) then
		table.insert(slot0._waitingBlockIdList, slot1)
		slot0:_startWaitRunRefreshTask()
	end
end

function slot0.waitRefreshPathLineChanged(slot0)
	slot0._transportPathLineChanged = true

	slot0:_startWaitRunRefreshTask()
end

function slot0._refreshBlockByIds(slot0, slot1)
	if slot1 and #slot1 > 0 then
		slot2 = {}

		for slot6 = 1, #slot1 do
			if RoomMapBlockModel.instance:getFullBlockMOById(slot1[slot6]) and slot8:isInMap() then
				if GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(slot8.id, SceneTag.RoomMapBlock) and not tabletool.indexOf(slot2, slot10) then
					table.insert(slot2, slot10)
				end

				slot15 = 1
				slot16 = false

				for slot15, slot16 in ipairs(RoomBlockHelper.getNearBlockEntity(false, slot8.hexPoint, slot15, slot16, true)) do
					if slot16 and not tabletool.indexOf(slot2, slot16) then
						table.insert(slot2, slot16)
					end
				end
			end
		end

		RoomBlockHelper.refreshBlockResourceType(slot2)
		RoomBlockHelper.refreshBlockEntity(slot2, "refreshLand")
	end
end

function slot0._startWaitRunRefreshTask(slot0)
	if not slot0._hasWaitRunRefreshTask then
		slot0._hasWaitRunRefreshTask = true

		TaskDispatcher.runDelay(slot0._onWaitRunRefreshTask, slot0, 0.001)
	end
end

function slot0._onWaitRunRefreshTask(slot0)
	slot0._hasWaitRunRefreshTask = false

	if slot0._waitingBlockIdList and #slot0._waitingBlockIdList > 0 then
		slot0._waitingBlockIdList = {}

		slot0:_refreshBlockByIds(slot0._waitingBlockIdList)

		slot0._transportPathLineChanged = true
	end

	if slot0._transportPathLineChanged then
		slot0._transportPathLineChanged = false

		RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathLineChanged)
	end
end

slot0.instance = slot0.New()

return slot0

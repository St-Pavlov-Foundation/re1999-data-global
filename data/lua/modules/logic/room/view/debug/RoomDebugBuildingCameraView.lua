module("modules.logic.room.view.debug.RoomDebugBuildingCameraView", package.seeall)

slot0 = class("RoomDebugBuildingCameraView", BaseView)
slot1 = {
	CharacterOnly = 4,
	VehicleOnly = 3,
	BuildingCharacter = 1,
	BuildingOnly = 2
}

function slot0.onInitView(slot0)
	slot0._inputangle = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/edit/item/#input_angle")
	slot0._inputdistance = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/edit/item2/#input_distance")
	slot0._inputoffsetHeight = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/edit/item3/#input_offsetHeight")
	slot0._goentityPoint = gohelper.findChild(slot0.viewGO, "container/edit/#go_entityPoint")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._inputangle:AddOnEndEdit(slot0._onAngleEndEdit, slot0)
	slot0._inputdistance:AddOnEndEdit(slot0._onDistanceEndEdit, slot0)
	slot0._inputoffsetHeight:AddOnEndEdit(slot0._onOffestHightEndEdit, slot0)
	slot0._btnRoomInteraction:AddClickListener(slot0._btnsaveOnClick, slot0)
	slot0._dropRoomInteraction:AddOnValueChanged(slot0._onRoomInteractionSelectChanged, slot0)
	slot0._dropEnityPoint:AddOnValueChanged(slot0._onEnityPointSelectChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._inputangle:RemoveOnEndEdit()
	slot0._inputdistance:RemoveOnEndEdit()
	slot0._inputoffsetHeight:RemoveOnEndEdit()
	slot0._btnRoomInteraction:RemoveClickListener()
	slot0._dropRoomInteraction:RemoveOnValueChanged()
	slot0._dropEnityPoint:RemoveOnValueChanged()
end

function slot0._btnsaveOnClick(slot0)
	if not slot0._selectCfg then
		GameFacade.showToast(94, "选择建筑，后方可输出相机参数。")

		return
	end

	if slot0._selectCfg.cameraType == uv0.BuildingCharacter then
		slot0:_logBuildingCharacterCameraParam()
	elseif slot0:_getBuildingCameraParam() then
		logNormal(slot0:_buildingCameraParamToString(slot1, slot0._selectCfg.name))
	end
end

function slot0._editableInitView(slot0)
	slot0._dropRoomInteraction = gohelper.findChildDropdown(slot0.viewGO, "container/edit/roomInteraction/Dropdown")
	slot0._btnRoomInteraction = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/edit/roomInteraction/btnOK")
	slot0._dropEnityPoint = gohelper.findChildDropdown(slot0._goentityPoint, "Dropdown")
	slot0._angle = 0
	slot0._distance = 0
	slot0._offsetHeight = 0
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if not SLFramework.FrameworkSettings.IsEditor then
		slot0:closeThis()

		return
	end

	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._onCameraTransformUpdate, slot0)
	slot0:_initCharacterInteractionSelect()
	slot0:_initEnityPointSelect()

	slot1 = slot0:_getRoomScene()

	slot1.camera:switchCameraState(RoomEnum.CameraState.InteractionCharacterBuilding, slot1.camera._cameraParam, nil, slot0._onCameraDone, slot0)
	slot0:_changeCaremerFollow()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._onAngleEndEdit(slot0, slot1)
	slot0._angle = tonumber(slot1)

	slot0:_updateCameraParam()
	slot0:refreshUI()
end

function slot0._onDistanceEndEdit(slot0, slot1)
	slot0._distance = tonumber(slot1)

	slot0:_updateCameraParam()
	slot0:refreshUI()
end

function slot0._onOffestHightEndEdit(slot0, slot1)
	slot0._offsetHeight = tonumber(slot1)

	slot0:_updateCameraParam()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._inputangle:SetText(tostring(slot0._angle))
	slot0._inputdistance:SetText(tostring(slot0._distance))
	slot0._inputoffsetHeight:SetText(tostring(slot0._offsetHeight))
end

function slot0._initCharacterInteractionSelect(slot0)
	slot0._interactionCfgList = {}

	table.insert({}, "建筑选择")

	for slot6, slot7 in ipairs(lua_room_character_interaction.configList) do
		if ({
			[RoomCharacterEnum.InteractionType.Building] = true
		})[slot7.behaviour] then
			slot9 = HeroConfig.instance:getHeroCO(slot7.heroId)

			if slot0:_getMOByBuildingId(slot7.buildingId) and slot9 then
				slot10 = string.format("%s-%s-%s", slot8.config.name, slot9.name, slot7.id)

				table.insert(slot1, slot10)
				table.insert(slot0._interactionCfgList, {
					cameraType = uv0.BuildingCharacter,
					name = slot10,
					interactionCfg = slot7,
					buildingUid = slot8.buildingUid
				})
			end
		end
	end

	slot4 = {}

	for slot8, slot9 in ipairs(RoomMapBuildingModel.instance:getList()) do
		if slot9.config and not slot4[slot9.buildingId] and slot10.buildingType ~= RoomBuildingEnum.BuildingType.Decoration then
			slot4[slot9.buildingId] = true
			slot12 = string.format("%s-%s", slot10.name, slot9.buildingId)

			table.insert(slot1, slot12)
			table.insert(slot0._interactionCfgList, {
				cameraType = uv0.BuildingOnly,
				isFollow = slot10.buildingType == RoomBuildingEnum.BuildingType.Interact,
				name = slot12,
				buildingUid = slot9.buildingUid,
				buildingType = slot10.buildingType
			})
		end
	end

	slot5 = {}

	for slot10, slot11 in ipairs(RoomMapVehicleModel.instance:getList()) do
		if slot11.config and not slot5[slot11.vehicleId] then
			slot5[slot11.vehicleId] = slot11.vehicleId
			slot13 = string.format("%s-%s", slot12.name, slot11.vehicleId)

			table.insert(slot1, slot13)
			table.insert(slot0._interactionCfgList, {
				isFollow = true,
				cameraType = uv0.VehicleOnly,
				name = slot13,
				id = slot11.id,
				vehicleUid = slot11.id,
				vehicleId = slot11.vehicleId
			})
		end
	end

	for slot11, slot12 in ipairs(RoomCharacterModel.instance:getList()) do
		slot13 = string.format("%s-%s-镜头跟随", slot12.heroConfig.name, slot12.heroId)

		table.insert(slot1, slot13)
		table.insert(slot0._interactionCfgList, {
			isFollow = true,
			cameraType = uv0.CharacterOnly,
			name = slot13,
			id = slot12.id,
			heroId = slot12.heroId
		})
	end

	slot0._dropRoomInteraction:ClearOptions()
	slot0._dropRoomInteraction:AddOptions(slot1)
end

function slot0._initEnityPointSelect(slot0)
	slot0._entityPointDataList = {
		{
			name = RoomEnum.EntityChildKey.ThirdPersonCameraGOKey
		},
		{
			isFirstPerson = true,
			name = RoomEnum.EntityChildKey.FirstPersonCameraGOKey
		}
	}
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._entityPointDataList) do
		table.insert(slot1, slot6.name)
	end

	slot0._entityPointData = slot0._entityPointDataList[1]

	slot0._dropEnityPoint:ClearOptions()
	slot0._dropEnityPoint:AddOptions(slot1)
end

function slot0._logBuildingCharacterCameraParam(slot0)
	slot1, slot2 = slot0:_getSelectEntity()

	if not slot1 then
		GameFacade.showToast(94, "选择建筑，后方可输出相机参数。")

		return
	end

	if not slot2 then
		GameFacade.showToast(94, string.format("当前场景没放置【%s】", HeroConfig.instance:getHeroCO(slot0._selectCfg.interactionCfg.heroId) and slot4.name))

		return
	end

	if not slot0:_getBuildingCameraParam() then
		return
	end

	slot6, slot7, slot8 = transformhelper.getPos(slot2.go.transform)
	slot9 = slot1.containerGOTrs:InverseTransformPoint(slot6, slot7, slot8)

	logNormal(string.format("%s nodesXYZ:%.3f#%s#%0.3f\n", slot0:_buildingCameraParamToString(slot4, slot0._selectCfg.name), slot9.x, 0.11, slot9.z))

	if not string.nilorempty(slot3.buildingAnimState) then
		slot1:playAnimator(slot3.buildingAnimState)
	end

	if slot2 and not string.nilorempty(slot3.heroAnimState) then
		slot2.characterspine:play(string.split(slot3.heroAnimState, "#") and #slot10 > 1 and slot10[1] or slot3.heroAnimState, false, true)
	end
end

function slot0._buildingCameraParamToString(slot0, slot1, slot2)
	if not string.nilorempty(slot2) then
		slot3 = string.format("【%s】%s", slot2, "相机参数：\n")
	end

	if not string.nilorempty(slot1.hangPoint) then
		slot3 = string.format("%s hangPoint:%s\n", string.format("%s focusXYZ:%.3f#%s#%.3f\n", string.format("%s rotate:%.1f\n", string.format("%s distance:%s#%s\n", string.format("%s angle:%s#%s\n", slot3, slot1.angle, slot1.angle), slot1.distance, slot1.distance), RoomRotateHelper.getMod(slot1.rotate, 360)), slot1.focusX, slot1.offsetHeight, slot1.focusZ), slot1.hangPoint)
	end

	return slot3
end

function slot0._getBuildingCameraParam(slot0)
	if not slot0:_getSelectEntity() then
		GameFacade.showToast(94, "选择建筑后，方能得到建筑相机参数。")

		return
	end

	slot3 = slot0:_getRoomScene().camera
	slot6 = slot1.containerGOTrs:InverseTransformPoint(slot3._cameraParam.focusX, 0, slot3._cameraParam.focusY)

	if slot0._selectCfg and slot0._selectCfg.isFollow and slot0._entityPointData then
		-- Nothing
	end

	return {
		angle = slot0._angle,
		distance = slot0._distance,
		offsetHeight = slot0._offsetHeight,
		rotate = RoomRotateHelper.getMod(slot3._realCameraParam.rotate * Mathf.Rad2Deg - (slot1:getMO().rotate and tonumber(slot4.rotate) or 0) * 60, 360),
		focusX = slot6.x,
		focusZ = slot6.z,
		hangPoint = slot0._entityPointData.name
	}
end

function slot0._applayBuildingCameraParam(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot0:_getRoomScene()

	if not slot0:_getSelectEntity() then
		GameFacade.showToast(94, "选择建筑后，设置当前相机参数。")

		return
	end

	slot0._angle = slot1.angle
	slot0._distance = slot1.distance
	slot0._offsetHeight = slot1.offsetHeight

	slot0:_updateCameraParam()

	slot8 = slot3:transformPoint(slot1.focusX or 0, slot1.offsetHeight or 0, slot1.focusZ or 0)
	slot10 = RoomEnum.CameraState.InteractionCharacterBuilding

	slot2.camera:switchCameraState(slot10, {
		focusX = slot8.x,
		focusY = slot8.z,
		zoom = slot2.camera:getZoomInitValue(slot10),
		rotate = RoomRotateHelper.getMod(tonumber(slot1.rotate or 0) + slot3:getMO().rotate * 60, 360) * Mathf.Deg2Rad
	}, nil, slot0._applayCameraFinish, slot0)
end

function slot0._getSelectEntity(slot0)
	slot1 = slot0:_getRoomScene()

	if slot0._selectCfg and slot1 then
		if slot0._selectCfg.cameraType == uv0.BuildingOnly then
			return slot1.buildingmgr:getBuildingEntity(slot0._selectCfg.buildingUid, SceneTag.RoomBuilding)
		elseif slot2 == uv0.BuildingCharacter then
			return slot1.buildingmgr:getBuildingEntity(slot0._selectCfg.buildingUid, SceneTag.RoomBuilding), slot1.charactermgr:getCharacterEntity(slot0._selectCfg.interactionCfg.heroId, SceneTag.RoomCharacter)
		elseif slot2 == uv0.VehicleOnly then
			return slot1.vehiclemgr:getVehicleEntity(slot0._selectCfg.id)
		elseif slot2 == uv0.CharacterOnly then
			return slot1.charactermgr:getCharacterEntity(slot0._selectCfg.id, SceneTag.RoomCharacter)
		end
	end
end

function slot0._getRoomScene(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		return GameSceneMgr.instance:getCurScene()
	end
end

function slot0._applayCameraFinish(slot0)
	GameFacade.showToast(94, "设置建筑相机镜头成功")
end

function slot0._getMOByBuildingId(slot0, slot1)
	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getList()) do
		if slot7.buildingId == slot1 then
			return slot7
		end
	end
end

function slot0._onRoomInteractionSelectChanged(slot0, slot1)
	if not slot0._interactionCfgList then
		return
	end

	if slot1 == 0 then
		slot0._selectCfg = nil
	else
		slot0._selectCfg = slot0._interactionCfgList[slot1]
	end

	slot0:_changeCaremerFollow()
end

function slot0._onEnityPointSelectChanged(slot0, slot1)
	slot0._entityPointData = slot0._entityPointDataList[slot1 + 1]

	slot0:_changeCaremerFollow()
end

function slot0._changeCaremerFollow(slot0)
	slot2 = nil
	slot0._isCameraFollow = false

	if slot0:_getRoomScene() then
		slot3 = slot0._entityPointData and slot0._entityPointData.isFirstPerson and true or false

		if slot0._selectCfg and slot0._selectCfg.isFollow and slot0:_getSelectEntity() and slot4.cameraFollowTargetComp then
			slot0._isCameraFollow = true

			slot2:setFollowGOPath(slot0._entityPointData and slot0._entityPointData.name)
		end

		slot1.cameraFollow:setFollowTarget(slot2, slot3)
	end

	gohelper.setActive(slot0._goentityPoint, slot2 ~= nil)
end

function slot0._selectBuilding(slot0)
end

function slot0._onCameraDone(slot0)
	slot0:_getCameraParam()
	slot0:refreshUI()
	slot0:_updateCameraParam()
end

function slot0._updateCameraParam(slot0)
	slot2 = slot0:_getRoomScene().camera

	for slot6, slot7 in pairs(RoomEnum.CameraState) do
		slot2._angleMin[slot7] = slot0._angle
		slot2._angleMax[slot7] = slot0._angle
		slot2._distanceMin[slot7] = slot0._distance
		slot2._distanceMax[slot7] = slot0._distance
		slot2._offsetHeightMap[slot7] = slot0._offsetHeight
	end

	slot0._isWaitUpdate = true

	slot2:zoomTo(slot2._cameraParam.zoom)
end

function slot0._getCameraParam(slot0)
	if slot0:_getRoomScene().camera._realCameraParam then
		slot0._angle = Mathf.Rad2Deg * (slot2._realCameraParam.angle or 0)
		slot0._distance = slot2._realCameraParam.distance or 0
	end

	if slot2._cameraState then
		slot0._offsetHeight = slot2._offsetHeightMap[slot2._cameraState] or 0
	end
end

function slot0._onCameraTransformUpdate(slot0)
	if slot0._isWaitUpdate then
		slot0._isWaitUpdate = false
	end

	if slot0._cameraNotDone or slot0._isCameraFollow then
		return
	end

	slot0:_getCameraParam()
	slot0:refreshUI()
end

return slot0

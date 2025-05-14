module("modules.logic.room.view.debug.RoomDebugBuildingCameraView", package.seeall)

local var_0_0 = class("RoomDebugBuildingCameraView", BaseView)
local var_0_1 = {
	CharacterOnly = 4,
	VehicleOnly = 3,
	BuildingCharacter = 1,
	BuildingOnly = 2
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._inputangle = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/edit/item/#input_angle")
	arg_1_0._inputdistance = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/edit/item2/#input_distance")
	arg_1_0._inputoffsetHeight = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/edit/item3/#input_offsetHeight")
	arg_1_0._goentityPoint = gohelper.findChild(arg_1_0.viewGO, "container/edit/#go_entityPoint")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._inputangle:AddOnEndEdit(arg_2_0._onAngleEndEdit, arg_2_0)
	arg_2_0._inputdistance:AddOnEndEdit(arg_2_0._onDistanceEndEdit, arg_2_0)
	arg_2_0._inputoffsetHeight:AddOnEndEdit(arg_2_0._onOffestHightEndEdit, arg_2_0)
	arg_2_0._btnRoomInteraction:AddClickListener(arg_2_0._btnsaveOnClick, arg_2_0)
	arg_2_0._dropRoomInteraction:AddOnValueChanged(arg_2_0._onRoomInteractionSelectChanged, arg_2_0)
	arg_2_0._dropEnityPoint:AddOnValueChanged(arg_2_0._onEnityPointSelectChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._inputangle:RemoveOnEndEdit()
	arg_3_0._inputdistance:RemoveOnEndEdit()
	arg_3_0._inputoffsetHeight:RemoveOnEndEdit()
	arg_3_0._btnRoomInteraction:RemoveClickListener()
	arg_3_0._dropRoomInteraction:RemoveOnValueChanged()
	arg_3_0._dropEnityPoint:RemoveOnValueChanged()
end

function var_0_0._btnsaveOnClick(arg_4_0)
	if not arg_4_0._selectCfg then
		GameFacade.showToast(94, "选择建筑，后方可输出相机参数。")

		return
	end

	if arg_4_0._selectCfg.cameraType == var_0_1.BuildingCharacter then
		arg_4_0:_logBuildingCharacterCameraParam()
	else
		local var_4_0 = arg_4_0:_getBuildingCameraParam()

		if var_4_0 then
			logNormal(arg_4_0:_buildingCameraParamToString(var_4_0, arg_4_0._selectCfg.name))
		end
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._dropRoomInteraction = gohelper.findChildDropdown(arg_5_0.viewGO, "container/edit/roomInteraction/Dropdown")
	arg_5_0._btnRoomInteraction = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "container/edit/roomInteraction/btnOK")
	arg_5_0._dropEnityPoint = gohelper.findChildDropdown(arg_5_0._goentityPoint, "Dropdown")
	arg_5_0._angle = 0
	arg_5_0._distance = 0
	arg_5_0._offsetHeight = 0
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	if not SLFramework.FrameworkSettings.IsEditor then
		arg_7_0:closeThis()

		return
	end

	arg_7_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_7_0._onCameraTransformUpdate, arg_7_0)
	arg_7_0:_initCharacterInteractionSelect()
	arg_7_0:_initEnityPointSelect()

	local var_7_0 = arg_7_0:_getRoomScene()
	local var_7_1 = RoomEnum.CameraState.InteractionCharacterBuilding

	var_7_0.camera:switchCameraState(var_7_1, var_7_0.camera._cameraParam, nil, arg_7_0._onCameraDone, arg_7_0)
	arg_7_0:_changeCaremerFollow()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._onAngleEndEdit(arg_10_0, arg_10_1)
	arg_10_0._angle = tonumber(arg_10_1)

	arg_10_0:_updateCameraParam()
	arg_10_0:refreshUI()
end

function var_0_0._onDistanceEndEdit(arg_11_0, arg_11_1)
	arg_11_0._distance = tonumber(arg_11_1)

	arg_11_0:_updateCameraParam()
	arg_11_0:refreshUI()
end

function var_0_0._onOffestHightEndEdit(arg_12_0, arg_12_1)
	arg_12_0._offsetHeight = tonumber(arg_12_1)

	arg_12_0:_updateCameraParam()
	arg_12_0:refreshUI()
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0._inputangle:SetText(tostring(arg_13_0._angle))
	arg_13_0._inputdistance:SetText(tostring(arg_13_0._distance))
	arg_13_0._inputoffsetHeight:SetText(tostring(arg_13_0._offsetHeight))
end

function var_0_0._initCharacterInteractionSelect(arg_14_0)
	arg_14_0._interactionCfgList = {}

	local var_14_0 = {}

	table.insert(var_14_0, "建筑选择")

	local var_14_1 = {
		[RoomCharacterEnum.InteractionType.Building] = true
	}

	for iter_14_0, iter_14_1 in ipairs(lua_room_character_interaction.configList) do
		if var_14_1[iter_14_1.behaviour] then
			local var_14_2 = arg_14_0:_getMOByBuildingId(iter_14_1.buildingId)
			local var_14_3 = HeroConfig.instance:getHeroCO(iter_14_1.heroId)

			if var_14_2 and var_14_3 then
				local var_14_4 = string.format("%s-%s-%s", var_14_2.config.name, var_14_3.name, iter_14_1.id)

				table.insert(var_14_0, var_14_4)
				table.insert(arg_14_0._interactionCfgList, {
					cameraType = var_0_1.BuildingCharacter,
					name = var_14_4,
					interactionCfg = iter_14_1,
					buildingUid = var_14_2.buildingUid
				})
			end
		end
	end

	local var_14_5 = RoomMapBuildingModel.instance:getList()
	local var_14_6 = {}

	for iter_14_2, iter_14_3 in ipairs(var_14_5) do
		local var_14_7 = iter_14_3.config

		if var_14_7 and not var_14_6[iter_14_3.buildingId] and var_14_7.buildingType ~= RoomBuildingEnum.BuildingType.Decoration then
			var_14_6[iter_14_3.buildingId] = true

			local var_14_8 = var_14_7.buildingType == RoomBuildingEnum.BuildingType.Interact
			local var_14_9 = string.format("%s-%s", var_14_7.name, iter_14_3.buildingId)

			table.insert(var_14_0, var_14_9)
			table.insert(arg_14_0._interactionCfgList, {
				cameraType = var_0_1.BuildingOnly,
				isFollow = var_14_8,
				name = var_14_9,
				buildingUid = iter_14_3.buildingUid,
				buildingType = var_14_7.buildingType
			})
		end
	end

	local var_14_10 = {}
	local var_14_11 = RoomMapVehicleModel.instance:getList()

	for iter_14_4, iter_14_5 in ipairs(var_14_11) do
		local var_14_12 = iter_14_5.config

		if var_14_12 and not var_14_10[iter_14_5.vehicleId] then
			var_14_10[iter_14_5.vehicleId] = iter_14_5.vehicleId

			local var_14_13 = string.format("%s-%s", var_14_12.name, iter_14_5.vehicleId)

			table.insert(var_14_0, var_14_13)
			table.insert(arg_14_0._interactionCfgList, {
				isFollow = true,
				cameraType = var_0_1.VehicleOnly,
				name = var_14_13,
				id = iter_14_5.id,
				vehicleUid = iter_14_5.id,
				vehicleId = iter_14_5.vehicleId
			})
		end
	end

	local var_14_14 = RoomCharacterModel.instance:getList()

	for iter_14_6, iter_14_7 in ipairs(var_14_14) do
		local var_14_15 = string.format("%s-%s-镜头跟随", iter_14_7.heroConfig.name, iter_14_7.heroId)

		table.insert(var_14_0, var_14_15)
		table.insert(arg_14_0._interactionCfgList, {
			isFollow = true,
			cameraType = var_0_1.CharacterOnly,
			name = var_14_15,
			id = iter_14_7.id,
			heroId = iter_14_7.heroId
		})
	end

	arg_14_0._dropRoomInteraction:ClearOptions()
	arg_14_0._dropRoomInteraction:AddOptions(var_14_0)
end

function var_0_0._initEnityPointSelect(arg_15_0)
	arg_15_0._entityPointDataList = {
		{
			name = RoomEnum.EntityChildKey.ThirdPersonCameraGOKey
		},
		{
			isFirstPerson = true,
			name = RoomEnum.EntityChildKey.FirstPersonCameraGOKey
		}
	}

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._entityPointDataList) do
		table.insert(var_15_0, iter_15_1.name)
	end

	arg_15_0._entityPointData = arg_15_0._entityPointDataList[1]

	arg_15_0._dropEnityPoint:ClearOptions()
	arg_15_0._dropEnityPoint:AddOptions(var_15_0)
end

function var_0_0._logBuildingCharacterCameraParam(arg_16_0)
	local var_16_0, var_16_1 = arg_16_0:_getSelectEntity()

	if not var_16_0 then
		GameFacade.showToast(94, "选择建筑，后方可输出相机参数。")

		return
	end

	local var_16_2 = arg_16_0._selectCfg.interactionCfg

	if not var_16_1 then
		local var_16_3 = HeroConfig.instance:getHeroCO(var_16_2.heroId)

		GameFacade.showToast(94, string.format("当前场景没放置【%s】", var_16_3 and var_16_3.name))

		return
	end

	local var_16_4 = arg_16_0:_getBuildingCameraParam()

	if not var_16_4 then
		return
	end

	local var_16_5 = arg_16_0:_buildingCameraParamToString(var_16_4, arg_16_0._selectCfg.name)
	local var_16_6, var_16_7, var_16_8 = transformhelper.getPos(var_16_1.go.transform)
	local var_16_9 = var_16_0.containerGOTrs:InverseTransformPoint(var_16_6, var_16_7, var_16_8)
	local var_16_10 = string.format("%s nodesXYZ:%.3f#%s#%0.3f\n", var_16_5, var_16_9.x, 0.11, var_16_9.z)

	logNormal(var_16_10)

	if not string.nilorempty(var_16_2.buildingAnimState) then
		var_16_0:playAnimator(var_16_2.buildingAnimState)
	end

	if var_16_1 and not string.nilorempty(var_16_2.heroAnimState) then
		local var_16_11 = string.split(var_16_2.heroAnimState, "#")

		var_16_1.characterspine:play(var_16_11 and #var_16_11 > 1 and var_16_11[1] or var_16_2.heroAnimState, false, true)
	end
end

function var_0_0._buildingCameraParamToString(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = "相机参数：\n"

	if not string.nilorempty(arg_17_2) then
		var_17_0 = string.format("【%s】%s", arg_17_2, var_17_0)
	end

	local var_17_1 = string.format("%s angle:%s#%s\n", var_17_0, arg_17_1.angle, arg_17_1.angle)
	local var_17_2 = string.format("%s distance:%s#%s\n", var_17_1, arg_17_1.distance, arg_17_1.distance)
	local var_17_3 = string.format("%s rotate:%.1f\n", var_17_2, RoomRotateHelper.getMod(arg_17_1.rotate, 360))
	local var_17_4 = string.format("%s focusXYZ:%.3f#%s#%.3f\n", var_17_3, arg_17_1.focusX, arg_17_1.offsetHeight, arg_17_1.focusZ)

	if not string.nilorempty(arg_17_1.hangPoint) then
		var_17_4 = string.format("%s hangPoint:%s\n", var_17_4, arg_17_1.hangPoint)
	end

	return var_17_4
end

function var_0_0._getBuildingCameraParam(arg_18_0)
	local var_18_0 = arg_18_0:_getSelectEntity()

	if not var_18_0 then
		GameFacade.showToast(94, "选择建筑后，方能得到建筑相机参数。")

		return
	end

	local var_18_1 = arg_18_0:_getRoomScene().camera
	local var_18_2 = var_18_0:getMO()
	local var_18_3 = var_18_2.rotate and tonumber(var_18_2.rotate) or 0
	local var_18_4 = var_18_0.containerGOTrs:InverseTransformPoint(var_18_1._cameraParam.focusX, 0, var_18_1._cameraParam.focusY)
	local var_18_5 = var_18_1._realCameraParam.rotate * Mathf.Rad2Deg - var_18_3 * 60
	local var_18_6 = {
		angle = arg_18_0._angle,
		distance = arg_18_0._distance,
		offsetHeight = arg_18_0._offsetHeight,
		rotate = RoomRotateHelper.getMod(var_18_5, 360),
		focusX = var_18_4.x,
		focusZ = var_18_4.z
	}

	if arg_18_0._selectCfg and arg_18_0._selectCfg.isFollow and arg_18_0._entityPointData then
		var_18_6.hangPoint = arg_18_0._entityPointData.name
	end

	return var_18_6
end

function var_0_0._applayBuildingCameraParam(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return
	end

	local var_19_0 = arg_19_0:_getRoomScene()
	local var_19_1 = arg_19_0:_getSelectEntity()

	if not var_19_1 then
		GameFacade.showToast(94, "选择建筑后，设置当前相机参数。")

		return
	end

	local var_19_2 = arg_19_1.focusX or 0
	local var_19_3 = arg_19_1.offsetHeight or 0
	local var_19_4 = arg_19_1.focusZ or 0
	local var_19_5 = arg_19_1.rotate or 0

	arg_19_0._angle = arg_19_1.angle
	arg_19_0._distance = arg_19_1.distance
	arg_19_0._offsetHeight = arg_19_1.offsetHeight

	arg_19_0:_updateCameraParam()

	local var_19_6 = var_19_1:transformPoint(var_19_2, var_19_3, var_19_4)
	local var_19_7 = tonumber(var_19_5) + var_19_1:getMO().rotate * 60
	local var_19_8 = RoomRotateHelper.getMod(var_19_7, 360) * Mathf.Deg2Rad
	local var_19_9 = RoomEnum.CameraState.InteractionCharacterBuilding
	local var_19_10 = {
		focusX = var_19_6.x,
		focusY = var_19_6.z,
		zoom = var_19_0.camera:getZoomInitValue(var_19_9),
		rotate = var_19_8
	}

	var_19_0.camera:switchCameraState(var_19_9, var_19_10, nil, arg_19_0._applayCameraFinish, arg_19_0)
end

function var_0_0._getSelectEntity(arg_20_0)
	local var_20_0 = arg_20_0:_getRoomScene()

	if arg_20_0._selectCfg and var_20_0 then
		local var_20_1 = arg_20_0._selectCfg.cameraType

		if var_20_1 == var_0_1.BuildingOnly then
			return var_20_0.buildingmgr:getBuildingEntity(arg_20_0._selectCfg.buildingUid, SceneTag.RoomBuilding)
		elseif var_20_1 == var_0_1.BuildingCharacter then
			local var_20_2 = var_20_0.buildingmgr:getBuildingEntity(arg_20_0._selectCfg.buildingUid, SceneTag.RoomBuilding)
			local var_20_3 = var_20_0.charactermgr:getCharacterEntity(arg_20_0._selectCfg.interactionCfg.heroId, SceneTag.RoomCharacter)

			return var_20_2, var_20_3
		elseif var_20_1 == var_0_1.VehicleOnly then
			return var_20_0.vehiclemgr:getVehicleEntity(arg_20_0._selectCfg.id)
		elseif var_20_1 == var_0_1.CharacterOnly then
			return var_20_0.charactermgr:getCharacterEntity(arg_20_0._selectCfg.id, SceneTag.RoomCharacter)
		end
	end
end

function var_0_0._getRoomScene(arg_21_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		return GameSceneMgr.instance:getCurScene()
	end
end

function var_0_0._applayCameraFinish(arg_22_0)
	GameFacade.showToast(94, "设置建筑相机镜头成功")
end

function var_0_0._getMOByBuildingId(arg_23_0, arg_23_1)
	local var_23_0 = RoomMapBuildingModel.instance:getList()

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_1.buildingId == arg_23_1 then
			return iter_23_1
		end
	end
end

function var_0_0._onRoomInteractionSelectChanged(arg_24_0, arg_24_1)
	if not arg_24_0._interactionCfgList then
		return
	end

	if arg_24_1 == 0 then
		arg_24_0._selectCfg = nil
	else
		arg_24_0._selectCfg = arg_24_0._interactionCfgList[arg_24_1]
	end

	arg_24_0:_changeCaremerFollow()
end

function var_0_0._onEnityPointSelectChanged(arg_25_0, arg_25_1)
	arg_25_0._entityPointData = arg_25_0._entityPointDataList[arg_25_1 + 1]

	arg_25_0:_changeCaremerFollow()
end

function var_0_0._changeCaremerFollow(arg_26_0)
	local var_26_0 = arg_26_0:_getRoomScene()
	local var_26_1

	arg_26_0._isCameraFollow = false

	if var_26_0 then
		local var_26_2 = arg_26_0._entityPointData and arg_26_0._entityPointData.isFirstPerson and true or false

		if arg_26_0._selectCfg and arg_26_0._selectCfg.isFollow then
			local var_26_3 = arg_26_0:_getSelectEntity()

			var_26_1 = var_26_3 and var_26_3.cameraFollowTargetComp

			if var_26_1 then
				arg_26_0._isCameraFollow = true

				var_26_1:setFollowGOPath(arg_26_0._entityPointData and arg_26_0._entityPointData.name)
			end
		end

		var_26_0.cameraFollow:setFollowTarget(var_26_1, var_26_2)
	end

	gohelper.setActive(arg_26_0._goentityPoint, var_26_1 ~= nil)
end

function var_0_0._selectBuilding(arg_27_0)
	return
end

function var_0_0._onCameraDone(arg_28_0)
	arg_28_0:_getCameraParam()
	arg_28_0:refreshUI()
	arg_28_0:_updateCameraParam()
end

function var_0_0._updateCameraParam(arg_29_0)
	local var_29_0 = arg_29_0:_getRoomScene().camera

	for iter_29_0, iter_29_1 in pairs(RoomEnum.CameraState) do
		var_29_0._angleMin[iter_29_1] = arg_29_0._angle
		var_29_0._angleMax[iter_29_1] = arg_29_0._angle
		var_29_0._distanceMin[iter_29_1] = arg_29_0._distance
		var_29_0._distanceMax[iter_29_1] = arg_29_0._distance
		var_29_0._offsetHeightMap[iter_29_1] = arg_29_0._offsetHeight
	end

	arg_29_0._isWaitUpdate = true

	var_29_0:zoomTo(var_29_0._cameraParam.zoom)
end

function var_0_0._getCameraParam(arg_30_0)
	local var_30_0 = arg_30_0:_getRoomScene().camera

	if var_30_0._realCameraParam then
		arg_30_0._angle = Mathf.Rad2Deg * (var_30_0._realCameraParam.angle or 0)
		arg_30_0._distance = var_30_0._realCameraParam.distance or 0
	end

	if var_30_0._cameraState then
		arg_30_0._offsetHeight = var_30_0._offsetHeightMap[var_30_0._cameraState] or 0
	end
end

function var_0_0._onCameraTransformUpdate(arg_31_0)
	if arg_31_0._isWaitUpdate then
		arg_31_0._isWaitUpdate = false
	end

	if arg_31_0._cameraNotDone or arg_31_0._isCameraFollow then
		return
	end

	arg_31_0:_getCameraParam()
	arg_31_0:refreshUI()
end

return var_0_0

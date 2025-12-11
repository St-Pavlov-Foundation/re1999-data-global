module("modules.logic.room.view.RoomViewTouch", package.seeall)

local var_0_0 = class("RoomViewTouch", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._commonEmptyBlockMO = RoomBlockMO.New()

	arg_1_0._commonEmptyBlockMO:init(RoomInfoHelper.generateEmptyMapBlockInfo(-1, 0, 0))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
	arg_4_0._characterTouchStateMap = {
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.Normal] = true
	}
	arg_4_0._isNotCanClickEeventMap = {
		[RoomEnum.CameraState.InteractBuilding] = true
	}
end

function var_0_0._isInitBlockById(arg_5_0, arg_5_1)
	return RoomConfig.instance:getInitBlock(arg_5_1) ~= nil
end

function var_0_0._onClick(arg_6_0, arg_6_1)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)

		return
	end

	if arg_6_0._isNotCanClickEeventMap[arg_6_0._scene.camera:getCameraState()] then
		return
	end

	if arg_6_0:_click3DGameObject(arg_6_1) then
		return
	end

	local var_6_0, var_6_1 = RoomBendingHelper.screenPosToHex(arg_6_1)

	if not var_6_0 then
		return
	end

	local var_6_2 = RoomMapBlockModel.instance:getBlockMO(var_6_0.x, var_6_0.y)

	if not var_6_2 and not RoomEnum.IsBlockNeedConnInit and RoomBlockHelper.isCanPlaceBlock() then
		arg_6_0._commonEmptyBlockMO.hexPiont = var_6_0
		var_6_2 = arg_6_0._commonEmptyBlockMO
	end

	if not var_6_2 then
		arg_6_0:_checkCancelBackBlock()

		return
	end

	local var_6_3 = RoomBendingHelper.screenToWorld(arg_6_1)

	if RoomController.instance:isDebugMode() then
		arg_6_0:_debugBlockInfo(var_6_2)
		arg_6_0:_clickInDebugMode(var_6_2, var_6_0, var_6_1)
	elseif RoomController.instance:isEditMode() then
		arg_6_0:_debugBlockInfo(var_6_2)
		arg_6_0:_clickInEditMode(var_6_2, var_6_0, var_6_1)
	elseif RoomController.instance:isObMode() then
		arg_6_0:_debugBlockInfo(var_6_2)
		arg_6_0:_clickInObMode(var_6_2, var_6_0, var_6_1, var_6_3)
	end
end

function var_0_0._clickInDebugMode(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
		return
	end

	if arg_7_1:canPlace() then
		RoomDebugController.instance:debugPlaceBlock(arg_7_2)
	elseif arg_7_1.blockState == RoomBlockEnum.BlockState.Map then
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.X) then
			if RoomDebugController.instance:isDebugBuildingListShow() then
				RoomDebugController.instance:debugRotateBuilding(arg_7_2)
			elseif RoomDebugController.instance:isDebugPlaceListShow() then
				RoomDebugController.instance:debugRotateBlock(arg_7_2)
			end
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) then
			if RoomDebugController.instance:isDebugBuildingListShow() then
				RoomDebugController.instance:debugRootOutBuilding(arg_7_2)
			elseif RoomDebugController.instance:isDebugPackageListShow() then
				RoomDebugController.instance:debugSetPackageId(arg_7_1.id, 0)
			elseif RoomDebugController.instance:isDebugPlaceListShow() then
				RoomDebugController.instance:debugRootOutBlock(arg_7_2)
			end
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.V) then
			RoomDebugController.instance:debugPlaceBuilding(arg_7_2)
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.B) then
			RoomDebugController.instance:debugRotateBuilding(arg_7_2)
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.N) then
			RoomDebugController.instance:debugRootOutBuilding(arg_7_2)
		elseif RoomDebugController.instance:isDebugBuildingListShow() then
			RoomDebugController.instance:debugPlaceBuilding(arg_7_2)
		elseif RoomDebugController.instance:isDebugPlaceListShow() then
			RoomDebugController.instance:debugReplaceBlock(arg_7_2)
		elseif RoomDebugController.instance:isDebugPackageListShow() then
			if RoomDebugController.instance:isEditPackageOrder() then
				RoomDebugController.instance:debugSetPackageLastOrder(arg_7_1.id)
			else
				RoomDebugController.instance:debugSetPackage(arg_7_1.id)
			end
		end
	end
end

function var_0_0._chickSelectInventontoryBlockId(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = HexMath.hexToPosition(arg_8_1.hexPoint, RoomBlockEnum.BlockSize)

	if not RoomHelper.isOutCameraFocusCenter(var_8_0) then
		-- block empty
	elseif not arg_8_0._scene.camera:isTweening() then
		arg_8_0._scene.camera:tweenCamera({
			focusX = var_8_0.x,
			focusY = var_8_0.y
		})
	end
end

function var_0_0._chickBackBlock(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {
		hexPoint = arg_9_2
	}

	arg_9_0._scene.fsm:triggerEvent(RoomSceneEvent.TryBackBlock, var_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._checkBuilding(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_10_0 then
		return
	end

	if arg_10_0:_isInitBlockById(arg_10_1.id) then
		GameFacade.showToast(RoomEnum.Toast.BuildingCannotInitBlock)

		return
	end

	local var_10_1 = {
		hexPoint = arg_10_2
	}

	if arg_10_2 ~= var_10_0.hexPoint then
		AudioMgr.instance:trigger(var_10_0:getPlaceAudioId())
	end

	for iter_10_0 = 0, 5 do
		local var_10_2 = RoomRotateHelper.rotateRotate(var_10_0.rotate, iter_10_0)

		if RoomBuildingHelper.canTryPlace(var_10_0.buildingId, arg_10_2, var_10_2) then
			var_10_1.rotate = var_10_2

			arg_10_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, var_10_1)

			break
		end
	end
end

function var_0_0._checkCancelBackBlock(arg_11_0)
	local var_11_0 = RoomMapBlockModel.instance:isBackMore()
	local var_11_1 = RoomWaterReformModel.instance:isWaterReform()

	if RoomController.instance:isEditMode() and not var_11_0 and not var_11_1 and RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		arg_11_0._scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	end
end

function var_0_0._clickInEditMode(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) or RoomBuildingController.instance:isBuildingListShow() then
		arg_12_0:_checkBuilding(arg_12_1, arg_12_2, arg_12_3)

		return
	end

	local var_12_0 = RoomMapBlockModel.instance:isBackMore()
	local var_12_1 = RoomWaterReformModel.instance:isWaterReform()

	if not arg_12_1:canPlace() then
		if arg_12_1.id == RoomInventoryBlockModel.instance:getSelectInventoryBlockId() then
			arg_12_0:_chickSelectInventontoryBlockId(arg_12_1, arg_12_2, arg_12_3)
		elseif arg_12_1.blockState == RoomBlockEnum.BlockState.Map then
			if var_12_1 then
				RoomWaterReformController.instance:onClickBlock(arg_12_1, arg_12_2)
			elseif var_12_0 and arg_12_0:_isInitBlockById(arg_12_1.id) then
				GameFacade.showToast(RoomEnum.Toast.InventoryCannotBackInitBlock)
			else
				arg_12_0:_chickBackBlock(arg_12_1, arg_12_2, arg_12_3)
			end
		end

		return
	end

	arg_12_0:_checkCancelBackBlock()

	if var_12_0 or var_12_1 then
		return
	end

	if not RoomInventoryBlockModel.instance:getSelectInventoryBlockMO() then
		GameFacade.showToast(RoomEnum.Toast.NoSelectInventoryBlock)

		return
	end

	if RoomInventoryBlockModel.instance:isMaxNum() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMax)

		return
	end

	if not RoomBlockHelper.isInBoundary(arg_12_2) then
		GameFacade.showToast(RoomEnum.Toast.InventBlockMapPositionMax)

		return
	end

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		local var_12_2 = {
			hexPoint = arg_12_2
		}

		arg_12_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, var_12_2)
	end
end

function var_0_0._clickInObMode(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
		arg_13_0:_checkBuilding(arg_13_1, arg_13_2, arg_13_3)
	elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) and arg_13_1.blockState == RoomBlockEnum.BlockState.Map then
		local var_13_0 = RoomCharacterModel.instance:getTempCharacterMO()

		if var_13_0 then
			local var_13_1 = var_13_0.currentPosition

			if RoomCharacterHelper.reCalculateHeight(Vector3(arg_13_4.x, 0, arg_13_4.y)) ~= var_13_1 then
				local var_13_2 = RoomCharacterHelper.getRecommendHexPoint(var_13_0.heroId, var_13_0.skinId, arg_13_4)

				if var_13_2 then
					local var_13_3 = {
						position = var_13_2.position
					}

					arg_13_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, var_13_3)

					return
				end

				GameFacade.showToast(ToastEnum.RoomViewTouch)
			end
		end
	end
end

function var_0_0._click3DGameObject(arg_14_0, arg_14_1)
	if not arg_14_0._click3DFuncDict then
		arg_14_0._click3DFuncDict = {
			[RoomEnum.TouchTab.RoomBuilding] = arg_14_0._click3DBuilding,
			[RoomEnum.TouchTab.RoomInitBuilding] = arg_14_0._click3DInitBuilding,
			[RoomEnum.TouchTab.RoomPartBuilding] = arg_14_0._click3DPartBuilding,
			[RoomEnum.TouchTab.RoomCharacter] = arg_14_0._click3DCharacter,
			[RoomEnum.TouchTab.RoomCritter] = arg_14_0._click3DCritter,
			[RoomEnum.TouchTab.RoomTransportSite] = arg_14_0._click3DTransportSite
		}
	end

	local var_14_0, var_14_1 = RoomBendingHelper.getRaycastEntity(arg_14_1)
	local var_14_2 = arg_14_0._click3DFuncDict[var_14_0]

	if var_14_2 then
		return var_14_2(arg_14_0, var_14_1)
	end

	return false
end

function var_0_0._isCanClickBuilding(arg_15_0)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		return false
	end

	return RoomController.instance:isObMode()
end

function var_0_0._click3DBuilding(arg_16_0, arg_16_1)
	local var_16_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_16_1)

	if not var_16_0 then
		return false
	end

	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			local var_16_1 = RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm)

			if var_16_1 then
				arg_16_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
					buildingUid = var_16_0.id,
					hexPoint = var_16_0.hexPoint,
					rotate = var_16_0.rotate
				})
				RoomShowBuildingListModel.instance:setSelect(var_16_0.id)
			end

			return var_16_1
		end
	elseif arg_16_0:_isCanClickBuilding() and var_16_0.config and RoomBuildingEnum.CanClickTouchBuildingType[var_16_0.config.buildingType] == true then
		RoomMap3DClickController.instance:onBuildingEntityClick(var_16_0)

		return true
	end

	return false
end

function var_0_0._click3DInitBuilding(arg_17_0, arg_17_1)
	if arg_17_0:_isCanClickBuilding() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
		RoomMapController.instance:openRoomInitBuildingView(0.2)

		return true
	end

	return false
end

function var_0_0._click3DPartBuilding(arg_18_0, arg_18_1)
	if arg_18_0:_isCanClickBuilding() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
		RoomMapController.instance:openRoomInitBuildingView(0.2, {
			partId = arg_18_1
		})

		return true
	end

	return false
end

function var_0_0._click3DCharacter(arg_19_0, arg_19_1)
	local var_19_0 = RoomCharacterModel.instance:getCharacterMOById(arg_19_1)

	if not var_19_0 then
		return false
	end

	if RoomController.instance:isObMode() then
		if RoomCharacterController.instance:isCharacterListShow() then
			local var_19_1 = RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm)

			if var_19_1 then
				arg_19_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					heroId = var_19_0.heroId,
					position = var_19_0.currentPosition
				})
				RoomCharacterPlaceListModel.instance:setSelect(var_19_0.id)
			end

			return var_19_1
		elseif arg_19_0._characterTouchStateMap[arg_19_0._scene.camera:getCameraState()] then
			RoomCharacterController.instance:dispatchEvent(RoomEvent.ClickCharacterInNormalCamera, var_19_0.heroId)

			return true
		end
	elseif RoomController.instance:isVisitMode() and arg_19_0._characterTouchStateMap[arg_19_0._scene.camera:getCameraState()] then
		RoomCharacterController.instance:dispatchEvent(RoomEvent.ClickCharacterInNormalCamera, var_19_0.heroId)

		return true
	end

	return false
end

function var_0_0._click3DCritter(arg_20_0, arg_20_1)
	local var_20_0 = RoomCritterModel.instance:getCritterMOById(arg_20_1)

	if not var_20_0 then
		return false
	end

	if (RoomController.instance:isObMode() or RoomController.instance:isVisitMode()) and arg_20_0._characterTouchStateMap[arg_20_0._scene.camera:getCameraState()] then
		RoomMap3DClickController.instance:onCritterEntityClick(var_20_0)

		return true
	end

	return false
end

function var_0_0._click3DTransportSite(arg_21_0, arg_21_1)
	if arg_21_0:_isCanClickBuilding() then
		RoomMap3DClickController.instance:onTransportSiteClick(arg_21_1)

		return true
	end

	return false
end

function var_0_0._debugBlockInfo(arg_22_0, arg_22_1)
	if isDebugBuild then
		local var_22_0 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)

		if (arg_22_1.blockState == RoomBlockEnum.BlockState.Map or arg_22_1.blockState == RoomBlockEnum.BlockState.Temp) and var_22_0 then
			local var_22_1 = HexMath.hexToPosition(arg_22_1.hexPoint, RoomBlockEnum.BlockSize)

			var_22_1.z = var_22_1.y
			var_22_1.y = 0

			local var_22_2 = CameraMgr.instance:getMainCameraTrs().position
			local var_22_3 = arg_22_1:getResourceList()
			local var_22_4 = arg_22_1:getResourceCenter()

			logNormal(string.format("当前选中的地块(%d, %d, %d) %d, 资源: %d | %d # %d # %d # %d # %d # %d, 发声位置 : (%s, %s, %s), 摄像机位置 : (%s, %s, %s), 距离摄像机距离 : %s", arg_22_1.hexPoint.x, arg_22_1.hexPoint.y, arg_22_1.id, arg_22_1.defineId, var_22_4, var_22_3[1], var_22_3[2], var_22_3[3], var_22_3[4], var_22_3[5], var_22_3[6], var_22_1.x, var_22_1.y, var_22_1.z, var_22_2.x, var_22_2.y, var_22_2.z, Vector3.Distance(var_22_1, var_22_2)))
		end
	end
end

function var_0_0._onDrag(arg_23_0, arg_23_1)
	if arg_23_0._scene.cameraFollow:isFollowing() then
		return
	end

	local var_23_0 = arg_23_0._scene.camera:getCameraRotate()
	local var_23_1 = arg_23_0._scene.camera:getCameraZoom()
	local var_23_2 = arg_23_1.x * (var_23_1 / 2 + 1)
	local var_23_3 = arg_23_1.y * (var_23_1 / 2 + 1)

	if not arg_23_0._scene.fsm:isTransitioning() then
		local var_23_4 = var_23_2 * Mathf.Cos(var_23_0) + var_23_3 * Mathf.Sin(var_23_0)
		local var_23_5 = -var_23_2 * Mathf.Sin(var_23_0) + var_23_3 * Mathf.Cos(var_23_0)
		local var_23_6 = -0.0025 * RoomController.instance.touchMoveSpeed

		arg_23_0._scene.camera:move(var_23_4 * var_23_6, var_23_5 * var_23_6)
	end
end

function var_0_0._onPressBuilding(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Overlook then
		return
	end

	RoomBuildingController.instance:pressBuildingUp(arg_24_1, arg_24_2)
end

function var_0_0._onDropBuilding(arg_25_0, arg_25_1)
	if arg_25_0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Overlook then
		return
	end

	RoomBuildingController.instance:dropBuildingDown(arg_25_1)
end

function var_0_0._onPressCharacter(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._scene.camera:getCameraState()

	if var_26_0 ~= RoomEnum.CameraState.Character and var_26_0 ~= RoomEnum.CameraState.Normal then
		return
	end

	RoomCharacterController.instance:pressCharacterUp(arg_26_1, arg_26_2)
end

function var_0_0._onDropCharacter(arg_27_0, arg_27_1)
	if arg_27_0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Character then
		return
	end

	RoomCharacterController.instance:dropCharacterDown(arg_27_1)
end

function var_0_0.onOpen(arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TouchClickScene, arg_28_0._onClick, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TouchDrag, arg_28_0._onDrag, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TouchScale, arg_28_0._onScale, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TouchRotate, arg_28_0._onRotate, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TouchPressBuilding, arg_28_0._onPressBuilding, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TouchDropBuilding, arg_28_0._onDropBuilding, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TouchPressCharacter, arg_28_0._onPressCharacter, arg_28_0)
	arg_28_0:addEventCb(RoomMapController.instance, RoomEvent.TouchDropCharacter, arg_28_0._onDropCharacter, arg_28_0)
end

function var_0_0.onClose(arg_29_0)
	return
end

function var_0_0._onScale(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0._scene.camera:getCameraState()

	if not RoomEnum.CameraCanScaleMap[var_30_0] then
		return
	end

	if arg_30_0._scene.fsm:isTransitioning() then
		return
	end

	if arg_30_1 ~= 0 then
		arg_30_0._scene.camera:zoom(arg_30_1)
	end
end

function var_0_0._onRotate(arg_31_0, arg_31_1)
	if arg_31_0._scene.fsm:isTransitioning() or arg_31_0._scene.cameraFollow:isLockRotate() then
		return
	end

	if arg_31_1 ~= 0 then
		arg_31_0._scene.camera:rotate(arg_31_1)
	end
end

function var_0_0._screenPosToHexPoint(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:_screenPosToGroundPos(arg_32_1)

	return var_32_0 and HexMath.positionToRoundHex(var_32_0, RoomBlockEnum.BlockSize)
end

function var_0_0._screenPosToGroundPos(arg_33_0, arg_33_1)
	local var_33_0 = CameraMgr.instance:getMainCamera()
	local var_33_1 = GameSceneMgr.instance:getCurScene()
	local var_33_2 = var_33_1.camera.camera
	local var_33_3 = var_33_1.go.planeGO.transform.position.y
	local var_33_4 = var_33_2:ScreenPointToRay(arg_33_1)

	if var_33_4.direction.y == 0 then
		return nil
	end

	local var_33_5 = (var_33_3 - var_33_4.origin.y) / var_33_4.direction.y

	if var_33_5 > 1000 or var_33_5 < 0 then
		return nil
	end

	local var_33_6 = Vector2(var_33_4.origin.x + var_33_4.direction.x * var_33_5, var_33_4.origin.z + var_33_4.direction.z * var_33_5)
	local var_33_7 = var_33_1.go.groundGO.transform.localScale

	if var_33_7.x == 0 or var_33_7.y == 0 then
		return nil
	end

	return (Vector2(var_33_6.x / var_33_7.x, var_33_6.y / var_33_7.z))
end

function var_0_0.onDestroyView(arg_34_0)
	return
end

return var_0_0

module("modules.logic.room.controller.RoomCharacterController", package.seeall)

local var_0_0 = class("RoomCharacterController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._refreshNextCharacterFaithUpdate, arg_3_0)

	arg_3_0._isCharacterListShow = false
	arg_3_0._characterFocus = RoomCharacterEnum.CameraFocus.Normal
	arg_3_0._lastCameraState = nil
	arg_3_0._playingInteractionParam = nil
	arg_3_0._dialogNextTime = nil
	arg_3_0._lastSendgainCharacterFaithHeroId = nil
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.init(arg_5_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_5_0._refreshRelateDot, arg_5_0)
end

function var_0_0.setCharacterFocus(arg_6_0, arg_6_1)
	arg_6_0._characterFocus = arg_6_1 or RoomCharacterEnum.CameraFocus.Normal
end

function var_0_0.getCharacterFocus(arg_7_0)
	return arg_7_0._characterFocus
end

function var_0_0.setCharacterListShow(arg_8_0, arg_8_1)
	arg_8_0._isCharacterListShow = arg_8_1

	local var_8_0 = GameSceneMgr.instance:getCurScene()
	local var_8_1 = var_8_0.camera:getCameraState()

	if var_8_1 ~= RoomEnum.CameraState.Character then
		arg_8_0._lastCameraState = var_8_1
	end

	if arg_8_1 then
		var_8_0.camera:switchCameraState(RoomEnum.CameraState.Character, {})
	elseif var_8_1 == RoomEnum.CameraState.Character then
		var_8_0.camera:switchCameraState(arg_8_0._lastCameraState or RoomEnum.CameraState.Overlook, {})

		if arg_8_0._lastCameraState == RoomEnum.CameraState.Normal then
			arg_8_0:tryPlayAllSpecialIdle()
		end
	end

	if arg_8_1 then
		if UIBlockMgrExtend.needCircleMv then
			UIBlockMgrExtend.setNeedCircleMv(false)
		end

		ViewMgr.instance:openView(ViewName.RoomCharacterPlaceView)

		local var_8_2 = RoomCharacterModel.instance:getList()

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			var_8_0.character:setCharacterAnimal(iter_8_1.heroId, false)
			var_8_0.character:setCharacterTouch(iter_8_1.heroId, false)

			if iter_8_1:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move then
				local var_8_3 = iter_8_1:getNearestPoint()

				iter_8_1:endMove()
				iter_8_1:setPosition(RoomCharacterHelper.getCharacterPosition3D(var_8_3, true))
			end
		end
	else
		ViewMgr.instance:closeView(ViewName.RoomCharacterPlaceView)
	end

	arg_8_0:dispatchEvent(RoomEvent.CharacterListShowChanged, arg_8_1)
	arg_8_0:dispatchEvent(RoomEvent.RefreshSpineShow)

	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
		var_8_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceCharacter)
	end
end

function var_0_0.isCharacterListShow(arg_9_0)
	return arg_9_0._isCharacterListShow
end

function var_0_0.tryCorrectAllCharacter(arg_10_0, arg_10_1)
	local var_10_0 = RoomCharacterModel.instance:getList()

	if arg_10_1 == true then
		arg_10_0:_tryRandomByCharacterList(var_10_0)

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			arg_10_0:interruptInteraction(iter_10_1:getCurrentInteractionId())
		end

		return
	end

	local var_10_1 = RoomCharacterModel.instance:getList()
	local var_10_2

	for iter_10_2, iter_10_3 in ipairs(var_10_1) do
		local var_10_3 = iter_10_3.currentPosition

		if not RoomCharacterHelper.canConfirmPlace(iter_10_3.heroId, var_10_3, iter_10_3.skinId, nil) then
			local var_10_4 = RoomCharacterHelper.getRandomPosition() or iter_10_3.currentPosition
			local var_10_5 = RoomCharacterHelper.getRecommendHexPoint(iter_10_3.heroId, iter_10_3.skinId, Vector2.New(var_10_4.x, var_10_4.z))

			if var_10_5 then
				arg_10_0:moveCharacterTo(iter_10_3, var_10_5.position, false)
			else
				var_10_2 = var_10_1 or {}

				table.insert(var_10_2, iter_10_3)
			end

			arg_10_0:interruptInteraction(iter_10_3:getCurrentInteractionId())
		end
	end

	if var_10_2 then
		arg_10_0:_tryRandomByCharacterList(var_10_1)
	end
end

function var_0_0.checkCharacterMax(arg_11_0)
	local var_11_0 = RoomCharacterModel.instance:getMaxCharacterCount()

	if var_11_0 < RoomCharacterModel.instance:getPlaceCount() then
		local var_11_1 = {}

		tabletool.tabletool.addValues(var_11_1, RoomCharacterModel.instance:getList())

		local var_11_2 = GameSceneMgr.instance:getCurScene()

		arg_11_0:_randomArray(var_11_1)

		local var_11_3 = {}

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			if iter_11_1:isPlaceSourceState() then
				if var_11_0 > #var_11_3 then
					table.insert(var_11_3, iter_11_1.heroId)
				else
					local var_11_4 = var_11_2.charactermgr:getCharacterEntity(iter_11_1.id)

					if var_11_4 then
						var_11_2.charactermgr:destroyCharacter(var_11_4)
					end

					RoomCharacterModel.instance:deleteCharacterMO(iter_11_1.heroId)
				end
			end
		end

		RoomRpc.instance:sendUpdateRoomHeroDataRequest(var_11_3)
	end
end

function var_0_0._findPlaceBlockMOList(arg_12_0)
	local var_12_0 = RoomMapBlockModel.instance:getFullBlockMOList()
	local var_12_1 = RoomMapBuildingModel.instance
	local var_12_2 = {}

	for iter_12_0 = 1, #var_12_0 do
		local var_12_3 = var_12_0[iter_12_0]

		if not var_12_1:getBuildingParam(var_12_3.hexPoint.x, var_12_3.hexPoint.y) and not RoomBuildingHelper.isInInitBlock(var_12_3.hexPoint) then
			table.insert(var_12_2, var_12_3)
		end
	end

	return var_12_2
end

function var_0_0._randomArray(arg_13_0, arg_13_1)
	RoomHelper.randomArray(arg_13_1)
end

function var_0_0._getRandomResDirectionArray(arg_14_0)
	if not arg_14_0._randomResDirectionList then
		arg_14_0._randomResDirectionList = {
			0,
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	arg_14_0:_randomArray(arg_14_0._randomResDirectionList)

	return arg_14_0._randomResDirectionList
end

function var_0_0._randomDirectionByBlockMO(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_2 and arg_15_2:getBlockDefineCfg()

	if var_15_0 then
		local var_15_1 = arg_15_0:_getRandomResDirectionArray()
		local var_15_2
		local var_15_3

		for iter_15_0 = 1, #var_15_1 do
			local var_15_4 = var_15_1[iter_15_0]
			local var_15_5 = var_15_0.resourceIds[var_15_4]

			if arg_15_1:isCanPlaceByResId(var_15_5) then
				return RoomRotateHelper.rotateDirection(var_15_4, -arg_15_2:getRotate())
			end
		end
	end

	return nil
end

function var_0_0.tryRandomByCharacterList(arg_16_0, arg_16_1)
	arg_16_0:_tryRandomByCharacterList(arg_16_1)
end

function var_0_0._tryRandomByCharacterList(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:_findPlaceBlockMOList()

	arg_17_0:_randomArray(var_17_0)

	local var_17_1 = #var_17_0
	local var_17_2 = 1
	local var_17_3

	RoomHelper.logEnd("RoomCharacterController:_tryRandomByCharacterList(roomCharacterMOList) start")

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_4 = true

		for iter_17_2 = var_17_2, var_17_1 do
			local var_17_5 = var_17_0[iter_17_2]
			local var_17_6 = arg_17_0:_randomDirectionByBlockMO(iter_17_1, var_17_5)

			if var_17_6 then
				local var_17_7 = ResourcePoint(var_17_5.hexPoint, var_17_6)
				local var_17_8 = RoomCharacterHelper.getCharacterPosition3D(var_17_7)
				local var_17_9 = RoomCharacterHelper.getRecommendHexPoint(iter_17_1.heroId, iter_17_1.skinId, Vector2.New(var_17_8.x, var_17_8.z))

				RoomHelper.logEnd(iter_17_1.heroConfig.name)

				if var_17_9 then
					var_17_0[iter_17_2] = var_17_0[var_17_2]
					var_17_0[var_17_2] = var_17_5
					var_17_2 = var_17_2 + 1

					arg_17_0:moveCharacterTo(iter_17_1, var_17_9 and var_17_9.position or var_17_8, false)

					var_17_4 = false

					break
				end
			end
		end

		if var_17_4 then
			var_17_3 = var_17_3 or {}

			table.insert(var_17_3, iter_17_1)
		end
	end

	RoomHelper.logEnd("RoomCharacterController:_tryRandomByCharacterList(roomCharacterMOList) end")

	if var_17_3 then
		local var_17_10 = {}

		tabletool.addValues(var_17_10, RoomConfig.instance:getBlockPlacePositionCfgList())
		arg_17_0:_randomArray(var_17_10)

		if #var_17_3 > #var_17_10 then
			logError("export_初始坐标[\"block_place_position\"] 坐标数量不足")
		end

		for iter_17_3 = 1, #var_17_3 do
			local var_17_11 = var_17_10[iter_17_3]

			if var_17_11 then
				arg_17_0:moveCharacterTo(var_17_3[iter_17_3], Vector3(var_17_11.x * 0.001, var_17_11.y * 0.001, var_17_11.z * 0.001), false)
			end
		end
	end
end

function var_0_0.moveCharacterTo(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = GameSceneMgr.instance:getCurScene()
	local var_18_1 = var_18_0.charactermgr:getCharacterEntity(arg_18_1.id)

	if var_18_1 then
		if arg_18_3 then
			arg_18_2 = RoomCharacterHelper.reCalculateHeight(arg_18_2)
		end

		var_18_0.charactermgr:moveTo(var_18_1, arg_18_2)
	end

	RoomCharacterModel.instance:resetCharacterMO(arg_18_1.heroId, arg_18_2)
end

function var_0_0.tryMoveCharacterAfterRotateCamera(arg_19_0)
	local var_19_0 = RoomCharacterModel.instance:getList()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move then
			local var_19_1 = iter_19_1:getRemainMovePositions()

			if not RoomCharacterHelper.isMoveCameraWalkable(var_19_1) then
				iter_19_1:endMove(true)
				iter_19_1:moveNeighbor()
			end
		end
	end
end

function var_0_0.correctAllCharacterHeight(arg_20_0)
	local var_20_0 = RoomCharacterModel.instance:getList()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		arg_20_0:correctCharacterHeight(iter_20_1)
	end
end

function var_0_0.correctCharacterHeight(arg_21_0, arg_21_1)
	if arg_21_1 == nil then
		return
	end

	local var_21_0 = arg_21_1:getIsFreeze()

	if arg_21_1:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move or var_21_0 then
		return
	end

	local var_21_1 = arg_21_1.currentPosition
	local var_21_2 = var_21_1.x
	local var_21_3 = var_21_1.z
	local var_21_4 = RoomCharacterHelper.getLandHeightByRaycast(var_21_1)

	arg_21_1:setPositionXYZ(var_21_2, var_21_4, var_21_3)
end

function var_0_0.checkCanSpineShow(arg_22_0, arg_22_1)
	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return false
	end

	if arg_22_0:isCharacterListShow() then
		return true
	end

	return RoomEnum.CameraShowSpineMap[arg_22_1]
end

function var_0_0.pressCharacterUp(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 then
		arg_23_0._pressHeroId = arg_23_2
	end

	if not arg_23_0._pressHeroId then
		return
	end

	if not arg_23_0:isCharacterListShow() then
		arg_23_0:setCharacterListShow(true)
	end

	local var_23_0 = GameSceneMgr.instance:getCurScene()
	local var_23_1 = var_23_0.charactermgr:getCharacterEntity(arg_23_0._pressHeroId, SceneTag.RoomCharacter)

	if not var_23_1 then
		return
	end

	if arg_23_2 then
		local var_23_2 = RoomCharacterModel.instance:getTempCharacterMO()

		if not var_23_2 or var_23_2.id ~= arg_23_2 then
			local var_23_3 = RoomCharacterModel.instance:getCharacterMOById(arg_23_2)

			var_23_0.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				press = true,
				heroId = arg_23_2,
				position = var_23_3.currentPosition
			})
		end

		var_23_1:tweenUp()
		RoomCharacterPlaceListModel.instance:setSelect(arg_23_2)
	end

	local var_23_4 = RoomCharacterModel.instance:getTempCharacterMO()

	if not arg_23_0._pressCharacterHexPoint then
		arg_23_0._pressCharacterHexPoint = var_23_4:getMoveTargetPoint().hexPoint
	end

	local var_23_5 = arg_23_0._pressCharacterHexPoint
	local var_23_6 = RoomBendingHelper.screenPosToHex(arg_23_1)

	if not var_23_6 then
		return
	end

	arg_23_0._pressCharacterHexPoint = var_23_6

	local var_23_7 = RoomBendingHelper.screenToWorld(arg_23_1)

	if var_23_7 then
		local var_23_8 = var_23_7.x
		local var_23_9 = var_23_7.y
		local var_23_10 = RoomCharacterHelper.getLandHeightByRaycast(Vector3(var_23_8, 0, var_23_9))

		var_23_4:setPositionXYZ(var_23_8, var_23_10, var_23_9)
		var_23_1:setLocalPos(var_23_8, var_23_10, var_23_9, true)
	end

	arg_23_0:dispatchEvent(RoomEvent.PressCharacterUp)
end

function var_0_0.getPressCharacterHexPoint(arg_24_0)
	return arg_24_0._pressCharacterHexPoint
end

function var_0_0.dropCharacterDown(arg_25_0, arg_25_1)
	if not arg_25_0._pressHeroId then
		return
	end

	local var_25_0 = RoomCharacterModel.instance:getCharacterMOById(arg_25_0._pressHeroId)
	local var_25_1
	local var_25_2 = arg_25_1 and RoomBendingHelper.screenToWorld(arg_25_1)
	local var_25_3 = var_25_2 and RoomCharacterHelper.getRecommendHexPoint(arg_25_0._pressHeroId, var_25_0.skinId, Vector2(var_25_2.x, var_25_2.y))

	if var_25_3 then
		var_25_1 = var_25_3.position
	end

	var_25_1 = var_25_1 or var_25_0.currentPosition

	local var_25_4 = GameSceneMgr.instance:getCurScene()
	local var_25_5 = {
		isPressing = true,
		position = var_25_1
	}

	arg_25_0:cancelPressCharacter()
	var_25_4.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, var_25_5)
end

function var_0_0.cancelPressCharacter(arg_26_0)
	if not arg_26_0._pressHeroId then
		return
	end

	local var_26_0 = GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(arg_26_0._pressHeroId, SceneTag.RoomCharacter)

	if not var_26_0 then
		return
	end

	arg_26_0._pressHeroId = nil
	arg_26_0._pressCharacterHexPoint = nil

	var_26_0:tweenDown()
	arg_26_0:dispatchEvent(RoomEvent.DropCharacterDown)
end

function var_0_0.isPressCharacter(arg_27_0)
	return arg_27_0._pressHeroId
end

function var_0_0.updateCharacterFaith(arg_28_0, arg_28_1)
	TaskDispatcher.cancelTask(arg_28_0._refreshNextCharacterFaithUpdate, arg_28_0)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	if not RoomController.instance:isObMode() then
		return
	end

	RoomCharacterModel.instance:updateCharacterFaith(arg_28_1)
	arg_28_0:dispatchEvent(RoomEvent.RefreshFaithShow)
	arg_28_0:refreshCharacterFaithTimer()
end

function var_0_0.playCharacterFaithEffect(arg_29_0, arg_29_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	local var_29_0 = GameSceneMgr.instance:getCurScene()

	if not RoomController.instance:isObMode() then
		return
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_1 = iter_29_1.heroId
		local var_29_2 = var_29_0.charactermgr:getCharacterEntity(var_29_1, SceneTag.RoomCharacter)

		if var_29_2 then
			var_29_2:playFaithEffect()
		end
	end
end

function var_0_0.refreshCharacterFaithTimer(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._refreshNextCharacterFaithUpdate, arg_30_0)

	local var_30_0
	local var_30_1 = RoomCharacterModel.instance:getList()

	for iter_30_0, iter_30_1 in ipairs(var_30_1) do
		local var_30_2 = iter_30_1.nextRefreshTime

		if var_30_2 and var_30_2 > 0 and (not var_30_0 or var_30_2 < var_30_0) then
			var_30_0 = var_30_2
		end
	end

	if var_30_0 and var_30_0 > 0 then
		local var_30_3 = var_30_0 - ServerTime.now()
		local var_30_4 = math.max(1, var_30_3) + 0.5

		TaskDispatcher.runDelay(arg_30_0._refreshNextCharacterFaithUpdate, arg_30_0, var_30_4)
	end
end

function var_0_0._refreshNextCharacterFaithUpdate(arg_31_0)
	local var_31_0 = {}
	local var_31_1 = RoomCharacterModel.instance:getList()

	for iter_31_0, iter_31_1 in ipairs(var_31_1) do
		table.insert(var_31_0, iter_31_1.heroId)
	end

	RoomRpc.instance:sendGetRoomObInfoRequest(false, arg_31_0._getRoomObInfoReply, arg_31_0)
end

function var_0_0._getRoomObInfoReply(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_2 ~= 0 then
		return
	end

	arg_32_0:updateCharacterFaith(arg_32_3.roomHeroDatas)
end

function var_0_0.gainCharacterFaith(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	RoomRpc.instance:sendGainRoomHeroFaithRequest(arg_33_1, arg_33_2, arg_33_3)
end

function var_0_0.findGainMaxFaithHeroId(arg_34_0)
	local var_34_0
	local var_34_1 = -1
	local var_34_2 = RoomCharacterModel.instance:getList()

	for iter_34_0, iter_34_1 in ipairs(var_34_2) do
		local var_34_3 = HeroModel.instance:getByHeroId(iter_34_1.heroId)

		if var_34_3 and iter_34_1.currentFaith > 0 then
			local var_34_4 = iter_34_1.currentFaith + var_34_3.faith

			if var_34_1 < var_34_4 then
				var_34_1 = var_34_4
				var_34_0 = iter_34_1.heroId
			end
		end
	end

	return var_34_0
end

function var_0_0.gainAllCharacterFaith(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = {}
	local var_35_1 = RoomCharacterModel.instance:getList()

	for iter_35_0, iter_35_1 in ipairs(var_35_1) do
		if iter_35_1.currentFaith > 0 then
			table.insert(var_35_0, iter_35_1.heroId)
		end
	end

	if #var_35_0 > 0 then
		local var_35_2 = tabletool.indexOf(var_35_0, arg_35_3)

		if var_35_2 == nil then
			arg_35_3 = arg_35_0:findGainMaxFaithHeroId()
			var_35_2 = tabletool.indexOf(var_35_0, arg_35_3)
		end

		if var_35_2 then
			var_35_0[var_35_2] = var_35_0[1]
			var_35_0[1] = arg_35_3
		end

		arg_35_0._lastSendgainCharacterFaithHeroId = arg_35_3

		arg_35_0:gainCharacterFaith(var_35_0, arg_35_1, arg_35_2)
	end
end

function var_0_0.tweenCameraFocusCharacter(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = RoomCharacterModel.instance:getById(arg_36_1)

	if not var_36_0 then
		return
	end

	arg_36_2 = arg_36_2 or RoomEnum.CameraState.Overlook

	local var_36_1 = GameSceneMgr.instance:getCurScene()
	local var_36_2 = var_36_0.currentPosition

	var_36_1.camera:switchCameraState(arg_36_2, {
		focusX = var_36_2.x,
		focusY = var_36_2.z
	})
end

function var_0_0.isCharacterFaithFull(arg_37_0, arg_37_1)
	local var_37_0 = HeroModel.instance:getByHeroId(arg_37_1)

	if not var_37_0 then
		return false
	end

	local var_37_1 = var_37_0.faith

	return HeroConfig.instance:getFaithPercent(var_37_1)[1] >= 1
end

function var_0_0.hideCharacterFaithFull(arg_38_0, arg_38_1)
	RoomCharacterModel.instance:setHideFaithFull(arg_38_1, true)
	arg_38_0:dispatchEvent(RoomEvent.RefreshFaithShow)
end

function var_0_0.setCharacterFullFaithChecked(arg_39_0, arg_39_1)
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.RoomCharacterFaithFull, false)
end

function var_0_0._refreshRelateDot(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		if iter_40_0 == RedDotEnum.DotNode.RoomCharacterFaithFull then
			arg_40_0:dispatchEvent(RoomEvent.RefreshFaithShow)

			return
		end
	end
end

function var_0_0.showGainFaithToast(arg_41_0, arg_41_1)
	local var_41_0 = {}
	local var_41_1

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		if iter_41_1.materilType == MaterialEnum.MaterialType.Faith then
			if arg_41_0._lastSendgainCharacterFaithHeroId == iter_41_1.materilId then
				arg_41_0._lastSendgainCharacterFaithHeroId = nil
				var_41_1 = iter_41_1
			end

			table.insert(var_41_0, iter_41_1)
		end
	end

	local var_41_2 = #var_41_0

	if var_41_2 <= 0 then
		return
	end

	local var_41_3 = var_41_1 or var_41_0[1]
	local var_41_4 = HeroModel.instance:getByHeroId(var_41_3.materilId)

	if not var_41_4 then
		return
	end

	if var_41_2 > 1 then
		GameFacade.showToast(RoomEnum.Toast.GainFaithMultipleCharacter, var_41_4.config.name)
	else
		local var_41_5 = HeroConfig.instance:getFaithPercent(var_41_4.faith)[1]

		GameFacade.showToast(RoomEnum.Toast.GainFaithSingleCharacter, var_41_4.config.name, var_41_5 * 100)
	end

	for iter_41_2, iter_41_3 in ipairs(var_41_0) do
		local var_41_6 = HeroModel.instance:getByHeroId(iter_41_3.materilId)

		if var_41_6 and HeroConfig.instance:getFaithPercent(var_41_6.faith)[1] >= 1 then
			GameFacade.showToast(RoomEnum.Toast.GainFaithFull)

			return
		end
	end
end

function var_0_0.interruptInteraction(arg_42_0, arg_42_1)
	if not arg_42_1 then
		return
	end

	local var_42_0 = RoomConfig.instance:getCharacterInteractionConfig(arg_42_1)

	if var_42_0.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		local var_42_1 = RoomCharacterModel.instance:getCharacterMOById(var_42_0.heroId)

		if var_42_1 then
			var_42_1:setCurrentInteractionId(nil)
		end

		local var_42_2 = RoomCharacterModel.instance:getCharacterMOById(var_42_0.relateHeroId)

		if var_42_2 then
			var_42_2:setCurrentInteractionId(nil)
		end
	elseif var_42_0.behaviour == RoomCharacterEnum.InteractionType.Building then
		-- block empty
	end

	arg_42_0:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function var_0_0.startInteraction(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_1 then
		return
	end

	arg_43_0._interactionGetReward = arg_43_2
	arg_43_0._interactionGetFaith = arg_43_3

	if not arg_43_0._interactionGetReward or RoomModel.instance:getInteractionState(arg_43_1) == RoomCharacterEnum.InteractionState.Start then
		arg_43_0:_onRealStartInteraction(arg_43_1)
	else
		RoomRpc.instance:sendStartCharacterInteractionRequest(arg_43_1, arg_43_0._onStartInteraction, arg_43_0)
	end
end

function var_0_0._onStartInteraction(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if arg_44_2 ~= 0 then
		return
	end

	arg_44_0:_onRealStartInteraction(arg_44_3.id)
end

function var_0_0._onRealStartInteraction(arg_45_0, arg_45_1)
	local var_45_0 = RoomConfig.instance:getCharacterInteractionConfig(arg_45_1)

	if var_45_0.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		arg_45_0:startDialogInteraction(var_45_0)
	else
		arg_45_0._playingInteractionParam = {}
	end

	arg_45_0:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function var_0_0.startDialogInteraction(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_1.dialogId

	arg_46_0._playingInteractionParam = {
		stepId = 0,
		id = arg_46_1.id,
		behaviour = arg_46_1.behaviour,
		dialogId = arg_46_1.dialogId,
		heroId = arg_46_1.heroId,
		relateHeroId = arg_46_1.relateHeroId,
		selectIds = {},
		buildingUid = arg_46_2,
		positionList = {}
	}

	if arg_46_1.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		arg_46_0:tweenDialogCamera(arg_46_1)
	end
end

function var_0_0.startDialogTrainCritter(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_0._playingInteractionParam = {
		stepId = 0,
		id = arg_47_1.id,
		behaviour = arg_47_1.behaviour,
		dialogId = arg_47_1.dialogId,
		heroId = arg_47_1.heroId,
		relateHeroId = arg_47_1.relateHeroId,
		selectIds = {},
		positionList = {},
		critterUid = arg_47_2
	}

	arg_47_0:nextDialogInteraction()
end

function var_0_0.tweenDialogCamera(arg_48_0, arg_48_1)
	local var_48_0 = GameSceneMgr.instance:getCurScene()
	local var_48_1 = RoomCharacterModel.instance:getCharacterMOById(arg_48_1.heroId)

	var_48_1:endMove(true)

	local var_48_2 = var_48_1.currentPosition

	table.insert(arg_48_0._playingInteractionParam.positionList, var_48_2)

	if arg_48_1.relateHeroId == 0 then
		local var_48_3 = {
			zoom = 0.2,
			focusX = var_48_2.x,
			focusY = var_48_2.z
		}

		var_48_0.camera:switchCameraState(RoomEnum.CameraState.Normal, var_48_3, nil, arg_48_0.interactionCameraDone, arg_48_0)

		arg_48_0._playingInteractionParam.cameraParam = var_48_3

		return
	end

	local var_48_4 = RoomCharacterModel.instance:getCharacterMOById(arg_48_1.relateHeroId)

	var_48_4:endMove(true)

	local var_48_5 = var_48_4.currentPosition

	table.insert(arg_48_0._playingInteractionParam.positionList, var_48_5)

	local var_48_6 = (var_48_2 + var_48_5) / 2
	local var_48_7 = Vector3.Normalize(var_48_5 - var_48_2)
	local var_48_8 = math.acos(Vector3.Dot(var_48_7, Vector3.forward))

	if var_48_7.x < 0 then
		var_48_8 = RoomRotateHelper.getMod(math.pi * 2 - var_48_8, math.pi * 2)
	end

	local var_48_9 = RoomRotateHelper.getMod(var_48_8 + math.pi / 2, math.pi * 2)
	local var_48_10 = RoomRotateHelper.getMod(var_48_8 - math.pi / 2, math.pi * 2)
	local var_48_11 = RoomRotateHelper.getMod(var_48_0.camera:getCameraRotate(), math.pi * 2)
	local var_48_12 = var_48_9
	local var_48_13 = math.min(math.abs(var_48_9 - var_48_11), math.pi * 2 - math.abs(var_48_9 - var_48_11)) > math.min(math.abs(var_48_10 - var_48_11), math.pi * 2 - math.abs(var_48_10 - var_48_11)) and SpineLookDir.Left or SpineLookDir.Right

	if var_48_13 == SpineLookDir.Left then
		var_48_12 = var_48_10
	end

	local var_48_14 = var_48_0.charactermgr:getCharacterEntity(var_48_1.id, SceneTag.RoomCharacter)

	if var_48_14 and var_48_14.charactermove then
		var_48_14.charactermove:forcePositionAndLookDir(nil, -var_48_13, nil)
	end

	local var_48_15 = var_48_0.charactermgr:getCharacterEntity(var_48_4.id, SceneTag.RoomCharacter)

	if var_48_15 and var_48_15.charactermove then
		var_48_15.charactermove:forcePositionAndLookDir(nil, var_48_13, nil)
	end

	local var_48_16 = {
		zoom = 0.2,
		focusX = var_48_6.x,
		focusY = var_48_6.z,
		rotate = var_48_12
	}

	var_48_0.camera:switchCameraState(RoomEnum.CameraState.Normal, var_48_16, nil, arg_48_0.interactionCameraDone, arg_48_0)

	arg_48_0._playingInteractionParam.cameraParam = var_48_16
end

function var_0_0.trynextDialogInteraction(arg_49_0)
	if arg_49_0._dialogNextTime and arg_49_0._dialogNextTime > Time.time then
		return
	end

	arg_49_0._dialogNextTime = Time.time + RoomCharacterEnum.DialogClickCDTime

	arg_49_0:nextDialogInteraction()
end

function var_0_0.interactionCameraDone(arg_50_0)
	arg_50_0:nextDialogInteraction()

	local var_50_0 = GameSceneMgr.instance:getCurScene()
end

function var_0_0.nextDialogInteraction(arg_51_0, arg_51_1)
	if not arg_51_0._playingInteractionParam or arg_51_0._playingInteractionParam.behaviour ~= RoomCharacterEnum.InteractionType.Dialog then
		return
	end

	local var_51_0 = RoomConfig.instance:getCharacterDialogConfig(arg_51_0._playingInteractionParam.dialogId, arg_51_0._playingInteractionParam.stepId)

	if not arg_51_1 and var_51_0 and not string.nilorempty(var_51_0.selectIds) then
		local var_51_1 = GameUtil.splitString2(var_51_0.selectIds, true)

		arg_51_0._playingInteractionParam.selectParam = var_51_1

		arg_51_0:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)

		if not ViewMgr.instance:isOpen(ViewName.RoomBranchView) then
			ViewMgr.instance:openView(ViewName.RoomBranchView)
		end

		return
	end

	if arg_51_1 and arg_51_0._playingInteractionParam.selectParam then
		local var_51_2 = arg_51_0._playingInteractionParam.selectParam[arg_51_1][1]

		arg_51_0._playingInteractionParam.stepId = arg_51_0._playingInteractionParam.selectParam[arg_51_1][2]
		arg_51_0._playingInteractionParam.selectParam = nil

		table.insert(arg_51_0._playingInteractionParam.selectIds, var_51_2)
	elseif var_51_0 and not string.nilorempty(var_51_0.nextStepId) then
		arg_51_0._playingInteractionParam.stepId = tonumber(var_51_0.nextStepId)
	else
		arg_51_0._playingInteractionParam.stepId = arg_51_0._playingInteractionParam.stepId + 1
	end

	if not RoomConfig.instance:getCharacterDialogConfig(arg_51_0._playingInteractionParam.dialogId, arg_51_0._playingInteractionParam.stepId) then
		arg_51_0:finishInteraction()
	else
		arg_51_0:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)

		if not ViewMgr.instance:isOpen(ViewName.RoomBranchView) then
			ViewMgr.instance:openView(ViewName.RoomBranchView)
		end
	end
end

function var_0_0.finishInteraction(arg_52_0)
	ViewMgr.instance:closeView(ViewName.RoomBranchView)

	if not arg_52_0._playingInteractionParam then
		return
	end

	if arg_52_0._interactionGetReward then
		arg_52_0._interactionGetReward = false

		RoomRpc.instance:sendGetCharacterInteractionBonusRequest(arg_52_0._playingInteractionParam.id, arg_52_0._playingInteractionParam.selectIds)
	end

	if arg_52_0._interactionGetFaith then
		arg_52_0._interactionGetFaith = false

		var_0_0.instance:gainAllCharacterFaith(nil, nil, arg_52_0._playingInteractionParam.heroId)
	end

	local var_52_0 = arg_52_0._playingInteractionParam.critterUid

	if var_52_0 then
		CritterController.instance:finishTrainSpecialEventByUid(var_52_0)
	end

	arg_52_0:endInteraction()
end

function var_0_0.endInteraction(arg_53_0)
	if not arg_53_0._playingInteractionParam then
		return
	end

	local var_53_0 = GameSceneMgr.instance:getCurScene()
	local var_53_1 = arg_53_0._playingInteractionParam.id

	arg_53_0._playingInteractionParam = nil
	arg_53_0._dialogNextTime = nil

	arg_53_0:interruptInteraction(var_53_1)

	local var_53_2 = RoomConfig.instance:getCharacterInteractionConfig(var_53_1)

	if var_53_2.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		local var_53_3 = RoomCharacterModel.instance:getCharacterMOById(var_53_2.heroId)

		if var_53_3 then
			var_53_3:setCurrentInteractionId(nil)

			local var_53_4 = var_53_0.charactermgr:getCharacterEntity(var_53_3.id, SceneTag.RoomCharacter)

			if var_53_4 and var_53_4.charactermove then
				var_53_4.charactermove:clearForcePositionAndLookDir()
			end
		end

		local var_53_5 = RoomCharacterModel.instance:getCharacterMOById(var_53_2.relateHeroId)

		if var_53_5 then
			var_53_5:setCurrentInteractionId(nil)

			local var_53_6 = var_53_0.charactermgr:getCharacterEntity(var_53_5.id, SceneTag.RoomCharacter)

			if var_53_6 and var_53_6.charactermove then
				var_53_6.charactermove:clearForcePositionAndLookDir()
			end
		end
	end
end

function var_0_0.getPlayingInteractionParam(arg_54_0)
	return arg_54_0._playingInteractionParam
end

function var_0_0.tryPlayAllSpecialIdle(arg_55_0)
	local var_55_0 = RoomCharacterModel.instance:getList()

	for iter_55_0, iter_55_1 in ipairs(var_55_0) do
		arg_55_0:tryPlaySpecialIdle(iter_55_1.id)
	end
end

function var_0_0.tryPlaySpecialIdle(arg_56_0, arg_56_1)
	local var_56_0 = GameSceneMgr.instance:getCurScene()
	local var_56_1 = RoomCharacterModel.instance:getCharacterMOById(arg_56_1)

	if not var_56_1 then
		return
	end

	local var_56_2 = var_56_0.charactermgr:getCharacterEntity(arg_56_1)

	if not var_56_2 then
		return
	end

	if var_56_2.characterspine:isRandomSpecialRate() then
		var_56_2.characterspine:tryPlaySpecialIdle()

		var_56_1.stateDuration = -5
	end
end

function var_0_0.tweenCameraFocus(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5)
	local var_57_0 = GameSceneMgr.instance:getCurSceneType()
	local var_57_1 = GameSceneMgr.instance:getCurScene()

	if var_57_0 ~= SceneType.Room or not var_57_1 or not var_57_1.camera then
		return
	end

	if RoomCharacterEnum.CameraFocus.MoreShowList == arg_57_3 then
		local var_57_2 = UnityEngine.Screen.width
		local var_57_3 = UnityEngine.Screen.height
		local var_57_4 = Vector2(var_57_2 * 0.5, var_57_3 * 0.7)
		local var_57_5 = RoomBendingHelper.screenToWorld(var_57_4)
		local var_57_6 = RoomBendingHelper.screenToWorld(Vector2(var_57_2 * 0.5, var_57_3 * 0.5))

		if var_57_5 and var_57_6 then
			local var_57_7 = var_57_5.x - var_57_6.x
			local var_57_8 = var_57_5.y - var_57_6.y

			arg_57_1 = arg_57_1 - var_57_7
			arg_57_2 = arg_57_2 - var_57_8
		end
	end

	local var_57_9 = {
		focusX = arg_57_1,
		focusY = arg_57_2
	}

	var_57_1.camera:tweenCamera(var_57_9, nil, arg_57_4, arg_57_5)
end

function var_0_0.setFilterOnBirthday(arg_58_0, arg_58_1)
	if arg_58_1 and not RoomCharacterPlaceListModel.instance:hasHeroOnBirthday() then
		GameFacade.showToast(ToastEnum.NoCharacterOnBirthday)

		return false
	end

	RoomCharacterPlaceListModel.instance:setIsFilterOnBirthday(arg_58_1)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	return true
end

function var_0_0.onCloseRoomCharacterPlaceView(arg_59_0)
	RoomCharacterPlaceListModel.instance:setIsFilterOnBirthday()
end

var_0_0.instance = var_0_0.New()

return var_0_0

module("modules.logic.room.controller.RoomCharacterController", package.seeall)

slot0 = class("RoomCharacterController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0._refreshNextCharacterFaithUpdate, slot0)

	slot0._isCharacterListShow = false
	slot0._characterFocus = RoomCharacterEnum.CameraFocus.Normal
	slot0._lastCameraState = nil
	slot0._playingInteractionParam = nil
	slot0._dialogNextTime = nil
	slot0._lastSendgainCharacterFaithHeroId = nil
end

function slot0.addConstEvents(slot0)
end

function slot0.init(slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshRelateDot, slot0)
end

function slot0.setCharacterFocus(slot0, slot1)
	slot0._characterFocus = slot1 or RoomCharacterEnum.CameraFocus.Normal
end

function slot0.getCharacterFocus(slot0)
	return slot0._characterFocus
end

function slot0.setCharacterListShow(slot0, slot1)
	slot0._isCharacterListShow = slot1

	if GameSceneMgr.instance:getCurScene().camera:getCameraState() ~= RoomEnum.CameraState.Character then
		slot0._lastCameraState = slot3
	end

	if slot1 then
		slot2.camera:switchCameraState(RoomEnum.CameraState.Character, {})
	elseif slot3 == RoomEnum.CameraState.Character then
		slot2.camera:switchCameraState(slot0._lastCameraState or RoomEnum.CameraState.Overlook, {})

		if slot0._lastCameraState == RoomEnum.CameraState.Normal then
			slot0:tryPlayAllSpecialIdle()
		end
	end

	if slot1 then
		if UIBlockMgrExtend.needCircleMv then
			UIBlockMgrExtend.setNeedCircleMv(false)
		end

		ViewMgr.instance:openView(ViewName.RoomCharacterPlaceView)

		for slot8, slot9 in ipairs(RoomCharacterModel.instance:getList()) do
			slot2.character:setCharacterAnimal(slot9.heroId, false)
			slot2.character:setCharacterTouch(slot9.heroId, false)

			if slot9:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move then
				slot9:endMove()
				slot9:setPosition(RoomCharacterHelper.getCharacterPosition3D(slot9:getNearestPoint(), true))
			end
		end
	else
		ViewMgr.instance:closeView(ViewName.RoomCharacterPlaceView)
	end

	slot0:dispatchEvent(RoomEvent.CharacterListShowChanged, slot1)
	slot0:dispatchEvent(RoomEvent.RefreshSpineShow)

	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
		slot2.fsm:triggerEvent(RoomSceneEvent.CancelPlaceCharacter)
	end
end

function slot0.isCharacterListShow(slot0)
	return slot0._isCharacterListShow
end

function slot0.tryCorrectAllCharacter(slot0, slot1)
	slot2 = RoomCharacterModel.instance:getList()

	if slot1 == true then
		slot0:_tryRandomByCharacterList(slot2)

		for slot6, slot7 in ipairs(slot2) do
			slot0:interruptInteraction(slot7:getCurrentInteractionId())
		end

		return
	end

	slot4 = nil

	for slot8, slot9 in ipairs(RoomCharacterModel.instance:getList()) do
		if not RoomCharacterHelper.canConfirmPlace(slot9.heroId, slot9.currentPosition, slot9.skinId, nil) then
			slot11 = RoomCharacterHelper.getRandomPosition() or slot9.currentPosition

			if RoomCharacterHelper.getRecommendHexPoint(slot9.heroId, slot9.skinId, Vector2.New(slot11.x, slot11.z)) then
				slot0:moveCharacterTo(slot9, slot12.position, false)
			else
				table.insert(slot3 or {}, slot9)
			end

			slot0:interruptInteraction(slot9:getCurrentInteractionId())
		end
	end

	if slot4 then
		slot0:_tryRandomByCharacterList(slot3)
	end
end

function slot0.checkCharacterMax(slot0)
	if RoomCharacterModel.instance:getMaxCharacterCount() < RoomCharacterModel.instance:getPlaceCount() then
		slot3 = {}

		tabletool.tabletool.addValues(slot3, RoomCharacterModel.instance:getList())

		slot4 = GameSceneMgr.instance:getCurScene()

		slot0:_randomArray(slot3)

		slot5 = {}

		for slot9, slot10 in ipairs(slot3) do
			if slot10:isPlaceSourceState() then
				if slot1 > #slot5 then
					table.insert(slot5, slot10.heroId)
				else
					if slot4.charactermgr:getCharacterEntity(slot10.id) then
						slot4.charactermgr:destroyCharacter(slot11)
					end

					RoomCharacterModel.instance:deleteCharacterMO(slot10.heroId)
				end
			end
		end

		RoomRpc.instance:sendUpdateRoomHeroDataRequest(slot5)
	end
end

function slot0._findPlaceBlockMOList(slot0)
	slot3 = {}

	for slot7 = 1, #RoomMapBlockModel.instance:getFullBlockMOList() do
		slot8 = slot1[slot7]

		if not RoomMapBuildingModel.instance:getBuildingParam(slot8.hexPoint.x, slot8.hexPoint.y) and not RoomBuildingHelper.isInInitBlock(slot8.hexPoint) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0._randomArray(slot0, slot1)
	RoomHelper.randomArray(slot1)
end

function slot0._getRandomResDirectionArray(slot0)
	if not slot0._randomResDirectionList then
		slot0._randomResDirectionList = {
			0,
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	slot0:_randomArray(slot0._randomResDirectionList)

	return slot0._randomResDirectionList
end

function slot0._randomDirectionByBlockMO(slot0, slot1, slot2)
	if slot2 and slot2:getBlockDefineCfg() then
		slot5, slot6 = nil

		for slot10 = 1, #slot0:_getRandomResDirectionArray() do
			if slot1:isCanPlaceByResId(slot3.resourceIds[slot4[slot10]]) then
				return RoomRotateHelper.rotateDirection(slot6, -slot2:getRotate())
			end
		end
	end

	return nil
end

function slot0.tryRandomByCharacterList(slot0, slot1)
	slot0:_tryRandomByCharacterList(slot1)
end

function slot0._tryRandomByCharacterList(slot0, slot1)
	slot2 = slot0:_findPlaceBlockMOList()

	slot0:_randomArray(slot2)

	slot3 = #slot2
	slot4 = 1
	slot5 = nil

	RoomHelper.logEnd("RoomCharacterController:_tryRandomByCharacterList(roomCharacterMOList) start")

	for slot9, slot10 in ipairs(slot1) do
		slot11 = true

		for slot15 = slot4, slot3 do
			if slot0:_randomDirectionByBlockMO(slot10, slot2[slot15]) then
				slot19 = RoomCharacterHelper.getCharacterPosition3D(ResourcePoint(slot16.hexPoint, slot17))

				RoomHelper.logEnd(slot10.heroConfig.name)

				if RoomCharacterHelper.getRecommendHexPoint(slot10.heroId, slot10.skinId, Vector2.New(slot19.x, slot19.z)) then
					slot2[slot15] = slot2[slot4]
					slot2[slot4] = slot16
					slot4 = slot4 + 1

					slot0:moveCharacterTo(slot10, slot20 and slot20.position or slot19, false)

					slot11 = false

					break
				end
			end
		end

		if slot11 then
			table.insert(slot5 or {}, slot10)
		end
	end

	RoomHelper.logEnd("RoomCharacterController:_tryRandomByCharacterList(roomCharacterMOList) end")

	if slot5 then
		slot6 = {}

		tabletool.addValues(slot6, RoomConfig.instance:getBlockPlacePositionCfgList())
		slot0:_randomArray(slot6)

		if #slot5 > #slot6 then
			logError("export_初始坐标[\"block_place_position\"] 坐标数量不足")
		end

		for slot10 = 1, #slot5 do
			if slot6[slot10] then
				slot0:moveCharacterTo(slot5[slot10], Vector3(slot11.x * 0.001, slot11.y * 0.001, slot11.z * 0.001), false)
			end
		end
	end
end

function slot0.moveCharacterTo(slot0, slot1, slot2, slot3)
	if GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(slot1.id) then
		if slot3 then
			slot2 = RoomCharacterHelper.reCalculateHeight(slot2)
		end

		slot4.charactermgr:moveTo(slot5, slot2)
	end

	RoomCharacterModel.instance:resetCharacterMO(slot1.heroId, slot2)
end

function slot0.tryMoveCharacterAfterRotateCamera(slot0)
	for slot5, slot6 in ipairs(RoomCharacterModel.instance:getList()) do
		if slot6:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move and not RoomCharacterHelper.isMoveCameraWalkable(slot6:getRemainMovePositions()) then
			slot6:endMove(true)
			slot6:moveNeighbor()
		end
	end
end

function slot0.correctAllCharacterHeight(slot0)
	for slot5, slot6 in ipairs(RoomCharacterModel.instance:getList()) do
		slot0:correctCharacterHeight(slot6)
	end
end

function slot0.correctCharacterHeight(slot0, slot1)
	if slot1:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move or slot1:getIsFreeze() then
		return
	end

	slot3 = slot1.currentPosition

	slot1:setPositionXYZ(slot3.x, RoomCharacterHelper.getLandHeightByRaycast(slot3), slot3.z)
end

function slot0.checkCanSpineShow(slot0, slot1)
	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return false
	end

	if slot0:isCharacterListShow() then
		return true
	end

	return RoomEnum.CameraShowSpineMap[slot1]
end

function slot0.pressCharacterUp(slot0, slot1, slot2)
	if slot2 then
		slot0._pressHeroId = slot2
	end

	if not slot0._pressHeroId then
		return
	end

	if not slot0:isCharacterListShow() then
		slot0:setCharacterListShow(true)
	end

	if not GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(slot0._pressHeroId, SceneTag.RoomCharacter) then
		return
	end

	if slot2 then
		if not RoomCharacterModel.instance:getTempCharacterMO() or slot5.id ~= slot2 then
			slot3.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				press = true,
				heroId = slot2,
				position = RoomCharacterModel.instance:getCharacterMOById(slot2).currentPosition
			})
		end

		slot4:tweenUp()
		RoomCharacterPlaceListModel.instance:setSelect(slot2)
	end

	if not slot0._pressCharacterHexPoint then
		slot0._pressCharacterHexPoint = RoomCharacterModel.instance:getTempCharacterMO():getMoveTargetPoint().hexPoint
	end

	slot6 = slot0._pressCharacterHexPoint

	if not RoomBendingHelper.screenPosToHex(slot1) then
		return
	end

	slot0._pressCharacterHexPoint = slot7

	if RoomBendingHelper.screenToWorld(slot1) then
		slot9 = slot8.x
		slot10 = slot8.y
		slot11 = RoomCharacterHelper.getLandHeightByRaycast(Vector3(slot9, 0, slot10))

		slot5:setPositionXYZ(slot9, slot11, slot10)
		slot4:setLocalPos(slot9, slot11, slot10, true)
	end

	slot0:dispatchEvent(RoomEvent.PressCharacterUp)
end

function slot0.getPressCharacterHexPoint(slot0)
	return slot0._pressCharacterHexPoint
end

function slot0.dropCharacterDown(slot0, slot1)
	if not slot0._pressHeroId then
		return
	end

	slot3 = nil
	slot4 = slot1 and RoomBendingHelper.screenToWorld(slot1)

	if slot4 and RoomCharacterHelper.getRecommendHexPoint(slot0._pressHeroId, RoomCharacterModel.instance:getCharacterMOById(slot0._pressHeroId).skinId, Vector2(slot4.x, slot4.y)) then
		slot3 = slot5.position
	end

	slot0:cancelPressCharacter()
	GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
		isPressing = true,
		position = slot3 or slot2.currentPosition
	})
end

function slot0.cancelPressCharacter(slot0)
	if not slot0._pressHeroId then
		return
	end

	if not GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(slot0._pressHeroId, SceneTag.RoomCharacter) then
		return
	end

	slot0._pressHeroId = nil
	slot0._pressCharacterHexPoint = nil

	slot2:tweenDown()
	slot0:dispatchEvent(RoomEvent.DropCharacterDown)
end

function slot0.isPressCharacter(slot0)
	return slot0._pressHeroId
end

function slot0.updateCharacterFaith(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._refreshNextCharacterFaithUpdate, slot0)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	if not RoomController.instance:isObMode() then
		return
	end

	RoomCharacterModel.instance:updateCharacterFaith(slot1)
	slot0:dispatchEvent(RoomEvent.RefreshFaithShow)
	slot0:refreshCharacterFaithTimer()
end

function slot0.playCharacterFaithEffect(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	slot3 = GameSceneMgr.instance:getCurScene()

	if not RoomController.instance:isObMode() then
		return
	end

	for slot7, slot8 in ipairs(slot1) do
		if slot3.charactermgr:getCharacterEntity(slot8.heroId, SceneTag.RoomCharacter) then
			slot10:playFaithEffect()
		end
	end
end

function slot0.refreshCharacterFaithTimer(slot0)
	TaskDispatcher.cancelTask(slot0._refreshNextCharacterFaithUpdate, slot0)

	slot1 = nil

	for slot6, slot7 in ipairs(RoomCharacterModel.instance:getList()) do
		if slot7.nextRefreshTime and slot8 > 0 and (not slot1 or slot8 < slot1) then
			slot1 = slot8
		end
	end

	if slot1 and slot1 > 0 then
		TaskDispatcher.runDelay(slot0._refreshNextCharacterFaithUpdate, slot0, math.max(1, slot1 - ServerTime.now()) + 0.5)
	end
end

function slot0._refreshNextCharacterFaithUpdate(slot0)
	for slot6, slot7 in ipairs(RoomCharacterModel.instance:getList()) do
		table.insert({}, slot7.heroId)
	end

	RoomRpc.instance:sendGetRoomObInfoRequest(false, slot0._getRoomObInfoReply, slot0)
end

function slot0._getRoomObInfoReply(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0:updateCharacterFaith(slot3.roomHeroDatas)
end

function slot0.gainCharacterFaith(slot0, slot1, slot2, slot3)
	RoomRpc.instance:sendGainRoomHeroFaithRequest(slot1, slot2, slot3)
end

function slot0.findGainMaxFaithHeroId(slot0)
	slot1 = nil

	for slot7, slot8 in ipairs(RoomCharacterModel.instance:getList()) do
		if HeroModel.instance:getByHeroId(slot8.heroId) and slot8.currentFaith > 0 and -1 < slot8.currentFaith + slot9.faith then
			slot2 = slot10
			slot1 = slot8.heroId
		end
	end

	return slot1
end

function slot0.gainAllCharacterFaith(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot9, slot10 in ipairs(RoomCharacterModel.instance:getList()) do
		if slot10.currentFaith > 0 then
			table.insert(slot4, slot10.heroId)
		end
	end

	if #slot4 > 0 then
		if tabletool.indexOf(slot4, slot3) == nil then
			slot6 = tabletool.indexOf(slot4, slot0:findGainMaxFaithHeroId())
		end

		if slot6 then
			slot4[slot6] = slot4[1]
			slot4[1] = slot3
		end

		slot0._lastSendgainCharacterFaithHeroId = slot3

		slot0:gainCharacterFaith(slot4, slot1, slot2)
	end
end

function slot0.tweenCameraFocusCharacter(slot0, slot1, slot2)
	if not RoomCharacterModel.instance:getById(slot1) then
		return
	end

	slot5 = slot3.currentPosition

	GameSceneMgr.instance:getCurScene().camera:switchCameraState(slot2 or RoomEnum.CameraState.Overlook, {
		focusX = slot5.x,
		focusY = slot5.z
	})
end

function slot0.isCharacterFaithFull(slot0, slot1)
	if not HeroModel.instance:getByHeroId(slot1) then
		return false
	end

	return HeroConfig.instance:getFaithPercent(slot2.faith)[1] >= 1
end

function slot0.hideCharacterFaithFull(slot0, slot1)
	RoomCharacterModel.instance:setHideFaithFull(slot1, true)
	slot0:dispatchEvent(RoomEvent.RefreshFaithShow)
end

function slot0.setCharacterFullFaithChecked(slot0, slot1)
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.RoomCharacterFaithFull, false)
end

function slot0._refreshRelateDot(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot5 == RedDotEnum.DotNode.RoomCharacterFaithFull then
			slot0:dispatchEvent(RoomEvent.RefreshFaithShow)

			return
		end
	end
end

function slot0.showGainFaithToast(slot0, slot1)
	slot2 = {}
	slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		if slot8.materilType == MaterialEnum.MaterialType.Faith then
			if slot0._lastSendgainCharacterFaithHeroId == slot8.materilId then
				slot0._lastSendgainCharacterFaithHeroId = nil
				slot3 = slot8
			end

			table.insert(slot2, slot8)
		end
	end

	if #slot2 <= 0 then
		return
	end

	if not HeroModel.instance:getByHeroId((slot3 or slot2[1]).materilId) then
		return
	end

	if slot4 > 1 then
		GameFacade.showToast(RoomEnum.Toast.GainFaithMultipleCharacter, slot6.config.name)
	else
		GameFacade.showToast(RoomEnum.Toast.GainFaithSingleCharacter, slot6.config.name, HeroConfig.instance:getFaithPercent(slot6.faith)[1] * 100)
	end

	for slot10, slot11 in ipairs(slot2) do
		if HeroModel.instance:getByHeroId(slot11.materilId) and HeroConfig.instance:getFaithPercent(slot12.faith)[1] >= 1 then
			GameFacade.showToast(RoomEnum.Toast.GainFaithFull)

			return
		end
	end
end

function slot0.interruptInteraction(slot0, slot1)
	if not slot1 then
		return
	end

	if RoomConfig.instance:getCharacterInteractionConfig(slot1).behaviour == RoomCharacterEnum.InteractionType.Dialog then
		if RoomCharacterModel.instance:getCharacterMOById(slot2.heroId) then
			slot3:setCurrentInteractionId(nil)
		end

		if RoomCharacterModel.instance:getCharacterMOById(slot2.relateHeroId) then
			slot4:setCurrentInteractionId(nil)
		end
	elseif slot2.behaviour == RoomCharacterEnum.InteractionType.Building then
		-- Nothing
	end

	slot0:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function slot0.startInteraction(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot0._interactionGetReward = slot2
	slot0._interactionGetFaith = slot3

	if not slot0._interactionGetReward or RoomModel.instance:getInteractionState(slot1) == RoomCharacterEnum.InteractionState.Start then
		slot0:_onRealStartInteraction(slot1)
	else
		RoomRpc.instance:sendStartCharacterInteractionRequest(slot1, slot0._onStartInteraction, slot0)
	end
end

function slot0._onStartInteraction(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0:_onRealStartInteraction(slot3.id)
end

function slot0._onRealStartInteraction(slot0, slot1)
	if RoomConfig.instance:getCharacterInteractionConfig(slot1).behaviour == RoomCharacterEnum.InteractionType.Dialog then
		slot0:startDialogInteraction(slot2)
	else
		slot0._playingInteractionParam = {}
	end

	slot0:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function slot0.startDialogInteraction(slot0, slot1, slot2)
	slot3 = slot1.dialogId
	slot0._playingInteractionParam = {
		stepId = 0,
		id = slot1.id,
		behaviour = slot1.behaviour,
		dialogId = slot1.dialogId,
		heroId = slot1.heroId,
		relateHeroId = slot1.relateHeroId,
		selectIds = {},
		buildingUid = slot2,
		positionList = {}
	}

	if slot1.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		slot0:tweenDialogCamera(slot1)
	end
end

function slot0.startDialogTrainCritter(slot0, slot1, slot2, slot3)
	slot0._playingInteractionParam = {
		stepId = 0,
		id = slot1.id,
		behaviour = slot1.behaviour,
		dialogId = slot1.dialogId,
		heroId = slot1.heroId,
		relateHeroId = slot1.relateHeroId,
		selectIds = {},
		positionList = {},
		critterUid = slot2
	}

	slot0:nextDialogInteraction()
end

function slot0.tweenDialogCamera(slot0, slot1)
	slot3 = RoomCharacterModel.instance:getCharacterMOById(slot1.heroId)

	slot3:endMove(true)
	table.insert(slot0._playingInteractionParam.positionList, slot3.currentPosition)

	if slot1.relateHeroId == 0 then
		slot5 = {
			zoom = 0.2,
			focusX = slot4.x,
			focusY = slot4.z
		}

		GameSceneMgr.instance:getCurScene().camera:switchCameraState(RoomEnum.CameraState.Normal, slot5, nil, slot0.interactionCameraDone, slot0)

		slot0._playingInteractionParam.cameraParam = slot5

		return
	end

	slot5 = RoomCharacterModel.instance:getCharacterMOById(slot1.relateHeroId)

	slot5:endMove(true)

	slot6 = slot5.currentPosition

	table.insert(slot0._playingInteractionParam.positionList, slot6)

	slot7 = (slot4 + slot6) / 2
	slot8 = Vector3.Normalize(slot6 - slot4)

	if slot8.x < 0 then
		slot9 = RoomRotateHelper.getMod(math.pi * 2 - math.acos(Vector3.Dot(slot8, Vector3.forward)), math.pi * 2)
	end

	slot10 = RoomRotateHelper.getMod(slot9 + math.pi / 2, math.pi * 2)
	slot11 = RoomRotateHelper.getMod(slot9 - math.pi / 2, math.pi * 2)
	slot12 = RoomRotateHelper.getMod(slot2.camera:getCameraRotate(), math.pi * 2)
	slot13 = slot10

	if (math.min(math.abs(slot11 - slot12), math.pi * 2 - math.abs(slot11 - slot12)) < math.min(math.abs(slot10 - slot12), math.pi * 2 - math.abs(slot10 - slot12)) and SpineLookDir.Left or SpineLookDir.Right) == SpineLookDir.Left then
		slot13 = slot11
	end

	if slot2.charactermgr:getCharacterEntity(slot3.id, SceneTag.RoomCharacter) and slot17.charactermove then
		slot17.charactermove:forcePositionAndLookDir(nil, -slot16, nil)
	end

	if slot2.charactermgr:getCharacterEntity(slot5.id, SceneTag.RoomCharacter) and slot18.charactermove then
		slot18.charactermove:forcePositionAndLookDir(nil, slot16, nil)
	end

	slot19 = {
		zoom = 0.2,
		focusX = slot7.x,
		focusY = slot7.z,
		rotate = slot13
	}

	slot2.camera:switchCameraState(RoomEnum.CameraState.Normal, slot19, nil, slot0.interactionCameraDone, slot0)

	slot0._playingInteractionParam.cameraParam = slot19
end

function slot0.trynextDialogInteraction(slot0)
	if slot0._dialogNextTime and Time.time < slot0._dialogNextTime then
		return
	end

	slot0._dialogNextTime = Time.time + RoomCharacterEnum.DialogClickCDTime

	slot0:nextDialogInteraction()
end

function slot0.interactionCameraDone(slot0)
	slot0:nextDialogInteraction()

	slot1 = GameSceneMgr.instance:getCurScene()
end

function slot0.nextDialogInteraction(slot0, slot1)
	if not slot0._playingInteractionParam or slot0._playingInteractionParam.behaviour ~= RoomCharacterEnum.InteractionType.Dialog then
		return
	end

	slot2 = RoomConfig.instance:getCharacterDialogConfig(slot0._playingInteractionParam.dialogId, slot0._playingInteractionParam.stepId)

	if not slot1 and slot2 and not string.nilorempty(slot2.selectIds) then
		slot0._playingInteractionParam.selectParam = GameUtil.splitString2(slot2.selectIds, true)

		slot0:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)

		if not ViewMgr.instance:isOpen(ViewName.RoomBranchView) then
			ViewMgr.instance:openView(ViewName.RoomBranchView)
		end

		return
	end

	if slot1 and slot0._playingInteractionParam.selectParam then
		slot0._playingInteractionParam.stepId = slot0._playingInteractionParam.selectParam[slot1][2]
		slot0._playingInteractionParam.selectParam = nil

		table.insert(slot0._playingInteractionParam.selectIds, slot0._playingInteractionParam.selectParam[slot1][1])
	elseif slot2 and not string.nilorempty(slot2.nextStepId) then
		slot0._playingInteractionParam.stepId = tonumber(slot2.nextStepId)
	else
		slot0._playingInteractionParam.stepId = slot0._playingInteractionParam.stepId + 1
	end

	if not RoomConfig.instance:getCharacterDialogConfig(slot0._playingInteractionParam.dialogId, slot0._playingInteractionParam.stepId) then
		slot0:finishInteraction()
	else
		slot0:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)

		if not ViewMgr.instance:isOpen(ViewName.RoomBranchView) then
			ViewMgr.instance:openView(ViewName.RoomBranchView)
		end
	end
end

function slot0.finishInteraction(slot0)
	ViewMgr.instance:closeView(ViewName.RoomBranchView)

	if not slot0._playingInteractionParam then
		return
	end

	if slot0._interactionGetReward then
		slot0._interactionGetReward = false

		RoomRpc.instance:sendGetCharacterInteractionBonusRequest(slot0._playingInteractionParam.id, slot0._playingInteractionParam.selectIds)
	end

	if slot0._interactionGetFaith then
		slot0._interactionGetFaith = false

		uv0.instance:gainAllCharacterFaith(nil, , slot0._playingInteractionParam.heroId)
	end

	if slot0._playingInteractionParam.critterUid then
		CritterController.instance:finishTrainSpecialEventByUid(slot1)
	end

	slot0:endInteraction()
end

function slot0.endInteraction(slot0)
	if not slot0._playingInteractionParam then
		return
	end

	slot2 = slot0._playingInteractionParam.id
	slot0._playingInteractionParam = nil
	slot0._dialogNextTime = nil

	slot0:interruptInteraction(slot2)

	if RoomConfig.instance:getCharacterInteractionConfig(slot2).behaviour == RoomCharacterEnum.InteractionType.Dialog then
		if RoomCharacterModel.instance:getCharacterMOById(slot3.heroId) then
			slot4:setCurrentInteractionId(nil)

			if GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(slot4.id, SceneTag.RoomCharacter) and slot5.charactermove then
				slot5.charactermove:clearForcePositionAndLookDir()
			end
		end

		if RoomCharacterModel.instance:getCharacterMOById(slot3.relateHeroId) then
			slot5:setCurrentInteractionId(nil)

			if slot1.charactermgr:getCharacterEntity(slot5.id, SceneTag.RoomCharacter) and slot6.charactermove then
				slot6.charactermove:clearForcePositionAndLookDir()
			end
		end
	end
end

function slot0.getPlayingInteractionParam(slot0)
	return slot0._playingInteractionParam
end

function slot0.tryPlayAllSpecialIdle(slot0)
	for slot5, slot6 in ipairs(RoomCharacterModel.instance:getList()) do
		slot0:tryPlaySpecialIdle(slot6.id)
	end
end

function slot0.tryPlaySpecialIdle(slot0, slot1)
	slot2 = GameSceneMgr.instance:getCurScene()

	if not RoomCharacterModel.instance:getCharacterMOById(slot1) then
		return
	end

	if not slot2.charactermgr:getCharacterEntity(slot1) then
		return
	end

	if slot4.characterspine:isRandomSpecialRate() then
		slot4.characterspine:tryPlaySpecialIdle()

		slot3.stateDuration = -5
	end
end

function slot0.tweenCameraFocus(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = GameSceneMgr.instance:getCurScene()

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room or not slot7 or not slot7.camera then
		return
	end

	if RoomCharacterEnum.CameraFocus.MoreShowList == slot3 then
		slot8 = UnityEngine.Screen.width
		slot9 = UnityEngine.Screen.height
		slot12 = RoomBendingHelper.screenToWorld(Vector2(slot8 * 0.5, slot9 * 0.5))

		if RoomBendingHelper.screenToWorld(Vector2(slot8 * 0.5, slot9 * 0.7)) and slot12 then
			slot1 = slot1 - (slot11.x - slot12.x)
			slot2 = slot2 - (slot11.y - slot12.y)
		end
	end

	slot7.camera:tweenCamera({
		focusX = slot1,
		focusY = slot2
	}, nil, slot4, slot5)
end

function slot0.setFilterOnBirthday(slot0, slot1)
	if slot1 and not RoomCharacterPlaceListModel.instance:hasHeroOnBirthday() then
		GameFacade.showToast(ToastEnum.NoCharacterOnBirthday)

		return false
	end

	RoomCharacterPlaceListModel.instance:setIsFilterOnBirthday(slot1)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	return true
end

function slot0.onCloseRoomCharacterPlaceView(slot0)
	RoomCharacterPlaceListModel.instance:setIsFilterOnBirthday()
end

slot0.instance = slot0.New()

return slot0

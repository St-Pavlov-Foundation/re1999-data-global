module("modules.logic.room.model.map.RoomCharacterMO", package.seeall)

slot0 = pureTable("RoomCharacterMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.heroId
	slot0.heroId = slot1.heroId
	slot0.currentFaith = slot1.currentFaith or 0
	slot0.currentMinute = slot1.currentMinute or 0
	slot0.nextRefreshTime = slot1.nextRefreshTime or 0
	slot0.skinId = slot1.skinId

	if (not slot0.skinId or slot0.skinId == 0) and (RoomController.instance:isObMode() or RoomController.instance:isEditMode()) then
		slot0.skinId = HeroModel.instance:getByHeroId(slot0.heroId) and slot2.skin or slot0.skinId
	end

	if not slot0.skinId or slot0.skinId == 0 then
		slot0.skinId = HeroConfig.instance:getHeroCO(slot0.heroId).skinId
	end

	slot0.currentPosition = slot1.currentPosition
	slot0.characterState = slot1.characterState
	slot0.heroConfig = HeroConfig.instance:getHeroCO(slot0.heroId)
	slot0.skinConfig = SkinConfig.instance:getSkinCo(slot0.skinId)
	slot0.roomCharacterConfig = RoomConfig.instance:getRoomCharacterConfig(slot0.skinId)
	slot0._nextPositions = slot1.nextPositions or {}
	slot0._movePoint = slot1.movePoint or 0
	slot0._moveValue = slot1.moveValue or 0
	slot0._moveState = slot1.moveState or RoomCharacterEnum.CharacterMoveState.Idle
	slot0.stateDuration = slot1.stateDuration or 0
	slot0._moveDir = slot1.moveDir or Vector2.zero
	slot0._preMovePositions = slot1.preMovePositions
	slot0.isAnimal = slot1.isAnimal or false
	slot0.isTouch = slot1.isTouch or false
	slot0.trainCritterUid = slot1.trainCritterUid or slot0.trainCritterUid or nil
	slot0.sourceState = slot1.sourceState or RoomCharacterEnum.SourceState.Place
	slot0._currentInteractionId = nil
	slot0._replaceIdleState = nil
	slot0._positionCodeId = slot0._positionCodeId or 0
	slot0.tranMoveRate = 0.8

	slot0:_updatePositionCodeId()

	if not string.nilorempty(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.HeroMoveRate)) then
		slot0.tranMoveRate = tonumber(slot2) * 0.001
	end
end

function slot0.getCanWade(slot0)
	return slot0.skinConfig.canWade > 0
end

function slot0.getMoveSpeed(slot0)
	return slot0.roomCharacterConfig and slot0.roomCharacterConfig.moveSpeed or 1
end

function slot0.getMoveInterval(slot0)
	return slot0.roomCharacterConfig and slot0.roomCharacterConfig.moveInterval or 5
end

function slot0.getMoveRate(slot0)
	if slot0.trainCritterUid then
		return slot0.tranMoveRate
	end

	return slot0.roomCharacterConfig and slot0.roomCharacterConfig.moveRate / 1000 or 0.5
end

function slot0.getSpecialRate(slot0)
	return slot0.roomCharacterConfig and slot0.roomCharacterConfig.specialRate / 1000 or 0.5
end

function slot0.isHasSpecialIdle(slot0)
	return slot0.roomCharacterConfig.specialIdle > 0
end

function slot0.getMoveState(slot0)
	if slot0._replaceIdleState and slot0._moveState == RoomCharacterEnum.CharacterMoveState.Idle then
		return slot0._replaceIdleState
	end

	return slot0._moveState
end

function slot0.isPlaceSourceState(slot0)
	return slot0.sourceState ~= RoomCharacterEnum.SourceState.Train
end

function slot0.isTrainSourceState(slot0)
	return slot0.sourceState == RoomCharacterEnum.SourceState.Train
end

function slot0.isCanPlaceByResId(slot0, slot1)
	if slot1 == RoomResourceEnum.ResourceId.Empty or slot1 == RoomResourceEnum.ResourceId.None or slot1 == RoomResourceEnum.ResourceId.Flag or slot1 == RoomResourceEnum.ResourceId.River and slot0:getCanWade() then
		return true
	end

	return false
end

function slot0.isTraining(slot0)
	if slot0.trainCritterUid and slot0.trainCritterUid ~= 0 then
		return true
	end

	return false
end

function slot0.getMovingDir(slot0)
	return slot0._moveDir
end

function slot0.getPositionCodeId(slot0)
	return slot0._positionCodeId
end

function slot0._updatePositionCodeId(slot0)
	slot0._positionCodeId = slot0._positionCodeId + 1
end

function slot0.getSpecialIdleWaterDistance(slot0)
	return slot0.roomCharacterConfig and slot0.roomCharacterConfig.waterDistance / 1000 or 0.5
end

function slot0.setPosition(slot0, slot1)
	slot0.currentPosition = slot1

	slot0:_updatePositionCodeId()
end

function slot0.setPositionXYZ(slot0, slot1, slot2, slot3)
	slot0.currentPosition:Set(slot1, slot2, slot3)
	slot0:_updatePositionCodeId()
end

function slot0.getMoveTargetPosition(slot0)
	slot1 = slot0.currentPosition

	if slot0._nextPositions and #slot0._nextPositions > 0 then
		slot1 = slot0._nextPositions[#slot0._nextPositions]
	end

	return slot1
end

function slot0.getMoveTargetPoint(slot0)
	return RoomCharacterHelper.positionRoundToPoint(slot0:getMoveTargetPosition())
end

function slot0.getNearestPoint(slot0)
	return RoomCharacterHelper.positionRoundToPoint(slot0.currentPosition)
end

function slot0.setPreMove(slot0, slot1)
	slot0._preMovePositions = slot1

	slot0:_tryNextMovePosition()
end

function slot0._tryNextMovePosition(slot0)
	slot1 = GameSceneMgr.instance:getCurScene()

	slot1.path:stopGetPath(slot0)

	if not slot1.charactermgr:getCharacterEntity(slot0.id) then
		return
	end

	if not slot2.charactermove:getSeeker() then
		return
	end

	while slot0._preMovePositions and #slot0._preMovePositions > 0 do
		table.remove(slot0._preMovePositions, #slot0._preMovePositions)

		if ZProj.AStarPathBridge.HasPossiblePath(slot0.currentPosition, slot0._preMovePositions[#slot0._preMovePositions], slot3:GetTag()) then
			slot1.path:tryGetPath(slot0, slot0.currentPosition, slot4, slot0.onPathCall, slot0)

			return
		end
	end
end

function slot0.setMove(slot0, slot1)
	if not slot1 or #slot1 <= 0 then
		return
	end

	slot0._moveState = RoomCharacterEnum.CharacterMoveState.Move
	slot0._moveStartPosition = slot0.currentPosition

	slot0:clearPath()
	tabletool.addValues(slot0._nextPositions, slot1)

	slot0._movePoint = 0
	slot0.stateDuration = 0

	GameSceneMgr.instance:getCurScene().path:stopGetPath(slot0)

	slot0._preMovePositions = nil
end

function slot0.getRemainMovePositions(slot0)
	if slot0._moveState ~= RoomCharacterEnum.CharacterMoveState.Move then
		return {}
	end

	if not slot0._nextPositions or #slot0._nextPositions <= 0 then
		return slot1
	end

	slot5 = slot0.currentPosition

	table.insert(slot1, slot5)

	for slot5 = slot0._movePoint + 1, #slot0._nextPositions do
		table.insert(slot1, slot0._nextPositions[slot5])
	end

	return slot1
end

function slot0.endMove(slot0, slot1)
	if slot0._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		if not slot1 and slot0:_hasNextPosition() then
			slot2 = slot0._nextPositions[#slot0._nextPositions]

			slot0:setPositionXYZ(slot2.x, slot2.y, slot2.z)
		end

		slot0:_moveEnd()
	end
end

function slot0.canMove(slot0)
	if slot0.isAnimal then
		return false
	end

	if slot0.isTouch then
		return false
	end

	if slot0._currentInteractionId then
		return false
	end

	if slot0._isHasLockTime then
		slot0._isHasLockTime = Time.time < slot0._nextUnLockTime

		return false
	end

	if RoomCharacterController.instance:getPlayingInteractionParam() and (slot1.heroId == slot0.heroId or slot1.relateHeroId == slot0.heroId) then
		return false
	end

	return true
end

function slot0.setLockTime(slot0, slot1)
	slot0._isHasLockTime = true
	slot0._nextUnLockTime = Time.time + slot1

	if slot0._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		slot0._moveState = RoomCharacterEnum.CharacterMoveState.Idle
	end
end

function slot0._tryMoveNeighbor(slot0)
	if RoomCharacterController.instance:isCharacterListShow() then
		return
	end

	if not slot0:canMove() then
		return
	end

	if slot0:getMoveRate() <= math.random() then
		RoomCharacterController.instance:tryPlaySpecialIdle(slot0.heroId)

		return
	end

	slot0:moveNeighbor()
end

function slot0.moveNeighbor(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = slot0:getMoveTargetPoint()
	slot6 = RoomCharacterHelper.getCharacterPosition(slot3)

	for slot10, slot11 in ipairs(slot3.hexPoint:getInRanges(2)) do
		for slot15 = 0, 6 do
			if ResourcePoint(slot11, slot15) ~= slot3 then
				table.insert(slot2, {
					resourcePoint = slot16,
					distance = Vector2.Distance(RoomCharacterHelper.getCharacterPosition(slot16), slot6)
				})
			end
		end
	end

	table.sort(GameUtil.randomTable(slot2), function (slot0, slot1)
		if math.abs(slot0.distance - slot1.distance) > 0.001 then
			return slot0.distance < slot1.distance
		end

		return false
	end)

	slot7 = RoomCharacterHelper.getBridgePositions(slot0.currentPosition)
	slot8 = nil

	if math.random() < 0.4 and (not slot0._preBridge or slot0._preBridge < 2) then
		slot8 = 1
	else
		slot0._preBridge = 0
	end

	for slot12, slot13 in ipairs(slot7) do
		if slot8 then
			table.insert(slot2, slot8, {
				isBridge = true,
				position = slot13
			})
		else
			table.insert(slot2, slot14)
		end
	end

	if GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(slot0.id) ~= nil then
		slot11 = {}

		for slot15, slot16 in ipairs(slot2) do
			if RoomCharacterHelper.checkMoveStraightRule(slot0.currentPosition, slot16.position or RoomCharacterHelper.getCharacterPosition3D(slot16.resourcePoint, false), slot0.heroId, slot10, slot16.isBridge) then
				slot0._preBridge = (slot0._preBridge or 0) + (slot16.isBridge and 1 or 0)

				table.insert(slot11, slot17)
			end
		end

		slot0:setPreMove(slot11)
	end
end

function slot0.onPathCall(slot0, slot1, slot2, slot3, slot4)
	if not slot3 then
		slot5 = RoomVectorPool.instance:packPosList(slot2)

		if RoomCharacterHelper.isMoveCameraWalkable(slot5) and not RoomCharacterHelper.isOtherCharacter(slot5[#slot5], slot0.heroId) then
			slot0:setMove(slot5)

			return
		end
	else
		logNormal("Room pathfinding Error : " .. tostring(slot4))
	end

	slot0:_tryNextMovePosition()
end

function slot0._moveEnd(slot0, slot1)
	slot0._moveState = RoomCharacterEnum.CharacterMoveState.Idle

	slot0:clearPath()

	slot0._movePoint = 0
	slot0._moveValue = 0
	slot0.stateDuration = 0

	GameSceneMgr.instance:getCurScene().path:stopGetPath(slot0)

	slot0._preMovePositions = nil

	if slot1 then
		RoomCharacterController.instance:tryPlaySpecialIdle(slot0.heroId)
	end
end

function slot0.replaceIdleState(slot0, slot1)
	slot0._replaceIdleState = slot1
end

function slot0.clearPath(slot0)
	if #slot0._nextPositions > 0 then
		for slot4 = #slot0._nextPositions, 1, -1 do
			RoomVectorPool.instance:recycle(slot0._nextPositions[slot4])
			table.remove(slot0._nextPositions, slot4)
		end
	end
end

function slot0.updateMove(slot0, slot1)
	if slot0.characterState ~= RoomCharacterEnum.CharacterState.Map then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		return
	end

	if not slot0:canMove() then
		return
	end

	slot0.stateDuration = slot0.stateDuration + slot1

	if slot0:getMoveInterval() < slot0.stateDuration and slot0._moveState ~= RoomCharacterEnum.CharacterMoveState.Move then
		slot0:_tryMoveNeighbor()

		slot0.stateDuration = 0
	end

	if slot0._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		slot0:_move(slot1 * slot0:getMoveSpeed() * 0.2)
	end
end

function slot0._move(slot0, slot1)
	if not slot0:_hasNextPosition() then
		slot0:_moveEnd()

		return
	end

	if slot1 <= 0 then
		return
	end

	slot2 = slot1
	slot5 = Vector3.Distance(slot0.currentPosition, slot0:_getNextPosition())

	while slot5 < slot2 do
		slot2 = slot2 - slot5

		slot0:_moveToNextPosition()

		if slot0:_hasNextPosition() then
			slot5 = Vector3.Distance(slot4, slot0:_getNextPosition())
		else
			slot5 = 0

			break
		end
	end

	if slot5 > 0 then
		slot0:setPosition(Vector3.Lerp(slot3, slot4, slot2 / slot5))

		slot0._moveDir = Vector2(slot4.x - slot3.x, slot4.z - slot3.z):SetNormalize()
	else
		slot0:setPositionXYZ(slot3.x, slot3.y, slot3.z)
	end

	if not slot0:_hasNextPosition() then
		slot0:_moveEnd(true)
	end
end

function slot0._hasNextPosition(slot0)
	return slot0._movePoint < #slot0._nextPositions
end

function slot0._getNextPosition(slot0)
	return slot0._nextPositions[slot0._movePoint + 1]
end

function slot0._moveToNextPosition(slot0)
	slot0._movePoint = slot0._movePoint + 1
end

function slot0.setCurrentInteractionId(slot0, slot1)
	slot0._currentInteractionId = slot1
end

function slot0.getCurrentInteractionId(slot0)
	return slot0._currentInteractionId
end

function slot0.setIsFreeze(slot0, slot1)
	slot0._freeze = slot1
end

function slot0.getIsFreeze(slot0)
	return slot0._freeze
end

return slot0

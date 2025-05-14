module("modules.logic.room.model.map.RoomCharacterMO", package.seeall)

local var_0_0 = pureTable("RoomCharacterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.heroId
	arg_1_0.heroId = arg_1_1.heroId
	arg_1_0.currentFaith = arg_1_1.currentFaith or 0
	arg_1_0.currentMinute = arg_1_1.currentMinute or 0
	arg_1_0.nextRefreshTime = arg_1_1.nextRefreshTime or 0
	arg_1_0.skinId = arg_1_1.skinId

	if (not arg_1_0.skinId or arg_1_0.skinId == 0) and (RoomController.instance:isObMode() or RoomController.instance:isEditMode()) then
		local var_1_0 = HeroModel.instance:getByHeroId(arg_1_0.heroId)

		arg_1_0.skinId = var_1_0 and var_1_0.skin or arg_1_0.skinId
	end

	if not arg_1_0.skinId or arg_1_0.skinId == 0 then
		arg_1_0.skinId = HeroConfig.instance:getHeroCO(arg_1_0.heroId).skinId
	end

	arg_1_0.currentPosition = arg_1_1.currentPosition
	arg_1_0.characterState = arg_1_1.characterState
	arg_1_0.heroConfig = HeroConfig.instance:getHeroCO(arg_1_0.heroId)
	arg_1_0.skinConfig = SkinConfig.instance:getSkinCo(arg_1_0.skinId)
	arg_1_0.roomCharacterConfig = RoomConfig.instance:getRoomCharacterConfig(arg_1_0.skinId)
	arg_1_0._nextPositions = arg_1_1.nextPositions or {}
	arg_1_0._movePoint = arg_1_1.movePoint or 0
	arg_1_0._moveValue = arg_1_1.moveValue or 0
	arg_1_0._moveState = arg_1_1.moveState or RoomCharacterEnum.CharacterMoveState.Idle
	arg_1_0.stateDuration = arg_1_1.stateDuration or 0
	arg_1_0._moveDir = arg_1_1.moveDir or Vector2.zero
	arg_1_0._preMovePositions = arg_1_1.preMovePositions
	arg_1_0.isAnimal = arg_1_1.isAnimal or false
	arg_1_0.isTouch = arg_1_1.isTouch or false
	arg_1_0.trainCritterUid = arg_1_1.trainCritterUid or arg_1_0.trainCritterUid or nil
	arg_1_0.sourceState = arg_1_1.sourceState or RoomCharacterEnum.SourceState.Place
	arg_1_0._currentInteractionId = nil
	arg_1_0._replaceIdleState = nil
	arg_1_0._positionCodeId = arg_1_0._positionCodeId or 0
	arg_1_0.tranMoveRate = 0.8

	arg_1_0:_updatePositionCodeId()

	local var_1_1 = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.HeroMoveRate)

	if not string.nilorempty(var_1_1) then
		arg_1_0.tranMoveRate = tonumber(var_1_1) * 0.001
	end
end

function var_0_0.getCanWade(arg_2_0)
	return arg_2_0.skinConfig.canWade > 0
end

function var_0_0.getMoveSpeed(arg_3_0)
	return arg_3_0.roomCharacterConfig and arg_3_0.roomCharacterConfig.moveSpeed or 1
end

function var_0_0.getMoveInterval(arg_4_0)
	return arg_4_0.roomCharacterConfig and arg_4_0.roomCharacterConfig.moveInterval or 5
end

function var_0_0.getMoveRate(arg_5_0)
	if arg_5_0.trainCritterUid then
		return arg_5_0.tranMoveRate
	end

	return arg_5_0.roomCharacterConfig and arg_5_0.roomCharacterConfig.moveRate / 1000 or 0.5
end

function var_0_0.getSpecialRate(arg_6_0)
	return arg_6_0.roomCharacterConfig and arg_6_0.roomCharacterConfig.specialRate / 1000 or 0.5
end

function var_0_0.isHasSpecialIdle(arg_7_0)
	return arg_7_0.roomCharacterConfig.specialIdle > 0
end

function var_0_0.getMoveState(arg_8_0)
	if arg_8_0._replaceIdleState and arg_8_0._moveState == RoomCharacterEnum.CharacterMoveState.Idle then
		return arg_8_0._replaceIdleState
	end

	return arg_8_0._moveState
end

function var_0_0.isPlaceSourceState(arg_9_0)
	return arg_9_0.sourceState ~= RoomCharacterEnum.SourceState.Train
end

function var_0_0.isTrainSourceState(arg_10_0)
	return arg_10_0.sourceState == RoomCharacterEnum.SourceState.Train
end

function var_0_0.isCanPlaceByResId(arg_11_0, arg_11_1)
	if arg_11_1 == RoomResourceEnum.ResourceId.Empty or arg_11_1 == RoomResourceEnum.ResourceId.None or arg_11_1 == RoomResourceEnum.ResourceId.Flag or arg_11_1 == RoomResourceEnum.ResourceId.River and arg_11_0:getCanWade() then
		return true
	end

	return false
end

function var_0_0.isTraining(arg_12_0)
	if arg_12_0.trainCritterUid and arg_12_0.trainCritterUid ~= 0 then
		return true
	end

	return false
end

function var_0_0.getMovingDir(arg_13_0)
	return arg_13_0._moveDir
end

function var_0_0.getPositionCodeId(arg_14_0)
	return arg_14_0._positionCodeId
end

function var_0_0._updatePositionCodeId(arg_15_0)
	arg_15_0._positionCodeId = arg_15_0._positionCodeId + 1
end

function var_0_0.getSpecialIdleWaterDistance(arg_16_0)
	return arg_16_0.roomCharacterConfig and arg_16_0.roomCharacterConfig.waterDistance / 1000 or 0.5
end

function var_0_0.setPosition(arg_17_0, arg_17_1)
	arg_17_0.currentPosition = arg_17_1

	arg_17_0:_updatePositionCodeId()
end

function var_0_0.setPositionXYZ(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0.currentPosition:Set(arg_18_1, arg_18_2, arg_18_3)
	arg_18_0:_updatePositionCodeId()
end

function var_0_0.getMoveTargetPosition(arg_19_0)
	local var_19_0 = arg_19_0.currentPosition

	if arg_19_0._nextPositions and #arg_19_0._nextPositions > 0 then
		var_19_0 = arg_19_0._nextPositions[#arg_19_0._nextPositions]
	end

	return var_19_0
end

function var_0_0.getMoveTargetPoint(arg_20_0)
	local var_20_0 = arg_20_0:getMoveTargetPosition()

	return RoomCharacterHelper.positionRoundToPoint(var_20_0)
end

function var_0_0.getNearestPoint(arg_21_0)
	local var_21_0 = arg_21_0.currentPosition

	return RoomCharacterHelper.positionRoundToPoint(var_21_0)
end

function var_0_0.setPreMove(arg_22_0, arg_22_1)
	arg_22_0._preMovePositions = arg_22_1

	arg_22_0:_tryNextMovePosition()
end

function var_0_0._tryNextMovePosition(arg_23_0)
	local var_23_0 = GameSceneMgr.instance:getCurScene()

	var_23_0.path:stopGetPath(arg_23_0)

	local var_23_1 = var_23_0.charactermgr:getCharacterEntity(arg_23_0.id)

	if not var_23_1 then
		return
	end

	local var_23_2 = var_23_1.charactermove:getSeeker()

	if not var_23_2 then
		return
	end

	while arg_23_0._preMovePositions and #arg_23_0._preMovePositions > 0 do
		local var_23_3 = arg_23_0._preMovePositions[#arg_23_0._preMovePositions]

		table.remove(arg_23_0._preMovePositions, #arg_23_0._preMovePositions)

		if ZProj.AStarPathBridge.HasPossiblePath(arg_23_0.currentPosition, var_23_3, var_23_2:GetTag()) then
			var_23_0.path:tryGetPath(arg_23_0, arg_23_0.currentPosition, var_23_3, arg_23_0.onPathCall, arg_23_0)

			return
		end
	end
end

function var_0_0.setMove(arg_24_0, arg_24_1)
	if not arg_24_1 or #arg_24_1 <= 0 then
		return
	end

	arg_24_0._moveState = RoomCharacterEnum.CharacterMoveState.Move
	arg_24_0._moveStartPosition = arg_24_0.currentPosition

	arg_24_0:clearPath()
	tabletool.addValues(arg_24_0._nextPositions, arg_24_1)

	arg_24_0._movePoint = 0
	arg_24_0.stateDuration = 0

	GameSceneMgr.instance:getCurScene().path:stopGetPath(arg_24_0)

	arg_24_0._preMovePositions = nil
end

function var_0_0.getRemainMovePositions(arg_25_0)
	local var_25_0 = {}

	if arg_25_0._moveState ~= RoomCharacterEnum.CharacterMoveState.Move then
		return var_25_0
	end

	if not arg_25_0._nextPositions or #arg_25_0._nextPositions <= 0 then
		return var_25_0
	end

	table.insert(var_25_0, arg_25_0.currentPosition)

	for iter_25_0 = arg_25_0._movePoint + 1, #arg_25_0._nextPositions do
		table.insert(var_25_0, arg_25_0._nextPositions[iter_25_0])
	end

	return var_25_0
end

function var_0_0.endMove(arg_26_0, arg_26_1)
	if arg_26_0._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		if not arg_26_1 and arg_26_0:_hasNextPosition() then
			local var_26_0 = arg_26_0._nextPositions[#arg_26_0._nextPositions]

			arg_26_0:setPositionXYZ(var_26_0.x, var_26_0.y, var_26_0.z)
		end

		arg_26_0:_moveEnd()
	end
end

function var_0_0.canMove(arg_27_0)
	if arg_27_0.isAnimal then
		return false
	end

	if arg_27_0.isTouch then
		return false
	end

	if arg_27_0._currentInteractionId then
		return false
	end

	if arg_27_0._isHasLockTime then
		arg_27_0._isHasLockTime = arg_27_0._nextUnLockTime > Time.time

		return false
	end

	local var_27_0 = RoomCharacterController.instance:getPlayingInteractionParam()

	if var_27_0 and (var_27_0.heroId == arg_27_0.heroId or var_27_0.relateHeroId == arg_27_0.heroId) then
		return false
	end

	return true
end

function var_0_0.setLockTime(arg_28_0, arg_28_1)
	arg_28_0._isHasLockTime = true
	arg_28_0._nextUnLockTime = Time.time + arg_28_1

	if arg_28_0._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		arg_28_0._moveState = RoomCharacterEnum.CharacterMoveState.Idle
	end
end

function var_0_0._tryMoveNeighbor(arg_29_0)
	if RoomCharacterController.instance:isCharacterListShow() then
		return
	end

	if not arg_29_0:canMove() then
		return
	end

	if arg_29_0:getMoveRate() <= math.random() then
		RoomCharacterController.instance:tryPlaySpecialIdle(arg_29_0.heroId)

		return
	end

	arg_29_0:moveNeighbor()
end

function var_0_0.moveNeighbor(arg_30_0)
	local var_30_0 = {}
	local var_30_1 = {}
	local var_30_2 = arg_30_0:getMoveTargetPoint()
	local var_30_3 = var_30_2.hexPoint:getInRanges(2)
	local var_30_4 = RoomCharacterHelper.getCharacterPosition(var_30_2)

	for iter_30_0, iter_30_1 in ipairs(var_30_3) do
		for iter_30_2 = 0, 6 do
			local var_30_5 = ResourcePoint(iter_30_1, iter_30_2)

			if var_30_5 ~= var_30_2 then
				local var_30_6 = RoomCharacterHelper.getCharacterPosition(var_30_5)
				local var_30_7 = Vector2.Distance(var_30_6, var_30_4)

				table.insert(var_30_1, {
					resourcePoint = var_30_5,
					distance = var_30_7
				})
			end
		end
	end

	local var_30_8 = GameUtil.randomTable(var_30_1)

	table.sort(var_30_8, function(arg_31_0, arg_31_1)
		if math.abs(arg_31_0.distance - arg_31_1.distance) > 0.001 then
			return arg_31_0.distance < arg_31_1.distance
		end

		return false
	end)

	local var_30_9 = RoomCharacterHelper.getBridgePositions(arg_30_0.currentPosition)
	local var_30_10

	if math.random() < 0.4 and (not arg_30_0._preBridge or arg_30_0._preBridge < 2) then
		var_30_10 = 1
	else
		arg_30_0._preBridge = 0
	end

	for iter_30_3, iter_30_4 in ipairs(var_30_9) do
		local var_30_11 = {
			isBridge = true,
			position = iter_30_4
		}

		if var_30_10 then
			table.insert(var_30_8, var_30_10, var_30_11)
		else
			table.insert(var_30_8, var_30_11)
		end
	end

	local var_30_12 = GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(arg_30_0.id)

	if var_30_12 ~= nil then
		local var_30_13 = {}

		for iter_30_5, iter_30_6 in ipairs(var_30_8) do
			local var_30_14 = iter_30_6.position or RoomCharacterHelper.getCharacterPosition3D(iter_30_6.resourcePoint, false)

			if RoomCharacterHelper.checkMoveStraightRule(arg_30_0.currentPosition, var_30_14, arg_30_0.heroId, var_30_12, iter_30_6.isBridge) then
				arg_30_0._preBridge = (arg_30_0._preBridge or 0) + (iter_30_6.isBridge and 1 or 0)

				table.insert(var_30_13, var_30_14)
			end
		end

		arg_30_0:setPreMove(var_30_13)
	end
end

function var_0_0.onPathCall(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	if not arg_32_3 then
		local var_32_0 = RoomVectorPool.instance:packPosList(arg_32_2)
		local var_32_1 = var_32_0[#var_32_0]

		if RoomCharacterHelper.isMoveCameraWalkable(var_32_0) and not RoomCharacterHelper.isOtherCharacter(var_32_1, arg_32_0.heroId) then
			arg_32_0:setMove(var_32_0)

			return
		end
	else
		logNormal("Room pathfinding Error : " .. tostring(arg_32_4))
	end

	arg_32_0:_tryNextMovePosition()
end

function var_0_0._moveEnd(arg_33_0, arg_33_1)
	arg_33_0._moveState = RoomCharacterEnum.CharacterMoveState.Idle

	arg_33_0:clearPath()

	arg_33_0._movePoint = 0
	arg_33_0._moveValue = 0
	arg_33_0.stateDuration = 0

	GameSceneMgr.instance:getCurScene().path:stopGetPath(arg_33_0)

	arg_33_0._preMovePositions = nil

	if arg_33_1 then
		RoomCharacterController.instance:tryPlaySpecialIdle(arg_33_0.heroId)
	end
end

function var_0_0.replaceIdleState(arg_34_0, arg_34_1)
	arg_34_0._replaceIdleState = arg_34_1
end

function var_0_0.clearPath(arg_35_0)
	if #arg_35_0._nextPositions > 0 then
		for iter_35_0 = #arg_35_0._nextPositions, 1, -1 do
			RoomVectorPool.instance:recycle(arg_35_0._nextPositions[iter_35_0])
			table.remove(arg_35_0._nextPositions, iter_35_0)
		end
	end
end

function var_0_0.updateMove(arg_36_0, arg_36_1)
	if arg_36_0.characterState ~= RoomCharacterEnum.CharacterState.Map then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		return
	end

	if not arg_36_0:canMove() then
		return
	end

	arg_36_0.stateDuration = arg_36_0.stateDuration + arg_36_1

	if arg_36_0:getMoveInterval() < arg_36_0.stateDuration and arg_36_0._moveState ~= RoomCharacterEnum.CharacterMoveState.Move then
		arg_36_0:_tryMoveNeighbor()

		arg_36_0.stateDuration = 0
	end

	if arg_36_0._moveState == RoomCharacterEnum.CharacterMoveState.Move then
		local var_36_0 = arg_36_1 * arg_36_0:getMoveSpeed() * 0.2

		arg_36_0:_move(var_36_0)
	end
end

function var_0_0._move(arg_37_0, arg_37_1)
	if not arg_37_0:_hasNextPosition() then
		arg_37_0:_moveEnd()

		return
	end

	if arg_37_1 <= 0 then
		return
	end

	local var_37_0 = arg_37_1
	local var_37_1 = arg_37_0.currentPosition
	local var_37_2 = arg_37_0:_getNextPosition()
	local var_37_3 = Vector3.Distance(var_37_1, var_37_2)

	while var_37_3 < var_37_0 do
		var_37_0 = var_37_0 - var_37_3
		var_37_1 = var_37_2

		arg_37_0:_moveToNextPosition()

		if arg_37_0:_hasNextPosition() then
			var_37_2 = arg_37_0:_getNextPosition()
			var_37_3 = Vector3.Distance(var_37_1, var_37_2)
		else
			var_37_3 = 0

			break
		end
	end

	if var_37_3 > 0 then
		arg_37_0:setPosition(Vector3.Lerp(var_37_1, var_37_2, var_37_0 / var_37_3))

		arg_37_0._moveDir = Vector2(var_37_2.x - var_37_1.x, var_37_2.z - var_37_1.z):SetNormalize()
	else
		arg_37_0:setPositionXYZ(var_37_1.x, var_37_1.y, var_37_1.z)
	end

	if not arg_37_0:_hasNextPosition() then
		arg_37_0:_moveEnd(true)
	end
end

function var_0_0._hasNextPosition(arg_38_0)
	return #arg_38_0._nextPositions > arg_38_0._movePoint
end

function var_0_0._getNextPosition(arg_39_0)
	return arg_39_0._nextPositions[arg_39_0._movePoint + 1]
end

function var_0_0._moveToNextPosition(arg_40_0)
	arg_40_0._movePoint = arg_40_0._movePoint + 1
end

function var_0_0.setCurrentInteractionId(arg_41_0, arg_41_1)
	arg_41_0._currentInteractionId = arg_41_1
end

function var_0_0.getCurrentInteractionId(arg_42_0)
	return arg_42_0._currentInteractionId
end

function var_0_0.setIsFreeze(arg_43_0, arg_43_1)
	arg_43_0._freeze = arg_43_1
end

function var_0_0.getIsFreeze(arg_44_0)
	return arg_44_0._freeze
end

return var_0_0

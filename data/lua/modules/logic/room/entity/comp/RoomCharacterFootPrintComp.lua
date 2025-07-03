module("modules.logic.room.entity.comp.RoomCharacterFootPrintComp", package.seeall)

local var_0_0 = class("RoomCharacterFootPrintComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goTrs = arg_2_1.transform

	local var_2_0, var_2_1, var_2_2 = transformhelper.getPos(arg_2_0.goTrs)

	arg_2_0._lastPosition = Vector3(var_2_0, var_2_1, var_2_2)
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
	arg_2_0._footDistance = 0.05
end

function var_0_0.addEventListeners(arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, arg_3_0._updateCharacterMove, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, arg_4_0._updateCharacterMove, arg_4_0)
end

function var_0_0._updateCharacterMove(arg_5_0)
	arg_5_0:_updateMovingLookDir()
end

function var_0_0._updateMovingLookDir(arg_6_0)
	if arg_6_0.entity.isPressing then
		return
	end

	local var_6_0 = arg_6_0.entity:getMO()

	if not var_6_0 then
		return
	end

	if arg_6_0._scene.character:isLock() then
		return
	end

	if var_6_0.roomCharacterConfig.hideFootprint ~= 0 then
		return
	end

	if var_6_0:getMoveState() ~= RoomCharacterEnum.CharacterMoveState.Move then
		arg_6_0._needFootPrint = true

		return
	end

	local var_6_1 = var_6_0:getMovingDir()
	local var_6_2 = var_6_1.x
	local var_6_3 = var_6_1.y

	if var_6_2 == 0 and var_6_3 == 0 then
		return
	end

	local var_6_4, var_6_5, var_6_6 = transformhelper.getPos(arg_6_0.goTrs)
	local var_6_7 = Vector3(var_6_4, var_6_5, var_6_6)

	if arg_6_0._needFootPrint or Vector3.Distance(arg_6_0._lastPosition, var_6_7) >= arg_6_0._footDistance then
		local var_6_8, var_6_9 = HexMath.posXYToRoundHexYX(var_6_4, var_6_6, RoomBlockEnum.BlockSize)
		local var_6_10 = RoomMapBlockModel.instance:getBlockMO(var_6_8, var_6_9)

		if var_6_10 and var_6_10:isInMapBlock() and RoomBlockEnum.FootPrintDict[var_6_10:getDefineBlockType()] then
			arg_6_0._needFootPrint = false
			arg_6_0._lastPosition = var_6_7

			local var_6_11 = Vector3(var_6_2, 0, var_6_3)
			local var_6_12 = Quaternion.LookRotation(var_6_11, Vector3.up).eulerAngles

			arg_6_0._isLeftFoot = arg_6_0._isLeftFoot == false

			RoomMapController.instance:dispatchEvent(RoomEvent.AddCharacterFootPrint, var_6_12, var_6_7, arg_6_0._isLeftFoot)
		end
	end
end

function var_0_0.beforeDestroy(arg_7_0)
	arg_7_0:removeEventListeners()
end

return var_0_0

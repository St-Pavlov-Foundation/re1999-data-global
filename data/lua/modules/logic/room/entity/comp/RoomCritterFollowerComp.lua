module("modules.logic.room.entity.comp.RoomCritterFollowerComp", package.seeall)

local var_0_0 = class("RoomCritterFollowerComp", RoomBaseFollowerComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._followDis = 0.15
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_1)
	arg_2_0:delaySetFollow(0.5)
end

function var_0_0.addPathPos(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getFollowPathData()

	if var_3_0:getPosCount() == 1 then
		local var_3_1 = Vector3.Distance(var_3_0:getFirstPos(), arg_3_1)

		if (arg_3_0._followDis or 0.1) > var_3_1 + var_3_0:getPathDistance() then
			return
		end
	end

	var_0_0.super.addPathPos(arg_3_0, arg_3_1)
end

function var_0_0.onMoveByPathData(arg_4_0, arg_4_1)
	if arg_4_1:getPosCount() < 1 then
		return
	end

	local var_4_0 = arg_4_1:getPathDistance()
	local var_4_1 = arg_4_0._followDis

	if var_4_1 < var_4_0 then
		local var_4_2 = arg_4_1:getPosByDistance(var_4_1)

		arg_4_0.entity:setLocalPos(var_4_2.x, var_4_2.y, var_4_2.z)
	elseif var_4_0 < var_4_1 then
		-- block empty
	end

	local var_4_3 = arg_4_0.entity.critterspine

	if var_4_3 then
		local var_4_4 = arg_4_0:_findCharacterEntity()

		if var_4_4 and var_4_4.characterspine then
			var_4_3:setLookDir(var_4_4.characterspine:getLookDir())
		end
	end
end

function var_0_0.onStopMove(arg_5_0)
	arg_5_0:_playAnimState(RoomCharacterEnum.CharacterMoveState.Idle, true)

	local var_5_0, var_5_1, var_5_2 = transformhelper.getPos(arg_5_0.entity.goTrs)
	local var_5_3 = arg_5_0:getFollowPathData()

	var_5_3:clear()
	var_5_3:addPathPos(Vector3(var_5_0, var_5_1, var_5_2))
end

function var_0_0.onStartMove(arg_6_0)
	arg_6_0:_playAnimState(RoomCharacterEnum.CharacterMoveState.Move, true)
end

function var_0_0._playAnimState(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.entity.critterspine

	if var_7_0 then
		var_7_0:changeMoveState(arg_7_1)
		var_7_0:play(RoomCharacterHelper.getAnimStateName(arg_7_1, arg_7_0.entity.id), arg_7_2, true)
	end
end

function var_0_0._findCharacterEntity(arg_8_0)
	local var_8_0 = arg_8_0.entity:getMO()

	if not var_8_0 then
		return
	end

	local var_8_1 = RoomCharacterModel.instance:getCharacterMOById(var_8_0.heroId)
	local var_8_2 = GameSceneMgr.instance:getCurScene()

	if var_8_2 and var_8_1 then
		return (var_8_2.charactermgr:getCharacterEntity(var_8_1.id, SceneTag.RoomCharacter))
	end
end

function var_0_0.delaySetFollow(arg_9_0, arg_9_1)
	TaskDispatcher.cancelTask(arg_9_0._delaySetFollow, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0._delaySetFollow, arg_9_0, arg_9_1 or 0.5)
end

function var_0_0._delaySetFollow(arg_10_0)
	local var_10_0 = RoomCameraController.instance:getRoomScene()

	if not arg_10_0.entity:getMO() or not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0:_findCharacterEntity()

	if var_10_1 then
		arg_10_0:followCharacter(var_10_1)

		return
	end
end

function var_0_0.followCharacter(arg_11_0, arg_11_1)
	arg_11_0:setFollowPath(arg_11_1.followPathComp)

	local var_11_0 = arg_11_0:getFollowPathData()

	if var_11_0:getPosCount() <= 1 then
		local var_11_1, var_11_2, var_11_3 = transformhelper.getPos(arg_11_0.entity.goTrs)

		var_11_0:addPathPos(Vector3(var_11_1, var_11_2, var_11_3))

		local var_11_4, var_11_5, var_11_6 = transformhelper.getPos(arg_11_1.goTrs)

		var_11_0:addPathPos(Vector3(var_11_4, var_11_5, var_11_6))
	end

	arg_11_0:onMoveByPathData(var_11_0)
end

function var_0_0.beforeDestroy(arg_12_0)
	var_0_0.super.beforeDestroy(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._delaySetFollow, arg_12_0)
end

return var_0_0

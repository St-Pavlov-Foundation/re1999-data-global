module("modules.logic.scene.room.comp.entitymgr.RoomSceneCritterEntityMgr", package.seeall)

local var_0_0 = class("RoomSceneCritterEntityMgr", BaseSceneUnitMgr)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	if RoomController.instance:isEditMode() then
		return
	end

	local var_2_0 = RoomCritterModel.instance:getList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0:spawnRoomCritter(iter_2_1)
	end
end

function var_0_0.spawnRoomCritter(arg_3_0, arg_3_1)
	return arg_3_0:_spawnRoomCritter(arg_3_1, false)
end

function var_0_0._spawnRoomCritter(arg_4_0, arg_4_1, arg_4_2)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	local var_4_0 = arg_4_0._scene.go.critterRoot
	local var_4_1 = arg_4_1.currentPosition
	local var_4_2 = gohelper.create3d(var_4_0, string.format("%s", arg_4_1.id))
	local var_4_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_2, RoomCritterEntity, arg_4_1.id)

	if arg_4_2 ~= true then
		arg_4_0:addUnit(var_4_3)
	end

	gohelper.addChild(var_4_0, var_4_2)

	if var_4_1 then
		var_4_3:setLocalPos(var_4_1.x, var_4_1.y, var_4_1.z)
	end

	return var_4_3
end

function var_0_0.delaySetFollow(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getCritterEntity(arg_5_1, SceneTag.RoomCharacter)

	if var_5_0 and var_5_0.critterfollower then
		var_5_0.critterfollower:delaySetFollow(arg_5_2 or 0.1)
	end
end

function var_0_0.moveTo(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:setLocalPos(arg_6_2.x, arg_6_2.y, arg_6_2.z)
end

function var_0_0.destroyCritter(arg_7_0, arg_7_1)
	arg_7_0:removeUnit(arg_7_1:getTag(), arg_7_1.id)
end

function var_0_0.getCritterEntity(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = (not arg_8_2 or arg_8_2 == SceneTag.RoomCharacter) and arg_8_0:getTagUnitDict(SceneTag.RoomCharacter)

	return var_8_0 and var_8_0[arg_8_1]
end

function var_0_0.spawnTempCritterByMO(arg_9_0, arg_9_1)
	if arg_9_0._tempCritterEntity then
		if arg_9_1 and arg_9_0._tempCritterEntity.id == arg_9_1.id then
			return arg_9_0._tempCritterEntity
		end

		local var_9_0 = arg_9_0._tempCritterEntity

		arg_9_0._tempCritterEntity = nil

		arg_9_0:destroyUnit(var_9_0)
	end

	if arg_9_1 then
		arg_9_0._tempCritterEntity = arg_9_0:_spawnRoomCritter(arg_9_1, true)
	end

	return arg_9_0._tempCritterEntity
end

function var_0_0.getTempCritterEntity(arg_10_0)
	return arg_10_0._tempCritterEntity
end

function var_0_0.getRoomCritterEntityDict(arg_11_0)
	return arg_11_0._tagUnitDict[SceneTag.RoomCharacter] or {}
end

function var_0_0._onUpdate(arg_12_0)
	return
end

function var_0_0.onSceneClose(arg_13_0)
	var_0_0.super.onSceneClose(arg_13_0)

	local var_13_0 = arg_13_0._tempCritterEntity

	if var_13_0 then
		arg_13_0._tempCritterEntity = nil

		arg_13_0:destroyUnit(var_13_0)
	end
end

return var_0_0

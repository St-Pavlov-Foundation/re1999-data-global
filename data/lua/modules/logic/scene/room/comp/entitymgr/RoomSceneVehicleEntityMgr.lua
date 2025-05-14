module("modules.logic.scene.room.comp.entitymgr.RoomSceneVehicleEntityMgr", package.seeall)

local var_0_0 = class("RoomSceneVehicleEntityMgr", BaseSceneUnitMgr)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	arg_2_0:_startSpawnVehicle()
end

function var_0_0.onStopMode(arg_3_0)
	arg_3_0:_onSwitchMode(true)
end

function var_0_0.onSwitchMode(arg_4_0)
	arg_4_0:_onSwitchMode(RoomController.instance:isEditMode())
end

function var_0_0._onSwitchMode(arg_5_0, arg_5_1)
	local var_5_0 = RoomMapVehicleEntity:getTag()
	local var_5_1 = arg_5_0:getTagUnitDict(var_5_0)

	if arg_5_1 then
		arg_5_0:_stopSpawnVehicle()

		if var_5_1 then
			for iter_5_0, iter_5_1 in pairs(var_5_1) do
				iter_5_1:setShow(false)
			end
		end
	else
		if var_5_1 then
			local var_5_2 = RoomMapVehicleModel.instance

			for iter_5_2, iter_5_3 in pairs(var_5_1) do
				local var_5_3 = var_5_2:getById(iter_5_2)

				if var_5_3 then
					arg_5_0:setVehiclePosByMO(iter_5_3, var_5_3)
					iter_5_3:setShow(true)
				else
					arg_5_0:removeUnit(var_5_0, iter_5_2)
				end
			end
		end

		arg_5_0:_startSpawnVehicle()
	end
end

function var_0_0._stopSpawnVehicle(arg_6_0)
	if arg_6_0._isRuningSpawnVehicle then
		arg_6_0._isRuningSpawnVehicle = false

		TaskDispatcher.cancelTask(arg_6_0._onRepeatSpawnVehicle, arg_6_0)
	end
end

function var_0_0._startSpawnVehicle(arg_7_0)
	local var_7_0 = RoomMapVehicleEntity:getTag()
	local var_7_1 = RoomMapVehicleModel.instance:getList()

	arg_7_0._waitVehicleMOList = nil

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if not arg_7_0:getUnit(var_7_0, iter_7_1.id) then
			arg_7_0._waitVehicleMOList = arg_7_0._waitVehicleMOList or {}

			table.insert(arg_7_0._waitVehicleMOList, iter_7_1)
		end
	end

	if arg_7_0._waitVehicleMOList and not arg_7_0._isRuningSpawnVehicle then
		arg_7_0._isRuningSpawnVehicle = true

		TaskDispatcher.runRepeat(arg_7_0._onRepeatSpawnVehicle, arg_7_0, 0)
	end
end

function var_0_0._onRepeatSpawnVehicle(arg_8_0)
	if arg_8_0._waitVehicleMOList and #arg_8_0._waitVehicleMOList > 0 then
		local var_8_0 = arg_8_0._waitVehicleMOList[1]

		table.remove(arg_8_0._waitVehicleMOList, 1)
		arg_8_0:spawnMapVehicle(var_8_0)
	else
		arg_8_0:_stopSpawnVehicle()
	end
end

function var_0_0.spawnMapVehicle(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._scene.go.vehicleRoot
	local var_9_1 = gohelper.create3d(var_9_0, arg_9_1.id)
	local var_9_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, RoomMapVehicleEntity, arg_9_1.id)

	arg_9_0:addUnit(var_9_2)
	gohelper.addChild(var_9_0, var_9_1)
	arg_9_0:setVehiclePosByMO(var_9_2, arg_9_1)

	return var_9_2
end

function var_0_0.setVehiclePosByMO(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = (arg_10_2 or arg_10_1:getMO()):getCurNode()
	local var_10_1 = var_10_0 and var_10_0.hexPoint

	if not var_10_1 then
		logError("RoomSceneVehicleEntityMgr: 没有位置信息")

		return
	end

	local var_10_2 = HexMath.hexToPosition(var_10_1, RoomBlockEnum.BlockSize)

	arg_10_1:setLocalPos(var_10_2.x, RoomBuildingEnum.VehicleInitOffestY, var_10_2.y)
end

function var_0_0.getVehicleEntity(arg_11_0, arg_11_1)
	return arg_11_0:getUnit(RoomMapVehicleEntity:getTag(), arg_11_1)
end

function var_0_0.destroyVehicle(arg_12_0, arg_12_1)
	arg_12_0:removeUnit(arg_12_1:getTag(), arg_12_1.id)
end

function var_0_0.onSceneClose(arg_13_0)
	var_0_0.super.onSceneClose(arg_13_0)
	arg_13_0:_stopSpawnVehicle()
end

return var_0_0

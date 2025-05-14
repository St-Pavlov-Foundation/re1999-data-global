module("modules.common.unit.UnitMoverMmo", package.seeall)

local var_0_0 = class("UnitMoverMmo", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._speed = 0
	arg_1_0._speedX = 0
	arg_1_0._speedY = 0
	arg_1_0._speedZ = 0
	arg_1_0._posX = 0
	arg_1_0._posY = 0
	arg_1_0._posZ = 0
	arg_1_0._wpPool = LuaObjPool.New(100, function()
		return {}
	end, function(arg_3_0)
		return
	end, function(arg_4_0)
		return
	end)
	arg_1_0._wayPoints = {}
	arg_1_0._curWayPoint = nil
	arg_1_0._accerationTime = 0
	arg_1_0._startMoveTime = 0

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.simpleMove(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	local var_5_0 = math.sqrt((arg_5_1 - arg_5_4)^2 + (arg_5_2 - arg_5_5)^2 + (arg_5_3 - arg_5_6)^2)
	local var_5_1 = var_5_0 > 0 and var_5_0 / arg_5_7 or 100000000

	arg_5_0:setSpeed(var_5_1)
	arg_5_0:setPosDirectly(arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:addWayPoint(arg_5_4, arg_5_5, arg_5_6)
end

function var_0_0.setPosDirectly(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:clearWayPoints()

	arg_6_0._posX = arg_6_1
	arg_6_0._posY = arg_6_2
	arg_6_0._posZ = arg_6_3

	arg_6_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_6_0)
end

function var_0_0.getCurWayPoint(arg_7_0)
	return arg_7_0._curWayPoint
end

function var_0_0.getPos(arg_8_0)
	return arg_8_0._posX, arg_8_0._posY, arg_8_0._posZ
end

function var_0_0.setSpeed(arg_9_0, arg_9_1)
	arg_9_0._speed = arg_9_1

	if not arg_9_0._curWayPoint then
		arg_9_0._speedX = 0
		arg_9_0._speedY = 0
		arg_9_0._speedZ = 0
	else
		local var_9_0 = arg_9_0._curWayPoint.x - arg_9_0._posX
		local var_9_1 = arg_9_0._curWayPoint.y - arg_9_0._posY
		local var_9_2 = arg_9_0._curWayPoint.z - arg_9_0._posZ
		local var_9_3 = math.sqrt(var_9_0 * var_9_0 + var_9_1 * var_9_1 + var_9_2 * var_9_2)
		local var_9_4 = var_9_0 / var_9_3
		local var_9_5 = var_9_1 / var_9_3
		local var_9_6 = var_9_2 / var_9_3

		arg_9_0._speedX = var_9_4 * arg_9_0._speed
		arg_9_0._speedY = var_9_5 * arg_9_0._speed
		arg_9_0._speedZ = var_9_6 * arg_9_0._speed
	end
end

function var_0_0.setTimeScale(arg_10_0, arg_10_1)
	if arg_10_1 > 0 then
		arg_10_0:setSpeed(arg_10_0._speed * arg_10_1)
	else
		logError("argument illegal, timeScale = " .. arg_10_1)
	end
end

function var_0_0.setAccelerationTime(arg_11_0, arg_11_1)
	arg_11_0._accerationTime = arg_11_1
end

function var_0_0.getAccelerationTime(arg_12_0)
	return arg_12_0._accerationTime
end

function var_0_0.setWayPoint(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0._wayPoints then
		return
	end

	local var_13_0 = #arg_13_0._wayPoints

	for iter_13_0 = 1, var_13_0 do
		arg_13_0._wpPool:putObject(arg_13_0._wayPoints[iter_13_0])

		arg_13_0._wayPoints[iter_13_0] = nil
	end

	local var_13_1 = arg_13_0._wpPool:getObject()

	var_13_1.x = arg_13_1
	var_13_1.y = arg_13_2
	var_13_1.z = arg_13_3

	arg_13_0:_setNewWayPoint(var_13_1)
end

function var_0_0.addWayPoint(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_0._posX == arg_14_1 and arg_14_0._posY == arg_14_2 and arg_14_0._posZ == arg_14_3 then
		if not arg_14_0._curWayPoint then
			return
		elseif arg_14_0._curWayPoint.x == arg_14_1 and arg_14_0._curWayPoint.y == arg_14_2 and arg_14_0._curWayPoint.z == arg_14_3 then
			return
		end
	end

	local var_14_0 = arg_14_0._wpPool:getObject()

	var_14_0.x = arg_14_1
	var_14_0.y = arg_14_2
	var_14_0.z = arg_14_3

	if arg_14_4 then
		local var_14_1 = 0

		if arg_14_0._curWayPoint and arg_14_0._curWayPoint[1] then
			local var_14_2 = arg_14_0._curWayPoint[#arg_14_0._curWayPoint]

			var_14_1 = math.sqrt((var_14_2.x - arg_14_1)^2 + (var_14_2.y - arg_14_2)^2 + (var_14_2.z - arg_14_3)^2)
		else
			var_14_1 = math.sqrt((arg_14_0._posX - arg_14_1)^2 + (arg_14_0._posY - arg_14_2)^2 + (arg_14_0._posZ - arg_14_3)^2)
		end

		var_14_0.speed = var_14_1 > 0 and var_14_1 / arg_14_4 or 100000000
	end

	if not arg_14_0._curWayPoint then
		arg_14_0:_setNewWayPoint(var_14_0)
	else
		table.insert(arg_14_0._wayPoints, var_14_0)
	end
end

function var_0_0.clearWayPoints(arg_15_0)
	local var_15_0 = #arg_15_0._wayPoints

	for iter_15_0 = 1, var_15_0 do
		arg_15_0._wpPool:putObject(arg_15_0._wayPoints[iter_15_0])

		arg_15_0._wayPoints[iter_15_0] = nil
	end

	if arg_15_0._curWayPoint then
		arg_15_0:_setNewWayPoint(nil)
		arg_15_0:dispatchEvent(UnitMoveEvent.Interrupt, arg_15_0)
	end
end

function var_0_0._setNewWayPoint(arg_16_0, arg_16_1)
	local var_16_0 = false

	if arg_16_0._curWayPoint then
		arg_16_0._wpPool:putObject(arg_16_0._curWayPoint)
	elseif arg_16_1 then
		var_16_0 = true
	end

	arg_16_0._curWayPoint = arg_16_1

	if not arg_16_0._curWayPoint then
		arg_16_0._speedX = 0
		arg_16_0._speedY = 0
		arg_16_0._speedZ = 0
	else
		if arg_16_1.speed then
			arg_16_0._speed = arg_16_1.speed
		end

		local var_16_1 = arg_16_0._curWayPoint.x - arg_16_0._posX
		local var_16_2 = arg_16_0._curWayPoint.y - arg_16_0._posY
		local var_16_3 = arg_16_0._curWayPoint.z - arg_16_0._posZ
		local var_16_4 = math.sqrt(var_16_1 * var_16_1 + var_16_2 * var_16_2 + var_16_3 * var_16_3)
		local var_16_5 = var_16_1 / var_16_4
		local var_16_6 = var_16_2 / var_16_4
		local var_16_7 = var_16_3 / var_16_4

		arg_16_0._speedX = var_16_5 * arg_16_0._speed
		arg_16_0._speedY = var_16_6 * arg_16_0._speed
		arg_16_0._speedZ = var_16_7 * arg_16_0._speed
	end

	if var_16_0 then
		arg_16_0._startMoveTime = Time.time

		arg_16_0:dispatchEvent(UnitMoveEvent.StartMove, arg_16_0)
	end
end

function var_0_0.onUpdate(arg_17_0)
	if arg_17_0._curWayPoint then
		local var_17_0 = Time.deltaTime

		if arg_17_0._accerationTime > 0 then
			local var_17_1 = Time.time - arg_17_0._startMoveTime

			if var_17_1 < arg_17_0._accerationTime then
				var_17_0 = var_17_0 * (var_17_1 / arg_17_0._accerationTime)
			end
		end

		local var_17_2 = arg_17_0._posX + arg_17_0._speedX * var_17_0
		local var_17_3 = arg_17_0._posY + arg_17_0._speedY * var_17_0
		local var_17_4 = arg_17_0._posZ + arg_17_0._speedZ * var_17_0
		local var_17_5 = var_17_2 - arg_17_0._posX
		local var_17_6 = var_17_3 - arg_17_0._posY
		local var_17_7 = var_17_4 - arg_17_0._posZ
		local var_17_8 = arg_17_0._curWayPoint.x - arg_17_0._posX
		local var_17_9 = arg_17_0._curWayPoint.y - arg_17_0._posY
		local var_17_10 = arg_17_0._curWayPoint.z - arg_17_0._posZ

		if var_17_5 * var_17_5 + var_17_6 * var_17_6 + var_17_7 * var_17_7 >= var_17_8 * var_17_8 + var_17_9 * var_17_9 + var_17_10 * var_17_10 then
			arg_17_0._posX = arg_17_0._curWayPoint.x
			arg_17_0._posY = arg_17_0._curWayPoint.y
			arg_17_0._posZ = arg_17_0._curWayPoint.z

			arg_17_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_17_0)
			arg_17_0:dispatchEvent(UnitMoveEvent.PassWayPoint, arg_17_0._posX, arg_17_0._posY, arg_17_0._posZ)

			if #arg_17_0._wayPoints > 0 then
				local var_17_11 = arg_17_0._wayPoints[1]

				table.remove(arg_17_0._wayPoints, 1)
				arg_17_0:_setNewWayPoint(var_17_11)
			else
				arg_17_0:_setNewWayPoint(nil)
				arg_17_0:dispatchEvent(UnitMoveEvent.Arrive, arg_17_0)
			end
		else
			arg_17_0._posX = var_17_2
			arg_17_0._posY = var_17_3
			arg_17_0._posZ = var_17_4

			arg_17_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_17_0)
		end
	end
end

function var_0_0.onDestroy(arg_18_0)
	arg_18_0:clearWayPoints()
	arg_18_0._wpPool:dispose()

	arg_18_0._wpPool = nil
	arg_18_0._wayPoints = nil
	arg_18_0._curWayPoint = nil
end

return var_0_0

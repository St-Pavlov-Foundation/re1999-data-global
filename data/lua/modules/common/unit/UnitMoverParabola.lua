module("modules.common.unit.UnitMoverParabola", package.seeall)

local var_0_0 = class("UnitMoverParabola", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._speed = 0
	arg_1_0._speedX = 0
	arg_1_0._speedY = 0
	arg_1_0._speedZ = 0
	arg_1_0._gravity = 0
	arg_1_0._posX = 0
	arg_1_0._posY = 0
	arg_1_0._posZ = 0
	arg_1_0._wayPoint = nil
	arg_1_0._getFrameFunction = nil
	arg_1_0._getFrameObject = nil
	arg_1_0._timeScale = 1

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.setPosDirectly(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:clearWayPoints()

	arg_2_0._posX = arg_2_1
	arg_2_0._posY = arg_2_2
	arg_2_0._posZ = arg_2_3

	arg_2_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_2_0)
end

function var_0_0.setGetFrameFunction(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._getFrameFunction = arg_3_1
	arg_3_0._getFrameObject = arg_3_2
	arg_3_0._frame = 0
end

function var_0_0.getCurWayPoint(arg_4_0)
	return arg_4_0._wayPoint
end

function var_0_0.getPos(arg_5_0)
	return arg_5_0._posX, arg_5_0._posY, arg_5_0._posZ
end

function var_0_0.setWayPoint(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0._wayPoint = {
		x = arg_6_1,
		y = arg_6_2,
		z = arg_6_3
	}

	arg_6_0:_setHoriSpeed(arg_6_4)
	arg_6_0:_calcSpeedYAndGravity(arg_6_5)

	arg_6_0._startMoveTime = Time.time

	arg_6_0:dispatchEvent(UnitMoveEvent.StartMove, arg_6_0)
end

function var_0_0.simpleMove(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7, arg_7_8)
	arg_7_0._duration = arg_7_7

	local var_7_0 = math.sqrt((arg_7_1 - arg_7_4)^2 + (arg_7_2 - arg_7_5)^2 + (arg_7_3 - arg_7_6)^2)
	local var_7_1 = var_7_0 > 0 and var_7_0 / arg_7_7 or 100000000

	arg_7_0:setPosDirectly(arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:setWayPoint(arg_7_4, arg_7_5, arg_7_6, var_7_1, arg_7_8)
end

function var_0_0.clearWayPoints(arg_8_0)
	if arg_8_0._wayPoint then
		arg_8_0._wayPoint = nil

		arg_8_0:dispatchEvent(UnitMoveEvent.Interrupt, arg_8_0)
	end
end

function var_0_0.setTimeScale(arg_9_0, arg_9_1)
	if arg_9_1 > 0 then
		arg_9_0._timeScale = arg_9_1
	else
		logError("argument illegal, timeScale = " .. arg_9_1)
	end
end

function var_0_0._setHoriSpeed(arg_10_0, arg_10_1)
	arg_10_0._speed = arg_10_1

	if not arg_10_0._wayPoint then
		arg_10_0._speedX = 0
		arg_10_0._speedZ = 0
	else
		local var_10_0 = arg_10_0._wayPoint.x - arg_10_0._posX
		local var_10_1 = arg_10_0._wayPoint.z - arg_10_0._posZ
		local var_10_2 = math.sqrt(var_10_0 * var_10_0 + var_10_1 * var_10_1)
		local var_10_3 = var_10_0 / var_10_2
		local var_10_4 = var_10_1 / var_10_2

		arg_10_0._speedX = var_10_3 * arg_10_0._speed
		arg_10_0._speedZ = var_10_4 * arg_10_0._speed
	end
end

function var_0_0._calcSpeedYAndGravity(arg_11_0, arg_11_1)
	arg_11_1 = (arg_11_0._posY >= arg_11_0._wayPoint.y and arg_11_0._posY or arg_11_0._wayPoint.y) + arg_11_1

	local var_11_0 = math.sqrt((arg_11_0._posX - arg_11_0._wayPoint.x)^2 + (arg_11_0._posZ - arg_11_0._wayPoint.z)^2) / arg_11_0._speed
	local var_11_1 = arg_11_1 - arg_11_0._posY
	local var_11_2 = arg_11_1 - arg_11_0._wayPoint.y
	local var_11_3 = var_11_0 / (1 + math.sqrt(var_11_2 / var_11_1))

	arg_11_0._gravity = 2 * var_11_1 / var_11_3^2
	arg_11_0._speedY = arg_11_0._gravity * var_11_3
end

function var_0_0.getDeltaTime(arg_12_0)
	local var_12_0, var_12_1, var_12_2 = arg_12_0._getFrameFunction(arg_12_0._getFrameObject)

	if var_12_0 <= var_12_1 then
		return 0
	end

	if var_12_2 <= 0 then
		return arg_12_0._duration
	end

	local var_12_3 = var_12_0 - math.max(var_12_1, arg_12_0._frame)

	arg_12_0._frame = var_12_0

	return var_12_3 / var_12_2 * (arg_12_0._duration or 0)
end

function var_0_0.onUpdate(arg_13_0)
	if arg_13_0._wayPoint then
		local var_13_0 = 0

		if arg_13_0._getFrameFunction then
			var_13_0 = arg_13_0:getDeltaTime()
		else
			var_13_0 = Time.deltaTime * arg_13_0._timeScale
		end

		if var_13_0 <= 0 then
			return
		end

		local var_13_1 = arg_13_0._speedY - arg_13_0._gravity * var_13_0

		arg_13_0._posY = arg_13_0._posY + (var_13_1 + arg_13_0._speedY) / 2 * var_13_0
		arg_13_0._posY = arg_13_0._posY < arg_13_0._wayPoint.y and arg_13_0._wayPoint.y or arg_13_0._posY
		arg_13_0._speedY = var_13_1

		local var_13_2 = arg_13_0._posX + arg_13_0._speedX * var_13_0
		local var_13_3 = arg_13_0._posZ + arg_13_0._speedZ * var_13_0
		local var_13_4 = var_13_2 - arg_13_0._posX
		local var_13_5 = var_13_3 - arg_13_0._posZ
		local var_13_6 = arg_13_0._wayPoint.x - arg_13_0._posX
		local var_13_7 = arg_13_0._wayPoint.z - arg_13_0._posZ

		if var_13_4 * var_13_4 + var_13_5 * var_13_5 >= var_13_6 * var_13_6 + var_13_7 * var_13_7 then
			arg_13_0._posX = arg_13_0._wayPoint.x
			arg_13_0._posZ = arg_13_0._wayPoint.z
			arg_13_0._wayPoint = nil

			arg_13_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_13_0)
			arg_13_0:dispatchEvent(UnitMoveEvent.Arrive, arg_13_0)
		else
			arg_13_0._posX = var_13_2
			arg_13_0._posZ = var_13_3

			arg_13_0:dispatchEvent(UnitMoveEvent.PosChanged, arg_13_0)
		end
	end
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0._wayPoint = nil
end

return var_0_0

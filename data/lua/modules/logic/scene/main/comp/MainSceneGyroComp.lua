module("modules.logic.scene.main.comp.MainSceneGyroComp", package.seeall)

local var_0_0 = class("MainSceneGyroComp", BaseSceneComp)
local var_0_1 = UnityEngine.Input
local var_0_2 = UnityEngine.Time
local var_0_3 = {
	{
		deltaScale = 2.2,
		angle_x = 1.5,
		lerpScale = 14,
		angle_y = 5
	}
}

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_0._isRunning then
		arg_1_0._isRunning = true

		TaskDispatcher.runRepeat(arg_1_0._tick, arg_1_0, 0)
		CameraMgr.instance:setUnitCameraSeparate()
	end

	arg_1_0._aniGoList = {}

	local var_1_0 = var_0_3[1]
	local var_1_1 = CameraMgr.instance:getMainCameraTrs()
	local var_1_2 = var_1_1.localEulerAngles

	var_1_0.maxX = var_1_2.x + var_1_0.angle_x
	var_1_0.minX = var_1_2.x - var_1_0.angle_x
	var_1_0.maxY = var_1_2.y + var_1_0.angle_y
	var_1_0.minY = var_1_2.y - var_1_0.angle_y

	local var_1_3 = {
		transform = var_1_1,
		config = var_1_0,
		initAngles = var_1_2
	}

	table.insert(arg_1_0._aniGoList, var_1_3)

	local var_1_4, var_1_5, var_1_6 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	arg_1_0._acceleration = Vector3.New(var_1_4, var_1_5, var_1_6)
	arg_1_0._curAcceleration = Vector3.New(var_1_4, var_1_5, var_1_6)
	arg_1_0._deltaPos = Vector3.zero
	arg_1_0._tempAngle = Vector3.zero
	arg_1_0._gyroOffset = Vector4.New(0, 0, 0.04)
	arg_1_0._srcQuaternion = Quaternion.New()
	arg_1_0._targetQuaternion = Quaternion.New()
	arg_1_0._gyroOffsetID = UnityEngine.Shader.PropertyToID("_GyroOffset")
end

function var_0_0._tick(arg_2_0)
	if not arg_2_0._aniGoList then
		return
	end

	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	local var_2_0, var_2_1, var_2_2 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	arg_2_0._gyroOffset.x, arg_2_0._gyroOffset.y = (arg_2_0._gyroOffset.x + var_2_0) * 0.5, (arg_2_0._gyroOffset.y + var_2_1) * 0.5

	UnityEngine.Shader.SetGlobalVector(arg_2_0._gyroOffsetID, arg_2_0._gyroOffset)
	arg_2_0._curAcceleration:Set(var_2_0, var_2_1, var_2_2)

	local var_2_3 = arg_2_0._deltaPos
	local var_2_4
	local var_2_5
	local var_2_6

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._aniGoList) do
		local var_2_7 = iter_2_1.transform
		local var_2_8 = iter_2_1.config

		var_2_3.y = arg_2_0._curAcceleration.x - arg_2_0._acceleration.x
		var_2_3.x = arg_2_0._curAcceleration.y - arg_2_0._acceleration.y

		local var_2_9 = arg_2_0:calcAngle(iter_2_1.initAngles, var_2_3, var_2_8.deltaScale)

		var_2_9.x = var_2_9.x > var_2_8.maxX and var_2_8.maxX or var_2_9.x
		var_2_9.x = var_2_9.x < var_2_8.minX and var_2_8.minX or var_2_9.x
		var_2_9.y = var_2_9.y > var_2_8.maxY and var_2_8.maxY or var_2_9.y
		var_2_9.y = var_2_9.y < var_2_8.minY and var_2_8.minY or var_2_9.y

		transformhelper.setLocalRotationLerp(var_2_7, var_2_9.x, var_2_9.y, var_2_9.z, var_0_2.deltaTime * var_2_8.lerpScale)
	end
end

function var_0_0.calcAngle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0._tempAngle

	var_3_0.x = arg_3_1.x + arg_3_2.x * arg_3_3
	var_3_0.y = arg_3_1.y + arg_3_2.y * arg_3_3
	var_3_0.z = arg_3_1.z + arg_3_2.z * arg_3_3

	return var_3_0
end

function var_0_0.QuaternionLerp(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = Mathf.Clamp(arg_4_3, 0, 1)

	if Quaternion.Dot(arg_4_1, arg_4_2) < 0 then
		arg_4_1.x = arg_4_1.x + arg_4_3 * (-arg_4_2.x - arg_4_1.x)
		arg_4_1.y = arg_4_1.y + arg_4_3 * (-arg_4_2.y - arg_4_1.y)
		arg_4_1.z = arg_4_1.z + arg_4_3 * (-arg_4_2.z - arg_4_1.z)
		arg_4_1.w = arg_4_1.w + arg_4_3 * (-arg_4_2.w - arg_4_1.w)
	else
		arg_4_1.x = arg_4_1.x + (arg_4_2.x - arg_4_1.x) * arg_4_3
		arg_4_1.y = arg_4_1.y + (arg_4_2.y - arg_4_1.y) * arg_4_3
		arg_4_1.z = arg_4_1.z + (arg_4_2.z - arg_4_1.z) * arg_4_3
		arg_4_1.w = arg_4_1.w + (arg_4_2.w - arg_4_1.w) * arg_4_3
	end

	arg_4_1:SetNormalize()

	return arg_4_1
end

function var_0_0.onSceneClose(arg_5_0)
	if arg_5_0._isRunning then
		arg_5_0._isRunning = false

		TaskDispatcher.cancelTask(arg_5_0._tick, arg_5_0)
		CameraMgr.instance:setUnitCameraCombine()
	end
end

return var_0_0

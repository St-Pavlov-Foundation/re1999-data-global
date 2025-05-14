module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandGyroRotationComp", package.seeall)

local var_0_0 = class("FairyLandGyroRotationComp")
local var_0_1 = UnityEngine.Input
local var_0_2 = UnityEngine.Time

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.autorotateToLandscapeLeft = UnityEngine.Screen.autorotateToLandscapeLeft
	arg_1_0.autorotateToLandscapeRight = UnityEngine.Screen.autorotateToLandscapeRight
	UnityEngine.Screen.autorotateToLandscapeLeft = false
	UnityEngine.Screen.autorotateToLandscapeRight = false
	arg_1_0.rotateCallback = arg_1_1.callback
	arg_1_0.rotateCallbackObj = arg_1_1.callbackObj
	arg_1_0.isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()
	arg_1_0._aniGoList = {}

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.goList) do
		table.insert(arg_1_0._aniGoList, {
			go = iter_1_1,
			transform = iter_1_1.transform
		})
	end

	if not arg_1_0._isRunning then
		arg_1_0._isRunning = true

		TaskDispatcher.runRepeat(arg_1_0._tick, arg_1_0, 0)
	end

	if arg_1_0.isMobilePlayer then
		arg_1_0.gyro = UnityEngine.Input.gyro
		arg_1_0.gyroEnabled = arg_1_0.gyro.enabled
		arg_1_0.gyro.enabled = true
	end

	arg_1_0.tempQuaternion = Quaternion.New()
	arg_1_0.tempQuaternion2 = Quaternion.Euler(90, 0, 0)
end

function var_0_0.checkInDrag(arg_2_0)
	return arg_2_0.rotateCallbackObj.inDrag
end

function var_0_0._tick(arg_3_0)
	if arg_3_0.isMobilePlayer and not arg_3_0:checkInDrag() then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._aniGoList) do
			local var_3_0 = arg_3_0:convertRotation(arg_3_0.gyro.attitude):ToEulerAngles().z

			transformhelper.setLocalRotationLerp(iter_3_1.transform, 0, 0, var_3_0, var_0_2.deltaTime * 2)
		end
	end

	arg_3_0:checkFinish()
end

function var_0_0.convertRotation(arg_4_0, arg_4_1)
	arg_4_0.tempQuaternion:Set(-arg_4_1.x, -arg_4_1.y, arg_4_1.z, arg_4_1.w)

	return arg_4_0.tempQuaternion2 * arg_4_0.tempQuaternion
end

function var_0_0.checkFinish(arg_5_0)
	if arg_5_0.rotateCallback then
		arg_5_0.rotateCallback(arg_5_0.rotateCallbackObj)
	end
end

function var_0_0.closeGyro(arg_6_0)
	if arg_6_0._isRunning then
		arg_6_0._isRunning = false

		TaskDispatcher.cancelTask(arg_6_0._tick, arg_6_0)
	end

	if arg_6_0.autorotateToLandscapeLeft ~= nil then
		UnityEngine.Screen.autorotateToLandscapeLeft = arg_6_0.autorotateToLandscapeLeft
	end

	if arg_6_0.autorotateToLandscapeRight ~= nil then
		UnityEngine.Screen.autorotateToLandscapeRight = arg_6_0.autorotateToLandscapeRight
	end

	if arg_6_0.gyro then
		arg_6_0.gyro.enabled = arg_6_0.gyroEnabled
	end
end

return var_0_0

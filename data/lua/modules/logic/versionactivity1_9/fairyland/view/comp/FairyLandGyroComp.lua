module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandGyroComp", package.seeall)

local var_0_0 = class("FairyLandGyroComp")
local var_0_1 = UnityEngine.Input
local var_0_2 = UnityEngine.Time

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.shakeCallback = arg_1_1.callback
	arg_1_0.shakeCallbackObj = arg_1_1.callbackObj
	arg_1_0.shakeGO = arg_1_1.go
	arg_1_0.isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()
	arg_1_0._aniGoList = {}

	local var_1_0 = arg_1_1.posLimit
	local var_1_1 = {}
	local var_1_2 = arg_1_0.shakeGO.transform
	local var_1_3 = var_1_2.localPosition

	var_1_1.posLimit = var_1_0
	var_1_1.deltaPos = 5
	var_1_1.lerpPos = 10

	local var_1_4 = {
		transform = var_1_2,
		config = var_1_1,
		initPos = var_1_3
	}

	table.insert(arg_1_0._aniGoList, var_1_4)

	local var_1_5, var_1_6, var_1_7 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	arg_1_0._acceleration = Vector3.New(var_1_5, var_1_6, var_1_7)
	arg_1_0._curAcceleration = Vector3.New(var_1_5, var_1_6, var_1_7)
	arg_1_0._offsetPos = Vector3.zero
	arg_1_0._tempPos = Vector3.zero

	if not arg_1_0._isRunning then
		arg_1_0._isRunning = true

		LateUpdateBeat:Add(arg_1_0._tick, arg_1_0)
	end
end

function var_0_0.checkInDrag(arg_2_0)
	return arg_2_0.shakeCallbackObj.inDrag
end

function var_0_0._tick(arg_3_0)
	if arg_3_0.isMobilePlayer and not arg_3_0:checkInDrag() then
		local var_3_0, var_3_1, var_3_2 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

		arg_3_0._curAcceleration:Set(var_3_0, var_3_1, var_3_2)

		local var_3_3 = arg_3_0._offsetPos
		local var_3_4
		local var_3_5
		local var_3_6
		local var_3_7
		local var_3_8

		if arg_3_0._aniGoList then
			for iter_3_0, iter_3_1 in ipairs(arg_3_0._aniGoList) do
				local var_3_9 = iter_3_1.transform
				local var_3_10 = iter_3_1.config

				var_3_3.x = arg_3_0._curAcceleration.x - arg_3_0._acceleration.x
				var_3_3.y = arg_3_0._curAcceleration.y - arg_3_0._acceleration.y

				local var_3_11, var_3_12 = transformhelper.getLocalPos(var_3_9)
				local var_3_13 = arg_3_0:calcPos(iter_3_1.initPos, var_3_3, var_3_10.deltaPos)
				local var_3_14 = arg_3_0:clampPos(var_3_13, iter_3_1.initPos, var_3_10.posLimit)

				transformhelper.setLocalLerp(var_3_9, var_3_14.x, var_3_14.y, var_3_14.z, var_0_2.deltaTime * var_3_10.lerpPos)
			end
		end
	end

	arg_3_0:doShake()
end

function var_0_0.clampPos(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 > Vector3.Distance(arg_4_2, arg_4_1) then
		return arg_4_1
	end

	return arg_4_2 + (arg_4_1 - arg_4_2).normalized * arg_4_3
end

function var_0_0.calcPos(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0._tempPos

	var_5_0.x = arg_5_1.x + arg_5_2.x * arg_5_3
	var_5_0.y = arg_5_1.y + arg_5_2.y * arg_5_3

	return var_5_0
end

function var_0_0.doShake(arg_6_0)
	if arg_6_0.shakeCallback then
		arg_6_0.shakeCallback(arg_6_0.shakeCallbackObj)
	end
end

function var_0_0.closeGyro(arg_7_0)
	if arg_7_0._isRunning then
		arg_7_0._isRunning = false

		LateUpdateBeat:Remove(arg_7_0._tick, arg_7_0)
	end
end

return var_0_0

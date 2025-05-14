module("modules.logic.scene.room.comp.RoomSceneCameraFollowComp", package.seeall)

local var_0_0 = class("RoomSceneCameraFollowComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._initialized = true
	arg_2_0._offsetY = 0
end

function var_0_0.onSceneStart(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.onSceneClose(arg_4_0)
	arg_4_0._followTarget = nil
	arg_4_0._initialized = false

	arg_4_0:_stopFollowTask()
end

function var_0_0._startFollowTask(arg_5_0)
	if not arg_5_0._isRunningFollowTask then
		arg_5_0._isRunningFollowTask = true

		TaskDispatcher.runRepeat(arg_5_0._onUpdateFollow, arg_5_0, 0)
	end
end

function var_0_0._stopFollowTask(arg_6_0)
	if arg_6_0._isRunningFollowTask then
		arg_6_0._isRunningFollowTask = false

		TaskDispatcher.cancelTask(arg_6_0._onUpdateFollow, arg_6_0)
	end
end

function var_0_0._onUpdateFollow(arg_7_0)
	if not arg_7_0._followTarget or arg_7_0._followTarget:isWillDestory() then
		arg_7_0._followTarget = nil

		arg_7_0:_stopFollowTask()

		return
	end

	if arg_7_0._scene and arg_7_0._scene.camera and not arg_7_0._isPass then
		local var_7_0, var_7_1, var_7_2 = arg_7_0._followTarget:getPositionXYZ()
		local var_7_3 = arg_7_0._scene.camera:getCameraParam()

		if arg_7_0._isFirstPerson then
			local var_7_4, var_7_5, var_7_6 = arg_7_0._followTarget:getRotateXYZ()

			var_7_3.rotate = RoomRotateHelper.getMod(var_7_5, 360) * Mathf.Deg2Rad
		end

		arg_7_0._offsetY = var_7_1

		arg_7_0._scene.camera:moveTo(var_7_0, var_7_2)
	end
end

function var_0_0.getCameraOffsetY(arg_8_0)
	if arg_8_0._followTarget and not arg_8_0._followTarget:isWillDestory() then
		return arg_8_0._offsetY or 0
	end

	return 0
end

function var_0_0.removeFollowTarget(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1 == arg_9_0._followTarget then
		arg_9_0._followTarget = nil

		arg_9_0:_stopFollowTask()
	end
end

function var_0_0.setIsPass(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._isPass = arg_10_1 == true

	if arg_10_0._isPass and arg_10_2 ~= nil then
		arg_10_0._offsetY = tonumber(arg_10_2)
	end
end

function var_0_0.getIsPass(arg_11_0)
	return arg_11_0._isPass
end

function var_0_0.isFollowing(arg_12_0)
	return arg_12_0._isRunningFollowTask
end

function var_0_0.isLockRotate(arg_13_0)
	if arg_13_0._isRunningFollowTask and arg_13_0._isFirstPerson then
		return true
	end

	return false
end

function var_0_0.setFollowTarget(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._isFirstPerson = arg_14_2 == true

	if arg_14_0._followTarget == arg_14_1 then
		return
	end

	if arg_14_0._followTarget then
		arg_14_0._followTarget:setCameraFollow(nil)
	end

	arg_14_0._followTarget = arg_14_1

	if arg_14_1 and not arg_14_1:isWillDestory() then
		arg_14_1:setCameraFollow(arg_14_0)
		arg_14_0:_startFollowTask()
		arg_14_0:setIsPass(false)
	else
		arg_14_0:_stopFollowTask()
	end
end

return var_0_0

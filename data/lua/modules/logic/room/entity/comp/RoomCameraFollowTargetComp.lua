module("modules.logic.room.entity.comp.RoomCameraFollowTargetComp", package.seeall)

local var_0_0 = class("RoomCameraFollowTargetComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKey = arg_1_1:getMainEffectKey() or RoomEnum.EffectKey.VehicleGOKey
	arg_1_0._followGOPathKey = RoomEnum.EntityChildKey.FirstPersonCameraGOKey
	arg_1_0.__willDestroy = false
	arg_1_0._offsetY = 0
	arg_1_0._posX, arg_1_0._posY, arg_1_0._posZ = 0, 0, 0
	arg_1_0._roX, arg_1_0._roY, arg_1_0._roZ = 0, 0, 0
	arg_1_0._forwardX, arg_1_0._forwardY, arg_1_0._forwardZ = 0, 0, 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goTrs = arg_2_1.transform
	arg_2_0.goFollowPos = arg_2_1
	arg_2_0.goFollowPosTrs = arg_2_0.goTrs
end

function var_0_0.setOffsetY(arg_3_0, arg_3_1)
	arg_3_0._offsetY = tonumber(arg_3_1)
end

function var_0_0.setEffectKey(arg_4_0, arg_4_1)
	arg_4_0._effectKey = arg_4_1
end

function var_0_0.setFollowGOPath(arg_5_0, arg_5_1)
	arg_5_0._followGOPathKey = arg_5_1

	arg_5_0:_updateFollowGO()
end

function var_0_0.getPositionXYZ(arg_6_0)
	if not arg_6_0.__willDestroy then
		arg_6_0._posX, arg_6_0._posY, arg_6_0._posZ = transformhelper.getPos(arg_6_0.goFollowPosTrs)
		arg_6_0._posY = arg_6_0._posY + arg_6_0._offsetY
	end

	return arg_6_0._posX, arg_6_0._posY, arg_6_0._posZ
end

function var_0_0.getRotateXYZ(arg_7_0)
	if not arg_7_0.__willDestroy then
		arg_7_0._roX, arg_7_0._roY, arg_7_0._roZ = transformhelper.getLocalRotation(arg_7_0.goTrs)
	end

	return arg_7_0._roX, arg_7_0._roY, arg_7_0._roZ
end

function var_0_0.getForwardXYZ(arg_8_0)
	if not arg_8_0.__willDestroy then
		arg_8_0._forwardX, arg_8_0._forwardY, arg_8_0._forwardZ = transformhelper.getForward(arg_8_0.goTrs)
	end

	return arg_8_0._forwardX, arg_8_0._forwardY, arg_8_0._forwardZ
end

function var_0_0.setCameraFollow(arg_9_0, arg_9_1)
	if arg_9_0.__willDestroy then
		return
	end

	arg_9_0._cameraFollowComp = arg_9_1
end

function var_0_0.beforeDestroy(arg_10_0)
	arg_10_0.__willDestroy = true

	if arg_10_0._cameraFollowComp then
		local var_10_0 = arg_10_0._cameraFollowComp

		arg_10_0._cameraFollowComp = nil

		var_10_0:removeFollowTarget(arg_10_0)
	end
end

function var_0_0._updateFollowGO(arg_11_0)
	if arg_11_0.__willDestroy then
		return
	end

	local var_11_0 = arg_11_0.entity.effect
	local var_11_1

	if var_11_0:isHasEffectGOByKey(arg_11_0._effectKey) and arg_11_0._followGOPathKey ~= nil then
		var_11_1 = var_11_0:getGameObjectByPath(arg_11_0._effectKey, arg_11_0._followGOPathKey)

		if not var_11_1 then
			local var_11_2 = var_11_0:getGameObjectsByName(arg_11_0._effectKey, arg_11_0._followGOPathKey)

			if var_11_2 and #var_11_2 > 0 then
				var_11_1 = var_11_2[1]
			end
		end
	end

	if var_11_1 then
		arg_11_0.goFollowPos = var_11_1
		arg_11_0.goFollowPosTrs = var_11_1.transform
	else
		arg_11_0.goFollowPos = arg_11_0.go
		arg_11_0.goFollowPosTrs = arg_11_0.goTrs
	end
end

function var_0_0.isWillDestory(arg_12_0)
	return arg_12_0.__willDestroy
end

function var_0_0.onEffectReturn(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._effectKey == arg_13_1 then
		arg_13_0:_updateFollowGO()
	end
end

function var_0_0.onEffectRebuild(arg_14_0)
	local var_14_0 = arg_14_0.entity.effect

	if var_14_0:isHasEffectGOByKey(arg_14_0._effectKey) and not var_14_0:isSameResByKey(arg_14_0._effectKey, arg_14_0._effectRes) then
		arg_14_0._effectRes = var_14_0:getEffectRes(arg_14_0._effectKey)

		arg_14_0:_updateFollowGO()
	end
end

return var_0_0

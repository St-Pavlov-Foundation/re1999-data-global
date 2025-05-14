module("modules.logic.room.entity.RoomMapVehicleEntity", package.seeall)

local var_0_0 = class("RoomMapVehicleEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
	arg_1_0._isShow = true
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.Untagged
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.containerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_3_0.staticContainerGO = arg_3_0.containerGO
	arg_3_0.containerGOTrs = arg_3_0.containerGO.transform
	arg_3_0.goTrs = arg_3_1.transform

	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._scene = GameSceneMgr.instance:getCurScene()

	arg_3_0:refreshVehicle()
end

function var_0_0.refreshVehicle(arg_4_0)
	if RoomController.instance:isObMode() then
		local var_4_0 = arg_4_0._lastVehicleId
		local var_4_1 = arg_4_0:getMO()
		local var_4_2 = var_4_1 and var_4_1:getReplaceDefideCfg()
		local var_4_3 = RoomEnum.EffectKey.VehicleGOKey

		if not arg_4_0.effect:isHasEffectGOByKey(var_4_3) or var_4_2 and var_4_0 ~= var_4_2.id then
			arg_4_0._lastVehicleId = var_4_2.id

			local var_4_4 = var_4_2 and var_4_2.rotate or 0

			arg_4_0.effect:addParams({
				[var_4_3] = {
					deleteChildPath = "0",
					res = arg_4_0:getRes(),
					localRotation = Vector3(0, var_4_4, 0)
				}
			})
			arg_4_0.effect:refreshEffect()
		end

		if var_4_0 and var_4_0 ~= arg_4_0._lastVehicleId then
			arg_4_0:dispatchEvent(RoomEvent.VehicleIdChange)
		end
	end
end

function var_0_0.refreshReplaceType(arg_5_0)
	local var_5_0 = arg_5_0:getMO()

	if var_5_0 and arg_5_0.vehickleTransport then
		local var_5_1 = arg_5_0.vehickleTransport:checkIsInRiver()

		var_5_0:setReplaceType(var_5_1 and RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land)
	end
end

function var_0_0.getRes(arg_6_0)
	local var_6_0 = arg_6_0:getMO()
	local var_6_1 = var_6_0 and var_6_0:getReplaceDefideCfg()
	local var_6_2 = var_6_1 and var_6_1.id

	return RoomResHelper.getVehiclePath(var_6_2)
end

function var_0_0.changeVehicle(arg_7_0)
	return
end

function var_0_0.initComponents(arg_8_0)
	local var_8_0 = arg_8_0:getMO()

	arg_8_0:addComp("vehiclemove", RoomVehicleMoveComp)
	arg_8_0:addComp("vehiclefollow", RoomVehicleFollowComp)
	arg_8_0:addComp("effect", RoomEffectComp)
	arg_8_0:addComp("nightlight", RoomNightLightComp)
	arg_8_0.nightlight:setEffectKey(RoomEnum.EffectKey.VehicleGOKey)
	arg_8_0:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)

	if var_8_0 and var_8_0.ownerType == RoomVehicleEnum.OwnerType.TransportSite then
		arg_8_0:addComp("vehickleTransport", RoomVehicleTransportComp)
	end
end

function var_0_0.onStart(arg_9_0)
	var_0_0.super.onStart(arg_9_0)
end

function var_0_0.setLocalPos(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	transformhelper.setLocalPos(arg_10_0.goTrs, arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.getMO(arg_11_0)
	return RoomMapVehicleModel.instance:getById(arg_11_0.id)
end

function var_0_0.getVehicleMO(arg_12_0)
	return arg_12_0:getMO()
end

function var_0_0.setShow(arg_13_0, arg_13_1)
	arg_13_0._isShow = arg_13_1 and true or false

	gohelper.setActive(arg_13_0.containerGO, arg_13_1)

	if arg_13_1 then
		arg_13_0.vehiclemove:restart()
		arg_13_0.vehiclefollow:restart()
	else
		arg_13_0.vehiclemove:stop()
	end

	arg_13_0.vehiclefollow:setShow(arg_13_1)
end

function var_0_0.getIsShow(arg_14_0)
	return arg_14_0._isShow
end

function var_0_0.beforeDestroy(arg_15_0)
	var_0_0.super.beforeDestroy(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, arg_15_0.go)
end

function var_0_0.getMainEffectKey(arg_16_0)
	return RoomEnum.EffectKey.VehicleGOKey
end

return var_0_0

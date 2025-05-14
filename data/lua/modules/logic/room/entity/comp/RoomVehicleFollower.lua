module("modules.logic.room.entity.comp.RoomVehicleFollower", package.seeall)

local var_0_0 = class("RoomVehicleFollower")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.vehicleMoveComp = arg_1_1
	arg_1_0._cacheDataDic = {}
	arg_1_0._pathPosList = {}
	arg_1_0._childList = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0.__isDispose = false
	arg_2_0._coypNameKey = arg_2_4
	arg_2_0.go = arg_2_1
	arg_2_0.goTrs = arg_2_1.transform
	arg_2_0.followDistance = arg_2_3
	arg_2_0._vehiceMeshRotate = arg_2_5 or 0
	arg_2_0.radius = arg_2_2 or 0
	arg_2_0._isVehiceForward = true
	arg_2_0._goNightList = {}
end

function var_0_0.onEffectRebuild(arg_3_0)
	local var_3_0 = arg_3_0.vehicleMoveComp.entity.effect

	if not string.nilorempty(arg_3_0._coypNameKey) and var_3_0 and var_3_0:isHasEffectGOByKey(RoomEnum.EffectKey.VehicleGOKey) and gohelper.isNil(arg_3_0._vehiceMeshGo) then
		local var_3_1 = var_3_0:getEffectGO(RoomEnum.EffectKey.VehicleGOKey)
		local var_3_2 = gohelper.findChild(var_3_1, arg_3_0._coypNameKey)

		if not gohelper.isNil(var_3_2) then
			arg_3_0._vehiceMeshGo = gohelper.clone(var_3_2, arg_3_0.go)

			transformhelper.setLocalPos(arg_3_0._vehiceMeshGo.transform, 0, 0.04, 0)
			transformhelper.setLocalRotation(arg_3_0._vehiceMeshGo.transform, 0, arg_3_0:_getVehiceRotate(), 0)
			RoomHelper.getGameObjectsByNameInChildren(arg_3_0._vehiceMeshGo, RoomEnum.EntityChildKey.NightLightGOKey, arg_3_0._goNightList)
		else
			local var_3_3 = arg_3_0.vehicleMoveComp:getVehicleMO()

			if var_3_3 and var_3_3.config then
				logError(string.format("交通工具[%s-%s], 子节点[%s]找不到", var_3_3.config.name, var_3_3.config.id, arg_3_0._coypNameKey))
			end
		end
	end
end

function var_0_0.setParentFollower(arg_4_0, arg_4_1)
	arg_4_0._parentFollower = arg_4_1
end

function var_0_0.setVehiceForward(arg_5_0, arg_5_1)
	if arg_5_0._isVehiceForward ~= arg_5_1 then
		arg_5_0._isVehiceForward = arg_5_1

		if not gohelper.isNil(arg_5_0._vehiceMeshGo) then
			transformhelper.setLocalRotation(arg_5_0._vehiceMeshGo.transform, 0, arg_5_0:_getVehiceRotate(), 0)
		end
	end
end

function var_0_0._getVehiceRotate(arg_6_0)
	if arg_6_0._isVehiceForward then
		return arg_6_0._vehiceMeshRotate
	end

	return arg_6_0._vehiceMeshRotate + 180
end

function var_0_0.addPathPos(arg_7_0, arg_7_1)
	table.insert(arg_7_0._pathPosList, 1, arg_7_1)
end

function var_0_0.setPathList(arg_8_0, arg_8_1)
	arg_8_0._pathPosList = {}

	tabletool.addValues(arg_8_0._pathPosList, arg_8_1)
end

function var_0_0.moveByPathData(arg_9_0)
	local var_9_0 = arg_9_0.vehicleMoveComp:getPathData()

	if var_9_0:getPosCount() < 1 then
		return
	end

	local var_9_1
	local var_9_2
	local var_9_3 = arg_9_0.vehicleMoveComp.targetTrs.position
	local var_9_4 = Vector3.Distance(var_9_3, var_9_0:getFirstPos())
	local var_9_5 = arg_9_0.followDistance - var_9_4
	local var_9_6 = var_9_5 - arg_9_0.radius

	if var_9_5 <= 0 then
		var_9_1 = Vector3.Lerp(var_9_3, var_9_0:getFirstPos(), arg_9_0.followDistance / var_9_4)
	else
		var_9_1 = var_9_0:getPosByDistance(var_9_5)
	end

	if arg_9_0.radius > 0 then
		if var_9_6 <= 0 then
			var_9_2 = Vector3.Lerp(var_9_3, var_9_0:getFirstPos(), (arg_9_0.followDistance - arg_9_0.radius) / var_9_4)
		else
			var_9_2 = var_9_0:getPosByDistance(var_9_6)
		end
	end

	if var_9_1 then
		transformhelper.setPos(arg_9_0.goTrs, var_9_1.x, var_9_1.y, var_9_1.z)
	end

	if var_9_2 then
		arg_9_0.goTrs:LookAt(var_9_2)
	end
end

function var_0_0.nightLight(arg_10_0, arg_10_1)
	if arg_10_0._goNightList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._goNightList) do
			gohelper.setActive(iter_10_1, arg_10_1)
		end
	end
end

function var_0_0.dispose(arg_11_0)
	arg_11_0.__isDispose = true
	arg_11_0.go = nil
	arg_11_0.goTrs = nil

	if arg_11_0._vehiceMeshGo then
		gohelper.destroy(arg_11_0._vehiceMeshGo)

		arg_11_0._vehiceMeshGo = nil
	end

	if arg_11_0.endGo then
		gohelper.destroy(arg_11_0.endGo)

		arg_11_0.endGo = nil
		arg_11_0.endGoTrs = nil
	end

	arg_11_0._parentFollower = nil

	if arg_11_0._goNightList then
		for iter_11_0 in pairs(arg_11_0._goNightList) do
			rawset(arg_11_0._goNightList, iter_11_0, nil)
		end

		arg_11_0._goNightList = nil
	end
end

return var_0_0

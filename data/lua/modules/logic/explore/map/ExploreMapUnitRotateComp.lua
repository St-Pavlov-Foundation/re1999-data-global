module("modules.logic.explore.map.ExploreMapUnitRotateComp", package.seeall)

local var_0_0 = class("ExploreMapUnitRotateComp", ExploreMapBaseComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._curRotateUnit = nil
	arg_1_0._btnLeft = nil
	arg_1_0._btnRight = nil
	arg_1_0._anim = nil
	arg_1_0._containerGO = gohelper.create3d(arg_1_0._mapGo, "RotateComp")

	gohelper.setActive(arg_1_0._containerGO, false)

	arg_1_0._loader = PrefabInstantiate.Create(arg_1_0._containerGO)

	arg_1_0._loader:startLoad("explore/common/sprite/prefabs/msts_icon_xuanzhuan.prefab", arg_1_0._onLoaded, arg_1_0)
end

function var_0_0._onLoaded(arg_2_0)
	local var_2_0 = arg_2_0._loader:getInstGO()

	arg_2_0._anim = var_2_0:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._btnLeft = gohelper.findChild(var_2_0, "right").transform
	arg_2_0._btnRight = gohelper.findChild(var_2_0, "left").transform
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(ExploreController.instance, ExploreEvent.SetRotateUnit, arg_3_0.changeStatus, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(ExploreController.instance, ExploreEvent.SetRotateUnit, arg_4_0.changeStatus, arg_4_0)
end

function var_0_0.changeStatus(arg_5_0, arg_5_1)
	if not arg_5_0:beginStatus() then
		return
	end

	arg_5_0:setRotateUnit(arg_5_1)
end

function var_0_0.setRotateUnit(arg_6_0, arg_6_1)
	if arg_6_0._curRotateUnit == arg_6_1 then
		return
	end

	if arg_6_0._curRotateUnit then
		arg_6_0._curRotateUnit:endRotate()
	end

	arg_6_0._curRotateUnit = arg_6_1

	if arg_6_0._curRotateUnit then
		arg_6_0._curRotateUnit:beginRotate()
	end

	if arg_6_0._curRotateUnit then
		arg_6_0:roleMoveToUnit(arg_6_0._curRotateUnit)
		arg_6_0:_setViewShow(true)

		arg_6_0._containerGO.transform.position = arg_6_0._curRotateUnit:getPos()
	else
		arg_6_0:_setViewShow(false)
	end
end

function var_0_0.onMapClick(arg_7_0, arg_7_1)
	if arg_7_0._isRoleMoving then
		return
	end

	if arg_7_0._isRotating then
		return
	end

	local var_7_0 = arg_7_0._map:getHitTriggerTrans()

	if var_7_0 then
		if var_7_0:IsChildOf(arg_7_0._btnLeft) then
			return arg_7_0:doRotate(false)
		elseif var_7_0:IsChildOf(arg_7_0._btnRight) then
			return arg_7_0:doRotate(true)
		end
	end

	arg_7_0:roleMoveBack()
end

function var_0_0.roleMoveToUnit(arg_8_0, arg_8_1)
	arg_8_0._isRoleMoving = true

	local var_8_0 = arg_8_0:getHero()
	local var_8_1 = ExploreHelper.xyToDir(arg_8_1.nodePos.x - var_8_0.nodePos.x, arg_8_1.nodePos.y - var_8_0.nodePos.y)
	local var_8_2 = (var_8_0:getPos() - arg_8_1:getPos()):SetNormalize():Mul(0.6):Add(arg_8_1:getPos())

	var_8_0:setTrOffset(var_8_1, var_8_2, nil, arg_8_0.onRoleMoveToUnitEnd, arg_8_0)
	var_8_0:setMoveSpeed(0.3)
end

function var_0_0.onRoleMoveToUnitEnd(arg_9_0)
	arg_9_0._isRoleMoving = false

	arg_9_0:getHero():setMoveSpeed(0)
end

function var_0_0.getHero(arg_10_0)
	return ExploreController.instance:getMap():getHero()
end

function var_0_0._setViewShow(arg_11_0, arg_11_1)
	TaskDispatcher.cancelTask(arg_11_0._onCloseAnimEnd, arg_11_0)

	if arg_11_0._anim then
		if arg_11_1 then
			arg_11_0._anim:Play("open", 0, 0)
			gohelper.setActive(arg_11_0._containerGO, true)
		else
			arg_11_0._anim:Play("close", 0, 0)
			TaskDispatcher.runDelay(arg_11_0._onCloseAnimEnd, arg_11_0, 0.167)
		end
	else
		gohelper.setActive(arg_11_0._containerGO, arg_11_1)
	end
end

function var_0_0._onCloseAnimEnd(arg_12_0)
	gohelper.setActive(arg_12_0._containerGO, false)
end

function var_0_0.onRoleMoveBackEnd(arg_13_0)
	arg_13_0:getHero():setMoveSpeed(0)

	arg_13_0._isRoleMoving = false

	arg_13_0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function var_0_0.roleMoveBack(arg_14_0)
	arg_14_0._isRoleMoving = true

	arg_14_0:setRotateUnit(nil)

	local var_14_0 = arg_14_0:getHero()
	local var_14_1 = var_14_0:getPos()

	var_14_0:setMoveSpeed(0.3)
	var_14_0:setTrOffset(nil, var_14_1, nil, arg_14_0.onRoleMoveBackEnd, arg_14_0)
end

function var_0_0.canSwitchStatus(arg_15_0, arg_15_1)
	if arg_15_1 == ExploreEnum.MapStatus.UseItem then
		return false
	end

	if arg_15_0._isRoleMoving or arg_15_0._isRotating then
		return false
	end

	return true
end

local var_0_1 = ExploreEnum.TriggerEvent.Rotate .. "#%d"

function var_0_0.doRotate(arg_16_0, arg_16_1)
	local var_16_0 = 0
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_0._curRotateUnit.mo.triggerEffects) do
		if iter_16_1[1] == ExploreEnum.TriggerEvent.Rotate then
			var_16_0 = iter_16_0
			var_16_1 = 1

			if arg_16_1 then
				var_16_1 = -var_16_1
			end

			break
		end
	end

	if var_16_0 <= 0 then
		return
	end

	arg_16_0._isRotating = true
	arg_16_0._isReverse = arg_16_1

	arg_16_0:_setViewShow(false)
	ExploreRpc.instance:sendExploreInteractRequest(arg_16_0._curRotateUnit.id, var_16_0, string.format(var_0_1, var_16_1), arg_16_0.onRotateRecv, arg_16_0)
end

function var_0_0.onRotateRecv(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_2 ~= 0 then
		arg_17_0._isRotating = false

		arg_17_0:_setViewShow(true)
	end
end

function var_0_0.rotateByServer(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = ExploreController.instance:getMap()

	if not arg_18_0._curRotateUnit or arg_18_0._curRotateUnit.id ~= arg_18_1 then
		local var_18_1 = var_18_0:getUnit(arg_18_1)

		if var_18_1 then
			var_18_1:_onFrameRotate(arg_18_2)
		end

		if arg_18_3 then
			arg_18_3(arg_18_4)
		end

		return
	end

	var_18_0:getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.RotateInteract, true, true)

	arg_18_0._fromRotate = arg_18_0._curRotateUnit.mo.unitDir
	arg_18_0._toRotate = arg_18_2

	if arg_18_0._isReverse then
		while arg_18_0._fromRotate < arg_18_0._toRotate do
			arg_18_0._fromRotate = arg_18_0._fromRotate + 360
		end

		while arg_18_0._fromRotate > arg_18_0._toRotate + 360 do
			arg_18_0._fromRotate = arg_18_0._fromRotate - 360
		end
	else
		while arg_18_0._fromRotate > arg_18_0._toRotate do
			arg_18_0._fromRotate = arg_18_0._fromRotate - 360
		end

		while arg_18_0._fromRotate < arg_18_0._toRotate - 360 do
			arg_18_0._fromRotate = arg_18_0._fromRotate + 360
		end
	end

	arg_18_0._curRotateUnit:_onFrameRotate(arg_18_0._fromRotate)

	arg_18_0._rotateEndCallBack = arg_18_3
	arg_18_0._rotateEndCallBackObj = arg_18_4

	arg_18_0._curRotateUnit:setEmitLight(true)
	TaskDispatcher.runDelay(arg_18_0._rotateUnit, arg_18_0, 0.2)
end

function var_0_0._rotateUnit(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.Explore.UnitRotate)
	arg_19_0._curRotateUnit:doRotate(arg_19_0._fromRotate, arg_19_0._toRotate, 0.2, arg_19_0._unitRotateEnd, arg_19_0)
end

function var_0_0._unitRotateEnd(arg_20_0)
	if arg_20_0._curRotateUnit then
		arg_20_0._curRotateUnit:setEmitLight(false)
	end

	arg_20_0:_setViewShow(true)

	arg_20_0._isRotating = false

	if arg_20_0._rotateEndCallBack then
		arg_20_0._rotateEndCallBack(arg_20_0._rotateEndCallBackObj)
	end
end

function var_0_0.onStatusEnd(arg_21_0)
	arg_21_0:setRotateUnit(nil)
end

function var_0_0.onDestroy(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onCloseAnimEnd, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._rotateUnit, arg_22_0)

	arg_22_0._rotateEndCallBack = nil
	arg_22_0._rotateEndCallBackObj = nil
	arg_22_0._curRotateUnit = nil
	arg_22_0._btnLeft = nil
	arg_22_0._btnRight = nil

	if arg_22_0._loader then
		arg_22_0._loader:dispose()

		arg_22_0._loader = nil
	end

	gohelper.destroy(arg_22_0._containerGO)

	arg_22_0._containerGO = nil

	var_0_0.super.onDestroy(arg_22_0)
end

return var_0_0

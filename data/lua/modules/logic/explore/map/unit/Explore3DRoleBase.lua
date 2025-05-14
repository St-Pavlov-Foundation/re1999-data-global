module("modules.logic.explore.map.unit.Explore3DRoleBase", package.seeall)

local var_0_0 = class("Explore3DRoleBase", ExploreBaseMoveUnit)

function var_0_0.onInit(arg_1_0)
	arg_1_0._offsetPos = Vector3(0.5, 0, 0.5)
	arg_1_0._angle = Vector3(0, 0, 0)
	arg_1_0._walkDistance = 0
	arg_1_0.dir = 270
end

function var_0_0.isRole(arg_2_0)
	return true
end

function var_0_0.initComponents(arg_3_0)
	arg_3_0:addComp("animComp", ExploreRoleAnimComp)
	arg_3_0:addComp("animEffectComp", ExploreRoleAnimEffectComp)
	arg_3_0:addComp("uiComp", ExploreUnitUIComp)
end

function var_0_0.playAnim(arg_4_0, arg_4_1)
	var_0_0.super.playAnim(arg_4_0, arg_4_1)

	arg_4_0._cacheAnimName = arg_4_1
end

function var_0_0.setBool(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.animComp:setBool(arg_5_1, arg_5_2)
end

function var_0_0.setFloat(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.animComp:setFloat(arg_6_1, arg_6_2)
end

function var_0_0.setMoveState(arg_7_0, arg_7_1)
	arg_7_0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveState, arg_7_1)
end

function var_0_0.getHeroStatus(arg_8_0)
	return arg_8_0._curStatus or ExploreAnimEnum.RoleAnimStatus.None
end

function var_0_0.setHeroStatus(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 == arg_9_0._curStatus and arg_9_1 ~= ExploreAnimEnum.RoleAnimStatus.None then
		arg_9_0.animEffectComp:setStatus(ExploreAnimEnum.RoleAnimStatus.None)
	end

	arg_9_0._curStatus = arg_9_1

	arg_9_0.animEffectComp:setStatus(arg_9_1)
	TaskDispatcher.cancelTask(arg_9_0.delaySetNormalStatus, arg_9_0)

	if arg_9_0._statusControl then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)

		arg_9_0._statusControl = nil
	end

	local var_9_0

	if arg_9_2 then
		var_9_0 = ExploreAnimEnum.RoleAnimLen[arg_9_1]
	end

	if var_9_0 and var_9_0 > 0 then
		TaskDispatcher.runDelay(arg_9_0.delaySetNormalStatus, arg_9_0, var_9_0)
	end

	arg_9_0._statusControl = arg_9_3

	if arg_9_3 then
		PopupController.instance:setPause("ExploreHeroLock", true)
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)
	end

	arg_9_0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.Status, arg_9_1)
end

function var_0_0.delaySetNormalStatus(arg_10_0)
	arg_10_0._curStatus = ExploreAnimEnum.RoleAnimStatus.None

	arg_10_0.animEffectComp:setStatus(ExploreAnimEnum.RoleAnimStatus.None)
	arg_10_0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.Status, ExploreAnimEnum.RoleAnimStatus.None)

	if arg_10_0._statusControl then
		PopupController.instance:setPause("ExploreHeroLock", false)
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)

		arg_10_0._statusControl = nil
	end
end

function var_0_0.moveSpeed(arg_11_0)
	local var_11_0 = ExploreAnimEnum.RoleSpeed.run

	if ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.MoveUnit then
		var_11_0 = ExploreAnimEnum.RoleSpeed.walk
	end

	arg_11_0:setMoveSpeed(var_11_0)

	return var_11_0
end

function var_0_0.setMoveSpeed(arg_12_0, arg_12_1)
	local var_12_0 = ExploreAnimEnum.RoleMoveState.Idle

	if arg_12_1 == 0 then
		var_12_0 = ExploreAnimEnum.RoleMoveState.Idle
	else
		var_12_0 = ExploreAnimEnum.RoleMoveState.Move
	end

	if var_12_0 == ExploreAnimEnum.RoleMoveState.Move or not arg_12_0._tarUnitMO or arg_12_0._tarUnitMO.type ~= ExploreEnum.ItemType.PipePot then
		TaskDispatcher.cancelTask(arg_12_0._delaySetIdle, arg_12_0)
		arg_12_0:setMoveState(var_12_0)
	else
		TaskDispatcher.runDelay(arg_12_0._delaySetIdle, arg_12_0, 0.2)
	end
end

function var_0_0._delaySetIdle(arg_13_0)
	arg_13_0:setMoveState(ExploreAnimEnum.RoleMoveState.Idle)
end

function var_0_0._endMove(arg_14_0, ...)
	arg_14_0:setMoveSpeed(0)
	var_0_0.super._endMove(arg_14_0, ...)
end

function var_0_0.stopMoving(arg_15_0, arg_15_1)
	if arg_15_1 then
		arg_15_0:setMoveSpeed(0)
	end

	return var_0_0.super.stopMoving(arg_15_0, arg_15_1)
end

function var_0_0.onDirChange(arg_16_0, arg_16_1)
	arg_16_0:setRotate(0, arg_16_0.dir, 0)
end

function var_0_0.onCheckDir(arg_17_0, arg_17_1, arg_17_2)
	if not ExploreHelper.isPosEqual(arg_17_1, arg_17_2) then
		if arg_17_2.x == arg_17_1.x then
			if arg_17_2.y > arg_17_1.y then
				arg_17_0.dir = 0
			else
				arg_17_0.dir = 180
			end
		elseif arg_17_2.x < arg_17_1.x then
			arg_17_0.dir = 270
		else
			arg_17_0.dir = 90
		end
	end

	arg_17_0.dir = arg_17_0._lockDir or arg_17_0.dir

	arg_17_0:onDirChange()
end

function var_0_0.onCheckDirByPos(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1:Equals(arg_18_2) then
		return
	end

	local var_18_0 = arg_18_2.x - arg_18_1.x
	local var_18_1 = arg_18_2.z - arg_18_1.z
	local var_18_2 = math.deg(math.atan2(var_18_0, var_18_1))

	var_18_2 = arg_18_0._lockDir or var_18_2

	arg_18_0:setRotate(0, var_18_2, 0)
end

function var_0_0._onSpineLoaded(arg_19_0, arg_19_1)
	arg_19_0:playAnim(arg_19_0._cacheAnimName or ExploreAnimEnum.RoleAnimName.idle)

	if arg_19_0._callback then
		if arg_19_0._callbackObj then
			arg_19_0._callback(arg_19_0._callbackObj, arg_19_1, arg_19_0)
		else
			arg_19_0._callback(arg_19_1, arg_19_0)
		end
	end

	arg_19_0:setRotate(arg_19_0._angle.x, arg_19_0._angle.y, arg_19_0._angle.z)

	arg_19_0._callback = nil
	arg_19_0._callbackObj = nil
end

function var_0_0.setRotate(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._angle.x = arg_20_1
	arg_20_0._angle.y = arg_20_2
	arg_20_0._angle.z = arg_20_3

	if arg_20_0._displayTr then
		transformhelper.setLocalRotation(arg_20_0._displayTr, arg_20_0._angle.x, arg_20_0._angle.y, arg_20_0._angle.z)
	end
end

function var_0_0.setTrOffset(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
	if not arg_21_0._displayTr then
		return
	end

	if arg_21_1 then
		arg_21_0:setRotate(0, arg_21_1, 0)
	end

	if arg_21_0._tweenMoveId then
		ZProj.TweenHelper.KillById(arg_21_0._tweenMoveId)
	end

	TaskDispatcher.runRepeat(arg_21_0.onTweenMoving, arg_21_0, 0, -1)

	arg_21_0._tweenMoveEndCb = arg_21_4
	arg_21_0._tweenMoveEndCbObj = arg_21_5
	arg_21_0._tweenMoveId = ZProj.TweenHelper.DOMove(arg_21_0._displayTr, arg_21_2.x, arg_21_2.y, arg_21_2.z, arg_21_3 or 0.3, arg_21_0.onTweenMoveEnd, arg_21_0, nil, arg_21_6 or EaseType.Linear)
end

function var_0_0.onTweenMoving(arg_22_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroTweenDisTr, arg_22_0._displayTr.position)
end

function var_0_0.onTweenMoveEnd(arg_23_0)
	arg_23_0._tweenMoveId = nil

	TaskDispatcher.cancelTask(arg_23_0.onTweenMoving, arg_23_0)

	local var_23_0 = arg_23_0._tweenMoveEndCb
	local var_23_1 = arg_23_0._tweenMoveEndCbObj

	arg_23_0._tweenMoveEndCb = nil
	arg_23_0._tweenMoveEndCbObj = nil

	if var_23_0 then
		var_23_0(var_23_1)
	end
end

function var_0_0.onDestroy(arg_24_0)
	PopupController.instance:setPause("ExploreHeroLock", false)
	TaskDispatcher.cancelTask(arg_24_0._delaySetIdle, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.onTweenMoving, arg_24_0)

	if arg_24_0._tweenMoveId then
		ZProj.TweenHelper.KillById(arg_24_0._tweenMoveId)

		arg_24_0._tweenMoveId = nil
	end

	TaskDispatcher.cancelTask(arg_24_0.delaySetNormalStatus, arg_24_0)
	var_0_0.super.onDestroy(arg_24_0)
end

return var_0_0

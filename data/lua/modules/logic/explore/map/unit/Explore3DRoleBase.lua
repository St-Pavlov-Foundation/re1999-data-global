module("modules.logic.explore.map.unit.Explore3DRoleBase", package.seeall)

slot0 = class("Explore3DRoleBase", ExploreBaseMoveUnit)

function slot0.onInit(slot0)
	slot0._offsetPos = Vector3(0.5, 0, 0.5)
	slot0._angle = Vector3(0, 0, 0)
	slot0._walkDistance = 0
	slot0.dir = 270
end

function slot0.isRole(slot0)
	return true
end

function slot0.initComponents(slot0)
	slot0:addComp("animComp", ExploreRoleAnimComp)
	slot0:addComp("animEffectComp", ExploreRoleAnimEffectComp)
	slot0:addComp("uiComp", ExploreUnitUIComp)
end

function slot0.playAnim(slot0, slot1)
	uv0.super.playAnim(slot0, slot1)

	slot0._cacheAnimName = slot1
end

function slot0.setBool(slot0, slot1, slot2)
	slot0.animComp:setBool(slot1, slot2)
end

function slot0.setFloat(slot0, slot1, slot2)
	slot0.animComp:setFloat(slot1, slot2)
end

function slot0.setMoveState(slot0, slot1)
	slot0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveState, slot1)
end

function slot0.getHeroStatus(slot0)
	return slot0._curStatus or ExploreAnimEnum.RoleAnimStatus.None
end

function slot0.setHeroStatus(slot0, slot1, slot2, slot3)
	if slot1 == slot0._curStatus and slot1 ~= ExploreAnimEnum.RoleAnimStatus.None then
		slot0.animEffectComp:setStatus(ExploreAnimEnum.RoleAnimStatus.None)
	end

	slot0._curStatus = slot1

	slot0.animEffectComp:setStatus(slot1)
	TaskDispatcher.cancelTask(slot0.delaySetNormalStatus, slot0)

	if slot0._statusControl then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)

		slot0._statusControl = nil
	end

	slot4 = nil

	if slot2 then
		slot4 = ExploreAnimEnum.RoleAnimLen[slot1]
	end

	if slot4 and slot4 > 0 then
		TaskDispatcher.runDelay(slot0.delaySetNormalStatus, slot0, slot4)
	end

	slot0._statusControl = slot3

	if slot3 then
		PopupController.instance:setPause("ExploreHeroLock", true)
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)
	end

	slot0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.Status, slot1)
end

function slot0.delaySetNormalStatus(slot0)
	slot0._curStatus = ExploreAnimEnum.RoleAnimStatus.None

	slot0.animEffectComp:setStatus(ExploreAnimEnum.RoleAnimStatus.None)
	slot0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.Status, ExploreAnimEnum.RoleAnimStatus.None)

	if slot0._statusControl then
		PopupController.instance:setPause("ExploreHeroLock", false)
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)

		slot0._statusControl = nil
	end
end

function slot0.moveSpeed(slot0)
	slot1 = ExploreAnimEnum.RoleSpeed.run

	if ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.MoveUnit then
		slot1 = ExploreAnimEnum.RoleSpeed.walk
	end

	slot0:setMoveSpeed(slot1)

	return slot1
end

function slot0.setMoveSpeed(slot0, slot1)
	slot2 = ExploreAnimEnum.RoleMoveState.Idle

	if ((slot1 ~= 0 or ExploreAnimEnum.RoleMoveState.Idle) and ExploreAnimEnum.RoleMoveState.Move) == ExploreAnimEnum.RoleMoveState.Move or not slot0._tarUnitMO or slot0._tarUnitMO.type ~= ExploreEnum.ItemType.PipePot then
		TaskDispatcher.cancelTask(slot0._delaySetIdle, slot0)
		slot0:setMoveState(slot2)
	else
		TaskDispatcher.runDelay(slot0._delaySetIdle, slot0, 0.2)
	end
end

function slot0._delaySetIdle(slot0)
	slot0:setMoveState(ExploreAnimEnum.RoleMoveState.Idle)
end

function slot0._endMove(slot0, ...)
	slot0:setMoveSpeed(0)
	uv0.super._endMove(slot0, ...)
end

function slot0.stopMoving(slot0, slot1)
	if slot1 then
		slot0:setMoveSpeed(0)
	end

	return uv0.super.stopMoving(slot0, slot1)
end

function slot0.onDirChange(slot0, slot1)
	slot0:setRotate(0, slot0.dir, 0)
end

function slot0.onCheckDir(slot0, slot1, slot2)
	if not ExploreHelper.isPosEqual(slot1, slot2) then
		if slot2.x == slot1.x then
			if slot1.y < slot2.y then
				slot0.dir = 0
			else
				slot0.dir = 180
			end
		elseif slot2.x < slot1.x then
			slot0.dir = 270
		else
			slot0.dir = 90
		end
	end

	slot0.dir = slot0._lockDir or slot0.dir

	slot0:onDirChange()
end

function slot0.onCheckDirByPos(slot0, slot1, slot2)
	if slot1:Equals(slot2) then
		return
	end

	slot0:setRotate(0, slot0._lockDir or math.deg(math.atan2(slot2.x - slot1.x, slot2.z - slot1.z)), 0)
end

function slot0._onSpineLoaded(slot0, slot1)
	slot0:playAnim(slot0._cacheAnimName or ExploreAnimEnum.RoleAnimName.idle)

	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj, slot1, slot0)
		else
			slot0._callback(slot1, slot0)
		end
	end

	slot0:setRotate(slot0._angle.x, slot0._angle.y, slot0._angle.z)

	slot0._callback = nil
	slot0._callbackObj = nil
end

function slot0.setRotate(slot0, slot1, slot2, slot3)
	slot0._angle.x = slot1
	slot0._angle.y = slot2
	slot0._angle.z = slot3

	if slot0._displayTr then
		transformhelper.setLocalRotation(slot0._displayTr, slot0._angle.x, slot0._angle.y, slot0._angle.z)
	end
end

function slot0.setTrOffset(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0._displayTr then
		return
	end

	if slot1 then
		slot0:setRotate(0, slot1, 0)
	end

	if slot0._tweenMoveId then
		ZProj.TweenHelper.KillById(slot0._tweenMoveId)
	end

	TaskDispatcher.runRepeat(slot0.onTweenMoving, slot0, 0, -1)

	slot0._tweenMoveEndCb = slot4
	slot0._tweenMoveEndCbObj = slot5
	slot0._tweenMoveId = ZProj.TweenHelper.DOMove(slot0._displayTr, slot2.x, slot2.y, slot2.z, slot3 or 0.3, slot0.onTweenMoveEnd, slot0, nil, slot6 or EaseType.Linear)
end

function slot0.onTweenMoving(slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroTweenDisTr, slot0._displayTr.position)
end

function slot0.onTweenMoveEnd(slot0)
	slot0._tweenMoveId = nil

	TaskDispatcher.cancelTask(slot0.onTweenMoving, slot0)

	slot0._tweenMoveEndCb = nil
	slot0._tweenMoveEndCbObj = nil

	if slot0._tweenMoveEndCb then
		slot1(slot0._tweenMoveEndCbObj)
	end
end

function slot0.onDestroy(slot0)
	PopupController.instance:setPause("ExploreHeroLock", false)
	TaskDispatcher.cancelTask(slot0._delaySetIdle, slot0)
	TaskDispatcher.cancelTask(slot0.onTweenMoving, slot0)

	if slot0._tweenMoveId then
		ZProj.TweenHelper.KillById(slot0._tweenMoveId)

		slot0._tweenMoveId = nil
	end

	TaskDispatcher.cancelTask(slot0.delaySetNormalStatus, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0

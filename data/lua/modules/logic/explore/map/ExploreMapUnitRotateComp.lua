module("modules.logic.explore.map.ExploreMapUnitRotateComp", package.seeall)

slot0 = class("ExploreMapUnitRotateComp", ExploreMapBaseComp)

function slot0.onInit(slot0)
	slot0._curRotateUnit = nil
	slot0._btnLeft = nil
	slot0._btnRight = nil
	slot0._anim = nil
	slot0._containerGO = gohelper.create3d(slot0._mapGo, "RotateComp")

	gohelper.setActive(slot0._containerGO, false)

	slot0._loader = PrefabInstantiate.Create(slot0._containerGO)

	slot0._loader:startLoad("explore/common/sprite/prefabs/msts_icon_xuanzhuan.prefab", slot0._onLoaded, slot0)
end

function slot0._onLoaded(slot0)
	slot1 = slot0._loader:getInstGO()
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnLeft = gohelper.findChild(slot1, "right").transform
	slot0._btnRight = gohelper.findChild(slot1, "left").transform
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.SetRotateUnit, slot0.changeStatus, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.SetRotateUnit, slot0.changeStatus, slot0)
end

function slot0.changeStatus(slot0, slot1)
	if not slot0:beginStatus() then
		return
	end

	slot0:setRotateUnit(slot1)
end

function slot0.setRotateUnit(slot0, slot1)
	if slot0._curRotateUnit == slot1 then
		return
	end

	if slot0._curRotateUnit then
		slot0._curRotateUnit:endRotate()
	end

	slot0._curRotateUnit = slot1

	if slot0._curRotateUnit then
		slot0._curRotateUnit:beginRotate()
	end

	if slot0._curRotateUnit then
		slot0:roleMoveToUnit(slot0._curRotateUnit)
		slot0:_setViewShow(true)

		slot0._containerGO.transform.position = slot0._curRotateUnit:getPos()
	else
		slot0:_setViewShow(false)
	end
end

function slot0.onMapClick(slot0, slot1)
	if slot0._isRoleMoving then
		return
	end

	if slot0._isRotating then
		return
	end

	if slot0._map:getHitTriggerTrans() then
		if slot2:IsChildOf(slot0._btnLeft) then
			return slot0:doRotate(false)
		elseif slot2:IsChildOf(slot0._btnRight) then
			return slot0:doRotate(true)
		end
	end

	slot0:roleMoveBack()
end

function slot0.roleMoveToUnit(slot0, slot1)
	slot0._isRoleMoving = true
	slot2 = slot0:getHero()

	slot2:setTrOffset(ExploreHelper.xyToDir(slot1.nodePos.x - slot2.nodePos.x, slot1.nodePos.y - slot2.nodePos.y), (slot2:getPos() - slot1:getPos()):SetNormalize():Mul(0.6):Add(slot1:getPos()), nil, slot0.onRoleMoveToUnitEnd, slot0)
	slot2:setMoveSpeed(0.3)
end

function slot0.onRoleMoveToUnitEnd(slot0)
	slot0._isRoleMoving = false

	slot0:getHero():setMoveSpeed(0)
end

function slot0.getHero(slot0)
	return ExploreController.instance:getMap():getHero()
end

function slot0._setViewShow(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._onCloseAnimEnd, slot0)

	if slot0._anim then
		if slot1 then
			slot0._anim:Play("open", 0, 0)
			gohelper.setActive(slot0._containerGO, true)
		else
			slot0._anim:Play("close", 0, 0)
			TaskDispatcher.runDelay(slot0._onCloseAnimEnd, slot0, 0.167)
		end
	else
		gohelper.setActive(slot0._containerGO, slot1)
	end
end

function slot0._onCloseAnimEnd(slot0)
	gohelper.setActive(slot0._containerGO, false)
end

function slot0.onRoleMoveBackEnd(slot0)
	slot0:getHero():setMoveSpeed(0)

	slot0._isRoleMoving = false

	slot0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function slot0.roleMoveBack(slot0)
	slot0._isRoleMoving = true

	slot0:setRotateUnit(nil)

	slot1 = slot0:getHero()

	slot1:setMoveSpeed(0.3)
	slot1:setTrOffset(nil, slot1:getPos(), nil, slot0.onRoleMoveBackEnd, slot0)
end

function slot0.canSwitchStatus(slot0, slot1)
	if slot1 == ExploreEnum.MapStatus.UseItem then
		return false
	end

	if slot0._isRoleMoving or slot0._isRotating then
		return false
	end

	return true
end

slot1 = ExploreEnum.TriggerEvent.Rotate .. "#%d"

function slot0.doRotate(slot0, slot1)
	slot2 = 0
	slot3 = 0

	for slot7, slot8 in pairs(slot0._curRotateUnit.mo.triggerEffects) do
		if slot8[1] == ExploreEnum.TriggerEvent.Rotate then
			slot2 = slot7

			if slot1 then
				slot3 = -1
			end

			break
		end
	end

	if slot2 <= 0 then
		return
	end

	slot0._isRotating = true
	slot0._isReverse = slot1

	slot0:_setViewShow(false)
	ExploreRpc.instance:sendExploreInteractRequest(slot0._curRotateUnit.id, slot2, string.format(uv0, slot3), slot0.onRotateRecv, slot0)
end

function slot0.onRotateRecv(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		slot0._isRotating = false

		slot0:_setViewShow(true)
	end
end

function slot0.rotateByServer(slot0, slot1, slot2, slot3, slot4)
	slot5 = ExploreController.instance:getMap()

	if not slot0._curRotateUnit or slot0._curRotateUnit.id ~= slot1 then
		if slot5:getUnit(slot1) then
			slot6:_onFrameRotate(slot2)
		end

		if slot3 then
			slot3(slot4)
		end

		return
	end

	slot5:getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.RotateInteract, true, true)

	slot0._fromRotate = slot0._curRotateUnit.mo.unitDir
	slot0._toRotate = slot2

	if slot0._isReverse then
		while slot0._fromRotate < slot0._toRotate do
			slot0._fromRotate = slot0._fromRotate + 360
		end

		while slot0._fromRotate > slot0._toRotate + 360 do
			slot0._fromRotate = slot0._fromRotate - 360
		end
	else
		while slot0._toRotate < slot0._fromRotate do
			slot0._fromRotate = slot0._fromRotate - 360
		end

		while slot0._fromRotate < slot0._toRotate - 360 do
			slot0._fromRotate = slot0._fromRotate + 360
		end
	end

	slot0._curRotateUnit:_onFrameRotate(slot0._fromRotate)

	slot0._rotateEndCallBack = slot3
	slot0._rotateEndCallBackObj = slot4

	slot0._curRotateUnit:setEmitLight(true)
	TaskDispatcher.runDelay(slot0._rotateUnit, slot0, 0.2)
end

function slot0._rotateUnit(slot0)
	AudioMgr.instance:trigger(AudioEnum.Explore.UnitRotate)
	slot0._curRotateUnit:doRotate(slot0._fromRotate, slot0._toRotate, 0.2, slot0._unitRotateEnd, slot0)
end

function slot0._unitRotateEnd(slot0)
	if slot0._curRotateUnit then
		slot0._curRotateUnit:setEmitLight(false)
	end

	slot0:_setViewShow(true)

	slot0._isRotating = false

	if slot0._rotateEndCallBack then
		slot0._rotateEndCallBack(slot0._rotateEndCallBackObj)
	end
end

function slot0.onStatusEnd(slot0)
	slot0:setRotateUnit(nil)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onCloseAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0._rotateUnit, slot0)

	slot0._rotateEndCallBack = nil
	slot0._rotateEndCallBackObj = nil
	slot0._curRotateUnit = nil
	slot0._btnLeft = nil
	slot0._btnRight = nil

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	gohelper.destroy(slot0._containerGO)

	slot0._containerGO = nil

	uv0.super.onDestroy(slot0)
end

return slot0

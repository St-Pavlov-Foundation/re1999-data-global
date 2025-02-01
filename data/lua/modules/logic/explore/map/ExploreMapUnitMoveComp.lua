module("modules.logic.explore.map.ExploreMapUnitMoveComp", package.seeall)

slot0 = class("ExploreMapUnitMoveComp", ExploreMapBaseComp)

function slot0.onInit(slot0)
	slot0._path = "explore/common/sprite/prefabs/msts_icon_yidong.prefab"
	slot0._cloneGo = nil
	slot0._anim = nil
	slot0._curMoveUnit = nil
	slot0._useList = {}
	slot0._legalPosDic = {}
	slot0._loader = SequenceAbLoader.New()

	slot0._loader:addPath(slot0._path)
	slot0._loader:startLoad(slot0.onLoaded, slot0)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.SetMoveUnit, slot0.changeStatus, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.SetMoveUnit, slot0.changeStatus, slot0)
end

function slot0.onLoaded(slot0)
	slot1 = gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0._mapGo)
	slot0._cloneGo = slot1
	slot0._useList[1] = gohelper.findChild(slot1, "top")
	slot0._useList[2] = gohelper.findChild(slot1, "down")
	slot0._useList[3] = gohelper.findChild(slot1, "left")
	slot0._useList[4] = gohelper.findChild(slot1, "right")
	slot5 = UnityEngine.Animator
	slot0._anim = slot1:GetComponent(typeof(slot5))

	for slot5 = 1, 4 do
		gohelper.setActive(slot0._useList[slot5], false)
	end

	if slot0._curMoveUnit then
		slot0:setMoveUnit(slot0._curMoveUnit, true)
	end
end

function slot0.changeStatus(slot0, slot1)
	if not slot0:beginStatus() then
		return
	end

	slot0:setMoveUnit(slot1)
end

function slot0._onCloseAnimEnd(slot0)
	for slot4 = 1, 4 do
		gohelper.setActive(slot0._useList[slot4], false)
	end
end

function slot0.setMoveUnit(slot0, slot1, slot2)
	if not slot2 then
		if slot0._curMoveUnit == slot1 then
			return
		end

		if slot0._curMoveUnit then
			slot0._curMoveUnit:endPick()
		end

		if slot1 then
			slot1:beginPick()
		end
	end

	slot0._curMoveUnit = slot1

	if not slot0._useList[1] then
		return
	end

	if not slot0._unitMoving and slot0._curMoveUnit then
		slot0:roleMoveToUnit(slot0._curMoveUnit)
	end

	if slot0._anim then
		TaskDispatcher.cancelTask(slot0._onCloseAnimEnd, slot0)

		if slot0._curMoveUnit then
			slot0._anim:Play("open", 0, 0)
		else
			slot0._anim:Play("close", 0, 0)
			TaskDispatcher.runDelay(slot0._onCloseAnimEnd, slot0, 0.167)
		end
	else
		for slot6 = 1, 4 do
			gohelper.setActive(slot0._useList[slot6], false)
		end
	end

	slot0._legalPosDic = {}
	slot3, slot4 = nil

	if slot0._curMoveUnit then
		if ExploreHelper.getDistance(slot0._map:getHeroPos(), slot1.nodePos) ~= 1 then
			slot0._curMoveUnit = nil

			logError("隔空抓取物品？？")

			return
		end

		slot7 = slot1:getPos()

		transformhelper.setPos(slot0._cloneGo.transform, slot7.x, slot7.y, slot7.z)

		if slot5.x == slot6.x then
			slot0:updateUse(ExploreHelper.getKeyXY(slot6.x, math.max(slot5.y, slot6.y) + 1), slot4, 1, slot6.y < slot5.y and slot5)
			slot0:updateUse(ExploreHelper.getKeyXY(slot6.x, math.min(slot5.y, slot6.y) - 1), slot4, 2, slot5.y < slot6.y and slot5)
			slot0:updateUse(ExploreHelper.getKeyXY(slot6.x - 1, slot6.y), ExploreHelper.getKeyXY(slot5.x - 1, slot5.y), 3)
			slot0:updateUse(ExploreHelper.getKeyXY(slot6.x + 1, slot6.y), ExploreHelper.getKeyXY(slot5.x + 1, slot5.y), 4)
		else
			slot0:updateUse(ExploreHelper.getKeyXY(slot6.x, slot6.y + 1), ExploreHelper.getKeyXY(slot5.x, slot5.y + 1), 1)
			slot0:updateUse(ExploreHelper.getKeyXY(slot6.x, slot6.y - 1), ExploreHelper.getKeyXY(slot5.x, slot5.y - 1), 2)
			slot0:updateUse(ExploreHelper.getKeyXY(math.min(slot5.x, slot6.x) - 1, slot6.y), nil, 3, slot5.x < slot6.x and slot5)
			slot0:updateUse(ExploreHelper.getKeyXY(math.max(slot5.x, slot6.x) + 1, slot6.y), slot4, 4, slot6.x < slot5.x and slot5)
		end
	end
end

function slot0.updateUse(slot0, slot1, slot2, slot3, slot4)
	slot5 = ExploreMapModel.instance:getNode(slot1)
	slot6 = nil

	if slot2 then
		slot6 = ExploreMapModel.instance:getNode(slot2)
	end

	if slot5 and slot5:isWalkable() and (not slot2 or slot6 and slot6:isWalkable()) then
		gohelper.setActive(slot0._useList[slot3], true)

		if slot4 then
			if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot4)) and slot7:isWalkable() then
				slot0._legalPosDic[slot1] = slot3
			else
				gohelper.setActive(slot0._useList[slot3], false)
			end
		else
			slot0._legalPosDic[slot1] = slot3
		end

		return
	end

	gohelper.setActive(slot0._useList[slot3], false)
end

function slot0.onMapClick(slot0, slot1)
	if slot0._isRoleMoving or slot0._unitMoving then
		return
	end

	slot3, slot4, slot5 = slot0._map:GetTilemapMousePos(slot1, true)
	slot6 = nil

	if slot5 and (slot5 - slot0._curMoveUnit:getPos()).magnitude <= 1.5 then
		slot9 = ExploreHelper.dirToXY(ExploreHelper.getDir(math.floor((math.deg(math.atan2(slot7.x, slot7.z)) + 45) / 90) * 90))
		slot10 = slot0._curMoveUnit.nodePos
		slot6 = {
			x = slot9.x + slot10.x,
			y = slot9.y + slot10.y
		}
	end

	if slot6 and slot0._legalPosDic[ExploreHelper.getKey(slot6)] then
		slot0:sendUnitMoveReq(slot6)

		return
	end

	slot0:setMoveUnit(nil)
	slot0:roleMoveBack()
end

function slot0.roleMoveToUnit(slot0, slot1)
	slot0._isRoleMoving = true
	slot2 = slot0:getHero()

	slot2:setTrOffset(ExploreHelper.xyToDir(slot1.nodePos.x - slot2.nodePos.x, slot1.nodePos.y - slot2.nodePos.y), (slot2:getPos() - slot1:getPos()):SetNormalize():Mul(0.4):Add(slot1:getPos()), nil, slot0.onRoleMoveToUnitEnd, slot0)
	slot2:setMoveSpeed(0.3)
end

function slot0.onRoleMoveToUnitEnd(slot0)
	slot0._isRoleMoving = false

	slot0:getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Pull)
	slot0:getHero():setMoveSpeed(0)
end

function slot0.roleMoveBack(slot0)
	slot0._isRoleMoving = true

	slot0:setMoveUnit(nil)

	slot1 = slot0:getHero()

	slot1:setMoveSpeed(0.3)
	slot1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	slot1:setTrOffset(nil, slot1:getPos(), nil, slot0.onRoleMoveBackEnd, slot0)
end

function slot0.getHero(slot0)
	return ExploreController.instance:getMap():getHero()
end

function slot0.onRoleMoveBackEnd(slot0)
	slot0:getHero():setMoveSpeed(0)

	slot0._isRoleMoving = false

	slot0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function slot0.onStatusEnd(slot0)
	slot0:setMoveUnit(nil)
end

function slot0.sendUnitMoveReq(slot0, slot1)
	slot0._unitMoving = true
	slot0._moveTempUnit = slot0._curMoveUnit
	slot0._movePos = slot1

	ExploreModel.instance:setStepPause(true)
	ExploreRpc.instance:sendExploreMoveRequest(slot1.x, slot1.y, slot0._curMoveUnit.id, slot0._onMoveReply, slot0)
	slot0:setMoveUnit(nil)
end

function slot0._onMoveReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0._movePos = nil

		slot0:doUnitMove(slot0._movePos)
	else
		ExploreModel.instance:setStepPause(false)

		slot0._unitMoving = false
		slot0._movePos = nil
		slot0._moveTempUnit = nil

		slot0:roleMoveBack()
	end
end

function slot0.doUnitMove(slot0, slot1)
	slot2, slot3, slot4, slot5 = ExploreConfig.instance:getUnitEffectConfig(slot0._moveTempUnit:getResPath(), "drag")

	ExploreHelper.triggerAudio(slot4, slot5, slot0._moveTempUnit.go)

	slot6 = slot1.x - slot0._moveTempUnit.nodePos.x
	slot7 = slot1.y - slot0._moveTempUnit.nodePos.y
	slot8 = slot0._map:getHeroPos()
	slot9 = slot0:getHero()
	slot10 = {
		x = slot8.x + slot6,
		y = slot8.y + slot7
	}
	slot13 = ExploreHelper.getDir(ExploreHelper.xyToDir(slot6, slot7) - ExploreHelper.xyToDir(slot0._moveTempUnit.nodePos.x - slot8.x, slot0._moveTempUnit.nodePos.y - slot8.y))
	slot0._unitMoving = true

	function slot15()
		uv0:setEmitLight(false)
		ExploreModel.instance:setStepPause(false)
		uv1:setMoveUnit(uv0)

		uv1._unitMoving = false
		uv1._allSameDirLightMos = nil

		TaskDispatcher.cancelTask(uv1._everyFrameSetLightLen, uv1)
	end

	slot16 = {}

	for slot21, slot22 in pairs(ExploreController.instance:getMapLight():getAllLightMos()) do
		if slot22.endEmitUnit == slot0._moveTempUnit and ExploreHelper.getDir(slot22.dir - slot12) % 180 == 0 then
			table.insert(slot16, slot22)
		end
	end

	if slot16[1] then
		slot0._allSameDirLightMos = slot16

		TaskDispatcher.runRepeat(slot0._everyFrameSetLightLen, slot0, 0, -1)
	end

	slot0._moveTempUnit:setEmitLight(true)

	if ExploreHelper.isPosEqual(slot1, slot8) then
		slot0._map:getHero():moveByPath({
			slot10
		}, slot13, slot11)
		slot0._moveTempUnit:moveByPath({
			slot1
		}, nil, , slot15)
	else
		slot0._moveTempUnit:moveByPath({
			slot1
		}, nil, , slot15)
		slot0._map:getHero():moveByPath({
			slot10
		}, slot13, slot11)
	end

	slot0:setMoveUnit(nil)

	slot0._moveTempUnit = nil
end

function slot0._everyFrameSetLightLen(slot0)
	for slot4, slot5 in pairs(slot0._allSameDirLightMos) do
		slot5.lightLen = Vector3.Distance(slot5.curEmitUnit:getPos(), slot5.endEmitUnit:getPos())

		slot5.curEmitUnit:onLightDataChange(slot5)
	end
end

function slot0.canSwitchStatus(slot0, slot1)
	if slot1 == ExploreEnum.MapStatus.UseItem then
		return false
	end

	if slot0._unitMoving or slot0._isRoleMoving then
		return false
	end

	return true
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onCloseAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0._everyFrameSetLightLen, slot0)

	for slot4 = 1, 4 do
		slot0._useList[slot4] = nil
	end

	if slot0._cloneGo then
		gohelper.destroy(slot0._cloneGo)

		slot0._cloneGo = nil
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._anim = nil
	slot0._allSameDirLightMos = nil
	slot0._mapGo = nil
	slot0._map = nil
	slot0._curMoveUnit = nil

	uv0.super.onDestroy(slot0)
end

return slot0

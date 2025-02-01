module("modules.logic.explore.map.unit.ExploreBaseUnit", package.seeall)

slot0 = class("ExploreBaseUnit", BaseUnitSpawn)
slot1 = typeof(SLFramework.LuaMonobehavier)

function slot0.ctor(slot0, slot1, slot2)
	slot3 = gohelper.create3d(slot1, slot2)
	slot0.trans = slot3.transform

	slot0:init(slot3)

	slot0._hasInteract = false
	slot0._isEnter = false

	slot0:onInit()

	slot0._luamonoContainer = slot3:GetComponent(uv0)

	slot0:_checkContainerNeedUpdate()
end

function slot0.isRole(slot0)
	return false
end

function slot0.canMove(slot0)
	return false
end

function slot0.onEnter(slot0)
end

function slot0.onUpdateCount(slot0, slot1, slot2)
end

function slot0.setupMO(slot0)
end

function slot0.doFix(slot0)
end

function slot0.onTriggerDone(slot0)
end

function slot0.onTrigger(slot0)
end

function slot0.onCancelTrigger(slot0)
end

function slot0.onRoleEnter(slot0, slot1, slot2)
end

function slot0.onRoleStay(slot0)
end

function slot0.onRoleLeave(slot0)
end

function slot0.onExit(slot0)
end

function slot0.onRelease(slot0)
end

function slot0.onDestroy(slot0)
end

function slot0.isMoving(slot0)
	return false
end

function slot0._checkContainerNeedUpdate(slot0)
end

function slot0.onLightDataChange(slot0, slot1)
	if slot0.lightComp then
		slot0.lightComp:onLightDataChange(slot1)
	end
end

function slot0.onStatusChange(slot0, slot1)
	if ExploreHelper.getBit(slot1, ExploreEnum.InteractIndex.InteractEnabled) > 0 then
		slot0:onInteractChange(slot0.mo:isInteractEnabled())
	end

	if ExploreHelper.getBit(slot1, ExploreEnum.InteractIndex.ActiveState) > 0 then
		slot0:onActiveChange(slot0.mo:isInteractActiveState())

		if slot0.mo then
			slot0.mo:activeStateChange(slot2)
		end
	end
end

function slot0.onStatus2Change(slot0, slot1, slot2)
end

function slot0.onInteractChange(slot0, slot1)
end

function slot0.onActiveChange(slot0, slot1)
end

function slot0.onNodeChange(slot0, slot1, slot2)
end

function slot0.onRoleNear(slot0)
	slot0._roleNear = true
end

function slot0.onRoleFar(slot0)
	slot0._roleNear = false
end

function slot0.onMapInit(slot0)
end

function slot0.onHeroInitDone(slot0)
end

function slot0.setData(slot0, slot1)
	slot0.mo = slot1
	slot0.id = slot1.id
	slot0.go.name = slot0.__cname .. slot1.id

	slot0:setPosByNode(slot1.nodePos)

	if slot0.mo:isEnter() then
		slot0:setEnter()
	else
		slot0:setExit()
	end

	slot0:_setupMO()
end

function slot0.getExploreUnitMO(slot0)
	return slot0.mo
end

function slot0.setTmpData(slot0, slot1)
	slot0.mo = slot1
	slot0.id = slot1.id
	slot0.go.name = slot0.__cname .. slot1.id

	slot0:setPosByNode(slot1.nodePos, true)
	slot0:_setupMO()
end

function slot0._setupMO(slot0)
	slot0:setupMO()
end

function slot0.tryTrigger(slot0, slot1)
	if slot0.mo:isInteractEnabled() and slot0._isEnter then
		slot0:onTrigger()
		ExploreMapTriggerController.instance:triggerUnit(slot0, slot1)

		return slot0:needInteractAnim()
	end
end

function slot0.needInteractAnim(slot0)
	return false
end

function slot0.cancelTrigger(slot0)
	slot0:onCancelTrigger()
	ExploreMapTriggerController.instance:cancelTrigger(slot0)
end

function slot0.getHasInteract(slot0)
	return slot0.mo:isInteractDone()
end

function slot0.setName(slot0, slot1)
	slot0.go.name = slot1
end

function slot0.setParent(slot0, slot1)
	slot0.trans:SetParent(slot1)
end

function slot0.getPos(slot0)
	return slot0.position
end

function slot0.getUnitType(slot0)
	if slot0.mo then
		return slot0.mo.type
	end
end

function slot0.needUpdateHeroPos(slot0)
	return false
end

function slot0.getFixItemId(slot0)
	return nil
end

function slot0.canTrigger(slot0)
	return slot0.mo and slot0.mo:isInteractEnabled() and not slot0.mo:isInteractFinishState() and slot0:isEnter()
end

function slot0.isInteractActiveState(slot0)
	if slot0.mo then
		return slot0.mo:isInteractActiveState()
	end

	return false
end

function slot0.setPos(slot0, slot1, slot2)
	if gohelper.isNil(slot0.go) == false then
		transformhelper.setPos(slot0.trans, -999999, 0, -99999)

		slot1.y = 10
		slot3, slot4 = UnityEngine.Physics.Raycast(slot1, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		if slot3 then
			slot1.y = slot4.point.y
		else
			slot1.y = slot0.trans.position.y
		end

		slot0.position = slot1

		transformhelper.setPos(slot0.trans, slot0.position.x, slot0.position.y, slot0.position.z)

		if ExploreHelper.posToTile(slot1) ~= slot0.nodePos then
			slot6 = slot0.nodePos
			slot0.nodePos = slot5

			if slot0.mo then
				slot0.mo:updatePos(slot5)
			end

			slot0.nodeMO = ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos))

			if slot2 ~= true then
				ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, slot0, slot0.nodePos, slot6)
			end

			slot0:onNodeChange(slot6, slot0.nodePos)
		end
	end
end

function slot0.removeFromNode(slot0)
	slot1 = slot0.nodePos
	slot0.nodePos = nil

	if slot0.mo then
		slot0.mo:removeFromNode()
	end

	slot0.nodeMO = nil

	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, slot0, false, slot1)
	slot0:onNodeChange(slot1, slot0.nodePos)
end

function slot0.isPassLight(slot0)
	return slot0:getLightRecvType() == ExploreEnum.LightRecvType.Photic
end

function slot0.getLightRecvType(slot0)
	return slot0.mo.isPhotic and ExploreEnum.LightRecvType.Photic or ExploreEnum.LightRecvType.Barricade
end

function slot0.getLightRecvDirs(slot0)
	return nil
end

function slot0.onLightChange(slot0, slot1, slot2)
end

function slot0.onLightEnter(slot0, slot1)
end

function slot0.onLightExit(slot0)
end

function slot0.onRotation(slot0)
end

function slot0.setInFOV(slot0, slot1)
	if slot0:isEnter() and slot0._isInFOV ~= slot1 then
		slot0._isInFOV = slot1

		slot0:onInFOVChange(slot1)
	end
end

function slot0.isInFOV(slot0)
	return slot0._isInFOV or false
end

function slot0.onInFOVChange(slot0, slot1)
end

function slot0.updateSceneY(slot0, slot1)
	if slot1 then
		slot0.position.y = slot1
	else
		slot2 = slot0.position.y
		slot0.position.y = 10
		slot3, slot4 = UnityEngine.Physics.Raycast(slot0.position, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		if slot3 then
			slot0.position.y = slot4.point.y
		else
			slot0.position.y = slot0.trans.position.y
		end
	end

	transformhelper.setPos(slot0.trans, slot0.position.x, slot0.position.y, slot0.position.z)
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.trans, slot1, slot1, slot1)
end

function slot0.setRotate(slot0, slot1, slot2, slot3)
	transformhelper.setLocalRotation(slot0.trans, slot1, slot2, slot3)
end

function slot0.setPosByNode(slot0, slot1, slot2)
	slot0:setPos(ExploreHelper.tileToPos(slot1), slot2)
end

function slot0.isEnter(slot0)
	return slot0._isEnter
end

function slot0.isActive(slot0)
	return slot0.go.activeSelf
end

function slot0.isEnable(slot0)
	return slot0:isActive()
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.setEnter(slot0)
	if not slot0:isEnter() then
		slot0._isEnter = true

		slot0.mo:setEnter(true)

		if isDebugBuild then
			logWarn(string.format("[+]%s:%s进入地图", slot0.__cname, slot0.id))
		end

		slot0:setActive(true)
		slot0:onEnter()
	end
end

function slot0.setExit(slot0)
	if slot0:isEnter() then
		slot0._isEnter = false

		slot0.mo:setEnter(false)

		if isDebugBuild then
			logWarn(string.format("[-]%s:%s退出地图", slot0.__cname, slot0.id))
		end

		slot0:setActive(false)
		slot0:onExit()
	else
		logWarn("重复退出" .. slot0.id .. slot0.__cname)
	end
end

function slot0.destroy(slot0)
	slot0:onDestroy()
	gohelper.destroy(slot0.go)

	slot0.trans = nil
	slot0.mo = nil
	slot0.go = nil
end

return slot0

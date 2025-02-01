module("modules.logic.explore.map.unit.ExplorePrismUnit", package.seeall)

slot0 = class("ExplorePrismUnit", ExploreBaseLightUnit)

function slot0.getLightRecvType(slot0)
	return ExploreEnum.LightRecvType.Custom
end

function slot0.onLightEnter(slot0, slot1)
	if not slot0.mo:isInteractEnabled() then
		return
	end

	slot2 = ExploreController.instance:getMapLight()

	slot2:beginCheckStatusChange(slot0.id, slot0:haveLight())
	slot0:addLights()
	slot2:endCheckStatus()
end

function slot0.onInteractChange(slot0, slot1)
	uv0.super.onInteractChange(slot0, slot1)

	if slot0.animComp._curAnim ~= ExploreAnimEnum.AnimName.uToN then
		slot2 = ExploreController.instance:getMapLight()

		slot2:beginCheckStatusChange(slot0.id, slot0:haveLight())
		slot0:checkLight()
		slot2:endCheckStatus()
	else
		ExploreModel.instance:setStepPause(true)
	end
end

function slot0.onAnimEnd(slot0, slot1, slot2)
	uv0.super.onAnimEnd(slot0, slot1, slot2)

	if slot1 == ExploreAnimEnum.AnimName.uToN then
		slot3 = ExploreController.instance:getMapLight()

		slot3:beginCheckStatusChange(slot0.id, slot0:haveLight())
		slot0:checkLight()
		slot3:endCheckStatus()
		ExploreModel.instance:setStepPause(false)
	end
end

function slot0.onLightExit(slot0)
	slot1 = ExploreController.instance:getMapLight()

	slot1:beginCheckStatusChange(slot0.id, slot0:haveLight())
	slot0:removeLights()
	slot1:endCheckStatus()
end

function slot0.setEmitLight(slot0, slot1)
	uv0.super.setEmitLight(slot0, slot1)

	if slot1 then
		slot2 = ExploreController.instance:getMapLight()

		slot2:removeUnitEmitLight(slot0)
		slot0:removeLights()
		slot2:updateLightsByUnit(slot0)
		slot0:playAnim(slot0:getIdleAnim())
	else
		slot0:checkLight()
	end
end

function slot0.checkLight(slot0)
	if not ExploreController.instance:getMap():isInitDone() then
		return
	end

	slot2 = ExploreController.instance:getMapLight()

	if not slot0.mo:isInteractEnabled() then
		slot2:removeUnitEmitLight(slot0)
		slot0:removeLights()
		slot2:updateLightsByUnit(slot0)

		return
	end

	slot3 = slot0:haveLight()

	slot2:beginCheckStatusChange(slot0.id, slot0:haveLight())
	slot2:removeUnitEmitLight(slot0)
	slot2:updateLightsByUnit(slot0)
	slot0:removeLights()

	if slot0:isHaveIlluminant() and not slot0._isNoEmitLight then
		slot0:addLights()
	end

	slot2:endCheckStatus()
end

function slot0.haveLight(slot0)
	return slot0.lightComp:haveLight()
end

function slot0.onBallLightChange(slot0)
	slot0:checkLight()
end

function slot0.addLights(slot0)
	slot0.lightComp:addLight(slot0.mo.unitDir)
end

function slot0.removeLights(slot0)
	slot0.lightComp:removeAllLight()
end

function slot0.isCustomShowOutLine(slot0)
	slot1 = not slot0.mo:isInteractEnabled()

	return slot1, slot1 and "explore/common/sprite/prefabs/msts_icon_xiuli.prefab"
end

function slot0.isHaveIlluminant(slot0)
	return ExploreController.instance:getMapLight():haveLight(slot0)
end

function slot0.getFixItemId(slot0)
	return slot0.mo.fixItemId
end

return slot0

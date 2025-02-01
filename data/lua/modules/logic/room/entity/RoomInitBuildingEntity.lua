module("modules.logic.room.entity.RoomInitBuildingEntity", package.seeall)

slot0 = class("RoomInitBuildingEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
end

function slot0.getTag(slot0)
	return SceneTag.RoomInitBuilding
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.StaticContainerGOKey)

	uv0.super.init(slot0, slot1)

	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)

	if RoomController.instance:isObMode() then
		slot0:addComp("collider", RoomColliderComp)
		slot0:addComp("atmosphere", RoomAtmosphereComp)
		slot0:addComp("roomGift", RoomGiftActComp)
	end

	slot0:addComp("nightlight", RoomNightLightComp)
	slot0:addComp("skin", RoomInitBuildingSkinComp)
	slot0:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, slot0._characterListShowChanged, slot0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, slot0._onSwithMode, slot0)
end

function slot0.refreshBuilding(slot0, slot1, slot2)
	if string.nilorempty(slot0:_getInitBuildingRes()) then
		slot0.effect:removeParams({
			RoomEnum.EffectKey.BuildingGOKey
		})
	else
		slot0.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				pathfinding = true,
				res = slot3,
				alphaThreshold = slot1,
				alphaThresholdValue = slot2
			}
		})
	end

	slot0.effect:refreshEffect()
end

function slot0._characterListShowChanged(slot0, slot1)
	slot0:setEnable(not RoomController.instance:isEditMode() and not slot1)
end

function slot0._onSwithMode(slot0)
	slot0:setEnable(not RoomController.instance:isEditMode())
end

function slot0.setEnable(slot0, slot1)
	if slot0.collider then
		slot0.collider:setEnable(slot1 and true or false)
	end
end

function slot0._getInitBuildingRes(slot0)
	return RoomConfig.instance:getRoomSkinModelPath(RoomSkinModel.instance:getShowSkin(slot0.id)) or RoomScenePreloader.ResInitBuilding
end

function slot0.tweenAlphaThreshold(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0.alphaThresholdComp then
		return
	end

	slot0.alphaThresholdComp:tweenAlphaThreshold(slot1, slot2, slot3, slot4, slot5)
end

function slot0.beforeDestroy(slot0)
	uv0.super.beforeDestroy(slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, slot0._characterListShowChanged, slot0)
	RoomController.instance:unregisterCallback(slot0._onSwithMode, slot0)
end

function slot0.getCharacterMeshRendererList(slot0)
	return slot0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

return slot0

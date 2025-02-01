module("modules.logic.room.entity.comp.RoomColliderComp", package.seeall)

slot0 = class("RoomColliderComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._colliderEffectKey = RoomEnum.EffectKey.BuildingGOKey
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._colliderGO = nil
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._colliderParamList = nil
	slot0._isEnabled = true

	slot0:refreshPosition()
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraUpdateFinish, slot0._cameraUpdateFinish, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraUpdateFinish, slot0._cameraUpdateFinish, slot0)
end

function slot0._cameraUpdateFinish(slot0)
	slot0:refreshPosition()
end

function slot0.setEnable(slot0, slot1)
	slot0._isEnabled = slot1

	slot0:_updateEnable()
	slot0:refreshPosition()
end

function slot0._updateEnable(slot0)
	if not slot0._colliderParamList then
		return
	end

	for slot4, slot5 in ipairs(slot0._colliderParamList) do
		slot5.collider.enabled = slot0._isEnabled
	end
end

function slot0.refreshPosition(slot0)
	if not slot0.entity.effect:isHasEffectGOByKey(slot0._colliderEffectKey) then
		return
	end

	if not slot0._colliderParamList then
		slot0._colliderParamList = slot0:getUserDataTb_()

		if slot0.entity.effect:getComponentsByKey(slot0._colliderEffectKey, RoomEnum.ComponentName.BoxCollider) then
			for slot5 = 1, #slot1 do
				if slot1[slot5].gameObject.layer == UnityLayer.SceneOpaque then
					table.insert(slot0._colliderParamList, {
						collider = slot6,
						trans = slot6.transform,
						center = slot6.center
					})
				end
			end
		end

		slot0:_updateEnable()
	end

	for slot4, slot5 in ipairs(slot0._colliderParamList) do
		slot6 = slot5.trans
		slot7 = slot6.position
		slot9 = RoomBendingHelper.worldToBendingSimple(slot7):Sub(slot7)
		slot9.x = slot6.lossyScale.x ~= 0 and slot9.x / slot10.x or 0
		slot9.y = slot10.y ~= 0 and slot9.y / slot10.y or 0
		slot9.z = slot10.z ~= 0 and slot9.z / slot10.z or 0
		slot5.collider.center = slot9:Add(slot5.center)
	end
end

function slot0.clearColliderGOList(slot0)
	if not slot0._colliderParamList then
		return
	end

	for slot4, slot5 in ipairs(slot0._colliderParamList) do
		slot5.collider.center = slot5.center
	end

	slot0._colliderParamList = nil
end

function slot0.beforeDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)
	slot0:clearColliderGOList()
	slot0:removeEventListeners()
end

return slot0

module("modules.logic.room.entity.comp.RoomInitBuildingSkinComp", package.seeall)

slot0 = class("RoomInitBuildingSkinComp", LuaCompBase)
slot1 = 0.3
slot2 = "RoomInitBuildingSkinComp_refreshBuilding_block"

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._skinId = slot0:_getRoomSkin()
	slot0._switchTime = CommonConfig.instance:getConstNum(ConstEnum.RoomSkinSwitchTime)

	if not slot0._switchTime or slot0._switchTime == 0 then
		slot0._switchTime = uv0
	end
end

function slot0.addEventListeners(slot0)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.SkinListViewShowChange, slot0._onSkinChange, slot0)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.ChangePreviewRoomSkin, slot0._onSkinChange, slot0)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.ChangeEquipRoomSkin, slot0._onEquipSkin, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.SkinListViewShowChange, slot0._onSkinChange, slot0)
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.ChangePreviewRoomSkin, slot0._onSkinChange, slot0)
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.ChangeEquipRoomSkin, slot0._onEquipSkin, slot0)
end

function slot0._onSkinChange(slot0)
	if slot0.__willDestroy then
		return
	end

	if not slot0.entity or RoomSkinListModel.instance:getSelectPartId() ~= slot0.entity.id then
		return
	end

	if slot0._skinId ~= slot0:_getRoomSkin() then
		TaskDispatcher.cancelTask(slot0.delayPlayChangeEff, slot0)

		slot0._skinId = slot2

		slot0.entity:tweenAlphaThreshold(0, 1, slot0._switchTime, slot0.onHideLastSkinFinish, slot0)
	end
end

function slot0.onHideLastSkinFinish(slot0)
	if not slot0.entity or slot0.__willDestroy then
		return
	end

	UIBlockMgr.instance:startBlock(uv0)

	slot0._needPlayChangeEff = true

	slot0.entity:refreshBuilding(true, 1)
end

function slot0.onEffectRebuild(slot0)
	UIBlockMgr.instance:endBlock(uv0)

	if slot0.__willDestroy then
		return
	end

	if not slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) then
		return
	end

	if not slot1:isSameResByKey(slot0._effectKey, slot0._effectRes) then
		slot0._effectRes = slot1:getEffectRes(slot0._effectKey)
		slot0._skinId = slot0:_getRoomSkin()
	end

	if slot0._needPlayChangeEff then
		TaskDispatcher.cancelTask(slot0.delayPlayChangeEff, slot0)
		TaskDispatcher.runDelay(slot0.delayPlayChangeEff, slot0, 0.01)
	end
end

function slot0.delayPlayChangeEff(slot0)
	if slot0.__willDestroy then
		return
	end

	slot0.entity:tweenAlphaThreshold(1, 0, slot0._switchTime)

	slot0._needPlayChangeEff = false
end

function slot0._onEquipSkin(slot0)
	if slot0.__willDestroy then
		return
	end

	slot1 = RoomSkinListModel.instance:getSelectPartId()

	if not slot0.entity or slot1 ~= slot0.entity.id then
		return
	end

	if RoomSkinModel.instance:isDefaultRoomSkin(slot1, slot0._skinId) then
		return
	end

	if slot0.entity.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BuildingEquipSkinEffectKey) then
		slot6 = slot4:getEffectGO(slot3)

		gohelper.setActive(slot6, false)
		gohelper.setActive(slot6, true)
	else
		slot6 = 0
		slot7 = 0
		slot8 = 0

		if RoomConfig.instance:getRoomSkinEquipEffPos(slot0._skinId) and #slot9 > 0 then
			slot6 = slot9[1] or 0
			slot7 = slot9[2] or 0
			slot8 = slot9[3] or 0
		end

		slot10 = nil

		if RoomConfig.instance:getRoomSkinEquipEffSize(slot0._skinId) and slot11 ~= 0 then
			slot10 = Vector3(slot11, slot11, slot11)
		end

		slot4:addParams({
			[slot3] = {
				res = RoomScenePreloader.ResEquipRoomSkinEffect,
				localPos = Vector3(slot6, slot7, slot8),
				localScale = slot10
			}
		})
	end

	slot4:refreshEffect()
end

function slot0._getRoomSkin(slot0)
	if slot0.__willDestroy then
		return
	end

	return RoomSkinModel.instance:getShowSkin(slot0.entity.id)
end

function slot0.beforeDestroy(slot0)
	UIBlockMgr.instance:endBlock(uv0)

	slot0.__willDestroy = true

	slot0:removeEventListeners()
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayChangeEff, slot0)

	slot0.go = nil
	slot0._effectRes = nil
	slot0._skinId = nil
	slot0.entity = nil
	slot0._needPlayChangeEff = false
end

return slot0

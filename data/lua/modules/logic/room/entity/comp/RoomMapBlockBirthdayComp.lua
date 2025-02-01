module("modules.logic.room.entity.comp.RoomMapBlockBirthdayComp", package.seeall)

slot0 = class("RoomMapBlockBirthdayComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.addEventListeners(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.removeEventListeners(slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0._onDailyRefresh(slot0)
	slot0:refreshBirthday()
end

function slot0.onStart(slot0)
end

function slot0.refreshBirthday(slot0)
	if slot0.__willDestroy then
		return
	end

	if not (slot0.entity:getMO() and slot1.packageId == RoomBlockPackageEnum.ID.RoleBirthday) then
		return
	end

	if not slot0._birthdayAnimator then
		if gohelper.isNil(slot0.entity.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.BirthdayBlockGOKey)) then
			return
		end

		slot0._birthdayAnimator = slot3:GetComponent(RoomEnum.ComponentType.Animator)
	end

	if not slot0._birthdayAnimator then
		return
	end

	slot0._birthdayAnimator:Play(RoomCharacterModel.instance:isOnBirthday(RoomConfig.instance:getSpecialBlockConfig(slot1.id) and slot3.heroId) and "v1a9_bxhy_terrain_role_birthday" or "shengri", 0, 0)
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	slot0:removeEventListeners()
end

function slot0.onDestroy(slot0)
end

return slot0

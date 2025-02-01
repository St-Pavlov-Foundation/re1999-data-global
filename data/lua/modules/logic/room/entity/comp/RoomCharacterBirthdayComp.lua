module("modules.logic.room.entity.comp.RoomCharacterBirthdayComp", package.seeall)

slot0 = class("RoomCharacterBirthdayComp", LuaCompBase)
slot1 = 0.1

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.birthdayRes = nil
	slot0.birthdayEffKey = RoomEnum.EffectKey.CharacterBirthdayEffKey
	slot0.goTrs = slot1.transform
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.addEventListeners(slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, slot0._updateCharacterMove, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.ConfirmCharacter, slot0.onPlaceCharacter, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, slot0._updateCharacterMove, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ConfirmCharacter, slot0.onPlaceCharacter, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0._updateCharacterMove(slot0)
	if slot0.entity.isPressing then
		return
	end

	if not slot0.entity:getMO() then
		return
	end

	if slot0._scene.character:isLock() then
		return
	end

	if slot1:getMoveState() == slot0._lastAnimState then
		return
	end

	slot0._lastAnimState = slot2
	slot0._curBlockMO = slot0:_findBlockMO()

	slot0:checkBirthday()
end

function slot0.onPlaceCharacter(slot0)
	slot0._curBlockMO = slot0:_findBlockMO()

	slot0:checkBirthday()
end

function slot0._findBlockMO(slot0)
	if slot0.__willDestroy then
		return
	end

	if slot0.goTrs then
		slot1, slot2, slot3 = transformhelper.getPos(slot0.goTrs)
		slot5 = HexMath.positionToRoundHex(Vector2(slot1, slot3), RoomBlockEnum.BlockSize)

		return RoomMapBlockModel.instance:getBlockMO(slot5.x, slot5.y)
	end
end

function slot0._onDailyRefresh(slot0)
	if slot0.__willDestroy then
		return
	end

	if not slot0.entity:getMO() then
		return
	end

	if not RoomCharacterModel.instance:isOnBirthday(slot1.id) then
		slot1:replaceIdleState()
	end
end

function slot0.onStart(slot0)
end

function slot0.onEffectRebuild(slot0)
	if not slot0.entity.effect:isHasEffectGOByKey(slot0.birthdayEffKey) then
		return
	end

	slot0:setEffGoDict(slot1:getEffectGO(slot0.birthdayEffKey))

	if slot0.tmpMeetingYear then
		slot0:playBirthdayFirework(slot0.tmpMeetingYear)

		slot0.tmpMeetingYear = nil
	end
end

function slot0.setEffGoDict(slot0, slot1)
	slot0.effGoDict = {}

	if gohelper.isNil(slot1) then
		return
	end

	for slot8 = 1, gohelper.findChild(slot1, "root").transform.childCount do
		if not string.nilorempty(tonumber(slot3:GetChild(slot8 - 1).name)) then
			slot12 = slot9.gameObject
			slot0.effGoDict[slot11] = slot12

			gohelper.setActive(slot12, false)
		end
	end
end

function slot0.checkBirthday(slot0)
	if slot0.__willDestroy then
		return
	end

	slot3 = nil

	if RoomCharacterModel.instance:isOnBirthday(slot0.entity:getMO().id) and slot0:_isSelfBirthdayBlock(slot0._curBlockMO, slot1.heroId) and HeroModel.instance:getByHeroId(slot1.id) then
		slot0:playBirthdayFirework(slot4:getMeetingYear())

		slot3 = RoomCharacterEnum.CharacterMoveState.BirthdayIdle
	end

	slot1:replaceIdleState(slot3)
end

function slot0._isSelfBirthdayBlock(slot0, slot1, slot2)
	if not slot1 or slot1:getDefineId() ~= slot1:getDefineId(true) then
		return false
	end

	return RoomConfig.instance:getSpecialBlockConfig(slot1.blockId) and slot3.heroId == slot2
end

function slot0.playBirthdayFirework(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0.effGoDict then
		slot0:initEffect()

		slot0.tmpMeetingYear = math.max(1, slot1)

		return
	end

	for slot5, slot6 in pairs(slot0.effGoDict) do
		gohelper.setActive(slot6, false)

		if slot5 == slot1 then
			gohelper.setActive(slot6, true)
		end
	end
end

function slot0.initEffect(slot0)
	if slot0.entity.effect:isHasEffectGOByKey(slot0.birthdayEffKey) then
		slot0:setEffGoDict(slot1:getEffectGO(slot0.birthdayEffKey))
	else
		slot1:addParams({
			[slot0.birthdayEffKey] = {
				res = RoomScenePreloader.RecCharacterBirthdayEffect,
				localScale = Vector3.one * uv0
			}
		})
	end

	slot1:refreshEffect()
end

function slot0.beforeDestroy(slot0)
	slot0.tmpMeetingYear = nil
	slot0.__willDestroy = true

	slot0:removeEventListeners()
end

function slot0.onDestroy(slot0)
	slot0.effGoDict = nil
end

return slot0

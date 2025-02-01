module("modules.logic.room.entity.comp.RoomCritterFollowerComp", package.seeall)

slot0 = class("RoomCritterFollowerComp", RoomBaseFollowerComp)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._followDis = 0.15
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot1)
	slot0:delaySetFollow(0.5)
end

function slot0.addPathPos(slot0, slot1)
	if slot0:getFollowPathData():getPosCount() == 1 and (slot0._followDis or 0.1) > Vector3.Distance(slot2:getFirstPos(), slot1) + slot2:getPathDistance() then
		return
	end

	uv0.super.addPathPos(slot0, slot1)
end

function slot0.onMoveByPathData(slot0, slot1)
	if slot1:getPosCount() < 1 then
		return
	end

	if slot0._followDis < slot1:getPathDistance() then
		slot4 = slot1:getPosByDistance(slot3)

		slot0.entity:setLocalPos(slot4.x, slot4.y, slot4.z)
	elseif slot2 < slot3 then
		-- Nothing
	end

	if slot0.entity.critterspine and slot0:_findCharacterEntity() and slot5.characterspine then
		slot4:setLookDir(slot5.characterspine:getLookDir())
	end
end

function slot0.onStopMove(slot0)
	slot0:_playAnimState(RoomCharacterEnum.CharacterMoveState.Idle, true)

	slot1, slot2, slot3 = transformhelper.getPos(slot0.entity.goTrs)
	slot4 = slot0:getFollowPathData()

	slot4:clear()
	slot4:addPathPos(Vector3(slot1, slot2, slot3))
end

function slot0.onStartMove(slot0)
	slot0:_playAnimState(RoomCharacterEnum.CharacterMoveState.Move, true)
end

function slot0._playAnimState(slot0, slot1, slot2)
	if slot0.entity.critterspine then
		slot3:changeMoveState(slot1)
		slot3:play(RoomCharacterHelper.getAnimStateName(slot1, slot0.entity.id), slot2, true)
	end
end

function slot0._findCharacterEntity(slot0)
	if not slot0.entity:getMO() then
		return
	end

	slot2 = RoomCharacterModel.instance:getCharacterMOById(slot1.heroId)

	if GameSceneMgr.instance:getCurScene() and slot2 then
		return slot3.charactermgr:getCharacterEntity(slot2.id, SceneTag.RoomCharacter)
	end
end

function slot0.delaySetFollow(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._delaySetFollow, slot0)
	TaskDispatcher.runDelay(slot0._delaySetFollow, slot0, slot1 or 0.5)
end

function slot0._delaySetFollow(slot0)
	if not slot0.entity:getMO() or not RoomCameraController.instance:getRoomScene() then
		return
	end

	if slot0:_findCharacterEntity() then
		slot0:followCharacter(slot3)

		return
	end
end

function slot0.followCharacter(slot0, slot1)
	slot0:setFollowPath(slot1.followPathComp)

	if slot0:getFollowPathData():getPosCount() <= 1 then
		slot3, slot4, slot5 = transformhelper.getPos(slot0.entity.goTrs)

		slot2:addPathPos(Vector3(slot3, slot4, slot5))

		slot6, slot7, slot8 = transformhelper.getPos(slot1.goTrs)

		slot2:addPathPos(Vector3(slot6, slot7, slot8))
	end

	slot0:onMoveByPathData(slot2)
end

function slot0.beforeDestroy(slot0)
	uv0.super.beforeDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delaySetFollow, slot0)
end

return slot0

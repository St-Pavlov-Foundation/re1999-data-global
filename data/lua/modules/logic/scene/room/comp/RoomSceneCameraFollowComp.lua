module("modules.logic.scene.room.comp.RoomSceneCameraFollowComp", package.seeall)

slot0 = class("RoomSceneCameraFollowComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._initialized = true
	slot0._offsetY = 0
end

function slot0.onSceneStart(slot0, slot1, slot2)
end

function slot0.onSceneClose(slot0)
	slot0._followTarget = nil
	slot0._initialized = false

	slot0:_stopFollowTask()
end

function slot0._startFollowTask(slot0)
	if not slot0._isRunningFollowTask then
		slot0._isRunningFollowTask = true

		TaskDispatcher.runRepeat(slot0._onUpdateFollow, slot0, 0)
	end
end

function slot0._stopFollowTask(slot0)
	if slot0._isRunningFollowTask then
		slot0._isRunningFollowTask = false

		TaskDispatcher.cancelTask(slot0._onUpdateFollow, slot0)
	end
end

function slot0._onUpdateFollow(slot0)
	if not slot0._followTarget or slot0._followTarget:isWillDestory() then
		slot0._followTarget = nil

		slot0:_stopFollowTask()

		return
	end

	if slot0._scene and slot0._scene.camera and not slot0._isPass then
		slot1, slot2, slot3 = slot0._followTarget:getPositionXYZ()

		if slot0._isFirstPerson then
			slot5, slot6, slot7 = slot0._followTarget:getRotateXYZ()
			slot0._scene.camera:getCameraParam().rotate = RoomRotateHelper.getMod(slot6, 360) * Mathf.Deg2Rad
		end

		slot0._offsetY = slot2

		slot0._scene.camera:moveTo(slot1, slot3)
	end
end

function slot0.getCameraOffsetY(slot0)
	if slot0._followTarget and not slot0._followTarget:isWillDestory() then
		return slot0._offsetY or 0
	end

	return 0
end

function slot0.removeFollowTarget(slot0, slot1)
	if slot1 and slot1 == slot0._followTarget then
		slot0._followTarget = nil

		slot0:_stopFollowTask()
	end
end

function slot0.setIsPass(slot0, slot1, slot2)
	slot0._isPass = slot1 == true

	if slot0._isPass and slot2 ~= nil then
		slot0._offsetY = tonumber(slot2)
	end
end

function slot0.getIsPass(slot0)
	return slot0._isPass
end

function slot0.isFollowing(slot0)
	return slot0._isRunningFollowTask
end

function slot0.isLockRotate(slot0)
	if slot0._isRunningFollowTask and slot0._isFirstPerson then
		return true
	end

	return false
end

function slot0.setFollowTarget(slot0, slot1, slot2)
	slot0._isFirstPerson = slot2 == true

	if slot0._followTarget == slot1 then
		return
	end

	if slot0._followTarget then
		slot0._followTarget:setCameraFollow(nil)
	end

	slot0._followTarget = slot1

	if slot1 and not slot1:isWillDestory() then
		slot1:setCameraFollow(slot0)
		slot0:_startFollowTask()
		slot0:setIsPass(false)
	else
		slot0:_stopFollowTask()
	end
end

return slot0

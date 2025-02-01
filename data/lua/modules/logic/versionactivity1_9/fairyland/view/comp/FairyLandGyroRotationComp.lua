module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandGyroRotationComp", package.seeall)

slot0 = class("FairyLandGyroRotationComp")
slot1 = UnityEngine.Input
slot2 = UnityEngine.Time

function slot0.init(slot0, slot1)
	slot0.autorotateToLandscapeLeft = UnityEngine.Screen.autorotateToLandscapeLeft
	slot0.autorotateToLandscapeRight = UnityEngine.Screen.autorotateToLandscapeRight
	UnityEngine.Screen.autorotateToLandscapeLeft = false
	UnityEngine.Screen.autorotateToLandscapeRight = false
	slot0.rotateCallback = slot1.callback
	slot0.rotateCallbackObj = slot1.callbackObj
	slot0.isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()
	slot0._aniGoList = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.goList) do
		table.insert(slot0._aniGoList, {
			go = slot7,
			transform = slot7.transform
		})
	end

	if not slot0._isRunning then
		slot0._isRunning = true

		TaskDispatcher.runRepeat(slot0._tick, slot0, 0)
	end

	if slot0.isMobilePlayer then
		slot0.gyro = UnityEngine.Input.gyro
		slot0.gyroEnabled = slot0.gyro.enabled
		slot0.gyro.enabled = true
	end

	slot0.tempQuaternion = Quaternion.New()
	slot0.tempQuaternion2 = Quaternion.Euler(90, 0, 0)
end

function slot0.checkInDrag(slot0)
	return slot0.rotateCallbackObj.inDrag
end

function slot0._tick(slot0)
	if slot0.isMobilePlayer and not slot0:checkInDrag() then
		for slot4, slot5 in ipairs(slot0._aniGoList) do
			transformhelper.setLocalRotationLerp(slot5.transform, 0, 0, slot0:convertRotation(slot0.gyro.attitude):ToEulerAngles().z, uv0.deltaTime * 2)
		end
	end

	slot0:checkFinish()
end

function slot0.convertRotation(slot0, slot1)
	slot0.tempQuaternion:Set(-slot1.x, -slot1.y, slot1.z, slot1.w)

	return slot0.tempQuaternion2 * slot0.tempQuaternion
end

function slot0.checkFinish(slot0)
	if slot0.rotateCallback then
		slot0.rotateCallback(slot0.rotateCallbackObj)
	end
end

function slot0.closeGyro(slot0)
	if slot0._isRunning then
		slot0._isRunning = false

		TaskDispatcher.cancelTask(slot0._tick, slot0)
	end

	if slot0.autorotateToLandscapeLeft ~= nil then
		UnityEngine.Screen.autorotateToLandscapeLeft = slot0.autorotateToLandscapeLeft
	end

	if slot0.autorotateToLandscapeRight ~= nil then
		UnityEngine.Screen.autorotateToLandscapeRight = slot0.autorotateToLandscapeRight
	end

	if slot0.gyro then
		slot0.gyro.enabled = slot0.gyroEnabled
	end
end

return slot0

module("modules.logic.scene.main.comp.MainSceneGyroComp", package.seeall)

slot0 = class("MainSceneGyroComp", BaseSceneComp)
slot1 = UnityEngine.Input
slot2 = UnityEngine.Time
slot3 = {
	{
		deltaScale = 2.2,
		angle_x = 1.5,
		lerpScale = 14,
		angle_y = 5
	}
}

function slot0.onScenePrepared(slot0, slot1, slot2)
	if not slot0._isRunning then
		slot0._isRunning = true

		TaskDispatcher.runRepeat(slot0._tick, slot0, 0)
		CameraMgr.instance:setUnitCameraSeparate()
	end

	slot0._aniGoList = {}
	slot3 = uv0[1]
	slot4 = CameraMgr.instance:getMainCameraTrs()
	slot5 = slot4.localEulerAngles
	slot3.maxX = slot5.x + slot3.angle_x
	slot3.minX = slot5.x - slot3.angle_x
	slot3.maxY = slot5.y + slot3.angle_y
	slot3.minY = slot5.y - slot3.angle_y

	table.insert(slot0._aniGoList, {
		transform = slot4,
		config = slot3,
		initAngles = slot5
	})

	slot7, slot8, slot9 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)
	slot0._acceleration = Vector3.New(slot7, slot8, slot9)
	slot0._curAcceleration = Vector3.New(slot7, slot8, slot9)
	slot0._deltaPos = Vector3.zero
	slot0._tempAngle = Vector3.zero
	slot0._gyroOffset = Vector4.New(0, 0, 0.04)
	slot0._srcQuaternion = Quaternion.New()
	slot0._targetQuaternion = Quaternion.New()
	slot0._gyroOffsetID = UnityEngine.Shader.PropertyToID("_GyroOffset")
end

function slot0._tick(slot0)
	if not slot0._aniGoList then
		return
	end

	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	slot1, slot2, slot3 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)
	slot0._gyroOffset.y = (slot0._gyroOffset.y + slot2) * 0.5
	slot0._gyroOffset.x = (slot0._gyroOffset.x + slot1) * 0.5

	UnityEngine.Shader.SetGlobalVector(slot0._gyroOffsetID, slot0._gyroOffset)
	slot0._curAcceleration:Set(slot1, slot2, slot3)

	slot4 = slot0._deltaPos
	slot5, slot6, slot7 = nil

	for slot11, slot12 in ipairs(slot0._aniGoList) do
		slot6 = slot12.config
		slot4.y = slot0._curAcceleration.x - slot0._acceleration.x
		slot4.x = slot0._curAcceleration.y - slot0._acceleration.y
		slot7.x = slot6.maxX < slot0:calcAngle(slot12.initAngles, slot4, slot6.deltaScale).x and slot6.maxX or slot7.x
		slot7.x = slot7.x < slot6.minX and slot6.minX or slot7.x
		slot7.y = slot6.maxY < slot7.y and slot6.maxY or slot7.y
		slot7.y = slot7.y < slot6.minY and slot6.minY or slot7.y

		transformhelper.setLocalRotationLerp(slot12.transform, slot7.x, slot7.y, slot7.z, uv0.deltaTime * slot6.lerpScale)
	end
end

function slot0.calcAngle(slot0, slot1, slot2, slot3)
	slot4 = slot0._tempAngle
	slot4.x = slot1.x + slot2.x * slot3
	slot4.y = slot1.y + slot2.y * slot3
	slot4.z = slot1.z + slot2.z * slot3

	return slot4
end

function slot0.QuaternionLerp(slot0, slot1, slot2, slot3)
	slot3 = Mathf.Clamp(slot3, 0, 1)

	if Quaternion.Dot(slot1, slot2) < 0 then
		slot1.x = slot1.x + slot3 * (-slot2.x - slot1.x)
		slot1.y = slot1.y + slot3 * (-slot2.y - slot1.y)
		slot1.z = slot1.z + slot3 * (-slot2.z - slot1.z)
		slot1.w = slot1.w + slot3 * (-slot2.w - slot1.w)
	else
		slot1.x = slot1.x + (slot2.x - slot1.x) * slot3
		slot1.y = slot1.y + (slot2.y - slot1.y) * slot3
		slot1.z = slot1.z + (slot2.z - slot1.z) * slot3
		slot1.w = slot1.w + (slot2.w - slot1.w) * slot3
	end

	slot1:SetNormalize()

	return slot1
end

function slot0.onSceneClose(slot0)
	if slot0._isRunning then
		slot0._isRunning = false

		TaskDispatcher.cancelTask(slot0._tick, slot0)
		CameraMgr.instance:setUnitCameraCombine()
	end
end

return slot0

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandGyroComp", package.seeall)

slot0 = class("FairyLandGyroComp")
slot1 = UnityEngine.Input
slot2 = UnityEngine.Time

function slot0.init(slot0, slot1)
	slot0.shakeCallback = slot1.callback
	slot0.shakeCallbackObj = slot1.callbackObj
	slot0.shakeGO = slot1.go
	slot0.isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()
	slot0._aniGoList = {}
	slot4 = slot0.shakeGO.transform

	table.insert(slot0._aniGoList, {
		transform = slot4,
		config = {
			posLimit = slot1.posLimit,
			deltaPos = 5,
			lerpPos = 10
		},
		initPos = slot4.localPosition
	})

	slot7, slot8, slot9 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)
	slot0._acceleration = Vector3.New(slot7, slot8, slot9)
	slot0._curAcceleration = Vector3.New(slot7, slot8, slot9)
	slot0._offsetPos = Vector3.zero
	slot0._tempPos = Vector3.zero

	if not slot0._isRunning then
		slot0._isRunning = true

		LateUpdateBeat:Add(slot0._tick, slot0)
	end
end

function slot0.checkInDrag(slot0)
	return slot0.shakeCallbackObj.inDrag
end

function slot0._tick(slot0)
	if slot0.isMobilePlayer and not slot0:checkInDrag() then
		slot1, slot2, slot3 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

		slot0._curAcceleration:Set(slot1, slot2, slot3)

		slot4 = slot0._offsetPos
		slot5, slot6, slot7, slot8, slot9 = nil

		if slot0._aniGoList then
			for slot13, slot14 in ipairs(slot0._aniGoList) do
				slot5 = slot14.transform
				slot6 = slot14.config
				slot4.x = slot0._curAcceleration.x - slot0._acceleration.x
				slot4.y = slot0._curAcceleration.y - slot0._acceleration.y
				slot8, slot9 = transformhelper.getLocalPos(slot5)
				slot7 = slot0:clampPos(slot0:calcPos(slot14.initPos, slot4, slot6.deltaPos), slot14.initPos, slot6.posLimit)

				transformhelper.setLocalLerp(slot5, slot7.x, slot7.y, slot7.z, uv0.deltaTime * slot6.lerpPos)
			end
		end
	end

	slot0:doShake()
end

function slot0.clampPos(slot0, slot1, slot2, slot3)
	if Vector3.Distance(slot2, slot1) < slot3 then
		return slot1
	end

	return slot2 + (slot1 - slot2).normalized * slot3
end

function slot0.calcPos(slot0, slot1, slot2, slot3)
	slot4 = slot0._tempPos
	slot4.x = slot1.x + slot2.x * slot3
	slot4.y = slot1.y + slot2.y * slot3

	return slot4
end

function slot0.doShake(slot0)
	if slot0.shakeCallback then
		slot0.shakeCallback(slot0.shakeCallbackObj)
	end
end

function slot0.closeGyro(slot0)
	if slot0._isRunning then
		slot0._isRunning = false

		LateUpdateBeat:Remove(slot0._tick, slot0)
	end
end

return slot0

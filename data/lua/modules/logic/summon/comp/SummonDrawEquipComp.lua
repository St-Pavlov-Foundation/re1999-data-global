module("modules.logic.summon.comp.SummonDrawEquipComp", package.seeall)

slot0 = class("SummonDrawEquipComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._rootGO = gohelper.findChild(slot1, "anim")
	slot0._goLed = gohelper.findChild(slot1, "anim/StandStill/Obj-Plant/erjiguan")
	slot0._tfLed = slot0._goLed.transform
	slot0._animLed = slot0._goLed:GetComponent(typeof(UnityEngine.Animator))
	slot0._goLedOne = gohelper.findChild(slot0._goLed, "diode_b")
	slot0._goLedTen = gohelper.findChild(slot0._goLed, "diode_a")
	slot0._fadingFactor = 1
	slot0._toZeroSpeed = 0.007
	slot0._targetLedPosY = -1.51
	slot0._finished = true
	slot0._curProgress = 0

	slot0:onCreate()
end

function slot0.onCreate(slot0)
end

function slot0.onUpdate(slot0)
	if slot0._finished then
		return
	end

	if slot0._updateSpeed ~= 0 then
		slot0._curProgress = slot0._curProgress + slot0._updateSpeed

		if slot0._curProgress < 0 then
			slot0._curProgress = 0
		elseif slot0._curProgress > 1 then
			slot0._curProgress = 1
		end

		slot0:updateForEffect()
		slot0:updateForSpeedFading()
		slot0:updateForFinishCheck()
	end
end

function slot0.applySpeed(slot0)
	slot1 = -slot0._deltaDistance * 0.003
	slot2 = math.abs(slot1)

	return slot2 > 0.1 and slot1 / slot2 * slot4 or slot1
end

function slot0.updateForEffect(slot0)
	if slot0._tfLed and slot0._ledPosY then
		slot3, slot4, slot5 = transformhelper.getLocalPos(slot0._rootGO.transform)

		transformhelper.setLocalPos(slot0._tfLed, slot3, slot0._ledPosY + (slot0._targetLedPosY - slot0._ledPosY) * slot0._curProgress, slot5)
	end
end

function slot0.updateForSpeedFading(slot0)
	if slot0._updateSpeed < slot0._toZeroSpeed then
		slot0._updateSpeed = 0
	else
		slot0._updateSpeed = slot0._updateSpeed * slot0._fadingFactor
	end
end

function slot0.updateForFinishCheck(slot0)
	if slot0._curProgress >= 1 then
		slot0:_completeDraw()
	end
end

function slot0.resetDraw(slot0, slot1, slot2)
	slot0._rare = slot1
	slot0._curProgress = 0
	slot0._updateSpeed = 0
	slot0._deltaDistance = 0
	slot0._finished = false
	slot0._isTen = slot2

	slot0:updateForEffect()
	slot0:resetLedFloat()
end

function slot0.skip(slot0)
	slot0._curProgress = 0
	slot0._updateSpeed = 0
	slot0._deltaDistance = 0
	slot0._finished = false
end

function slot0.setEffect(slot0, slot1)
	slot0._curProgress = math.min(math.max(1 - slot1, 0), 1)

	slot0:updateForEffect()
end

function slot0.resetLedFloat(slot0)
	gohelper.setActive(slot0._isTen and slot0._goLedTen or slot0._goLedOne, false)
	gohelper.setActive(slot0._isTen and slot0._goLedOne or slot0._goLedTen, false)

	if not gohelper.isNil(slot0._animLed) then
		slot0._animLed.enabled = true
	end

	if not gohelper.isNil(slot0._tfLed) then
		slot3, slot0._ledPosY = transformhelper.getLocalPos(slot0._tfLed)
	end
end

function slot0.startDrag(slot0)
	if not gohelper.isNil(slot0._tfLed) then
		slot1, slot0._ledPosY = transformhelper.getLocalPos(slot0._tfLed)
	end

	if not gohelper.isNil(slot0._animLed) then
		slot0._animLed.enabled = false
	end

	slot0._fadingFactor = 0.1
end

function slot0.updateDistance(slot0, slot1)
	slot0._deltaDistance = slot1
	slot0._updateSpeed = slot0:applySpeed()
end

function slot0.endDrag(slot0)
	slot0._updateSpeed = 0.1
	slot0._fadingFactor = 1.1
end

function slot0._completeDraw(slot0)
	if slot0._finished then
		return
	end

	slot0._finished = true
	slot0._updateSpeed = 0

	SummonController.instance:dispatchEvent(SummonEvent.onSummonDraw)
end

function slot0.onDestroy(slot0)
end

return slot0

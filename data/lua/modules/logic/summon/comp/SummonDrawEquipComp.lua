-- chunkname: @modules/logic/summon/comp/SummonDrawEquipComp.lua

module("modules.logic.summon.comp.SummonDrawEquipComp", package.seeall)

local SummonDrawEquipComp = class("SummonDrawEquipComp", LuaCompBase)

function SummonDrawEquipComp:ctor(sceneGO)
	self._rootGO = gohelper.findChild(sceneGO, "anim")
	self._goLed = gohelper.findChild(sceneGO, "anim/StandStill/Obj-Plant/erjiguan")
	self._tfLed = self._goLed.transform
	self._animLed = self._goLed:GetComponent(typeof(UnityEngine.Animator))
	self._goLedOne = gohelper.findChild(self._goLed, "diode_b")
	self._goLedTen = gohelper.findChild(self._goLed, "diode_a")
	self._fadingFactor = 1
	self._toZeroSpeed = 0.007
	self._targetLedPosY = -1.51
	self._finished = true
	self._curProgress = 0

	self:onCreate()
end

function SummonDrawEquipComp:onCreate()
	return
end

function SummonDrawEquipComp:onUpdate()
	if self._finished then
		return
	end

	if self._updateSpeed ~= 0 then
		self._curProgress = self._curProgress + self._updateSpeed

		if self._curProgress < 0 then
			self._curProgress = 0
		elseif self._curProgress > 1 then
			self._curProgress = 1
		end

		self:updateForEffect()
		self:updateForSpeedFading()
		self:updateForFinishCheck()
	end
end

function SummonDrawEquipComp:applySpeed()
	local deltaValue = -self._deltaDistance * 0.003
	local absDist = math.abs(deltaValue)
	local sign = deltaValue / absDist
	local constMaxSpd = 0.1
	local speed = constMaxSpd < absDist and sign * constMaxSpd or deltaValue

	return speed
end

function SummonDrawEquipComp:updateForEffect()
	local progress = self._curProgress

	if self._tfLed and self._ledPosY then
		local targetPosY = self._ledPosY + (self._targetLedPosY - self._ledPosY) * progress
		local positionX, positionY, positionZ = transformhelper.getLocalPos(self._rootGO.transform)

		transformhelper.setLocalPos(self._tfLed, positionX, targetPosY, positionZ)
	end
end

function SummonDrawEquipComp:updateForSpeedFading()
	if self._updateSpeed < self._toZeroSpeed then
		self._updateSpeed = 0
	else
		self._updateSpeed = self._updateSpeed * self._fadingFactor
	end
end

function SummonDrawEquipComp:updateForFinishCheck()
	if self._curProgress >= 1 then
		self:_completeDraw()
	end
end

function SummonDrawEquipComp:resetDraw(rare, isTen)
	self._rare = rare
	self._curProgress = 0
	self._updateSpeed = 0
	self._deltaDistance = 0
	self._finished = false
	self._isTen = isTen

	self:updateForEffect()
	self:resetLedFloat()
end

function SummonDrawEquipComp:skip()
	self._curProgress = 0
	self._updateSpeed = 0
	self._deltaDistance = 0
	self._finished = false
end

function SummonDrawEquipComp:setEffect(val)
	self._curProgress = math.min(math.max(1 - val, 0), 1)

	self:updateForEffect()
end

function SummonDrawEquipComp:resetLedFloat()
	local ledCtrlGo = self._isTen and self._goLedTen or self._goLedOne
	local ledOtherGo = self._isTen and self._goLedOne or self._goLedTen

	gohelper.setActive(ledCtrlGo, false)
	gohelper.setActive(ledOtherGo, false)

	if not gohelper.isNil(self._animLed) then
		self._animLed.enabled = true
	end

	if not gohelper.isNil(self._tfLed) then
		local _, positionY = transformhelper.getLocalPos(self._tfLed)

		self._ledPosY = positionY
	end
end

function SummonDrawEquipComp:startDrag()
	if not gohelper.isNil(self._tfLed) then
		local _, positionY = transformhelper.getLocalPos(self._tfLed)

		self._ledPosY = positionY
	end

	if not gohelper.isNil(self._animLed) then
		self._animLed.enabled = false
	end

	self._fadingFactor = 0.1
end

function SummonDrawEquipComp:updateDistance(deltaDistance)
	self._deltaDistance = deltaDistance
	self._updateSpeed = self:applySpeed()
end

function SummonDrawEquipComp:endDrag()
	self._updateSpeed = 0.1
	self._fadingFactor = 1.1
end

function SummonDrawEquipComp:_completeDraw()
	if self._finished then
		return
	end

	self._finished = true
	self._updateSpeed = 0

	SummonController.instance:dispatchEvent(SummonEvent.onSummonDraw)
end

function SummonDrawEquipComp:onDestroy()
	return
end

return SummonDrawEquipComp

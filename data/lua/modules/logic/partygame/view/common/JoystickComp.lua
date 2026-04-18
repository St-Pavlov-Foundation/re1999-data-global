-- chunkname: @modules/logic/partygame/view/common/JoystickComp.lua

module("modules.logic.partygame.view.common.JoystickComp", package.seeall)

local JoystickComp = class("JoystickComp", LuaCompBase)

function JoystickComp:init(go)
	self.go = go
	self._joystickWrapCs = go:GetComponent(typeof(ZProj.JoystickWrap))
	self._joystickGo = gohelper.findChild(go, "#go_joystick")
	self._goeffectdir = gohelper.findChild(go, "vx_control")
	self._transimage = gohelper.findChild(go, "image").transform
	self._transeffectdir = self._goeffectdir.transform
	self._goeffecthandle = gohelper.findChild(go, "handle/vx_handle_light")
	self._game = PartyGameController.instance:getCurPartyGame()
	self._lastIndex = nil
	self._lastLengthIndex = nil

	gohelper.setActive(self._goeffectdir, false)
	gohelper.setActive(self._goeffecthandle, false)
	self:onInitView()
end

function JoystickComp:onInitView()
	self._joystickWrapCs:SetInputType(1)
	recthelper.setSize(self.go.transform, 800, 900)
end

function JoystickComp:addEventListeners()
	self._joystickWrapCs:AddOnValueChanged(self._onValueChange, self)
	self._joystickWrapCs:AddPointerDownCallBack(self._onPointDown, self)
	self._joystickWrapCs:AddPointerUpCallBack(self._onPointUp, self)
end

function JoystickComp:removeEventListeners()
	self._joystickWrapCs:RemovePointerDownCallBack()
	self._joystickWrapCs:RemovePointerUpCallBack()
	self._joystickWrapCs:RemoveOnValueChanged()
end

function JoystickComp:_onPointDown()
	gohelper.setActive(self._goeffecthandle, true)
end

function JoystickComp:_onPointUp()
	gohelper.setActive(self._goeffectdir, false)
	gohelper.setActive(self._goeffecthandle, false)
end

function JoystickComp:_onValueChange(x, y, index)
	gohelper.setActive(self._goeffectdir, index >= 0)

	if index >= 0 then
		local angleX, angleY, angleZ = transformhelper.getEulerAngles(self._transimage)

		transformhelper.setEulerAngles(self._transeffectdir, angleX, angleY, angleZ)
	end

	self:onValueChange(x, y, index)
end

function JoystickComp:onValueChange(x, y, index)
	if not self._game:isCanControl() then
		return
	end

	local lengthIndex = index == -1 and 0 or 1

	index = index == -1 and 0 or index

	if self._lastIndex == nil or self._lastIndex ~= index or self._lastLengthIndex == nil or self._lastLengthIndex ~= lengthIndex then
		PartyGameEnum.CommandUtil.CreateJoystickCommand(index, lengthIndex)

		self._lastIndex = index
		self._lastLengthIndex = lengthIndex
	end
end

function JoystickComp:onDestroy()
	self._lastIndex = nil
end

return JoystickComp

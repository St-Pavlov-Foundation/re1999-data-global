module("projbooter.gamepad.define.GamepadXBoxKey", package.seeall)

local var_0_0 = _M
local var_0_1 = UnityEngine.KeyCode

var_0_0.AxisKeys = {
	XAxis = GamepadEnum.KeyCode.LeftStickHorizontal,
	YAxis = GamepadEnum.KeyCode.LeftStickVertical,
	["5thAxis"] = GamepadEnum.KeyCode.RightStickHorizontal,
	["4thAxis"] = GamepadEnum.KeyCode.RightStickVertical
}
var_0_0.JoystickKeys = {
	[var_0_1.JoystickButton0] = GamepadEnum.KeyCode.A,
	[var_0_1.JoystickButton1] = GamepadEnum.KeyCode.B,
	[var_0_1.JoystickButton4] = GamepadEnum.KeyCode.LB,
	[var_0_1.JoystickButton5] = GamepadEnum.KeyCode.RB
}

return var_0_0

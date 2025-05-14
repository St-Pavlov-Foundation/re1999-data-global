module("modules.logic.gamepad.GamepadController", package.seeall)

local var_0_0 = class("GamepadController", BaseController)

function var_0_0.onInit(arg_1_0)
	if GamepadBooter ~= nil then
		arg_1_0:setUp()
	end
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.isOpen(arg_5_0)
	return arg_5_0._isOpen
end

function var_0_0.isDownA(arg_6_0)
	return arg_6_0._down
end

function var_0_0.getMousePosition(arg_7_0)
	if arg_7_0:isOpen() then
		return arg_7_0:getScreenPos()
	else
		return UnityEngine.Input.mousePosition
	end
end

function var_0_0.getScreenPos(arg_8_0)
	arg_8_0:_updateScreenPos()

	return Vector2.New(arg_8_0._screenPosV2.x, arg_8_0._screenPosV2.y)
end

function var_0_0.setPointerAnchor(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._pointer:setAnchor(arg_9_1, arg_9_2)
	arg_9_0:_updateScreenPos()
end

function var_0_0.setUp(arg_10_0)
	arg_10_0:_checkGamepadModel()

	if arg_10_0._isOpen == false then
		return
	end

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._useKeyType.JoystickKeys) do
		table.insert(var_10_0, iter_10_0)
	end

	local var_10_1 = {}

	for iter_10_2, iter_10_3 in pairs(arg_10_0._useKeyType.AxisKeys) do
		table.insert(var_10_1, iter_10_2)
	end

	arg_10_0._mgrInst = ZProj.GamepadManager.Instance
	arg_10_0._eventMgrInst = ZProj.GamepadEvent.Instance
	arg_10_0._eventMgr = ZProj.GamepadEvent

	arg_10_0._eventMgrInst:ClearLuaListener()
	arg_10_0._mgrInst:SetKeyListLua(var_10_0, var_10_1)

	arg_10_0._pointer = GamepadPointer.New()
	arg_10_0._screenPosV2 = Vector2.New()

	arg_10_0._eventMgrInst:AddLuaLisenter(arg_10_0._eventMgr.DownKey, arg_10_0._onDownKey, arg_10_0)
	arg_10_0._eventMgrInst:AddLuaLisenter(arg_10_0._eventMgr.UpKey, arg_10_0._onUpKey, arg_10_0)
	arg_10_0._eventMgrInst:AddLuaLisenter(arg_10_0._eventMgr.ClickKey, arg_10_0._onClickKey, arg_10_0)
	arg_10_0._eventMgrInst:AddLuaLisenter(arg_10_0._eventMgr.AxisChange, arg_10_0._onAxisChange, arg_10_0)

	arg_10_0._axisHandleFunc = {
		[GamepadEnum.KeyCode.LeftStickHorizontal] = arg_10_0._onLeftStickHorizontal,
		[GamepadEnum.KeyCode.LeftStickVertical] = arg_10_0._onLeftStickVertical,
		[GamepadEnum.KeyCode.RightStickHorizontal] = arg_10_0._onRightStickHorizontal,
		[GamepadEnum.KeyCode.RightStickVertical] = arg_10_0._onRightStickVertical
	}
	arg_10_0._buttonHandleFunc = {
		[GamepadEnum.KeyCode.A] = {
			arg_10_0._onDownA,
			arg_10_0._onUpA
		},
		[GamepadEnum.KeyCode.B] = {
			arg_10_0._onDownB,
			arg_10_0._onUpB
		},
		[GamepadEnum.KeyCode.LB] = {},
		[GamepadEnum.KeyCode.RB] = {}
	}
end

function var_0_0._checkGamepadModel(arg_11_0)
	arg_11_0._isOpen = SDKNativeUtil.isGamePad()

	if arg_11_0._isOpen then
		local var_11_0 = UnityEngine.Input.GetJoystickNames()
		local var_11_1 = false

		if var_11_0 and var_11_0.Length > 0 then
			for iter_11_0 = 0, var_11_0.Length - 1 do
				if var_11_1 then
					break
				end

				local var_11_2 = var_11_0[iter_11_0]

				for iter_11_1, iter_11_2 in pairs(GamepadKeyMapEnum.KeyMap) do
					if string.find(var_11_2, iter_11_1) then
						var_11_1 = true

						if BootNativeUtil.isAndroid() then
							arg_11_0._useKeyType = iter_11_2[2]

							break
						end

						if BootNativeUtil.isWindows() or SLFramework.FrameworkSettings.IsEditor then
							arg_11_0._useKeyType = iter_11_2[1]
						end

						break
					end
				end
			end
		end

		if var_11_1 == false then
			if BootNativeUtil.isAndroid() then
				arg_11_0._useKeyType = GamepadKeyMapEnum.KeyMap.XIAOM[2]
			elseif BootNativeUtil.isWindows() or SLFramework.FrameworkSettings.IsEditor then
				arg_11_0._useKeyType = GamepadKeyMapEnum.KeyMap.XIAOM[1]
			end
		end
	end
end

function var_0_0._onDownKey(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._useKeyType.JoystickKeys[arg_12_1]
	local var_12_1 = arg_12_0._buttonHandleFunc[var_12_0][1]

	if var_12_1 then
		var_12_1(arg_12_0)
	end

	arg_12_0:dispatchEvent(GamepadEvent.KeyDown, var_12_0)
end

function var_0_0._onUpKey(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._useKeyType.JoystickKeys[arg_13_1]
	local var_13_1 = arg_13_0._buttonHandleFunc[var_13_0][2]

	if var_13_1 then
		var_13_1(arg_13_0)
	end

	arg_13_0:dispatchEvent(GamepadEvent.KeyUp, var_13_0)
end

function var_0_0._updateScreenPos(arg_14_0)
	local var_14_0, var_14_1 = arg_14_0._pointer:getScreenPos()

	if var_14_0 and var_14_1 then
		arg_14_0._screenPosV2.x = var_14_0
		arg_14_0._screenPosV2.y = var_14_1
	end
end

function var_0_0._setUIClick(arg_15_0, arg_15_1)
	arg_15_0._mgrInst:SendClickEvent(arg_15_0._screenPosV2, arg_15_1)
end

function var_0_0._sendDragEvent(arg_16_0)
	arg_16_0:_updateScreenPos()
	arg_16_0._mgrInst:SendDragEvent(arg_16_0._screenPosV2)
end

function var_0_0._onClickKey(arg_17_0, arg_17_1)
	return
end

function var_0_0._onAxisChange(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._useKeyType.AxisKeys[arg_18_1]
	local var_18_1 = arg_18_0._axisHandleFunc[var_18_0]

	if var_18_1 then
		var_18_1(arg_18_0, arg_18_2)
	end

	arg_18_0:dispatchEvent(GamepadEvent.AxisChange, var_18_0, arg_18_2)
end

function var_0_0._onDownA(arg_19_0)
	arg_19_0._down = true

	arg_19_0:_updateScreenPos()
	arg_19_0:_setUIClick(true)
	GameGlobalMgr.instance:playTouchEffect(arg_19_0._screenPosV2)

	local var_19_0 = TouchEventMgrHepler.getAllMgrs()

	arg_19_0:_clearDownActiveTouchMgrDic()

	arg_19_0._downActiveTouchMgrDic = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if not gohelper.isNil(iter_19_1) and iter_19_1.isActiveAndEnabled then
			iter_19_1:TriggerOnTouchDown(arg_19_0._screenPosV2)

			arg_19_0._downActiveTouchMgrDic[iter_19_1] = true
		end
	end
end

function var_0_0._onUpA(arg_20_0)
	arg_20_0._down = false

	arg_20_0:_updateScreenPos()
	arg_20_0:_setUIClick(false)

	if arg_20_0._downActiveTouchMgrDic then
		local var_20_0 = TouchEventMgrHepler.getAllMgrs()

		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			if not gohelper.isNil(iter_20_1) and iter_20_1.isActiveAndEnabled and arg_20_0._downActiveTouchMgrDic[iter_20_1] then
				iter_20_1:TriggerOnClick(arg_20_0._screenPosV2)
				iter_20_1:TriggerOnTouchUp(arg_20_0._screenPosV2)
			end
		end
	end

	arg_20_0:_clearDownActiveTouchMgrDic()
end

function var_0_0._clearDownActiveTouchMgrDic(arg_21_0)
	if arg_21_0._downActiveTouchMgrDic then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._downActiveTouchMgrDic) do
			arg_21_0._downActiveTouchMgrDic[iter_21_0] = nil
		end

		arg_21_0._downActiveTouchMgrDic = nil
	end
end

function var_0_0._onDownB(arg_22_0)
	return
end

function var_0_0._onUpB(arg_23_0)
	if not arg_23_0._down then
		NavigateMgr.instance:onEscapeBtnClick()
	end
end

function var_0_0._onLeftStickHorizontal(arg_24_0, arg_24_1)
	local var_24_0 = Time.deltaTime / 0.016

	arg_24_0._pointer:updateX(var_24_0 * arg_24_1)

	if arg_24_0._down then
		arg_24_0:_sendDragEvent()
	end
end

function var_0_0._onLeftStickVertical(arg_25_0, arg_25_1)
	local var_25_0 = Time.deltaTime / 0.016

	arg_25_0._pointer:updateY(-1 * var_25_0 * arg_25_1)

	if arg_25_0._down then
		arg_25_0:_sendDragEvent()
	end
end

function var_0_0._onRightStickHorizontal(arg_26_0, arg_26_1)
	return
end

function var_0_0._onRightStickVertical(arg_27_0, arg_27_1)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0

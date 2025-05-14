module("projbooter.hotupdate.GamepadBooter", package.seeall)

local var_0_0 = class("GamepadBooter")

function var_0_0.init(arg_1_0)
	addGlobalModule("projbooter.gamepad.define.GamepadEnum", "GamepadEnum")
	addGlobalModule("projbooter.gamepad.define.GamepadEvent", "GamepadEvent")
	addGlobalModule("projbooter.gamepad.define.GamepadXBoxKey_Android", "GamepadXBoxKey_Android")
	addGlobalModule("projbooter.gamepad.define.GamepadXBoxKey", "GamepadXBoxKey")
	addGlobalModule("projbooter.gamepad.define.GamepadKeyMapEnum", "GamepadKeyMapEnum")
end

function var_0_0.setBootMsgBoxClick(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.onClickRightCallBack = arg_2_1
	arg_2_0.onClickRightCallBackObj = arg_2_2
	arg_2_0.onClickLeftCallBack = arg_2_3
	arg_2_0.onClickLeftCallBackObj = arg_2_4

	arg_2_0:_checkGamepadModel()

	if arg_2_0._isOpen == false then
		return
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0._useKeyType.JoystickKeys) do
		table.insert(var_2_0, iter_2_0)
	end

	local var_2_1 = {}

	for iter_2_2, iter_2_3 in pairs(arg_2_0._useKeyType.AxisKeys) do
		table.insert(var_2_1, iter_2_2)
	end

	arg_2_0._mgrInst = ZProj.GamepadManager.Instance
	arg_2_0._eventMgrInst = ZProj.GamepadEvent.Instance
	arg_2_0._eventMgr = ZProj.GamepadEvent

	arg_2_0._mgrInst:SetKeyListLua(var_2_0, var_2_1)
	arg_2_0._eventMgrInst:AddLuaLisenter(arg_2_0._eventMgr.UpKey, arg_2_0._onClickKey, arg_2_0)

	arg_2_0._buttonHandleFunc = {
		[GamepadEnum.KeyCode.A] = {
			arg_2_0._onClickA
		},
		[GamepadEnum.KeyCode.B] = {
			arg_2_0._onClickB
		}
	}
end

function var_0_0._checkGamepadModel(arg_3_0)
	arg_3_0._isOpen = SDKNativeUtil.isGamePad()

	if arg_3_0._isOpen then
		local var_3_0 = UnityEngine.Input.GetJoystickNames()
		local var_3_1 = false

		if var_3_0 and var_3_0.Length > 0 then
			for iter_3_0 = 0, var_3_0.Length - 1 do
				if var_3_1 then
					break
				end

				local var_3_2 = var_3_0[iter_3_0]

				for iter_3_1, iter_3_2 in pairs(GamepadKeyMapEnum.KeyMap) do
					if string.find(var_3_2, iter_3_1) then
						var_3_1 = true

						if BootNativeUtil.isAndroid() then
							arg_3_0._useKeyType = iter_3_2[2]

							break
						end

						if BootNativeUtil.isWindows() or SLFramework.FrameworkSettings.IsEditor then
							arg_3_0._useKeyType = iter_3_2[1]
						end

						break
					end
				end
			end
		end

		if var_3_1 == false then
			if BootNativeUtil.isAndroid() then
				arg_3_0._useKeyType = GamepadKeyMapEnum.KeyMap.XIAOM[2]
			elseif BootNativeUtil.isWindows() or SLFramework.FrameworkSettings.IsEditor then
				arg_3_0._useKeyType = GamepadKeyMapEnum.KeyMap.XIAOM[1]
			end
		end
	end
end

function var_0_0._onClickKey(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._useKeyType.JoystickKeys[arg_4_1]
	local var_4_1 = arg_4_0._buttonHandleFunc[var_4_0][1]

	if var_4_1 then
		var_4_1(arg_4_0)
	end
end

function var_0_0._onClickA(arg_5_0)
	if arg_5_0.onClickRightCallBack then
		arg_5_0.onClickRightCallBack(arg_5_0.onClickRightCallBackObj)
	end
end

function var_0_0._onClickB(arg_6_0)
	if arg_6_0.onClickLeftCallBack then
		arg_6_0.onClickLeftCallBack(arg_6_0.onClickLeftCallBackObj)
	end
end

function var_0_0.dispose(arg_7_0)
	arg_7_0.onClickRightCallBack = nil
	arg_7_0.onClickRightCallBackObj = nil
	arg_7_0.onClickLeftCallBack = nil
	arg_7_0.onClickLeftCallBackObj = nil
	arg_7_0._mgrInst = nil
	arg_7_0._eventMgrInst = nil
	arg_7_0._eventMgr = nil

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		if type(iter_7_1) == "userdata" then
			rawset(arg_7_0, iter_7_0, nil)
			logNormal("key = " .. tostring(iter_7_0) .. " value = " .. tostring(iter_7_1))
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

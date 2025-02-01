module("projbooter.hotupdate.GamepadBooter", package.seeall)

slot0 = class("GamepadBooter")

function slot0.init(slot0)
	addGlobalModule("projbooter.gamepad.define.GamepadEnum", "GamepadEnum")
	addGlobalModule("projbooter.gamepad.define.GamepadEvent", "GamepadEvent")
	addGlobalModule("projbooter.gamepad.define.GamepadXBoxKey_Android", "GamepadXBoxKey_Android")
	addGlobalModule("projbooter.gamepad.define.GamepadXBoxKey", "GamepadXBoxKey")
	addGlobalModule("projbooter.gamepad.define.GamepadKeyMapEnum", "GamepadKeyMapEnum")
end

function slot0.setBootMsgBoxClick(slot0, slot1, slot2, slot3, slot4)
	slot0.onClickRightCallBack = slot1
	slot0.onClickRightCallBackObj = slot2
	slot0.onClickLeftCallBack = slot3
	slot0.onClickLeftCallBackObj = slot4

	slot0:_checkGamepadModel()

	if slot0._isOpen == false then
		return
	end

	for slot9, slot10 in pairs(slot0._useKeyType.JoystickKeys) do
		table.insert({}, slot9)
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot0._useKeyType.AxisKeys) do
		table.insert(slot6, slot10)
	end

	slot0._mgrInst = ZProj.GamepadManager.Instance
	slot0._eventMgrInst = ZProj.GamepadEvent.Instance
	slot0._eventMgr = ZProj.GamepadEvent

	slot0._mgrInst:SetKeyListLua(slot5, slot6)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.UpKey, slot0._onClickKey, slot0)

	slot0._buttonHandleFunc = {
		[GamepadEnum.KeyCode.A] = {
			slot0._onClickA
		},
		[GamepadEnum.KeyCode.B] = {
			slot0._onClickB
		}
	}
end

function slot0._checkGamepadModel(slot0)
	slot0._isOpen = SDKNativeUtil.isGamePad()

	if slot0._isOpen then
		slot2 = false

		if UnityEngine.Input.GetJoystickNames() and slot1.Length > 0 then
			for slot6 = 0, slot1.Length - 1 do
				if slot2 then
					break
				end

				for slot11, slot12 in pairs(GamepadKeyMapEnum.KeyMap) do
					if string.find(slot1[slot6], slot11) then
						slot2 = true

						if BootNativeUtil.isAndroid() then
							slot0._useKeyType = slot12[2]

							break
						end

						if BootNativeUtil.isWindows() or SLFramework.FrameworkSettings.IsEditor then
							slot0._useKeyType = slot12[1]
						end

						break
					end
				end
			end
		end

		if slot2 == false then
			if BootNativeUtil.isAndroid() then
				slot0._useKeyType = GamepadKeyMapEnum.KeyMap.XIAOM[2]
			elseif BootNativeUtil.isWindows() or SLFramework.FrameworkSettings.IsEditor then
				slot0._useKeyType = GamepadKeyMapEnum.KeyMap.XIAOM[1]
			end
		end
	end
end

function slot0._onClickKey(slot0, slot1)
	if slot0._buttonHandleFunc[slot0._useKeyType.JoystickKeys[slot1]][1] then
		slot3(slot0)
	end
end

function slot0._onClickA(slot0)
	if slot0.onClickRightCallBack then
		slot0.onClickRightCallBack(slot0.onClickRightCallBackObj)
	end
end

function slot0._onClickB(slot0)
	if slot0.onClickLeftCallBack then
		slot0.onClickLeftCallBack(slot0.onClickLeftCallBackObj)
	end
end

function slot0.dispose(slot0)
	slot0.onClickRightCallBack = nil
	slot0.onClickRightCallBackObj = nil
	slot0.onClickLeftCallBack = nil
	slot0.onClickLeftCallBackObj = nil
	slot0._mgrInst = nil
	slot0._eventMgrInst = nil
	slot0._eventMgr = nil

	for slot4, slot5 in pairs(slot0) do
		if type(slot5) == "userdata" then
			rawset(slot0, slot4, nil)
			logNormal("key = " .. tostring(slot4) .. " value = " .. tostring(slot5))
		end
	end
end

slot0.instance = slot0.New()

return slot0

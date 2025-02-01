module("modules.logic.gamepad.GamepadController", package.seeall)

slot0 = class("GamepadController", BaseController)

function slot0.onInit(slot0)
	if GamepadBooter ~= nil then
		slot0:setUp()
	end
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.isOpen(slot0)
	return slot0._isOpen
end

function slot0.isDownA(slot0)
	return slot0._down
end

function slot0.getMousePosition(slot0)
	if slot0:isOpen() then
		return slot0:getScreenPos()
	else
		return UnityEngine.Input.mousePosition
	end
end

function slot0.getScreenPos(slot0)
	slot0:_updateScreenPos()

	return Vector2.New(slot0._screenPosV2.x, slot0._screenPosV2.y)
end

function slot0.setPointerAnchor(slot0, slot1, slot2)
	slot0._pointer:setAnchor(slot1, slot2)
	slot0:_updateScreenPos()
end

function slot0.setUp(slot0)
	slot0:_checkGamepadModel()

	if slot0._isOpen == false then
		return
	end

	for slot5, slot6 in pairs(slot0._useKeyType.JoystickKeys) do
		table.insert({}, slot5)
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot0._useKeyType.AxisKeys) do
		table.insert(slot2, slot6)
	end

	slot0._mgrInst = ZProj.GamepadManager.Instance
	slot0._eventMgrInst = ZProj.GamepadEvent.Instance
	slot0._eventMgr = ZProj.GamepadEvent

	slot0._eventMgrInst:ClearLuaListener()
	slot0._mgrInst:SetKeyListLua(slot1, slot2)

	slot0._pointer = GamepadPointer.New()
	slot0._screenPosV2 = Vector2.New()

	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.DownKey, slot0._onDownKey, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.UpKey, slot0._onUpKey, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.ClickKey, slot0._onClickKey, slot0)
	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.AxisChange, slot0._onAxisChange, slot0)

	slot0._axisHandleFunc = {
		[GamepadEnum.KeyCode.LeftStickHorizontal] = slot0._onLeftStickHorizontal,
		[GamepadEnum.KeyCode.LeftStickVertical] = slot0._onLeftStickVertical,
		[GamepadEnum.KeyCode.RightStickHorizontal] = slot0._onRightStickHorizontal,
		[GamepadEnum.KeyCode.RightStickVertical] = slot0._onRightStickVertical
	}
	slot0._buttonHandleFunc = {
		[GamepadEnum.KeyCode.A] = {
			slot0._onDownA,
			slot0._onUpA
		},
		[GamepadEnum.KeyCode.B] = {
			slot0._onDownB,
			slot0._onUpB
		},
		[GamepadEnum.KeyCode.LB] = {},
		[GamepadEnum.KeyCode.RB] = {}
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

function slot0._onDownKey(slot0, slot1)
	if slot0._buttonHandleFunc[slot0._useKeyType.JoystickKeys[slot1]][1] then
		slot3(slot0)
	end

	slot0:dispatchEvent(GamepadEvent.KeyDown, slot2)
end

function slot0._onUpKey(slot0, slot1)
	if slot0._buttonHandleFunc[slot0._useKeyType.JoystickKeys[slot1]][2] then
		slot3(slot0)
	end

	slot0:dispatchEvent(GamepadEvent.KeyUp, slot2)
end

function slot0._updateScreenPos(slot0)
	slot1, slot2 = slot0._pointer:getScreenPos()

	if slot1 and slot2 then
		slot0._screenPosV2.x = slot1
		slot0._screenPosV2.y = slot2
	end
end

function slot0._setUIClick(slot0, slot1)
	slot0._mgrInst:SendClickEvent(slot0._screenPosV2, slot1)
end

function slot0._sendDragEvent(slot0)
	slot0:_updateScreenPos()
	slot0._mgrInst:SendDragEvent(slot0._screenPosV2)
end

function slot0._onClickKey(slot0, slot1)
end

function slot0._onAxisChange(slot0, slot1, slot2)
	if slot0._axisHandleFunc[slot0._useKeyType.AxisKeys[slot1]] then
		slot4(slot0, slot2)
	end

	slot0:dispatchEvent(GamepadEvent.AxisChange, slot3, slot2)
end

function slot0._onDownA(slot0)
	slot0._down = true

	slot0:_updateScreenPos()
	slot0:_setUIClick(true)
	GameGlobalMgr.instance:playTouchEffect(slot0._screenPosV2)
	slot0:_clearDownActiveTouchMgrDic()

	slot0._downActiveTouchMgrDic = {}

	for slot5, slot6 in ipairs(TouchEventMgrHepler.getAllMgrs()) do
		if not gohelper.isNil(slot6) and slot6.isActiveAndEnabled then
			slot6:TriggerOnTouchDown(slot0._screenPosV2)

			slot0._downActiveTouchMgrDic[slot6] = true
		end
	end
end

function slot0._onUpA(slot0)
	slot0._down = false

	slot0:_updateScreenPos()
	slot0:_setUIClick(false)

	if slot0._downActiveTouchMgrDic then
		for slot5, slot6 in ipairs(TouchEventMgrHepler.getAllMgrs()) do
			if not gohelper.isNil(slot6) and slot6.isActiveAndEnabled and slot0._downActiveTouchMgrDic[slot6] then
				slot6:TriggerOnClick(slot0._screenPosV2)
				slot6:TriggerOnTouchUp(slot0._screenPosV2)
			end
		end
	end

	slot0:_clearDownActiveTouchMgrDic()
end

function slot0._clearDownActiveTouchMgrDic(slot0)
	if slot0._downActiveTouchMgrDic then
		for slot4, slot5 in pairs(slot0._downActiveTouchMgrDic) do
			slot0._downActiveTouchMgrDic[slot4] = nil
		end

		slot0._downActiveTouchMgrDic = nil
	end
end

function slot0._onDownB(slot0)
end

function slot0._onUpB(slot0)
	if not slot0._down then
		NavigateMgr.instance:onEscapeBtnClick()
	end
end

function slot0._onLeftStickHorizontal(slot0, slot1)
	slot0._pointer:updateX(Time.deltaTime / 0.016 * slot1)

	if slot0._down then
		slot0:_sendDragEvent()
	end
end

function slot0._onLeftStickVertical(slot0, slot1)
	slot0._pointer:updateY(-1 * Time.deltaTime / 0.016 * slot1)

	if slot0._down then
		slot0:_sendDragEvent()
	end
end

function slot0._onRightStickHorizontal(slot0, slot1)
end

function slot0._onRightStickVertical(slot0, slot1)
end

slot0.instance = slot0.New()

return slot0

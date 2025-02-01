slot2 = UnityEngine.Input
slot3 = UnityEngine.KeyCode
slot4 = SLFramework.GameObjectHelper
slot5 = UnityEngine.EventSystems.EventSystem
slot6 = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult
slot7 = UnityEngine.EventSystems.PointerEventData
slot9 = "#00FF00"
slot10 = "#FFFF00"
slot11 = "_luaLang"
slot12 = "_lang"

function slot13(slot0)
	if uv0("GMRpc") then
		slot1.instance:sendGMRequest(slot0)
	end
end

function slot14()
	if uv0("LoginController") then
		slot0.instance:logout()
	end
end

_G.getGlobal("Partial_GMTool")._input = ({
	_super = function (slot0)
		for slot5 = 1, #{
			"add hero all 1",
			"add material 10#10#100",
			"add material 2#5#1000000",
			"add allfaith 22222",
			"set level 60",
			"add equip 0#30#1",
			"set dungeon all"
		} do
			uv0(slot1[slot5])
		end
	end,
	_showMouseClickGoName = function (slot0)
		if not uv0.current or not slot1:IsPointerOverGameObject() then
			return
		end

		if gohelper.isNil(slot1.currentSelectedGameObject) and uv1("CameraMgr") and CameraMgr.instance:getMainCamera() then
			slot0._pointerEventData = slot0._pointerEventData or uv3.New(uv0.current)
			slot0._pointerEventData.position = uv2.mousePosition
			slot0._csList = slot0._csList or uv4.New()

			slot1:RaycastAll(slot0._pointerEventData, slot0._csList)

			if slot0._csList.Count > 0 then
				slot2 = slot0._csList[0].gameObject
			end
		end

		if not gohelper.isNil(slot2) then
			logNormal(uv5.util.setColorDesc(uv6.GetPath(slot2), uv7))
		end
	end,
	_getOpeningViewNameList = function (slot0)
		slot1 = ViewMgr.instance:getOpenViewNameList() or {}
		slot2 = {}

		for slot6 = #slot1, 1, -1 do
			if ViewMgr.instance:getContainer(slot1[slot6]) and not ViewHelper.instance:checkIsGlobalIgnore(slot7) then
				table.insert(slot2, slot7)
			end
		end

		return slot2
	end,
	_showOpeningViewName = function (slot0)
		if #slot0:_getOpeningViewNameList() > 0 then
			table.insert({}, "GM [正在打开的UI]:")

			for slot6, slot7 in ipairs(slot1) do
				table.insert(slot2, uv0.util.setColorDesc(slot6, uv1) .. " " .. uv0.util.setColorDesc(slot7, uv2))
			end

			logError(table.concat(slot2, "\n"))
		end
	end,
	_hookLangSettings__luaLang_rawkey = function (slot0, slot1)
	end,
	_hookLangSettings__luaLang = function (slot0, slot1)
		slot2 = nil
		LangSettings[uv0] = (not slot1 or GMMinusModel.instance:loadOriginalFunc(LangSettings, uv0)) and function (slot0, slot1)
			return slot1
		end
	end,
	_hookLangSettings__lang = function (slot0, slot1)
		slot2 = nil
		LangSettings[uv0] = (not slot1 or GMMinusModel.instance:loadOriginalFunc(LangSettings, uv0)) and function (slot0, slot1)
			return slot1
		end
	end,
	_switchLuaLang = function (slot0)
		slot1 = not slot0._mlStringEnable

		slot0:_hookLangSettings__luaLang(slot1)
		slot0:_hookLangSettings__lang(slot1)

		slot0._mlStringEnable = slot1
	end,
	onClear = function (slot0)
		slot0._pointerEventData = nil
		slot0._csList = nil

		if slot0._mlStringEnable == false then
			slot0:_switchLuaLang()
		else
			GMMinusModel.instance:saveOriginalFunc(LangSettings, uv0)
			GMMinusModel.instance:saveOriginalFunc(LangSettings, uv1)
		end

		slot0._mlStringEnable = true

		return slot0
	end,
	onUpdate = function (slot0)
		slot3 = uv0.GetKey(uv1.LeftAlt) or uv0.GetKey(uv1.RightAlt)
		slot6 = uv0.GetKey(uv1.LeftShift) or uv0.GetKey(uv1.RightShift)
		slot9 = uv0.GetKey(uv1.LeftControl) or uv0.GetKey(uv1.RightControl)

		if uv0.GetKeyDown(uv1.F12) then
			logNormal("F12 logout")
			uv2()
		elseif uv0.GetKeyDown(uv1.F2) then
			logNormal("F2 super")
			slot0:_super()
		elseif slot9 and uv0.GetMouseButtonUp(0) then
			logNormal("Ctrl + Left Mouse Click")
			slot0:_showMouseClickGoName()
		elseif slot9 and slot3 and uv0.GetKeyDown(uv1.Alpha1) then
			logNormal("Ctrl + Alt + 1")
			slot0:_switchLuaLang()
		elseif slot9 and slot3 and uv0.GetKeyDown(uv1.Alpha2) then
			logNormal("Ctrl + Alt + 2")
			slot0:_showOpeningViewName()
		end
	end
}):onClear()

return {}

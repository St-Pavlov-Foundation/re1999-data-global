slot0 = string.format
slot1 = table.insert
slot2 = table.concat
slot5 = UnityEngine.Input
slot6 = UnityEngine.KeyCode
slot7 = SLFramework.GameObjectHelper
slot8 = UnityEngine.EventSystems.EventSystem
slot9 = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult
slot10 = UnityEngine.EventSystems.PointerEventData
slot12 = "#00FF00"
slot13 = "#FFFF00"
slot14 = "_luaLang"
slot15 = "_lang"
slot16 = SLFramework.ResLogMgr.Instance

function slot17(slot0)
	if uv0("GMRpc") then
		slot1.instance:sendGMRequest(slot0)
	end
end

function slot18()
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

			logError(uv3(slot2, "\n"))
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
	_switchResLog = function (slot0)
		if slot0._resLogEnable == nil then
			slot0._resLogEnable = true
			uv0.Enable = true

			return
		end

		if slot0._resLogEnable == true then
			slot3 = {}

			if SLFramework.ResLogMgr.Instance:GetList().Count > 0 then
				for slot9 = 0, slot5 - 1 do
					slot10 = slot4[slot9]

					uv1(slot3, {
						cost = slot10.loadedTime - slot10.loadTime,
						loadedTime = slot10.loadedTime,
						loadTime = slot10.loadTime,
						path = slot10.path,
						size = slot10.size,
						_id = slot9
					})
				end
			end

			if #slot3 > 0 then
				table.sort(slot3, function (slot0, slot1)
					if slot0.loadTime ~= slot1.loadTime then
						return slot2 < slot3
					end

					if slot0.cost ~= slot1.cost then
						return slot5 < slot4
					end

					if slot0.size ~= slot1.size then
						return slot7 < slot6
					end

					return slot0._id < slot1._id
				end)
			end

			slot6 = {}
			slot9 = 0
			slot10 = 0

			for slot14, slot15 in ipairs(slot3) do
				slot16 = uv2("%.3fs", slot15.cost)

				if uv2("%.2f", slot15.loadTime) ~= nil then
					slot8 = 0 + 1
					slot7 = slot17

					if slot15.cost < 0 then
						return
					end

					if slot15.cost < 10 then
						slot9 = slot9 + slot15.cost
					end
				end

				slot18 = tonumber(tostring(slot15.size))
				slot10 = slot10 + slot18

				uv1(slot6, uv2("%s (%s): cost=%s, size=%s, path=%s", slot14, slot8, slot16, uv2("%.4f MB", slot18 / 1024 / 1024), slot15.path))
			end

			uv1(slot6, 1, uv2("tot_cnt: %s, tot_size: %s, tot_cost: %s seconds", slot5, uv2("%.4f MB", slot10 / 1024 / 1024), slot9))
			logError(uv3(slot6, "\n"))
		end

		slot0._resLogEnable = not slot0._resLogEnable
		uv0.Enable = slot0._resLogEnable
	end,
	onClear = function (slot0)
		slot0._pointerEventData = nil
		slot0._csList = nil
		slot0._resLogEnable = nil

		if slot0._mlStringEnable == false then
			slot0:_switchLuaLang()
		else
			GMMinusModel.instance:saveOriginalFunc(LangSettings, uv0)
			GMMinusModel.instance:saveOriginalFunc(LangSettings, uv1)
		end

		slot0._mlStringEnable = true
		uv2.Enable = false

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
		elseif slot9 and slot3 and uv0.GetKeyDown(uv1.Alpha3) then
			logNormal("Ctrl + Alt + 3")
			slot0:_switchResLog()
		end
	end
}):onClear()

return {}

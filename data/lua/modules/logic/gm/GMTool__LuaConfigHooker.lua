slot2 = _G.addGlobalModule
slot3 = string.format
slot4 = _G.debug.getupvalue

function slot5(slot0, slot1)
	if not slot1 or not slot0 then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		slot0[slot5] = slot6
	end
end

slot7 = "lua_"
_G.getGlobal("Partial_GMTool")._LuaConfigHooker = ({
	onClear = function (slot0)
		slot0._sConfigInfo = slot0._sConfigInfo or {}

		if slot0._isEnabledMlString == false then
			slot0:toggleSwitchMlString()
		end

		slot0._isEnabledMlString = true

		return slot0
	end,
	_isValid = function (slot0, slot1)
		if not slot1 then
			return false
		end

		return slot0._sConfigInfo[slot1] and true or false
	end,
	_try_inject = function (slot0, slot1)
		if string.nilorempty(slot1) then
			return
		end

		if not getModulePath(slot1) then
			logError(uv0("[GMTool__LuaConfigHooker] please re gen require_modules.lua error moduleName: %s", slot2))

			return
		end

		if not uv1(slot3, slot2) then
			logError(uv0("[GMTool__LuaConfigHooker] please re gen require_modules.lua error modulePath: %s", slot3))

			return
		end

		slot0:_validate(slot4, slot2)
	end,
	_validate = function (slot0, slot1, slot2)
		slot3 = uv0(slot1.onLoad, 1) or slot2
		slot4 = nil

		function slot1._name()
			return uv0
		end

		slot5 = {}
		slot0._sConfigInfo[slot3] = {
			fields = false,
			primaryKey = false,
			mlStringKey = false,
			name = slot3,
			mlStringKeyBackup = slot5
		}

		function slot1._fields()
			return uv0:_getUpvalue(uv1, "fields")
		end

		function slot1._primaryKey()
			return uv0:_getUpvalue(uv1, "primaryKey")
		end

		function slot1._mlStringKey()
			return uv0:_getUpvalue(uv1, "mlStringKey")
		end

		function slot1._mlStringKeyBackup()
			return uv0
		end

		uv1(slot5, slot1._mlStringKey())
	end,
	_getUpvalue = function (slot0, slot1, slot2)
		if not slot0._sConfigInfo[slot1._name()][slot2] then
			slot4[slot2] = uv0.util.getUpvalue(slot1.onLoad, slot2, 1, 10)
		end

		return slot4[slot2]
	end,
	_setActiveLangKey = function (slot0, slot1, slot2)
		if slot2 then
			uv0(slot1._mlStringKey(), slot1._mlStringKeyBackup())
		else
			for slot8, slot9 in pairs(slot3 or {}) do
				rawset(slot3, slot8, nil)
			end
		end
	end,
	toggleSwitchMlString = function (slot0)
		slot5 = not slot0._isEnabledMlString

		logNormal("Toggle Switch MlString: " .. uv0.util.colorBoolStr(slot5))

		for slot5, slot6 in pairs(slot0._sConfigInfo) do
			slot0:_setActiveLangKey(_G[slot6.name], slot1)
		end

		slot0._isEnabledMlString = slot1
	end
}):onClear()
slot8 = {
	"lua_language_coder",
	"lua_language_prefab"
}

function slot9()
	for slot3, slot4 in ipairs(uv0) do
		uv1:_try_inject(slot4)
	end
end

slot10 = "modules.configs.excel2json.lua_"

function ()
	for slot4, slot5 in pairs(_G.moduleNameToPath) do
		if uv0.util.startsWith(slot5, uv1) then
			uv2:_try_inject(slot4)
		end
	end
end()

return {}

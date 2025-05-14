local var_0_0 = _G.getGlobal("Partial_GMTool")
local var_0_1 = _G.addGlobalModule
local var_0_2 = string.format
local var_0_3 = _G.debug.getupvalue

local function var_0_4(arg_1_0, arg_1_1)
	if not arg_1_1 or not arg_1_0 then
		return
	end

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		arg_1_0[iter_1_0] = iter_1_1
	end
end

local var_0_5 = {
	onClear = function(arg_2_0)
		arg_2_0._sConfigInfo = arg_2_0._sConfigInfo or {}

		if arg_2_0._isEnabledMlString == false then
			arg_2_0:toggleSwitchMlString()
		end

		arg_2_0._isEnabledMlString = true

		return arg_2_0
	end,
	_isValid = function(arg_3_0, arg_3_1)
		if not arg_3_1 then
			return false
		end

		return arg_3_0._sConfigInfo[arg_3_1] and true or false
	end,
	_try_inject = function(arg_4_0, arg_4_1)
		if string.nilorempty(arg_4_1) then
			return
		end

		local var_4_0 = arg_4_1
		local var_4_1 = getModulePath(var_4_0)

		if not var_4_1 then
			logError(var_0_2("[GMTool__LuaConfigHooker] please re gen require_modules.lua error moduleName: %s", var_4_0))

			return
		end

		local var_4_2 = var_0_1(var_4_1, var_4_0)

		if not var_4_2 then
			logError(var_0_2("[GMTool__LuaConfigHooker] please re gen require_modules.lua error modulePath: %s", var_4_1))

			return
		end

		arg_4_0:_validate(var_4_2, var_4_0)
	end
}
local var_0_6 = "lua_"

function var_0_5._validate(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_3(arg_5_1.onLoad, 1) or arg_5_2
	local var_5_1

	function arg_5_1._name()
		return var_5_0
	end

	local var_5_2 = {}

	arg_5_0._sConfigInfo[var_5_0] = {
		fields = false,
		primaryKey = false,
		mlStringKey = false,
		name = var_5_0,
		mlStringKeyBackup = var_5_2
	}

	function arg_5_1._fields()
		return arg_5_0:_getUpvalue(arg_5_1, "fields")
	end

	function arg_5_1._primaryKey()
		return arg_5_0:_getUpvalue(arg_5_1, "primaryKey")
	end

	function arg_5_1._mlStringKey()
		return arg_5_0:_getUpvalue(arg_5_1, "mlStringKey")
	end

	function arg_5_1._mlStringKeyBackup()
		return var_5_2
	end

	var_0_4(var_5_2, arg_5_1._mlStringKey())
end

function var_0_5._getUpvalue(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1._name()
	local var_11_1 = arg_11_0._sConfigInfo[var_11_0]

	if not var_11_1[arg_11_2] then
		var_11_1[arg_11_2] = var_0_0.util.getUpvalue(arg_11_1.onLoad, arg_11_2, 1, 10)
	end

	return var_11_1[arg_11_2]
end

function var_0_5._setActiveLangKey(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1._mlStringKey()
	local var_12_1 = arg_12_1._mlStringKeyBackup()

	if arg_12_2 then
		var_0_4(var_12_0, var_12_1)
	else
		for iter_12_0, iter_12_1 in pairs(var_12_0 or {}) do
			rawset(var_12_0, iter_12_0, nil)
		end
	end
end

function var_0_5.toggleSwitchMlString(arg_13_0)
	local var_13_0 = not arg_13_0._isEnabledMlString

	logNormal("Toggle Switch MlString: " .. var_0_0.util.colorBoolStr(var_13_0))

	for iter_13_0, iter_13_1 in pairs(arg_13_0._sConfigInfo) do
		local var_13_1 = iter_13_1.name
		local var_13_2 = _G[var_13_1]

		arg_13_0:_setActiveLangKey(var_13_2, var_13_0)
	end

	arg_13_0._isEnabledMlString = var_13_0
end

var_0_0._LuaConfigHooker = var_0_5:onClear()

local var_0_7 = {
	"lua_language_coder",
	"lua_language_prefab"
}

local function var_0_8()
	for iter_14_0, iter_14_1 in ipairs(var_0_7) do
		var_0_5:_try_inject(iter_14_1)
	end
end

local var_0_9 = "modules.configs.excel2json.lua_"

;(function()
	local var_15_0 = _G.moduleNameToPath

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if var_0_0.util.startsWith(iter_15_1, var_0_9) then
			var_0_5:_try_inject(iter_15_0)
		end
	end
end)()

return {}

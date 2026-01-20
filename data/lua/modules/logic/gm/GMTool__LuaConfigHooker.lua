-- chunkname: @modules/logic/gm/GMTool__LuaConfigHooker.lua

local getGlobal = _G.getGlobal
local GMTool = getGlobal("Partial_GMTool")
local addGlobalModule = _G.addGlobalModule
local sf = string.format
local debug_getupvalue = _G.debug.getupvalue

local function _copy(dst, src)
	if not src or not dst then
		return
	end

	for k, v in pairs(src) do
		dst[k] = v
	end
end

local M = {}

function M:onClear()
	self._sConfigInfo = self._sConfigInfo or {}

	if self._isEnabledMlString == false then
		self:toggleSwitchMlString()
	end

	self._isEnabledMlString = true

	return self
end

function M:_isValid(k)
	if not k then
		return false
	end

	return self._sConfigInfo[k] and true or false
end

function M:_try_inject(name)
	if string.nilorempty(name) then
		return
	end

	local moduleName = name
	local modulePath = getModulePath(moduleName)

	if not modulePath then
		logError(sf("[GMTool__LuaConfigHooker] please re gen require_modules.lua error moduleName: %s", moduleName))

		return
	end

	local lua_table = addGlobalModule(modulePath, moduleName)

	if not lua_table then
		logError(sf("[GMTool__LuaConfigHooker] please re gen require_modules.lua error modulePath: %s", modulePath))

		return
	end

	self:_validate(lua_table, moduleName)
end

local kLuaTableNamePrefix = "lua_"

function M:_validate(lua_table, opt_name)
	local name, _ = debug_getupvalue(lua_table.onLoad, 1) or opt_name

	function lua_table._name()
		return name
	end

	local mlStringKeyBackup = {}

	self._sConfigInfo[name] = {
		fields = false,
		primaryKey = false,
		mlStringKey = false,
		name = name,
		mlStringKeyBackup = mlStringKeyBackup
	}

	function lua_table._fields()
		return self:_getUpvalue(lua_table, "fields")
	end

	function lua_table._primaryKey()
		return self:_getUpvalue(lua_table, "primaryKey")
	end

	function lua_table._mlStringKey()
		return self:_getUpvalue(lua_table, "mlStringKey")
	end

	function lua_table._mlStringKeyBackup()
		return mlStringKeyBackup
	end

	_copy(mlStringKeyBackup, lua_table._mlStringKey())
end

function M:_getUpvalue(lua_table, upvalueKey)
	local name = lua_table._name()
	local configInfo = self._sConfigInfo[name]

	if not configInfo[upvalueKey] then
		configInfo[upvalueKey] = GMTool.util.getUpvalue(lua_table.onLoad, upvalueKey, 1, 10)
	end

	return configInfo[upvalueKey]
end

function M:_setActiveLangKey(lua_table, isActive)
	local mlstringKey = lua_table._mlStringKey()
	local mlStringKeyBackup = lua_table._mlStringKeyBackup()

	if isActive then
		_copy(mlstringKey, mlStringKeyBackup)
	else
		for k, _ in pairs(mlstringKey or {}) do
			rawset(mlstringKey, k, nil)
		end
	end
end

function M:toggleSwitchMlString()
	local isActive = not self._isEnabledMlString

	logNormal("Toggle Switch MlString: " .. GMTool.util.colorBoolStr(isActive))

	for _, v in pairs(self._sConfigInfo) do
		local name = v.name
		local lua_table = _G[name]

		self:_setActiveLangKey(lua_table, isActive)
	end

	self._isEnabledMlString = isActive
end

GMTool._LuaConfigHooker = M:onClear()

local kHookList = {
	"lua_language_coder",
	"lua_language_prefab"
}

local function _hook_example()
	for _, moduleName in ipairs(kHookList) do
		M:_try_inject(moduleName)
	end
end

local kModulePathPrefix = "modules.configs.excel2json.lua_"

local function hookOnce()
	local moduleNameToPath = _G.moduleNameToPath

	for moduleName, modulePath in pairs(moduleNameToPath) do
		if GMTool.util.startsWith(modulePath, kModulePathPrefix) then
			M:_try_inject(moduleName)
		end
	end
end

hookOnce()

return {}

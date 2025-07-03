if jit and SLFramework.FrameworkSettings.Is64Bit then
	jit.off()
end

canLogNormal = SLFramework.SLLogger.CanLogNormal
canLogWarn = SLFramework.SLLogger.CanLogWarn
canLogError = SLFramework.SLLogger.CanLogError
isDebugBuild = SLFramework.UnityHelper.IsDebugBuild()
_xpcall = xpcall

function __G__TRACKBACK__(arg_1_0)
	if canLogError then
		printError(arg_1_0 .. "\n" .. debug.traceback())
	end
end

function callWithCatch(arg_2_0, ...)
	if (... ~= nil and select("#", ...) or 0) > 0 then
		return _xpcall(arg_2_0, __G__TRACKBACK__, select(1, ...))
	else
		return _xpcall(arg_2_0, __G__TRACKBACK__)
	end
end

function setGlobal(arg_3_0, arg_3_1)
	if arg_3_0 == nil then
		error("BootStarter setGlobal, key should not be nil!")

		return
	end

	rawset(_G, arg_3_0, arg_3_1)
end

function getGlobal(arg_4_0)
	return rawget(_G, arg_4_0)
end

moduleNameToTables = {}
moduleNameToPath = {}

function getModuleDef(arg_5_0)
	return moduleNameToTables[arg_5_0]
end

function getModulePath(arg_6_0)
	return moduleNameToPath[arg_6_0]
end

function addGlobalModule(arg_7_0, arg_7_1)
	local var_7_0 = require(arg_7_0)

	if arg_7_1 and not moduleNameToTables[arg_7_1] then
		if type(var_7_0) ~= "table" then
			moduleNameToTables[arg_7_1] = true

			error("BootStarter addGlobalModule, can not find module define, module path = " .. arg_7_0)
		else
			moduleNameToTables[arg_7_1] = var_7_0

			setGlobal(arg_7_1, var_7_0)
		end
	end

	return var_7_0
end

function setNeedLoadModule(arg_8_0, arg_8_1)
	if arg_8_1 and not moduleNameToPath[arg_8_1] then
		moduleNameToPath[arg_8_1] = arg_8_0
	end

	return true
end

gMetaTable = {}

function gMetaTable.__index(arg_9_0, arg_9_1)
	local var_9_0 = moduleNameToTables[arg_9_1]

	if not var_9_0 then
		local var_9_1 = moduleNameToPath[arg_9_1]

		if var_9_1 then
			var_9_0 = require(var_9_1)

			if type(var_9_0) ~= "table" then
				moduleNameToTables[arg_9_1] = true

				error("BootStarter __index, can not find module define, module path = " .. var_9_1)
			else
				moduleNameToTables[arg_9_1] = var_9_0

				setGlobal(arg_9_1, var_9_0)
			end
		end
	end

	return var_9_0
end

function gMetaTable.__newindex(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= "booter" and arg_10_1 ~= "projbooter" and arg_10_1 ~= "framework" and arg_10_1 ~= "modules" and arg_10_1 ~= "protobuf" then
		error("BootStarter gMetaTable.__newindex, can not set _G table value from other module, use setGlobal function instead! key = " .. arg_10_1)
	end
end

setmetatable(_G, gMetaTable)

local function var_0_0()
	addGlobalModule("booter.base.cjson")
	addGlobalModule("booter.base.logger")
	addGlobalModule("booter.base.oop")
	addGlobalModule("booter.base.string")
	addGlobalModule("booter.base.tabletool")
	forceLog("SLFramework, lua start!")
	addGlobalModule("booter.LuaResMgr")

	local var_11_0 = SLFramework.GameConfig.Instance

	setGlobal("GameConfig", var_11_0)
	addGlobalModule("projbooter.ProjBooter", "ProjBooter")
end

local var_0_1, var_0_2 = callWithCatch(var_0_0)

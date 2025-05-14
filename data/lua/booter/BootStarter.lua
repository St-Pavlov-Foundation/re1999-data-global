if jit and SLFramework.FrameworkSettings.Is64Bit then
	jit.off()
end

canLogNormal = SLFramework.SLLogger.CanLogNormal
canLogWarn = SLFramework.SLLogger.CanLogWarn
canLogError = SLFramework.SLLogger.CanLogError
isDebugBuild = SLFramework.UnityHelper.IsDebugBuild()

function __G__TRACKBACK__(arg_1_0)
	if canLogError then
		printError(arg_1_0 .. "\n" .. debug.traceback())
	end
end

function callWithCatch(arg_2_0, ...)
	if ... ~= nil then
		local var_2_0 = {
			...
		}

		return xpcall(function()
			arg_2_0(unpack(var_2_0))
		end, __G__TRACKBACK__)
	else
		return xpcall(arg_2_0, __G__TRACKBACK__)
	end
end

function setGlobal(arg_4_0, arg_4_1)
	if arg_4_0 == nil then
		error("BootStarter setGlobal, key should not be nil!")

		return
	end

	rawset(_G, arg_4_0, arg_4_1)
end

function getGlobal(arg_5_0)
	return rawget(_G, arg_5_0)
end

moduleNameToTables = {}
moduleNameToPath = {}

function getModuleDef(arg_6_0)
	return moduleNameToTables[arg_6_0]
end

function getModulePath(arg_7_0)
	return moduleNameToPath[arg_7_0]
end

function addGlobalModule(arg_8_0, arg_8_1)
	local var_8_0 = require(arg_8_0)

	if arg_8_1 and not moduleNameToTables[arg_8_1] then
		if type(var_8_0) ~= "table" then
			moduleNameToTables[arg_8_1] = true

			error("BootStarter addGlobalModule, can not find module define, module path = " .. arg_8_0)
		else
			moduleNameToTables[arg_8_1] = var_8_0

			setGlobal(arg_8_1, var_8_0)
		end
	end

	return var_8_0
end

function setNeedLoadModule(arg_9_0, arg_9_1)
	if arg_9_1 and not moduleNameToPath[arg_9_1] then
		moduleNameToPath[arg_9_1] = arg_9_0
	end

	return true
end

gMetaTable = {}

function gMetaTable.__index(arg_10_0, arg_10_1)
	local var_10_0 = moduleNameToTables[arg_10_1]

	if not var_10_0 then
		local var_10_1 = moduleNameToPath[arg_10_1]

		if var_10_1 then
			var_10_0 = require(var_10_1)

			if type(var_10_0) ~= "table" then
				moduleNameToTables[arg_10_1] = true

				error("BootStarter __index, can not find module define, module path = " .. var_10_1)
			else
				moduleNameToTables[arg_10_1] = var_10_0

				setGlobal(arg_10_1, var_10_0)
			end
		end
	end

	return var_10_0
end

function gMetaTable.__newindex(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= "booter" and arg_11_1 ~= "projbooter" and arg_11_1 ~= "framework" and arg_11_1 ~= "modules" and arg_11_1 ~= "protobuf" then
		error("BootStarter gMetaTable.__newindex, can not set _G table value from other module, use setGlobal function instead! key = " .. arg_11_1)
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

	local var_12_0 = SLFramework.GameConfig.Instance

	setGlobal("GameConfig", var_12_0)
	addGlobalModule("projbooter.ProjBooter", "ProjBooter")
end

local var_0_1, var_0_2 = callWithCatch(var_0_0)

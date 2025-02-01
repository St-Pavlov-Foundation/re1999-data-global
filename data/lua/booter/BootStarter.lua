if jit and SLFramework.FrameworkSettings.Is64Bit then
	jit.off()
end

canLogNormal = SLFramework.SLLogger.CanLogNormal
canLogWarn = SLFramework.SLLogger.CanLogWarn
canLogError = SLFramework.SLLogger.CanLogError
isDebugBuild = SLFramework.UnityHelper.IsDebugBuild()

function __G__TRACKBACK__(slot0)
	if canLogError then
		printError(slot0 .. "\n" .. debug.traceback())
	end
end

function callWithCatch(slot0, ...)
	if ... ~= nil then
		slot1 = {
			...
		}

		return xpcall(function ()
			uv0(unpack(uv1))
		end, __G__TRACKBACK__)
	else
		return xpcall(slot0, __G__TRACKBACK__)
	end
end

function setGlobal(slot0, slot1)
	if slot0 == nil then
		error("BootStarter setGlobal, key should not be nil!")

		return
	end

	rawset(_G, slot0, slot1)
end

function getGlobal(slot0)
	return rawget(_G, slot0)
end

moduleNameToTables = {}
moduleNameToPath = {}

function getModuleDef(slot0)
	return moduleNameToTables[slot0]
end

function getModulePath(slot0)
	return moduleNameToPath[slot0]
end

function addGlobalModule(slot0, slot1)
	if slot1 and not moduleNameToTables[slot1] then
		if type(require(slot0)) ~= "table" then
			moduleNameToTables[slot1] = true

			error("BootStarter addGlobalModule, can not find module define, module path = " .. slot0)
		else
			moduleNameToTables[slot1] = slot2

			setGlobal(slot1, slot2)
		end
	end

	return slot2
end

function setNeedLoadModule(slot0, slot1)
	if slot1 and not moduleNameToPath[slot1] then
		moduleNameToPath[slot1] = slot0
	end

	return true
end

gMetaTable = {
	__index = function (slot0, slot1)
		if not moduleNameToTables[slot1] and moduleNameToPath[slot1] then
			if type(require(slot3)) ~= "table" then
				moduleNameToTables[slot1] = true

				error("BootStarter __index, can not find module define, module path = " .. slot3)
			else
				moduleNameToTables[slot1] = slot2

				setGlobal(slot1, slot2)
			end
		end

		return slot2
	end,
	__newindex = function (slot0, slot1, slot2)
		if slot1 ~= "booter" and slot1 ~= "projbooter" and slot1 ~= "framework" and slot1 ~= "modules" and slot1 ~= "protobuf" then
			error("BootStarter gMetaTable.__newindex, can not set _G table value from other module, use setGlobal function instead! key = " .. slot1)
		end
	end
}

setmetatable(_G, gMetaTable)

slot1, slot2 = callWithCatch(function ()
	addGlobalModule("booter.base.cjson")
	addGlobalModule("booter.base.logger")
	addGlobalModule("booter.base.oop")
	addGlobalModule("booter.base.string")
	addGlobalModule("booter.base.tabletool")
	forceLog("SLFramework, lua start!")
	addGlobalModule("booter.LuaResMgr")
	setGlobal("GameConfig", SLFramework.GameConfig.Instance)
	addGlobalModule("projbooter.ProjBooter", "ProjBooter")
end)

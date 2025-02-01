module("modules.logic.common.config.CommonConfig", package.seeall)

slot0 = class("CommonConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"const",
		"cpu_level",
		"gpu_level",
		"toast",
		"messagebox",
		"gm_command",
		"activity155_drop",
		"activity155_const"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "cpu_level" then
		slot0._cpuLevelDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			slot0._cpuLevelDict[slot0:_getStr(slot7.name)] = slot7.level
		end
	elseif slot1 == "gpu_level" then
		slot0._gpuLevelDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			slot0._gpuLevelDict[slot0:_getStr(slot7.name)] = slot7.level
		end
	end
end

function slot0.getCPULevel(slot0, slot1)
	if LuaUtil.isEmptyStr(slot0:_getStr(slot1)) then
		return ModuleEnum.Performance.Undefine
	end

	if slot0._cpuLevelDict[slot1] then
		return slot2
	end

	for slot6, slot7 in pairs(slot0._cpuLevelDict) do
		if string.find(slot6, slot1) or string.find(slot1, slot6) then
			return slot7
		end
	end

	return ModuleEnum.Performance.Undefine
end

function slot0.getGPULevel(slot0, slot1)
	if LuaUtil.isEmptyStr(slot0:_getStr(slot1)) then
		return ModuleEnum.Performance.Undefine
	end

	if slot0._gpuLevelDict[slot1] then
		return slot2
	end

	for slot6, slot7 in pairs(slot0._gpuLevelDict) do
		if string.find(slot6, slot1) or string.find(slot1, slot6) then
			return slot7
		end
	end

	return ModuleEnum.Performance.Undefine
end

function slot0._getStr(slot0, slot1)
	return string.gsub(string.lower(slot1), "%s+", "")
end

function slot0.getConstNum(slot0, slot1)
	if string.nilorempty(slot0:getConstStr(slot1)) then
		return 0
	else
		return tonumber(slot2)
	end
end

function slot0.getConstStr(slot0, slot1)
	if not lua_const.configDict[slot1] then
		printError("const not exist: ", slot1)

		return nil
	end

	if not string.nilorempty(slot2.value) then
		return slot3
	end

	return slot2.value2
end

function slot0.getAct155CurrencyRatio(slot0)
	return string.splitToNumber(lua_activity155_const.configDict[1].value2, "#") and slot2[2] or 0
end

function slot0.getAct155EpisodeDisplay(slot0)
	slot2 = string.splitToNumber(lua_activity155_const.configDict[3].value2, "#")

	return slot2[1], slot2[2]
end

slot0.instance = slot0.New()

return slot0

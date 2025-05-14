module("framework.mvc.ConfigMgr", package.seeall)

local var_0_0 = class("ConfigMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._resPath = "configs/excel2json/json_"
	arg_1_0._luaPath = "modules.configs.excel2json.lua_"
	arg_1_0._abPath = "configs/datacfg_"
	arg_1_0._requestorList = {}
	arg_1_0._configNameList = {}
	arg_1_0._configName2PathDict = {}
	arg_1_0._configList = {}
	arg_1_0._configDict = {}
	arg_1_0._onLoadedCallback = nil
	arg_1_0._onLoadedCallbackObj = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._resPath = arg_2_1
	arg_2_0._luaPath = arg_2_2
	arg_2_0._abPath = arg_2_3
end

function var_0_0.addRequestor(arg_3_0, arg_3_1)
	table.insert(arg_3_0._requestorList, arg_3_1)

	local var_3_0 = arg_3_1:reqConfigNames()
	local var_3_1 = var_3_0 and #var_3_0 or 0

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = var_3_0[iter_3_0]

		if not arg_3_0._configName2PathDict[var_3_2] then
			local var_3_3 = string.format("%s%s.json", arg_3_0._resPath, var_3_2)

			arg_3_0._configName2PathDict[var_3_2] = var_3_3

			table.insert(arg_3_0._configNameList, var_3_2)
		end
	end
end

function var_0_0.loadConfigs(arg_4_0, arg_4_1, arg_4_2)
	if #arg_4_0._configNameList == 0 then
		if arg_4_1 then
			if arg_4_2 then
				arg_4_1(arg_4_2)
			else
				arg_4_1()
			end
		end

		return
	end

	arg_4_0._onLoadedCallback = arg_4_1
	arg_4_0._onLoadedCallbackObj = arg_4_2

	if GameResMgr.IsFromEditorDir then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._configNameList) do
			local var_4_0 = arg_4_0._configName2PathDict[iter_4_1]

			loadNonAbAsset(var_4_0, SLFramework.AssetType.TEXT, arg_4_0._onConfigAbCallback, arg_4_0)
		end

		logNormal("--编辑器Direct运行时，检查对应的json、jua是否有缺")
		arg_4_0:_editorCheckLuaJson()
	else
		logNormal("-- json的ab是 AllToOne ，加载一次，就可以把所有json拿到了（可能会有多余的配置，自觉删除无用配置，否则报错）self._abPath = " .. arg_4_0._abPath)

		arg_4_0._jsonList = {}
		arg_4_0._frameHandleNum = 20
		arg_4_0._nowHandNum = 0
		arg_4_0._allHandNum = 0
		arg_4_0._maxConfigDatNum = 5
		arg_4_0._configDatIndex = 1

		loadNonAbAsset(string.format("%s%s%s", arg_4_0._abPath, arg_4_0._configDatIndex, ".dat"), SLFramework.AssetType.DATA, arg_4_0._onConfigOneAbCallback, arg_4_0)
	end
end

function var_0_0._onConfigOneAbCallback(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetNonAbTextAsset(true)
	local var_5_1 = cjson.decode(var_5_0)

	arg_5_0._allHandNum = arg_5_0._allHandNum + tabletool.len(var_5_1)

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		table.insert(arg_5_0._jsonList, iter_5_1)
	end

	if arg_5_0._configDatIndex == arg_5_0._maxConfigDatNum then
		arg_5_0:_onConfigAllAbCallback()
	else
		arg_5_0._configDatIndex = arg_5_0._configDatIndex + 1

		loadNonAbAsset(string.format("%s%s%s", arg_5_0._abPath, arg_5_0._configDatIndex, ".dat"), SLFramework.AssetType.DATA, arg_5_0._onConfigOneAbCallback, arg_5_0)
	end
end

function var_0_0._onConfigAllAbCallback(arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0._onConfigLoadedRepeat, arg_6_0, 0.01)
end

function var_0_0._onConfigAbCallback(arg_7_0, arg_7_1)
	if not arg_7_1.IsLoadSuccess then
		logError("config load fail: " .. arg_7_1.ResPath)

		return
	end

	if GameResMgr.IsFromEditorDir then
		arg_7_0:_onConfigLoaded(arg_7_1.TextAsset)
	else
		local var_7_0 = arg_7_1:GetNonAbTextAsset(true)
		local var_7_1 = cjson.decode(var_7_0)

		arg_7_0._frameHandleNum = 20
		arg_7_0._nowHandNum = 0
		arg_7_0._allHandNum = tabletool.len(var_7_1)
		arg_7_0._jsonList = {}

		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			table.insert(arg_7_0._jsonList, iter_7_1)
		end

		TaskDispatcher.runRepeat(arg_7_0._onConfigLoadedRepeat, arg_7_0, 0.01)
	end
end

function var_0_0._onConfigLoadedRepeat(arg_8_0)
	for iter_8_0 = 1, arg_8_0._frameHandleNum do
		arg_8_0._nowHandNum = arg_8_0._nowHandNum + 1

		local var_8_0 = arg_8_0._jsonList[arg_8_0._nowHandNum]

		arg_8_0:_onConfigLoaded(var_8_0)

		if arg_8_0._nowHandNum == arg_8_0._allHandNum then
			TaskDispatcher.cancelTask(arg_8_0._onConfigLoadedRepeat, arg_8_0)

			arg_8_0._jsonList = nil

			if not GameResMgr.IsFromEditorDir and #arg_8_0._configList ~= #arg_8_0._configNameList then
				for iter_8_1, iter_8_2 in ipairs(arg_8_0._configNameList) do
					if not arg_8_0._configDict[iter_8_2] then
						logError("config: <" .. iter_8_2 .. "> not exist. You're runnning in AssetBundle mode.")
					end
				end
			end

			break
		end
	end
end

function var_0_0._onConfigLoaded(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:_decodeJsonStr(arg_9_1)
	local var_9_1 = var_9_0[1]
	local var_9_2 = var_9_0[2]

	if not var_9_1 then
		logError("config name not exist: " .. arg_9_1)

		return
	end

	local var_9_3 = addGlobalModule(arg_9_0._luaPath .. var_9_1, var_9_1)

	if not var_9_3 then
		logError("config lua head not exist: <" .. var_9_1 .. ">")

		return
	end

	if not GameResMgr.IsFromEditorDir and isDebugBuild and GameConfig.UseDebugLuaFile then
		local var_9_4 = UnityEngine.Application.persistentDataPath .. string.format("/lua/json_%s.json", var_9_1)
		local var_9_5 = SLFramework.FileHelper.ReadText(var_9_4)

		if not string.nilorempty(var_9_5) then
			logNormal("替换了外部目录的json配置表：" .. var_9_1)

			var_9_2 = arg_9_0:_decodeJsonStr(var_9_5)[2]
		end
	end

	var_9_3.onLoad(var_9_2)

	if not arg_9_0._configDict[var_9_1] then
		if arg_9_0._configName2PathDict[var_9_1] then
			arg_9_0._configDict[var_9_1] = var_9_3

			table.insert(arg_9_0._configList, var_9_3)
		else
			logWarn("config: <" .. var_9_1 .. "> never use, please remove it")
		end
	end

	if #arg_9_0._configList == #arg_9_0._configNameList and not arg_9_0._requestorCbDone then
		arg_9_0._requestorCbDone = true

		for iter_9_0, iter_9_1 in ipairs(arg_9_0._requestorList) do
			local var_9_6 = iter_9_1:reqConfigNames()
			local var_9_7 = var_9_6 and #var_9_6 or 0

			for iter_9_2 = 1, var_9_7 do
				iter_9_1:onConfigLoaded(var_9_6[iter_9_2], arg_9_0._configDict[var_9_6[iter_9_2]])
			end
		end

		if arg_9_0._onLoadedCallback then
			if arg_9_0._onLoadedCallbackObj then
				arg_9_0._onLoadedCallback(arg_9_0._onLoadedCallbackObj)
			else
				arg_9_0._onLoadedCallback()
			end
		end

		arg_9_0._onLoadedCallback = nil
		arg_9_0._onLoadedCallbackObj = nil
	end
end

function var_0_0._decodeJsonStr(arg_10_0, arg_10_1)
	local var_10_0

	if isDebugBuild then
		local var_10_1, var_10_2 = pcall(cjson.decode, arg_10_1)

		if not var_10_1 then
			logError("配置解析失败: " .. arg_10_1)

			return
		end

		var_10_0 = var_10_2
	else
		var_10_0 = cjson.decode(arg_10_1)
	end

	return var_10_0
end

function var_0_0._editorCheckLuaJson(arg_11_0)
	local var_11_0 = SLFramework.FrameworkSettings.ProjLuaRootDir .. "/modules/configs/excel2json/"
	local var_11_1 = SLFramework.FrameworkSettings.AssetRootDir .. "/configs/excel2json/"
	local var_11_2 = SLFramework.FileHelper.GetDirFilePaths(var_11_0)
	local var_11_3 = SLFramework.FileHelper.GetDirFilePaths(var_11_1)
	local var_11_4 = {}
	local var_11_5 = {}

	for iter_11_0 = 0, var_11_2.Length - 1 do
		local var_11_6 = var_11_2[iter_11_0]

		if not string.find(var_11_6, ".meta") and string.find(var_11_6, "lua_") then
			local var_11_7 = SLFramework.FileHelper.GetFileName(var_11_6, false)

			var_11_4[string.sub(var_11_7, 5)] = true
		end
	end

	for iter_11_1 = 0, var_11_3.Length - 1 do
		local var_11_8 = var_11_3[iter_11_1]

		if not string.find(var_11_8, ".meta") and string.find(var_11_8, "json_") then
			local var_11_9 = SLFramework.FileHelper.GetFileName(var_11_8, false)

			var_11_5[string.sub(var_11_9, 6)] = true
		end
	end

	for iter_11_2, iter_11_3 in pairs(var_11_4) do
		if not var_11_5[iter_11_2] then
			logError("config lua_" .. iter_11_2 .. ".lua not match, <color=red><json_" .. iter_11_2 .. ".json>" .. " not exist</color>")
		end
	end

	for iter_11_4, iter_11_5 in pairs(var_11_5) do
		if not var_11_4[iter_11_4] then
			logError("config json_" .. iter_11_4 .. ".json not match, <color=red><lua_" .. iter_11_4 .. ".lua>" .. " not exist</color>")
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

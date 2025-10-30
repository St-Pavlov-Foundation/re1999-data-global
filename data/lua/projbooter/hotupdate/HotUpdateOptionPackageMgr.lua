module("projbooter.hotupdate.HotUpdateOptionPackageMgr", package.seeall)

local var_0_0 = class("HotUpdateOptionPackageMgr")

var_0_0.EnableEditorDebug = false

local var_0_1 = "HotUpdateOptionPackageMgr_OptionPackageNamesKey"

function var_0_0.init(arg_1_0)
	arg_1_0._optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	arg_1_0._optionalUpdateInst:Init()

	arg_1_0._downloader = OptionPackageDownloader.New()
	arg_1_0._httpWorker = OptionPackageHttpWorker.New()
end

function var_0_0.getSupportVoiceLangs(arg_2_0)
	local var_2_0 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local var_2_1 = GameConfig:GetDefaultVoiceShortcut()

	if not tabletool.indexOf(var_2_0, var_2_1) then
		table.insert(var_2_0, 1, var_2_1)
	end

	logNormal("\n语言：" .. var_2_1 .. "\n排序：" .. table.concat(var_2_0, ","))

	return var_2_0
end

function var_0_0.getHotUpdateLangPacks(arg_3_0)
	local var_3_0 = arg_3_0:getPackageNameList()

	if not var_3_0 or #var_3_0 < 1 then
		return nil, nil
	end

	local var_3_1 = {
		"res",
		"media"
	}
	local var_3_2 = arg_3_0:getHotUpdateVoiceLangs()

	tabletool.addValues(var_3_1, var_3_2)

	return (arg_3_0:formatLangPackList(var_3_1, var_3_0))
end

function var_0_0.getHotUpdateVoiceLangs(arg_4_0)
	local var_4_0 = arg_4_0:getSupportVoiceLangs()
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if arg_4_0:isNeedDownloadVoiceLang(iter_4_1) then
			table.insert(var_4_1, 1, iter_4_1)
		end
	end

	return var_4_1
end

function var_0_0.isNeedDownloadVoiceLang(arg_5_0, arg_5_1)
	if HotUpdateVoiceMgr.ForceSelect and HotUpdateVoiceMgr.ForceSelect[arg_5_1] then
		return true
	end

	local var_5_0 = arg_5_0._optionalUpdateInst:GetLocalVersion(arg_5_1)

	if not string.nilorempty(var_5_0) then
		return true
	end

	if GameConfig:GetDefaultVoiceShortcut() == arg_5_1 then
		return true
	end

	return false
end

function var_0_0.getPackageNameList(arg_6_0)
	local var_6_0 = UnityEngine.PlayerPrefs.GetString(var_0_1, "")

	if not string.nilorempty(var_6_0) then
		return string.split(var_6_0, "#")
	end

	return {}
end

function var_0_0.savePackageNameList(arg_7_0, arg_7_1)
	local var_7_0 = ""

	if arg_7_1 and #arg_7_1 > 0 then
		var_7_0 = table.concat(arg_7_1, "#")
	end

	UnityEngine.PlayerPrefs.SetString(var_0_1, var_7_0)
	UnityEngine.PlayerPrefs.Save()
end

function var_0_0.showDownload(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_3 and arg_8_3:getHttpGetterList()

	if not var_8_0 or #var_8_0 < 1 then
		arg_8_1(arg_8_2)

		return
	end

	arg_8_0._adppter = arg_8_3

	arg_8_0._adppter:setDownloder(arg_8_0._downloader, arg_8_0)

	if VersionValidator.instance:isInReviewing() then
		arg_8_1(arg_8_2)
	elseif GameResMgr.IsFromEditorDir and not var_0_0.EnableEditorDebug then
		arg_8_1(arg_8_2)
	else
		arg_8_0._httpWorker:start(var_8_0, arg_8_1, arg_8_2)
	end
end

function var_0_0.startDownload(arg_9_0, arg_9_1, arg_9_2)
	if VersionValidator.instance:isInReviewing() and not var_0_0.EnableEditorDebug then
		arg_9_1(arg_9_2)
	elseif GameResMgr.IsFromEditorDir and not var_0_0.EnableEditorDebug then
		arg_9_1(arg_9_2)
	elseif BootNativeUtil.isIOS() and HotUpdateMgr.instance:hasHotUpdate() then
		logNormal("热更新紧接着语音更新，延迟开始")
		Timer.New(function()
			logNormal("独立资源包更新开始")
			arg_9_0._downloader:start(arg_9_0:getHttpResult(), arg_9_1, arg_9_2, arg_9_0._adppter)
		end, 1.5):Start()
	else
		arg_9_0._downloader:start(arg_9_0:getHttpResult(), arg_9_1, arg_9_2, arg_9_0._adppter)
	end
end

function var_0_0.getHttpResult(arg_11_0)
	return arg_11_0._httpWorker:getHttpResult()
end

function var_0_0.getNeedDownloadSize(arg_12_0)
	local var_12_0 = arg_12_0:getHttpResult()

	if not var_12_0 then
		return 0
	end

	local var_12_1 = 0

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		local var_12_2 = iter_12_1.res

		if var_12_2 then
			local var_12_3 = {}
			local var_12_4 = {}
			local var_12_5 = {}
			local var_12_6 = {}

			for iter_12_2, iter_12_3 in ipairs(var_12_2) do
				table.insert(var_12_3, iter_12_3.name)
				table.insert(var_12_4, iter_12_3.hash)
				table.insert(var_12_5, iter_12_3.order)
				table.insert(var_12_6, iter_12_3.length)

				var_12_1 = var_12_1 + iter_12_3.length
			end

			arg_12_0._optionalUpdateInst:InitBreakPointInfo(var_12_3, var_12_4, var_12_5, var_12_6)

			local var_12_7 = arg_12_0._optionalUpdateInst:GetRecvSize()

			var_12_1 = var_12_1 - tonumber(var_12_7)
		end
	end

	return var_12_1
end

function var_0_0.getTotalSize(arg_13_0)
	local var_13_0 = arg_13_0:getHttpResult()

	if not var_13_0 then
		return 0
	end

	local var_13_1 = 0

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_2 = iter_13_1.res

		if var_13_2 then
			local var_13_3 = {}
			local var_13_4 = {}
			local var_13_5 = {}
			local var_13_6 = {}

			for iter_13_2, iter_13_3 in ipairs(var_13_2) do
				table.insert(var_13_3, iter_13_3.name)
				table.insert(var_13_4, iter_13_3.hash)
				table.insert(var_13_5, iter_13_3.order)
				table.insert(var_13_6, iter_13_3.length)

				var_13_1 = var_13_1 + iter_13_3.length
			end
		end
	end

	return var_13_1
end

function var_0_0.formatLangPackList(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	if not arg_14_2 or #arg_14_2 < 1 then
		tabletool.addValues(var_14_0, arg_14_1)

		return var_14_0
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
		for iter_14_2, iter_14_3 in ipairs(arg_14_1) do
			table.insert(var_14_0, arg_14_0:formatLangPackName(iter_14_3, iter_14_1))
		end
	end

	return var_14_0
end

function var_0_0.formatLangPackName(arg_15_0, arg_15_1, arg_15_2)
	if string.nilorempty(arg_15_2) then
		return arg_15_1
	end

	return string.format("%s-%s", arg_15_1, arg_15_2)
end

function var_0_0.stop(arg_16_0)
	arg_16_0._downloader:cancelDownload()
end

var_0_0.instance = var_0_0.New()

return var_0_0

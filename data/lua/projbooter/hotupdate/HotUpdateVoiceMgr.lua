module("projbooter.hotupdate.HotUpdateVoiceMgr", package.seeall)

local var_0_0 = class("HotUpdateVoiceMgr")

var_0_0.EnableEditorDebug = false

local var_0_1 = 50001

var_0_0.IsGuoFu = false
var_0_0.LangEn = "en"
var_0_0.LangZh = "zh"
var_0_0.HD = "res-HD"
var_0_0.LangSortOrderDefault = {
	jp = 3,
	kr = 4,
	zh = 2,
	en = 1
}
var_0_0.LangSortOrderDict = {
	en = {
		jp = 2,
		kr = 4,
		zh = 3,
		en = 1
	},
	tw = {
		jp = 2,
		kr = 4,
		zh = 3,
		en = 1
	},
	jp = {
		jp = 1,
		kr = 4,
		zh = 3,
		en = 2
	},
	kr = {
		kr = 1,
		jp = 4,
		zh = 3,
		en = 2
	}
}
var_0_0.ForceSelect = {
	[var_0_0.LangEn] = true,
	[var_0_0.LangZh] = true
}

function var_0_0.init(arg_1_0)
	arg_1_0._optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	arg_1_0._optionalUpdateInst:Init()

	arg_1_0._httpGetter = VoiceHttpGetter.New()
	arg_1_0._downloader = VoiceDownloader.New()
	var_0_0.IsGuoFu = tonumber(SDKMgr.instance:getGameId()) == var_0_1

	if not var_0_0.IsGuoFu then
		var_0_0.ForceSelect = {}
	end

	if BootNativeUtil.isWindows() then
		var_0_0.ForceSelect[var_0_0.HD] = true
	end
end

local var_0_2
local var_0_3
local var_0_4 = {}

function var_0_0.getSupportVoiceLangs(arg_2_0)
	local var_2_0 = GameConfig:GetSupportedVoiceShortcuts()
	local var_2_1 = var_2_0.Length
	local var_2_2 = {}
	local var_2_3 = GameConfig:GetDefaultLangShortcut()

	var_0_2 = GameConfig:GetDefaultVoiceShortcut()
	var_0_3 = var_0_0.LangSortOrderDict[var_2_3] or var_0_0.LangSortOrderDefault

	for iter_2_0 = 0, var_2_1 - 1 do
		local var_2_4 = var_2_0[iter_2_0]

		table.insert(var_2_2, var_2_4)

		var_0_4[var_2_4] = iter_2_0 + 1
	end

	table.sort(var_2_2, var_0_0._sortLang)

	local var_2_5

	return var_2_2
end

function var_0_0._sortLang(arg_3_0, arg_3_1)
	if arg_3_0 == var_0_2 then
		return true
	elseif arg_3_1 == var_0_2 then
		return false
	else
		local var_3_0 = var_0_3[arg_3_0] or 999
		local var_3_1 = var_0_3[arg_3_1] or 999

		if var_3_0 ~= var_3_1 then
			return var_3_0 < var_3_1
		end

		return var_0_4[arg_3_0] < var_0_4[arg_3_1]
	end
end

function var_0_0.showDownload(arg_4_0, arg_4_1, arg_4_2)
	if VersionValidator.instance:isInReviewing() then
		arg_4_1(arg_4_2)
	elseif GameResMgr.IsFromEditorDir and not var_0_0.EnableEditorDebug then
		arg_4_1(arg_4_2)
	else
		arg_4_0._httpGetter:start(arg_4_1, arg_4_2)
	end
end

function var_0_0.startDownload(arg_5_0, arg_5_1, arg_5_2)
	if VersionValidator.instance:isInReviewing() then
		arg_5_1(arg_5_2)
	elseif GameResMgr.IsFromEditorDir and not var_0_0.EnableEditorDebug then
		arg_5_1(arg_5_2)
	elseif BootNativeUtil.isIOS() and HotUpdateMgr.instance:hasHotUpdate() then
		logNormal("热更新紧接着语音更新，延迟开始")
		Timer.New(function()
			logNormal("语音更新开始")
			arg_5_0._downloader:start(arg_5_1, arg_5_2)
		end, 1.5):Start()
	else
		arg_5_0._downloader:start(arg_5_1, arg_5_2)
	end
end

function var_0_0.getHttpResult(arg_7_0)
	return arg_7_0._httpGetter:getHttpResult()
end

function var_0_0.getLangSize(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getHttpResult()

	if not var_8_0 then
		return 0
	end

	local var_8_1 = var_8_0[arg_8_1]

	if not var_8_1 or not var_8_1.res then
		return 0
	end

	local var_8_2 = 0

	for iter_8_0, iter_8_1 in ipairs(var_8_1.res) do
		var_8_2 = var_8_2 + iter_8_1.length
	end

	return var_8_2
end

function var_0_0.getTotalSize(arg_9_0)
	local var_9_0 = arg_9_0:getHttpResult()

	if not var_9_0 then
		return 0
	end

	local var_9_1 = BootVoiceView.instance:isFirstDownloadDone()
	local var_9_2 = 0
	local var_9_3 = BootVoiceView.instance:getDownloadChoices()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		local var_9_4 = false

		if var_9_1 then
			local var_9_5 = arg_9_0._optionalUpdateInst:GetLocalVersion(iter_9_0)

			var_9_4 = not string.nilorempty(var_9_5)
		else
			var_9_4 = tabletool.indexOf(var_9_3, iter_9_0)
		end

		if iter_9_1.res and var_9_4 then
			for iter_9_2, iter_9_3 in ipairs(iter_9_1.res) do
				var_9_2 = var_9_2 + iter_9_3.length
			end
		end
	end

	return var_9_2
end

function var_0_0.getNeedDownloadSize(arg_10_0)
	local var_10_0 = arg_10_0:getHttpResult()

	if not var_10_0 then
		return 0
	end

	local var_10_1 = arg_10_0:getTotalSize()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_2 = arg_10_0:getDownloadList(iter_10_0)

		if var_10_2 then
			local var_10_3 = {}
			local var_10_4 = {}
			local var_10_5 = {}
			local var_10_6 = {}

			for iter_10_2, iter_10_3 in ipairs(var_10_2) do
				table.insert(var_10_3, iter_10_3.name)
				table.insert(var_10_4, iter_10_3.hash)
				table.insert(var_10_5, iter_10_3.order)
				table.insert(var_10_6, iter_10_3.length)
			end

			arg_10_0._optionalUpdateInst:InitBreakPointInfo(var_10_3, var_10_4, var_10_5, var_10_6)

			local var_10_7 = arg_10_0._optionalUpdateInst:GetRecvSize()

			var_10_1 = var_10_1 - tonumber(var_10_7)
		end
	end

	return var_10_1
end

function var_0_0.getDownloadUrl(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getHttpResult()

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0[arg_11_1]

	if var_11_1 then
		return var_11_1.download_url, var_11_1.download_url_bak
	end
end

function var_0_0.getDownloadList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getHttpResult()

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0[arg_12_1]

	if #var_12_1.res > 0 then
		local var_12_2 = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_1.res) do
			local var_12_3 = {
				latest_ver = var_12_1.latest_ver,
				name = iter_12_1.name,
				hash = iter_12_1.hash,
				order = iter_12_1.order,
				length = iter_12_1.length
			}

			table.insert(var_12_2, var_12_3)
		end

		table.sort(var_12_2, var_0_0._sortByOrder)

		return var_12_2
	end
end

function var_0_0.stop(arg_13_0)
	arg_13_0._downloader:cancelDownload()
end

function var_0_0.getAllLangDownloadList(arg_14_0)
	local var_14_0 = BootVoiceView.instance:isFirstDownloadDone()
	local var_14_1 = BootVoiceView.instance:getDownloadChoices()
	local var_14_2 = arg_14_0:getHttpResult()

	if not var_14_2 then
		return {}
	end

	local var_14_3 = {}
	local var_14_4 = GameConfig:GetCurVoiceShortcut()

	for iter_14_0, iter_14_1 in pairs(var_14_2) do
		local var_14_5 = false

		if var_14_0 then
			local var_14_6 = arg_14_0._optionalUpdateInst:GetLocalVersion(iter_14_0)

			var_14_5 = not string.nilorempty(var_14_6) or var_14_4 == iter_14_0
		else
			var_14_5 = tabletool.indexOf(var_14_1, iter_14_0)
		end

		if #iter_14_1.res > 0 and var_14_5 then
			local var_14_7 = {}

			for iter_14_2, iter_14_3 in ipairs(iter_14_1.res) do
				local var_14_8 = {
					latest_ver = iter_14_1.latest_ver,
					name = iter_14_3.name,
					hash = iter_14_3.hash,
					order = iter_14_3.order,
					length = iter_14_3.length
				}

				table.insert(var_14_7, var_14_8)
			end

			table.sort(var_14_7, var_0_0._sortByOrder)

			var_14_3[iter_14_0] = var_14_7
		end
	end

	return var_14_3
end

function var_0_0._sortByOrder(arg_15_0, arg_15_1)
	return arg_15_0.order < arg_15_1.order
end

var_0_0.instance = var_0_0.New()

return var_0_0

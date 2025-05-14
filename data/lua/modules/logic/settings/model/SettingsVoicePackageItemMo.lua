module("modules.logic.settings.model.SettingsVoicePackageItemMo", package.seeall)

local var_0_0 = pureTable("SettingsVoicePackageItemMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.size = 0
	arg_1_0.localSize = 0
	arg_1_0.lang = ""
	arg_1_0.nameLangId = ""
	arg_1_0.localVersion = 0
	arg_1_0.latestVersion = 0
	arg_1_0.download_url = ""
	arg_1_0.download_url_bak = ""
	arg_1_0.downloadResList = {
		names = {},
		hashs = {},
		orders = {},
		lengths = {}
	}
end

function var_0_0.setLang(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.lang = arg_2_1
	arg_2_0.nameLangId = "langtype_" .. arg_2_1
	arg_2_0.localVersion = arg_2_2
end

function var_0_0.setLangInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.latest_ver

	var_3_0 = var_3_0 and (string.splitToNumber(var_3_0, ".")[2] or 0)
	arg_3_0.latestVersion = var_3_0 or 0
	arg_3_0.download_url = arg_3_1.download_url
	arg_3_0.download_url_bak = arg_3_1.download_url_bak

	if arg_3_1.res then
		local var_3_1 = 0
		local var_3_2 = {}
		local var_3_3 = {}
		local var_3_4 = {}
		local var_3_5 = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_1.res) do
			table.insert(var_3_2, iter_3_1.name)
			table.insert(var_3_3, iter_3_1.hash)
			table.insert(var_3_4, iter_3_1.order)
			table.insert(var_3_5, iter_3_1.length)

			var_3_1 = var_3_1 + iter_3_1.length
		end

		arg_3_0.downloadResList.names = var_3_2
		arg_3_0.downloadResList.hashs = var_3_3
		arg_3_0.downloadResList.orders = var_3_4
		arg_3_0.downloadResList.lengths = var_3_5
		arg_3_0.size = var_3_1
	end
end

function var_0_0.setLocalSize(arg_4_0, arg_4_1)
	arg_4_0.localSize = arg_4_1
end

function var_0_0.getStatus(arg_5_0)
	if GameResMgr.IsFromEditorDir then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if arg_5_0.lang == GameConfig:GetDefaultVoiceShortcut() then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if arg_5_0.localVersion and arg_5_0.localVersion > 0 then
		return SettingsVoicePackageController.AlreadyLatest
	end

	return SettingsVoicePackageController.instance:getPackItemState(arg_5_0.lang, arg_5_0.latestVersion)
end

function var_0_0.hasLocalFile(arg_6_0)
	if arg_6_0.lang == GameConfig:GetDefaultVoiceShortcut() then
		return SettingsVoicePackageController.AlreadyLatest
	end

	if arg_6_0.localVersion and arg_6_0.localVersion > 0 then
		return SettingsVoicePackageController.AlreadyLatest
	end

	return false
end

function var_0_0.needDownload(arg_7_0)
	if GameResMgr.IsFromEditorDir then
		return false
	end

	if arg_7_0.lang == GameConfig:GetDefaultVoiceShortcut() then
		return false
	end

	if arg_7_0.localVersion and arg_7_0.localVersion > 0 then
		return false
	end

	return arg_7_0:getStatus() ~= SettingsVoicePackageController.AlreadyLatest
end

function var_0_0.getLeftSizeMBorGB(arg_8_0)
	local var_8_0 = math.max(0, arg_8_0.size - arg_8_0.localSize)
	local var_8_1 = 1073741824
	local var_8_2 = var_8_0 / var_8_1
	local var_8_3 = "GB"

	if var_8_2 < 0.1 then
		var_8_1 = 1048576
		var_8_2 = var_8_0 / var_8_1
		var_8_3 = "MB"

		if var_8_2 < 0.01 then
			var_8_2 = 0.01
		end
	end

	return var_8_2, math.max(0.01, arg_8_0.size / var_8_1), var_8_3
end

function var_0_0.getLeftSizeMBNum(arg_9_0)
	local var_9_0 = math.max(0, arg_9_0.size - arg_9_0.localSize) / 1048576

	if var_9_0 < 0.01 then
		var_9_0 = 0.01
	end

	return var_9_0
end

function var_0_0.isCurVoice(arg_10_0)
	return arg_10_0.lang == GameConfig:GetCurVoiceShortcut()
end

return var_0_0

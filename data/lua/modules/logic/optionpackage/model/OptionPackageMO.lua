module("modules.logic.optionpackage.model.OptionPackageMO", package.seeall)

local var_0_0 = pureTable("OptionPackageMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.packeName = arg_1_1 or ""
	arg_1_0.lang = arg_1_2 or ""
	arg_1_0.id = OptionPackageHelper.formatLangPackName(arg_1_0.lang, arg_1_0.packeName)
	arg_1_0.langPack = OptionPackageHelper.formatLangPackName(arg_1_0.lang, arg_1_0.packeName)
	arg_1_0.nameLangId = "langtype_" .. arg_1_0.lang
	arg_1_0.size = 0
	arg_1_0.localSize = 0
	arg_1_0.localVersion = 0
	arg_1_0.latestVersion = 0
	arg_1_0.download_url = ""
	arg_1_0.download_url_bak = ""
	arg_1_0.download_res = {}
	arg_1_0.downloadResList = {
		names = {},
		hashs = {},
		orders = {},
		lengths = {}
	}
	arg_1_0._landPackInfo = nil
end

function var_0_0.setLocalVersion(arg_2_0, arg_2_1)
	arg_2_0.localVersion = arg_2_1
end

function var_0_0.setPackInfo(arg_3_0, arg_3_1)
	arg_3_0._landPackInfo = arg_3_1

	local var_3_0 = arg_3_1.latest_ver

	var_3_0 = var_3_0 and (string.splitToNumber(var_3_0, ".")[2] or 0)
	arg_3_0.latestVersion = var_3_0 or 0
	arg_3_0.download_url = arg_3_1.download_url
	arg_3_0.download_url_bak = arg_3_1.download_url_bak
	arg_3_0.download_res = {}

	tabletool.addValues(arg_3_0.download_res, arg_3_1.res)

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

function var_0_0.getPackInfo(arg_4_0)
	return arg_4_0._landPackInfo
end

function var_0_0.setLocalSize(arg_5_0, arg_5_1)
	arg_5_0.localSize = arg_5_1
end

function var_0_0.isNeedDownload(arg_6_0)
	return arg_6_0:getStatus() ~= OptionPackageEnum.UpdateState.AlreadyLatest
end

function var_0_0.getStatus(arg_7_0)
	if arg_7_0.latestVersion <= 0 then
		return OptionPackageEnum.UpdateState.NotDownload
	end

	if arg_7_0.localVersion >= arg_7_0.latestVersion or not arg_7_0.download_res or #arg_7_0.download_res < 1 then
		return OptionPackageEnum.UpdateState.AlreadyLatest
	end

	return OptionPackageController.instance:getPackItemState(arg_7_0.id, arg_7_0.latestVersion)
end

function var_0_0.hasLocalVersion(arg_8_0)
	if arg_8_0.localVersion and arg_8_0.localVersion > 0 then
		return true
	end

	return false
end

return var_0_0

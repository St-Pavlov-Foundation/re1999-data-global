module("modules.logic.optionpackage.model.OptionPackageSetMO", package.seeall)

local var_0_0 = pureTable("OptionPackageSetMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1 or ""
	arg_1_0.packName = arg_1_1 or ""
	arg_1_0._packMOModel = arg_1_3
	arg_1_0._lang2IdDict = {}
	arg_1_0._needDownloadLangs = {}
	arg_1_0._neddDownLoadDict = {}
	arg_1_0._allPackLangs = {}

	tabletool.addValues(arg_1_0._needDownloadLangs, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(arg_1_0._allPackLangs, OptionPackageEnum.NeedPackLangList)
	tabletool.addValues(arg_1_0._allPackLangs, arg_1_2)

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._allPackLangs) do
		arg_1_0._lang2IdDict[iter_1_1] = OptionPackageHelper.formatLangPackName(iter_1_1, arg_1_0.packName)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_0._needDownloadLangs) do
		arg_1_0._neddDownLoadDict[iter_1_3] = true
	end
end

function var_0_0.getPackageMO(arg_2_0, arg_2_1)
	if arg_2_0._packMOModel and arg_2_0._lang2IdDict[arg_2_1] then
		return arg_2_0._packMOModel:getById(arg_2_0._lang2IdDict[arg_2_1])
	end
end

function var_0_0.hasLocalVersion(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._allPackLangs) do
		local var_3_0 = arg_3_0:getPackageMO(iter_3_1)

		if var_3_0 and var_3_0:hasLocalVersion() then
			return true
		end
	end

	return false
end

function var_0_0.getDownloadSize(arg_4_0, arg_4_1)
	local var_4_0 = 0
	local var_4_1 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if not arg_4_0._neddDownLoadDict[iter_4_1] then
			local var_4_2 = arg_4_0:getPackageMO(iter_4_1)

			if var_4_2 then
				var_4_0 = var_4_0 + var_4_2.size
				var_4_1 = var_4_1 + var_4_2.localSize
			end
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._needDownloadLangs) do
		local var_4_3 = arg_4_0:getPackageMO(iter_4_3)

		if var_4_3 then
			var_4_0 = var_4_0 + var_4_3.size
			var_4_1 = var_4_1 + var_4_3.localSize
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.isNeedDownload(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._needDownloadLangs) do
		if arg_5_0:_checkDownloadLang(iter_5_1) then
			return true
		end
	end

	if arg_5_1 and #arg_5_1 > 0 then
		for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
			if arg_5_0:_checkDownloadLang(iter_5_3) then
				return true
			end
		end
	end

	return false
end

function var_0_0.getDownloadInfoListTb(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._needDownloadLangs) do
		arg_6_0:_getDownloadInfoTb(iter_6_1, var_6_0)
	end

	if arg_6_1 and #arg_6_1 > 0 then
		for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
			if not arg_6_0._neddDownLoadDict[iter_6_3] then
				arg_6_0:_getDownloadInfoTb(iter_6_3, var_6_0)
			end
		end
	end

	return var_6_0
end

function var_0_0._checkDownloadLang(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getPackageMO(arg_7_1)

	if var_7_0 and var_7_0:isNeedDownload() then
		return true
	end

	return false
end

function var_0_0._getDownloadInfoTb(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or {}

	local var_8_0 = arg_8_0:getPackageMO(arg_8_1)

	if var_8_0 and var_8_0:isNeedDownload() then
		local var_8_1 = var_8_0:getPackInfo()

		if var_8_1 then
			arg_8_2[var_8_0.langPack] = var_8_1
		end
	end

	return arg_8_2
end

return var_0_0

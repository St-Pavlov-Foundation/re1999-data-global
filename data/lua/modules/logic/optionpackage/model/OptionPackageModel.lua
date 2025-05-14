module("modules.logic.optionpackage.model.OptionPackageModel", package.seeall)

local var_0_0 = class("OptionPackageModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0._setMOModel = BaseModel.New()
	arg_1_0._packMOModel = BaseModel.New()
	arg_1_0._initialized = false
	arg_1_0._voiceLangsDict = {}

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onInit(arg_2_0)
	if not HotUpdateVoiceMgr then
		return
	end

	arg_2_0._initialized = true

	local var_2_0 = OptionPackageEnum.PackageNameList or {}
	local var_2_1 = arg_2_0:getSupportVoiceLangs()
	local var_2_2 = HotUpdateVoiceMgr.ForceSelect or {}
	local var_2_3 = GameConfig:GetDefaultVoiceShortcut()

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_4 = {}

		arg_2_0._voiceLangsDict[iter_2_1] = var_2_4

		table.insert(var_2_4, iter_2_1)

		for iter_2_2, iter_2_3 in pairs(var_2_2) do
			if not tabletool.indexOf(var_2_4, iter_2_2) then
				table.insert(var_2_4, iter_2_2)
			end
		end

		if not tabletool.indexOf(var_2_4, var_2_3) then
			table.insert(var_2_4, var_2_3)
		end
	end

	local var_2_5 = {}

	for iter_2_4, iter_2_5 in ipairs(var_2_0) do
		local var_2_6 = OptionPackageSetMO.New()

		var_2_6:init(iter_2_5, var_2_1, arg_2_0._packMOModel)
		table.insert(var_2_5, var_2_6)
	end

	local var_2_7 = {}

	arg_2_0._setMOModel:setList(var_2_5)
	arg_2_0._packMOModel:setList(var_2_7)
end

function var_0_0.getSupportVoiceLangs(arg_3_0)
	if not arg_3_0._supportVoiceLangList then
		arg_3_0._supportVoiceLangList = {}

		local var_3_0 = HotUpdateVoiceMgr and HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

		tabletool.addValues(arg_3_0._supportVoiceLangList, var_3_0)
	end

	return arg_3_0._supportVoiceLangList
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._localPackSetNameList = nil
end

function var_0_0.setOpenInfo(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		local var_5_0 = arg_5_0:getPackageMO(iter_5_0)

		if var_5_0 then
			var_5_0:setLangInfo(iter_5_1)
		end
	end
end

function var_0_0.getPackageMO(arg_6_0, arg_6_1)
	return arg_6_0._packMOModel:getById(arg_6_1)
end

function var_0_0.getPackageMOList(arg_7_0)
	return arg_7_0._packMOModel:getList()
end

function var_0_0.addPackageMO(arg_8_0, arg_8_1)
	arg_8_0._packMOModel:addAtLast(arg_8_1)
end

function var_0_0.addPackageMOList(arg_9_0, arg_9_1)
	arg_9_0._packMOModel:addList(arg_9_1)
end

function var_0_0.getPackageSetMO(arg_10_0, arg_10_1)
	return arg_10_0._setMOModel:getById(arg_10_1)
end

function var_0_0.getPackageSetMOList(arg_11_0)
	return arg_11_0._setMOModel:getList()
end

function var_0_0.setDownloadProgress(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:getPackageMO(arg_12_1)

	if var_12_0 then
		var_12_0:setLocalSize(arg_12_2)
	end
end

function var_0_0.updateLocalVersion(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getPackageMO(arg_13_1)

	if var_13_0 then
		local var_13_1 = OptionPackageController.instance:getLocalVersionInt(arg_13_1)

		var_13_0:setLocalVersion(var_13_1)
	end
end

function var_0_0.onDownloadSucc(arg_14_0, arg_14_1)
	arg_14_0:updateLocalVersion(arg_14_1)
end

function var_0_0.onDeleteVoicePack(arg_15_0, arg_15_1)
	arg_15_0:updateLocalVersion(arg_15_1)
end

function var_0_0.getNeedVoiceLangList(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or GameConfig:GetCurVoiceShortcut()

	return arg_16_0._voiceLangsDict[arg_16_1]
end

function var_0_0.addLocalPackSetName(arg_17_0, arg_17_1)
	if not arg_17_0._initialized then
		return
	end

	if not OptionPackageEnum.HasPackageNameDict[arg_17_1] then
		return
	end

	local var_17_0 = HotUpdateOptionPackageMgr.instance:getPackageNameList()

	if not tabletool.indexOf(var_17_0, arg_17_1) then
		table.insert(var_17_0, arg_17_1)
		HotUpdateOptionPackageMgr.instance:savePackageNameList(var_17_0)
	end
end

function var_0_0.saveLocalPackSetName(arg_18_0)
	if not arg_18_0._initialized then
		return
	end

	local var_18_0 = arg_18_0:_getLocalSetNameList()
	local var_18_1 = arg_18_0:getPackageSetMOList()

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = iter_18_1.packName

		if iter_18_1:hasLocalVersion() and not tabletool.indexOf(var_18_0, var_18_2) then
			table.insert(var_18_0, var_18_2)
		end
	end

	HotUpdateOptionPackageMgr.instance:savePackageNameList(var_18_0)
end

function var_0_0._getLocalSetNameList(arg_19_0)
	if not arg_19_0._localPackSetNameList then
		arg_19_0._localPackSetNameList = HotUpdateOptionPackageMgr.instance:getPackageNameList() or {}
	end

	return arg_19_0._localPackSetNameList
end

var_0_0.instance = var_0_0.New()

return var_0_0

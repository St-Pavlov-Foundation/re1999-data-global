module("modules.logic.settings.model.SettingsVoicePackageModel", package.seeall)

local var_0_0 = class("SettingsVoicePackageModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	if not HotUpdateVoiceMgr then
		return
	end

	local var_1_0 = {}

	arg_1_0._packInfoDic = {}

	local var_1_1 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	table.insert(var_1_1, "res-HD")

	local var_1_2 = GameConfig:GetDefaultVoiceShortcut()

	for iter_1_0 = 1, #var_1_1 do
		local var_1_3 = var_1_1[iter_1_0]
		local var_1_4 = SettingsVoicePackageController.instance:getLocalVersionInt(var_1_3)
		local var_1_5 = SettingsVoicePackageItemMo.New()

		var_1_5:setLang(var_1_3, var_1_4)

		if var_1_3 == var_1_2 then
			table.insert(var_1_0, 1, var_1_5)
		else
			table.insert(var_1_0, var_1_5)
		end

		arg_1_0._packInfoDic[var_1_5.lang] = var_1_5
	end

	SettingsVoicePackageListModel.instance:setList(var_1_0)
end

function var_0_0.getPackInfo(arg_2_0, arg_2_1)
	return arg_2_0._packInfoDic[arg_2_1]
end

function var_0_0.getPackLangName(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getPackInfo(arg_3_1)

	if var_3_0 then
		return luaLang(var_3_0.nameLangId)
	else
		return ""
	end
end

function var_0_0.setDownloadProgress(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0:getPackInfo(arg_4_1)

	if var_4_0 then
		var_4_0:setLocalSize(arg_4_2)
	end
end

function var_0_0.onDownloadSucc(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getPackInfo(arg_5_1)

	if var_5_0 then
		local var_5_1 = SettingsVoicePackageController.instance:getLocalVersionInt(arg_5_1)

		var_5_0:setLang(arg_5_1, var_5_1)
	end
end

function var_0_0.onDeleteVoicePack(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getPackInfo(arg_6_1)

	if var_6_0 then
		local var_6_1 = SettingsVoicePackageController.instance:getLocalVersionInt(arg_6_1)

		var_6_0:setLang(arg_6_1, var_6_1)
	end
end

function var_0_0.getLocalVoiceTypeList(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._packInfoDic) do
		if iter_7_1:hasLocalFile() then
			table.insert(var_7_0, iter_7_0)
		end
	end

	return var_7_0
end

var_0_0.instance = var_0_0.New()

return var_0_0

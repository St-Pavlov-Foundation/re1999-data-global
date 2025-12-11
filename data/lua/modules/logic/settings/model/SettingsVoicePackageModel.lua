module("modules.logic.settings.model.SettingsVoicePackageModel", package.seeall)

local var_0_0 = class("SettingsVoicePackageModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	if not HotUpdateVoiceMgr then
		return
	end

	arg_1_0:updateVoiceList(true)
end

function var_0_0.updateVoiceList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	arg_2_0._packInfoDic = {}

	local var_2_1 = arg_2_0:getSupportVoiceLangs(arg_2_1)

	table.insert(var_2_1, "res-HD")

	local var_2_2 = GameConfig:GetDefaultVoiceShortcut()

	for iter_2_0 = 1, #var_2_1 do
		local var_2_3 = var_2_1[iter_2_0]
		local var_2_4 = SettingsVoicePackageController.instance:getLocalVersionInt(var_2_3)
		local var_2_5 = SettingsVoicePackageItemMo.New()

		var_2_5:setLang(var_2_3, var_2_4)

		if var_2_3 == var_2_2 then
			table.insert(var_2_0, 1, var_2_5)
		else
			table.insert(var_2_0, var_2_5)
		end

		arg_2_0._packInfoDic[var_2_5.lang] = var_2_5
	end

	SettingsVoicePackageListModel.instance:setList(var_2_0)
end

function var_0_0.getSupportVoiceLangs(arg_3_0, arg_3_1)
	local var_3_0 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local var_3_1 = false

	if not arg_3_1 and LangSettings.instance:isOverseas() == false then
		local var_3_2 = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.S01SpRole), "#")

		for iter_3_0, iter_3_1 in ipairs(var_3_2) do
			if HeroModel.instance:getByHeroId(iter_3_1) then
				var_3_1 = true

				break
			end
		end
	end

	if var_3_1 then
		if not tabletool.indexOf(var_3_0, LangSettings.shortcutTab[LangSettings.jp]) then
			table.insert(var_3_0, LangSettings.shortcutTab[LangSettings.jp])
		end

		if not tabletool.indexOf(var_3_0, LangSettings.shortcutTab[LangSettings.kr]) then
			table.insert(var_3_0, LangSettings.shortcutTab[LangSettings.kr])
		end
	end

	return var_3_0
end

function var_0_0.getPackInfo(arg_4_0, arg_4_1)
	return arg_4_0._packInfoDic[arg_4_1]
end

function var_0_0.getPackLangName(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getPackInfo(arg_5_1)

	if var_5_0 then
		return luaLang(var_5_0.nameLangId)
	else
		return ""
	end
end

function var_0_0.setDownloadProgress(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:getPackInfo(arg_6_1)

	if var_6_0 then
		var_6_0:setLocalSize(arg_6_2)
	end
end

function var_0_0.onDownloadSucc(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getPackInfo(arg_7_1)

	if var_7_0 then
		local var_7_1 = SettingsVoicePackageController.instance:getLocalVersionInt(arg_7_1)

		var_7_0:setLang(arg_7_1, var_7_1)
	end
end

function var_0_0.onDeleteVoicePack(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getPackInfo(arg_8_1)

	if var_8_0 then
		local var_8_1 = SettingsVoicePackageController.instance:getLocalVersionInt(arg_8_1)

		var_8_0:setLang(arg_8_1, var_8_1)
	end
end

function var_0_0.getLocalVoiceTypeList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0._packInfoDic) do
		if iter_9_1:hasLocalFile() then
			table.insert(var_9_0, iter_9_0)
		end
	end

	return var_9_0
end

function var_0_0.clearNeedDownloadSize(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getPackInfo(arg_10_1)

	if var_10_0 then
		var_10_0:setLocalSize(0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

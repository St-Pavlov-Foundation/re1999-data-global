module("modules.logic.settings.model.SettingsRoleVoiceModel", package.seeall)

local var_0_0 = class("SettingsRoleVoiceModel", BaseModel)

function var_0_0._getValidLangStr(arg_1_0, arg_1_1)
	local var_1_0 = GameConfig:GetCurVoiceShortcut()
	local var_1_1 = SettingsVoicePackageModel.instance:getPackInfo(arg_1_1)
	local var_1_2 = false

	if var_1_1 and not var_1_1:needDownload() then
		var_1_2 = true
	end

	local var_1_3 = var_1_2 and arg_1_1 or var_1_0

	return LangSettings.shortCut2LangIdxTab[var_1_3], var_1_3, arg_1_1 == var_1_0
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.setCharVoiceLangPrefValue(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = type(arg_3_1) == "number" and LangSettings.shortcutTab[arg_3_1] or arg_3_1

	if SettingsModel.instance:isOverseas() == false and not arg_3_0:isHeroSp01(arg_3_2) and (var_3_0 == LangSettings.shortcutTab[LangSettings.jp] or var_3_0 == LangSettings.shortcutTab[LangSettings.kr]) then
		return
	end

	arg_3_0:statCharVoiceData(StatEnum.EventName.ChangeCharVoiceLang, arg_3_2, var_3_0)

	local var_3_1 = PlayerModel.instance:getPlayerPrefsKey(SettingsEnum.CharVoiceLangPrefsKey .. arg_3_2 .. "_")

	PlayerPrefsHelper.setString(var_3_1, var_3_0)
end

function var_0_0.getCharVoiceLangPrefValue(arg_4_0, arg_4_1)
	local var_4_0 = PlayerModel.instance:getPlayerPrefsKey(SettingsEnum.CharVoiceLangPrefsKey .. arg_4_1 .. "_")
	local var_4_1 = PlayerPrefsHelper.getString(var_4_0)
	local var_4_2 = false

	if SettingsModel.instance:isOverseas() == false and (type(var_4_1) ~= "string" or string.nilorempty(var_4_1)) then
		var_4_1 = GameConfig:GetCurVoiceShortcut()

		if not arg_4_0:isHeroSp01(arg_4_1) and (var_4_1 == LangSettings.shortcutTab[LangSettings.jp] or var_4_1 == LangSettings.shortcutTab[LangSettings.kr]) then
			var_4_1 = LangSettings.shortcutTab[LangSettings.en]
		end
	end

	local var_4_3 = LangSettings.shortCut2LangIdxTab[var_4_1]
	local var_4_4, var_4_5, var_4_6 = arg_4_0:_getValidLangStr(var_4_1)
	local var_4_7 = var_4_6
	local var_4_8 = var_4_5

	return var_4_4, var_4_8, var_4_7
end

function var_0_0.isHeroSp01(arg_5_0, arg_5_1)
	local var_5_0 = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.S01SpRole), "#")

	return (LuaUtil.tableContains(var_5_0, arg_5_1))
end

function var_0_0.statCharVoiceData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = HeroConfig.instance:getHeroCO(arg_6_2)

	if not var_6_0 then
		return
	end

	local var_6_1 = {
		[StatEnum.EventProperties.HeroId] = tonumber(arg_6_2),
		[StatEnum.EventProperties.HeroName] = var_6_0.name
	}

	if arg_6_1 == StatEnum.EventName.ChangeCharVoiceLang then
		local var_6_2, var_6_3, var_6_4 = arg_6_0:getCharVoiceLangPrefValue(arg_6_2)
		local var_6_5 = GameConfig:GetCurVoiceShortcut()

		var_6_1[StatEnum.EventProperties.CharVoiceLang] = arg_6_3
		var_6_1[StatEnum.EventProperties.GlobalVoiceLang] = var_6_5
		var_6_1[StatEnum.EventProperties.CharVoiceLangBefore] = var_6_4 and var_6_5 or var_6_3
	end

	StatController.instance:track(arg_6_1, var_6_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0

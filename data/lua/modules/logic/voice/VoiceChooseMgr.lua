module("modules.logic.voice.VoiceChooseMgr", package.seeall)

local var_0_0 = class("VoiceChooseMgr")

function var_0_0.start(arg_1_0, arg_1_1, arg_1_2)
	if VersionValidator.instance:isInReviewing() then
		arg_1_1(arg_1_2)
	elseif GameResMgr.IsFromEditorDir and not HotUpdateVoiceMgr.EnableEditorDebug then
		arg_1_1(arg_1_2)
	elseif PlayerPrefsHelper.hasKey(PlayerPrefsKey.SettingsVoiceShortcut) then
		arg_1_1(arg_1_2)
	elseif not GameConfig.CanHotUpdate then
		arg_1_1(arg_1_2)
	else
		local var_1_0 = GameConfig:GetDefaultVoiceShortcut()

		VoiceChooseModel.instance:initModel(var_1_0)

		if VoiceChooseModel.instance:getCount() > 1 then
			BootLoadingView.instance:hide()
			ViewMgr.instance:openView(ViewName.VoiceChooseView, {
				callback = arg_1_1,
				callbackObj = arg_1_2
			})
		else
			local var_1_1 = GameConfig:GetDefaultVoiceShortcut()

			logNormal("没有下载可选语音，跳过选择语音界面，默认选择 " .. var_1_1)
			PlayerPrefsHelper.setString(PlayerPrefsKey.SettingsVoiceShortcut, var_1_1)
			arg_1_1(arg_1_2)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

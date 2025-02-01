module("modules.logic.voice.VoiceChooseMgr", package.seeall)

slot0 = class("VoiceChooseMgr")

function slot0.start(slot0, slot1, slot2)
	if VersionValidator.instance:isInReviewing() then
		slot1(slot2)
	elseif GameResMgr.IsFromEditorDir and not HotUpdateVoiceMgr.EnableEditorDebug then
		slot1(slot2)
	elseif PlayerPrefsHelper.hasKey(PlayerPrefsKey.SettingsVoiceShortcut) then
		slot1(slot2)
	elseif not GameConfig.CanHotUpdate then
		slot1(slot2)
	else
		VoiceChooseModel.instance:initModel(GameConfig:GetDefaultVoiceShortcut())

		if VoiceChooseModel.instance:getCount() > 1 then
			BootLoadingView.instance:hide()
			ViewMgr.instance:openView(ViewName.VoiceChooseView, {
				callback = slot1,
				callbackObj = slot2
			})
		else
			slot4 = GameConfig:GetDefaultVoiceShortcut()

			logNormal("没有下载可选语音，跳过选择语音界面，默认选择 " .. slot4)
			PlayerPrefsHelper.setString(PlayerPrefsKey.SettingsVoiceShortcut, slot4)
			slot1(slot2)
		end
	end
end

slot0.instance = slot0.New()

return slot0

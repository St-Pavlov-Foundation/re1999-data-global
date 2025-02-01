module("modules.logic.settings.view.SettingsVoiceDownloadViewContainer", package.seeall)

slot0 = class("SettingsVoiceDownloadViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SettingsVoiceDownloadView.New())

	return slot1
end

return slot0

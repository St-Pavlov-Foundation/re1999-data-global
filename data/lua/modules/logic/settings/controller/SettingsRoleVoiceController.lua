module("modules.logic.settings.controller.SettingsRoleVoiceController", package.seeall)

slot0 = class("SettingsRoleVoiceController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openSettingRoleVoiceView(slot0)
	ViewMgr.instance:openView(ViewName.SettingsRoleVoiceView)
end

function slot0.setCharVoiceLangPrefValue(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(slot2, slot7.heroId)
	end

	GameFacade.showToast(ToastEnum.SettingCharVoiceLang)
	slot0:dispatchEvent(SettingsEvent.OnCharVoiceTypeChanged, slot1)
end

slot0.instance = slot0.New()

return slot0

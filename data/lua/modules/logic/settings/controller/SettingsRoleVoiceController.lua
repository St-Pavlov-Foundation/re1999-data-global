module("modules.logic.settings.controller.SettingsRoleVoiceController", package.seeall)

local var_0_0 = class("SettingsRoleVoiceController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openSettingRoleVoiceView(arg_5_0)
	ViewMgr.instance:openView(ViewName.SettingsRoleVoiceView)
end

function var_0_0.setCharVoiceLangPrefValue(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(arg_6_2, iter_6_1.heroId)
	end

	GameFacade.showToast(ToastEnum.SettingCharVoiceLang)
	arg_6_0:dispatchEvent(SettingsEvent.OnCharVoiceTypeChanged, arg_6_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0

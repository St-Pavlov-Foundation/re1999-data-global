module("modules.logic.login.controller.work.LogoutVoicePackageDonwloadWork", package.seeall)

local var_0_0 = class("LogoutVoicePackageDonwloadWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_1.isVoicePackageDonwload then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
		SettingsVoicePackageController.instance:initData(arg_2_0.onVoicePackageLoadDone, arg_2_0)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0.onVoicePackageLoadDone(arg_3_0)
	arg_3_0:onDone(true)
end

return var_0_0

module("modules.logic.settings.model.SettingsShowHelper", package.seeall)

local var_0_0 = class("SettingsShowHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0._handlerMap = {
		[SettingsEnum.ShowType.RecordVideo] = var_0_0.canShowRecordVideo,
		[SettingsEnum.ShowType.KeyMap] = var_0_0.canShowKeySetting,
		[SettingsEnum.ShowType.Push] = var_0_0.canShowPush
	}
end

function var_0_0.canShow(arg_2_0, arg_2_1)
	if not arg_2_0._handlerMap[arg_2_1] then
		return true
	end

	return arg_2_0._handlerMap[arg_2_1]()
end

function var_0_0.canShowRecordVideo()
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsRecordVideo) and SDKMgr.isSupportRecord ~= nil and SDKMgr.instance:isSupportRecord()
end

function var_0_0.canShowKeySetting()
	return BootNativeUtil.isWindows() and PCInputController.instance:getIsUse()
end

function var_0_0.canShowPush()
	return not BootNativeUtil.isWindows()
end

return var_0_0

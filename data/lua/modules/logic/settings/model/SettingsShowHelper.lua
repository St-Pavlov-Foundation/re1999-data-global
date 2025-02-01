module("modules.logic.settings.model.SettingsShowHelper", package.seeall)

slot0 = class("SettingsShowHelper")

function slot0.ctor(slot0)
	slot0._handlerMap = {
		[SettingsEnum.ShowType.RecordVideo] = uv0.canShowRecordVideo,
		[SettingsEnum.ShowType.KeyMap] = uv0.canShowKeySetting
	}
end

function slot0.canShow(slot0, slot1)
	if not slot0._handlerMap[slot1] then
		return true
	end

	return slot0._handlerMap[slot1]()
end

function slot0.canShowRecordVideo()
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsRecordVideo) and SDKMgr.isSupportRecord ~= nil and SDKMgr.instance:isSupportRecord()
end

function slot0.canShowKeySetting()
	return BootNativeUtil.isWindows() and PCInputController.instance:getIsUse()
end

return slot0

-- chunkname: @modules/common/facade/GameFacade.lua

module("modules.common.facade.GameFacade", package.seeall)

local GameFacade = {}

function GameFacade.openInputBox(commonInputMO)
	ViewMgr.instance:openView(ViewName.CommonInputView, commonInputMO)
end

function GameFacade.closeInputBox()
	ViewMgr.instance:closeView(ViewName.CommonInputView)
end

function GameFacade.jump(jumpId, callback, callbackObj, recordFarmItem)
	return JumpController.instance:jump(jumpId, callback, callbackObj, recordFarmItem)
end

function GameFacade.jumpByAdditionParam(param, callback, callbackObj, recordFarmItem)
	return JumpController.instance:jumpByAdditionParam(param, callback, callbackObj, recordFarmItem)
end

function GameFacade.jumpByStr(jumpString)
	CommonJumpUtil.jump(jumpString)
end

function GameFacade.showMessageBox(messageBoxId, msgBoxType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	MessageBoxController.instance:showMsgBox(messageBoxId, msgBoxType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
end

function GameFacade.showToastWithTableParam(toastId, paramList)
	if paramList then
		ToastController.instance:showToast(toastId, unpack(paramList))
	else
		ToastController.instance:showToast(toastId)
	end
end

function GameFacade.showToast(toastId, ...)
	ToastController.instance:showToast(toastId, ...)
end

function GameFacade.showToastString(msg)
	ToastController.instance:showToastWithString(msg)
end

function GameFacade.showToastWithIcon(toastId, icon, ...)
	ToastController.instance:showToastWithIcon(toastId, icon, ...)
end

function GameFacade.showIconToastWithTableParam(toastId, icon, paramList)
	if type(paramList) == "table" then
		GameFacade.showToastWithIcon(toastId, icon, unpack(paramList))
	else
		GameFacade.showToastWithIcon(toastId, icon)
	end
end

function GameFacade.isExternalTest()
	local serverType = GameConfig:GetCurServerType()

	return serverType == 6 and SettingsModel.instance:isZhRegion()
end

function GameFacade.isKOLTest()
	local serverType = GameConfig:GetCurServerType()

	return serverType == GameUrlConfig.ServerType.OutExperience or serverType == 8
end

function GameFacade.showOptionMessageBox(messageBoxId, msgBoxType, optionType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	local canShowView = MessageBoxController.instance:canShowMessageOptionBoxView(messageBoxId, optionType)

	if not canShowView then
		if yesCallback then
			yesCallback(yesCallbackObj)
		end

		return
	end

	MessageBoxController.instance:showOptionMsgBox(messageBoxId, msgBoxType, optionType, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
end

function GameFacade.showOptionAndParamsMessageBox(messageBoxId, msgBoxType, optionType, optionExParam, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	local canShowView = MessageBoxController.instance:canShowMessageOptionBoxView(messageBoxId, optionType, optionExParam)

	if not canShowView then
		if yesCallback then
			yesCallback(yesCallbackObj)
		end

		return
	end

	MessageBoxController.instance:showOptionAndParamsMsgBox(messageBoxId, msgBoxType, optionType, optionExParam, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
end

return GameFacade

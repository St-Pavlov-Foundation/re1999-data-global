module("modules.common.facade.GameFacade", package.seeall)

return {
	openInputBox = function (slot0)
		ViewMgr.instance:openView(ViewName.CommonInputView, slot0)
	end,
	closeInputBox = function ()
		ViewMgr.instance:closeView(ViewName.CommonInputView)
	end,
	jump = function (slot0, slot1, slot2, slot3)
		return JumpController.instance:jump(slot0, slot1, slot2, slot3)
	end,
	jumpByAdditionParam = function (slot0, slot1, slot2, slot3)
		return JumpController.instance:jumpByAdditionParam(slot0, slot1, slot2, slot3)
	end,
	jumpByStr = function (slot0)
		CommonJumpUtil.jump(slot0)
	end,
	showMessageBox = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, ...)
		MessageBoxController.instance:showMsgBox(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, ...)
	end,
	showToastWithTableParam = function (slot0, slot1)
		if slot1 then
			ToastController.instance:showToast(slot0, unpack(slot1))
		else
			ToastController.instance:showToast(slot0)
		end
	end,
	showToast = function (slot0, ...)
		ToastController.instance:showToast(slot0, ...)
	end,
	showToastString = function (slot0)
		ToastController.instance:showToastWithString(slot0)
	end,
	showToastWithIcon = function (slot0, slot1, ...)
		ToastController.instance:showToastWithIcon(slot0, slot1, ...)
	end,
	showIconToastWithTableParam = function (slot0, slot1, slot2)
		if type(slot2) == "table" then
			uv0.showToastWithIcon(slot0, slot1, unpack(slot2))
		else
			uv0.showToastWithIcon(slot0, slot1)
		end
	end,
	isExternalTest = function ()
		return GameConfig:GetCurServerType() == 6 and SettingsModel.instance:isZhRegion()
	end,
	isKOLTest = function ()
		return GameConfig:GetCurServerType() == GameUrlConfig.ServerType.OutExperience or slot0 == 8
	end,
	showOptionMessageBox = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, ...)
		if not MessageBoxController.instance:canShowMessageOptionBoxView(slot0, slot2) then
			if slot3 then
				slot3(slot6)
			end

			return
		end

		MessageBoxController.instance:showOptionMsgBox(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, ...)
	end
}

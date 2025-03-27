module("modules.logic.settings.view.KeyMapAlertView", package.seeall)

slot0 = class("KeyMapAlertView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end

	slot0._toastConfig = lua_toast.configDict

	slot0.viewGO:SetActive(false)
end

function slot0.addEvents(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btncancelOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function slot0._btnconfirmOnClick(slot0)
	slot0:save()
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewParam then
		slot0._mo = slot0.viewParam.value
		slot0._modifyKey = slot0._mo[PCInputModel.Configfield.key]

		slot0:setInputKey()
	end
end

function slot0.onBtnReset(slot0)
	SettingsKeyListModel.instance:Reset(slot0._mo[PCInputModel.Configfield.hud])
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.getKey, slot0)
end

function slot0.listenInputKey(slot0)
	TaskDispatcher.runRepeat(slot0.getKey, slot0, 0)
end

function slot0.getKey(slot0)
	if UnityEngine.Input.anyKeyDown and not UnityEngine.Input.GetMouseButton(0) then
		TaskDispatcher.cancelTask(slot0.getKey, slot0)

		if PCInputModel.instance:checkKeyCanModify(slot0._mo[PCInputModel.Configfield.hud], PCInputController.instance:getCurrentPresskey()) then
			if slot0:checkedKey(slot2) then
				slot0:setKeyOccupied(slot3, slot2)
			else
				slot0:setKey(slot2)
			end
		else
			slot0:setCantModify(slot2)
		end
	end
end

function slot0.checkedKey(slot0, slot1)
	return SettingsKeyListModel.instance:checkDunplicateKey(slot0._mo[PCInputModel.Configfield.hud], slot1)
end

function slot0.setInputKey(slot0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeyChange, MsgBoxEnum.BoxType.NO, slot0._btnconfirmOnClick, slot0._btncancelOnClick, nil, slot0, slot0, nil, slot0._mo[PCInputModel.Configfield.description])
	slot0:listenInputKey()
end

function slot0.setKey(slot0, slot1)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeyConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._btnconfirmOnClick, slot0._btncancelOnClick, nil, slot0, slot0, nil, slot0._mo[PCInputModel.Configfield.description], PCInputController.instance:KeyNameToDescName(slot1))

	slot0._modifyKey = slot1
end

function slot0.setCantModify(slot0, slot1)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)

	if not slot1 then
		return
	end

	ToastController.instance:showToast(ToastEnum.PCKeyCantModify, slot1)
end

function slot0.setKeyOccupied(slot0, slot1, slot2)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)

	if slot1[PCInputModel.Configfield.hud] == slot0._mo[PCInputModel.Configfield.hud] and slot1[PCInputModel.Configfield.id] == slot0._mo[PCInputModel.Configfield.id] then
		ToastController.instance:showToast(ToastEnum.pcKeyTipsOccupied)
		ViewMgr.instance:closeView(ViewName.KeyMapAlertView)

		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeySwap, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:swapKey(uv1, uv2)
	end, slot0._btncancelOnClick, nil, , , , PCInputController.instance:KeyNameToDescName(slot2), slot1[PCInputModel.Configfield.description])
end

function slot0.swapKey(slot0, slot1, slot2)
	SettingsKeyListModel.instance:modifyKey(slot0._mo[PCInputModel.Configfield.hud], slot0._mo[PCInputModel.Configfield.id], slot2)
	SettingsKeyListModel.instance:modifyKey(slot1[PCInputModel.Configfield.hud], slot1[PCInputModel.Configfield.id], slot0._mo[PCInputModel.Configfield.key])
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function slot0.save(slot0)
	SettingsKeyListModel.instance:modifyKey(slot0._mo[PCInputModel.Configfield.hud], slot0._mo[PCInputModel.Configfield.id], slot0._modifyKey)
end

return slot0

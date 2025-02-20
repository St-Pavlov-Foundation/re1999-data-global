module("modules.logic.sdk.view.SDKExitGameView", package.seeall)

slot0 = class("SDKExitGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "txt_desc")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._btnlogout = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_logout")

	PCInputController.instance:showkeyTips(gohelper.findChild(slot0.viewGO, "#btn_cancel/#go_pcbtn"), nil, , "Esc")
	PCInputController.instance:showkeyTips(gohelper.findChild(slot0.viewGO, "#btn_logout/#go_pcbtn"), nil, , "Return")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnlogout:AddClickListener(slot0._btnlogoutOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, slot0._btncancelOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, slot0._btnlogoutOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btnlogout:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, slot0._btncancelOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, slot0._btnlogoutOnClick, slot0)
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnlogoutOnClick(slot0)
	slot0:closeThis()

	if slot0.viewParam.exitCallback then
		slot0.viewParam.exitCallback()
	else
		LoginController.instance:logout()
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(ViewName.SDKExitGameView, slot0.closeThis, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
end

return slot0

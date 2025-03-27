module("modules.logic.gm.view.GM_MailView", package.seeall)

slot0 = class("GM_MailView", BaseView)
slot1 = string.format
slot2 = "#FFFF00"
slot3 = "#FF0000"
slot4 = "#00FF00"
slot5 = "#0000FF"

function slot0.register()
	uv0.MailView_register(MailView)
	uv0.MailCategoryListItem_register(MailCategoryListItem)
end

function slot0.MailView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_MailViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_MailViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		MailCategroyModel.instance:onModelUpdate()
	end
end

function slot0.MailCategoryListItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshInfo")

	function slot0._refreshInfo(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshInfo", ...)

		if not uv0.s_ShowAllTabId then
			return
		end

		slot1 = slot0._mo
		slot0._txtmailTitleSelect.text = uv1("mailId=%s", gohelper.getRichColorText(slot1.mailId, uv3))
		slot0._txtmailTitleUnSelect.text = uv1("mailId=%s", gohelper.getRichColorText(slot1.mailId, uv2))
		slot0._txtmailTimeSelect.text = uv1("incr=%s", gohelper.getRichColorText(slot1.id, uv5))
		slot0._txtmailTimeUnSelect.text = uv1("incr=%s", gohelper.getRichColorText(slot1.id, uv4))
	end
end

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._item1Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item1/Toggle")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._item1Toggle:AddOnValueChanged(slot0._onItem1ToggleValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._item1Toggle:RemoveOnValueChanged()
end

function slot0.onOpen(slot0)
	slot0:_refreshItem1()
end

function slot0.onDestroyView(slot0)
end

slot0.s_ShowAllTabId = false

function slot0._refreshItem1(slot0)
	slot0._item1Toggle.isOn = uv0.s_ShowAllTabId
end

function slot0._onItem1ToggleValueChanged(slot0)
	slot1 = slot0._item1Toggle.isOn
	uv0.s_ShowAllTabId = slot1

	GMController.instance:dispatchEvent(GMEvent.MailView_ShowAllTabIdUpdate, slot1)
end

return slot0

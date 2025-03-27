module("modules.logic.gm.view.GM_SummonPoolHistoryView", package.seeall)

slot0 = class("GM_SummonPoolHistoryView", BaseView)
slot1 = "#00FF00"

function slot0.register()
	uv0.SummonPoolHistoryView_register(SummonPoolHistoryView)
	uv0.SummonPoolHistoryTypeItem_register(SummonPoolHistoryTypeItem)
end

function slot0.SummonPoolHistoryView_register(slot0)
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
		GM_SummonPoolHistoryViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_SummonPoolHistoryViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		SummonPoolHistoryTypeListModel.instance:onModelUpdate()
	end
end

function slot0.SummonPoolHistoryTypeItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "onUpdateMO")

	function slot0.onUpdateMO(slot0, slot1, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onUpdateMO", slot1, ...)

		if not uv0.s_ShowAllTabId then
			return
		end

		slot2 = slot1.config
		slot3 = slot2.name .. gohelper.getRichColorText(slot2.id, uv1)
		slot0._txtunname.text = slot3
		slot0._txtname.text = slot3
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

	GMController.instance:dispatchEvent(GMEvent.SummonPoolHistoryView_ShowAllTabIdUpdate, slot1)
end

return slot0

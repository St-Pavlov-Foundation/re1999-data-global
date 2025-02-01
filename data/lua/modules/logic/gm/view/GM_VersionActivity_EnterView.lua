module("modules.logic.gm.view.GM_VersionActivity_EnterView", package.seeall)

slot0 = class("GM_VersionActivity_EnterView", BaseView)

function slot1()
	ViewMgr.instance:openView(ViewName.GM_VersionActivity_EnterView)
end

function slot0.VersionActivityX_XEnterView(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0, uv0)
		GM_VersionActivity_EnterViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_VersionActivity_EnterViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		slot0:refreshUI()
	end
end

function slot0.VersionActivityEnterViewTabItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "refreshNameText")

	slot1 = "#FFFF00"

	function slot0.refreshNameText(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "refreshNameText", ...)

		if not uv0.s_ShowAllTabId then
			return
		end

		slot2 = gohelper.getRichColorText(tostring(slot0.actId), uv1)
		slot0.activityNameTexts.select.text = slot2
		slot0.activityNameTexts.normal.text = slot2
	end
end

function slot0.VersionActivityX_XEnterViewTabItemBase_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "afterSetData")

	slot1 = "#FFFF00"

	function slot0.afterSetData(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "afterSetData", ...)

		if not uv0.s_ShowAllTabId then
			return
		end

		slot3 = gohelper.getRichColorText(tostring(slot0.activityCo.id), uv1)
		slot0.txtName.text = slot3
		slot0.txtNameEn.text = slot3
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

	GMController.instance:dispatchEvent(GMEvent.VersionActivity_EnterView_ShowAllTabIdUpdate, slot1)
end

return slot0

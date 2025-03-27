module("modules.logic.gm.view.GM_ActivityBeginnerView", package.seeall)

slot0 = class("GM_ActivityBeginnerView", BaseView)
slot1 = "#FFFF00"

function slot0.register()
	uv0.ActivityBeginnerView_register(ActivityBeginnerView)
	uv0.ActivityCategoryItem_register(ActivityCategoryItem)
end

function slot0.ActivityBeginnerView_register(slot0)
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
		GM_ActivityBeginnerViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_ActivityBeginnerViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		ActivityBeginnerCategoryListModel.instance:onModelUpdate()
	end
end

function slot0.ActivityCategoryItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshItem")

	function slot0._refreshItem(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshItem", ...)

		if not uv0.s_ShowAllTabId then
			return
		end

		slot3 = gohelper.getRichColorText(slot0._mo.id, uv1)
		slot0._txtnamecn.text = slot3
		slot0._txtunselectnamecn.text = slot3
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

	GMController.instance:dispatchEvent(GMEvent.ActivityBeginnerView_ShowAllTabIdUpdate, slot1)
end

return slot0

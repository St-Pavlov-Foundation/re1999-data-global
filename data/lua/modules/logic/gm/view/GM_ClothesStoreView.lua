module("modules.logic.gm.view.GM_ClothesStoreView", package.seeall)

slot0 = class("GM_ClothesStoreView", BaseView)

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

	GMController.instance:dispatchEvent(GMEvent.ClothesStoreView_ShowAllTabIdUpdate, slot1)
end

return slot0

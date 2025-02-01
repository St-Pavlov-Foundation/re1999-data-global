module("modules.logic.gm.view.GM_MainThumbnailRecommendView", package.seeall)

slot0 = class("GM_MainThumbnailRecommendView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._item1Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item1/Toggle")
	slot0._item2Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item2/Toggle")
	slot0._item3Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item3/Toggle")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._item1Toggle:AddOnValueChanged(slot0._onItem1ToggleValueChanged, slot0)
	slot0._item2Toggle:AddOnValueChanged(slot0._onItem2ToggleValueChanged, slot0)
	slot0._item3Toggle:AddOnValueChanged(slot0._onItem3ToggleValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._item1Toggle:RemoveOnValueChanged()
	slot0._item2Toggle:RemoveOnValueChanged()
	slot0._item3Toggle:RemoveOnValueChanged()
end

function slot0.onOpen(slot0)
	slot0:_refreshItem1()
	slot0:_refreshItem2()
	slot0:_refreshItem3()
end

function slot0.onDestroyView(slot0)
end

slot0.s_ShowAllBanner = false

function slot0._refreshItem1(slot0)
	slot0._item1Toggle.isOn = uv0.s_ShowAllBanner
end

function slot0._onItem1ToggleValueChanged(slot0)
	slot1 = slot0._item1Toggle.isOn
	uv0.s_ShowAllBanner = slot1

	GMController.instance:dispatchEvent(GMEvent.MainThumbnailRecommendView_ShowAllBannerUpdate, slot1)
end

slot0.s_ShowAllTabId = false

function slot0._refreshItem2(slot0)
	slot0._item2Toggle.isOn = uv0.s_ShowAllTabId
end

function slot0._onItem2ToggleValueChanged(slot0)
	slot1 = slot0._item2Toggle.isOn
	uv0.s_ShowAllTabId = slot1

	GMController.instance:dispatchEvent(GMEvent.MainThumbnailRecommendView_ShowAllTabIdUpdate, slot1)
end

slot0.s_StopBannerLoopAnim = false

function slot0._refreshItem3(slot0)
	slot0._item3Toggle.isOn = uv0.s_StopBannerLoopAnim
end

function slot0._onItem3ToggleValueChanged(slot0)
	slot1 = slot0._item3Toggle.isOn
	uv0.s_StopBannerLoopAnim = slot1

	GMController.instance:dispatchEvent(GMEvent.MainThumbnailRecommendView_StopBannerLoopAnimUpdate, slot1)
end

return slot0

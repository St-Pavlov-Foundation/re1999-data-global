module("modules.logic.gm.view.GM_TaskListCommonItem", package.seeall)

slot0 = class("GM_TaskListCommonItem", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._item1Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item1/Toggle")
	slot0._item2Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item2/Toggle")
	slot0._item3Btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item3/Button")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._item1Toggle:AddOnValueChanged(slot0._onItem1ToggleValueChanged, slot0)
	slot0._item2Toggle:AddOnValueChanged(slot0._onItem2ToggleValueChanged, slot0)
	slot0._item3Btn:AddClickListener(slot0._onItem3Click, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._item1Toggle:RemoveOnValueChanged()
	slot0._item2Toggle:RemoveOnValueChanged()
	slot0._item3Btn:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0:_refreshItem1()
	slot0:_refreshItem2()
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshItem1(slot0)
	slot0._item1Toggle.isOn = slot0.class.s_ShowAllTabId or false
end

function slot0._onItem1ToggleValueChanged(slot0)
	if slot0.class.s_ShowAllTabId == slot0._item1Toggle.isOn then
		return
	end

	slot2.s_ShowAllTabId = slot1

	slot0.viewContainer:_gm_showAllTabIdUpdate(slot1)
end

function slot0._refreshItem2(slot0)
	slot0._item2Toggle.isOn = slot0.class.s_enableFinishSelectedTask or false
end

function slot0._onItem2ToggleValueChanged(slot0)
	if slot0.class.s_enableFinishSelectedTask == slot0._item2Toggle.isOn then
		return
	end

	slot2.s_enableFinishSelectedTask = slot1

	slot0.viewContainer:_gm_enableFinishOnSelect(slot1)
end

function slot0._onItem3Click(slot0)
	slot0.viewContainer:_gm_onClickFinishAll()
end

return slot0

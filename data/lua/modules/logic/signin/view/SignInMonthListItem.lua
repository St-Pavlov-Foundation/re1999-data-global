module("modules.logic.signin.view.SignInMonthListItem", package.seeall)

slot0 = class("SignInMonthListItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._obj = gohelper.findChild(slot1, "obj")
	slot0._normal = gohelper.findChild(slot1, "obj/normal")
	slot0._select = gohelper.findChild(slot1, "obj/select")
	slot0._txtmonthnormal = gohelper.findChildText(slot1, "obj/normal/txt_normalmonth")
	slot0._txtmonthselect = gohelper.findChildText(slot1, "obj/select/txt_selectmonth")
	slot0._itemClick = gohelper.getClickWithAudio(slot0._obj)
end

function slot0.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	SignInController.instance:registerCallback(SignInEvent.GetHistorySignInSuccess, slot0._onCheckSignInMonthUnlocked, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._itemClick:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.GetHistorySignInSuccess, slot0._onCheckSignInMonthUnlocked, slot0)
end

function slot0._onItemClick(slot0)
	if slot0._mo.year == SignInModel.instance:getSignTargetDate()[1] and slot0._mo.month == slot1[2] then
		return
	end

	SignInModel.instance:setNewShowDetail(false)

	if slot0._mo.year == SignInModel.instance:getCurDate().year and slot0._mo.month == slot2.month then
		SignInModel.instance:setTargetDate(slot0._mo.year, slot0._mo.month, slot2.day)
		slot0:_refreshMonthItem()
	elseif 12 * (slot2.year - slot0._mo.year - 1) + 13 - slot0._mo.month + slot2.month > 13 then
		SignInModel.instance:setTargetDate(slot0._mo.year, slot0._mo.month, 1)
		slot0:_refreshMonthItem()
	else
		SignInRpc.instance:sendSignInHistoryRequest(slot0._mo.month)
	end
end

function slot0._onCheckSignInMonthUnlocked(slot0, slot1)
	if slot0._mo.month == SignInModel.instance:getCurDate().month and slot0._mo.year == slot2.year then
		return
	end

	if slot0._mo.month == slot1 then
		if SignInModel.instance:getHistorySignInDays(slot1) and #slot3 > 0 then
			SignInModel.instance:setTargetDate(slot0._mo.year, slot0._mo.month, slot3[1])
			slot0:_refreshMonthItem()
		else
			GameFacade.showToast(ToastEnum.SignInError)
		end
	end
end

function slot0._refreshMonthItem(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_calendar_month_turn)
	SignInController.instance:dispatchEvent(SignInEvent.ClickSignInMonthItem)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	slot0._txtmonthnormal.text = slot0._mo.month
	slot0._txtmonthselect.text = slot0._mo.month
	slot2 = slot0._mo.year == SignInModel.instance:getSignTargetDate()[1] and slot0._mo.month == slot1[2]

	gohelper.setActive(slot0._select, slot2)
	gohelper.setActive(slot0._normal, not slot2)
end

function slot0.onDestroy(slot0)
end

return slot0

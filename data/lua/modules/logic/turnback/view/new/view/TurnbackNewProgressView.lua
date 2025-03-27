module("modules.logic.turnback.view.new.view.TurnbackNewProgressView", package.seeall)

slot0 = class("TurnbackNewProgressView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnrefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/content/#btn_refresh")
	slot0._txtrefresh = gohelper.findChildText(slot0.viewGO, "bg/content/#btn_refresh/txt_refresh")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "bg/content")
	slot0._simagepic = gohelper.findChildSingleImage(slot0.viewGO, "bg/content/item1/#simage_pic")
	slot0._canRefresh = true
	slot0._refreshCd = TurnbackEnum.RefreshCd
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrefresh:AddClickListener(slot0._btnrefreshOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onCurrencyChange, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0.refreshItemBySelf, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrefresh:RemoveClickListener()
end

function slot0._btnrefreshOnClick(slot0)
	if not slot0._taskcd and slot0._canRefresh then
		slot0._animator:Update(0)
		slot0._animator:Play("update")
		TaskDispatcher.runDelay(slot0._afteranim, slot0, 0.16)
	else
		GameFacade.showToast(ToastEnum.TurnbackNewProgressViewRefresh)
	end
end

function slot0._afteranim(slot0)
	TaskDispatcher.cancelTask(slot0._afteranim, slot0)

	slot0._canRefresh = false

	slot0:refreshProgressItem()

	slot0._txtrefresh.text = slot0._refreshCd .. "s"
	slot0._taskcd = TaskDispatcher.runRepeat(slot0._ontimeout, slot0, 1)
end

function slot0._ontimeout(slot0)
	slot0._refreshCd = slot0._refreshCd - 1

	if slot0._refreshCd > 0 then
		slot0._txtrefresh.text = slot0._refreshCd .. "s"
	else
		TaskDispatcher.cancelTask(slot0._ontimeout, slot0)

		slot0._txtrefresh.text = luaLang("p_turnbacknewprogressview_txt_refresh")
		slot0._canRefresh = true
		slot0._taskcd = nil
		slot0._refreshCd = TurnbackEnum.RefreshCd
	end
end

function slot0._editableInitView(slot0)
	slot0._txtrefresh.text = luaLang("p_turnbacknewprogressview_txt_refresh")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onCurrencyChange(slot0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	slot0:refreshItemBySelf()
end

function slot0.refreshItemBySelf(slot0)
	for slot4, slot5 in ipairs(slot0._progressItems) do
		slot5.cls:refreshItemBySelf()
	end
end

function slot0.refreshProgressItem(slot0)
	slot1, slot2 = TurnbackModel.instance:getDropInfoList()

	slot0._progressItems[TurnbackEnum.DropInfoEnum.MainEpisode].cls:refreshItem(TurnbackModel.instance:getDropInfoByType(TurnbackEnum.DropInfoEnum.MainEpisode))

	for slot8, slot9 in ipairs(slot1) do
		if slot0._progressItems[slot8 + 2] then
			slot11.cls:refreshItem(slot9)
		end
	end

	slot0._progressItems[6].cls:refreshItem(slot2[1])
end

function slot0.onOpen(slot0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._progressItems = {}

	for slot5 = 1, 6 do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.findChild(slot0._gocontent, "item" .. slot5)
		slot6.cls = MonoHelper.addNoUpdateLuaComOnceToGo(slot6.go, TurnbackNewProgressItem)

		table.insert(slot0._progressItems, slot6)
		slot6.cls:initItem(slot5)
	end

	slot0:refreshProgressItem()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_03)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._afteranim, slot0)
	TaskDispatcher.cancelTask(slot0._ontimeout, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._ontimeout, slot0)
end

return slot0

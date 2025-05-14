module("modules.logic.turnback.view.new.view.TurnbackNewProgressView", package.seeall)

local var_0_0 = class("TurnbackNewProgressView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnrefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/content/#btn_refresh")
	arg_1_0._txtrefresh = gohelper.findChildText(arg_1_0.viewGO, "bg/content/#btn_refresh/txt_refresh")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "bg/content")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/content/item1/#simage_pic")
	arg_1_0._canRefresh = true
	arg_1_0._refreshCd = TurnbackEnum.RefreshCd
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrefresh:AddClickListener(arg_2_0._btnrefreshOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0.refreshItemBySelf, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrefresh:RemoveClickListener()
end

function var_0_0._btnrefreshOnClick(arg_4_0)
	if not arg_4_0._taskcd and arg_4_0._canRefresh then
		arg_4_0._animator:Update(0)
		arg_4_0._animator:Play("update")
		TaskDispatcher.runDelay(arg_4_0._afteranim, arg_4_0, 0.16)
	else
		GameFacade.showToast(ToastEnum.TurnbackNewProgressViewRefresh)
	end
end

function var_0_0._afteranim(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._afteranim, arg_5_0)

	arg_5_0._canRefresh = false

	arg_5_0:refreshProgressItem()

	arg_5_0._txtrefresh.text = arg_5_0._refreshCd .. "s"
	arg_5_0._taskcd = TaskDispatcher.runRepeat(arg_5_0._ontimeout, arg_5_0, 1)
end

function var_0_0._ontimeout(arg_6_0)
	arg_6_0._refreshCd = arg_6_0._refreshCd - 1

	if arg_6_0._refreshCd > 0 then
		arg_6_0._txtrefresh.text = arg_6_0._refreshCd .. "s"
	else
		TaskDispatcher.cancelTask(arg_6_0._ontimeout, arg_6_0)

		arg_6_0._txtrefresh.text = luaLang("p_turnbacknewprogressview_txt_refresh")
		arg_6_0._canRefresh = true
		arg_6_0._taskcd = nil
		arg_6_0._refreshCd = TurnbackEnum.RefreshCd
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txtrefresh.text = luaLang("p_turnbacknewprogressview_txt_refresh")
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onCurrencyChange(arg_9_0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	arg_9_0:refreshItemBySelf()
end

function var_0_0.refreshItemBySelf(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._progressItems) do
		iter_10_1.cls:refreshItemBySelf()
	end
end

function var_0_0.refreshProgressItem(arg_11_0)
	local var_11_0, var_11_1 = TurnbackModel.instance:getDropInfoList()
	local var_11_2 = TurnbackModel.instance:getDropInfoByType(TurnbackEnum.DropInfoEnum.MainEpisode)

	arg_11_0._progressItems[TurnbackEnum.DropInfoEnum.MainEpisode].cls:refreshItem(var_11_2)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_3 = iter_11_0 + 2
		local var_11_4 = arg_11_0._progressItems[var_11_3]

		if var_11_4 then
			var_11_4.cls:refreshItem(iter_11_1)
		end
	end

	arg_11_0._progressItems[6].cls:refreshItem(var_11_1[1])
end

function var_0_0.onOpen(arg_12_0)
	local var_12_0 = arg_12_0.viewParam.parent

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	gohelper.addChild(var_12_0, arg_12_0.viewGO)

	arg_12_0._progressItems = {}

	for iter_12_0 = 1, 6 do
		local var_12_1 = arg_12_0:getUserDataTb_()

		var_12_1.go = gohelper.findChild(arg_12_0._gocontent, "item" .. iter_12_0)
		var_12_1.cls = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1.go, TurnbackNewProgressItem)

		table.insert(arg_12_0._progressItems, var_12_1)
		var_12_1.cls:initItem(iter_12_0)
	end

	arg_12_0:refreshProgressItem()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_03)
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._afteranim, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._ontimeout, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._ontimeout, arg_14_0)
end

return var_0_0

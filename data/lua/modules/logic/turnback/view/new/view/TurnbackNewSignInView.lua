module("modules.logic.turnback.view.new.view.TurnbackNewSignInView", package.seeall)

local var_0_0 = class("TurnbackNewSignInView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	TurnbackController.instance:registerCallback(TurnbackEvent.RefreshView, arg_2_0.refreshItem, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.refreshItem, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	TurnbackController.instance:unregisterCallback(TurnbackEvent.RefreshView, arg_3_0.refreshItem, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.refreshItem, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._signItems = {}

	for iter_4_0 = 1, 7 do
		local var_4_0 = arg_4_0:getUserDataTb_()

		var_4_0.go = gohelper.findChild(arg_4_0._gocontent, "node" .. iter_4_0)
		var_4_0.cls = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_0.go, TurnbackNewSignInItem)

		table.insert(arg_4_0._signItems, var_4_0)
		var_4_0.cls:initItem(iter_4_0)
	end
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_04)
end

function var_0_0.refreshItem(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._signItems) do
		iter_7_1.cls:initItem(iter_7_0)
	end
end

function var_0_0._onCloseViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CommonPropView then
		local var_8_0 = TurnbackModel.instance:getLastGetSigninReward()

		if var_8_0 then
			ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
				isNormal = true,
				day = var_8_0
			})
		end
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0

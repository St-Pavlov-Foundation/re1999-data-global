module("modules.logic.versionactivity2_5.challenge.view.store.Act183StoreEntry", package.seeall)

local var_0_0 = class("Act183StoreEntry", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_click")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_Num")
	arg_1_0._gostoretips = gohelper.findChild(arg_1_0.viewGO, "root/#go_storetips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstore:RemoveClickListener()
end

function var_0_0._btnstoreOnClick(arg_4_0)
	Act183Controller.instance:openAct183StoreView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_5_0.refreshStoreTag, arg_5_0)
	arg_5_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_5_0.refreshStoreTag, arg_5_0)
	arg_5_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0.refreshCurrency, arg_5_0)
	arg_5_0:addEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, arg_5_0.refreshStoreTag, arg_5_0)

	arg_5_0._actId = Act183Model.instance:getActivityId()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshCurrency()
	arg_6_0:refreshStoreTag()
end

function var_0_0.refreshCurrency(arg_7_0)
	local var_7_0 = V1a6_BossRush_StoreModel.instance:getCurrencyCount(arg_7_0._actId)

	arg_7_0._txtNum.text = var_7_0 or 0
end

function var_0_0.refreshStoreTag(arg_8_0)
	local var_8_0 = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(arg_8_0._gostoretips, var_8_0)
end

return var_0_0

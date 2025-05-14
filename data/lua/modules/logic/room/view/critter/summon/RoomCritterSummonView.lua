module("modules.logic.room.view.critter.summon.RoomCritterSummonView", package.seeall)

local var_0_0 = class("RoomCritterSummonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/top/#simage_title")
	arg_1_0._gocritterSub = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_critterSub")
	arg_1_0._gocritteritem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_critterSub/#go_critteritem")
	arg_1_0._scrollcritter = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#go_critterSub/#scroll_critter")
	arg_1_0._btnrefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#btn_refresh")
	arg_1_0._btnsummon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bottom/#btn_summon")
	arg_1_0._simagecurrency = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bottom/#btn_summon/currency/#simage_currency")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#btn_summon/currency/#txt_currency")
	arg_1_0._btnsummonten = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bottom/#btn_summonten")
	arg_1_0._simagecurrencyten = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bottom/#btn_summonten/currency/#simage_currencyten")
	arg_1_0._txtcurrencyten = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#btn_summonten/currency/#txt_currencyten")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "root/#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrefresh:AddClickListener(arg_2_0._btnrefreshOnClick, arg_2_0)
	arg_2_0._btnsummon:AddClickListener(arg_2_0._btnsummonOnClick, arg_2_0)
	arg_2_0._btnsummonten:AddClickListener(arg_2_0._btnsummontenOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrefresh:RemoveClickListener()
	arg_3_0._btnsummon:RemoveClickListener()
	arg_3_0._btnsummonten:RemoveClickListener()
end

function var_0_0._addEvents(arg_4_0)
	arg_4_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, arg_4_0._onStartSummon, arg_4_0)
	arg_4_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, arg_4_0._onCloseGetCritter, arg_4_0)
	arg_4_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onResetSummon, arg_4_0._onResetSummon, arg_4_0)
	arg_4_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0._startRefreshSingleCostTask, arg_4_0)
	arg_4_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_4_0._startRefreshSingleCostTask, arg_4_0)
end

function var_0_0._removeEvents(arg_5_0)
	arg_5_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, arg_5_0._onStartSummon, arg_5_0)
	arg_5_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, arg_5_0._onCloseGetCritter, arg_5_0)
	arg_5_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onResetSummon, arg_5_0._onResetSummon, arg_5_0)
	arg_5_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0._startRefreshSingleCostTask, arg_5_0)
	arg_5_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_5_0._startRefreshSingleCostTask, arg_5_0)
end

function var_0_0._btnrefreshOnClick(arg_6_0)
	arg_6_0:_refreshPool()
end

function var_0_0._btnsummonOnClick(arg_7_0)
	arg_7_0:_sendSummonCritter(CritterEnum.Summon.One)
end

function var_0_0._btnsummontenOnClick(arg_8_0)
	if arg_8_0._curTenCount then
		arg_8_0:_sendSummonCritter(arg_8_0._curTenCount)
	end
end

function var_0_0._sendSummonCritter(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = CritterSummonModel.instance:notSummonToast(arg_9_0._poolId, arg_9_1)

	if string.nilorempty(var_9_0) then
		CritterRpc.instance:sendSummonCritterRequest(arg_9_0._poolId, arg_9_1)
	else
		GameFacade.showToast(var_9_0, var_9_1)
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._canvasGroup = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_10_0._goroot = gohelper.findChild(arg_10_0.viewGO, "root")
	arg_10_0._btnsummonGO = arg_10_0._btnsummon.gameObject
	arg_10_0._btnsummontenGO = arg_10_0._btnsummonten.gameObject
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_addEvents()

	arg_12_0._poolId = CritterSummonModel.instance:getSummonPoolId()
	arg_12_0._summonCount = CritterSummonModel.instance:getSummonCount()

	gohelper.setActive(arg_12_0._gocritteritem, false)
	CritterRpc.instance:sendSummonCritterInfoRequest(arg_12_0.onRefresh, arg_12_0)
	arg_12_0:_refreshSingleCost()
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:_removeEvents()
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagecurrency:UnLoadImage()
	arg_14_0._simagecurrencyten:UnLoadImage()
	arg_14_0:_stopRefreshSingleCostTask()
end

function var_0_0.onRefresh(arg_15_0)
	arg_15_0:_onRefreshCritter()
	arg_15_0:_startRefreshSingleCostTask()
end

function var_0_0._startRefreshSingleCostTask(arg_16_0)
	if not arg_16_0._hasWaitRefreshSingleCostTask then
		arg_16_0._hasWaitRefreshSingleCostTask = true

		TaskDispatcher.runDelay(arg_16_0._onRunRefreshSingleCostTask, arg_16_0, 0.1)
	end
end

function var_0_0._stopRefreshSingleCostTask(arg_17_0)
	arg_17_0._hasWaitRefreshSingleCostTask = false

	TaskDispatcher.cancelTask(arg_17_0._onRunRefreshSingleCostTask, arg_17_0)
end

function var_0_0._onRunRefreshSingleCostTask(arg_18_0)
	arg_18_0._hasWaitRefreshSingleCostTask = false

	arg_18_0:_refreshSingleCost()
end

function var_0_0._onRefreshCritter(arg_19_0)
	CritterSummonModel.instance:setSummonPoolList(arg_19_0._poolId)

	if CritterSummonModel.instance:isNullPool(arg_19_0._poolId) then
		arg_19_0:_refreshPool()
	end
end

function var_0_0._refreshPool(arg_20_0)
	if CritterSummonModel.instance:isFullPool(arg_20_0._poolId) then
		GameFacade.showToast(ToastEnum.RoomCritterPoolNeweast)

		return
	end

	if CritterSummonModel.instance:isNullPool(arg_20_0._poolId) then
		arg_20_0:_refreshPoolRequest()
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterPoolRefresh, MsgBoxEnum.BoxType.Yes_No, arg_20_0._refreshPoolRequest, nil, nil, arg_20_0)
	end
end

function var_0_0._refreshPoolRequest(arg_21_0)
	CritterRpc.instance:sendResetSummonCritterPoolRequest(arg_21_0._poolId)
end

function var_0_0._refreshSingleCost(arg_22_0)
	local var_22_0, var_22_1, var_22_2 = CritterSummonModel.instance:getPoolCurrency(arg_22_0._poolId)

	arg_22_0._simagecurrency:LoadImage(var_22_0)

	arg_22_0._txtcurrency.text = var_22_1

	local var_22_3 = CritterSummonModel.instance:getPoolCritterCount(arg_22_0._poolId)

	arg_22_0._curTenCount = math.min(var_22_3, CritterEnum.Summon.Ten)

	local var_22_4, var_22_5, var_22_6 = CritterSummonModel.instance:getPoolCurrency(arg_22_0._poolId, arg_22_0._curTenCount)

	arg_22_0._simagecurrencyten:LoadImage(var_22_4)

	arg_22_0._txtcurrencyten.text = var_22_5
	var_22_6 = var_22_6 and var_22_3 >= arg_22_0._curTenCount
	var_22_2 = var_22_2 and var_22_3 >= CritterEnum.Summon.One

	ZProj.UGUIHelper.SetGrayscale(arg_22_0._btnsummontenGO, not var_22_6)
	ZProj.UGUIHelper.SetGrayscale(arg_22_0._btnsummonGO, not var_22_2)
end

function var_0_0._onStartSummon(arg_23_0, arg_23_1)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)

	local var_23_0 = arg_23_0.viewContainer:getContainerViewBuilding()

	CritterSummonController.instance:openSummonView(var_23_0, arg_23_1)

	if arg_23_0._goroot then
		gohelper.setActive(arg_23_0._goroot, false)
	end
end

function var_0_0._onCloseGetCritter(arg_24_0)
	if arg_24_0._goroot then
		gohelper.setActive(arg_24_0._goroot, true)
	end

	arg_24_0:onRefresh()
end

function var_0_0._onResetSummon(arg_25_0, arg_25_1)
	arg_25_0._poolId = arg_25_1

	GameFacade.showToast(ToastEnum.RoomCritterPoolRefresh)
	CritterSummonController.instance:refreshSummon(arg_25_1, arg_25_0.onRefresh, arg_25_0)
end

return var_0_0

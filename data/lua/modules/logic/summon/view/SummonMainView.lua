module("modules.logic.summon.view.SummonMainView", package.seeall)

local var_0_0 = class("SummonMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_drag")
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_category")
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_ui/#go_category/#scroll_category")
	arg_1_0._gonormalRoleCategoryItem = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_normalRoleCategoryItem")
	arg_1_0._goequipCategoryItem = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_equipCategoryItem")
	arg_1_0._goRoleUpCategoryItem = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_RoleUpCategoryItem")
	arg_1_0._btnconvertStore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/btns/#btn_convertStore")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/btns/#btn_detail")
	arg_1_0._btnsummonrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/btns/#btn_summonrecord")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconvertStore:AddClickListener(arg_2_0._btnconvertStoreOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnsummonrecord:AddClickListener(arg_2_0._btnsummonrecordOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconvertStore:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnsummonrecord:RemoveClickListener()
end

function var_0_0._btnconvertStoreOnClick(arg_4_0)
	local var_4_0 = SummonMainModel.instance:getCurPool()
	local var_4_1 = StoreEnum.StoreId.SummonExchange

	if var_4_0 and SummonMainModel.getResultType(var_4_0) == SummonEnum.ResultType.Equip then
		var_4_1 = StoreEnum.StoreId.SummonEquipExchange
	end

	StoreController.instance:checkAndOpenStoreView(var_4_1)
end

function var_0_0._btndetailOnClick(arg_5_0)
	local var_5_0 = SummonMainModel.instance:getCurPool()

	SummonMainController.instance:openSummonDetail(var_5_0)
end

function var_0_0._btnsummonrecordOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.SummonPoolHistoryView)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txtrecord = gohelper.findChildTextMesh(arg_7_0.viewGO, "#go_ui/btns/#btn_summonrecord/txt")
	arg_7_0._goblackloading = gohelper.findChild(arg_7_0.viewGO, "#blackloading")
	arg_7_0._animLoading = arg_7_0._goblackloading:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._animUI = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	SummonMainModel.instance:setFirstTimeSwitch(true)
	gohelper.addUIClickAudio(arg_7_0._btnconvertStore.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
	gohelper.addUIClickAudio(arg_7_0._btndetail.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
end

function var_0_0._handleTabSet(arg_8_0)
	local var_8_0 = SummonMainModel.instance:getCurADPageIndex()

	if var_8_0 then
		arg_8_0:checkCallPreloader()
		arg_8_0.viewContainer:refreshCurrencyType()
	end

	arg_8_0._tabIndex = var_8_0

	local var_8_1 = SummonMainModel.instance:getCurPool()

	if SummonMainModel.getResultType(var_8_1) == SummonEnum.ResultType.Equip then
		arg_8_0._txtrecord:SetText(luaLang("p_summonpool_equip_record"))
	else
		arg_8_0._txtrecord:SetText(luaLang("p_summonpool_record"))
	end
end

function var_0_0.onItemChanged(arg_9_0)
	arg_9_0.viewContainer:refreshCurrencyType()
end

function var_0_0.onUpdateParam(arg_10_0)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = SummonMainModel.instance:getList()

	if not var_11_0 or #var_11_0 <= 0 then
		logError("没有卡池")
		TaskDispatcher.runDelay(arg_11_0.returnToMainScene, arg_11_0, 2)

		return
	end

	arg_11_0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, arg_11_0._handleTabSet, arg_11_0)
	arg_11_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_11_0.checkCallPreloader, arg_11_0)
	arg_11_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_11_0.onSummonInfoGot, arg_11_0)
	arg_11_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_11_0.viewContainer.refreshHelp, arg_11_0.viewContainer)
	arg_11_0:addEventCb(SummonController.instance, SummonEvent.summonShowBlackScreen, arg_11_0.onReceiveShowBlackScreen, arg_11_0)
	arg_11_0:addEventCb(SummonController.instance, SummonEvent.summonShowExitAnim, arg_11_0.startExitLoading, arg_11_0)
	arg_11_0:addEventCb(SummonController.instance, SummonEvent.summonCloseBlackScreen, arg_11_0.onReceiveCloseBlackScreen, arg_11_0)
	arg_11_0:addEventCb(SummonController.instance, SummonEvent.summonMainCloseImmediately, arg_11_0.closeThis, arg_11_0)
	arg_11_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_11_0.onItemChanged, arg_11_0)
	arg_11_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_11_0.onItemChanged, arg_11_0)
	TaskDispatcher.runRepeat(arg_11_0.repeatCallCountdown, arg_11_0, 10)

	if SDKChannelEventModel.instance:needAppReview() then
		SDKController.instance:openSDKScoreJumpView()
	end
end

function var_0_0.onOpenFinish(arg_12_0)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonUI)
end

function var_0_0.returnToMainScene(arg_13_0)
	MainController.instance:enterMainScene(true)
	VirtualSummonScene.instance:close(true)
	ViewMgr.instance:closeView(ViewName.SummonADView)
	ViewMgr.instance:closeView(ViewName.SummonView)
end

function var_0_0.checkCallPreloader(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.delayLoadSceneResPreloader, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0.delayLoadSceneResPreloader, arg_14_0, 1)
end

function var_0_0.delayLoadSceneResPreloader(arg_15_0)
	local var_15_0 = SummonMainModel.instance:getCurId()
	local var_15_1 = SummonMainModel.getResultTypeById(var_15_0) == SummonEnum.ResultType.Char

	VirtualSummonScene.instance:checkNeedLoad(var_15_1, false)
end

function var_0_0.onSummonInfoGot(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getList()

	if not var_16_0 or #var_16_0 <= 0 then
		logError("返回消息没有卡池")
		TaskDispatcher.runDelay(arg_16_0.returnToMainScene, arg_16_0, 1)

		return
	end

	arg_16_0:checkCurPoolValid()
end

function var_0_0.onReceiveShowBlackScreen(arg_17_0)
	gohelper.setActive(arg_17_0._goblackloading, true)
	arg_17_0._animLoading:Play("blackloading_open", 0, 0)

	arg_17_0._isShowBlackScreen = true

	TaskDispatcher.runDelay(arg_17_0.afterBlackLoading, arg_17_0, 0.3)
end

function var_0_0.afterBlackLoading(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.afterBlackLoading, arg_18_0)
	gohelper.setActive(arg_18_0._goui, false)
	SummonController.instance:onFirstLoadSceneBlock()
end

function var_0_0.onReceiveCloseBlackScreen(arg_19_0)
	if not gohelper.isNil(arg_19_0._animLoading) then
		arg_19_0._animLoading:Play("blackloading_close", 0, 0)
	end

	TaskDispatcher.runDelay(arg_19_0.afterCloseLoading, arg_19_0, 0.4)
end

function var_0_0.afterCloseLoading(arg_20_0)
	logNormal("close SummonMainView")
	TaskDispatcher.cancelTask(arg_20_0.afterCloseLoading, arg_20_0)
	arg_20_0:closeThis()
end

function var_0_0.startExitLoading(arg_21_0)
	if not gohelper.isNil(arg_21_0._animUI) then
		arg_21_0._animUI:Play(UIAnimationName.Close, 0, 0)
	end

	local var_21_0 = arg_21_0.viewContainer:getCurTabInst()

	if var_21_0 and not gohelper.isNil(var_21_0.viewGO) then
		local var_21_1 = var_21_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

		if var_21_1 then
			var_21_1:Play(UIAnimationName.Close, 0, 0)
		end
	end

	return 0.16
end

function var_0_0.startExitSummonFadeOut(arg_22_0)
	if not gohelper.isNil(arg_22_0._animUI) then
		arg_22_0._animUI:Play("out", 0, 0)
	end

	return 0.16
end

function var_0_0.checkCurPoolValid(arg_23_0)
	local var_23_0 = SummonMainModel.instance:getCurPool()
	local var_23_1 = SummonMainModel.instance:getCurADPageIndex()

	if not var_23_0 then
		return
	end

	if not SummonMainModel.instance:getById(var_23_0.id) then
		if SummonMainModel.instance:trySetSelectPoolIndex(1) then
			SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
		end
	elseif var_23_1 ~= arg_23_0._tabIndex then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
	end
end

function var_0_0.repeatCallCountdown(arg_24_0)
	SummonController.instance:dispatchEvent(SummonEvent.onRemainTimeCountdown)
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.afterBlackLoading, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.afterCloseLoading, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.checkCallPreloader, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.repeatCallCountdown, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.returnToMainScene, arg_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0

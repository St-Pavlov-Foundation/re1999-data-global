module("modules.logic.summon.view.SummonMainView", package.seeall)

slot0 = class("SummonMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#go_ui/#go_drag")
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "#go_ui/#go_category")
	slot0._scrollcategory = gohelper.findChildScrollRect(slot0.viewGO, "#go_ui/#go_category/#scroll_category")
	slot0._gonormalRoleCategoryItem = gohelper.findChild(slot0.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_normalRoleCategoryItem")
	slot0._goequipCategoryItem = gohelper.findChild(slot0.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_equipCategoryItem")
	slot0._goRoleUpCategoryItem = gohelper.findChild(slot0.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/GameObject/#go_RoleUpCategoryItem")
	slot0._btnconvertStore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/btns/#btn_convertStore")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/btns/#btn_detail")
	slot0._btnsummonrecord = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/btns/#btn_summonrecord")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconvertStore:AddClickListener(slot0._btnconvertStoreOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnsummonrecord:AddClickListener(slot0._btnsummonrecordOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconvertStore:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	slot0._btnsummonrecord:RemoveClickListener()
end

function slot0._btnconvertStoreOnClick(slot0)
	slot2 = StoreEnum.SummonExchange

	if SummonMainModel.instance:getCurPool() and SummonMainModel.getResultType(slot1) == SummonEnum.ResultType.Equip then
		slot2 = StoreEnum.SummonEquipExchange
	end

	StoreController.instance:checkAndOpenStoreView(slot2)
end

function slot0._btndetailOnClick(slot0)
	SummonMainController.instance:openSummonDetail(SummonMainModel.instance:getCurPool())
end

function slot0._btnsummonrecordOnClick(slot0)
	ViewMgr.instance:openView(ViewName.SummonPoolHistoryView)
end

function slot0._editableInitView(slot0)
	slot0._txtrecord = gohelper.findChildTextMesh(slot0.viewGO, "#go_ui/btns/#btn_summonrecord/txt")
	slot0._goblackloading = gohelper.findChild(slot0.viewGO, "#blackloading")
	slot0._animLoading = slot0._goblackloading:GetComponent(typeof(UnityEngine.Animator))
	slot0._animUI = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	SummonMainModel.instance:setFirstTimeSwitch(true)
	gohelper.addUIClickAudio(slot0._btnconvertStore.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
	gohelper.addUIClickAudio(slot0._btndetail.gameObject, AudioEnum.UI.play_ui_checkpoint_click)
end

function slot0._handleTabSet(slot0)
	if SummonMainModel.instance:getCurADPageIndex() then
		slot0:checkCallPreloader()
		slot0.viewContainer:refreshCurrencyType()
	end

	slot0._tabIndex = slot1

	if SummonMainModel.getResultType(SummonMainModel.instance:getCurPool()) == SummonEnum.ResultType.Equip then
		slot0._txtrecord:SetText(luaLang("p_summonpool_equip_record"))
	else
		slot0._txtrecord:SetText(luaLang("p_summonpool_record"))
	end
end

function slot0.onUpdateParam(slot0)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
end

function slot0.onOpen(slot0)
	if not SummonMainModel.instance:getList() or #slot1 <= 0 then
		logError("没有卡池")
		TaskDispatcher.runDelay(slot0.returnToMainScene, slot0, 2)

		return
	end

	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, slot0._handleTabSet, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.checkCallPreloader, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.onSummonInfoGot, slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.viewContainer.refreshHelp, slot0.viewContainer)
	slot0:addEventCb(SummonController.instance, SummonEvent.summonShowBlackScreen, slot0.onReceiveShowBlackScreen, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.summonShowExitAnim, slot0.startExitLoading, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.summonCloseBlackScreen, slot0.onReceiveCloseBlackScreen, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.summonMainCloseImmediately, slot0.closeThis, slot0)
	TaskDispatcher.runRepeat(slot0.repeatCallCountdown, slot0, 10)

	if SDKChannelEventModel.instance:needAppReview() then
		SDKController.instance:openSDKScoreJumpView()
	end
end

function slot0.onOpenFinish(slot0)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonUI)
end

function slot0.returnToMainScene(slot0)
	MainController.instance:enterMainScene(true)
	VirtualSummonScene.instance:close(true)
	ViewMgr.instance:closeView(ViewName.SummonADView)
	ViewMgr.instance:closeView(ViewName.SummonView)
end

function slot0.checkCallPreloader(slot0)
	TaskDispatcher.cancelTask(slot0.delayLoadSceneResPreloader, slot0)
	TaskDispatcher.runDelay(slot0.delayLoadSceneResPreloader, slot0, 1)
end

function slot0.delayLoadSceneResPreloader(slot0)
	VirtualSummonScene.instance:checkNeedLoad(SummonMainModel.getResultTypeById(SummonMainModel.instance:getCurId()) == SummonEnum.ResultType.Char, false)
end

function slot0.onSummonInfoGot(slot0)
	if not SummonMainModel.instance:getList() or #slot1 <= 0 then
		logError("返回消息没有卡池")
		TaskDispatcher.runDelay(slot0.returnToMainScene, slot0, 1)

		return
	end

	slot0:checkCurPoolValid()
end

function slot0.onReceiveShowBlackScreen(slot0)
	gohelper.setActive(slot0._goblackloading, true)
	slot0._animLoading:Play("blackloading_open", 0, 0)

	slot0._isShowBlackScreen = true

	TaskDispatcher.runDelay(slot0.afterBlackLoading, slot0, 0.3)
end

function slot0.afterBlackLoading(slot0)
	TaskDispatcher.cancelTask(slot0.afterBlackLoading, slot0)
	gohelper.setActive(slot0._goui, false)
	SummonController.instance:onFirstLoadSceneBlock()
end

function slot0.onReceiveCloseBlackScreen(slot0)
	if not gohelper.isNil(slot0._animLoading) then
		slot0._animLoading:Play("blackloading_close", 0, 0)
	end

	TaskDispatcher.runDelay(slot0.afterCloseLoading, slot0, 0.4)
end

function slot0.afterCloseLoading(slot0)
	logNormal("close SummonMainView")
	TaskDispatcher.cancelTask(slot0.afterCloseLoading, slot0)
	slot0:closeThis()
end

function slot0.startExitLoading(slot0)
	if not gohelper.isNil(slot0._animUI) then
		slot0._animUI:Play(UIAnimationName.Close, 0, 0)
	end

	if slot0.viewContainer:getCurTabInst() and not gohelper.isNil(slot1.viewGO) and slot1.viewGO:GetComponent(typeof(UnityEngine.Animator)) then
		slot2:Play(UIAnimationName.Close, 0, 0)
	end

	return 0.16
end

function slot0.startExitSummonFadeOut(slot0)
	if not gohelper.isNil(slot0._animUI) then
		slot0._animUI:Play("out", 0, 0)
	end

	return 0.16
end

function slot0.checkCurPoolValid(slot0)
	slot2 = SummonMainModel.instance:getCurADPageIndex()

	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if not SummonMainModel.instance:getById(slot1.id) then
		if SummonMainModel.instance:trySetSelectPoolIndex(1) then
			SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
		end
	elseif slot2 ~= slot0._tabIndex then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
	end
end

function slot0.repeatCallCountdown(slot0)
	SummonController.instance:dispatchEvent(SummonEvent.onRemainTimeCountdown)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.afterBlackLoading, slot0)
	TaskDispatcher.cancelTask(slot0.afterCloseLoading, slot0)
	TaskDispatcher.cancelTask(slot0.checkCallPreloader, slot0)
	TaskDispatcher.cancelTask(slot0.repeatCallCountdown, slot0)
	TaskDispatcher.cancelTask(slot0.returnToMainScene, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

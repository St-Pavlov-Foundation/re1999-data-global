module("modules.logic.versionactivity.view.VersionActivityDungeonMapView", package.seeall)

local var_0_0 = class("VersionActivityDungeonMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topLeftGo = gohelper.findChild(arg_1_0.viewGO, "top_left")
	arg_1_0._topRightGo = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._topLeftElementGo = gohelper.findChild(arg_1_0.viewGO, "top_left_element")
	arg_1_0._goversionactivity = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "#go_main")
	arg_1_0._gores = gohelper.findChild(arg_1_0.viewGO, "#go_res")
	arg_1_0._btnequipstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_equipstore")
	arg_1_0._btnactivitystore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitystore")
	arg_1_0._btnactivitytask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitytask")
	arg_1_0._txtstorenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._scrollcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnactivitystore:AddClickListener(arg_2_0.btnActivityStoreOnClick, arg_2_0)
	arg_2_0._btnactivitytask:AddClickListener(arg_2_0.btnActivityTaskOnClick, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnactivitystore:RemoveClickListener()
	arg_3_0._btnactivitytask:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()
end

function var_0_0.btnActivityStoreOnClick(arg_4_0)
	VersionActivityController.instance:openLeiMiTeBeiStoreView(VersionActivityEnum.ActivityId.Act113)
end

function var_0_0.btnActivityTaskOnClick(arg_5_0)
	VersionActivityController.instance:openLeiMiTeBeiTaskView()
end

function var_0_0._btncloseviewOnClick(arg_6_0)
	arg_6_0:_showSwitchMode()
	ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapLevelView)
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._goversionactivity, true)
	gohelper.setActive(arg_7_0._btnactivitystore.gameObject, false)
	gohelper.setActive(arg_7_0._btnactivitytask.gameObject, false)
	gohelper.setActive(arg_7_0._gomain, false)
	gohelper.setActive(arg_7_0._gores, false)
	gohelper.setActive(arg_7_0._btnequipstore.gameObject, false)

	arg_7_0.modeAnimator = arg_7_0._goversionactivity:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0.txtTaskGet = gohelper.findChildText(arg_7_0.viewGO, "#go_topright/#btn_activitytask/#txt_get")
	arg_7_0.goTaskRedDot = gohelper.findChild(arg_7_0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")

	RedDotController.instance:addRedDot(arg_7_0.goTaskRedDot, RedDotEnum.DotNode.LeiMiTeBeiTask)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_7_0.refreshTaskUI, arg_7_0)
	gohelper.removeUIClickAudio(arg_7_0._btncloseview.gameObject)

	arg_7_0._rectmask2D = arg_7_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_7_0._goSwitchMode = gohelper.findChild(arg_7_0.viewGO, "#go_tasklist")
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0._onEscBtnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_10_0._onOpenView, arg_10_0)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_10_0._onCloseView, arg_10_0)
	arg_10_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_10_0._setEpisodeListVisible, arg_10_0)
	arg_10_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_10_0.refreshActivityCurrency, arg_10_0)
	arg_10_0:refreshUI()
	NavigateMgr.instance:addEscape(ViewName.VersionActivityDungeonMapView, arg_10_0._onEscBtnClick, arg_10_0)

	if ViewMgr.instance:isOpen(ViewName.VersionActivityDungeonMapLevelView) then
		arg_10_0:_onOpenView(ViewName.VersionActivityDungeonMapLevelView)
	end

	arg_10_0:_showSwitchMode()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0:refreshTaskUI()
	arg_11_0:refreshActivityCurrency()
end

function var_0_0.refreshTaskUI(arg_12_0)
	arg_12_0.txtTaskGet.text = string.format("%s/%s", arg_12_0:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivityEnum.ActivityId.Act113))
end

function var_0_0.refreshActivityCurrency(arg_13_0)
	local var_13_0 = ReactivityModel.instance:getActivityCurrencyId(VersionActivityEnum.ActivityId.Act113)
	local var_13_1 = CurrencyModel.instance:getCurrency(var_13_0)
	local var_13_2 = var_13_1 and var_13_1.quantity or 0

	arg_13_0._txtstorenum.text = GameUtil.numberDisplay(var_13_2)
end

function var_0_0.getFinishTaskCount(arg_14_0)
	local var_14_0 = 0
	local var_14_1

	for iter_14_0, iter_14_1 in ipairs(VersionActivityConfig.instance:getAct113TaskList(VersionActivityEnum.ActivityId.Act113)) do
		local var_14_2 = TaskModel.instance:getTaskById(iter_14_1.id)

		if var_14_2 and var_14_2.finishCount >= iter_14_1.maxFinishCount then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

function var_0_0._setEpisodeListVisible(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._topLeftGo, arg_15_1)

	if arg_15_1 then
		arg_15_0.modeAnimator:Play(UIAnimationName.Open, 0, 0)
	else
		arg_15_0.modeAnimator:Play(UIAnimationName.Close, 0, 0)
	end
end

function var_0_0._onOpenView(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.VersionActivityDungeonMapLevelView then
		arg_16_0.modeAnimator:Play(UIAnimationName.Close, 0, 0)
		gohelper.setActive(arg_16_0._btncloseview, true)

		arg_16_0._rectmask2D.padding = Vector4(0, 0, 600, 0)

		TaskDispatcher.cancelTask(arg_16_0._hideSwitchMode, arg_16_0)
		TaskDispatcher.runDelay(arg_16_0._hideSwitchMode, arg_16_0, 0.667)
	end
end

function var_0_0._onCloseView(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.VersionActivityDungeonMapLevelView then
		arg_17_0.modeAnimator:Play(UIAnimationName.Open, 0, 0)
		gohelper.setActive(arg_17_0._btncloseview, false)

		arg_17_0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		arg_17_0:_showSwitchMode()
	end
end

function var_0_0._showSwitchMode(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._hideSwitchMode, arg_18_0)
	gohelper.setActive(arg_18_0._goSwitchMode, true)
end

function var_0_0._hideSwitchMode(arg_19_0)
	gohelper.setActive(arg_19_0._goSwitchMode, false)

	arg_19_0._isShowSwitchMode = false
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0

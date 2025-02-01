module("modules.logic.versionactivity.view.VersionActivityDungeonMapView", package.seeall)

slot0 = class("VersionActivityDungeonMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._topLeftGo = gohelper.findChild(slot0.viewGO, "top_left")
	slot0._topRightGo = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._topLeftElementGo = gohelper.findChild(slot0.viewGO, "top_left_element")
	slot0._goversionactivity = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity")
	slot0._gomain = gohelper.findChild(slot0.viewGO, "#go_main")
	slot0._gores = gohelper.findChild(slot0.viewGO, "#go_res")
	slot0._btnequipstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_equipstore")
	slot0._btnactivitystore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitystore")
	slot0._btnactivitytask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitytask")
	slot0._txtstorenum = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._scrollcontent = gohelper.findChild(slot0.viewGO, "#scroll_content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnactivitystore:AddClickListener(slot0.btnActivityStoreOnClick, slot0)
	slot0._btnactivitytask:AddClickListener(slot0.btnActivityTaskOnClick, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnactivitystore:RemoveClickListener()
	slot0._btnactivitytask:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()
end

function slot0.btnActivityStoreOnClick(slot0)
	VersionActivityController.instance:openLeiMiTeBeiStoreView(VersionActivityEnum.ActivityId.Act113)
end

function slot0.btnActivityTaskOnClick(slot0)
	VersionActivityController.instance:openLeiMiTeBeiTaskView()
end

function slot0._btncloseviewOnClick(slot0)
	slot0:_showSwitchMode()
	ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapLevelView)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goversionactivity, true)
	gohelper.setActive(slot0._btnactivitystore.gameObject, false)
	gohelper.setActive(slot0._btnactivitytask.gameObject, false)
	gohelper.setActive(slot0._gomain, false)
	gohelper.setActive(slot0._gores, false)
	gohelper.setActive(slot0._btnequipstore.gameObject, false)

	slot0.modeAnimator = slot0._goversionactivity:GetComponent(typeof(UnityEngine.Animator))
	slot0.txtTaskGet = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitytask/#txt_get")
	slot0.goTaskRedDot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")

	RedDotController.instance:addRedDot(slot0.goTaskRedDot, RedDotEnum.DotNode.LeiMiTeBeiTask)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshTaskUI, slot0)
	gohelper.removeUIClickAudio(slot0._btncloseview.gameObject)

	slot0._rectmask2D = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._goSwitchMode = gohelper.findChild(slot0.viewGO, "#go_tasklist")
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0._onEscBtnClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:refreshUI()
	NavigateMgr.instance:addEscape(ViewName.VersionActivityDungeonMapView, slot0._onEscBtnClick, slot0)

	if ViewMgr.instance:isOpen(ViewName.VersionActivityDungeonMapLevelView) then
		slot0:_onOpenView(ViewName.VersionActivityDungeonMapLevelView)
	end

	slot0:_showSwitchMode()
end

function slot0.refreshUI(slot0)
	slot0:refreshTaskUI()
	slot0:refreshActivityCurrency()
end

function slot0.refreshTaskUI(slot0)
	slot0.txtTaskGet.text = string.format("%s/%s", slot0:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivityEnum.ActivityId.Act113))
end

function slot0.refreshActivityCurrency(slot0)
	slot0._txtstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(ReactivityModel.instance:getActivityCurrencyId(VersionActivityEnum.ActivityId.Act113)) and slot2.quantity or 0)
end

function slot0.getFinishTaskCount(slot0)
	slot2 = nil
	slot6 = VersionActivityEnum.ActivityId.Act113

	for slot6, slot7 in ipairs(VersionActivityConfig.instance:getAct113TaskList(slot6)) do
		if TaskModel.instance:getTaskById(slot7.id) and slot7.maxFinishCount <= slot2.finishCount then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0._setEpisodeListVisible(slot0, slot1)
	gohelper.setActive(slot0._topLeftGo, slot1)

	if slot1 then
		slot0.modeAnimator:Play(UIAnimationName.Open, 0, 0)
	else
		slot0.modeAnimator:Play(UIAnimationName.Close, 0, 0)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.VersionActivityDungeonMapLevelView then
		slot0.modeAnimator:Play(UIAnimationName.Close, 0, 0)
		gohelper.setActive(slot0._btncloseview, true)

		slot0._rectmask2D.padding = Vector4(0, 0, 600, 0)

		TaskDispatcher.cancelTask(slot0._hideSwitchMode, slot0)
		TaskDispatcher.runDelay(slot0._hideSwitchMode, slot0, 0.667)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivityDungeonMapLevelView then
		slot0.modeAnimator:Play(UIAnimationName.Open, 0, 0)
		gohelper.setActive(slot0._btncloseview, false)

		slot0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		slot0:_showSwitchMode()
	end
end

function slot0._showSwitchMode(slot0)
	TaskDispatcher.cancelTask(slot0._hideSwitchMode, slot0)
	gohelper.setActive(slot0._goSwitchMode, true)
end

function slot0._hideSwitchMode(slot0)
	gohelper.setActive(slot0._goSwitchMode, false)

	slot0._isShowSwitchMode = false
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

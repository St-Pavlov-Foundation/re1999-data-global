module("modules.logic.versionactivity2_5.enter.view.subview.VersionActivity2_5ChallengeEnterView", package.seeall)

slot0 = class("VersionActivity2_5ChallengeEnterView", BaseView)
slot1 = 0.8
slot2 = 0.8

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/#txt_limittime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/#txt_Descr")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._btnReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Reward")
	slot0._gorewardreddot = gohelper.findChild(slot0.viewGO, "Right/#btn_Reward/#go_rewardreddot")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#go_Tips")
	slot0._txtUnLocked = gohelper.findChildText(slot0.viewGO, "Right/#btn_Enter/#go_Tips/#txt_UnLocked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
	slot0._btnReward:AddClickListener(slot0._btnRewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnReward:RemoveClickListener()
end

function slot0._btnEnterOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot1 == ActivityEnum.ActivityStatus.NotUnlock and slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		return
	end

	Act183Controller.instance:openAct183MainView()
end

function slot0._btnRewardOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot1 == ActivityEnum.ActivityStatus.NotUnlock and slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		return
	end

	Act183Controller.instance:openAct183TaskView()
end

function slot0._editableInitView(slot0)
	slot0.actId = slot0.viewContainer.activityId
	slot0.config = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot0._txtDescr.text = slot0.config.actDesc
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
	slot0._rewardReddotAnim = gohelper.findChildComponent(slot0._btnReward.gameObject, "ani", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(slot0._gorewardreddot, RedDotEnum.DotNode.V2a5_Act183Task, nil, slot0._taskReddotFunc, slot0)
	Act183Model.instance:setActivityId(slot0.actId)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V2a5_Act183Task
	})

	slot0._imagetaskicon = gohelper.findChildImage(slot0.viewGO, "Right/#btn_Reward/ani/baoxiang")

	slot0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.onSelectActId, slot0, LuaEventSystem.Low)
end

function slot0._taskReddotFunc(slot0, slot1)
	slot1:defaultRefreshDot()
	slot0._rewardReddotAnim:Play(slot1.show and "loop" or "idle", 0, 0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._onActStatusChange, slot0)
	slot0:_freshLockStatus()
	slot0:_showLeftTime()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 1)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

function slot0._freshLockStatus(slot0)
	slot2 = ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.NotUnlock

	ZProj.UGUIHelper.SetGrayscale(slot0._btnEnter.gameObject, slot2)
	ZProj.UGUIHelper.SetGrayscale(slot0._imagetaskicon.gameObject, slot2)
	gohelper.setActive(slot0._goTips, slot2)

	if slot2 then
		ZProj.UGUIHelper.SetGrayFactor(slot0._btnEnter.gameObject, uv0)
		ZProj.UGUIHelper.SetGrayFactor(slot0._imagetaskicon.gameObject, uv1)

		slot0._txtUnLocked.text = OpenHelper.getActivityUnlockTxt(slot0.config.openId)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0._onActStatusChange(slot0)
	slot0:_freshLockStatus()
end

function slot0.onSelectActId(slot0, slot1)
	if slot0.actId ~= slot1 then
		return
	end

	slot0._animator:Play("open", 0, 0)
end

return slot0

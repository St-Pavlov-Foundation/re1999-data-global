module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickFullView", package.seeall)

slot0 = class("SummonNewCustomPickFullView", BaseView)
slot0.DEFAULT_REFRESH_DELAY = 0.4
slot0.TIME_REFRESH_DURATION = 10

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "role/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "role/#simage_role2")
	slot0._simagerole3 = gohelper.findChildSingleImage(slot0.viewGO, "role/#simage_role3")
	slot0._simagerole4 = gohelper.findChildSingleImage(slot0.viewGO, "role/#simage_role4")
	slot0._simagedecbg = gohelper.findChildSingleImage(slot0.viewGO, "role/#simage_decbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "logo/#simage_title")
	slot0._simagetitle2 = gohelper.findChildSingleImage(slot0.viewGO, "logo/#simage_title2")
	slot0._simagefrontbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_frontbg")
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "timebg/#txt_remainTime")
	slot0._goinviteContent = gohelper.findChild(slot0.viewGO, "#go_inviteContent")
	slot0._gouninvite = gohelper.findChild(slot0.viewGO, "#go_inviteContent/#go_uninvite")
	slot0._btninvite = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	slot0._btnuninviteTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_inviteContent/#go_uninvite/#btn_uninviteTips")
	slot0._goinvited = gohelper.findChild(slot0.viewGO, "#go_inviteContent/#go_invited")
	slot0._btninviteTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips")
	slot0._simagerolehead = gohelper.findChildSingleImage(slot0.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips/#simage_rolehead")
	slot0._txtrolename = gohelper.findChildText(slot0.viewGO, "#go_inviteContent/#go_invited/#txt_rolename")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btninvite:AddClickListener(slot0._btninviteOnClick, slot0)
	slot0._btnuninviteTips:AddClickListener(slot0._btnuninviteTipsOnClick, slot0)
	slot0._btninviteTips:AddClickListener(slot0._btninviteTipsOnClick, slot0)
	slot0:addEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, slot0._onGetReward, slot0)
	slot0:addEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetServerInfoReply, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btninvite:RemoveClickListener()
	slot0._btnuninviteTips:RemoveClickListener()
	slot0._btninviteTips:RemoveClickListener()
	slot0:removeEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, slot0._onGetReward, slot0)
	slot0:removeEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetServerInfoReply, slot0._refreshUI, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._delayRefreshUI, slot0)
	TaskDispatcher.cancelTask(slot0._refreshTime, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnuninviteTipsOnClick(slot0)
	ViewMgr.instance:openView(ViewName.SummonNewCustomPickTipsView)
end

function slot0._btninviteTipsOnClick(slot0)
	if not SummonNewCustomPickViewModel.instance:getActivityInfo(slot0._actId) or not slot1.heroId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = slot1.heroId
	})
end

function slot0._btninviteOnClick(slot0)
	if not slot0._actId then
		return
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(slot1) then
		return
	end

	if SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		ViewMgr.instance:openView(ViewName.SummonNewCustomPickChoiceView, {
			actId = slot1
		})
	else
		SummonNewCustomPickChoiceController.instance:trySendSummon()
	end
end

function slot0._onGetReward(slot0, slot1, slot2)
	if slot1 ~= slot0._actId then
		return
	end

	if not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		SummonNewCustomPickChoiceController.instance:onGetReward(1, {
			slot2
		})
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._delayRefreshUI, slot0)
end

function slot0._editableInitView(slot0)
	slot0._getRewardAnim = slot0._goinvited:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.SummonNewCustomSkin.play_ui_youyu_liuxing_give)
	slot0:_checkParam()
	slot0:_refreshUI()
	slot0:_addTimeRefreshTask()
end

function slot0._addTimeRefreshTask(slot0)
	if not slot0._actId then
		return
	end

	TaskDispatcher.runRepeat(slot0._refreshTime, slot0, slot0.TIME_REFRESH_DURATION)
end

function slot0._checkParam(slot0)
	slot1 = slot0.viewParam.actId
	slot0._actId = slot1

	SummonNewCustomPickViewModel.instance:setCurActId(slot1)

	if slot0.viewParam.refreshData == nil or slot0.viewParam.refreshData == true then
		SummonNewCustomPickViewController.instance:getSummonInfo(slot1)
	end
end

function slot0._delayRefreshUI(slot0, slot1)
	if slot1 == SummonNewCustomPickChoiceController.instance:getCurrentListenViewName() then
		slot0:_refreshUI()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._delayRefreshUI, slot0)
	end
end

function slot0._refreshUI(slot0)
	slot1 = SummonNewCustomPickViewModel.instance:isGetReward(slot0._actId)

	gohelper.setActive(slot0._goinvited, slot1)
	gohelper.setActive(slot0._gouninvite, not slot1)

	if slot1 then
		slot0:_refreshSelectRole()
	end

	slot0:_refreshTime()
	slot0:_checkShowFx()
end

function slot0._checkShowFx(slot0)
	if SummonNewCustomPickViewModel.instance:getGetRewardFxState(slot0._actId) then
		slot0._getRewardAnim:Play(UIAnimationName.Open, 0, 0)
		SummonNewCustomPickViewModel.instance:setGetRewardFxState(slot1, false)
	else
		slot0._getRewardAnim:Play(UIAnimationName.Idle, 0, 0)
	end
end

function slot0._refreshTime(slot0)
	if ActivityModel.instance:getActMO(slot0._actId):getRealEndTimeStamp() <= ServerTime.now() then
		slot0._txtremainTime.text = luaLang("ended")

		return
	end

	slot0._txtremainTime.text = TimeUtil.SecondToActivityTimeFormat(slot2 - slot3)
end

function slot0._refreshSelectRole(slot0)
	if not HeroConfig.instance:getHeroCO(SummonNewCustomPickViewModel.instance:getActivityInfo(slot0._actId).heroId) then
		logError("SummonNewCustomPick.refreshUI error, heroConfig is nil, id:" .. tostring(slot2))

		return
	end

	if not SkinConfig.instance:getSkinCo(slot3.skinId) then
		logError("SummonNewCustomPick.refreshUI error,  skinCfg is nil, id:" .. tostring(slot3.skinId))

		return
	end

	slot0._simagerolehead:LoadImage(ResUrl.getRoomHeadIcon(slot4.headIcon))

	slot0._txtrolename.text = slot3.name
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagerolehead:UnLoadImage()
end

return slot0

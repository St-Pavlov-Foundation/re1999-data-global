module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickView", package.seeall)

local var_0_0 = class("SummonNewCustomPickView", BaseView)

var_0_0.DEFAULT_REFRESH_DELAY = 0.4
var_0_0.TIME_REFRESH_DURATION = 10

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/#simage_role1")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/#simage_role2")
	arg_1_0._simagerole3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/#simage_role3")
	arg_1_0._simagerole4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/#simage_role4")
	arg_1_0._simagedecbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/#simage_decbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "logo/#simage_title")
	arg_1_0._simagetitle2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "logo/#simage_title2")
	arg_1_0._simagefrontbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_frontbg")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "timebg/#txt_remainTime")
	arg_1_0._goinviteContent = gohelper.findChild(arg_1_0.viewGO, "#go_inviteContent")
	arg_1_0._gouninvite = gohelper.findChild(arg_1_0.viewGO, "#go_inviteContent/#go_uninvite")
	arg_1_0._btninvite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	arg_1_0._btnuninviteTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_inviteContent/#go_uninvite/#btn_uninviteTips")
	arg_1_0._goinvited = gohelper.findChild(arg_1_0.viewGO, "#go_inviteContent/#go_invited")
	arg_1_0._btninviteTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips")
	arg_1_0._simagerolehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips/#simage_rolehead")
	arg_1_0._txtrolename = gohelper.findChildText(arg_1_0.viewGO, "#go_inviteContent/#go_invited/#txt_rolename")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninvite:AddClickListener(arg_2_0._btninviteOnClick, arg_2_0)
	arg_2_0._btnuninviteTips:AddClickListener(arg_2_0._btnuninviteTipsOnClick, arg_2_0)
	arg_2_0._btninviteTips:AddClickListener(arg_2_0._btninviteTipsOnClick, arg_2_0)
	arg_2_0:addEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, arg_2_0._onGetReward, arg_2_0)
	arg_2_0:addEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetServerInfoReply, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninvite:RemoveClickListener()
	arg_3_0._btnuninviteTips:RemoveClickListener()
	arg_3_0._btninviteTips:RemoveClickListener()
	arg_3_0:removeEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, arg_3_0._onGetReward, arg_3_0)
	arg_3_0:removeEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetServerInfoReply, arg_3_0._refreshUI, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._delayRefreshUI, arg_3_0)
end

function var_0_0._btnuninviteTipsOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.SummonNewCustomPickTipsView)
end

function var_0_0._btninviteTipsOnClick(arg_5_0)
	local var_5_0 = SummonNewCustomPickViewModel.instance:getActivityInfo(arg_5_0._actId)

	if not var_5_0 or not var_5_0.heroId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = var_5_0.heroId
	})
end

function var_0_0._btninviteOnClick(arg_6_0)
	local var_6_0 = arg_6_0._actId

	if not var_6_0 then
		return
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(var_6_0) then
		return
	end

	if SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		ViewMgr.instance:openView(ViewName.SummonNewCustomPickChoiceView, {
			actId = var_6_0
		})
	else
		SummonNewCustomPickChoiceController.instance:trySendSummon()
	end
end

function var_0_0._onGetReward(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= arg_7_0._actId then
		return
	end

	if not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		SummonNewCustomPickChoiceController.instance:onGetReward(2, {
			arg_7_2
		})
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_7_0._delayRefreshUI, arg_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._goblackloading = gohelper.findChild(arg_8_0.viewGO, "#blackloading")
	arg_8_0._animLoading = arg_8_0._goblackloading:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._animUI = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._getRewardAnim = arg_8_0._goinvited:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.SummonNewCustomSkin.play_ui_youyu_liuxing_give)
	arg_10_0:_checkParam()
	arg_10_0:_refreshUI()
	arg_10_0:_addTimeRefreshTask()
end

function var_0_0._addTimeRefreshTask(arg_11_0)
	if not arg_11_0._actId then
		return
	end

	TaskDispatcher.runDelay(arg_11_0._refreshTime, arg_11_0, arg_11_0.TIME_REFRESH_DURATION)
end

function var_0_0._checkParam(arg_12_0)
	arg_12_0._actId = arg_12_0.viewParam.actId

	SummonNewCustomPickViewModel.instance:setCurActId(arg_12_0._actId)

	local var_12_0 = arg_12_0.viewParam.parent

	if var_12_0 then
		gohelper.addChild(var_12_0, arg_12_0.viewGO)
	end

	if arg_12_0.viewParam.refreshData == nil or arg_12_0.viewParam.refreshData == true then
		SummonNewCustomPickViewController.instance:getSummonInfo(arg_12_0._actId)
	end
end

function var_0_0._delayRefreshUI(arg_13_0, arg_13_1)
	if arg_13_1 == SummonNewCustomPickChoiceController.instance:getCurrentListenViewName() then
		arg_13_0:_refreshUI()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_13_0._delayRefreshUI, arg_13_0)
	end
end

function var_0_0._refreshUI(arg_14_0)
	local var_14_0 = SummonNewCustomPickViewModel.instance:isGetReward(arg_14_0._actId)

	gohelper.setActive(arg_14_0._goinvited, var_14_0)
	gohelper.setActive(arg_14_0._gouninvite, not var_14_0)

	if var_14_0 then
		arg_14_0:_refreshSelectRole()
	end

	arg_14_0:_refreshTime()
	arg_14_0:_checkShowFx()
end

function var_0_0._checkShowFx(arg_15_0)
	local var_15_0 = arg_15_0._actId

	if SummonNewCustomPickViewModel.instance:getGetRewardFxState(var_15_0) then
		arg_15_0._getRewardAnim:Play(UIAnimationName.Open, 0, 0)
		SummonNewCustomPickViewModel.instance:setGetRewardFxState(var_15_0, false)
	else
		arg_15_0._getRewardAnim:Play(UIAnimationName.Idle, 0, 0)
	end
end

function var_0_0._refreshTime(arg_16_0)
	local var_16_0 = ActivityModel.instance:getActMO(arg_16_0._actId):getRealEndTimeStamp()
	local var_16_1 = ServerTime.now()

	if var_16_0 <= var_16_1 then
		arg_16_0._txtremainTime.text = luaLang("ended")

		return
	end

	local var_16_2 = TimeUtil.SecondToActivityTimeFormat(var_16_0 - var_16_1)

	arg_16_0._txtremainTime.text = var_16_2
end

function var_0_0._refreshSelectRole(arg_17_0)
	local var_17_0 = SummonNewCustomPickViewModel.instance:getActivityInfo(arg_17_0._actId).heroId
	local var_17_1 = HeroConfig.instance:getHeroCO(var_17_0)

	if not var_17_1 then
		logError("SummonNewCustomPick.refreshUI error, heroConfig is nil, id:" .. tostring(var_17_0))

		return
	end

	local var_17_2 = SkinConfig.instance:getSkinCo(var_17_1.skinId)

	if not var_17_2 then
		logError("SummonNewCustomPick.refreshUI error,  skinCfg is nil, id:" .. tostring(var_17_1.skinId))

		return
	end

	arg_17_0._simagerolehead:LoadImage(ResUrl.getRoomHeadIcon(var_17_2.headIcon))

	arg_17_0._txtrolename.text = var_17_1.name
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._refreshTime, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._simagerolehead:UnLoadImage()
end

return var_0_0

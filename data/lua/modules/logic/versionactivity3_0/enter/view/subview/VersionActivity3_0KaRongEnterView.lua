module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0KaRongEnterView", package.seeall)

local var_0_0 = class("VersionActivity3_0KaRongEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_Descr")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._txtLocked = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	arg_1_0._btnTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/#btn_Trial")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
	arg_2_0._btnTrial:AddClickListener(arg_2_0._btnTrialOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
	arg_3_0._btnTrial:RemoveClickListener()
end

function var_0_0._btnEnterOnClick(arg_4_0)
	local var_4_0 = arg_4_0.config.confirmCondition

	if string.nilorempty(var_4_0) then
		RoleActivityController.instance:enterActivity(arg_4_0.actId)
	else
		local var_4_1 = string.split(var_4_0, "=")
		local var_4_2 = tonumber(var_4_1[2])
		local var_4_3 = PlayerModel.instance:getPlayinfo().userId
		local var_4_4 = PlayerPrefsKey.EnterRoleActivity .. arg_4_0.actId .. var_4_3
		local var_4_5 = PlayerPrefsHelper.getNumber(var_4_4, 0) == 1

		if OpenModel.instance:isFunctionUnlock(var_4_2) or var_4_5 then
			RoleActivityController.instance:enterActivity(arg_4_0.actId)
		else
			local var_4_6 = OpenConfig.instance:getOpenCo(var_4_2)
			local var_4_7 = DungeonConfig.instance:getEpisodeDisplay(var_4_6.episodeId)
			local var_4_8 = DungeonConfig.instance:getEpisodeCO(var_4_6.episodeId).name
			local var_4_9 = var_4_7 .. var_4_8

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(var_4_4, 1)
				RoleActivityController.instance:enterActivity(arg_4_0.actId)
			end, nil, nil, nil, nil, nil, var_4_9)
		end
	end
end

function var_0_0._btnLockedOnClick(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = ActivityHelper.getActivityStatusAndToast(arg_6_0.actId)

	if var_6_0 == ActivityEnum.ActivityStatus.NotUnlock and var_6_1 then
		GameFacade.showToastWithTableParam(var_6_1, var_6_2)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.actId = arg_7_0.viewContainer.activityId
	arg_7_0.config = ActivityConfig.instance:getActivityCo(arg_7_0.actId)
	arg_7_0._txtDescr.text = arg_7_0.config.actDesc

	local var_7_0 = OpenHelper.getActivityUnlockTxt(arg_7_0.config.openId)

	arg_7_0._txtLocked.text = var_7_0
	arg_7_0.animComp = VersionActivitySubAnimatorComp.get(arg_7_0.viewGO, arg_7_0)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_8_0._onActStatusChange, arg_8_0)

	local var_8_0 = gohelper.findChild(arg_8_0._btnEnter.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(var_8_0, RedDotEnum.DotNode.V1a6RoleActivityTask, arg_8_0.actId):setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	arg_8_0:_freshLockStatus()
	arg_8_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_8_0._showLeftTime, arg_8_0, 1)
	arg_8_0.animComp:playOpenAnim()
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._showLeftTime, arg_9_0)
	arg_9_0.animComp:destroy()
end

function var_0_0._freshLockStatus(arg_10_0)
	local var_10_0 = ActivityHelper.getActivityStatus(arg_10_0.actId)

	gohelper.setActive(arg_10_0._btnEnter, var_10_0 ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(arg_10_0._btnLocked, var_10_0 == ActivityEnum.ActivityStatus.NotUnlock)
end

function var_0_0._showLeftTime(arg_11_0)
	arg_11_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_11_0.actId)
end

function var_0_0._onActStatusChange(arg_12_0)
	arg_12_0:_freshLockStatus()
end

function var_0_0._clickLock(arg_13_0)
	local var_13_0, var_13_1 = OpenHelper.getToastIdAndParam(arg_13_0.config.openId)

	if var_13_0 and var_13_0 ~= 0 then
		GameFacade.showToastWithTableParam(var_13_0, var_13_1)
	end
end

function var_0_0._btnTrialOnClick(arg_14_0)
	if ActivityHelper.getActivityStatus(VersionActivity3_0Enum.ActivityId.KaRong) == ActivityEnum.ActivityStatus.Normal then
		local var_14_0 = arg_14_0.config.tryoutEpisode

		if var_14_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_14_1 = DungeonConfig.instance:getEpisodeCO(var_14_0)

		DungeonFightController.instance:enterFight(var_14_1.chapterId, var_14_0)
	else
		arg_14_0:_clickLock()
	end
end

return var_0_0

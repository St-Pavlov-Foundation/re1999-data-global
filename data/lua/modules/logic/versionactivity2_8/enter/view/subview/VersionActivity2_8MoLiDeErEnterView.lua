module("modules.logic.versionactivity2_8.enter.view.subview.VersionActivity2_8MoLiDeErEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_8MoLiDeErEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._simageTitleeff = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title/#simage_Title_eff")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._txtUnLocked = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	arg_1_0._goTry = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Try")
	arg_1_0._btnTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/#btn_Trial")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Try/#go_Tips")
	arg_1_0._simageReward = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	arg_1_0._btnitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#btn_item")
	arg_1_0._animator = gohelper.findChildComponent(arg_1_0.viewGO, "", gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
	arg_2_0._btnTrial:AddClickListener(arg_2_0._btnTrialOnClick, arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._btnitemOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
	arg_3_0._btnTrial:RemoveClickListener()
	arg_3_0._btnitem:RemoveClickListener()
end

function var_0_0._btnEnterOnClick(arg_4_0)
	MoLiDeErController.instance:enterLevelView(arg_4_0.actId)
end

function var_0_0._btnLockedOnClick(arg_5_0)
	local var_5_0, var_5_1 = OpenHelper.getToastIdAndParam(arg_5_0.actCo.openId)

	if var_5_0 and var_5_0 ~= 0 then
		GameFacade.showToast(var_5_0)
	end
end

function var_0_0._btnitemOnClick(arg_6_0)
	return
end

function var_0_0._btnTrialOnClick(arg_7_0)
	if ActivityHelper.getActivityStatus(arg_7_0.actId) == ActivityEnum.ActivityStatus.Normal then
		local var_7_0 = arg_7_0.actCo.tryoutEpisode

		if var_7_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_7_1 = DungeonConfig.instance:getEpisodeCO(var_7_0)

		DungeonFightController.instance:enterFight(var_7_1.chapterId, var_7_0)
	else
		arg_7_0:_clickLock()
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._btnTrial = gohelper.findChildButtonWithAudio(arg_8_0.viewGO, "Right/#go_Try/#btn_Trial")
	arg_8_0.actId = VersionActivity2_8Enum.ActivityId.MoLiDeEr
	arg_8_0.actCo = ActivityConfig.instance:getActivityCo(arg_8_0.actId)
	arg_8_0._txtDescr.text = arg_8_0.actCo.actDesc
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	RedDotController.instance:addRedDot(arg_10_0._goreddot, RedDotEnum.DotNode.V2a8MoLiDeEr)
	var_0_0.super.onOpen(arg_10_0)
	arg_10_0:_refreshTime()
	TaskDispatcher.runRepeat(arg_10_0._refreshTime, arg_10_0, TimeUtil.OneMinuteSecond)
	arg_10_0._animator:Play("open", 0, 0)
end

function var_0_0._refreshTime(arg_11_0)
	local var_11_0 = arg_11_0.actId
	local var_11_1 = ActivityModel.instance:getActivityInfo()[var_11_0]

	if var_11_1 then
		local var_11_2 = var_11_1:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_11_0._txtLimitTime.gameObject, var_11_2 > 0)

		if var_11_2 > 0 then
			local var_11_3 = TimeUtil.SecondToActivityTimeFormat(var_11_2)

			arg_11_0._txtLimitTime.text = var_11_3
		end

		local var_11_4 = ActivityHelper.getActivityStatus(var_11_0) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_11_0._btnEnter, not var_11_4)
		gohelper.setActive(arg_11_0._btnLocked, var_11_4)
	end
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._refreshTime, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0

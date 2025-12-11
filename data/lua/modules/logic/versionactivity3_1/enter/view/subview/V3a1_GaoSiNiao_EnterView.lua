module("modules.logic.versionactivity3_1.enter.view.subview.V3a1_GaoSiNiao_EnterView", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_EnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_limittime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goEnterRedDot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._txtUnLocked = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	arg_1_0._goTry = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Try")
	arg_1_0._btnTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/#btn_Trial")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Try/#go_Tips")
	arg_1_0._simageReward = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#simage_Reward")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#txt_Num")
	arg_1_0._btnitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/#go_Tips/#btn_item")

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
	arg_4_0:_enterGame()
end

function var_0_0._btnLockedOnClick(arg_5_0)
	arg_5_0:_clickLock()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = GaoSiNiaoConfig.instance:actId()
	arg_6_0.actCo = ActivityConfig.instance:getActivityCo(arg_6_0.actId)
	arg_6_0._txtDescr.text = arg_6_0.actCo.actDesc
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = 0

	RedDotController.instance:addRedDot(arg_7_0._goEnterRedDot, RedDotEnum.DotNode.V3a1GaoSiNiaoTask, var_7_0)
	arg_7_0:_refreshTime()
	TaskDispatcher.cancelTask(arg_7_0._refreshTime, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0._refreshTime, arg_7_0, TimeUtil.OneMinuteSecond)
	arg_7_0._animator:Play("open", 0, 0)
end

function var_0_0._enterGame(arg_8_0)
	local var_8_0 = ActivityConfig.instance:getActivityCo(arg_8_0.actId).confirmCondition

	if string.nilorempty(var_8_0) then
		GaoSiNiaoController.instance:enterLevelView()
	else
		local var_8_1 = string.split(var_8_0, "=")
		local var_8_2 = tonumber(var_8_1[2])
		local var_8_3 = PlayerModel.instance:getPlayinfo().userId
		local var_8_4 = PlayerPrefsKey.EnterRoleActivity .. arg_8_0.actId .. var_8_3
		local var_8_5 = PlayerPrefsHelper.getNumber(var_8_4, 0) == 1

		if OpenModel.instance:isFunctionUnlock(var_8_2) or var_8_5 then
			GaoSiNiaoController.instance:enterLevelView()
		else
			local var_8_6 = OpenConfig.instance:getOpenCo(var_8_2)
			local var_8_7 = DungeonConfig.instance:getEpisodeDisplay(var_8_6.episodeId)
			local var_8_8 = DungeonConfig.instance:getEpisodeCO(var_8_6.episodeId).name
			local var_8_9 = var_8_7 .. var_8_8

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(var_8_4, 1)
				GaoSiNiaoController.instance:enterLevelView()
			end, nil, nil, nil, nil, nil, var_8_9)
		end
	end
end

function var_0_0._clickLock(arg_10_0)
	local var_10_0, var_10_1 = OpenHelper.getToastIdAndParam(arg_10_0.actCo.openId)

	if var_10_0 and var_10_0 ~= 0 then
		GameFacade.showToast(var_10_0)
	end
end

function var_0_0._btnitemOnClick(arg_11_0)
	return
end

function var_0_0._btnTrialOnClick(arg_12_0)
	if ActivityHelper.getActivityStatus(arg_12_0.actId) == ActivityEnum.ActivityStatus.Normal then
		local var_12_0 = arg_12_0.actCo.tryoutEpisode

		if var_12_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_12_1 = DungeonConfig.instance:getEpisodeCO(var_12_0)

		DungeonFightController.instance:enterFight(var_12_1.chapterId, var_12_0)
	else
		arg_12_0:_clickLock()
	end
end

function var_0_0.everySecondCall(arg_13_0)
	arg_13_0:_refreshTime()
end

function var_0_0._refreshTime(arg_14_0)
	local var_14_0 = ActivityModel.instance:getActivityInfo()[arg_14_0.actId]

	if var_14_0 then
		local var_14_1 = var_14_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_14_0._txtlimittime.gameObject, var_14_1 > 0)

		if var_14_1 > 0 then
			local var_14_2 = TimeUtil.SecondToActivityTimeFormat(var_14_1)

			arg_14_0._txtlimittime.text = var_14_2
		end

		local var_14_3 = ActivityHelper.getActivityStatus(arg_14_0.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_14_0._btnEnter, not var_14_3)
		gohelper.setActive(arg_14_0._btnLocked, var_14_3)
	end
end

function var_0_0.onClose(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._refreshTime, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._refreshTime, arg_16_0)
end

return var_0_0

module("modules.logic.versionactivity3_1.enter.view.subview.V3a1_YeShuMeiEnterView", package.seeall)

local var_0_0 = class("V3a1_YeShuMeiEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goEnterRedDot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
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
	arg_2_0._btnEnter:AddClickListener(arg_2_0._enterGame, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._clickLock, arg_2_0)
	arg_2_0._btnTrial:AddClickListener(arg_2_0._btnTrialOnClick, arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._btnitemOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
	arg_3_0._btnTrial:RemoveClickListener()
	arg_3_0._btnitem:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actId = VersionActivity3_1Enum.ActivityId.YeShuMei
	arg_4_0.actCo = ActivityConfig.instance:getActivityCo(arg_4_0.actId)
	arg_4_0._txtDescr.text = arg_4_0.actCo.actDesc
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onOpen(arg_5_0)
	RedDotController.instance:addRedDot(arg_5_0._goEnterRedDot, RedDotEnum.DotNode.V3a1YeShuMeiTask, arg_5_0.actId)
	arg_5_0:_refreshTime()
	TaskDispatcher.runRepeat(arg_5_0._refreshTime, arg_5_0, TimeUtil.OneMinuteSecond)
	arg_5_0._animator:Play("open", 0, 0)
end

function var_0_0._enterGame(arg_6_0)
	local var_6_0 = ActivityConfig.instance:getActivityCo(arg_6_0.actId).confirmCondition

	if string.nilorempty(var_6_0) then
		YeShuMeiController.instance:enterLevelView()
	else
		local var_6_1 = string.split(var_6_0, "=")
		local var_6_2 = tonumber(var_6_1[2])
		local var_6_3 = PlayerModel.instance:getPlayinfo().userId
		local var_6_4 = PlayerPrefsKey.EnterRoleActivity .. arg_6_0.actId .. var_6_3
		local var_6_5 = PlayerPrefsHelper.getNumber(var_6_4, 0) == 1

		if OpenModel.instance:isFunctionUnlock(var_6_2) or var_6_5 then
			YeShuMeiController.instance:enterLevelView()
		else
			local var_6_6 = OpenConfig.instance:getOpenCo(var_6_2)
			local var_6_7 = DungeonConfig.instance:getEpisodeDisplay(var_6_6.episodeId)
			local var_6_8 = DungeonConfig.instance:getEpisodeCO(var_6_6.episodeId).name
			local var_6_9 = var_6_7 .. var_6_8

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleActivityOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(var_6_4, 1)
				YeShuMeiController.instance:enterLevelView()
			end, nil, nil, nil, nil, nil, var_6_9)
		end
	end
end

function var_0_0._clickLock(arg_8_0)
	local var_8_0, var_8_1 = OpenHelper.getToastIdAndParam(arg_8_0.actCo.openId)

	if var_8_0 and var_8_0 ~= 0 then
		GameFacade.showToast(var_8_0)
	end
end

function var_0_0._btnitemOnClick(arg_9_0)
	return
end

function var_0_0._btnTrialOnClick(arg_10_0)
	if ActivityHelper.getActivityStatus(arg_10_0.actId) == ActivityEnum.ActivityStatus.Normal then
		local var_10_0 = arg_10_0.actCo.tryoutEpisode

		if var_10_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_10_1 = DungeonConfig.instance:getEpisodeCO(var_10_0)

		DungeonFightController.instance:enterFight(var_10_1.chapterId, var_10_0)
	else
		arg_10_0:_clickLock()
	end
end

function var_0_0.everySecondCall(arg_11_0)
	arg_11_0:_refreshTime()
end

function var_0_0._refreshTime(arg_12_0)
	local var_12_0 = ActivityModel.instance:getActivityInfo()[arg_12_0.actId]

	if var_12_0 then
		local var_12_1 = var_12_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_12_0._txtLimitTime.gameObject, var_12_1 > 0)

		if var_12_1 > 0 then
			local var_12_2 = TimeUtil.SecondToActivityTimeFormat(var_12_1)

			arg_12_0._txtLimitTime.text = var_12_2
		end

		local var_12_3 = ActivityHelper.getActivityStatus(arg_12_0.actId) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_12_0._btnEnter, not var_12_3)
		gohelper.setActive(arg_12_0._btnLocked, var_12_3)
	end
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._refreshTime, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0

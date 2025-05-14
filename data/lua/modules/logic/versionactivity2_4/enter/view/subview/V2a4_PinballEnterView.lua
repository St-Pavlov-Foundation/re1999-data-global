module("modules.logic.versionactivity2_4.enter.view.subview.V2a4_PinballEnterView", package.seeall)

local var_0_0 = class("V2a4_PinballEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "#simage_FullBG/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._txtlock = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_task")
	arg_1_0._goTaskRed = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_task/#go_reddotreward")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_reset")
	arg_1_0._btnTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/image_TryBtn")
	arg_1_0._txtmainlv = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_main/#txt_lv")
	arg_1_0._goslider1 = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_main/#go_slider/#go_slider1")
	arg_1_0._goslider2 = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_main/#go_slider/#go_slider2")
	arg_1_0._goslider3 = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_main/#go_slider/#go_slider3")
	arg_1_0._txtmainnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_main/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._enterGame, arg_2_0)
	arg_2_0._btnTrial:AddClickListener(arg_2_0._clickTrial, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._clickTask, arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._clickReset, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_2_0._refreshMainLv, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.DataInited, arg_2_0._refreshMainLv, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.DataInited, arg_2_0._refreshResetShow, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnTrial:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._btnReset:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_3_0._refreshMainLv, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, arg_3_0._refreshMainLv, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, arg_3_0._refreshResetShow, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.Pinball)
end

function var_0_0.onOpen(arg_5_0)
	var_0_0.super.onOpen(arg_5_0)
	RedDotController.instance:addRedDot(arg_5_0._gored, RedDotEnum.DotNode.V2a4PinballTaskRed)
	RedDotController.instance:addRedDot(arg_5_0._goTaskRed, RedDotEnum.DotNode.V2a4PinballTaskRed)

	arg_5_0._isLock = true

	arg_5_0:_refreshTime()
	arg_5_0:_refreshMainLv()
	arg_5_0:_refreshResetShow()
end

function var_0_0._enterGame(arg_6_0)
	PinballController.instance:openMainView()
end

function var_0_0._clickLock(arg_7_0)
	local var_7_0, var_7_1 = OpenHelper.getToastIdAndParam(arg_7_0.actCo.openId)

	if var_7_0 and var_7_0 ~= 0 then
		GameFacade.showToastWithTableParam(var_7_0, var_7_1)
	end
end

function var_0_0._clickTask(arg_8_0)
	ViewMgr.instance:openView(ViewName.PinballTaskView)
end

function var_0_0._clickReset(arg_9_0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PinballReset, MsgBoxEnum.BoxType.Yes_No, arg_9_0._realReset, nil, nil, arg_9_0)
end

function var_0_0._realReset(arg_10_0)
	PinballStatHelper.instance:sendResetCity()
	Activity178Rpc.instance:sendAct178Reset(VersionActivity2_4Enum.ActivityId.Pinball)
end

function var_0_0._clickTrial(arg_11_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball) == ActivityEnum.ActivityStatus.Normal then
		local var_11_0 = arg_11_0.actCo.tryoutEpisode

		if var_11_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0)

		DungeonFightController.instance:enterFight(var_11_1.chapterId, var_11_0)
	else
		arg_11_0:_clickLock()
	end
end

function var_0_0.everySecondCall(arg_12_0)
	arg_12_0:_refreshTime()
end

function var_0_0._refreshTime(arg_13_0)
	local var_13_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.Pinball]

	if var_13_0 then
		local var_13_1 = var_13_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_13_0._txtLimitTime.gameObject, var_13_1 > 0)

		if var_13_1 > 0 then
			local var_13_2 = TimeUtil.SecondToActivityTimeFormat(var_13_1)

			arg_13_0._txtLimitTime.text = var_13_2
		end

		local var_13_3 = ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_13_0._btnEnter, not var_13_3)
		gohelper.setActive(arg_13_0._btnLocked, var_13_3)
		gohelper.setActive(arg_13_0._btnTask, false)
		gohelper.setActive(arg_13_0._btnTrial, not var_13_3)

		arg_13_0._isLock = var_13_3

		arg_13_0:_refreshResetShow()

		if var_13_3 then
			local var_13_4 = OpenHelper.getActivityUnlockTxt(arg_13_0.actCo.openId)

			arg_13_0._txtlock.text = var_13_4
		end
	end
end

function var_0_0._refreshMainLv(arg_14_0)
	local var_14_0, var_14_1, var_14_2 = PinballModel.instance:getScoreLevel()
	local var_14_3, var_14_4 = PinballModel.instance:getResNum(PinballEnum.ResType.Score)

	arg_14_0._txtmainlv.text = var_14_0
	arg_14_0._goslider1.fillAmount = 0

	if var_14_2 == var_14_1 then
		arg_14_0._goslider2.fillAmount = 1
	else
		arg_14_0._goslider2.fillAmount = (var_14_3 - var_14_1) / (var_14_2 - var_14_1)
	end

	arg_14_0._goslider3.fillAmount = 0
	arg_14_0._txtmainnum.text = string.format("%d/%d", var_14_3, var_14_2)
end

function var_0_0._refreshResetShow(arg_15_0)
	gohelper.setActive(arg_15_0._btnReset, not arg_15_0._isLock and PinballModel.instance.day >= PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ResetDay))
end

return var_0_0

module("modules.logic.versionactivity2_4.enter.view.subview.VersionActivity2_4WuErLiXiEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_4WuErLiXiEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDescr = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_Descr")
	arg_1_0._txtLimitTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goEnterRedDot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._enterGame, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._clickLock, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_4Enum.ActivityId.WuErLiXi)
	arg_4_0._txtDescr.text = arg_4_0.actCo.actDesc
end

function var_0_0.onOpen(arg_5_0)
	RedDotController.instance:addRedDot(arg_5_0._goEnterRedDot, RedDotEnum.DotNode.V2a4WuErLiXiTask)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_jinru)
	var_0_0.super.onOpen(arg_5_0)
	arg_5_0:_refreshTime()
end

function var_0_0._enterGame(arg_6_0)
	WuErLiXiController.instance:enterLevelView()
end

function var_0_0._clickLock(arg_7_0)
	local var_7_0, var_7_1 = OpenHelper.getToastIdAndParam(arg_7_0.actCo.openId)

	if var_7_0 and var_7_0 ~= 0 then
		GameFacade.showToast(var_7_0)
	end
end

function var_0_0.everySecondCall(arg_8_0)
	arg_8_0:_refreshTime()
end

function var_0_0._refreshTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.WuErLiXi]

	if var_9_0 then
		local var_9_1 = var_9_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_9_0._txtLimitTime.gameObject, var_9_1 > 0)

		if var_9_1 > 0 then
			local var_9_2 = TimeUtil.SecondToActivityTimeFormat(var_9_1)

			arg_9_0._txtLimitTime.text = var_9_2
		end

		local var_9_3 = ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.WuErLiXi) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_9_0._btnEnter, not var_9_3)
		gohelper.setActive(arg_9_0._btnLocked, var_9_3)
	end
end

return var_0_0

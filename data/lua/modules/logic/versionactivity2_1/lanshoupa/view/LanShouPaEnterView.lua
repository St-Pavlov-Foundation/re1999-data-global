module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaEnterView", package.seeall)

local var_0_0 = class("LanShouPaEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._btnTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/image_TryBtn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._enterGame, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._clickLock, arg_2_0)
	arg_2_0._btnTrial:AddClickListener(arg_2_0._clickTrial, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
	arg_3_0._btnTrial:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.LanShouPa)
	arg_4_0._txtDescr.text = arg_4_0.actCo.actDesc

	RedDotController.instance:addRedDot(arg_4_0._gored, RedDotEnum.DotNode.V2a1LanShouPaTaskRed, VersionActivity2_1Enum.ActivityId.LanShouPa)
end

function var_0_0.onOpen(arg_5_0)
	var_0_0.super.onOpen(arg_5_0)
	arg_5_0:_refreshTime()
end

function var_0_0.onClose(arg_6_0)
	var_0_0.super.onClose(arg_6_0)
end

function var_0_0._enterGame(arg_7_0)
	Activity164Rpc.instance:sendGetActInfoRequest(VersionActivity2_1Enum.ActivityId.LanShouPa, arg_7_0._onRecvMsg, arg_7_0)
end

function var_0_0._onRecvMsg(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 == 0 then
		ViewMgr.instance:openView(ViewName.LanShouPaMapView)
	end
end

function var_0_0._clickLock(arg_9_0)
	local var_9_0, var_9_1 = OpenHelper.getToastIdAndParam(arg_9_0.actCo.openId)

	if var_9_0 and var_9_0 ~= 0 then
		GameFacade.showToastWithTableParam(var_9_0, var_9_1)
	end
end

function var_0_0._clickTrial(arg_10_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.LanShouPa) == ActivityEnum.ActivityStatus.Normal then
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
	local var_12_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.LanShouPa]

	if var_12_0 then
		local var_12_1 = var_12_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_12_0._txtLimitTime.gameObject, var_12_1 > 0)

		if var_12_1 > 0 then
			local var_12_2 = TimeUtil.SecondToActivityTimeFormat(var_12_1)

			arg_12_0._txtLimitTime.text = var_12_2
		end

		local var_12_3 = ActivityHelper.getActivityStatus(VersionActivity2_1Enum.ActivityId.LanShouPa) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_12_0._btnEnter, not var_12_3)
		gohelper.setActive(arg_12_0._btnLocked, var_12_3)
	end
end

return var_0_0

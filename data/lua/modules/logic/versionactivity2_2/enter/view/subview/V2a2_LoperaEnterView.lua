module("modules.logic.versionactivity2_2.enter.view.subview.V2a2_LoperaEnterView", package.seeall)

local var_0_0 = class("V2a2_LoperaEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "image_LimitTimeBG/#txt_LimitTime")
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
	arg_4_0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.Lopera)
	arg_4_0._txtDescr.text = arg_4_0.actCo.actDesc
end

function var_0_0.onOpen(arg_5_0)
	var_0_0.super.onOpen(arg_5_0)
	RedDotController.instance:addRedDot(arg_5_0._gored, RedDotEnum.DotNode.LoperaTaksReword)
	arg_5_0:_refreshTime()
end

function var_0_0._enterGame(arg_6_0)
	LoperaController.instance:openLoperaMainView()
end

function var_0_0._clickLock(arg_7_0)
	local var_7_0, var_7_1 = OpenHelper.getToastIdAndParam(arg_7_0.actCo.openId)

	if var_7_0 and var_7_0 ~= 0 then
		GameFacade.showToastWithTableParam(var_7_0, var_7_1)
	end
end

function var_0_0._clickTrial(arg_8_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.Lopera) == ActivityEnum.ActivityStatus.Normal then
		local var_8_0 = arg_8_0.actCo.tryoutEpisode

		if var_8_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_8_1 = DungeonConfig.instance:getEpisodeCO(var_8_0)

		DungeonFightController.instance:enterFight(var_8_1.chapterId, var_8_0)
	else
		arg_8_0:_clickLock()
	end
end

function var_0_0.everySecondCall(arg_9_0)
	arg_9_0:_refreshTime()
end

function var_0_0._refreshTime(arg_10_0)
	local var_10_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.Lopera]

	if var_10_0 then
		local var_10_1 = var_10_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_10_0._txtLimitTime.gameObject, var_10_1 > 0)

		if var_10_1 > 0 then
			local var_10_2 = TimeUtil.SecondToActivityTimeFormat(var_10_1)

			arg_10_0._txtLimitTime.text = var_10_2
		end

		local var_10_3 = ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.Lopera) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_10_0._btnEnter, not var_10_3)
		gohelper.setActive(arg_10_0._btnLocked, var_10_3)
	end
end

return var_0_0

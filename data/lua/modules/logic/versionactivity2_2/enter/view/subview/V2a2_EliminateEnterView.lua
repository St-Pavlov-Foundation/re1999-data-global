module("modules.logic.versionactivity2_2.enter.view.subview.V2a2_EliminateEnterView", package.seeall)

local var_0_0 = class("V2a2_EliminateEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._txtunlocked = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
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
	arg_4_0.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.Eliminate)
	arg_4_0._txtDescr.text = arg_4_0.actCo.actDesc
	arg_4_0._txtunlocked.text = lua_toast.configDict[ToastEnum.EliminateLockDungeon].tips
end

function var_0_0.onOpen(arg_5_0)
	var_0_0.super.onOpen(arg_5_0)
	arg_5_0:_refreshTime()
end

function var_0_0._enterGame(arg_6_0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Eliminate) then
		GameFacade.showToast(ToastEnum.EliminateLockDungeon)

		return
	end

	EliminateMapController.instance:openEliminateMapView()
end

function var_0_0._onRecvMsg(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == 0 then
		-- block empty
	end
end

function var_0_0._clickLock(arg_8_0)
	local var_8_0, var_8_1 = OpenHelper.getToastIdAndParam(arg_8_0.actCo.openId)

	if var_8_0 and var_8_0 ~= 0 then
		GameFacade.showToast(ToastEnum.EliminateLockDungeon)
	end
end

function var_0_0._clickTrial(arg_9_0)
	if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.Eliminate) == ActivityEnum.ActivityStatus.Normal then
		local var_9_0 = arg_9_0.actCo.tryoutEpisode

		if var_9_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)

		DungeonFightController.instance:enterFight(var_9_1.chapterId, var_9_0)
	else
		arg_9_0:_clickLock()
	end
end

function var_0_0.everySecondCall(arg_10_0)
	arg_10_0:_refreshTime()
end

function var_0_0._refreshTime(arg_11_0)
	local var_11_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.Eliminate]

	if var_11_0 then
		local var_11_1 = var_11_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_11_0._txtLimitTime.gameObject, var_11_1 > 0)

		if var_11_1 > 0 then
			local var_11_2 = TimeUtil.SecondToActivityTimeFormat(var_11_1)

			arg_11_0._txtLimitTime.text = var_11_2
		end

		local var_11_3 = ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.Eliminate) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_11_0._btnEnter, not var_11_3)
		gohelper.setActive(arg_11_0._btnLocked, var_11_3)
	end
end

return var_0_0

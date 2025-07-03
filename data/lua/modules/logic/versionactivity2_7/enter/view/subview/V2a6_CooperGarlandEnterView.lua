module("modules.logic.versionactivity2_7.enter.view.subview.V2a6_CooperGarlandEnterView", package.seeall)

local var_0_0 = class("V2a6_CooperGarlandEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_time/#txt_limittime")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#go_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._btnTrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Try/image_TryBtn")

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
	CooperGarlandController.instance:openLevelView()
end

function var_0_0._btnLockedOnClick(arg_5_0)
	local var_5_0, var_5_1 = OpenHelper.getToastIdAndParam(arg_5_0.actCo.openId)

	if var_5_0 and var_5_0 ~= 0 then
		GameFacade.showToastWithTableParam(var_5_0, var_5_1)
	end
end

function var_0_0._btnTrialOnClick(arg_6_0)
	if CooperGarlandModel.instance:isAct192Open() then
		local var_6_0 = arg_6_0.actCo.tryoutEpisode

		if var_6_0 <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local var_6_1 = DungeonConfig.instance:getEpisodeCO(var_6_0)

		DungeonFightController.instance:enterFight(var_6_1.chapterId, var_6_0)
	else
		arg_6_0:_btnLockedOnClick()
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.actId = CooperGarlandModel.instance:getAct192Id()
	arg_7_0.actCo = ActivityConfig.instance:getActivityCo(arg_7_0.actId)
	arg_7_0._txtDescr.text = arg_7_0.actCo.actDesc
end

function var_0_0.onOpen(arg_8_0)
	var_0_0.super.onOpen(arg_8_0)
	arg_8_0:_refreshTime()
	RedDotController.instance:addRedDot(arg_8_0._goreddot, RedDotEnum.DotNode.V2a7CooperGarland)
end

function var_0_0.everySecondCall(arg_9_0)
	arg_9_0:_refreshTime()
end

function var_0_0._refreshTime(arg_10_0)
	local var_10_0, var_10_1 = CooperGarlandModel.instance:getAct192RemainTimeStr(arg_10_0.actId)

	arg_10_0._txtlimittime.text = var_10_0

	gohelper.setActive(arg_10_0._txtlimittime.gameObject, not var_10_1)

	local var_10_2 = CooperGarlandModel.instance:isAct192Open()

	gohelper.setActive(arg_10_0._btnEnter, var_10_2)
	gohelper.setActive(arg_10_0._btnLocked, not var_10_2)
end

return var_0_0

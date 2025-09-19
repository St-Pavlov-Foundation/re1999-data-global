module("modules.logic.survival.view.SurvivalEnterView", package.seeall)

local var_0_0 = class("SurvivalEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_achievement")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_reward")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "#simage_FullBG/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_reward/#go_reddot")
	arg_1_0.goCanget = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_reward/#canget")
	arg_1_0.goNormal = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_reward/#normal")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onEnterClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._onRewardClick, arg_2_0)
	arg_2_0._btnAchievement:AddClickListener(arg_2_0._btnAchievementOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnAchievement:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)
	RedDotController.instance:addRedDot(arg_4_0._gored, RedDotEnum.DotNode.V2a8Survival, false, arg_4_0._refreshRed, arg_4_0)
end

function var_0_0._refreshRed(arg_5_0, arg_5_1)
	arg_5_1:defaultRefreshDot()

	local var_5_0 = arg_5_1.show

	gohelper.setActive(arg_5_0.goCanget, var_5_0)
	gohelper.setActive(arg_5_0.goNormal, not var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.config = ActivityConfig.instance:getActivityCo(VersionActivity2_8Enum.ActivityId.Survival)
	arg_6_0._txtDescr.text = arg_6_0.config.actDesc
end

function var_0_0._onEnterClick(arg_7_0)
	SurvivalStatHelper.instance:statBtnClick("_onEnterClick", "SurvivalEnterView")
	ViewMgr.instance:openView(ViewName.SurvivalView)
end

function var_0_0._btnAchievementOnClick(arg_8_0)
	local var_8_0 = arg_8_0.config.achievementJumpId

	JumpController.instance:jump(var_8_0)
	SurvivalStatHelper.instance:statBtnClick("_btnAchievementOnClick", "SurvivalEnterView")
end

function var_0_0.everySecondCall(arg_9_0)
	arg_9_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_8Enum.ActivityId.Survival)
end

function var_0_0._onRewardClick(arg_10_0)
	ViewMgr.instance:openView(ViewName.SurvivalShelterRewardView)
	SurvivalStatHelper.instance:statBtnClick("_onRewardClick", "SurvivalEnterView")
end

return var_0_0

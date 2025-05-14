module("modules.logic.versionactivity2_5.enter.view.subview.VersionActivity2_5AutoChessEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_5AutoChessEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LimitTime/#txt_LimitTime")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_Desc")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Enter")
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Achievement")
	arg_1_0._goTip = gohelper.findChild(arg_1_0.viewGO, "#go_Tip")
	arg_1_0._txtTip = gohelper.findChildText(arg_1_0.viewGO, "#go_Tip/#txt_Tip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnAchievement:AddClickListener(arg_2_0._btnAchievementOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnAchievement:RemoveClickListener()
end

function var_0_0._btnEnterOnClick(arg_4_0)
	if not Activity182Model.instance:getActMo() then
		return
	end

	AutoChessController.instance:openMainView()
end

function var_0_0._btnAchievementOnClick(arg_5_0)
	local var_5_0 = arg_5_0.config.achievementJumpId

	JumpController.instance:jump(var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = arg_6_0.viewContainer.activityId
	arg_6_0.config = ActivityConfig.instance:getActivityCo(arg_6_0.actId)
	arg_6_0.animComp = VersionActivity2_5SubAnimatorComp.get(arg_6_0.viewGO, arg_6_0)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(Activity182Controller.instance, Activity182Event.UpdateInfo, arg_7_0.refreshUI, arg_7_0)
	arg_7_0.animComp:playOpenAnim()

	arg_7_0._txtDesc.text = arg_7_0.config.actDesc

	arg_7_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_7_0._showLeftTime, arg_7_0, 1)
	Activity182Rpc.instance:sendGetAct182InfoRequest(arg_7_0.actId)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0.animComp:destroy()
	TaskDispatcher.cancelTask(arg_8_0._showLeftTime, arg_8_0)
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = Activity182Model.instance:getActMo()
	local var_9_1 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreRank].value)
	local var_9_2 = lua_auto_chess_rank.configDict[arg_9_0.actId][var_9_1].name
	local var_9_3 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.DoubleScoreCnt].value)

	if var_9_1 >= var_9_0.rank then
		local var_9_4 = luaLang("autochess_mainview_tips1")
		local var_9_5 = string.format("（%d/%d）", var_9_0.doubleScoreTimes, var_9_3)

		arg_9_0._txtTip.text = GameUtil.getSubPlaceholderLuaLangThreeParam(var_9_4, var_9_2, var_9_3, var_9_5)

		gohelper.setActive(arg_9_0._goTip, true)
	else
		gohelper.setActive(arg_9_0._goTip, false)
	end
end

function var_0_0._showLeftTime(arg_10_0)
	arg_10_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_10_0.actId)
end

return var_0_0

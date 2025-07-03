module("modules.logic.versionactivity2_5.challenge.view.result.Act183FightSuccView", package.seeall)

local var_0_0 = class("Act183FightSuccView", FightSuccView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._additionitem = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/addition")
end

function var_0_0._onClickClose(arg_2_0)
	if not arg_2_0._canClick or arg_2_0._isStartToCloseView then
		return
	end

	local var_2_0 = ActivityHelper.getActivityStatus(arg_2_0._activityId)

	if arg_2_0._reChallenge and arg_2_0._episodeType ~= Act183Enum.EpisodeType.Boss and var_2_0 == ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act183ReplaceResult, MsgBoxEnum.BoxType.Yes_No, arg_2_0._confrimReplaceResult, arg_2_0._cancelReplaceResult, nil, arg_2_0, arg_2_0)

		return
	end

	arg_2_0:_reallyStartToCloseView()
end

function var_0_0._confrimReplaceResult(arg_3_0)
	Activity183Rpc.instance:sendAct183ReplaceResultRequest(arg_3_0._activityId, arg_3_0._episodeId, arg_3_0._reallyStartToCloseView, arg_3_0)
end

function var_0_0._cancelReplaceResult(arg_4_0)
	Act183Model.instance:clearBattleFinishedInfo()
	arg_4_0:_reallyStartToCloseView()
end

function var_0_0._reallyStartToCloseView(arg_5_0)
	var_0_0.super._onClickClose(arg_5_0)

	arg_5_0._isStartToCloseView = true
end

function var_0_0.onOpen(arg_6_0)
	var_0_0.super.onOpen(arg_6_0)

	arg_6_0._conditionItemTab = arg_6_0:getUserDataTb_()

	arg_6_0:initBattleFinishInfo()
	arg_6_0:refreshFightConditions()
	NavigateMgr.instance:addEscape(arg_6_0.viewName, arg_6_0._onClickClose, arg_6_0)
end

function var_0_0.initBattleFinishInfo(arg_7_0)
	local var_7_0 = Act183Model.instance:getBattleFinishedInfo()

	arg_7_0._activityId = var_7_0.activityId
	arg_7_0._episodeMo = var_7_0.episodeMo
	arg_7_0._fightResultMo = var_7_0.fightResultMo
	arg_7_0._episodeId = arg_7_0._episodeMo and arg_7_0._episodeMo:getEpisodeId()
	arg_7_0._episodeType = arg_7_0._episodeMo and arg_7_0._episodeMo:getEpisodeType()
	arg_7_0._reChallenge = var_7_0 and var_7_0.reChallenge
end

function var_0_0.refreshFightConditions(arg_8_0)
	local var_8_0 = arg_8_0._episodeMo:getConditionIds()

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			local var_8_1 = arg_8_0:_getOrCreateConditionItem(iter_8_0)
			local var_8_2 = arg_8_0._fightResultMo:isConditionPass(iter_8_1)
			local var_8_3 = Act183Config.instance:getConditionCo(iter_8_1)

			var_8_1.txtcondition.text = var_8_3 and var_8_3.decs1 or ""

			Act183Helper.setEpisodeConditionStar(var_8_1.imagestar, var_8_2, nil, true)
			gohelper.setActive(var_8_1.viewGO, true)
		end
	end
end

function var_0_0._getOrCreateConditionItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._conditionItemTab[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()
		var_9_0.viewGO = gohelper.cloneInPlace(arg_9_0._additionitem, "fightcondition_" .. arg_9_1)
		var_9_0.txtcondition = gohelper.findChildText(var_9_0.viewGO, "condition")
		var_9_0.imagestar = gohelper.findChildImage(var_9_0.viewGO, "star")
		arg_9_0._conditionItemTab[arg_9_1] = var_9_0
	end

	return var_9_0
end

return var_0_0

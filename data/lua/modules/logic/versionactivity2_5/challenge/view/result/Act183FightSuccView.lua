module("modules.logic.versionactivity2_5.challenge.view.result.Act183FightSuccView", package.seeall)

local var_0_0 = class("Act183FightSuccView", FightSuccView)

function var_0_0._onClickClose(arg_1_0)
	if not arg_1_0._canClick or arg_1_0._isStartToCloseView then
		return
	end

	local var_1_0 = ActivityHelper.getActivityStatus(arg_1_0._activityId)

	if arg_1_0._reChallenge and arg_1_0._episodeType ~= Act183Enum.EpisodeType.Boss and var_1_0 == ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act183ReplaceResult, MsgBoxEnum.BoxType.Yes_No, arg_1_0._confrimReplaceResult, arg_1_0._cancelReplaceResult, nil, arg_1_0, arg_1_0)

		return
	end

	arg_1_0:_reallyStartToCloseView()
end

function var_0_0._confrimReplaceResult(arg_2_0)
	Activity183Rpc.instance:sendAct183ReplaceResultRequest(arg_2_0._activityId, arg_2_0._episodeId, arg_2_0._reallyStartToCloseView, arg_2_0)
end

function var_0_0._cancelReplaceResult(arg_3_0)
	Act183Model.instance:clearBattleFinishedInfo()
	arg_3_0:_reallyStartToCloseView()
end

function var_0_0._reallyStartToCloseView(arg_4_0)
	var_0_0.super._onClickClose(arg_4_0)

	arg_4_0._isStartToCloseView = true
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseView, arg_5_0)

	arg_5_0._canClick = false
	arg_5_0._animation = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animation))

	arg_5_0._animation:Play("fightsucc_in", UnityEngine.PlayMode.StopAll)
	arg_5_0._animation:PlayQueued("fightsucc_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)

	arg_5_0._animEventWrap = arg_5_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	FightController.instance:checkFightQuitTipViewClose()
	gohelper.setActive(arg_5_0._bonusItemGo, false)

	arg_5_0._curEpisodeId = DungeonModel.instance.curSendEpisodeId
	arg_5_0._curChapterId = DungeonModel.instance.curSendChapterId

	local var_5_0 = FightResultModel.instance
	local var_5_1 = lua_episode.configDict[arg_5_0._curEpisodeId]
	local var_5_2 = DungeonConfig.instance:getChapterCO(arg_5_0._curChapterId)
	local var_5_3 = var_5_2 and var_5_2.type or DungeonEnum.ChapterType.Normal

	arg_5_0._normalMode = var_5_3 == DungeonEnum.ChapterType.Normal
	arg_5_0._hardMode = var_5_3 == DungeonEnum.ChapterType.Hard
	arg_5_0._simpleMode = var_5_3 == DungeonEnum.ChapterType.Simple

	if not var_5_1 or not var_5_1.type then
		local var_5_4 = DungeonEnum.EpisodeType.Normal
	end

	arg_5_0._curEpisodeId = FightResultModel.instance.episodeId
	arg_5_0.hadHighRareProp = false

	arg_5_0:_loadBonusItems()
	arg_5_0:_hideGoDemand()

	arg_5_0._randomEntityMO = arg_5_0:_getRandomEntityMO()

	arg_5_0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	arg_5_0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	local var_5_5 = lua_chapter.configDict[var_5_0:getChapterId()]
	local var_5_6 = lua_episode.configDict[var_5_0:getEpisodeId()]
	local var_5_7 = var_5_5 ~= nil and var_5_6 ~= nil

	gohelper.setActive(arg_5_0._txtFbName.gameObject, var_5_7)
	gohelper.setActive(arg_5_0._txtFbNameEn.gameObject, var_5_7)

	if var_5_7 then
		arg_5_0:_setFbName(var_5_6)
	end

	local var_5_8 = PlayerModel.instance:getExpNowAndMax()

	arg_5_0._txtLv.text = "<size=36>LV </size>" .. PlayerModel.instance:getPlayerLevel()

	arg_5_0._sliderExp:SetValue(var_5_8[1] / var_5_8[2])

	arg_5_0._txtExp.text = var_5_8[1] .. "/" .. var_5_8[2]

	local var_5_9 = var_5_0:getPlayerExp()

	if var_5_9 and var_5_9 > 0 then
		gohelper.setActive(arg_5_0._txtAddExp.gameObject, true)

		arg_5_0._txtAddExp.text = "EXP+" .. var_5_9
	else
		gohelper.setActive(arg_5_0._txtAddExp.gameObject, false)
	end

	arg_5_0:_setSpineVoice()
	NavigateMgr.instance:addEscape(ViewName.FightSuccView, arg_5_0._onClickClose, arg_5_0)

	arg_5_0._canPlayVoice = false

	TaskDispatcher.runDelay(arg_5_0._setCanPlayVoice, arg_5_0, 0.9)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	arg_5_0:_checkNewRecord()
	arg_5_0:_detectCoverRecord()
	arg_5_0:_checkTypeDetails()
	arg_5_0:showUnLockCurrentEpisodeNewMode()

	arg_5_0._conditionItemTab = arg_5_0:getUserDataTb_()

	arg_5_0:initBattleFinishInfo()
	arg_5_0:refreshEpisodeConditions()
	NavigateMgr.instance:addEscape(arg_5_0.viewName, arg_5_0._onClickClose, arg_5_0)
end

function var_0_0.initBattleFinishInfo(arg_6_0)
	local var_6_0 = Act183Model.instance:getBattleFinishedInfo()

	arg_6_0._activityId = var_6_0.activityId
	arg_6_0._episodeMo = var_6_0.episodeMo
	arg_6_0._fightResultMo = var_6_0.fightResultMo
	arg_6_0._episodeId = arg_6_0._episodeMo and arg_6_0._episodeMo:getEpisodeId()
	arg_6_0._episodeType = arg_6_0._episodeMo and arg_6_0._episodeMo:getEpisodeType()
	arg_6_0._reChallenge = var_6_0 and var_6_0.reChallenge
end

function var_0_0.refreshEpisodeConditions(arg_7_0)
	local var_7_0 = arg_7_0:refreshFirstAndAdvanceConditions(0)

	arg_7_0:refreshFightConditions(var_7_0)
end

function var_0_0.refreshFirstAndAdvanceConditions(arg_8_0, arg_8_1)
	local var_8_0 = Act183Helper.getEpisodeConditionDescList(arg_8_0._episodeId)
	local var_8_1 = FightResultModel.instance.star
	local var_8_2 = arg_8_0._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"
	local var_8_3 = var_8_0 and #var_8_0 or 0
	local var_8_4 = 0

	for iter_8_0 = 1, var_8_3 do
		var_8_4 = iter_8_0 + arg_8_1

		local var_8_5 = arg_8_0:_getOrCreateConditionItem(var_8_4)
		local var_8_6 = iter_8_0 <= var_8_1
		local var_8_7 = var_8_6 and "#C4C0BD" or "#6C6C6B"

		var_8_5.txtcondition.text = gohelper.getRichColorText(var_8_0[iter_8_0] or "", var_8_7)

		local var_8_8 = "#87898C"

		if var_8_6 then
			var_8_8 = arg_8_0._hardMode and "#FF4343" or "#F77040"
		end

		UISpriteSetMgr.instance:setCommonSprite(var_8_5.imagestar, var_8_2, true)
		SLFramework.UGUI.GuiHelper.SetColor(var_8_5.imagestar, var_8_8)
		gohelper.setActive(var_8_5.viewGO, true)
	end

	return var_8_4
end

function var_0_0.refreshFightConditions(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._episodeMo:getConditionIds()

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_1 = arg_9_0:_getOrCreateConditionItem(iter_9_0 + arg_9_1)
			local var_9_2 = arg_9_0._fightResultMo:isConditionPass(iter_9_1)
			local var_9_3 = Act183Config.instance:getConditionCo(iter_9_1)

			var_9_1.txtcondition.text = var_9_3 and var_9_3.decs1 or ""

			Act183Helper.setEpisodeConditionStar(var_9_1.imagestar, var_9_2, nil, true)
			gohelper.setActive(var_9_1.viewGO, true)
		end
	end
end

function var_0_0._getOrCreateConditionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._conditionItemTab[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.viewGO = gohelper.cloneInPlace(arg_10_0._goCondition, "fightcondition_" .. arg_10_1)
		var_10_0.txtcondition = gohelper.findChildText(var_10_0.viewGO, "condition")
		var_10_0.imagestar = gohelper.findChildImage(var_10_0.viewGO, "star")
		arg_10_0._conditionItemTab[arg_10_1] = var_10_0
	end

	return var_10_0
end

return var_0_0

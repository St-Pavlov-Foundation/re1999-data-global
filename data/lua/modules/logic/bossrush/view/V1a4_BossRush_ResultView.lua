module("modules.logic.bossrush.view.V1a4_BossRush_ResultView", package.seeall)

local var_0_0 = class("V1a4_BossRush_ResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Title/#simage_Title")
	arg_1_0._btnRank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/#btn_Rank")
	arg_1_0._simagePlayerHead = gohelper.findChildSingleImage(arg_1_0.viewGO, "Player/PlayerHead/#simage_PlayerHead")
	arg_1_0._txtPlayerName = gohelper.findChildText(arg_1_0.viewGO, "Player/#txt_PlayerName")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "Player/#txt_Time")
	arg_1_0._goAssessScore = gohelper.findChild(arg_1_0.viewGO, "Right/#go_AssessScore")
	arg_1_0._goGroup = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Group")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRank:AddClickListener(arg_2_0._btnRankOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRank:RemoveClickListener()
end

function var_0_0._btnRankOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._bossBgList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, 3 do
		arg_5_0._bossBgList[iter_5_0] = gohelper.findChild(arg_5_0.viewGO, "boss_topbg" .. iter_5_0)
	end

	arg_5_0:_initAssessScore()
	arg_5_0:_initHeroGroup()

	arg_5_0._click = gohelper.getClick(arg_5_0.viewGO)

	arg_5_0._click:AddClickListener(arg_5_0.closeThis, arg_5_0)
	NavigateMgr.instance:addEscape(ViewName.V1a4_BossRush_ResultView, arg_5_0.closeThis, arg_5_0)
end

function var_0_0._initAssessScore(arg_6_0)
	local var_6_0 = V1a4_BossRush_Assess_Score
	local var_6_1 = arg_6_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, arg_6_0._goAssessScore, var_6_0.__name)

	arg_6_0._assessScore = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, var_6_0)

	arg_6_0._assessScore:setActiveDesc(false)
	arg_6_0._assessIcon:initData(arg_6_0, false)
end

function var_0_0._initHeroGroup(arg_7_0)
	local var_7_0 = V1a4_BossRush_HeroGroup
	local var_7_1 = arg_7_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_herogroup, arg_7_0._goGroup, var_7_0.__cname)

	arg_7_0._heroGroup = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, var_7_0, arg_7_0.viewContainer)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._curStage, arg_9_0._curLayer = BossRushModel.instance:getBattleStageAndLayer()

	local var_9_0 = PlayerModel.instance:getPlayinfo()
	local var_9_1 = var_9_0.portrait

	if not arg_9_0._liveHeadIcon then
		arg_9_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_9_0._simagePlayerHead)
	end

	arg_9_0._liveHeadIcon:setLiveHead(var_9_1)

	arg_9_0._txtTime.text = TimeUtil.getServerDateUTCToString()
	arg_9_0._txtPlayerName.text = var_9_0.name

	arg_9_0:_refresh()
end

function var_0_0.onOpenFinish(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._click:RemoveClickListener()
	FightController.onResultViewClose()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageFullBG:UnLoadImage()
	arg_12_0._simageTitle:UnLoadImage()
	arg_12_0._simagePlayerHead:UnLoadImage()
	GameUtil.onDestroyViewMember(arg_12_0, "_heroGroup")
	GameUtil.onDestroyViewMember(arg_12_0, "_assessScore")
end

function var_0_0._refresh(arg_13_0)
	local var_13_0 = arg_13_0._curStage

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0 == 1 and 1 or var_13_0 == 2 and 3 or 2

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._bossBgList) do
		gohelper.setActive(iter_13_1, var_13_1 == iter_13_0)
	end

	arg_13_0._simageFullBG:LoadImage(BossRushConfig.instance:getResultViewFullBgSImage(var_13_0))
	arg_13_0._simageTitle:LoadImage(BossRushConfig.instance:getResultViewNameSImage(var_13_0))
	arg_13_0._assessScore:setData_ResultView(var_13_0, BossRushModel.instance:getFightScore())
	arg_13_0._assessScore:setActiveNewRecord(BossRushModel.instance:checkIsNewHighestPointRecord(var_13_0))
	arg_13_0._heroGroup:setDataByCurFightParam()
end

return var_0_0

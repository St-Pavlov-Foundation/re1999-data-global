module("modules.logic.versionactivity2_3.act174.view.Act174FightResultView", package.seeall)

local var_0_0 = class("Act174FightResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnEnemyBuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "enemy/txt_enemy/#btn_EnemyBuff")
	arg_1_0._btnPlayerBuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "player/txt_player/#btn_PlayerBuff")
	arg_1_0._goresultitem = gohelper.findChild(arg_1_0.viewGO, "Group/#go_resultitem")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "go_top/tips/#txt_Round")
	arg_1_0._imageHpPercent = gohelper.findChildImage(arg_1_0.viewGO, "go_top/hp/bg/#image_HpPercent")
	arg_1_0._gowin = gohelper.findChild(arg_1_0.viewGO, "go_top/result/#go_win")
	arg_1_0._godraw = gohelper.findChild(arg_1_0.viewGO, "go_top/result/#go_draw")
	arg_1_0._golose = gohelper.findChild(arg_1_0.viewGO, "go_top/result/#go_lose")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnemyBuff:AddClickListener(arg_2_0._btnEnemyBuffOnClick, arg_2_0)
	arg_2_0._btnPlayerBuff:AddClickListener(arg_2_0._btnPlayerBuffOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnemyBuff:RemoveClickListener()
	arg_3_0._btnPlayerBuff:RemoveClickListener()
end

function var_0_0.onClickModalMask(arg_4_0)
	Activity174Rpc.instance:sendEnterNextAct174FightRequest(arg_4_0.actId, arg_4_0.enterReply, arg_4_0)
end

function var_0_0.enterReply(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == 0 then
		if arg_5_3.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Controller.instance:dispatchEvent(Activity174Event.EndGame)
		else
			Activity174Controller.instance:dispatchEvent(Activity174Event.EnterNextAct174FightReply)
		end

		FightController.instance:dispatchEvent(FightEvent.DouQuQuSettlementFinish)
		arg_5_0:closeThis()
	end
end

function var_0_0._btnEnemyBuffOnClick(arg_6_0)
	Activity174Controller.instance:openBuffTipView(true, Vector2.New(-450, 80))
end

function var_0_0._btnPlayerBuffOnClick(arg_7_0)
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(450, 80))
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(Activity174Controller.instance, Activity174Event.SeasonChange, arg_10_0.closeThis, arg_10_0)

	arg_10_0.actId = Activity174Model.instance:getCurActId()
	arg_10_0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	arg_10_0.fightInfo = arg_10_0.gameInfo:getFightInfo()
	arg_10_0.fightResInfos = arg_10_0.fightInfo.fightResInfo
	arg_10_0.entityId2HeroIdDicList = cjson.decode(arg_10_0.fightInfo.param)
	arg_10_0.playerTeamInfos = arg_10_0.gameInfo:getTeamMoList()
	arg_10_0.enemyTeamInfos = arg_10_0.fightInfo.matchInfo.teamInfo

	local var_10_0 = arg_10_0.gameInfo.gameCount
	local var_10_1 = Activity174Config.instance:getMaxRound(arg_10_0.actId, var_10_0)

	arg_10_0._txtRound.text = var_10_0 .. "/" .. var_10_1

	local var_10_2 = arg_10_0.gameInfo:getWarehouseInfo()
	local var_10_3 = arg_10_0.fightInfo.matchInfo.enhanceId

	gohelper.setActive(arg_10_0._btnPlayerBuff, #var_10_2.enhanceId ~= 0)
	gohelper.setActive(arg_10_0._btnEnemyBuff, #var_10_3 ~= 0)

	if arg_10_0.fightInfo.state == Activity174Enum.FightResult.Lose then
		if arg_10_0.fightInfo.betHp then
			arg_10_0.gameInfo.hp = arg_10_0.gameInfo.hp - 2
		else
			arg_10_0.gameInfo.hp = arg_10_0.gameInfo.hp - 1
		end
	end

	local var_10_4 = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

	arg_10_0._imageHpPercent.fillAmount = arg_10_0.gameInfo.hp / var_10_4

	local var_10_5 = arg_10_0.fightInfo.state
	local var_10_6 = var_10_5 == Activity174Enum.FightResult.Win
	local var_10_7 = var_10_5 == Activity174Enum.FightResult.Lose
	local var_10_8 = var_10_5 == Activity174Enum.FightResult.Draw

	gohelper.setActive(arg_10_0._gowin, var_10_6)
	gohelper.setActive(arg_10_0._golose, var_10_7)
	gohelper.setActive(arg_10_0._godraw, var_10_8)

	local var_10_9

	if var_10_6 then
		var_10_9 = AudioEnum.Act174.play_ui_shenghuo_dqq_win
	elseif var_10_7 then
		var_10_9 = AudioEnum.Act174.play_ui_shenghuo_dqq_lose
	elseif var_10_8 then
		var_10_9 = AudioEnum.Act174.play_ui_shenghuo_dqq_draw
	end

	if var_10_9 then
		AudioMgr.instance:trigger(var_10_9)
	end

	arg_10_0.teamCnt = Activity174Config.instance:getTurnCo(arg_10_0.actId, arg_10_0.gameInfo.gameCount).groupNum
	arg_10_0.resultItemList = {}

	for iter_10_0 = 1, arg_10_0.teamCnt do
		local var_10_10 = gohelper.cloneInPlace(arg_10_0._goresultitem, "resultItem" .. iter_10_0)

		arg_10_0:initResultItem(var_10_10, iter_10_0)
	end

	gohelper.setActive(arg_10_0._goresultitem, false)
	arg_10_0:playEndAnim()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_result)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.initResultItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getUserDataTb_()
	local var_12_1 = gohelper.findChild(arg_12_1, "EnemyGroup")

	var_12_0.goEnemyWin = gohelper.findChild(arg_12_1, "simage_enemywin")
	var_12_0.goEnemyMask = gohelper.findChild(var_12_1, "go_mask")

	local var_12_2 = gohelper.findChildImage(var_12_1, "numbg/image_Num")

	UISpriteSetMgr.instance:setAct174Sprite(var_12_2, "act174_ready_num_0" .. arg_12_2)

	local var_12_3 = Activity174Helper.MatchKeyInArray(arg_12_0.enemyTeamInfos, arg_12_2, "index")

	for iter_12_0 = 4, 1, -1 do
		local var_12_4 = arg_12_0:getResInst(Activity174Enum.PrefabPath.BattleHero, var_12_1)
		local var_12_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_4, Act174BattleHeroItem)
		local var_12_6 = Activity174Helper.MatchKeyInArray(var_12_3.battleHeroInfo, iter_12_0, "index")

		var_12_5:setIndex(iter_12_0)
		var_12_5:setData(var_12_6, arg_12_2, true)
	end

	gohelper.setAsLastSibling(var_12_0.goEnemyMask)

	local var_12_7 = gohelper.findChild(arg_12_1, "PlayerGroup")

	var_12_0.goPlayerWin = gohelper.findChild(arg_12_1, "simage_playerwin")
	var_12_0.goPlayerMask = gohelper.findChild(var_12_7, "go_mask")

	local var_12_8 = gohelper.findChildImage(var_12_7, "numbg/image_Num")

	UISpriteSetMgr.instance:setAct174Sprite(var_12_8, "act174_ready_num_0" .. arg_12_2)

	local var_12_9 = Activity174Helper.MatchKeyInArray(arg_12_0.playerTeamInfos, arg_12_2, "index")

	for iter_12_1 = 1, 4 do
		local var_12_10 = arg_12_0:getResInst(Activity174Enum.PrefabPath.BattleHero, var_12_7)
		local var_12_11 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_10, Act174BattleHeroItem)
		local var_12_12 = Activity174Helper.MatchKeyInArray(var_12_9.battleHeroInfo, iter_12_1, "index")

		var_12_11:setIndex(iter_12_1)
		var_12_11:setData(var_12_12, arg_12_2, false)
	end

	gohelper.setAsLastSibling(var_12_0.goPlayerMask)

	local var_12_13 = gohelper.findChildButtonWithAudio(arg_12_1, "btn_replay")
	local var_12_14 = gohelper.findChildButtonWithAudio(arg_12_1, "btn_detail")

	arg_12_0:addClickCb(var_12_13, arg_12_0.onClickReplay, arg_12_0, arg_12_2)
	arg_12_0:addClickCb(var_12_14, arg_12_0.onClickDetail, arg_12_0, arg_12_2)

	arg_12_0.resultItemList[#arg_12_0.resultItemList + 1] = var_12_0
end

function var_0_0.onClickDetail(arg_13_0, arg_13_1)
	local var_13_0 = Activity174Helper.MatchKeyInArray(arg_13_0.fightResInfos, arg_13_1, "index")

	if var_13_0 then
		local var_13_1 = var_13_0.attackStatistics
		local var_13_2 = arg_13_0.entityId2HeroIdDicList[tostring(arg_13_1)]

		if var_13_2 then
			local var_13_3 = Activity174Model.instance:geAttackStatisticsByServerData(var_13_1, var_13_2)

			FightStatModel.instance:setAtkStatInfo(var_13_3)
			ViewMgr.instance:openView(ViewName.FightStatView)
		end
	else
		logError("dont exist fightResInfo")
	end
end

function var_0_0.onClickReplay(arg_14_0, arg_14_1)
	if Activity174Helper.MatchKeyInArray(arg_14_0.fightResInfos, arg_14_1, "index") then
		Activity174Controller.instance:playFight({
			arg_14_1
		}, true)
		arg_14_0:closeThis()
	end
end

function var_0_0.playEndAnim(arg_15_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act174FightResultView_endAnim")

	arg_15_0.curTeam = 1

	TaskDispatcher.runRepeat(arg_15_0.lightBg, arg_15_0, 0.5)
end

function var_0_0.lightBg(arg_16_0)
	local var_16_0 = arg_16_0.resultItemList[arg_16_0.curTeam]
	local var_16_1 = Activity174Helper.MatchKeyInArray(arg_16_0.fightResInfos, arg_16_0.curTeam, "index")

	if var_16_1 then
		gohelper.setActive(var_16_0.goPlayerWin, var_16_1.win)
		gohelper.setActive(var_16_0.goEnemyWin, not var_16_1.win)
		gohelper.setActive(var_16_0.goPlayerMask, not var_16_1.win)
		gohelper.setActive(var_16_0.goEnemyMask, var_16_1.win)
	end

	arg_16_0.curTeam = arg_16_0.curTeam + 1

	if arg_16_0.curTeam > arg_16_0.teamCnt then
		TaskDispatcher.cancelTask(arg_16_0.lightBg, arg_16_0)
		UIBlockMgr.instance:endBlock("Act174FightResultView_endAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return var_0_0

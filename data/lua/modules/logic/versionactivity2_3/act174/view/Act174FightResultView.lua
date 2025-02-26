module("modules.logic.versionactivity2_3.act174.view.Act174FightResultView", package.seeall)

slot0 = class("Act174FightResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnEnemyBuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "enemy/txt_enemy/#btn_EnemyBuff")
	slot0._btnPlayerBuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "player/txt_player/#btn_PlayerBuff")
	slot0._goresultitem = gohelper.findChild(slot0.viewGO, "Group/#go_resultitem")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "go_top/tips/#txt_Round")
	slot0._imageHpPercent = gohelper.findChildImage(slot0.viewGO, "go_top/hp/bg/#image_HpPercent")
	slot0._gowin = gohelper.findChild(slot0.viewGO, "go_top/result/#go_win")
	slot0._godraw = gohelper.findChild(slot0.viewGO, "go_top/result/#go_draw")
	slot0._golose = gohelper.findChild(slot0.viewGO, "go_top/result/#go_lose")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnemyBuff:AddClickListener(slot0._btnEnemyBuffOnClick, slot0)
	slot0._btnPlayerBuff:AddClickListener(slot0._btnPlayerBuffOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnemyBuff:RemoveClickListener()
	slot0._btnPlayerBuff:RemoveClickListener()
end

function slot0.onClickModalMask(slot0)
	Activity174Rpc.instance:sendEnterNextAct174FightRequest(slot0.actId, slot0.enterReply, slot0)
end

function slot0.enterReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		if slot3.gameInfo.state == Activity174Enum.GameState.None then
			Activity174Controller.instance:dispatchEvent(Activity174Event.EndGame)
		else
			Activity174Controller.instance:dispatchEvent(Activity174Event.EnterNextAct174FightReply)
		end

		FightController.instance:dispatchEvent(FightEvent.DouQuQuSettlementFinish)
		slot0:closeThis()
	end
end

function slot0._btnEnemyBuffOnClick(slot0)
	Activity174Controller.instance:openBuffTipView(true, Vector2.New(-450, 80))
end

function slot0._btnPlayerBuffOnClick(slot0)
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(450, 80))
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.SeasonChange, slot0.closeThis, slot0)

	slot0.actId = Activity174Model.instance:getCurActId()
	slot0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	slot0.fightInfo = slot0.gameInfo:getFightInfo()
	slot0.fightResInfos = slot0.fightInfo.fightResInfo
	slot0.entityId2HeroIdDicList = cjson.decode(slot0.fightInfo.param)
	slot0.playerTeamInfos = slot0.gameInfo:getTeamMoList()
	slot0.enemyTeamInfos = slot0.fightInfo.matchInfo.teamInfo
	slot1 = slot0.gameInfo.gameCount
	slot0._txtRound.text = slot1 .. "/" .. Activity174Config.instance:getMaxRound(slot0.actId, slot1)

	gohelper.setActive(slot0._btnPlayerBuff, #slot0.gameInfo:getWarehouseInfo().enhanceId ~= 0)
	gohelper.setActive(slot0._btnEnemyBuff, #slot0.fightInfo.matchInfo.enhanceId ~= 0)

	if slot0.fightInfo.state == Activity174Enum.FightResult.Lose then
		if slot0.fightInfo.betHp then
			slot0.gameInfo.hp = slot0.gameInfo.hp - 2
		else
			slot0.gameInfo.hp = slot0.gameInfo.hp - 1
		end
	end

	slot0._imageHpPercent.fillAmount = slot0.gameInfo.hp / tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)
	slot7 = slot0.fightInfo.state == Activity174Enum.FightResult.Win

	gohelper.setActive(slot0._gowin, slot7)
	gohelper.setActive(slot0._golose, slot6 == Activity174Enum.FightResult.Lose)
	gohelper.setActive(slot0._godraw, slot6 == Activity174Enum.FightResult.Draw)

	slot10 = nil

	if slot7 then
		slot10 = AudioEnum.Act174.play_ui_shenghuo_dqq_win
	elseif slot8 then
		slot10 = AudioEnum.Act174.play_ui_shenghuo_dqq_lose
	elseif slot9 then
		slot10 = AudioEnum.Act174.play_ui_shenghuo_dqq_draw
	end

	if slot10 then
		AudioMgr.instance:trigger(slot10)
	end

	slot0.teamCnt = Activity174Config.instance:getTurnCo(slot0.actId, slot0.gameInfo.gameCount).groupNum
	slot0.resultItemList = {}

	for slot15 = 1, slot0.teamCnt do
		slot0:initResultItem(gohelper.cloneInPlace(slot0._goresultitem, "resultItem" .. slot15), slot15)
	end

	gohelper.setActive(slot0._goresultitem, false)
	slot0:playEndAnim()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_result)
end

function slot0.onDestroyView(slot0)
end

function slot0.initResultItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot4 = gohelper.findChild(slot1, "EnemyGroup")
	slot3.goEnemyWin = gohelper.findChild(slot1, "simage_enemywin")
	slot3.goEnemyMask = gohelper.findChild(slot4, "go_mask")
	slot10 = slot2

	UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot4, "numbg/image_Num"), "act174_ready_num_0" .. slot10)

	for slot10 = 4, 1, -1 do
		slot12 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity174Enum.PrefabPath.BattleHero, slot4), Act174BattleHeroItem)

		slot12:setIndex(slot10)
		slot12:setData(Activity174Helper.MatchKeyInArray(Activity174Helper.MatchKeyInArray(slot0.enemyTeamInfos, slot2, "index").battleHeroInfo, slot10, "index"), slot2, true)
	end

	gohelper.setAsLastSibling(slot3.goEnemyMask)

	slot7 = gohelper.findChild(slot1, "PlayerGroup")
	slot3.goPlayerWin = gohelper.findChild(slot1, "simage_playerwin")
	slot3.goPlayerMask = gohelper.findChild(slot7, "go_mask")
	slot13 = slot2

	UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot7, "numbg/image_Num"), "act174_ready_num_0" .. slot13)

	for slot13 = 1, 4 do
		slot15 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity174Enum.PrefabPath.BattleHero, slot7), Act174BattleHeroItem)

		slot15:setIndex(slot13)
		slot15:setData(Activity174Helper.MatchKeyInArray(Activity174Helper.MatchKeyInArray(slot0.playerTeamInfos, slot2, "index").battleHeroInfo, slot13, "index"), slot2, false)
	end

	gohelper.setAsLastSibling(slot3.goPlayerMask)
	slot0:addClickCb(gohelper.findChildButtonWithAudio(slot1, "btn_replay"), slot0.onClickReplay, slot0, slot2)
	slot0:addClickCb(gohelper.findChildButtonWithAudio(slot1, "btn_detail"), slot0.onClickDetail, slot0, slot2)

	slot0.resultItemList[#slot0.resultItemList + 1] = slot3
end

function slot0.onClickDetail(slot0, slot1)
	if Activity174Helper.MatchKeyInArray(slot0.fightResInfos, slot1, "index") then
		if slot0.entityId2HeroIdDicList[tostring(slot1)] then
			FightStatModel.instance:setAtkStatInfo(Activity174Model.instance:geAttackStatisticsByServerData(slot2.attackStatistics, slot4))
			ViewMgr.instance:openView(ViewName.FightStatView)
		end
	else
		logError("dont exist fightResInfo")
	end
end

function slot0.onClickReplay(slot0, slot1)
	if Activity174Helper.MatchKeyInArray(slot0.fightResInfos, slot1, "index") then
		Activity174Controller.instance:playFight({
			slot1
		}, true)
		slot0:closeThis()
	end
end

function slot0.playEndAnim(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act174FightResultView_endAnim")

	slot0.curTeam = 1

	TaskDispatcher.runRepeat(slot0.lightBg, slot0, 0.5)
end

function slot0.lightBg(slot0)
	slot1 = slot0.resultItemList[slot0.curTeam]

	if Activity174Helper.MatchKeyInArray(slot0.fightResInfos, slot0.curTeam, "index") then
		gohelper.setActive(slot1.goPlayerWin, slot2.win)
		gohelper.setActive(slot1.goEnemyWin, not slot2.win)
		gohelper.setActive(slot1.goPlayerMask, not slot2.win)
		gohelper.setActive(slot1.goEnemyMask, slot2.win)
	end

	slot0.curTeam = slot0.curTeam + 1

	if slot0.teamCnt < slot0.curTeam then
		TaskDispatcher.cancelTask(slot0.lightBg, slot0)
		UIBlockMgr.instance:endBlock("Act174FightResultView_endAnim")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

return slot0

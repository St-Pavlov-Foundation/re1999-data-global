module("modules.logic.toughbattle.view.ToughBattleEnterView", package.seeall)

slot0 = class("ToughBattleEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "root/left/top/#txt_desc")
	slot0._gosmalltxt = gohelper.findChild(slot0.viewGO, "root/left/top/titlesmalltxt")
	slot0._goprop = gohelper.findChild(slot0.viewGO, "root/right/top/prop")
	slot0._txtpropnum = gohelper.findChildTextMesh(slot0.viewGO, "root/right/top/prop/#txt_num")
	slot0._propicon = gohelper.findChildImage(slot0.viewGO, "root/right/top/prop/propicon")
	slot0._btnProp = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/top/#btn_prop")
	slot0._godiffcult = gohelper.findChild(slot0.viewGO, "root/right/bottom/difficulty")
	slot0._animdiffcult = slot0._godiffcult:GetComponent(typeof(UnityEngine.Animator))
	slot0._imgdiffcult = gohelper.findChildImage(slot0.viewGO, "root/right/bottom/difficulty/bg")
	slot0._imgdiffculticon = gohelper.findChildImage(slot0.viewGO, "root/right/bottom/difficulty/#simage_icon")
	slot0._txtdiffcult = gohelper.findChildTextMesh(slot0.viewGO, "root/right/bottom/difficulty/#txt_diff")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/bottom/difficulty/#go_leftchoosebtn")
	slot0._btnleftlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/bottom/difficulty/#go_leftlockbtn")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/bottom/difficulty/#go_rightchoosebtn")
	slot0._btnrightlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/bottom/difficulty/#go_rightlockbtn")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/bottom/#btn_startbtn")
	slot0._gored = gohelper.findChild(slot0.viewGO, "root/right/bottom/#btn_startbtn/#go_reddot")
	slot0._gored2 = gohelper.findChild(slot0.viewGO, "root/right/bottom/difficulty/#go_reddot")
	slot0._txtstart = gohelper.findChildTextMesh(slot0.viewGO, "root/right/bottom/#btn_startbtn/txt_start")
	slot0._propbottomicon = gohelper.findChildImage(slot0.viewGO, "root/right/bottom/prop")
	slot0._txtpropcost = gohelper.findChildTextMesh(slot0.viewGO, "root/right/bottom/prop/#txt_num")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/bottom/#btn_rewardbtn")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "root/right/bottom/RewardTips")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG/#scroll_Rewards/Viewport/#go_rewards/item")
	slot0._gorewardbg = gohelper.findChild(slot0.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG")
	slot0._gorewardscroll = gohelper.findChild(slot0.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG/#scroll_Rewards")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "root/left/top/timebg")
	slot0._txttime = gohelper.findChildTextMesh(slot0.viewGO, "root/left/top/timebg/#txt_time")
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._onEnter, slot0)
	slot0._btnleft:AddClickListener(slot0.onClickChangeDiffcult, slot0, false)
	slot0._btnright:AddClickListener(slot0.onClickChangeDiffcult, slot0, true)
	slot0._btnrightlock:AddClickListener(slot0.onClickLock, slot0)
	slot0._btnreward:AddClickListener(slot0.onShowReward, slot0)
	slot0._btnProp:AddClickListener(slot0.onClickProp, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnrightlock:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnProp:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_enter)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
	gohelper.setActive(slot0._gorewarditem, false)
	gohelper.setActive(slot0._goreward, false)
	gohelper.setActive(slot0._btnleftlock, false)
	gohelper.setActive(slot0._goprop, slot0.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(slot0._propbottomicon, slot0.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(slot0._godiffcult, slot0.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(slot0._gosmalltxt, slot0.viewParam.mode == ToughBattleEnum.Mode.Act)

	slot0._txtstart.text = luaLang("toughbattle_mainview_txt_start")

	if slot0.viewParam.mode == ToughBattleEnum.Mode.Act then
		RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V1a9ToughBattle)
		RedDotController.instance:addRedDot(slot0._gored2, RedDotEnum.DotNode.V1a9ToughBattle)
		slot0:autoSelectDiffcult()
		slot0:updateCost()

		slot0._txtdesc.text = luaLang("toughbattle_mainview_act_title_desc")
	else
		slot0._txtdesc.text = luaLang("toughbattle_mainview_normal_title_desc")
	end

	slot0:updateTime()
end

function slot0.onClose(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
end

function slot0.updateReward(slot0)
	slot1 = nil

	if not lua_episode.configDict[((slot0.viewParam.mode ~= ToughBattleEnum.Mode.Act or ToughBattleConfig.instance:getCOByDiffcult(slot0._nowDiff).stage2) and ToughBattleConfig.instance:getStoryCO().stage2).episodeId] then
		logError("没有关卡配置" .. slot1.episodeId)

		return
	end

	slot3 = false

	if slot0.viewParam.mode == ToughBattleEnum.Mode.Act then
		slot3 = tabletool.indexOf(slot0:getInfo().passDifficulty, slot0._nowDiff)
	end

	if not lua_bonus.configDict[slot2.firstBonus] then
		logError("没有奖励配置" .. slot1.episodeId .. " >> " .. slot2.firstBonus)

		return
	end

	slot6 = #GameUtil.splitString2(slot4.fixBonus, true)

	recthelper.setWidth(slot0._gorewardbg.transform, math.min(slot6 * 126 + 58, 465))
	recthelper.setWidth(slot0._gorewardscroll.transform, math.min(slot6 * 126 + 58, 495))

	slot0._rewardItems = slot0._rewardItems or {}

	for slot10 = 1, slot6 do
		if not slot0._rewardItems[slot10] then
			slot0._rewardItems[slot10] = {}
			slot11 = gohelper.cloneInPlace(slot0._gorewarditem, "item" .. slot10)

			gohelper.setActive(slot11, true)

			slot0._rewardItems[slot10].item = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot11, "itemicon"))
			slot0._rewardItems[slot10].go = slot11
			slot0._rewardItems[slot10].finished = gohelper.findChild(slot11, "finished")
		end

		gohelper.setActive(slot0._rewardItems[slot10].go, true)

		slot11 = slot5[slot10]

		slot0._rewardItems[slot10].item:setMOValue(slot11[1], slot11[2], slot11[3], nil, true)
		slot0._rewardItems[slot10].item:setCountFontSize(46)
		slot0._rewardItems[slot10].item:SetCountBgHeight(31)
		gohelper.setActive(slot0._rewardItems[slot10].finished, slot3)
	end

	for slot10 = slot6 + 1, #slot0._rewardItems do
		gohelper.setActive(slot0._rewardItems[slot10].go.transform.parent, false)
	end
end

function slot0.updateTime(slot0)
	if slot0.viewParam.mode == ToughBattleEnum.Mode.Act then
		if not ActivityModel.instance:getActivityInfo()[VersionActivity1_9Enum.ActivityId.ToughBattle] then
			gohelper.setActive(slot0._gotime, false)

			return
		end

		slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(slot1:getRealEndTimeStamp() - ServerTime.now())

		gohelper.setActive(slot0._gotime, true)
	else
		gohelper.setActive(slot0._gotime, false)
	end
end

function slot0.updateCost(slot0)
	slot1 = ToughBattleConfig.instance:getConstValue(ToughBattleEnum.HoldTicketMaxLimitConstId, true)

	if slot0:getCostNum() <= slot0:getNowNum() then
		slot0._txtpropcost.text = "<color=#ffffff>-" .. slot2
	else
		slot0._txtpropcost.text = "<color=#e44646>-" .. slot2
	end

	slot0._txtpropnum.text = slot3 .. "/" .. slot1
	slot5 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a9ToughEnter).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._propicon, slot5 .. "_1")
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._propbottomicon, slot5 .. "_1")
end

function slot0.onClickProp(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a9ToughEnter, false, nil, false)
end

function slot0.onClickChangeDiffcult(slot0, slot1)
	if not slot0._nowDiff then
		return
	end

	slot0:selectDiffcult(slot1 and slot0._nowDiff + 1 or slot0._nowDiff - 1, false)
end

function slot0.onClickLock(slot0)
	GameFacade.showToast(ToastEnum.ToughBattleDiffcultLock)
end

function slot0.onShowReward(slot0)
	if slot0._goreward.activeSelf then
		gohelper.setActive(slot0._goreward, false)
	else
		slot0:updateReward()
		gohelper.setActive(slot0._goreward, true)
	end
end

function slot0._onTouchScreen(slot0)
	if not gohelper.isMouseOverGo(slot0._btnreward) and not gohelper.isMouseOverGo(slot0._gorewardbg) then
		gohelper.setActive(slot0._goreward, false)
	end
end

function slot0.autoSelectDiffcult(slot0)
	if #slot0:getInfo().passDifficulty + 1 > 3 then
		slot2 = 3
	end

	slot6 = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ToughBattleLastSelectDiffcult), 0)
	slot7 = nil
	slot8 = 1

	if slot2 > 1 and PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ToughBattleLastUnlockDiffcult), 0) < slot2 then
		slot8 = slot2
		slot7 = true

		GameFacade.showToast(ToastEnum.ToughBattleDiffcultUnLock, luaLang("toughbattle_diffcult_" .. slot2))
	else
		slot8 = slot6 > 0 and slot6 <= slot2 and slot6 or slot2
	end

	PlayerPrefsHelper.setNumber(slot3, slot2)
	PlayerPrefsHelper.setNumber(slot4, slot8)
	slot0:selectDiffcult(slot8, slot7)
end

function slot0.selectDiffcult(slot0, slot1, slot2)
	if slot2 then
		slot0._animdiffcult:Play("unlock", 0, 0)
	end

	slot0._nowDiff = slot1
	slot4 = #slot0:getInfo().passDifficulty + 1

	gohelper.setActive(slot0._btnleft, slot1 > 1)
	gohelper.setActive(slot0._btnright, slot1 < 3 and slot4 ~= slot1)
	gohelper.setActive(slot0._btnrightlock, slot1 < 3 and slot4 == slot1)
	gohelper.setActive(slot0._gored, slot4 == slot1)
	gohelper.setActive(slot0._gored2, slot1 < slot4)

	slot5 = tabletool.indexOf(slot3.enterDifficulty, slot1)

	gohelper.setActive(slot0._propbottomicon, not slot5)

	if slot5 then
		slot0._txtstart.text = luaLang("toughbattle_mainview_txt_continue")
	else
		slot0._txtstart.text = luaLang("toughbattle_mainview_txt_start")
	end

	slot0._txtdiffcult.text = luaLang("toughbattle_diffcult_" .. slot1)

	UISpriteSetMgr.instance:setToughBattleSprite(slot0._imgdiffcult, "toughbattle_difficultychoosebg" .. slot1)
	UISpriteSetMgr.instance:setToughBattleSprite(slot0._imgdiffculticon, "toughbattle_difficulty" .. slot1)
end

function slot0.getInfo(slot0)
	return slot0.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()
end

function slot0._onEnter(slot0)
	if slot0.viewParam.mode == ToughBattleEnum.Mode.Story then
		SiegeBattleRpc.instance:sendStartSiegeBattleRequest(slot0.onEnterFinish, slot0)
	else
		if not tabletool.indexOf(slot0:getInfo().enterDifficulty, slot0._nowDiff) and slot0:getNowNum() < slot0:getCostNum() then
			GameFacade.showToast(ToastEnum.ToughBattleCostNoEnough)

			return
		end

		Activity158Rpc.instance:sendAct158StartChallengeRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, slot0._nowDiff, slot0.onEnterFinish, slot0)
	end
end

function slot0.getNowNum(slot0)
	return CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a9ToughEnter) and slot1.quantity or 0
end

function slot0.getCostNum(slot0)
	return string.splitToNumber(ToughBattleConfig.instance:getConstValue(ToughBattleEnum.TicketConstId), "#")[3] or 0
end

function slot0.onEnterFinish(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot4 = slot0.viewParam.mode == ToughBattleEnum.Mode.Act
		slot0.viewParam.lastFightSuccIndex = nil

		ViewMgr.instance:openView(slot4 and ViewName.ToughBattleActMapView or ViewName.ToughBattleMapView, slot0.viewParam)
		ViewMgr.instance:openView(slot4 and ViewName.ToughBattleActLoadingView or ViewName.ToughBattleLoadingView, {
			stage = 1
		})
		slot0:closeThis()
	end
end

return slot0

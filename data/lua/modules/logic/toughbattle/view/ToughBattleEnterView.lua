module("modules.logic.toughbattle.view.ToughBattleEnterView", package.seeall)

local var_0_0 = class("ToughBattleEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/left/top/#txt_desc")
	arg_1_0._gosmalltxt = gohelper.findChild(arg_1_0.viewGO, "root/left/top/titlesmalltxt")
	arg_1_0._goprop = gohelper.findChild(arg_1_0.viewGO, "root/right/top/prop")
	arg_1_0._txtpropnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/top/prop/#txt_num")
	arg_1_0._propicon = gohelper.findChildImage(arg_1_0.viewGO, "root/right/top/prop/propicon")
	arg_1_0._btnProp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/top/#btn_prop")
	arg_1_0._godiffcult = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/difficulty")
	arg_1_0._animdiffcult = arg_1_0._godiffcult:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._imgdiffcult = gohelper.findChildImage(arg_1_0.viewGO, "root/right/bottom/difficulty/bg")
	arg_1_0._imgdiffculticon = gohelper.findChildImage(arg_1_0.viewGO, "root/right/bottom/difficulty/#simage_icon")
	arg_1_0._txtdiffcult = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/bottom/difficulty/#txt_diff")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/bottom/difficulty/#go_leftchoosebtn")
	arg_1_0._btnleftlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/bottom/difficulty/#go_leftlockbtn")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/bottom/difficulty/#go_rightchoosebtn")
	arg_1_0._btnrightlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/bottom/difficulty/#go_rightlockbtn")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/bottom/#btn_startbtn")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/#btn_startbtn/#go_reddot")
	arg_1_0._gored2 = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/difficulty/#go_reddot")
	arg_1_0._txtstart = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/bottom/#btn_startbtn/txt_start")
	arg_1_0._propbottomicon = gohelper.findChildImage(arg_1_0.viewGO, "root/right/bottom/prop")
	arg_1_0._txtpropcost = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/bottom/prop/#txt_num")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/bottom/#btn_rewardbtn")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/RewardTips")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG/#scroll_Rewards/Viewport/#go_rewards/item")
	arg_1_0._gorewardbg = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG")
	arg_1_0._gorewardscroll = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/RewardTips/image_RewardTipsBG/#scroll_Rewards")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "root/left/top/timebg")
	arg_1_0._txttime = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/left/top/timebg/#txt_time")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._onEnter, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0.onClickChangeDiffcult, arg_2_0, false)
	arg_2_0._btnright:AddClickListener(arg_2_0.onClickChangeDiffcult, arg_2_0, true)
	arg_2_0._btnrightlock:AddClickListener(arg_2_0.onClickLock, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0.onShowReward, arg_2_0)
	arg_2_0._btnProp:AddClickListener(arg_2_0.onClickProp, arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_2_0._onTouchScreen, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnrightlock:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnProp:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_3_0._onTouchScreen, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_enter)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
	gohelper.setActive(arg_4_0._gorewarditem, false)
	gohelper.setActive(arg_4_0._goreward, false)
	gohelper.setActive(arg_4_0._btnleftlock, false)
	gohelper.setActive(arg_4_0._goprop, arg_4_0.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(arg_4_0._propbottomicon, arg_4_0.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(arg_4_0._godiffcult, arg_4_0.viewParam.mode == ToughBattleEnum.Mode.Act)
	gohelper.setActive(arg_4_0._gosmalltxt, arg_4_0.viewParam.mode == ToughBattleEnum.Mode.Act)

	arg_4_0._txtstart.text = luaLang("toughbattle_mainview_txt_start")

	if arg_4_0.viewParam.mode == ToughBattleEnum.Mode.Act then
		RedDotController.instance:addRedDot(arg_4_0._gored, RedDotEnum.DotNode.V1a9ToughBattle)
		RedDotController.instance:addRedDot(arg_4_0._gored2, RedDotEnum.DotNode.V1a9ToughBattle)
		arg_4_0:autoSelectDiffcult()
		arg_4_0:updateCost()

		arg_4_0._txtdesc.text = luaLang("toughbattle_mainview_act_title_desc")
	else
		arg_4_0._txtdesc.text = luaLang("toughbattle_mainview_normal_title_desc")
	end

	arg_4_0:updateTime()
end

function var_0_0.onClose(arg_5_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
end

function var_0_0.updateReward(arg_6_0)
	local var_6_0

	if arg_6_0.viewParam.mode == ToughBattleEnum.Mode.Act then
		var_6_0 = ToughBattleConfig.instance:getCOByDiffcult(arg_6_0._nowDiff).stage2
	else
		var_6_0 = ToughBattleConfig.instance:getStoryCO().stage2
	end

	local var_6_1 = lua_episode.configDict[var_6_0.episodeId]

	if not var_6_1 then
		logError("没有关卡配置" .. var_6_0.episodeId)

		return
	end

	local var_6_2 = false

	if arg_6_0.viewParam.mode == ToughBattleEnum.Mode.Act then
		local var_6_3 = arg_6_0:getInfo()

		var_6_2 = tabletool.indexOf(var_6_3.passDifficulty, arg_6_0._nowDiff)
	end

	local var_6_4 = lua_bonus.configDict[var_6_1.firstBonus]

	if not var_6_4 then
		logError("没有奖励配置" .. var_6_0.episodeId .. " >> " .. var_6_1.firstBonus)

		return
	end

	local var_6_5 = GameUtil.splitString2(var_6_4.fixBonus, true)
	local var_6_6 = #var_6_5

	recthelper.setWidth(arg_6_0._gorewardbg.transform, math.min(var_6_6 * 126 + 58, 465))
	recthelper.setWidth(arg_6_0._gorewardscroll.transform, math.min(var_6_6 * 126 + 58, 495))

	arg_6_0._rewardItems = arg_6_0._rewardItems or {}

	for iter_6_0 = 1, var_6_6 do
		if not arg_6_0._rewardItems[iter_6_0] then
			arg_6_0._rewardItems[iter_6_0] = {}

			local var_6_7 = gohelper.cloneInPlace(arg_6_0._gorewarditem, "item" .. iter_6_0)

			gohelper.setActive(var_6_7, true)

			local var_6_8 = gohelper.findChild(var_6_7, "itemicon")

			arg_6_0._rewardItems[iter_6_0].item = IconMgr.instance:getCommonPropItemIcon(var_6_8)
			arg_6_0._rewardItems[iter_6_0].go = var_6_7
			arg_6_0._rewardItems[iter_6_0].finished = gohelper.findChild(var_6_7, "finished")
		end

		gohelper.setActive(arg_6_0._rewardItems[iter_6_0].go, true)

		local var_6_9 = var_6_5[iter_6_0]

		arg_6_0._rewardItems[iter_6_0].item:setMOValue(var_6_9[1], var_6_9[2], var_6_9[3], nil, true)
		arg_6_0._rewardItems[iter_6_0].item:setCountFontSize(46)
		arg_6_0._rewardItems[iter_6_0].item:SetCountBgHeight(31)
		gohelper.setActive(arg_6_0._rewardItems[iter_6_0].finished, var_6_2)
	end

	for iter_6_1 = var_6_6 + 1, #arg_6_0._rewardItems do
		gohelper.setActive(arg_6_0._rewardItems[iter_6_1].go.transform.parent, false)
	end
end

function var_0_0.updateTime(arg_7_0)
	if arg_7_0.viewParam.mode == ToughBattleEnum.Mode.Act then
		local var_7_0 = ActivityModel.instance:getActivityInfo()[VersionActivity1_9Enum.ActivityId.ToughBattle]

		if not var_7_0 then
			gohelper.setActive(arg_7_0._gotime, false)

			return
		end

		local var_7_1 = var_7_0:getRealEndTimeStamp() - ServerTime.now()

		arg_7_0._txttime.text = TimeUtil.SecondToActivityTimeFormat(var_7_1)

		gohelper.setActive(arg_7_0._gotime, true)
	else
		gohelper.setActive(arg_7_0._gotime, false)
	end
end

function var_0_0.updateCost(arg_8_0)
	local var_8_0 = ToughBattleConfig.instance:getConstValue(ToughBattleEnum.HoldTicketMaxLimitConstId, true)
	local var_8_1 = arg_8_0:getCostNum()
	local var_8_2 = arg_8_0:getNowNum()

	if var_8_1 <= var_8_2 then
		arg_8_0._txtpropcost.text = "<color=#ffffff>-" .. var_8_1
	else
		arg_8_0._txtpropcost.text = "<color=#e44646>-" .. var_8_1
	end

	arg_8_0._txtpropnum.text = var_8_2 .. "/" .. var_8_0

	local var_8_3 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a9ToughEnter).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_8_0._propicon, var_8_3 .. "_1")
	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_8_0._propbottomicon, var_8_3 .. "_1")
end

function var_0_0.onClickProp(arg_9_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a9ToughEnter, false, nil, false)
end

function var_0_0.onClickChangeDiffcult(arg_10_0, arg_10_1)
	if not arg_10_0._nowDiff then
		return
	end

	arg_10_0:selectDiffcult(arg_10_1 and arg_10_0._nowDiff + 1 or arg_10_0._nowDiff - 1, false)
end

function var_0_0.onClickLock(arg_11_0)
	GameFacade.showToast(ToastEnum.ToughBattleDiffcultLock)
end

function var_0_0.onShowReward(arg_12_0)
	if arg_12_0._goreward.activeSelf then
		gohelper.setActive(arg_12_0._goreward, false)
	else
		arg_12_0:updateReward()
		gohelper.setActive(arg_12_0._goreward, true)
	end
end

function var_0_0._onTouchScreen(arg_13_0)
	if not gohelper.isMouseOverGo(arg_13_0._btnreward) and not gohelper.isMouseOverGo(arg_13_0._gorewardbg) then
		gohelper.setActive(arg_13_0._goreward, false)
	end
end

function var_0_0.autoSelectDiffcult(arg_14_0)
	local var_14_0 = #arg_14_0:getInfo().passDifficulty + 1

	if var_14_0 > 3 then
		var_14_0 = 3
	end

	local var_14_1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ToughBattleLastUnlockDiffcult)
	local var_14_2 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ToughBattleLastSelectDiffcult)
	local var_14_3 = PlayerPrefsHelper.getNumber(var_14_1, 0)
	local var_14_4 = PlayerPrefsHelper.getNumber(var_14_2, 0)
	local var_14_5
	local var_14_6 = 1

	if var_14_0 > 1 and var_14_3 < var_14_0 then
		var_14_6 = var_14_0
		var_14_5 = true

		GameFacade.showToast(ToastEnum.ToughBattleDiffcultUnLock, luaLang("toughbattle_diffcult_" .. var_14_0))
	elseif var_14_4 > 0 and var_14_4 <= var_14_0 then
		var_14_6 = var_14_4
	else
		var_14_6 = var_14_0
	end

	PlayerPrefsHelper.setNumber(var_14_1, var_14_0)
	PlayerPrefsHelper.setNumber(var_14_2, var_14_6)
	arg_14_0:selectDiffcult(var_14_6, var_14_5)
end

function var_0_0.selectDiffcult(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 then
		arg_15_0._animdiffcult:Play("unlock", 0, 0)
	end

	arg_15_0._nowDiff = arg_15_1

	local var_15_0 = arg_15_0:getInfo()
	local var_15_1 = #var_15_0.passDifficulty + 1

	gohelper.setActive(arg_15_0._btnleft, arg_15_1 > 1)
	gohelper.setActive(arg_15_0._btnright, arg_15_1 < 3 and var_15_1 ~= arg_15_1)
	gohelper.setActive(arg_15_0._btnrightlock, arg_15_1 < 3 and var_15_1 == arg_15_1)
	gohelper.setActive(arg_15_0._gored, var_15_1 == arg_15_1)
	gohelper.setActive(arg_15_0._gored2, arg_15_1 < var_15_1)

	local var_15_2 = tabletool.indexOf(var_15_0.enterDifficulty, arg_15_1)

	gohelper.setActive(arg_15_0._propbottomicon, not var_15_2)

	if var_15_2 then
		arg_15_0._txtstart.text = luaLang("toughbattle_mainview_txt_continue")
	else
		arg_15_0._txtstart.text = luaLang("toughbattle_mainview_txt_start")
	end

	arg_15_0._txtdiffcult.text = luaLang("toughbattle_diffcult_" .. arg_15_1)

	UISpriteSetMgr.instance:setToughBattleSprite(arg_15_0._imgdiffcult, "toughbattle_difficultychoosebg" .. arg_15_1)
	UISpriteSetMgr.instance:setToughBattleSprite(arg_15_0._imgdiffculticon, "toughbattle_difficulty" .. arg_15_1)
end

function var_0_0.getInfo(arg_16_0)
	return arg_16_0.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()
end

function var_0_0._onEnter(arg_17_0)
	if arg_17_0.viewParam.mode == ToughBattleEnum.Mode.Story then
		SiegeBattleRpc.instance:sendStartSiegeBattleRequest(arg_17_0.onEnterFinish, arg_17_0)
	else
		local var_17_0 = arg_17_0:getInfo()

		if not tabletool.indexOf(var_17_0.enterDifficulty, arg_17_0._nowDiff) and arg_17_0:getNowNum() < arg_17_0:getCostNum() then
			GameFacade.showToast(ToastEnum.ToughBattleCostNoEnough)

			return
		end

		Activity158Rpc.instance:sendAct158StartChallengeRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, arg_17_0._nowDiff, arg_17_0.onEnterFinish, arg_17_0)
	end
end

function var_0_0.getNowNum(arg_18_0)
	local var_18_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a9ToughEnter)

	return var_18_0 and var_18_0.quantity or 0
end

function var_0_0.getCostNum(arg_19_0)
	local var_19_0 = ToughBattleConfig.instance:getConstValue(ToughBattleEnum.TicketConstId)

	return string.splitToNumber(var_19_0, "#")[3] or 0
end

function var_0_0.onEnterFinish(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 == 0 then
		local var_20_0 = arg_20_0.viewParam.mode == ToughBattleEnum.Mode.Act
		local var_20_1 = var_20_0 and ViewName.ToughBattleActLoadingView or ViewName.ToughBattleLoadingView
		local var_20_2 = var_20_0 and ViewName.ToughBattleActMapView or ViewName.ToughBattleMapView

		arg_20_0.viewParam.lastFightSuccIndex = nil

		ViewMgr.instance:openView(var_20_2, arg_20_0.viewParam)
		ViewMgr.instance:openView(var_20_1, {
			stage = 1
		})
		arg_20_0:closeThis()
	end
end

return var_0_0

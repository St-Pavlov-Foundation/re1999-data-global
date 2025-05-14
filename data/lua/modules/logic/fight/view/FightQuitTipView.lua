module("modules.logic.fight.view.FightQuitTipView", package.seeall)

local var_0_0 = class("FightQuitTipView", BaseView)
local var_0_1 = {
	Tip = 1,
	Confirm = 2
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_quitshowview/center/layout/#simage_maskbg")
	arg_1_0._simagetipbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_quittipview/#simage_tipbg")
	arg_1_0._goquitshowview = gohelper.findChild(arg_1_0.viewGO, "#go_quitshowview")
	arg_1_0._goquittipview = gohelper.findChild(arg_1_0.viewGO, "#go_quittipview")
	arg_1_0._gopasstarget = gohelper.findChild(arg_1_0.viewGO, "#go_quitshowview/center/layout/passtarget")
	arg_1_0._goconditionitem = gohelper.findChild(arg_1_0.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem")
	arg_1_0._goconditionitemdesc = gohelper.findChild(arg_1_0.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem/desc")
	arg_1_0._goquitfight = gohelper.findChild(arg_1_0.viewGO, "#go_quittipview/tipcontent/#go_quitfight")
	arg_1_0._goadditiondetail = gohelper.findChild(arg_1_0.viewGO, "#go_quitshowview/#go_additiondetail")
	arg_1_0._btncloserule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quitshowview/#go_additiondetail/#btn_closerule")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "#go_quitshowview/#go_additiondetail/bg/#go_ruleDescList")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "#go_quitshowview/#go_additiondetail/bg/#go_ruleDescList/#go_ruleitem")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quitshowview/center/btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quitshowview/center/btn/#btn_restart")
	arg_1_0._btnfighttechnical = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quitshowview/center/btn/#btn_fighttechnical")
	arg_1_0._btnrouge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quitshowview/center/btn/#btn_rouge")
	arg_1_0._gocareercontent = gohelper.findChild(arg_1_0.viewGO, "#go_quitshowview/center/layout/careerContent/#go_careercontent")
	arg_1_0._btncontinuegame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quitshowview/center/btn/#btn_continuegame")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quittipview/#btn_sure")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quittipview/#btn_no")
	arg_1_0._simagenumline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_quittipview/num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnRestart, arg_2_0)
	arg_2_0._btnfighttechnical:AddClickListener(arg_2_0._btnfighttechnicalOnClick, arg_2_0)
	arg_2_0._btnrouge:AddClickListener(arg_2_0._btnrougeOnClick, arg_2_0)
	arg_2_0._btncontinuegame:AddClickListener(arg_2_0._onBtnContinueGame, arg_2_0)
	arg_2_0._btncloserule:AddClickListener(arg_2_0._onBtnContinueGame, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0._btncloserule:AddClickListener(arg_2_0._btncloseruleOnClick, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, arg_2_0._onKeyExit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnfighttechnical:RemoveClickListener()
	arg_3_0._btnrouge:RemoveClickListener()
	arg_3_0._btncontinuegame:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0._btncloserule:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, arg_3_0._btnnoOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, arg_3_0._onKeyExit, arg_3_0)
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.GuideView then
		arg_4_0:closeThis()
	end
end

function var_0_0._btnyesOnClick(arg_5_0)
	arg_5_0.status = var_0_1.Confirm

	arg_5_0:_refreshUI()
	gohelper.setActive(arg_5_0._goquitshowview, false)
	arg_5_0:_setQuitText()
end

function var_0_0._btnRestart(arg_6_0)
	if FightReplayModel.instance:isReplay() then
		return false
	end

	local var_6_0 = FightModel.instance:getCurStage()

	if var_6_0 == FightEnum.Stage.EndRound or var_6_0 == FightEnum.Stage.End then
		ToastController.instance:showToast(-80)

		return
	end

	FightSystem.instance:restartFight()
end

function var_0_0._setQuitText(arg_7_0)
	if arg_7_0._descTxt then
		return
	end

	arg_7_0._descTxt = gohelper.findChildText(arg_7_0._goquitfight, "desc")

	local var_7_0 = DungeonConfig.instance:getEpisodeCO(arg_7_0._episodeId)

	if var_7_0 then
		if var_7_0.type == DungeonEnum.EpisodeType.WeekWalk or var_7_0.type == DungeonEnum.EpisodeType.Season then
			arg_7_0._descTxt.text = luaLang("quit_fight_weekwalk")

			return
		elseif var_7_0.type == DungeonEnum.EpisodeType.Cachot then
			arg_7_0._descTxt.text = luaLang("cachot_quit_fight")

			return
		elseif var_7_0.type == DungeonEnum.EpisodeType.Rouge then
			arg_7_0._descTxt.text = luaLang("rouge_quit_fight_confirm")

			return
		end
	end

	local var_7_1 = var_7_0 and DungeonConfig.instance:getChapterCO(var_7_0.chapterId)

	if var_7_1 and var_7_1.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(var_7_1.type) > 0 then
		arg_7_0._descTxt.text = lua_language_coder.configDict.quit_fight_equip_1.lang

		return
	end

	if (tonumber(DungeonConfig.instance:getEndBattleCost(arg_7_0._episodeId, false)) or 0) <= 0 then
		arg_7_0._descTxt.text = lua_language_coder.configDict.quit_fight_weekwalk.lang

		return
	end

	if arg_7_0._episodeId then
		local var_7_2 = DungeonModel.instance:getEpisodeInfo(arg_7_0._episodeId)
	end

	local var_7_3 = FightModel.instance:getFightParam()

	if not var_7_3 or not var_7_3.multiplication then
		local var_7_4 = 1
	end

	arg_7_0._descTxt.text = luaLang("confirm_quit")
end

function var_0_0._onKeyExit(arg_8_0)
	if arg_8_0._goquitshowview and not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		arg_8_0:_btnsureOnClick()
	end
end

function var_0_0._btnsureOnClick(arg_9_0)
	arg_9_0:closeThis()

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		FightSystem.instance:dispose()
		FightModel.instance:clearRecordMO()
		FightController.instance:exitFightScene()

		return
	end

	local var_9_0 = FightModel.instance:getCurStage()

	if var_9_0 ~= FightEnum.Stage.EndRound and var_9_0 ~= FightEnum.Stage.End then
		if not FightModel.instance:getFightParam().isTestFight then
			DungeonFightController.instance:sendEndFightRequest(true)
		else
			FightRpc.instance:sendEndFightRequest(true)
		end
	end
end

function var_0_0._btnnoOnClick(arg_10_0)
	arg_10_0.status = var_0_1.Tip

	arg_10_0:_refreshUI()
	gohelper.setActive(arg_10_0._goquitshowview, true)
end

function var_0_0._onBtnContinueGame(arg_11_0)
	arg_11_0:closeThis()
	FightController.instance:dispatchEvent(FightEvent.OnFightQuitTipViewClose)
end

function var_0_0._btncloseruleOnClick(arg_12_0)
	gohelper.setActive(arg_12_0._goadditiondetail, false)
end

function var_0_0._btnfighttechnicalOnClick(arg_13_0)
	FightController.instance:openFightTechniqueView()
end

function var_0_0._btnrougeOnClick(arg_14_0)
	FightController.instance:openFightTechniqueView()
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
	arg_15_0._simagemaskbg:LoadImage(ResUrl.getFightIcon("img_zanting_bg.png"))
	arg_15_0._simagenumline:LoadImage(ResUrl.getMessageIcon("bg_num"))

	arg_15_0._episodeId = DungeonModel.instance.curSendEpisodeId
	arg_15_0._chapterId = DungeonModel.instance.curSendChapterId

	local var_15_0 = DungeonConfig.instance:getChapterCO(arg_15_0._chapterId)

	arg_15_0._hardMode = var_15_0 and var_15_0.type == DungeonEnum.ChapterType.Hard
	arg_15_0._weekwalkMode = var_15_0 and var_15_0.type == DungeonEnum.ChapterType.WeekWalk
	arg_15_0._rougeMode = var_15_0 and var_15_0.type == DungeonEnum.ChapterType.Rouge

	if arg_15_0._hardMode then
		arg_15_0._episodeId = DungeonConfig.instance:getHardEpisode(arg_15_0._episodeId).id
	end

	gohelper.setActive(arg_15_0._goruleitem, false)
	gohelper.setActive(arg_15_0._goadditiondetail, false)

	arg_15_0._ruleItemsImage = arg_15_0:getUserDataTb_()
	arg_15_0._ruleItemsDescImage = arg_15_0:getUserDataTb_()

	for iter_15_0 = 1, 6 do
		local var_15_1 = gohelper.findChildImage(arg_15_0._gocareercontent, "career" .. iter_15_0)

		UISpriteSetMgr.instance:setCommonSprite(var_15_1, "lssx_" .. iter_15_0)
	end

	gohelper.addUIClickAudio(arg_15_0._btnquitgame.gameObject, AudioEnum.UI.Play_UI_Rolesback)
	gohelper.addUIClickAudio(arg_15_0._btncontinuegame.gameObject, AudioEnum.UI.Play_UI_Tags)
	gohelper.addUIClickAudio(arg_15_0._btnsure.gameObject, AudioEnum.UI.Play_UI_Rolesout)
	gohelper.addUIClickAudio(arg_15_0._btnno.gameObject, AudioEnum.UI.Play_UI_Tags)

	local var_15_2 = gohelper.findChild(arg_15_0._btnsure.gameObject, "#go_pcbtn")
	local var_15_3 = gohelper.findChild(arg_15_0._btnno.gameObject, "#go_pcbtn")

	PCInputController.instance:showkeyTips(var_15_2, nil, nil, "Return")
	PCInputController.instance:showkeyTips(var_15_3, nil, nil, "Esc")
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	if arg_17_0:episodeNeedHideRestart() then
		gohelper.setActive(arg_17_0._btnrestart.gameObject, false)
	else
		gohelper.setActive(arg_17_0._btnrestart.gameObject, not FightReplayModel.instance:isReplay())
	end

	arg_17_0.status = var_0_1.Tip

	arg_17_0:_loadCondition()
	arg_17_0:_refreshUI()

	local var_17_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightTechnique)

	gohelper.setActive(arg_17_0._btnfighttechnical.gameObject, var_17_0 and not arg_17_0._rougeMode)
	gohelper.setActive(arg_17_0._btnrouge.gameObject, var_17_0 and arg_17_0._rougeMode)
	NavigateMgr.instance:addEscape(ViewName.FightQuitTipView, arg_17_0._onBtnContinueGame, arg_17_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_fight_keeporquit)
	FightAudioMgr.instance:obscureBgm(true)
end

function var_0_0.episodeNeedHideRestart(arg_18_0)
	local var_18_0 = DungeonConfig.instance:getEpisodeCO(arg_18_0._episodeId)

	if var_18_0 and arg_18_0:checkNeedHideRestartEpisodeType(var_18_0.type) then
		return true
	end

	if var_18_0 then
		local var_18_1 = DungeonConfig.instance:getChapterCO(var_18_0.chapterId)
		local var_18_2 = FightRestartSequence.RestartType2Type[var_18_1.type] or var_18_1.type

		if var_18_1 and not _G["FightRestartAbandonType" .. var_18_2] then
			return true
		end
	end

	return false
end

function var_0_0.checkNeedHideRestartEpisodeType(arg_19_0, arg_19_1)
	if not arg_19_0._hideRestartEpisodeTypes then
		arg_19_0._hideRestartEpisodeTypes = {
			[DungeonEnum.EpisodeType.Dog] = true,
			[DungeonEnum.EpisodeType.Act1_6DungeonBoss] = true
		}
	end

	return arg_19_0._hideRestartEpisodeTypes[arg_19_1]
end

function var_0_0._refreshUI(arg_20_0)
	local var_20_0 = arg_20_0.status == var_0_1.Tip

	gohelper.setActive(arg_20_0._goquitshowview, var_20_0)
	gohelper.setActive(arg_20_0._goquittipview, not var_20_0)
end

function var_0_0._loadCondition(arg_21_0)
	local var_21_0 = DungeonModel.instance:getEpisodeInfo(arg_21_0._episodeId)
	local var_21_1 = DungeonConfig.instance:getEpisodeCO(arg_21_0._episodeId)

	if var_21_1 then
		if var_21_1.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
			gohelper.setActive(arg_21_0._gopasstarget, false)

			return
		elseif SeasonFightHandler.loadSeasonCondition(var_21_1.type, arg_21_0._gopasstarget, arg_21_0._goconditionitemdesc, arg_21_0._goconditionitem) then
			return
		end
	end

	local var_21_2 = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())

	if BossRushController.instance:isInBossRushInfiniteFight() then
		var_21_2 = luaLang("v1a4_bossrushleveldetail_txt_target")
	end

	arg_21_0:_setConditionText(arg_21_0._goconditionitemdesc, var_21_2, false)
	arg_21_0:_setStarStatus(arg_21_0._goconditionitemdesc, false)

	if not var_21_0 or not var_21_1 then
		return
	end

	local var_21_3 = DungeonModel.instance.curSendChapterId

	if var_21_3 then
		local var_21_4 = DungeonConfig.instance:getChapterCO(var_21_3)

		if var_21_4 and var_21_4.type == DungeonEnum.ChapterType.Simple then
			return
		end
	end

	local var_21_5 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_21_0._episodeId, FightModel.instance:getBattleId())

	if not LuaUtil.isEmptyStr(var_21_5) then
		local var_21_6 = gohelper.clone(arg_21_0._goconditionitemdesc, arg_21_0._goconditionitem, "platnumdesc")
		local var_21_7 = arg_21_0:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(arg_21_0._episodeId, 1, FightModel.instance:getBattleId()))
		local var_21_8 = ""

		if not FightModel.instance.needFightReconnect then
			local var_21_9 = DungeonConfig.instance:getEpisodeAdvancedCondition(arg_21_0._episodeId, FightModel.instance:getBattleId())
			local var_21_10 = lua_condition.configDict[tonumber(var_21_9)]
			local var_21_11 = var_21_10 and tonumber(var_21_10.type)

			if var_21_11 and var_21_11 == 7 then
				var_21_8 = string.format(" (%d/%s)", arg_21_0:_getPlatinumProgress7(), var_21_10.attr)
			elseif var_21_11 and var_21_11 == 8 then
				var_21_8 = string.format(" (%d/%s)", arg_21_0:_getPlatinumProgress8(), var_21_10.attr)
			elseif var_21_11 and var_21_11 == 9 then
				var_21_8 = string.format(" (%d%%/%s%%)", arg_21_0:_getPlatinumProgress9(), tostring(tonumber(var_21_10.attr) / 10))
			end
		end

		arg_21_0:_setConditionText(var_21_6, var_21_5 .. var_21_8, var_21_7)
		arg_21_0:_setStarStatus(var_21_6, var_21_7)
	end

	local var_21_12 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(arg_21_0._episodeId, FightModel.instance:getBattleId())

	if not LuaUtil.isEmptyStr(var_21_12) then
		local var_21_13 = gohelper.clone(arg_21_0._goconditionitemdesc, arg_21_0._goconditionitem, "platnumdesc2")
		local var_21_14 = arg_21_0:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(arg_21_0._episodeId, 2, FightModel.instance:getBattleId()))

		arg_21_0:_setConditionText(var_21_13, var_21_12, var_21_14)
		arg_21_0:_setStarStatus(var_21_13, var_21_14)
	end
end

function var_0_0._getPlatinumProgress7(arg_22_0)
	local var_22_0 = FightModel.instance:getHistoryRoundMOList()
	local var_22_1

	var_22_1 = var_22_0 and tabletool.copy(var_22_0) or {}

	local var_22_2 = FightModel.instance:getCurRoundMO()

	if var_22_2 and not tabletool.indexOf(var_22_1, var_22_2) then
		table.insert(var_22_1, FightModel.instance:getCurRoundMO())
	end

	local var_22_3 = 0

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		local var_22_4 = 0

		for iter_22_2, iter_22_3 in ipairs(iter_22_1.fightStepMOs) do
			if iter_22_3.hasPlay and iter_22_3.actType == FightEnum.ActType.SKILL then
				local var_22_5 = FightDataHelper.entityMgr:getById(iter_22_3.fromId)

				if var_22_5 and var_22_5.side == FightEnum.EntitySide.MySide and var_22_5:isUniqueSkill(iter_22_3.actId) then
					var_22_4 = var_22_4 + 1
				end
			end
		end

		var_22_3 = math.max(var_22_3, var_22_4)
	end

	return var_22_3
end

local var_0_2 = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.BEATBACK] = true,
	[FightEnum.EffectType.DAMAGEEXTRA] = true
}

function var_0_0._getPlatinumProgress8(arg_23_0)
	local var_23_0 = FightModel.instance:getHistoryRoundMOList()
	local var_23_1

	var_23_1 = var_23_0 and tabletool.copy(var_23_0) or {}

	local var_23_2 = FightModel.instance:getCurRoundMO()

	if var_23_2 and not tabletool.indexOf(var_23_1, var_23_2) then
		table.insert(var_23_1, FightModel.instance:getCurRoundMO())
	end

	local var_23_3 = 0

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		for iter_23_2, iter_23_3 in ipairs(iter_23_1.fightStepMOs) do
			local var_23_4 = FightDataHelper.entityMgr:getById(iter_23_3.fromId)

			if iter_23_3.hasPlay and var_23_4 and var_23_4.side == FightEnum.EntitySide.MySide then
				local var_23_5 = 0

				for iter_23_4, iter_23_5 in ipairs(iter_23_3.actEffectMOs) do
					local var_23_6 = FightDataHelper.entityMgr:getById(iter_23_5.targetId)

					if var_23_6 and var_23_6.side == FightEnum.EntitySide.EnemySide then
						if var_0_2[iter_23_5.effectType] then
							var_23_5 = var_23_5 + iter_23_5.effectNum
						elseif iter_23_5.effectType == FightEnum.EffectType.SHIELDDEL then
							var_23_5 = var_23_5 + iter_23_5.effectNum
						elseif iter_23_5.effectType == FightEnum.EffectType.SHIELD and iter_23_5.entityMO then
							var_23_5 = var_23_5 + iter_23_5.entityMO.shieldValue - iter_23_5.effectNum
						end
					end
				end

				var_23_3 = math.max(var_23_3, var_23_5)
			end
		end
	end

	return var_23_3
end

function var_0_0._getPlatinumProgress9(arg_24_0)
	local var_24_0 = FightDataHelper.entityMgr:getMyNormalList()
	local var_24_1 = #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide)
	local var_24_2 = 0

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		var_24_2 = var_24_2 + iter_24_1.currentHp / iter_24_1.attrMO.hp
	end

	local var_24_3 = var_24_2 / (#var_24_0 + var_24_1)

	return math.floor(var_24_3 * 100)
end

function var_0_0._setConditionText(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1:GetComponent(gohelper.Type_Text) or arg_25_1:GetComponent(gohelper.Type_TextMesh)

	if arg_25_3 then
		var_25_0.text = gohelper.getRichColorText(arg_25_2, "#E6E2DF")
	else
		var_25_0.text = gohelper.getRichColorText(arg_25_2, "#A7A6A6")
	end
end

function var_0_0._setStarStatus(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = gohelper.findChildImage(arg_26_1, "star")
	local var_26_1 = arg_26_0._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"
	local var_26_2 = "#87898C"

	if arg_26_2 then
		var_26_2 = arg_26_0._hardMode and "#FF4343" or "#F77040"
	end

	UISpriteSetMgr.instance:setCommonSprite(var_26_0, var_26_1)
	SLFramework.UGUI.GuiHelper.SetColor(var_26_0, var_26_2)
end

function var_0_0.checkPlatCondition(arg_27_0, arg_27_1)
	local var_27_0 = lua_condition.configDict[tonumber(arg_27_1)]

	if not var_27_0 then
		return true
	end

	local var_27_1 = #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide)
	local var_27_2 = FightModel.instance:getCurRoundId()

	if tonumber(var_27_0.type) == 1 then
		return var_27_1 < tonumber(var_27_0.attr)
	elseif tonumber(var_27_0.type) == 2 then
		return var_27_2 <= tonumber(var_27_0.attr)
	elseif tonumber(var_27_0.type) == 3 then
		return var_27_1 == 0 and var_27_2 <= tonumber(var_27_0.attr)
	elseif tonumber(var_27_0.type) == 4 then
		return false
	elseif tonumber(var_27_0.type) == 5 then
		return false
	elseif tonumber(var_27_0.type) == 6 then
		return false
	elseif tonumber(var_27_0.type) == 7 then
		return arg_27_0:_getPlatinumProgress7() >= tonumber(var_27_0.attr)
	elseif tonumber(var_27_0.type) == 8 then
		return arg_27_0:_getPlatinumProgress8() >= tonumber(var_27_0.attr)
	elseif tonumber(var_27_0.type) == 9 then
		return arg_27_0:_getPlatinumProgress9() >= tonumber(var_27_0.attr) / 10
	else
		return true
	end
end

function var_0_0._addEmptyRuleItem(arg_28_0)
	local var_28_0 = gohelper.clone(arg_28_0._goruletemp, arg_28_0._gorulelist, "none")

	gohelper.setActive(var_28_0, true)

	local var_28_1 = gohelper.findChildImage(var_28_0, "#image_tagicon")

	gohelper.setActive(var_28_1.gameObject, false)

	local var_28_2 = gohelper.findChildImage(var_28_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_28_2, "none")
end

function var_0_0._addRuleItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = gohelper.clone(arg_29_0._goruletemp, arg_29_0._gorulelist, arg_29_1.id)

	gohelper.setActive(var_29_0, true)

	local var_29_1 = gohelper.findChildImage(var_29_0, "#image_tagicon")

	gohelper.setActive(var_29_1.gameObject, true)
	UISpriteSetMgr.instance:setCommonSprite(var_29_1, "wz_" .. arg_29_2)

	local var_29_2 = gohelper.findChildImage(var_29_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_29_2, arg_29_1.icon)
end

function var_0_0._addRuleItemDesc(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_30_1 = gohelper.clone(arg_30_0._goruleitem, arg_30_0._goruleDescList, arg_30_1.id)
	local var_30_2 = gohelper.findChildImage(var_30_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_30_2, arg_30_1.icon)

	local var_30_3 = gohelper.findChild(var_30_1, "#go_line")

	gohelper.setActive(var_30_3, arg_30_3)

	local var_30_4 = gohelper.findChildImage(var_30_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_30_4, "wz_" .. arg_30_2)

	local var_30_5 = gohelper.findChildText(var_30_1, "desc")
	local var_30_6 = string.gsub(arg_30_1.desc, "%【(.-)%】", "<color=#6680bd>【%1】</color>")

	var_30_5.text = SkillConfig.instance:fmtTagDescColor(luaLang("dungeon_add_rule_target_" .. arg_30_2), var_30_6, var_30_0[arg_30_2])

	gohelper.setActive(var_30_1, true)
end

function var_0_0._showRuleDesc(arg_31_0)
	local var_31_0 = FightModel.instance:getFightParam()
	local var_31_1 = DungeonConfig.instance:getEpisodeCO(var_31_0.episodeId)

	if var_31_1 and not string.nilorempty(var_31_1.battleDesc) then
		gohelper.setActive(arg_31_0._goadditiontip, true)
		gohelper.setActive(arg_31_0._goaddition, true)
		gohelper.setActive(arg_31_0._goruledesc, true)
		gohelper.setActive(arg_31_0._gorulelist, false)
		gohelper.setActive(arg_31_0._ruleclick.gameObject, false)

		arg_31_0._txtruledesc1.text = var_31_1.battleDesc
	else
		gohelper.setActive(arg_31_0._goaddition, false)
	end
end

function var_0_0._ruleListClickFunc(arg_32_0)
	gohelper.setActive(arg_32_0._goadditiondetail, true)
end

function var_0_0.onClose(arg_33_0)
	FightAudioMgr.instance:obscureBgm(false)
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simagetipbg:UnLoadImage()
	arg_34_0._simagemaskbg:UnLoadImage()
	arg_34_0._simagenumline:UnLoadImage()
end

return var_0_0

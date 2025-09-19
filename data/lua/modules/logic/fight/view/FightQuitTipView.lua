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
		elseif var_7_0.type == DungeonEnum.EpisodeType.Shelter then
			arg_7_0._descTxt.text = luaLang("survival_shelter_quit_fight_confirm")

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
	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.WeekwalkVer2] then
		arg_21_0:_refreshWeekwalkVer2Condition()

		return
	end

	local var_21_0 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Odyssey]

	if var_21_0 and var_21_0.elementId and var_21_0.elementId ~= 0 and arg_21_0:refreshOdysseyTask(var_21_0) then
		return
	end

	local var_21_1 = DungeonModel.instance:getEpisodeInfo(arg_21_0._episodeId)
	local var_21_2 = DungeonConfig.instance:getEpisodeCO(arg_21_0._episodeId)

	if var_21_2 then
		if var_21_2.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
			gohelper.setActive(arg_21_0._gopasstarget, false)

			return
		elseif SeasonFightHandler.loadSeasonCondition(var_21_2.type, arg_21_0._gopasstarget, arg_21_0._goconditionitemdesc, arg_21_0._goconditionitem) then
			return
		elseif VersionActivity2_9DungeonHelper.loadFightCondition(arg_21_0, arg_21_0._episodeId, arg_21_0._gopasstarget) then
			return
		end
	end

	local var_21_3 = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())

	if BossRushController.instance:isInBossRushInfiniteFight() then
		var_21_3 = luaLang("v1a4_bossrushleveldetail_txt_target")
	end

	arg_21_0:_setConditionText(arg_21_0._goconditionitemdesc, var_21_3, false)
	arg_21_0:_setStarStatus(arg_21_0._goconditionitemdesc, false)

	if not var_21_1 or not var_21_2 then
		return
	end

	local var_21_4 = DungeonModel.instance.curSendChapterId

	if var_21_4 then
		local var_21_5 = DungeonConfig.instance:getChapterCO(var_21_4)

		if var_21_5 and var_21_5.type == DungeonEnum.ChapterType.Simple then
			return
		end
	end

	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183] then
		arg_21_0:refresh183Condition()

		return
	end

	local var_21_6 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_21_0._episodeId, FightModel.instance:getBattleId())

	if not LuaUtil.isEmptyStr(var_21_6) then
		local var_21_7 = gohelper.clone(arg_21_0._goconditionitemdesc, arg_21_0._goconditionitem, "platnumdesc")
		local var_21_8 = arg_21_0:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(arg_21_0._episodeId, 1, FightModel.instance:getBattleId()))
		local var_21_9 = ""

		if not FightModel.instance.needFightReconnect then
			local var_21_10 = DungeonConfig.instance:getEpisodeAdvancedCondition(arg_21_0._episodeId, FightModel.instance:getBattleId())
			local var_21_11 = lua_condition.configDict[tonumber(var_21_10)]
			local var_21_12 = var_21_11 and tonumber(var_21_11.type)

			if var_21_12 and var_21_12 == 7 then
				var_21_9 = string.format(" (%d/%s)", arg_21_0:_getPlatinumProgress7(), var_21_11.attr)
			elseif var_21_12 and var_21_12 == 8 then
				var_21_9 = string.format(" (%d/%s)", arg_21_0:_getPlatinumProgress8(), var_21_11.attr)
			elseif var_21_12 and var_21_12 == 9 then
				var_21_9 = string.format(" (%d%%/%s%%)", arg_21_0:_getPlatinumProgress9(), tostring(tonumber(var_21_11.attr) / 10))
			end
		end

		arg_21_0:_setConditionText(var_21_7, var_21_6 .. var_21_9, var_21_8)
		arg_21_0:_setStarStatus(var_21_7, var_21_8)
	end

	local var_21_13 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(arg_21_0._episodeId, FightModel.instance:getBattleId())

	if not LuaUtil.isEmptyStr(var_21_13) then
		local var_21_14 = gohelper.clone(arg_21_0._goconditionitemdesc, arg_21_0._goconditionitem, "platnumdesc2")
		local var_21_15 = arg_21_0:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(arg_21_0._episodeId, 2, FightModel.instance:getBattleId()))

		arg_21_0:_setConditionText(var_21_14, var_21_13, var_21_15)
		arg_21_0:_setStarStatus(var_21_14, var_21_15)
	end
end

function var_0_0._getPlatinumProgress7(arg_22_0)
	local var_22_0 = FightDataHelper.roundMgr.dataList
	local var_22_1 = 0

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_2 = 0

		for iter_22_2, iter_22_3 in ipairs(iter_22_1.fightStep) do
			if iter_22_3.hasPlay and iter_22_3.actType == FightEnum.ActType.SKILL then
				local var_22_3 = FightDataHelper.entityMgr:getById(iter_22_3.fromId)

				if var_22_3 and var_22_3.side == FightEnum.EntitySide.MySide and FightCardDataHelper.isBigSkill(iter_22_3.actId) then
					var_22_2 = var_22_2 + 1
				end
			end
		end

		var_22_1 = math.max(var_22_1, var_22_2)
	end

	return var_22_1
end

local var_0_2 = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.BEATBACK] = true,
	[FightEnum.EffectType.DAMAGEEXTRA] = true
}

function var_0_0._getPlatinumProgress8(arg_23_0)
	local var_23_0 = FightDataHelper.roundMgr.dataList
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		for iter_23_2, iter_23_3 in ipairs(iter_23_1.fightStep) do
			local var_23_2 = FightDataHelper.entityMgr:getById(iter_23_3.fromId)

			if iter_23_3.hasPlay and var_23_2 and var_23_2.side == FightEnum.EntitySide.MySide then
				local var_23_3 = 0

				for iter_23_4, iter_23_5 in ipairs(iter_23_3.actEffect) do
					local var_23_4 = FightDataHelper.entityMgr:getById(iter_23_5.targetId)

					if var_23_4 and var_23_4.side == FightEnum.EntitySide.EnemySide then
						if var_0_2[iter_23_5.effectType] then
							var_23_3 = var_23_3 + iter_23_5.effectNum
						elseif iter_23_5.effectType == FightEnum.EffectType.SHIELDDEL then
							var_23_3 = var_23_3 + iter_23_5.effectNum
						elseif iter_23_5.effectType == FightEnum.EffectType.SHIELD and iter_23_5.entity then
							var_23_3 = var_23_3 + iter_23_5.entity.shieldValue - iter_23_5.effectNum
						end
					end
				end

				var_23_1 = math.max(var_23_1, var_23_3)
			end
		end
	end

	return var_23_1
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

function var_0_0.refreshOdysseyTask(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.elementId
	local var_33_1 = lua_odyssey_fight_element.configDict[var_33_0]

	if not var_33_1 then
		return
	end

	if var_33_1.type ~= 6 then
		return
	end

	local var_33_2 = var_33_1.param
	local var_33_3 = GameUtil.splitString2(var_33_2, true)

	table.sort(var_33_3, function(arg_34_0, arg_34_1)
		return arg_34_0[1] < arg_34_1[1]
	end)

	local var_33_4 = {}

	for iter_33_0, iter_33_1 in ipairs(var_33_3) do
		local var_33_5 = iter_33_1[2]
		local var_33_6 = lua_odyssey_fight_task_desc.configDict[var_33_5]

		if var_33_6 then
			table.insert(var_33_4, var_33_6)
		end
	end

	for iter_33_2, iter_33_3 in ipairs(var_33_4) do
		local var_33_7 = gohelper.clone(arg_33_0._goconditionitemdesc, arg_33_0._goconditionitem, "platnumdesc")

		arg_33_0:showOdysseyTask(var_33_7, iter_33_3, iter_33_2)
	end

	gohelper.setActive(arg_33_0._goconditionitemdesc, false)

	gohelper.onceAddComponent(arg_33_0._goconditionitem, gohelper.Type_VerticalLayoutGroup).spacing = 60
	gohelper.findChildComponent(arg_33_0.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem/passtargetTip", typeof(UnityEngine.UI.LayoutElement)).minHeight = 35

	return true
end

function var_0_0.showOdysseyTask(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	gohelper.findChildText(arg_35_1, "").text = arg_35_2.desc

	gohelper.setActive(gohelper.findChild(arg_35_1, "star"), false)

	local var_35_0 = gohelper.findChildImage(arg_35_1, "star_weekwalkheart")

	transformhelper.setLocalScale(var_35_0.transform, 0.8, 0.8, 0.8)
	gohelper.setActive(var_35_0.gameObject, true)
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_35_0, "pingji_x_" .. arg_35_3)
end

function var_0_0._refreshWeekwalkVer2Condition(arg_36_0)
	local var_36_0 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.WeekwalkVer2]

	var_36_0 = var_36_0 and cjson.decode(var_36_0)

	if not var_36_0 then
		return
	end

	if not var_36_0.cupIds then
		return
	end

	local var_36_1 = {}

	for iter_36_0, iter_36_1 in ipairs(var_36_0.cupIds) do
		table.insert(var_36_1, iter_36_1)
	end

	table.sort(var_36_1, var_0_0.sortWeekWalkVer2Task)

	for iter_36_2, iter_36_3 in ipairs(var_36_1) do
		local var_36_2 = gohelper.clone(arg_36_0._goconditionitemdesc, arg_36_0._goconditionitem, "platnumdesc")

		arg_36_0:_showWeekWalkVer2OneTaskGroup(var_36_2, iter_36_3, iter_36_2)
	end

	gohelper.setActive(arg_36_0._goconditionitemdesc, false)
end

function var_0_0._showWeekWalkVer2OneTaskGroup(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = lua_weekwalk_ver2_cup.configDict[arg_37_2]
	local var_37_1 = gohelper.findChildText(arg_37_1, "")
	local var_37_2 = GameUtil.splitString2(var_37_0.cupTask, true)

	table.sort(var_37_2, var_0_0.sortWeekWalkVer2CupList)

	local var_37_3
	local var_37_4
	local var_37_5 = FightDataHelper.fieldMgr.fightTaskBox.tasks

	for iter_37_0, iter_37_1 in ipairs(var_37_2) do
		local var_37_6 = 0

		for iter_37_2 = 2, #iter_37_1 do
			local var_37_7 = var_37_5[iter_37_1[iter_37_2]]

			if var_37_7 then
				if var_37_7.status ~= FightTaskBoxData.TaskStatus.Finished then
					var_37_3 = iter_37_1[1]

					break
				end

				if var_37_7.status == FightTaskBoxData.TaskStatus.Finished then
					var_37_6 = var_37_6 + 1
				end
			end
		end

		if var_37_6 == #iter_37_1 - 1 then
			var_37_4 = iter_37_1[1]
		end

		if var_37_3 then
			break
		end
	end

	local var_37_8 = var_0_0._getWeekWalkVer2CupProgressDesc(var_37_3, var_37_0) or ""

	var_37_1.text = var_37_0.desc .. var_37_8

	gohelper.setActive(gohelper.findChild(arg_37_1, "star"), false)

	local var_37_9 = gohelper.findChild(arg_37_1, "star_weekwalkheart")

	gohelper.setActive(var_37_9, true)

	local var_37_10 = gohelper.findChildImage(arg_37_1, "star_weekwalkheart")

	var_37_4 = var_37_4 or 0
	var_37_10.enabled = false

	local var_37_11 = arg_37_0:getResInst(arg_37_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_37_10.gameObject)

	WeekWalk_2Helper.setCupEffectByResult(var_37_11, var_37_4)
end

function var_0_0._getWeekWalkVer2CupProgressDesc(arg_38_0, arg_38_1)
	if not arg_38_0 then
		return
	end

	local var_38_0 = arg_38_1.progressDesc

	if string.nilorempty(var_38_0) then
		return
	end

	local var_38_1 = GameUtil.splitString2(var_38_0)
	local var_38_2

	for iter_38_0, iter_38_1 in ipairs(var_38_1) do
		if tonumber(iter_38_1[1]) == arg_38_0 then
			var_38_2 = iter_38_1[2]

			break
		end
	end

	if not var_38_2 then
		return
	end

	local var_38_3 = arg_38_1.paramOfProgressDesc

	if string.nilorempty(var_38_3) then
		return
	end

	local var_38_4 = GameUtil.splitString2(var_38_3)
	local var_38_5

	for iter_38_2, iter_38_3 in ipairs(var_38_4) do
		if tonumber(iter_38_3[1]) == arg_38_0 then
			var_38_5 = iter_38_3

			break
		end
	end

	if not var_38_5 then
		return
	end

	local var_38_6 = FightDataHelper.fieldMgr.fightTaskBox.tasks
	local var_38_7 = {}
	local var_38_8 = GameUtil.splitString2(var_38_5[2], true, "_", "&")

	for iter_38_4, iter_38_5 in ipairs(var_38_8) do
		local var_38_9 = var_38_6[iter_38_5[1]]

		if var_38_9 then
			for iter_38_6, iter_38_7 in ipairs(var_38_9.values) do
				if iter_38_7.index == iter_38_5[2] then
					if iter_38_5[3] == 1 then
						local var_38_10 = math.ceil(iter_38_7.progress / iter_38_7.maxProgress * 100)

						table.insert(var_38_7, var_38_10 .. "%")
					elseif iter_38_5[3] == 2 then
						local var_38_11 = math.floor(iter_38_7.progress / iter_38_7.maxProgress * 100)

						table.insert(var_38_7, var_38_11 .. "%")
					else
						table.insert(var_38_7, iter_38_7.progress)
					end
				end
			end
		end
	end

	return (GameUtil.getSubPlaceholderLuaLang(var_38_2, var_38_7))
end

function var_0_0.sortWeekWalkVer2CupList(arg_39_0, arg_39_1)
	return arg_39_0[1] < arg_39_1[1]
end

function var_0_0.sortWeekWalkVer2Task(arg_40_0, arg_40_1)
	local var_40_0 = lua_weekwalk_ver2_cup.configDict[arg_40_0]
	local var_40_1 = lua_weekwalk_ver2_cup.configDict[arg_40_1]

	return var_40_0.cupNo < var_40_1.cupNo
end

function var_0_0.refresh183Condition(arg_41_0)
	gohelper.onceAddComponent(arg_41_0._gopasstarget, gohelper.Type_VerticalLayoutGroup).padding.bottom = -60

	local var_41_0 = FightDataHelper.fieldMgr.episodeId
	local var_41_1 = DungeonConfig.instance:getEpisodeAdvancedCondition(var_41_0)

	if LuaUtil.isEmptyStr(var_41_1) == false then
		local var_41_2 = string.splitToNumber(var_41_1, "|")

		for iter_41_0, iter_41_1 in ipairs(var_41_2) do
			local var_41_3 = lua_condition.configDict[iter_41_1]
			local var_41_4 = gohelper.clone(arg_41_0._goconditionitemdesc, arg_41_0._goconditionitem, "platnumdesc")
			local var_41_5 = arg_41_0:checkPlatCondition(iter_41_1)

			arg_41_0:_setConditionText(var_41_4, var_41_3.desc, var_41_5)
			arg_41_0:_setStarStatus(var_41_4, var_41_5)
		end
	end
end

function var_0_0.onClose(arg_42_0)
	FightAudioMgr.instance:obscureBgm(false)
end

function var_0_0.onDestroyView(arg_43_0)
	arg_43_0._simagetipbg:UnLoadImage()
	arg_43_0._simagemaskbg:UnLoadImage()
	arg_43_0._simagenumline:UnLoadImage()
end

return var_0_0

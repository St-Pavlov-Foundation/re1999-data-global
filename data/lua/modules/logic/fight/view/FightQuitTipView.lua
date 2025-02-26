module("modules.logic.fight.view.FightQuitTipView", package.seeall)

slot0 = class("FightQuitTipView", BaseView)
slot1 = {
	Tip = 1,
	Confirm = 2
}

function slot0.onInitView(slot0)
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_quitshowview/center/layout/#simage_maskbg")
	slot0._simagetipbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_quittipview/#simage_tipbg")
	slot0._goquitshowview = gohelper.findChild(slot0.viewGO, "#go_quitshowview")
	slot0._goquittipview = gohelper.findChild(slot0.viewGO, "#go_quittipview")
	slot0._gopasstarget = gohelper.findChild(slot0.viewGO, "#go_quitshowview/center/layout/passtarget")
	slot0._goconditionitem = gohelper.findChild(slot0.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem")
	slot0._goconditionitemdesc = gohelper.findChild(slot0.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem/desc")
	slot0._goquitfight = gohelper.findChild(slot0.viewGO, "#go_quittipview/tipcontent/#go_quitfight")
	slot0._goadditiondetail = gohelper.findChild(slot0.viewGO, "#go_quitshowview/#go_additiondetail")
	slot0._btncloserule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quitshowview/#go_additiondetail/#btn_closerule")
	slot0._goruleDescList = gohelper.findChild(slot0.viewGO, "#go_quitshowview/#go_additiondetail/bg/#go_ruleDescList")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "#go_quitshowview/#go_additiondetail/bg/#go_ruleDescList/#go_ruleitem")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quitshowview/center/btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quitshowview/center/btn/#btn_restart")
	slot0._btnfighttechnical = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quitshowview/center/btn/#btn_fighttechnical")
	slot0._btnrouge = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quitshowview/center/btn/#btn_rouge")
	slot0._gocareercontent = gohelper.findChild(slot0.viewGO, "#go_quitshowview/center/layout/careerContent/#go_careercontent")
	slot0._btncontinuegame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quitshowview/center/btn/#btn_continuegame")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quittipview/#btn_sure")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quittipview/#btn_no")
	slot0._simagenumline = gohelper.findChildSingleImage(slot0.viewGO, "#go_quittipview/num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnRestart, slot0)
	slot0._btnfighttechnical:AddClickListener(slot0._btnfighttechnicalOnClick, slot0)
	slot0._btnrouge:AddClickListener(slot0._btnrougeOnClick, slot0)
	slot0._btncontinuegame:AddClickListener(slot0._onBtnContinueGame, slot0)
	slot0._btncloserule:AddClickListener(slot0._onBtnContinueGame, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
	slot0._btncloserule:AddClickListener(slot0._btncloseruleOnClick, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, slot0._btnnoOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, slot0._onKeyExit, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnfighttechnical:RemoveClickListener()
	slot0._btnrouge:RemoveClickListener()
	slot0._btncontinuegame:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
	slot0._btncloserule:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, slot0._btnnoOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, slot0._onKeyExit, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.GuideView then
		slot0:closeThis()
	end
end

function slot0._btnyesOnClick(slot0)
	slot0.status = uv0.Confirm

	slot0:_refreshUI()
	gohelper.setActive(slot0._goquitshowview, false)
	slot0:_setQuitText()
end

function slot0._btnRestart(slot0)
	if FightReplayModel.instance:isReplay() then
		return false
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.EndRound or slot1 == FightEnum.Stage.End then
		ToastController.instance:showToast(-80)

		return
	end

	FightSystem.instance:restartFight()
end

function slot0._setQuitText(slot0)
	if slot0._descTxt then
		return
	end

	slot0._descTxt = gohelper.findChildText(slot0._goquitfight, "desc")

	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId) then
		if slot1.type == DungeonEnum.EpisodeType.WeekWalk or slot1.type == DungeonEnum.EpisodeType.Season then
			slot0._descTxt.text = luaLang("quit_fight_weekwalk")

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Cachot then
			slot0._descTxt.text = luaLang("cachot_quit_fight")

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Rouge then
			slot0._descTxt.text = luaLang("rouge_quit_fight_confirm")

			return
		end
	end

	if slot1 and DungeonConfig.instance:getChapterCO(slot1.chapterId) and slot2.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(slot2.type) > 0 then
		slot0._descTxt.text = lua_language_coder.configDict.quit_fight_equip_1.lang

		return
	end

	if (tonumber(DungeonConfig.instance:getEndBattleCost(slot0._episodeId, false)) or 0) <= 0 then
		slot0._descTxt.text = lua_language_coder.configDict.quit_fight_weekwalk.lang

		return
	end

	slot4 = slot0._episodeId and DungeonModel.instance:getEpisodeInfo(slot0._episodeId)
	slot6 = FightModel.instance:getFightParam() and slot5.multiplication or 1
	slot0._descTxt.text = luaLang("confirm_quit")
end

function slot0._onKeyExit(slot0)
	if slot0._goquitshowview and not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		slot0:_btnsureOnClick()
	end
end

function slot0._btnsureOnClick(slot0)
	slot0:closeThis()

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		FightSystem.instance:dispose()
		FightModel.instance:clearRecordMO()
		FightController.instance:exitFightScene()

		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.EndRound and slot1 ~= FightEnum.Stage.End then
		if not FightModel.instance:getFightParam().isTestFight then
			DungeonFightController.instance:sendEndFightRequest(true)
		else
			FightRpc.instance:sendEndFightRequest(true)
		end
	end
end

function slot0._btnnoOnClick(slot0)
	slot0.status = uv0.Tip

	slot0:_refreshUI()
	gohelper.setActive(slot0._goquitshowview, true)
end

function slot0._onBtnContinueGame(slot0)
	slot0:closeThis()
	FightController.instance:dispatchEvent(FightEvent.OnFightQuitTipViewClose)
end

function slot0._btncloseruleOnClick(slot0)
	gohelper.setActive(slot0._goadditiondetail, false)
end

function slot0._btnfighttechnicalOnClick(slot0)
	FightController.instance:openFightTechniqueView()
end

function slot0._btnrougeOnClick(slot0)
	FightController.instance:openFightTechniqueView()
end

function slot0._editableInitView(slot0)
	slot0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
	slot0._simagemaskbg:LoadImage(ResUrl.getFightIcon("img_zanting_bg.png"))
	slot0._simagenumline:LoadImage(ResUrl.getMessageIcon("bg_num"))

	slot0._episodeId = DungeonModel.instance.curSendEpisodeId
	slot0._chapterId = DungeonModel.instance.curSendChapterId
	slot0._hardMode = DungeonConfig.instance:getChapterCO(slot0._chapterId) and slot1.type == DungeonEnum.ChapterType.Hard
	slot0._weekwalkMode = slot1 and slot1.type == DungeonEnum.ChapterType.WeekWalk
	slot0._rougeMode = slot1 and slot1.type == DungeonEnum.ChapterType.Rouge

	if slot0._hardMode then
		slot0._episodeId = DungeonConfig.instance:getHardEpisode(slot0._episodeId).id
	end

	gohelper.setActive(slot0._goruleitem, false)
	gohelper.setActive(slot0._goadditiondetail, false)

	slot0._ruleItemsImage = slot0:getUserDataTb_()
	slot0._ruleItemsDescImage = slot0:getUserDataTb_()

	for slot5 = 1, 6 do
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot0._gocareercontent, "career" .. slot5), "lssx_" .. slot5)
	end

	gohelper.addUIClickAudio(slot0._btnquitgame.gameObject, AudioEnum.UI.Play_UI_Rolesback)
	gohelper.addUIClickAudio(slot0._btncontinuegame.gameObject, AudioEnum.UI.Play_UI_Tags)
	gohelper.addUIClickAudio(slot0._btnsure.gameObject, AudioEnum.UI.Play_UI_Rolesout)
	gohelper.addUIClickAudio(slot0._btnno.gameObject, AudioEnum.UI.Play_UI_Tags)
	PCInputController.instance:showkeyTips(gohelper.findChild(slot0._btnsure.gameObject, "#go_pcbtn"), nil, , "Return")
	PCInputController.instance:showkeyTips(gohelper.findChild(slot0._btnno.gameObject, "#go_pcbtn"), nil, , "Esc")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0:episodeNeedHideRestart() then
		gohelper.setActive(slot0._btnrestart.gameObject, false)
	else
		gohelper.setActive(slot0._btnrestart.gameObject, not FightReplayModel.instance:isReplay())
	end

	slot0.status = uv0.Tip

	slot0:_loadCondition()
	slot0:_refreshUI()
	gohelper.setActive(slot0._btnfighttechnical.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightTechnique) and not slot0._rougeMode)
	gohelper.setActive(slot0._btnrouge.gameObject, slot1 and slot0._rougeMode)
	NavigateMgr.instance:addEscape(ViewName.FightQuitTipView, slot0._onBtnContinueGame, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_fight_keeporquit)
	FightAudioMgr.instance:obscureBgm(true)
end

function slot0.episodeNeedHideRestart(slot0)
	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId) and slot0:checkNeedHideRestartEpisodeType(slot1.type) then
		return true
	end

	if slot1 then
		if slot2 and not _G["FightRestartAbandonType" .. (FightRestartSequence.RestartType2Type[DungeonConfig.instance:getChapterCO(slot1.chapterId).type] or slot2.type)] then
			return true
		end
	end

	return false
end

function slot0.checkNeedHideRestartEpisodeType(slot0, slot1)
	if not slot0._hideRestartEpisodeTypes then
		slot0._hideRestartEpisodeTypes = {
			[DungeonEnum.EpisodeType.Dog] = true,
			[DungeonEnum.EpisodeType.Act1_6DungeonBoss] = true
		}
	end

	return slot0._hideRestartEpisodeTypes[slot1]
end

function slot0._refreshUI(slot0)
	slot1 = slot0.status == uv0.Tip

	gohelper.setActive(slot0._goquitshowview, slot1)
	gohelper.setActive(slot0._goquittipview, not slot1)
end

function slot0._loadCondition(slot0)
	slot1 = DungeonModel.instance:getEpisodeInfo(slot0._episodeId)

	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId) then
		if slot2.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
			gohelper.setActive(slot0._gopasstarget, false)

			return
		elseif SeasonFightHandler.loadSeasonCondition(slot2.type, slot0._gopasstarget, slot0._goconditionitemdesc, slot0._goconditionitem) then
			return
		end
	end

	slot3 = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())

	if BossRushController.instance:isInBossRushInfiniteFight() then
		slot3 = luaLang("v1a4_bossrushleveldetail_txt_target")
	end

	slot0:_setConditionText(slot0._goconditionitemdesc, slot3, false)
	slot0:_setStarStatus(slot0._goconditionitemdesc, false)

	if not slot1 or not slot2 then
		return
	end

	if DungeonModel.instance.curSendChapterId and DungeonConfig.instance:getChapterCO(slot4) and slot5.type == DungeonEnum.ChapterType.Simple then
		return
	end

	if not LuaUtil.isEmptyStr(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot0._episodeId, FightModel.instance:getBattleId())) then
		slot6 = gohelper.clone(slot0._goconditionitemdesc, slot0._goconditionitem, "platnumdesc")
		slot7 = slot0:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(slot0._episodeId, 1, FightModel.instance:getBattleId()))
		slot8 = ""

		if not FightModel.instance.needFightReconnect then
			if lua_condition.configDict[tonumber(DungeonConfig.instance:getEpisodeAdvancedCondition(slot0._episodeId, FightModel.instance:getBattleId()))] and tonumber(slot10.type) and slot11 == 7 then
				slot8 = string.format(" (%d/%s)", slot0:_getPlatinumProgress7(), slot10.attr)
			elseif slot11 and slot11 == 8 then
				slot8 = string.format(" (%d/%s)", slot0:_getPlatinumProgress8(), slot10.attr)
			elseif slot11 and slot11 == 9 then
				slot8 = string.format(" (%d%%/%s%%)", slot0:_getPlatinumProgress9(), tostring(tonumber(slot10.attr) / 10))
			end
		end

		slot0:_setConditionText(slot6, slot5 .. slot8, slot7)
		slot0:_setStarStatus(slot6, slot7)
	end

	if not LuaUtil.isEmptyStr(DungeonConfig.instance:getEpisodeAdvancedCondition2Text(slot0._episodeId, FightModel.instance:getBattleId())) then
		slot7 = gohelper.clone(slot0._goconditionitemdesc, slot0._goconditionitem, "platnumdesc2")
		slot8 = slot0:checkPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2(slot0._episodeId, 2, FightModel.instance:getBattleId()))

		slot0:_setConditionText(slot7, slot6, slot8)
		slot0:_setStarStatus(slot7, slot8)
	end
end

function slot0._getPlatinumProgress7(slot0)
	slot1 = FightModel.instance:getHistoryRoundMOList() and tabletool.copy(slot1) or {}

	if FightModel.instance:getCurRoundMO() and not tabletool.indexOf(slot1, slot2) then
		table.insert(slot1, FightModel.instance:getCurRoundMO())
	end

	slot3 = 0

	for slot7, slot8 in ipairs(slot1) do
		for slot13, slot14 in ipairs(slot8.fightStepMOs) do
			if slot14.hasPlay and slot14.actType == FightEnum.ActType.SKILL and FightDataHelper.entityMgr:getById(slot14.fromId) and slot15.side == FightEnum.EntitySide.MySide and slot15:isUniqueSkill(slot14.actId) then
				slot9 = 0 + 1
			end
		end

		slot3 = math.max(slot3, slot9)
	end

	return slot3
end

slot2 = {
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.BEATBACK] = true,
	[FightEnum.EffectType.DAMAGEEXTRA] = true
}

function slot0._getPlatinumProgress8(slot0)
	slot1 = FightModel.instance:getHistoryRoundMOList() and tabletool.copy(slot1) or {}

	if FightModel.instance:getCurRoundMO() and not tabletool.indexOf(slot1, slot2) then
		table.insert(slot1, FightModel.instance:getCurRoundMO())
	end

	slot3 = 0

	for slot7, slot8 in ipairs(slot1) do
		for slot12, slot13 in ipairs(slot8.fightStepMOs) do
			slot14 = FightDataHelper.entityMgr:getById(slot13.fromId)

			if slot13.hasPlay and slot14 and slot14.side == FightEnum.EntitySide.MySide then
				for slot19, slot20 in ipairs(slot13.actEffectMOs) do
					if FightDataHelper.entityMgr:getById(slot20.targetId) and slot21.side == FightEnum.EntitySide.EnemySide then
						if uv0[slot20.effectType] then
							slot15 = 0 + slot20.effectNum
						elseif slot20.effectType == FightEnum.EffectType.SHIELDDEL then
							slot15 = slot15 + slot20.effectNum
						elseif slot20.effectType == FightEnum.EffectType.SHIELD and slot20.entityMO then
							slot15 = slot15 + slot20.entityMO.shieldValue - slot20.effectNum
						end
					end
				end

				slot3 = math.max(slot3, slot15)
			end
		end
	end

	return slot3
end

function slot0._getPlatinumProgress9(slot0)
	slot2 = #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide)

	for slot7, slot8 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		slot3 = 0 + slot8.currentHp / slot8.attrMO.hp
	end

	return math.floor(slot3 / (#slot1 + slot2) * 100)
end

function slot0._setConditionText(slot0, slot1, slot2, slot3)
	if slot3 then
		(slot1:GetComponent(gohelper.Type_Text) or slot1:GetComponent(gohelper.Type_TextMesh)).text = gohelper.getRichColorText(slot2, "#E6E2DF")
	else
		slot4.text = gohelper.getRichColorText(slot2, "#A7A6A6")
	end
end

function slot0._setStarStatus(slot0, slot1, slot2)
	slot3 = gohelper.findChildImage(slot1, "star")
	slot4 = slot0._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"
	slot5 = "#87898C"

	if slot2 then
		slot5 = slot0._hardMode and "#FF4343" or "#F77040"
	end

	UISpriteSetMgr.instance:setCommonSprite(slot3, slot4)
	SLFramework.UGUI.GuiHelper.SetColor(slot3, slot5)
end

function slot0.checkPlatCondition(slot0, slot1)
	if not lua_condition.configDict[tonumber(slot1)] then
		return true
	end

	slot4 = FightModel.instance:getCurRoundId()

	if tonumber(slot2.type) == 1 then
		return #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide) < tonumber(slot2.attr)
	elseif tonumber(slot2.type) == 2 then
		return slot4 <= tonumber(slot2.attr)
	elseif tonumber(slot2.type) == 3 then
		return slot3 == 0 and slot4 <= tonumber(slot2.attr)
	elseif tonumber(slot2.type) == 4 then
		return false
	elseif tonumber(slot2.type) == 5 then
		return false
	elseif tonumber(slot2.type) == 6 then
		return false
	elseif tonumber(slot2.type) == 7 then
		return tonumber(slot2.attr) <= slot0:_getPlatinumProgress7()
	elseif tonumber(slot2.type) == 8 then
		return tonumber(slot2.attr) <= slot0:_getPlatinumProgress8()
	elseif tonumber(slot2.type) == 9 then
		return slot0:_getPlatinumProgress9() >= tonumber(slot2.attr) / 10
	else
		return true
	end
end

function slot0._addEmptyRuleItem(slot0)
	slot1 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, "none")

	gohelper.setActive(slot1, true)
	gohelper.setActive(gohelper.findChildImage(slot1, "#image_tagicon").gameObject, false)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot1, ""), "none")
end

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	gohelper.setActive(slot3, true)

	slot4 = gohelper.findChildImage(slot3, "#image_tagicon")

	gohelper.setActive(slot4.gameObject, true)
	UISpriteSetMgr.instance:setCommonSprite(slot4, "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot3, ""), slot1.icon)
end

function slot0._addRuleItemDesc(slot0, slot1, slot2, slot3)
	slot5 = gohelper.clone(slot0._goruleitem, slot0._goruleDescList, slot1.id)

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot5, "icon"), slot1.icon)
	gohelper.setActive(gohelper.findChild(slot5, "#go_line"), slot3)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot5, "tag"), "wz_" .. slot2)

	gohelper.findChildText(slot5, "desc").text = SkillConfig.instance:fmtTagDescColor(luaLang("dungeon_add_rule_target_" .. slot2), string.gsub(slot1.desc, "%【(.-)%】", "<color=#6680bd>【%1】</color>"), ({
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	})[slot2])

	gohelper.setActive(slot5, true)
end

function slot0._showRuleDesc(slot0)
	if DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightParam().episodeId) and not string.nilorempty(slot2.battleDesc) then
		gohelper.setActive(slot0._goadditiontip, true)
		gohelper.setActive(slot0._goaddition, true)
		gohelper.setActive(slot0._goruledesc, true)
		gohelper.setActive(slot0._gorulelist, false)
		gohelper.setActive(slot0._ruleclick.gameObject, false)

		slot0._txtruledesc1.text = slot2.battleDesc
	else
		gohelper.setActive(slot0._goaddition, false)
	end
end

function slot0._ruleListClickFunc(slot0)
	gohelper.setActive(slot0._goadditiondetail, true)
end

function slot0.onClose(slot0)
	FightAudioMgr.instance:obscureBgm(false)
end

function slot0.onDestroyView(slot0)
	slot0._simagetipbg:UnLoadImage()
	slot0._simagemaskbg:UnLoadImage()
	slot0._simagenumline:UnLoadImage()
end

return slot0

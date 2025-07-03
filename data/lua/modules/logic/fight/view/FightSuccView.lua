module("modules.logic.fight.view.FightSuccView", package.seeall)

local var_0_0 = class("FightSuccView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0._btnData = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnData")
	arg_1_0._simagecharacterbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_characterbg")
	arg_1_0._simagemaskImage = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskImage")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "spineContainer/spine")
	arg_1_0._uiSpine = GuiModelAgent.Create(arg_1_0._gospine, true)
	arg_1_0._txtFbNameEn = gohelper.findChildText(arg_1_0.viewGO, "txtFbNameen")

	arg_1_0._uiSpine:useRT()

	arg_1_0._txtFbName = gohelper.findChildText(arg_1_0.viewGO, "txtFbName")
	arg_1_0._txtChapterIndex = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#go_normaltag/section")
	arg_1_0._txtEpisodeIndex = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#go_normaltag/unit")
	arg_1_0._gonormaltag = gohelper.findChild(arg_1_0.viewGO, "txtFbName/#go_normaltag")
	arg_1_0._goroletag = gohelper.findChild(arg_1_0.viewGO, "txtFbName/#go_roletag")
	arg_1_0._txtLv = gohelper.findChildText(arg_1_0.viewGO, "goalcontent/txtLv")
	arg_1_0._txtExp = gohelper.findChildText(arg_1_0.viewGO, "goalcontent/txtLv/txtExp")
	arg_1_0._txtAddExp = gohelper.findChildText(arg_1_0.viewGO, "goalcontent/txtLv/progress/txtAddExp")
	arg_1_0._sliderExp = gohelper.findChildSlider(arg_1_0.viewGO, "goalcontent/txtLv/progress")
	arg_1_0._txtSayCn = gohelper.findChildText(arg_1_0.viewGO, "txtSayCn")
	arg_1_0._txtSayEn = gohelper.findChildText(arg_1_0.viewGO, "SayEn/txtSayEn")
	arg_1_0._favorIcon = gohelper.findChild(arg_1_0.viewGO, "scroll/viewport/content/favor")
	arg_1_0._goCondition = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/fightgoal")
	arg_1_0._goPlatCondition = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/platinum")
	arg_1_0._goPlatCondition2 = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/platinum2")
	arg_1_0._goPlatConditionMaterial = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/platinumMaterial")
	arg_1_0._goalcontent = gohelper.findChild(arg_1_0.viewGO, "goalcontent")
	arg_1_0._goweekwalkgoalcontent = gohelper.findChild(arg_1_0.viewGO, "weekwalkgoalcontent")
	arg_1_0._goweekwalkcontentitem = gohelper.findChild(arg_1_0.viewGO, "weekwalkgoalcontent/goallist/goalitem")
	arg_1_0._bonusItemContainer = gohelper.findChild(arg_1_0.viewGO, "scroll/viewport/content")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "scroll")
	arg_1_0._bonusItemGo = gohelper.findChild(arg_1_0.viewGO, "scroll/item")
	arg_1_0._godemand = gohelper.findChild(arg_1_0.viewGO, "#go_demand")
	arg_1_0._txtdemand = gohelper.findChildText(arg_1_0.viewGO, "#go_demand/#txt_demand")
	arg_1_0._btnbacktosource = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_demand/#btn_backToSource")
	arg_1_0._gocoverrecordpart = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part")
	arg_1_0._btncoverrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cover_record_part/#btn_cover_record")
	arg_1_0._txtcurroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	arg_1_0._txtmaxroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	arg_1_0._goCoverLessThan = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	arg_1_0._goCoverMuchThan = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	arg_1_0._goCoverEqual = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	arg_1_0._godetails = gohelper.findChild(arg_1_0.viewGO, "#go_details")
	arg_1_0._gogoallist = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist")
	arg_1_0._goseason = gohelper.findChild(arg_1_0.viewGO, "#go_season")
	arg_1_0._txtseasongrade = gohelper.findChildText(arg_1_0.viewGO, "#go_season/grade/#txt_grade")
	arg_1_0._txtseasonlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_season/level/#txt_level")
	arg_1_0._imagegradeicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_season/level/#image_gradeicon")
	arg_1_0._txtgrademark = gohelper.findChildText(arg_1_0.viewGO, "#go_season/grade/grade")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnData:AddClickListener(arg_2_0._onClickData, arg_2_0)
	arg_2_0._btnbacktosource:AddClickListener(arg_2_0._onClickBackToSource, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btncoverrecord, arg_2_0._onBtnCoverRecordClick, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, arg_2_0._onCoverDungeonRecordReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnData:RemoveClickListener()
	arg_3_0._btnbacktosource:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0)

	arg_4_0._canClick = false
	arg_4_0._animation = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animation))

	arg_4_0._animation:Play("fightsucc_in", UnityEngine.PlayMode.StopAll)
	arg_4_0._animation:PlayQueued("fightsucc_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)

	arg_4_0._animEventWrap = arg_4_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	FightController.instance:checkFightQuitTipViewClose()
	gohelper.setActive(arg_4_0._bonusItemGo, false)

	arg_4_0._curEpisodeId = DungeonModel.instance.curSendEpisodeId
	arg_4_0._curChapterId = DungeonModel.instance.curSendChapterId

	local var_4_0 = FightResultModel.instance
	local var_4_1 = lua_episode.configDict[arg_4_0._curEpisodeId]
	local var_4_2 = DungeonConfig.instance:getChapterCO(arg_4_0._curChapterId)
	local var_4_3 = var_4_2 and var_4_2.type or DungeonEnum.ChapterType.Normal

	arg_4_0._normalMode = var_4_3 == DungeonEnum.ChapterType.Normal
	arg_4_0._hardMode = var_4_3 == DungeonEnum.ChapterType.Hard
	arg_4_0._simpleMode = var_4_3 == DungeonEnum.ChapterType.Simple

	if not var_4_1 or not var_4_1.type then
		local var_4_4 = DungeonEnum.EpisodeType.Normal
	end

	arg_4_0._curEpisodeId = FightResultModel.instance.episodeId
	arg_4_0.hadHighRareProp = false

	arg_4_0:_loadBonusItems()
	arg_4_0:_hideGoDemand()

	local var_4_5 = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())
	local var_4_6 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_4_0._curEpisodeId, FightModel.instance:getBattleId())
	local var_4_7 = arg_4_0._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

	if string.nilorempty(var_4_5) then
		gohelper.setActive(arg_4_0._goCondition, false)
	else
		gohelper.findChildText(arg_4_0._goCondition, "condition").text = var_4_5

		local var_4_8 = gohelper.findChildImage(arg_4_0._goCondition, "star")

		UISpriteSetMgr.instance:setCommonSprite(var_4_8, var_4_7, true)
		SLFramework.UGUI.GuiHelper.SetColor(var_4_8, arg_4_0._hardMode and "#FF4343" or "#F77040")
	end

	if var_4_2 and var_4_2.type == DungeonEnum.ChapterType.Simple then
		gohelper.setActive(arg_4_0._goPlatCondition, false)
	else
		arg_4_0:_showPlatCondition(var_4_6, arg_4_0._goPlatCondition, var_4_7, DungeonEnum.StarType.Advanced)
	end

	arg_4_0:_showPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2Text(arg_4_0._curEpisodeId, FightModel.instance:getBattleId()), arg_4_0._goPlatCondition2, var_4_7, DungeonEnum.StarType.Ultra)

	arg_4_0._randomEntityMO = arg_4_0:_getRandomEntityMO()

	arg_4_0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	arg_4_0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	local var_4_9 = lua_chapter.configDict[var_4_0:getChapterId()]
	local var_4_10 = lua_episode.configDict[var_4_0:getEpisodeId()]
	local var_4_11 = var_4_9 ~= nil and var_4_10 ~= nil

	gohelper.setActive(arg_4_0._txtFbName.gameObject, var_4_11)

	local var_4_12 = GameConfig:GetCurLangType() == LangSettings.zh

	gohelper.setActive(arg_4_0._txtFbNameEn.gameObject, var_4_11 and var_4_12)

	if var_4_11 then
		arg_4_0:_setFbName(var_4_10)
	end

	local var_4_13 = PlayerModel.instance:getExpNowAndMax()

	arg_4_0._txtLv.text = "<size=36>Lv </size>" .. PlayerModel.instance:getPlayerLevel()

	arg_4_0._sliderExp:SetValue(var_4_13[1] / var_4_13[2])

	arg_4_0._txtExp.text = var_4_13[1] .. "/" .. var_4_13[2]

	local var_4_14 = var_4_0:getPlayerExp()

	if var_4_14 and var_4_14 > 0 then
		gohelper.setActive(arg_4_0._txtAddExp.gameObject, true)

		arg_4_0._txtAddExp.text = "EXP+" .. var_4_14
	else
		gohelper.setActive(arg_4_0._txtAddExp.gameObject, false)
	end

	arg_4_0:_setSpineVoice()
	NavigateMgr.instance:addEscape(ViewName.FightSuccView, arg_4_0._onClickClose, arg_4_0)

	arg_4_0._canPlayVoice = false

	TaskDispatcher.runDelay(arg_4_0._setCanPlayVoice, arg_4_0, 0.9)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	arg_4_0:_checkNewRecord()
	arg_4_0:_detectCoverRecord()
	arg_4_0:_checkTypeDetails()
	arg_4_0:showUnLockCurrentEpisodeNewMode()
	arg_4_0:_show1_2DailyEpisodeEndNotice()
	arg_4_0:_show1_6EpisodeMaterial()
	arg_4_0:_showWeekWalk_2Condition()
	arg_4_0:_playVictoryAudio_2_7()
end

function var_0_0._showPlatCondition(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if string.nilorempty(arg_5_1) then
		gohelper.setActive(arg_5_2, false)
	else
		gohelper.setActive(arg_5_2, true)

		local var_5_0 = tonumber(FightResultModel.instance.star) or 0

		if var_5_0 < arg_5_4 then
			gohelper.findChildText(arg_5_2, "condition").text = gohelper.getRichColorText(arg_5_1, "#6C6C6B")
		else
			gohelper.findChildText(arg_5_2, "condition").text = gohelper.getRichColorText(arg_5_1, "#C4C0BD")
		end

		local var_5_1 = gohelper.findChildImage(arg_5_2, "star")
		local var_5_2 = "#87898C"

		if arg_5_4 <= var_5_0 then
			var_5_2 = arg_5_0._hardMode and "#FF4343" or "#F77040"
		end

		UISpriteSetMgr.instance:setCommonSprite(var_5_1, arg_5_3, true)
		SLFramework.UGUI.GuiHelper.SetColor(var_5_1, var_5_2)
	end
end

function var_0_0.onClose(arg_6_0)
	arg_6_0._canPlayVoice = false

	TaskDispatcher.cancelTask(arg_6_0._setCanPlayVoice, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayPlayVoice, arg_6_0)
	gohelper.setActive(arg_6_0._gospine, false)

	if FightResultModel.instance.canUpdateDungeonRecord and not arg_6_0._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	if arg_6_0._popupFlow then
		arg_6_0._popupFlow:destroy()

		arg_6_0._popupFlow = nil
	end
end

function var_0_0._checkTypeDetails(arg_7_0)
	local var_7_0 = lua_episode.configDict[arg_7_0._curEpisodeId]

	if not (var_7_0 and var_7_0.type == DungeonEnum.EpisodeType.Season) then
		return
	end

	gohelper.setActive(arg_7_0._goseason, true)
	gohelper.setActive(arg_7_0._txtLv.gameObject, false)
	gohelper.setActive(arg_7_0._goscroll, false)
	gohelper.setActive(arg_7_0._gogoallist, false)

	local var_7_1 = Activity104Model.instance:getNewUnlockInfo()

	gohelper.setActive(arg_7_0._txtseasonlevel.gameObject, false)
	UISpriteSetMgr.instance:setSeasonSprite(arg_7_0._imagegradeicon, "sjwf_nandudengji_" .. tostring(Activity104Model.instance:getEpisodeLv(var_7_1.score)))

	arg_7_0._txtseasongrade.text = var_7_1.score
end

function var_0_0._detectCoverRecord(arg_8_0)
	gohelper.setActive(arg_8_0._gocoverrecordpart, FightResultModel.instance.canUpdateDungeonRecord or false)

	if FightResultModel.instance.canUpdateDungeonRecord then
		arg_8_0._txtcurroundcount.text = FightResultModel.instance.newRecordRound or ""
		arg_8_0._txtmaxroundcount.text = FightResultModel.instance.oldRecordRound or ""

		gohelper.setActive(arg_8_0._goCoverLessThan, FightResultModel.instance.newRecordRound < FightResultModel.instance.oldRecordRound)
		gohelper.setActive(arg_8_0._goCoverMuchThan, FightResultModel.instance.newRecordRound > FightResultModel.instance.oldRecordRound)
		gohelper.setActive(arg_8_0._goCoverEqual, FightResultModel.instance.newRecordRound == FightResultModel.instance.oldRecordRound)

		if FightResultModel.instance.newRecordRound >= FightResultModel.instance.oldRecordRound then
			arg_8_0._txtcurroundcount.color = GameUtil.parseColor("#272525")
		else
			arg_8_0._txtcurroundcount.color = GameUtil.parseColor("#AC5320")
		end
	end
end

function var_0_0._onBtnCoverRecordClick(arg_9_0)
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function var_0_0._onCoverDungeonRecordReply(arg_10_0, arg_10_1)
	arg_10_0._hasSendCoverRecord = true

	gohelper.setActive(arg_10_0._gocoverrecordpart, false)

	if arg_10_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function var_0_0._getRandomEntityMO(arg_11_0)
	local var_11_0 = FightDataHelper.entityMgr:getMyNormalList()
	local var_11_1 = FightDataHelper.entityMgr:getMySubList()
	local var_11_2 = FightDataHelper.entityMgr:getMyDeadList()
	local var_11_3 = {}

	tabletool.addValues(var_11_3, var_11_0)
	tabletool.addValues(var_11_3, var_11_1)
	tabletool.addValues(var_11_3, var_11_2)

	for iter_11_0 = #var_11_3, 1, -1 do
		local var_11_4 = var_11_3[iter_11_0]

		if not arg_11_0:_getSkin(var_11_4) then
			table.remove(var_11_3, iter_11_0)
		end
	end

	local var_11_5 = {}

	tabletool.addValues(var_11_5, var_11_3)

	for iter_11_1 = #var_11_5, 1, -1 do
		local var_11_6 = var_11_3[iter_11_1]
		local var_11_7 = FightAudioMgr.instance:_getHeroVoiceCOs(var_11_6.modelId, CharacterEnum.VoiceType.FightResult)

		if var_11_7 and #var_11_7 > 0 then
			if var_11_6:isMonster() then
				table.remove(var_11_5, iter_11_1)
			end
		else
			table.remove(var_11_5, iter_11_1)
		end
	end

	if #var_11_5 > 0 then
		return var_11_5[math.random(#var_11_5)]
	elseif #var_11_3 > 0 then
		return var_11_3[math.random(#var_11_3)]
	else
		logError("没有角色")
	end
end

function var_0_0._checkNewRecord(arg_12_0)
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	elseif OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local var_12_0 = DungeonConfig.instance:getEpisodeCO(arg_12_0._curEpisodeId)
		local var_12_1 = FightModel.instance:getFightParam()
		local var_12_2 = var_12_1 and var_12_1.battleId

		if var_12_0 and var_12_2 and var_12_0.firstBattleId == var_12_2 and not HeroGroupBalanceHelper.getIsBalanceMode() then
			GameFacade.showToast(ToastEnum.CantRecordReplay)
		end
	end
end

function var_0_0._setCanPlayVoice(arg_13_0)
	arg_13_0._canPlayVoice = true

	arg_13_0:_playSpineVoice()
end

function var_0_0._setFbName(arg_14_0, arg_14_1)
	local var_14_0 = DungeonConfig.instance:getNormalEpisodeId(arg_14_1.id)
	local var_14_1 = DungeonConfig.instance:getEpisodeCO(var_14_0)
	local var_14_2 = DungeonConfig.instance:getChapterCO(var_14_1.chapterId)
	local var_14_3, var_14_4 = DungeonConfig.instance:getChapterIndex(var_14_2.type, var_14_1.chapterId)
	local var_14_5, var_14_6 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_14_1.chapterId, var_14_0)

	if arg_14_1.type == DungeonEnum.EpisodeType.Sp then
		local var_14_7 = math.floor(arg_14_1.id % 10000 / 100)

		var_14_5 = arg_14_1.id % 100

		if TeachNoteModel.instance:isTeachNoteEpisode(arg_14_1.id) then
			arg_14_0._txtChapterIndex.text = var_14_2.chapterIndex .. tostring(var_14_7)
		elseif var_14_2.id == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
			arg_14_0._txtChapterIndex.text = var_14_2.chapterIndex
		else
			arg_14_0._txtChapterIndex.text = "SP" .. tostring(var_14_7)
		end
	else
		arg_14_0._txtChapterIndex.text = var_14_2.chapterIndex
	end

	arg_14_0:_setEpisodeName(arg_14_1, var_14_5, var_14_1)
	arg_14_0:_setTag(arg_14_1)
end

function var_0_0._setTag(arg_15_0, arg_15_1)
	local var_15_0 = lua_const.configDict[ConstEnum.DungeonSuccessType].value
	local var_15_1 = string.splitToNumber(var_15_0, "#")
	local var_15_2 = tabletool.indexOf(var_15_1, arg_15_1.type)

	if arg_15_1.chapterId == DungeonEnum.ChapterId.RoleDuDuGu then
		var_15_2 = false
	end

	gohelper.setActive(arg_15_0._gonormaltag, var_15_2)
	gohelper.setActive(arg_15_0._goroletag, not var_15_2)
end

function var_0_0._setEpisodeName(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_1.type == DungeonEnum.EpisodeType.WeekWalk then
		local var_16_0 = FightModel.instance:getFightParam().battleId
		local var_16_1, var_16_2 = WeekWalkModel.instance:getInfo():getNameIndexByBattleId(var_16_0)

		if var_16_2 then
			arg_16_0._txtFbName.text = var_16_1
			arg_16_0._txtEpisodeIndex.text = var_16_2

			return
		end
	elseif arg_16_1.type == DungeonEnum.EpisodeType.WeekWalk_2 then
		local var_16_3 = WeekWalk_2Model.instance:getCurMapInfo()

		if var_16_3 then
			arg_16_0._txtFbName.text = var_16_3.sceneConfig.battleName
			arg_16_0._txtFbNameEn.text = var_16_3.sceneConfig.name_en

			return
		end
	elseif arg_16_1.type == DungeonEnum.EpisodeType.Season then
		local var_16_4 = FightModel.instance:getFightParam()
		local var_16_5, var_16_6, var_16_7 = Activity104Model.instance:getSeasonEpisodeDifficultByBattleId(var_16_4.battleId)
		local var_16_8 = SeasonConfig.instance:getSeasonEpisodeConfig(var_16_5, var_16_6)

		arg_16_0._txtgrademark.text = var_16_6 == 1 and luaLang("season_permanent_level_score") or luaLang("season_limit_level_score")
		arg_16_0._txtFbName.text = var_16_8.name
		arg_16_0._txtEpisodeIndex.text = var_16_6

		return
	elseif arg_16_1.type == DungeonEnum.EpisodeType.Dog then
		local var_16_9, var_16_10 = Activity109ChessController.instance:getFightSourceEpisode()

		if var_16_9 and var_16_10 then
			local var_16_11 = Activity109Config.instance:getEpisodeCo(var_16_9, var_16_10)

			if var_16_11 then
				arg_16_0._txtFbName.text = arg_16_1.name
				arg_16_0._txtEpisodeIndex.text = var_16_11.id

				return
			end
		end
	end

	local var_16_12 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_16_1)

	if var_16_12 and #var_16_12 > 1 then
		arg_16_2 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(var_16_12[1].id)
	end

	local var_16_13 = DungeonConfig.instance:getChapterCO(arg_16_1.chapterId)

	if var_16_13 then
		if var_16_13.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or var_16_13.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or var_16_13.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or var_16_13.type == DungeonEnum.ChapterType.Activity1_2DungeonHard then
			arg_16_2 = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		end

		if var_16_13.actId == VersionActivity1_3Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity1_3DungeonController.instance:getEpisodeIndex(arg_16_1.id)
		end

		if var_16_13.actId == VersionActivity1_5Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity1_5DungeonController.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_13.actId == VersionActivity1_6Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity1_6DungeonController.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_13.actId == VersionActivity1_8Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity1_8DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_13.actId == VersionActivity2_0Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_0DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_13.actId == VersionActivity2_1Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_1DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_13.actId == VersionActivity2_3Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_3DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_13.actId == VersionActivity2_4Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_4DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_13.actId == VersionActivity2_5Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_5DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_13.actId == VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon then
			arg_16_2 = VersionActivityFixedDungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		end
	end

	if arg_16_1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard then
		arg_16_2 = DungeonConfig.instance:getEpisodeLevelIndex(arg_16_1)
	end

	arg_16_0._txtFbName.text = arg_16_3.name
	arg_16_0._txtFbNameEn.text = arg_16_3.name_En
	arg_16_0._txtEpisodeIndex.text = arg_16_2
end

function var_0_0._getSkin(arg_17_0, arg_17_1)
	local var_17_0 = FightConfig.instance:getSkinCO(arg_17_1.skin)
	local var_17_1 = var_17_0 and not string.nilorempty(var_17_0.verticalDrawing)
	local var_17_2 = var_17_0 and not string.nilorempty(var_17_0.live2d)

	if var_17_1 or var_17_2 then
		return var_17_0
	end
end

function var_0_0._setSpineVoice(arg_18_0)
	if not arg_18_0._randomEntityMO then
		return
	end

	local var_18_0 = arg_18_0:_getSkin(arg_18_0._randomEntityMO)

	if var_18_0 then
		arg_18_0._spineLoaded = false

		arg_18_0._uiSpine:setImgPos(0)
		arg_18_0._uiSpine:setResPath(var_18_0, function()
			arg_18_0._spineLoaded = true

			arg_18_0._uiSpine:setUIMask(true)
			arg_18_0:_playSpineVoice()
			arg_18_0._uiSpine:setAllLayer(UnityLayer.UI)
		end, arg_18_0)

		local var_18_1, var_18_2 = SkinConfig.instance:getSkinOffset(var_18_0.fightSuccViewOffset)

		if var_18_2 then
			var_18_1, _ = SkinConfig.instance:getSkinOffset(var_18_0.characterViewOffset)
			var_18_1 = SkinConfig.instance:getAfterRelativeOffset(504, var_18_1)
		end

		local var_18_3 = tonumber(var_18_1[3])
		local var_18_4 = tonumber(var_18_1[1])
		local var_18_5 = tonumber(var_18_1[2])

		recthelper.setAnchor(arg_18_0._gospine.transform, var_18_4, var_18_5)
		transformhelper.setLocalScale(arg_18_0._gospine.transform, var_18_3, var_18_3, var_18_3)
	else
		gohelper.setActive(arg_18_0._gospine, false)
	end
end

function var_0_0._playSpineVoice(arg_20_0)
	if not arg_20_0._canPlayVoice then
		return
	end

	if not arg_20_0._spineLoaded then
		return
	end

	if arg_20_0._uiSpine:isLive2D() then
		arg_20_0._uiSpine:setLive2dCameraLoadFinishCallback(arg_20_0.onLive2dCameraLoadedCallback, arg_20_0)

		return
	end

	arg_20_0:_playVoice()
end

function var_0_0.onLive2dCameraLoadedCallback(arg_21_0)
	arg_21_0._uiSpine:setLive2dCameraLoadFinishCallback()

	arg_21_0._repeatNum = CharacterVoiceEnum.DelayFrame + 1
	arg_21_0._repeatCount = 0

	TaskDispatcher.cancelTask(arg_21_0._delayPlayVoice, arg_21_0)
	TaskDispatcher.runRepeat(arg_21_0._delayPlayVoice, arg_21_0, 0, arg_21_0._repeatNum)
end

function var_0_0._delayPlayVoice(arg_22_0)
	arg_22_0._repeatCount = arg_22_0._repeatCount + 1

	if arg_22_0._repeatCount < arg_22_0._repeatNum then
		return
	end

	arg_22_0:_playVoice()
end

function var_0_0._playVoice(arg_23_0)
	local var_23_0 = HeroModel.instance:getVoiceConfig(arg_23_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, nil, arg_23_0._randomEntityMO.skin) or FightAudioMgr.instance:_getHeroVoiceCOs(arg_23_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, arg_23_0._randomEntityMO.skin)

	if var_23_0 and #var_23_0 > 0 then
		local var_23_1 = var_23_0[1]

		arg_23_0._uiSpine:playVoice(var_23_1, nil, arg_23_0._txtSayCn, arg_23_0._txtSayEn)
	end
end

function var_0_0._getSayContent(arg_24_0, arg_24_1)
	local var_24_0 = GameUtil.splitString2(arg_24_1, false, "|", "#")
	local var_24_1 = ""

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		var_24_1 = var_24_1 .. iter_24_1[1]
	end

	return var_24_1
end

function var_0_0.onCloseFinish(arg_25_0)
	arg_25_0._simagecharacterbg:UnLoadImage()
	arg_25_0._simagemaskImage:UnLoadImage()
	FightStatModel.instance:clear()
	arg_25_0._animEventWrap:RemoveAllEventListener()

	if arg_25_0._farmTweenId then
		ZProj.TweenHelper.KillById(arg_25_0._farmTweenId)
	end
end

function var_0_0._getHeroIconPath(arg_26_0)
	if arg_26_0._randomEntityMO then
		local var_26_0 = FightConfig.instance:getSkinCO(arg_26_0._randomEntityMO.skin)

		if var_26_0 then
			return ResUrl.getHeadIconLarge(var_26_0.largeIcon)
		end
	end
end

function var_0_0._onClickClose(arg_27_0)
	if not arg_27_0._canClick then
		return
	end

	if arg_27_0._uiSpine then
		arg_27_0._uiSpine:stopVoice()
	end

	arg_27_0:closeThis()

	local var_27_0 = FightModel.instance:getAfterStory()
	local var_27_1 = DungeonConfig.instance:getChapterCO(arg_27_0._curChapterId)
	local var_27_2 = var_27_1.type == DungeonEnum.ChapterType.RoleStory or var_27_1.id == DungeonEnum.ChapterId.RoleDuDuGu

	if var_27_0 > 0 and (var_27_2 or not StoryModel.instance:isStoryFinished(var_27_0)) then
		var_0_0._storyId = var_27_0
		var_0_0._clientFinish = false
		var_0_0._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, var_0_0._finishStoryFromServer)

		local var_27_3 = {}

		var_27_3.mark = true
		var_27_3.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_27_0, var_27_3, function()
			TaskDispatcher.runDelay(var_0_0.onStoryEnd, nil, 3)

			var_0_0._clientFinish = true

			var_0_0.checkStoryEnd()
		end)

		return
	end

	var_0_0.onStoryEnd()
end

function var_0_0._finishStoryFromServer(arg_29_0)
	if var_0_0._storyId == arg_29_0 then
		var_0_0._serverFinish = true

		var_0_0.checkStoryEnd()
	end
end

function var_0_0.checkStoryEnd()
	if var_0_0._clientFinish and var_0_0._serverFinish then
		var_0_0.onStoryEnd()
	end
end

function var_0_0.onStoryEnd()
	var_0_0._storyId = nil
	var_0_0._clientFinish = false
	var_0_0._serverFinish = false

	TaskDispatcher.cancelTask(var_0_0.onStoryEnd, nil)
	StoryController.instance:unregisterCallback(StoryEvent.FinishFromServer, var_0_0._finishStoryFromServer)
	FightController.onResultViewClose()
end

function var_0_0._loadBonusItems(arg_32_0)
	arg_32_0._firstBonusGOList = arg_32_0:getUserDataTb_()
	arg_32_0._additionBonusGOList = arg_32_0:getUserDataTb_()
	arg_32_0._additionContainerGODict = arg_32_0:getUserDataTb_()
	arg_32_0._bonusGOList = arg_32_0:getUserDataTb_()
	arg_32_0._moveBonusGOList = arg_32_0:getUserDataTb_()
	arg_32_0._extraBonusGOList = arg_32_0:getUserDataTb_()
	arg_32_0._containerGODict = arg_32_0:getUserDataTb_()
	arg_32_0._extraContainerGODict = arg_32_0:getUserDataTb_()
	arg_32_0._delayTime = 0.06
	arg_32_0._itemDelay = 0.5

	local var_32_0 = arg_32_0._curEpisodeId and tonumber(DungeonConfig.instance:getEndBattleCost(arg_32_0._curEpisodeId)) or 0

	if var_32_0 and var_32_0 > 0 then
		table.insert(arg_32_0._bonusGOList, arg_32_0._favorIcon)
	end

	gohelper.setActive(arg_32_0._favorIcon, false)

	arg_32_0._favorIcon:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	local var_32_1 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getTimeFirstMaterialDataList())

	if var_32_1 then
		local var_32_2 = LuaUtil.deepCopy(var_32_1)

		for iter_32_0, iter_32_1 in ipairs(var_32_2) do
			arg_32_0:_addFirstItem(iter_32_1)
		end

		arg_32_0:checkHadHighRareProp(var_32_2)
	end

	local var_32_3 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getFirstMaterialDataList())

	if var_32_3 then
		local var_32_4 = LuaUtil.deepCopy(var_32_3)

		for iter_32_2, iter_32_3 in ipairs(var_32_4) do
			arg_32_0:_addFirstItem(iter_32_3)
		end

		arg_32_0:checkHadHighRareProp(var_32_4)
	end

	local var_32_5 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct155MaterialDataList())

	if var_32_5 then
		local var_32_6 = LuaUtil.deepCopy(var_32_5)

		for iter_32_4, iter_32_5 in ipairs(var_32_6) do
			if iter_32_5.materilType == MaterialEnum.MaterialType.Currency and iter_32_5.materilId == CurrencyEnum.CurrencyType.V1a9Dungeon then
				arg_32_0:_addFirstItem(iter_32_5, arg_32_0.onRefreshV1a7Currency)
			elseif iter_32_5.materilType == MaterialEnum.MaterialType.PowerPotion and iter_32_5.materilId == MaterialEnum.PowerId.ActPowerId then
				arg_32_0:_addFirstItem(iter_32_5, arg_32_0.onRefreshV1a7Power)
			elseif iter_32_5.materilType == MaterialEnum.MaterialType.Currency and iter_32_5.materilId == CurrencyEnum.CurrencyType.V1a9ToughEnter then
				arg_32_0:_addFirstItem(iter_32_5, arg_32_0.onRefreshToughBattle)
			elseif iter_32_5.materilType == MaterialEnum.MaterialType.Currency and iter_32_5.materilId == CurrencyEnum.CurrencyType.V2a2Dungeon then
				arg_32_0:_addFirstItem(iter_32_5, arg_32_0.onRefreshV2a2Dungeon)
			elseif iter_32_5.materilType == MaterialEnum.MaterialType.Currency and iter_32_5.materilId == CurrencyEnum.CurrencyType.V2a6Dungeon then
				arg_32_0:_addFirstItem(iter_32_5, arg_32_0.onRefreshV2a6Dungeon)
			else
				arg_32_0:_addFirstItem(iter_32_5)
			end
		end

		arg_32_0:checkHadHighRareProp(var_32_6)
	end

	local var_32_7 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct153MaterialDataList())

	if var_32_7 then
		local var_32_8 = LuaUtil.deepCopy(var_32_7)

		for iter_32_6, iter_32_7 in ipairs(var_32_8) do
			arg_32_0:_addAdditionItem(iter_32_7)
		end

		arg_32_0:checkHadHighRareProp(var_32_8)

		if #var_32_8 > 0 then
			local var_32_9, var_32_10 = DoubleDropModel.instance:getDailyRemainTimes()

			if var_32_9 and var_32_10 then
				GameFacade.showToast(ToastEnum.DoubleDropTips, var_32_9, var_32_10)
			end
		end
	end

	local var_32_11 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAdditionMaterialDataList())

	if var_32_11 then
		local var_32_12 = LuaUtil.deepCopy(var_32_11)

		for iter_32_8, iter_32_9 in ipairs(var_32_12) do
			arg_32_0:_addAdditionItem(iter_32_9)
		end

		arg_32_0:checkHadHighRareProp(var_32_12)
	end

	if FightModel.instance:isEnterUseFreeLimit() then
		local var_32_13 = FightResultModel.instance:getExtraMaterialDataList()

		if var_32_13 then
			local var_32_14 = LuaUtil.deepCopy(ItemModel.instance:processRPCItemList(var_32_13))

			for iter_32_10, iter_32_11 in ipairs(var_32_14) do
				iter_32_11.bonusTag = FightEnum.FightBonusTag.EquipDailyFreeBonus

				arg_32_0:_addExtraItem(iter_32_11)
			end

			arg_32_0:checkHadHighRareProp(var_32_14)
		end
	end

	local var_32_15 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getNormal2SimpleMaterialDataList())

	if var_32_15 then
		local var_32_16 = LuaUtil.deepCopy(var_32_15)

		for iter_32_12, iter_32_13 in ipairs(var_32_16) do
			arg_32_0:_addFirstItem(iter_32_13)
		end

		arg_32_0:checkHadHighRareProp(var_32_16)
	end

	local var_32_17 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList())

	if var_32_17 then
		local var_32_18 = LuaUtil.deepCopy(var_32_17)

		for iter_32_14, iter_32_15 in ipairs(var_32_18) do
			arg_32_0:_addNormalItem(iter_32_15)
		end

		arg_32_0:checkHadHighRareProp(var_32_18)
	end

	arg_32_0._animEventWrap:AddEventListener("bonus", arg_32_0._showPlayerLevelUpView, arg_32_0)
end

function var_0_0.checkHadHighRareProp(arg_33_0, arg_33_1)
	if arg_33_0.hadHighRareProp then
		return
	end

	local var_33_0

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		local var_33_1 = ItemModel.instance:getItemConfig(tonumber(iter_33_1.materilType), tonumber(iter_33_1.materilId))

		if not var_33_1 or not var_33_1.rare then
			logNormal(string.format("[checkMaterialRare] type : %s, id : %s; getConfig error", iter_33_1.materilType, iter_33_1.materilId))
		elseif var_33_1.rare >= CommonPropListModel.HighRare then
			arg_33_0.hadHighRareProp = true

			return
		end
	end
end

function var_0_0._addFirstItem(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0, var_34_1 = arg_34_0:_addItem(arg_34_1, arg_34_2, arg_34_3)

	arg_34_0._containerGODict[arg_34_0._delayTime * #arg_34_0._bonusGOList + arg_34_0._itemDelay] = var_34_0

	table.insert(arg_34_0._bonusGOList, var_34_1)
	table.insert(arg_34_0._firstBonusGOList, var_34_1)
end

function var_0_0._addAdditionItem(arg_35_0, arg_35_1)
	local var_35_0, var_35_1 = arg_35_0:_addItem(arg_35_1)

	arg_35_0._additionContainerGODict[arg_35_0._delayTime * #arg_35_0._additionBonusGOList + arg_35_0._itemDelay] = var_35_0

	table.insert(arg_35_0._additionBonusGOList, var_35_1)
end

function var_0_0._addExtraItem(arg_36_0, arg_36_1)
	local var_36_0, var_36_1 = arg_36_0:_addItem(arg_36_1)

	arg_36_0._extraContainerGODict[arg_36_0._delayTime * #arg_36_0._extraBonusGOList + arg_36_0._itemDelay] = var_36_0

	table.insert(arg_36_0._extraBonusGOList, var_36_1)
end

function var_0_0._addNormalItem(arg_37_0, arg_37_1)
	local var_37_0, var_37_1 = arg_37_0:_addItem(arg_37_1)

	arg_37_0._containerGODict[arg_37_0._delayTime * #arg_37_0._bonusGOList + arg_37_0._itemDelay] = var_37_0

	table.insert(arg_37_0._bonusGOList, var_37_1)
	table.insert(arg_37_0._moveBonusGOList, var_37_1)
end

function var_0_0._addItem(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = gohelper.clone(arg_38_0._bonusItemGo, arg_38_0._bonusItemContainer, arg_38_1.id)
	local var_38_1 = gohelper.findChild(var_38_0, "container/itemIcon")
	local var_38_2 = IconMgr.instance:getCommonPropItemIcon(var_38_1)
	local var_38_3 = gohelper.findChild(var_38_0, "container/tag")
	local var_38_4 = gohelper.findChild(var_38_0, "container/tag/imgFirst")
	local var_38_5 = gohelper.findChild(var_38_0, "container/tag/imgFirstHard")
	local var_38_6 = gohelper.findChild(var_38_0, "container/tag/imgFirstSimple")
	local var_38_7 = gohelper.findChild(var_38_0, "container/tag/imgNormal")
	local var_38_8 = gohelper.findChild(var_38_0, "container/tag/imgAdvance")
	local var_38_9 = gohelper.findChild(var_38_0, "container/tag/imgEquipDaily")
	local var_38_10 = gohelper.findChild(var_38_0, "container/tag/limitfirstbg")
	local var_38_11 = gohelper.findChild(var_38_0, "container/tag/imgact")
	local var_38_12 = gohelper.findChild(var_38_0, "container")

	gohelper.setActive(var_38_12, false)
	gohelper.setActive(var_38_3, arg_38_1.bonusTag)

	if arg_38_1.bonusTag then
		gohelper.setActive(var_38_4, arg_38_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and arg_38_0._normalMode)
		gohelper.setActive(var_38_5, arg_38_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and arg_38_0._hardMode)
		gohelper.setActive(var_38_7, false)
		gohelper.setActive(var_38_8, arg_38_1.bonusTag == FightEnum.FightBonusTag.AdvencedBonus)
		gohelper.setActive(var_38_9, arg_38_1.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
		gohelper.setActive(var_38_10, arg_38_1.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus)
		gohelper.setActive(var_38_11, arg_38_1.bonusTag == FightEnum.FightBonusTag.ActBonus)
		gohelper.setActive(var_38_6, arg_38_1.bonusTag == FightEnum.FightBonusTag.SimpleBouns or FightEnum.FightBonusTag.FirstBonus and arg_38_0._simpleMode)
	end

	arg_38_1.isIcon = true

	var_38_2:onUpdateMO(arg_38_1)
	var_38_2:setCantJump(true)
	var_38_2:setCountFontSize(40)
	var_38_2:setAutoPlay(true)
	var_38_2:isShowEquipRefineLv(true)

	local var_38_13 = false

	if arg_38_1.bonusTag and arg_38_1.bonusTag == FightEnum.FightBonusTag.AdditionBonus then
		var_38_13 = true
	end

	var_38_2:isShowAddition(var_38_13)

	if arg_38_2 then
		arg_38_2(arg_38_0, var_38_2, arg_38_3)
	end

	gohelper.setActive(var_38_0, false)

	var_38_3:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	arg_38_0:applyBonusVfx(arg_38_1, var_38_0)

	return var_38_12, var_38_0
end

function var_0_0.applyBonusVfx(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = ItemModel.instance:getItemConfig(arg_39_1.materilType, arg_39_1.materilId)
	local var_39_1 = var_39_0.rare

	if arg_39_1.materilType == MaterialEnum.MaterialType.PlayerCloth then
		var_39_1 = var_39_1 or 5
	else
		var_39_1 = var_39_1 or 1
	end

	for iter_39_0 = 1, 6 do
		local var_39_2 = gohelper.findChild(arg_39_2, "vx/" .. iter_39_0)

		gohelper.setActive(var_39_2, iter_39_0 == var_39_1)
	end

	local var_39_3 = ItemModel.canShowVfx(arg_39_1.materilType, var_39_0, var_39_1)

	for iter_39_1 = 4, 5 do
		local var_39_4 = gohelper.findChild(arg_39_2, "vx/" .. iter_39_1 .. "/#teshudaoju")

		if iter_39_1 == var_39_1 and var_39_3 then
			gohelper.setActive(var_39_4, false)
			gohelper.setActive(var_39_4, true)
		else
			gohelper.setActive(var_39_4, false)
		end
	end
end

function var_0_0.onRefreshV1a7Currency(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1._itemIcon

	var_40_0._gov1a7act = var_40_0._gov1a7act or gohelper.findChild(var_40_0.go, "act")

	gohelper.setActive(var_40_0._gov1a7act, true)
end

function var_0_0.onRefreshV1a7Power(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1._itemIcon

	var_41_0:setCanShowDeadLine(false)

	var_41_0._gov1a7act = var_41_0._gov1a7act or gohelper.findChild(var_41_0.go, "act")

	gohelper.setActive(var_41_0._gov1a7act, true)
end

function var_0_0.onRefreshToughBattle(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1._itemIcon

	var_42_0:setCanShowDeadLine(false)

	var_42_0._gov1a7act = var_42_0._gov1a7act or gohelper.findChild(var_42_0.go, "act")

	gohelper.setActive(var_42_0._gov1a7act, true)
end

function var_0_0.onRefreshV2a2Dungeon(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1._itemIcon

	var_43_0:setCanShowDeadLine(false)

	var_43_0._gov1a7act = var_43_0._gov1a7act or gohelper.findChild(var_43_0.go, "act")

	gohelper.setActive(var_43_0._gov1a7act, true)
end

function var_0_0.onRefreshV2a6Dungeon(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1._itemIcon

	var_44_0:setCanShowDeadLine(false)

	var_44_0._gov1a7act = var_44_0._gov1a7act or gohelper.findChild(var_44_0.go, "act")

	gohelper.setActive(var_44_0._gov1a7act, true)
end

function var_0_0._showRecordFarmItem(arg_45_0)
	local var_45_0 = FightResultModel.instance:getEpisodeId()
	local var_45_1 = JumpModel.instance:getRecordFarmItem()
	local var_45_2 = var_0_0.checkRecordFarmItem(var_45_0, var_45_1)

	gohelper.setActive(arg_45_0._godemand, var_45_2)

	if var_45_2 then
		arg_45_0._godemand:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0
		arg_45_0._farmTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_45_0._godemand, 0, 1, 0.3, nil, nil, nil, EaseType.Linear)

		if var_45_1.special then
			arg_45_0._txtdemand.text = var_45_1.desc

			gohelper.setActive(arg_45_0._btnbacktosource.gameObject, true)
		else
			local var_45_3 = ItemModel.instance:getItemConfig(var_45_1.type, var_45_1.id)
			local var_45_4 = ItemModel.instance:getItemQuantity(var_45_1.type, var_45_1.id)

			if var_45_1.quantity then
				if var_45_4 >= var_45_1.quantity then
					arg_45_0._txtdemand.text = string.format("%s %s <color=#81ce83>%s</color>/%s", luaLang("fightsuccview_demand"), var_45_3.name, GameUtil.numberDisplay(var_45_4), GameUtil.numberDisplay(var_45_1.quantity))
				else
					arg_45_0._txtdemand.text = string.format("%s %s <color=#cc492f>%s</color>/%s", luaLang("fightsuccview_demand"), var_45_3.name, GameUtil.numberDisplay(var_45_4), GameUtil.numberDisplay(var_45_1.quantity))
				end

				gohelper.setActive(arg_45_0._btnbacktosource.gameObject, true)
			else
				local var_45_5 = {
					var_45_3.name,
					(GameUtil.numberDisplay(var_45_4))
				}

				arg_45_0._txtdemand.text = GameUtil.getSubPlaceholderLuaLang(luaLang("FightSuccView_txtdemand_overseas"), var_45_5)

				gohelper.setActive(arg_45_0._btnbacktosource.gameObject, true)
			end
		end
	else
		JumpModel.instance:clearRecordFarmItem()
	end
end

function var_0_0.checkRecordFarmItem(arg_46_0, arg_46_1)
	if not arg_46_1 then
		return false
	end

	if arg_46_1.checkFunc then
		return arg_46_1.checkFunc(arg_46_1.checkFuncObj)
	end

	local var_46_0 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList())

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		if iter_46_1.materilType == arg_46_1.type and iter_46_1.materilId == arg_46_1.id then
			return true
		end
	end

	if not (arg_46_0 and DungeonConfig.instance:getEpisodeCO(arg_46_0)) then
		return false
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeFirstBonus(arg_46_0), arg_46_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeAdvancedBonus(arg_46_0), arg_46_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeBonus(arg_46_0), arg_46_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeRewardList(arg_46_0), arg_46_1) then
		return true
	end

	return false
end

function var_0_0.checkRecordFarmItemByReward(arg_47_0, arg_47_1)
	for iter_47_0, iter_47_1 in ipairs(arg_47_0) do
		if tonumber(iter_47_1[1]) == arg_47_1.type and tonumber(iter_47_1[2]) == arg_47_1.id then
			return true
		end
	end

	return false
end

function var_0_0._showCharacterGetView(arg_48_0)
	PopupController.instance:setPause("fightsuccess", false)

	arg_48_0._canClick = true
end

function var_0_0._showBonus(arg_49_0)
	if arg_49_0.hadHighRareProp then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_resources)
	end

	if #arg_49_0._bonusGOList <= 0 then
		arg_49_0:_showRecordFarmItem()
		arg_49_0:_showCharacterGetView()

		return
	end

	if arg_49_0._popupFlow then
		arg_49_0._popupFlow:destroy()

		arg_49_0._popupFlow = nil
	end

	arg_49_0.popupFlow = FlowSequence.New()

	arg_49_0.popupFlow:addWork(FightSuccShowBonusWork.New(arg_49_0._bonusGOList, arg_49_0._containerGODict, arg_49_0._delayTime, arg_49_0._itemDelay))
	arg_49_0.popupFlow:addWork(FightSuccShowExtraBonusWork.New(arg_49_0._extraBonusGOList, arg_49_0._extraContainerGODict, arg_49_0._showBonusEffect, arg_49_0, arg_49_0._moveBonusGOList, arg_49_0._bonusItemContainer, arg_49_0._delayTime, arg_49_0._itemDelay))
	arg_49_0.popupFlow:addWork(FightSuccShowExtraBonusWork.New(arg_49_0._additionBonusGOList, arg_49_0._additionContainerGODict, arg_49_0._showBonusEffect, arg_49_0, arg_49_0._moveBonusGOList, arg_49_0._bonusItemContainer, arg_49_0._delayTime, arg_49_0._itemDelay))
	arg_49_0.popupFlow:registerDoneListener(arg_49_0._onAllTweenFinish, arg_49_0)
	arg_49_0.popupFlow:start()
end

function var_0_0._showBonusEffect(arg_50_0)
	local var_50_0 = gohelper.findChild(arg_50_0.viewGO, "#reward_vx")

	gohelper.setActive(var_50_0, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_extrafall)

	if #arg_50_0._firstBonusGOList > 0 then
		recthelper.setAnchorX(var_50_0.transform, 169)
	end
end

function var_0_0._onAllTweenFinish(arg_51_0)
	arg_51_0:_showRecordFarmItem()
	arg_51_0:_showCharacterGetView()

	if arg_51_0.viewContainer.fightSuccActView then
		arg_51_0.viewContainer.fightSuccActView:showReward()
	end
end

function var_0_0._showPlayerLevelUpView(arg_52_0)
	local var_52_0 = DungeonModel.instance.curSendEpisodeId
	local var_52_1 = lua_episode.configDict[var_52_0]

	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	local var_52_2 = PlayerModel.instance:getAndResetPlayerLevelUp()

	if var_52_2 > 0 then
		ViewMgr.instance:openView(ViewName.PlayerLevelUpView, var_52_2)
	else
		arg_52_0:_showBonus()
	end
end

function var_0_0._onCloseView(arg_53_0, arg_53_1)
	if arg_53_1 == ViewName.PlayerLevelUpView or arg_53_1 == ViewName.SeasonLevelView then
		arg_53_0:_showBonus()
	end
end

function var_0_0._onClickData(arg_54_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._onClickBackToSource(arg_55_0)
	local var_55_0 = JumpModel.instance:getRecordFarmItem()

	if var_55_0 then
		var_55_0.canBackSource = true
	end

	arg_55_0:closeThis()
	var_0_0.onStoryEnd()
end

function var_0_0.showUnLockCurrentEpisodeNewMode(arg_56_0)
	local var_56_0 = ActivityConfig.instance:getActIdByChapterId(arg_56_0._curChapterId)

	if not var_56_0 then
		return
	end

	local var_56_1 = ActivityConfig.instance:getActivityDungeonConfig(var_56_0)

	if not var_56_1 then
		return
	end

	if var_56_1.story1ChapterId ~= arg_56_0._curChapterId and var_56_1.story2ChapterId ~= arg_56_0._curChapterId then
		return
	end

	if not DungeonModel.instance.curSendEpisodePass then
		return
	end

	local var_56_2 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(lua_episode.configDict[arg_56_0._curEpisodeId])

	if not var_56_2 or #var_56_2 <= 1 then
		return
	end

	local var_56_3 = ActivityConfig.instance:getChapterIdMode(arg_56_0._curChapterId)

	GameFacade.showToast(ToastEnum.UnLockCurrentEpisode, luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[var_56_3 + 1]))
end

function var_0_0._hideGoDemand(arg_57_0)
	gohelper.setActive(arg_57_0._godemand, false)
end

function var_0_0._show1_2DailyEpisodeEndNotice(arg_58_0)
	local var_58_0 = lua_activity116_episode_sp.configDict[arg_58_0._curEpisodeId]

	if var_58_0 then
		ToastController.instance:showToastWithString(var_58_0.endShow)
	end
end

function var_0_0._showWeekWalk_2Condition(arg_59_0)
	local var_59_0 = lua_episode.configDict[arg_59_0._curEpisodeId]

	if not (var_59_0 and var_59_0.type == DungeonEnum.EpisodeType.WeekWalk_2) then
		return
	end

	local var_59_1 = WeekWalk_2Model.instance:getResultCupInfos()

	if not var_59_1 then
		return
	end

	for iter_59_0, iter_59_1 in ipairs(var_59_1) do
		local var_59_2 = gohelper.cloneInPlace(arg_59_0._goweekwalkcontentitem)

		arg_59_0:_showWeekWalkVer2OneTaskGroup(var_59_2, iter_59_1, iter_59_0)
	end

	gohelper.setActive(arg_59_0._goalcontent, false)
	gohelper.setActive(arg_59_0._goweekwalkgoalcontent, true)
end

function var_0_0._showWeekWalkVer2OneTaskGroup(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	local var_60_0 = arg_60_2.config

	gohelper.findChildText(arg_60_1, "condition").text = var_60_0["desc" .. arg_60_2.result] or var_60_0.desc1

	local var_60_1 = gohelper.findChildImage(arg_60_1, "star")

	var_60_1.enabled = false

	local var_60_2 = arg_60_0:getResInst(arg_60_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_60_1.gameObject)

	WeekWalk_2Helper.setCupEffect(var_60_2, arg_60_2)
	gohelper.setActive(arg_60_1, true)
end

function var_0_0._show1_6EpisodeMaterial(arg_61_0)
	local var_61_0 = lua_episode.configDict[arg_61_0._curEpisodeId]
	local var_61_1 = var_61_0 and var_61_0.type == DungeonEnum.EpisodeType.Act1_6Dungeon
	local var_61_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	if not var_61_1 or not var_61_2 then
		gohelper.setActive(arg_61_0._goPlatConditionMaterial, false)

		return
	end

	gohelper.setActive(arg_61_0._goPlatConditionMaterial, true)

	local var_61_3
	local var_61_4
	local var_61_5
	local var_61_6 = gohelper.findChildImage(arg_61_0._goPlatConditionMaterial, "icon")
	local var_61_7 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local var_61_8 = string.format("%s_1", var_61_7 and var_61_7.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(var_61_6, var_61_8)

	local var_61_9 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local var_61_10 = VersionActivity1_6DungeonSkillModel.instance:getAllSkillPoint()
	local var_61_11 = string.format("<color=#EB5F34>%s</color>/%s", var_61_10 or 0, var_61_9)

	gohelper.findChildText(arg_61_0._goPlatConditionMaterial, "value").text = var_61_11
	gohelper.findChildText(arg_61_0._goPlatConditionMaterial, "condition").text = luaLang("act1_6dungeonFightResultViewMaterialTitle")
end

function var_0_0._playVictoryAudio_2_7(arg_62_0)
	if LuaUtil.tableContains(VersionActivity2_7DungeonEnum.DungeonChapterId, FightResultModel.instance:getChapterId()) then
		AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString("Checkpointstate"), AudioMgr.instance:getIdFromString("Victory"))
	end
end

return var_0_0

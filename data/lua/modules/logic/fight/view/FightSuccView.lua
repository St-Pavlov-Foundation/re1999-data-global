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
	elseif arg_16_1.type == DungeonEnum.EpisodeType.Season then
		local var_16_3 = FightModel.instance:getFightParam()
		local var_16_4, var_16_5, var_16_6 = Activity104Model.instance:getSeasonEpisodeDifficultByBattleId(var_16_3.battleId)
		local var_16_7 = SeasonConfig.instance:getSeasonEpisodeConfig(var_16_4, var_16_5)

		arg_16_0._txtgrademark.text = var_16_5 == 1 and luaLang("season_permanent_level_score") or luaLang("season_limit_level_score")
		arg_16_0._txtFbName.text = var_16_7.name
		arg_16_0._txtEpisodeIndex.text = var_16_5

		return
	elseif arg_16_1.type == DungeonEnum.EpisodeType.Dog then
		local var_16_8, var_16_9 = Activity109ChessController.instance:getFightSourceEpisode()

		if var_16_8 and var_16_9 then
			local var_16_10 = Activity109Config.instance:getEpisodeCo(var_16_8, var_16_9)

			if var_16_10 then
				arg_16_0._txtFbName.text = arg_16_1.name
				arg_16_0._txtEpisodeIndex.text = var_16_10.id

				return
			end
		end
	end

	local var_16_11 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_16_1)

	if var_16_11 and #var_16_11 > 1 then
		arg_16_2 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(var_16_11[1].id)
	end

	local var_16_12 = DungeonConfig.instance:getChapterCO(arg_16_1.chapterId)

	if var_16_12 then
		if var_16_12.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or var_16_12.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or var_16_12.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or var_16_12.type == DungeonEnum.ChapterType.Activity1_2DungeonHard then
			arg_16_2 = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		end

		if var_16_12.actId == VersionActivity1_3Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity1_3DungeonController.instance:getEpisodeIndex(arg_16_1.id)
		end

		if var_16_12.actId == VersionActivity1_5Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity1_5DungeonController.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_12.actId == VersionActivity1_6Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity1_6DungeonController.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_12.actId == VersionActivity1_8Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity1_8DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_12.actId == VersionActivity2_0Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_0DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_12.actId == VersionActivity2_1Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_1DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_12.actId == VersionActivity2_3Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_3DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_12.actId == VersionActivity2_4Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_4DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
		elseif var_16_12.actId == VersionActivity2_5Enum.ActivityId.Dungeon then
			arg_16_2 = VersionActivity2_5DungeonConfig.instance:getEpisodeIndex(arg_16_1.id)
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

	local var_20_0 = HeroModel.instance:getVoiceConfig(arg_20_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, nil, arg_20_0._randomEntityMO.skin) or FightAudioMgr.instance:_getHeroVoiceCOs(arg_20_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, arg_20_0._randomEntityMO.skin)

	if var_20_0 and #var_20_0 > 0 then
		local var_20_1 = var_20_0[1]

		arg_20_0._uiSpine:playVoice(var_20_1, nil, arg_20_0._txtSayCn, arg_20_0._txtSayEn)
	end
end

function var_0_0._getSayContent(arg_21_0, arg_21_1)
	local var_21_0 = GameUtil.splitString2(arg_21_1, false, "|", "#")
	local var_21_1 = ""

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		var_21_1 = var_21_1 .. iter_21_1[1]
	end

	return var_21_1
end

function var_0_0.onCloseFinish(arg_22_0)
	arg_22_0._simagecharacterbg:UnLoadImage()
	arg_22_0._simagemaskImage:UnLoadImage()
	FightStatModel.instance:clear()
	arg_22_0._animEventWrap:RemoveAllEventListener()

	if arg_22_0._farmTweenId then
		ZProj.TweenHelper.KillById(arg_22_0._farmTweenId)
	end
end

function var_0_0._getHeroIconPath(arg_23_0)
	if arg_23_0._randomEntityMO then
		local var_23_0 = FightConfig.instance:getSkinCO(arg_23_0._randomEntityMO.skin)

		if var_23_0 then
			return ResUrl.getHeadIconLarge(var_23_0.largeIcon)
		end
	end
end

function var_0_0._onClickClose(arg_24_0)
	if not arg_24_0._canClick then
		return
	end

	if arg_24_0._uiSpine then
		arg_24_0._uiSpine:stopVoice()
	end

	arg_24_0:closeThis()

	local var_24_0 = FightModel.instance:getAfterStory()
	local var_24_1 = DungeonConfig.instance:getChapterCO(arg_24_0._curChapterId)
	local var_24_2 = var_24_1.type == DungeonEnum.ChapterType.RoleStory or var_24_1.id == DungeonEnum.ChapterId.RoleDuDuGu

	if var_24_0 > 0 and (var_24_2 or not StoryModel.instance:isStoryFinished(var_24_0)) then
		var_0_0._storyId = var_24_0
		var_0_0._clientFinish = false
		var_0_0._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, var_0_0._finishStoryFromServer)

		local var_24_3 = {}

		var_24_3.mark = true
		var_24_3.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_24_0, var_24_3, function()
			TaskDispatcher.runDelay(var_0_0.onStoryEnd, nil, 3)

			var_0_0._clientFinish = true

			var_0_0.checkStoryEnd()
		end)

		return
	end

	var_0_0.onStoryEnd()
end

function var_0_0._finishStoryFromServer(arg_26_0)
	if var_0_0._storyId == arg_26_0 then
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

function var_0_0._loadBonusItems(arg_29_0)
	arg_29_0._firstBonusGOList = arg_29_0:getUserDataTb_()
	arg_29_0._additionBonusGOList = arg_29_0:getUserDataTb_()
	arg_29_0._additionContainerGODict = arg_29_0:getUserDataTb_()
	arg_29_0._bonusGOList = arg_29_0:getUserDataTb_()
	arg_29_0._moveBonusGOList = arg_29_0:getUserDataTb_()
	arg_29_0._extraBonusGOList = arg_29_0:getUserDataTb_()
	arg_29_0._containerGODict = arg_29_0:getUserDataTb_()
	arg_29_0._extraContainerGODict = arg_29_0:getUserDataTb_()
	arg_29_0._delayTime = 0.06
	arg_29_0._itemDelay = 0.5

	local var_29_0 = arg_29_0._curEpisodeId and tonumber(DungeonConfig.instance:getEndBattleCost(arg_29_0._curEpisodeId)) or 0

	if var_29_0 and var_29_0 > 0 then
		table.insert(arg_29_0._bonusGOList, arg_29_0._favorIcon)
	end

	gohelper.setActive(arg_29_0._favorIcon, false)

	arg_29_0._favorIcon:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	local var_29_1 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getTimeFirstMaterialDataList())

	if var_29_1 then
		local var_29_2 = LuaUtil.deepCopy(var_29_1)

		for iter_29_0, iter_29_1 in ipairs(var_29_2) do
			arg_29_0:_addFirstItem(iter_29_1)
		end

		arg_29_0:checkHadHighRareProp(var_29_2)
	end

	local var_29_3 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getFirstMaterialDataList())

	if var_29_3 then
		local var_29_4 = LuaUtil.deepCopy(var_29_3)

		for iter_29_2, iter_29_3 in ipairs(var_29_4) do
			arg_29_0:_addFirstItem(iter_29_3)
		end

		arg_29_0:checkHadHighRareProp(var_29_4)
	end

	local var_29_5 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct155MaterialDataList())

	if var_29_5 then
		local var_29_6 = LuaUtil.deepCopy(var_29_5)

		for iter_29_4, iter_29_5 in ipairs(var_29_6) do
			if iter_29_5.materilType == MaterialEnum.MaterialType.Currency and iter_29_5.materilId == CurrencyEnum.CurrencyType.V1a9Dungeon then
				arg_29_0:_addFirstItem(iter_29_5, arg_29_0.onRefreshV1a7Currency)
			elseif iter_29_5.materilType == MaterialEnum.MaterialType.PowerPotion and iter_29_5.materilId == MaterialEnum.PowerId.ActPowerId then
				arg_29_0:_addFirstItem(iter_29_5, arg_29_0.onRefreshV1a7Power)
			elseif iter_29_5.materilType == MaterialEnum.MaterialType.Currency and iter_29_5.materilId == CurrencyEnum.CurrencyType.V1a9ToughEnter then
				arg_29_0:_addFirstItem(iter_29_5, arg_29_0.onRefreshToughBattle)
			elseif iter_29_5.materilType == MaterialEnum.MaterialType.Currency and iter_29_5.materilId == CurrencyEnum.CurrencyType.V2a2Dungeon then
				arg_29_0:_addFirstItem(iter_29_5, arg_29_0.onRefreshV2a2Dungeon)
			else
				arg_29_0:_addFirstItem(iter_29_5)
			end
		end

		arg_29_0:checkHadHighRareProp(var_29_6)
	end

	local var_29_7 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct153MaterialDataList())

	if var_29_7 then
		local var_29_8 = LuaUtil.deepCopy(var_29_7)

		for iter_29_6, iter_29_7 in ipairs(var_29_8) do
			arg_29_0:_addAdditionItem(iter_29_7)
		end

		arg_29_0:checkHadHighRareProp(var_29_8)

		if #var_29_8 > 0 then
			local var_29_9, var_29_10 = DoubleDropModel.instance:getDailyRemainTimes()

			if var_29_9 and var_29_10 then
				GameFacade.showToast(ToastEnum.DoubleDropTips, var_29_9, var_29_10)
			end
		end
	end

	local var_29_11 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getAdditionMaterialDataList())

	if var_29_11 then
		local var_29_12 = LuaUtil.deepCopy(var_29_11)

		for iter_29_8, iter_29_9 in ipairs(var_29_12) do
			arg_29_0:_addAdditionItem(iter_29_9)
		end

		arg_29_0:checkHadHighRareProp(var_29_12)
	end

	if FightModel.instance:isEnterUseFreeLimit() then
		local var_29_13 = FightResultModel.instance:getExtraMaterialDataList()

		if var_29_13 then
			local var_29_14 = LuaUtil.deepCopy(ItemModel.instance:processRPCItemList(var_29_13))

			for iter_29_10, iter_29_11 in ipairs(var_29_14) do
				iter_29_11.bonusTag = FightEnum.FightBonusTag.EquipDailyFreeBonus

				arg_29_0:_addExtraItem(iter_29_11)
			end

			arg_29_0:checkHadHighRareProp(var_29_14)
		end
	end

	local var_29_15 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getNormal2SimpleMaterialDataList())

	if var_29_15 then
		local var_29_16 = LuaUtil.deepCopy(var_29_15)

		for iter_29_12, iter_29_13 in ipairs(var_29_16) do
			arg_29_0:_addFirstItem(iter_29_13)
		end

		arg_29_0:checkHadHighRareProp(var_29_16)
	end

	local var_29_17 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList())

	if var_29_17 then
		local var_29_18 = LuaUtil.deepCopy(var_29_17)

		for iter_29_14, iter_29_15 in ipairs(var_29_18) do
			arg_29_0:_addNormalItem(iter_29_15)
		end

		arg_29_0:checkHadHighRareProp(var_29_18)
	end

	arg_29_0._animEventWrap:AddEventListener("bonus", arg_29_0._showPlayerLevelUpView, arg_29_0)
end

function var_0_0.checkHadHighRareProp(arg_30_0, arg_30_1)
	if arg_30_0.hadHighRareProp then
		return
	end

	local var_30_0

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		local var_30_1 = ItemModel.instance:getItemConfig(tonumber(iter_30_1.materilType), tonumber(iter_30_1.materilId))

		if not var_30_1 or not var_30_1.rare then
			logNormal(string.format("[checkMaterialRare] type : %s, id : %s; getConfig error", iter_30_1.materilType, iter_30_1.materilId))
		elseif var_30_1.rare >= CommonPropListModel.HighRare then
			arg_30_0.hadHighRareProp = true

			return
		end
	end
end

function var_0_0._addFirstItem(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0, var_31_1 = arg_31_0:_addItem(arg_31_1, arg_31_2, arg_31_3)

	arg_31_0._containerGODict[arg_31_0._delayTime * #arg_31_0._bonusGOList + arg_31_0._itemDelay] = var_31_0

	table.insert(arg_31_0._bonusGOList, var_31_1)
	table.insert(arg_31_0._firstBonusGOList, var_31_1)
end

function var_0_0._addAdditionItem(arg_32_0, arg_32_1)
	local var_32_0, var_32_1 = arg_32_0:_addItem(arg_32_1)

	arg_32_0._additionContainerGODict[arg_32_0._delayTime * #arg_32_0._additionBonusGOList + arg_32_0._itemDelay] = var_32_0

	table.insert(arg_32_0._additionBonusGOList, var_32_1)
end

function var_0_0._addExtraItem(arg_33_0, arg_33_1)
	local var_33_0, var_33_1 = arg_33_0:_addItem(arg_33_1)

	arg_33_0._extraContainerGODict[arg_33_0._delayTime * #arg_33_0._extraBonusGOList + arg_33_0._itemDelay] = var_33_0

	table.insert(arg_33_0._extraBonusGOList, var_33_1)
end

function var_0_0._addNormalItem(arg_34_0, arg_34_1)
	local var_34_0, var_34_1 = arg_34_0:_addItem(arg_34_1)

	arg_34_0._containerGODict[arg_34_0._delayTime * #arg_34_0._bonusGOList + arg_34_0._itemDelay] = var_34_0

	table.insert(arg_34_0._bonusGOList, var_34_1)
	table.insert(arg_34_0._moveBonusGOList, var_34_1)
end

function var_0_0._addItem(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = gohelper.clone(arg_35_0._bonusItemGo, arg_35_0._bonusItemContainer, arg_35_1.id)
	local var_35_1 = gohelper.findChild(var_35_0, "container/itemIcon")
	local var_35_2 = IconMgr.instance:getCommonPropItemIcon(var_35_1)
	local var_35_3 = gohelper.findChild(var_35_0, "container/tag")
	local var_35_4 = gohelper.findChild(var_35_0, "container/tag/imgFirst")
	local var_35_5 = gohelper.findChild(var_35_0, "container/tag/imgFirstHard")
	local var_35_6 = gohelper.findChild(var_35_0, "container/tag/imgFirstSimple")
	local var_35_7 = gohelper.findChild(var_35_0, "container/tag/imgNormal")
	local var_35_8 = gohelper.findChild(var_35_0, "container/tag/imgAdvance")
	local var_35_9 = gohelper.findChild(var_35_0, "container/tag/imgEquipDaily")
	local var_35_10 = gohelper.findChild(var_35_0, "container/tag/limitfirstbg")
	local var_35_11 = gohelper.findChild(var_35_0, "container/tag/imgact")
	local var_35_12 = gohelper.findChild(var_35_0, "container")

	gohelper.setActive(var_35_12, false)
	gohelper.setActive(var_35_3, arg_35_1.bonusTag)

	if arg_35_1.bonusTag then
		gohelper.setActive(var_35_4, arg_35_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and arg_35_0._normalMode)
		gohelper.setActive(var_35_5, arg_35_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and arg_35_0._hardMode)
		gohelper.setActive(var_35_7, false)
		gohelper.setActive(var_35_8, arg_35_1.bonusTag == FightEnum.FightBonusTag.AdvencedBonus)
		gohelper.setActive(var_35_9, arg_35_1.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
		gohelper.setActive(var_35_10, arg_35_1.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus)
		gohelper.setActive(var_35_11, arg_35_1.bonusTag == FightEnum.FightBonusTag.ActBonus)
		gohelper.setActive(var_35_6, arg_35_1.bonusTag == FightEnum.FightBonusTag.SimpleBouns or FightEnum.FightBonusTag.FirstBonus and arg_35_0._simpleMode)
	end

	arg_35_1.isIcon = true

	var_35_2:onUpdateMO(arg_35_1)
	var_35_2:setCantJump(true)
	var_35_2:setCountFontSize(40)
	var_35_2:setAutoPlay(true)
	var_35_2:isShowEquipRefineLv(true)

	local var_35_13 = false

	if arg_35_1.bonusTag and arg_35_1.bonusTag == FightEnum.FightBonusTag.AdditionBonus then
		var_35_13 = true
	end

	var_35_2:isShowAddition(var_35_13)

	if arg_35_2 then
		arg_35_2(arg_35_0, var_35_2, arg_35_3)
	end

	gohelper.setActive(var_35_0, false)

	var_35_3:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	arg_35_0:applyBonusVfx(arg_35_1, var_35_0)

	return var_35_12, var_35_0
end

function var_0_0.applyBonusVfx(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = ItemModel.instance:getItemConfig(arg_36_1.materilType, arg_36_1.materilId)
	local var_36_1 = var_36_0.rare

	if arg_36_1.materilType == MaterialEnum.MaterialType.PlayerCloth then
		var_36_1 = var_36_1 or 5
	else
		var_36_1 = var_36_1 or 1
	end

	for iter_36_0 = 1, 6 do
		local var_36_2 = gohelper.findChild(arg_36_2, "vx/" .. iter_36_0)

		gohelper.setActive(var_36_2, iter_36_0 == var_36_1)
	end

	local var_36_3 = ItemModel.canShowVfx(arg_36_1.materilType, var_36_0, var_36_1)

	for iter_36_1 = 4, 5 do
		local var_36_4 = gohelper.findChild(arg_36_2, "vx/" .. iter_36_1 .. "/#teshudaoju")

		if iter_36_1 == var_36_1 and var_36_3 then
			gohelper.setActive(var_36_4, false)
			gohelper.setActive(var_36_4, true)
		else
			gohelper.setActive(var_36_4, false)
		end
	end
end

function var_0_0.onRefreshV1a7Currency(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1._itemIcon

	var_37_0._gov1a7act = var_37_0._gov1a7act or gohelper.findChild(var_37_0.go, "act")

	gohelper.setActive(var_37_0._gov1a7act, true)
end

function var_0_0.onRefreshV1a7Power(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1._itemIcon

	var_38_0:setCanShowDeadLine(false)

	var_38_0._gov1a7act = var_38_0._gov1a7act or gohelper.findChild(var_38_0.go, "act")

	gohelper.setActive(var_38_0._gov1a7act, true)
end

function var_0_0.onRefreshToughBattle(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1._itemIcon

	var_39_0:setCanShowDeadLine(false)

	var_39_0._gov1a7act = var_39_0._gov1a7act or gohelper.findChild(var_39_0.go, "act")

	gohelper.setActive(var_39_0._gov1a7act, true)
end

function var_0_0.onRefreshV2a2Dungeon(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1._itemIcon

	var_40_0:setCanShowDeadLine(false)

	var_40_0._gov1a7act = var_40_0._gov1a7act or gohelper.findChild(var_40_0.go, "act")

	gohelper.setActive(var_40_0._gov1a7act, true)
end

function var_0_0._showRecordFarmItem(arg_41_0)
	local var_41_0 = FightResultModel.instance:getEpisodeId()
	local var_41_1 = JumpModel.instance:getRecordFarmItem()
	local var_41_2 = var_0_0.checkRecordFarmItem(var_41_0, var_41_1)

	gohelper.setActive(arg_41_0._godemand, var_41_2)

	if var_41_2 then
		arg_41_0._godemand:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0
		arg_41_0._farmTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_41_0._godemand, 0, 1, 0.3, nil, nil, nil, EaseType.Linear)

		if var_41_1.special then
			arg_41_0._txtdemand.text = var_41_1.desc

			gohelper.setActive(arg_41_0._btnbacktosource.gameObject, true)
		else
			local var_41_3 = ItemModel.instance:getItemConfig(var_41_1.type, var_41_1.id)
			local var_41_4 = ItemModel.instance:getItemQuantity(var_41_1.type, var_41_1.id)

			if var_41_1.quantity then
				if var_41_4 >= var_41_1.quantity then
					arg_41_0._txtdemand.text = string.format("%s %s <color=#81ce83>%s</color>/%s", luaLang("fightsuccview_demand"), var_41_3.name, GameUtil.numberDisplay(var_41_4), GameUtil.numberDisplay(var_41_1.quantity))
				else
					arg_41_0._txtdemand.text = string.format("%s %s <color=#cc492f>%s</color>/%s", luaLang("fightsuccview_demand"), var_41_3.name, GameUtil.numberDisplay(var_41_4), GameUtil.numberDisplay(var_41_1.quantity))
				end

				gohelper.setActive(arg_41_0._btnbacktosource.gameObject, true)
			else
				local var_41_5 = {
					var_41_3.name,
					(GameUtil.numberDisplay(var_41_4))
				}

				arg_41_0._txtdemand.text = GameUtil.getSubPlaceholderLuaLang(luaLang("FightSuccView_txtdemand_overseas"), var_41_5)

				gohelper.setActive(arg_41_0._btnbacktosource.gameObject, true)
			end
		end
	else
		JumpModel.instance:clearRecordFarmItem()
	end
end

function var_0_0.checkRecordFarmItem(arg_42_0, arg_42_1)
	if not arg_42_1 then
		return false
	end

	if arg_42_1.checkFunc then
		return arg_42_1.checkFunc(arg_42_1.checkFuncObj)
	end

	local var_42_0 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList())

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if iter_42_1.materilType == arg_42_1.type and iter_42_1.materilId == arg_42_1.id then
			return true
		end
	end

	if not (arg_42_0 and DungeonConfig.instance:getEpisodeCO(arg_42_0)) then
		return false
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeFirstBonus(arg_42_0), arg_42_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeAdvancedBonus(arg_42_0), arg_42_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeBonus(arg_42_0), arg_42_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeRewardList(arg_42_0), arg_42_1) then
		return true
	end

	return false
end

function var_0_0.checkRecordFarmItemByReward(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0) do
		if tonumber(iter_43_1[1]) == arg_43_1.type and tonumber(iter_43_1[2]) == arg_43_1.id then
			return true
		end
	end

	return false
end

function var_0_0._showCharacterGetView(arg_44_0)
	PopupController.instance:setPause("fightsuccess", false)

	arg_44_0._canClick = true
end

function var_0_0._showBonus(arg_45_0)
	if arg_45_0.hadHighRareProp then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_resources)
	end

	if #arg_45_0._bonusGOList <= 0 then
		arg_45_0:_showRecordFarmItem()
		arg_45_0:_showCharacterGetView()

		return
	end

	if arg_45_0._popupFlow then
		arg_45_0._popupFlow:destroy()

		arg_45_0._popupFlow = nil
	end

	arg_45_0.popupFlow = FlowSequence.New()

	arg_45_0.popupFlow:addWork(FightSuccShowBonusWork.New(arg_45_0._bonusGOList, arg_45_0._containerGODict, arg_45_0._delayTime, arg_45_0._itemDelay))
	arg_45_0.popupFlow:addWork(FightSuccShowExtraBonusWork.New(arg_45_0._extraBonusGOList, arg_45_0._extraContainerGODict, arg_45_0._showBonusEffect, arg_45_0, arg_45_0._moveBonusGOList, arg_45_0._bonusItemContainer, arg_45_0._delayTime, arg_45_0._itemDelay))
	arg_45_0.popupFlow:addWork(FightSuccShowExtraBonusWork.New(arg_45_0._additionBonusGOList, arg_45_0._additionContainerGODict, arg_45_0._showBonusEffect, arg_45_0, arg_45_0._moveBonusGOList, arg_45_0._bonusItemContainer, arg_45_0._delayTime, arg_45_0._itemDelay))
	arg_45_0.popupFlow:registerDoneListener(arg_45_0._onAllTweenFinish, arg_45_0)
	arg_45_0.popupFlow:start()
end

function var_0_0._showBonusEffect(arg_46_0)
	local var_46_0 = gohelper.findChild(arg_46_0.viewGO, "#reward_vx")

	gohelper.setActive(var_46_0, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_extrafall)

	if #arg_46_0._firstBonusGOList > 0 then
		recthelper.setAnchorX(var_46_0.transform, 169)
	end
end

function var_0_0._onAllTweenFinish(arg_47_0)
	arg_47_0:_showRecordFarmItem()
	arg_47_0:_showCharacterGetView()

	if arg_47_0.viewContainer.fightSuccActView then
		arg_47_0.viewContainer.fightSuccActView:showReward()
	end
end

function var_0_0._showPlayerLevelUpView(arg_48_0)
	local var_48_0 = DungeonModel.instance.curSendEpisodeId
	local var_48_1 = lua_episode.configDict[var_48_0]

	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	local var_48_2 = PlayerModel.instance:getAndResetPlayerLevelUp()

	if var_48_2 > 0 then
		ViewMgr.instance:openView(ViewName.PlayerLevelUpView, var_48_2)
	else
		arg_48_0:_showBonus()
	end
end

function var_0_0._onCloseView(arg_49_0, arg_49_1)
	if arg_49_1 == ViewName.PlayerLevelUpView or arg_49_1 == ViewName.SeasonLevelView then
		arg_49_0:_showBonus()
	end
end

function var_0_0._onClickData(arg_50_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._onClickBackToSource(arg_51_0)
	local var_51_0 = JumpModel.instance:getRecordFarmItem()

	if var_51_0 then
		var_51_0.canBackSource = true
	end

	arg_51_0:closeThis()
	var_0_0.onStoryEnd()
end

function var_0_0.showUnLockCurrentEpisodeNewMode(arg_52_0)
	local var_52_0 = ActivityConfig.instance:getActIdByChapterId(arg_52_0._curChapterId)

	if not var_52_0 then
		return
	end

	local var_52_1 = ActivityConfig.instance:getActivityDungeonConfig(var_52_0)

	if not var_52_1 then
		return
	end

	if var_52_1.story1ChapterId ~= arg_52_0._curChapterId and var_52_1.story2ChapterId ~= arg_52_0._curChapterId then
		return
	end

	if not DungeonModel.instance.curSendEpisodePass then
		return
	end

	local var_52_2 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(lua_episode.configDict[arg_52_0._curEpisodeId])

	if not var_52_2 or #var_52_2 <= 1 then
		return
	end

	local var_52_3 = ActivityConfig.instance:getChapterIdMode(arg_52_0._curChapterId)

	GameFacade.showToast(ToastEnum.UnLockCurrentEpisode, luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[var_52_3 + 1]))
end

function var_0_0._hideGoDemand(arg_53_0)
	gohelper.setActive(arg_53_0._godemand, false)
end

function var_0_0._show1_2DailyEpisodeEndNotice(arg_54_0)
	local var_54_0 = lua_activity116_episode_sp.configDict[arg_54_0._curEpisodeId]

	if var_54_0 then
		ToastController.instance:showToastWithString(var_54_0.endShow)
	end
end

function var_0_0._show1_6EpisodeMaterial(arg_55_0)
	local var_55_0 = lua_episode.configDict[arg_55_0._curEpisodeId]
	local var_55_1 = var_55_0 and var_55_0.type == DungeonEnum.EpisodeType.Act1_6Dungeon
	local var_55_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	if not var_55_1 or not var_55_2 then
		gohelper.setActive(arg_55_0._goPlatConditionMaterial, false)

		return
	end

	gohelper.setActive(arg_55_0._goPlatConditionMaterial, true)

	local var_55_3
	local var_55_4
	local var_55_5
	local var_55_6 = gohelper.findChildImage(arg_55_0._goPlatConditionMaterial, "icon")
	local var_55_7 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local var_55_8 = string.format("%s_1", var_55_7 and var_55_7.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(var_55_6, var_55_8)

	local var_55_9 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local var_55_10 = VersionActivity1_6DungeonSkillModel.instance:getAllSkillPoint()
	local var_55_11 = string.format("<color=#EB5F34>%s</color>/%s", var_55_10 or 0, var_55_9)

	gohelper.findChildText(arg_55_0._goPlatConditionMaterial, "value").text = var_55_11
	gohelper.findChildText(arg_55_0._goPlatConditionMaterial, "condition").text = luaLang("act1_6dungeonFightResultViewMaterialTitle")
end

return var_0_0

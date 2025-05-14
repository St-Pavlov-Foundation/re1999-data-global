module("modules.logic.dungeon.view.rolestory.RoleStoryFightSuccView", package.seeall)

local var_0_0 = class("RoleStoryFightSuccView", BaseView)

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
	arg_1_0._txtSayCn = gohelper.findChildText(arg_1_0.viewGO, "txtSayCn")
	arg_1_0._txtSayEn = gohelper.findChildText(arg_1_0.viewGO, "SayEn/txtSayEn")
	arg_1_0._gocoverrecordpart = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part")
	arg_1_0._btncoverrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cover_record_part/#btn_cover_record")
	arg_1_0._txtcurroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	arg_1_0._txtmaxroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	arg_1_0._goCoverLessThan = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	arg_1_0._goCoverMuchThan = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	arg_1_0._goCoverEqual = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	arg_1_0.txtScore = gohelper.findChildText(arg_1_0.viewGO, "goRoleStorytips/#txt_num")
	arg_1_0.txtScoreAdd = gohelper.findChildText(arg_1_0.viewGO, "goRoleStorytips/#txt_num/#txt_add")
	arg_1_0.gofightgoal = gohelper.findChild(arg_1_0.viewGO, "fightgoal")
	arg_1_0.txtCondition = gohelper.findChildText(arg_1_0.gofightgoal, "condition")
	arg_1_0.txtWave = gohelper.findChildText(arg_1_0.gofightgoal, "count")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnData:AddClickListener(arg_2_0._onClickData, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btncoverrecord, arg_2_0._onBtnCoverRecordClick, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, arg_2_0._onCoverDungeonRecordReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnData:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
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

	arg_4_0._hardMode = var_4_2 and var_4_2.type == DungeonEnum.ChapterType.Hard

	if not var_4_1 or not var_4_1.type then
		local var_4_3 = DungeonEnum.EpisodeType.Normal
	end

	arg_4_0._curEpisodeId = FightResultModel.instance.episodeId
	arg_4_0.hadHighRareProp = false
	arg_4_0._randomEntityMO = arg_4_0:_getRandomEntityMO()

	arg_4_0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	arg_4_0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	local var_4_4 = lua_chapter.configDict[var_4_0:getChapterId()]
	local var_4_5 = lua_episode.configDict[var_4_0:getEpisodeId()]
	local var_4_6 = var_4_4 ~= nil and var_4_5 ~= nil

	gohelper.setActive(arg_4_0._txtFbName.gameObject, var_4_6)
	gohelper.setActive(arg_4_0._txtFbNameEn.gameObject, var_4_6 and GameConfig:GetCurLangType() == LangSettings.zh)

	if var_4_6 then
		arg_4_0:_setFbName(var_4_5)
	end

	arg_4_0:_setSpineVoice()
	NavigateMgr.instance:addEscape(ViewName.RoleStoryFightSuccView, arg_4_0._onClickClose, arg_4_0)

	arg_4_0._canPlayVoice = false

	TaskDispatcher.runDelay(arg_4_0._setCanPlayVoice, arg_4_0, 0.9)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	arg_4_0:_checkNewRecord()
	arg_4_0:_detectCoverRecord()
	arg_4_0:showWave()
	arg_4_0:showScore()
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

function var_0_0._detectCoverRecord(arg_7_0)
	gohelper.setActive(arg_7_0._gocoverrecordpart, FightResultModel.instance.canUpdateDungeonRecord or false)

	if FightResultModel.instance.canUpdateDungeonRecord then
		arg_7_0._txtcurroundcount.text = FightResultModel.instance.newRecordRound or ""
		arg_7_0._txtmaxroundcount.text = FightResultModel.instance.oldRecordRound or ""

		gohelper.setActive(arg_7_0._goCoverLessThan, FightResultModel.instance.newRecordRound < FightResultModel.instance.oldRecordRound)
		gohelper.setActive(arg_7_0._goCoverMuchThan, FightResultModel.instance.newRecordRound > FightResultModel.instance.oldRecordRound)
		gohelper.setActive(arg_7_0._goCoverEqual, FightResultModel.instance.newRecordRound == FightResultModel.instance.oldRecordRound)

		if FightResultModel.instance.newRecordRound >= FightResultModel.instance.oldRecordRound then
			arg_7_0._txtcurroundcount.color = GameUtil.parseColor("#272525")
		else
			arg_7_0._txtcurroundcount.color = GameUtil.parseColor("#AC5320")
		end
	end
end

function var_0_0._onBtnCoverRecordClick(arg_8_0)
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function var_0_0._onCoverDungeonRecordReply(arg_9_0, arg_9_1)
	arg_9_0._hasSendCoverRecord = true

	gohelper.setActive(arg_9_0._gocoverrecordpart, false)

	if arg_9_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function var_0_0._getRandomEntityMO(arg_10_0)
	local var_10_0 = FightDataHelper.entityMgr:getMyNormalList()
	local var_10_1 = FightDataHelper.entityMgr:getMySubList()
	local var_10_2 = FightDataHelper.entityMgr:getMyDeadList()
	local var_10_3 = {}

	tabletool.addValues(var_10_3, var_10_0)
	tabletool.addValues(var_10_3, var_10_1)
	tabletool.addValues(var_10_3, var_10_2)

	for iter_10_0 = #var_10_3, 1, -1 do
		local var_10_4 = var_10_3[iter_10_0]

		if not arg_10_0:_getSkin(var_10_4) then
			table.remove(var_10_3, iter_10_0)
		end
	end

	local var_10_5 = {}

	tabletool.addValues(var_10_5, var_10_3)

	for iter_10_1 = #var_10_5, 1, -1 do
		local var_10_6 = var_10_3[iter_10_1]
		local var_10_7 = FightAudioMgr.instance:_getHeroVoiceCOs(var_10_6.modelId, CharacterEnum.VoiceType.FightResult)

		if var_10_7 and #var_10_7 > 0 then
			if var_10_6:isMonster() then
				table.remove(var_10_5, iter_10_1)
			end
		else
			table.remove(var_10_5, iter_10_1)
		end
	end

	if #var_10_5 > 0 then
		return var_10_5[math.random(#var_10_5)]
	elseif #var_10_3 > 0 then
		return var_10_3[math.random(#var_10_3)]
	else
		logError("没有角色")
	end
end

function var_0_0._checkNewRecord(arg_11_0)
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	elseif OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local var_11_0 = DungeonConfig.instance:getEpisodeCO(arg_11_0._curEpisodeId)
		local var_11_1 = FightModel.instance:getFightParam()
		local var_11_2 = var_11_1 and var_11_1.battleId

		if var_11_0 and var_11_2 and var_11_0.firstBattleId == var_11_2 and not HeroGroupBalanceHelper.getIsBalanceMode() then
			GameFacade.showToast(ToastEnum.CantRecordReplay)
		end
	end
end

function var_0_0._setCanPlayVoice(arg_12_0)
	arg_12_0._canPlayVoice = true

	arg_12_0:_playSpineVoice()
end

function var_0_0._setFbName(arg_13_0, arg_13_1)
	local var_13_0 = DungeonConfig.instance:getNormalEpisodeId(arg_13_1.id)
	local var_13_1 = DungeonConfig.instance:getEpisodeCO(var_13_0)
	local var_13_2 = DungeonConfig.instance:getChapterCO(var_13_1.chapterId)
	local var_13_3, var_13_4 = DungeonConfig.instance:getChapterIndex(var_13_2.type, var_13_1.chapterId)
	local var_13_5, var_13_6 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_13_1.chapterId, var_13_0)

	if arg_13_1.type == DungeonEnum.EpisodeType.Sp then
		local var_13_7 = math.floor(arg_13_1.id % 10000 / 100)

		var_13_5 = arg_13_1.id % 100

		if TeachNoteModel.instance:isTeachNoteEpisode(arg_13_1.id) then
			arg_13_0._txtChapterIndex.text = var_13_2.chapterIndex .. tostring(var_13_7)
		else
			arg_13_0._txtChapterIndex.text = "SP" .. tostring(var_13_7)
		end
	else
		arg_13_0._txtChapterIndex.text = var_13_2.chapterIndex
	end

	arg_13_0._txtFbNameEn.text = arg_13_1.name_En

	arg_13_0:_setEpisodeName(arg_13_1, var_13_5)
	arg_13_0:_setTag(arg_13_1)
end

function var_0_0._setTag(arg_14_0, arg_14_1)
	local var_14_0 = lua_const.configDict[ConstEnum.DungeonSuccessType].value
	local var_14_1 = string.splitToNumber(var_14_0, "#")
	local var_14_2 = tabletool.indexOf(var_14_1, arg_14_1.type)

	gohelper.setActive(arg_14_0._gonormaltag, var_14_2)
	gohelper.setActive(arg_14_0._goroletag, not var_14_2)
end

function var_0_0._setEpisodeName(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1.type == DungeonEnum.EpisodeType.WeekWalk then
		local var_15_0 = FightModel.instance:getFightParam().battleId
		local var_15_1, var_15_2 = WeekWalkModel.instance:getInfo():getNameIndexByBattleId(var_15_0)

		if var_15_2 then
			arg_15_0._txtFbName.text = var_15_1
			arg_15_0._txtEpisodeIndex.text = var_15_2

			return
		end
	elseif arg_15_1.type == DungeonEnum.EpisodeType.Season then
		local var_15_3 = FightModel.instance:getFightParam()
		local var_15_4, var_15_5, var_15_6 = Activity104Model.instance:getSeasonEpisodeDifficultByBattleId(var_15_3.battleId)
		local var_15_7 = SeasonConfig.instance:getSeasonEpisodeConfig(var_15_4, var_15_5)

		arg_15_0._txtgrademark.text = var_15_5 == 1 and luaLang("season_permanent_level_score") or luaLang("season_limit_level_score")
		arg_15_0._txtFbName.text = var_15_7.name
		arg_15_0._txtEpisodeIndex.text = var_15_5

		return
	elseif arg_15_1.type == DungeonEnum.EpisodeType.Dog then
		local var_15_8, var_15_9 = Activity109ChessController.instance:getFightSourceEpisode()

		if var_15_8 and var_15_9 then
			local var_15_10 = Activity109Config.instance:getEpisodeCo(var_15_8, var_15_9)

			if var_15_10 then
				arg_15_0._txtFbName.text = arg_15_1.name
				arg_15_0._txtEpisodeIndex.text = var_15_10.id

				return
			end
		end
	end

	local var_15_11 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_15_1)

	if var_15_11 and #var_15_11 > 1 then
		arg_15_2 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(var_15_11[1].id)
	end

	local var_15_12 = DungeonConfig.instance:getChapterCO(arg_15_1.chapterId)

	if var_15_12 then
		if var_15_12.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or var_15_12.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or var_15_12.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or var_15_12.type == DungeonEnum.ChapterType.Activity1_2DungeonHard then
			arg_15_2 = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(arg_15_1.id)
		end

		if var_15_12.actId == VersionActivity1_3Enum.ActivityId.Dungeon then
			arg_15_2 = VersionActivity1_3DungeonController.instance:getEpisodeIndex(arg_15_1.id)
		end
	end

	arg_15_0._txtFbName.text = arg_15_1.name
	arg_15_0._txtEpisodeIndex.text = arg_15_2
end

function var_0_0._getSkin(arg_16_0, arg_16_1)
	local var_16_0 = FightConfig.instance:getSkinCO(arg_16_1.skin)
	local var_16_1 = var_16_0 and not string.nilorempty(var_16_0.verticalDrawing)
	local var_16_2 = var_16_0 and not string.nilorempty(var_16_0.live2d)

	if var_16_1 or var_16_2 then
		return var_16_0
	end
end

function var_0_0._setSpineVoice(arg_17_0)
	if not arg_17_0._randomEntityMO then
		return
	end

	local var_17_0 = arg_17_0:_getSkin(arg_17_0._randomEntityMO)

	if var_17_0 then
		arg_17_0._spineLoaded = false

		arg_17_0._uiSpine:setImgPos(0)
		arg_17_0._uiSpine:setResPath(var_17_0, function()
			arg_17_0._spineLoaded = true

			arg_17_0._uiSpine:setUIMask(true)
			arg_17_0:_playSpineVoice()
		end, arg_17_0)

		local var_17_1, var_17_2 = SkinConfig.instance:getSkinOffset(var_17_0.fightSuccViewOffset)

		if var_17_2 then
			var_17_1, _ = SkinConfig.instance:getSkinOffset(var_17_0.characterViewOffset)
			var_17_1 = SkinConfig.instance:getAfterRelativeOffset(504, var_17_1)
		end

		local var_17_3 = tonumber(var_17_1[3])
		local var_17_4 = tonumber(var_17_1[1])
		local var_17_5 = tonumber(var_17_1[2])

		recthelper.setAnchor(arg_17_0._gospine.transform, var_17_4, var_17_5)
		transformhelper.setLocalScale(arg_17_0._gospine.transform, var_17_3, var_17_3, var_17_3)
	else
		gohelper.setActive(arg_17_0._gospine, false)
	end
end

function var_0_0._playSpineVoice(arg_19_0)
	if not arg_19_0._canPlayVoice then
		return
	end

	if not arg_19_0._spineLoaded then
		return
	end

	local var_19_0 = HeroModel.instance:getVoiceConfig(arg_19_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, nil, arg_19_0._randomEntityMO.skin) or FightAudioMgr.instance:_getHeroVoiceCOs(arg_19_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, arg_19_0._randomEntityMO.skin)

	if var_19_0 and #var_19_0 > 0 then
		local var_19_1 = var_19_0[1]

		arg_19_0._uiSpine:playVoice(var_19_1, nil, arg_19_0._txtSayCn, arg_19_0._txtSayEn)
	end
end

function var_0_0._getSayContent(arg_20_0, arg_20_1)
	local var_20_0 = GameUtil.splitString2(arg_20_1, false, "|", "#")
	local var_20_1 = ""

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		var_20_1 = var_20_1 .. iter_20_1[1]
	end

	return var_20_1
end

function var_0_0.onCloseFinish(arg_21_0)
	arg_21_0._simagecharacterbg:UnLoadImage()
	arg_21_0._simagemaskImage:UnLoadImage()
	FightStatModel.instance:clear()
	arg_21_0._animEventWrap:RemoveAllEventListener()

	if arg_21_0._farmTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._farmTweenId)
	end
end

function var_0_0._getHeroIconPath(arg_22_0)
	if arg_22_0._randomEntityMO then
		local var_22_0 = FightConfig.instance:getSkinCO(arg_22_0._randomEntityMO.skin)

		if var_22_0 then
			return ResUrl.getHeadIconLarge(var_22_0.largeIcon)
		end
	end
end

function var_0_0._onClickClose(arg_23_0)
	if not arg_23_0._canClick then
		return
	end

	if arg_23_0._uiSpine then
		arg_23_0._uiSpine:stopVoice()
	end

	arg_23_0:closeThis()

	local var_23_0 = FightModel.instance:getAfterStory()

	if var_23_0 > 0 and not StoryModel.instance:isStoryFinished(var_23_0) then
		var_0_0._storyId = var_23_0
		var_0_0._clientFinish = false
		var_0_0._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, var_0_0._finishStoryFromServer)

		local var_23_1 = {}

		var_23_1.mark = true
		var_23_1.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_23_0, var_23_1, function()
			TaskDispatcher.runDelay(var_0_0.onStoryEnd, nil, 3)

			var_0_0._clientFinish = true

			var_0_0.checkStoryEnd()
		end)

		return
	end

	var_0_0.onStoryEnd()
end

function var_0_0._finishStoryFromServer(arg_25_0)
	if var_0_0._storyId == arg_25_0 then
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

function var_0_0.checkRecordFarmItem(arg_28_0, arg_28_1)
	if not arg_28_1 then
		return false
	end

	if arg_28_1.checkFunc then
		return arg_28_1.checkFunc(arg_28_1.checkFuncObj)
	end

	local var_28_0 = ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList())

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		if iter_28_1.materilType == arg_28_1.type and iter_28_1.materilId == arg_28_1.id then
			return true
		end
	end

	if not (arg_28_0 and DungeonConfig.instance:getEpisodeCO(arg_28_0)) then
		return false
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeFirstBonus(arg_28_0), arg_28_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeAdvancedBonus(arg_28_0), arg_28_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeBonus(arg_28_0), arg_28_1) then
		return true
	end

	if var_0_0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeRewardList(arg_28_0), arg_28_1) then
		return true
	end

	return false
end

function var_0_0.checkRecordFarmItemByReward(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0) do
		if tonumber(iter_29_1[1]) == arg_29_1.type and tonumber(iter_29_1[2]) == arg_29_1.id then
			return true
		end
	end

	return false
end

function var_0_0._showCharacterGetView(arg_30_0)
	PopupController.instance:setPause("fightsuccess", false)

	arg_30_0._canClick = true
end

function var_0_0.showWave(arg_31_0)
	local var_31_0 = FightModel.instance:getCurWaveId()
	local var_31_1 = FightModel.instance.maxWave

	arg_31_0.txtCondition.text = luaLang("dungeon_beat_all")

	local var_31_2 = FightDataHelper.entityMgr:getEnemyNormalList()

	if var_31_2 and #var_31_2 > 0 then
		var_31_0 = var_31_0 - 1
	end

	arg_31_0.txtWave.text = string.format("<color=#E57937>%s</color>/%s", var_31_0, var_31_1)
end

function var_0_0.showScore(arg_32_0)
	local var_32_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_32_1 = RoleStoryModel.instance:getById(var_32_0)
	local var_32_2 = var_32_1 and var_32_1:getScore() or 0
	local var_32_3 = var_32_1 and var_32_1:getAddScore() or 0

	arg_32_0.txtScore.text = var_32_2
	arg_32_0.txtScoreAdd.text = string.format("(+%s)", var_32_3)

	arg_32_0:_onAllTweenFinish()
end

function var_0_0._onAllTweenFinish(arg_33_0)
	arg_33_0:_showCharacterGetView()
end

function var_0_0._onClickData(arg_34_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

return var_0_0

module("modules.logic.dungeon.view.rolestory.RoleStoryFightSuccView", package.seeall)

slot0 = class("RoleStoryFightSuccView", BaseView)

function slot0.onInitView(slot0)
	slot0._click = gohelper.getClick(slot0.viewGO)
	slot0._btnData = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnData")
	slot0._simagecharacterbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_characterbg")
	slot0._simagemaskImage = gohelper.findChildSingleImage(slot0.viewGO, "#simage_maskImage")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "spineContainer/spine")
	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)
	slot0._txtFbNameEn = gohelper.findChildText(slot0.viewGO, "txtFbNameen")

	slot0._uiSpine:useRT()

	slot0._txtFbName = gohelper.findChildText(slot0.viewGO, "txtFbName")
	slot0._txtChapterIndex = gohelper.findChildText(slot0.viewGO, "txtFbName/#go_normaltag/section")
	slot0._txtEpisodeIndex = gohelper.findChildText(slot0.viewGO, "txtFbName/#go_normaltag/unit")
	slot0._gonormaltag = gohelper.findChild(slot0.viewGO, "txtFbName/#go_normaltag")
	slot0._goroletag = gohelper.findChild(slot0.viewGO, "txtFbName/#go_roletag")
	slot0._txtSayCn = gohelper.findChildText(slot0.viewGO, "txtSayCn")
	slot0._txtSayEn = gohelper.findChildText(slot0.viewGO, "SayEn/txtSayEn")
	slot0._gocoverrecordpart = gohelper.findChild(slot0.viewGO, "#go_cover_record_part")
	slot0._btncoverrecord = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cover_record_part/#btn_cover_record")
	slot0._txtcurroundcount = gohelper.findChildText(slot0.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	slot0._txtmaxroundcount = gohelper.findChildText(slot0.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	slot0._goCoverLessThan = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	slot0._goCoverMuchThan = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	slot0._goCoverEqual = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	slot0.txtScore = gohelper.findChildText(slot0.viewGO, "goRoleStorytips/#txt_num")
	slot0.txtScoreAdd = gohelper.findChildText(slot0.viewGO, "goRoleStorytips/#txt_num/#txt_add")
	slot0.gofightgoal = gohelper.findChild(slot0.viewGO, "fightgoal")
	slot0.txtCondition = gohelper.findChildText(slot0.gofightgoal, "condition")
	slot0.txtWave = gohelper.findChildText(slot0.gofightgoal, "count")
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0._onClickClose, slot0)
	slot0._btnData:AddClickListener(slot0._onClickData, slot0)
	slot0:addClickCb(slot0._btncoverrecord, slot0._onBtnCoverRecordClick, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, slot0._onCoverDungeonRecordReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._btnData:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0._canClick = false
	slot0._animation = slot0.viewGO:GetComponent(typeof(UnityEngine.Animation))

	slot0._animation:Play("fightsucc_in", UnityEngine.PlayMode.StopAll)
	slot0._animation:PlayQueued("fightsucc_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)

	slot0._animEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	FightController.instance:checkFightQuitTipViewClose()
	gohelper.setActive(slot0._bonusItemGo, false)

	slot0._curEpisodeId = DungeonModel.instance.curSendEpisodeId
	slot0._curChapterId = DungeonModel.instance.curSendChapterId
	slot1 = FightResultModel.instance
	slot2 = lua_episode.configDict[slot0._curEpisodeId]
	slot0._hardMode = DungeonConfig.instance:getChapterCO(slot0._curChapterId) and slot3.type == DungeonEnum.ChapterType.Hard
	slot4 = slot2 and slot2.type or DungeonEnum.EpisodeType.Normal
	slot0._curEpisodeId = FightResultModel.instance.episodeId
	slot0.hadHighRareProp = false
	slot0._randomEntityMO = slot0:_getRandomEntityMO()

	slot0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	slot0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	slot7 = lua_chapter.configDict[slot1:getChapterId()] ~= nil and lua_episode.configDict[slot1:getEpisodeId()] ~= nil

	gohelper.setActive(slot0._txtFbName.gameObject, slot7)
	gohelper.setActive(slot0._txtFbNameEn.gameObject, slot7 and GameConfig:GetCurLangType() == LangSettings.zh)

	if slot7 then
		slot0:_setFbName(slot6)
	end

	slot0:_setSpineVoice()
	NavigateMgr.instance:addEscape(ViewName.RoleStoryFightSuccView, slot0._onClickClose, slot0)

	slot0._canPlayVoice = false

	TaskDispatcher.runDelay(slot0._setCanPlayVoice, slot0, 0.9)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	slot0:_checkNewRecord()
	slot0:_detectCoverRecord()
	slot0:showWave()
	slot0:showScore()
end

function slot0._showPlatCondition(slot0, slot1, slot2, slot3, slot4)
	if string.nilorempty(slot1) then
		gohelper.setActive(slot2, false)
	else
		gohelper.setActive(slot2, true)

		if slot4 > (tonumber(FightResultModel.instance.star) or 0) then
			gohelper.findChildText(slot2, "condition").text = gohelper.getRichColorText(slot1, "#6C6C6B")
		else
			gohelper.findChildText(slot2, "condition").text = gohelper.getRichColorText(slot1, "#C4C0BD")
		end

		slot6 = gohelper.findChildImage(slot2, "star")
		slot7 = "#87898C"

		if slot4 <= slot5 then
			slot7 = slot0._hardMode and "#FF4343" or "#F77040"
		end

		UISpriteSetMgr.instance:setCommonSprite(slot6, slot3, true)
		SLFramework.UGUI.GuiHelper.SetColor(slot6, slot7)
	end
end

function slot0.onClose(slot0)
	slot0._canPlayVoice = false

	TaskDispatcher.cancelTask(slot0._setCanPlayVoice, slot0)
	gohelper.setActive(slot0._gospine, false)

	if FightResultModel.instance.canUpdateDungeonRecord and not slot0._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end
end

function slot0._detectCoverRecord(slot0)
	gohelper.setActive(slot0._gocoverrecordpart, FightResultModel.instance.canUpdateDungeonRecord or false)

	if FightResultModel.instance.canUpdateDungeonRecord then
		slot0._txtcurroundcount.text = FightResultModel.instance.newRecordRound or ""
		slot0._txtmaxroundcount.text = FightResultModel.instance.oldRecordRound or ""

		gohelper.setActive(slot0._goCoverLessThan, FightResultModel.instance.newRecordRound < FightResultModel.instance.oldRecordRound)
		gohelper.setActive(slot0._goCoverMuchThan, FightResultModel.instance.oldRecordRound < FightResultModel.instance.newRecordRound)
		gohelper.setActive(slot0._goCoverEqual, FightResultModel.instance.newRecordRound == FightResultModel.instance.oldRecordRound)

		if FightResultModel.instance.oldRecordRound <= FightResultModel.instance.newRecordRound then
			slot0._txtcurroundcount.color = GameUtil.parseColor("#272525")
		else
			slot0._txtcurroundcount.color = GameUtil.parseColor("#AC5320")
		end
	end
end

function slot0._onBtnCoverRecordClick(slot0)
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function slot0._onCoverDungeonRecordReply(slot0, slot1)
	slot0._hasSendCoverRecord = true

	gohelper.setActive(slot0._gocoverrecordpart, false)

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function slot0._getRandomEntityMO(slot0)
	slot4 = {}

	tabletool.addValues(slot4, FightDataHelper.entityMgr:getMyNormalList())
	tabletool.addValues(slot4, FightDataHelper.entityMgr:getMySubList())
	tabletool.addValues(slot4, FightDataHelper.entityMgr:getMyDeadList())

	for slot8 = #slot4, 1, -1 do
		if not slot0:_getSkin(slot4[slot8]) then
			table.remove(slot4, slot8)
		end
	end

	slot5 = {}

	tabletool.addValues(slot5, slot4)

	for slot9 = #slot5, 1, -1 do
		if FightAudioMgr.instance:_getHeroVoiceCOs(slot4[slot9].modelId, CharacterEnum.VoiceType.FightResult) and #slot11 > 0 then
			if slot10:isMonster() then
				table.remove(slot5, slot9)
			end
		else
			table.remove(slot5, slot9)
		end
	end

	if #slot5 > 0 then
		return slot5[math.random(#slot5)]
	elseif #slot4 > 0 then
		return slot4[math.random(#slot4)]
	else
		logError("没有角色")
	end
end

function slot0._checkNewRecord(slot0)
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	elseif OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		slot3 = FightModel.instance:getFightParam() and slot2.battleId

		if DungeonConfig.instance:getEpisodeCO(slot0._curEpisodeId) and slot3 and slot1.firstBattleId == slot3 and not HeroGroupBalanceHelper.getIsBalanceMode() then
			GameFacade.showToast(ToastEnum.CantRecordReplay)
		end
	end
end

function slot0._setCanPlayVoice(slot0)
	slot0._canPlayVoice = true

	slot0:_playSpineVoice()
end

function slot0._setFbName(slot0, slot1)
	slot2 = DungeonConfig.instance:getNormalEpisodeId(slot1.id)
	slot3 = DungeonConfig.instance:getEpisodeCO(slot2)
	slot5, slot6 = DungeonConfig.instance:getChapterIndex(DungeonConfig.instance:getChapterCO(slot3.chapterId).type, slot3.chapterId)
	slot7, slot8 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot3.chapterId, slot2)

	if slot1.type == DungeonEnum.EpisodeType.Sp then
		slot7 = slot1.id % 100

		if TeachNoteModel.instance:isTeachNoteEpisode(slot1.id) then
			slot0._txtChapterIndex.text = slot4.chapterIndex .. tostring(math.floor(slot1.id % 10000 / 100))
		else
			slot0._txtChapterIndex.text = "SP" .. tostring(slot9)
		end
	else
		slot0._txtChapterIndex.text = slot4.chapterIndex
	end

	slot0._txtFbNameEn.text = slot1.name_En

	slot0:_setEpisodeName(slot1, slot7)
	slot0:_setTag(slot1)
end

function slot0._setTag(slot0, slot1)
	slot4 = tabletool.indexOf(string.splitToNumber(lua_const.configDict[ConstEnum.DungeonSuccessType].value, "#"), slot1.type)

	gohelper.setActive(slot0._gonormaltag, slot4)
	gohelper.setActive(slot0._goroletag, not slot4)
end

function slot0._setEpisodeName(slot0, slot1, slot2)
	if slot1.type == DungeonEnum.EpisodeType.WeekWalk then
		slot0._txtFbName.text, slot7 = WeekWalkModel.instance:getInfo():getNameIndexByBattleId(FightModel.instance:getFightParam().battleId)

		if slot7 then
			slot0._txtEpisodeIndex.text = slot7

			return
		end
	elseif slot1.type == DungeonEnum.EpisodeType.Season then
		slot4, slot5, slot6 = Activity104Model.instance:getSeasonEpisodeDifficultByBattleId(FightModel.instance:getFightParam().battleId)
		slot0._txtgrademark.text = slot5 == 1 and luaLang("season_permanent_level_score") or luaLang("season_limit_level_score")
		slot0._txtFbName.text = SeasonConfig.instance:getSeasonEpisodeConfig(slot4, slot5).name
		slot0._txtEpisodeIndex.text = slot5

		return
	elseif slot1.type == DungeonEnum.EpisodeType.Dog then
		slot3, slot4 = Activity109ChessController.instance:getFightSourceEpisode()

		if slot3 and slot4 and Activity109Config.instance:getEpisodeCo(slot3, slot4) then
			slot0._txtFbName.text = slot1.name
			slot0._txtEpisodeIndex.text = slot5.id

			return
		end
	end

	if DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(slot1) and #slot3 > 1 then
		slot2 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot3[1].id)
	end

	if DungeonConfig.instance:getChapterCO(slot1.chapterId) then
		if slot4.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or slot4.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or slot4.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or slot4.type == DungeonEnum.ChapterType.Activity1_2DungeonHard then
			slot2 = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(slot1.id)
		end

		if slot4.actId == VersionActivity1_3Enum.ActivityId.Dungeon then
			slot2 = VersionActivity1_3DungeonController.instance:getEpisodeIndex(slot1.id)
		end
	end

	slot0._txtFbName.text = slot1.name
	slot0._txtEpisodeIndex.text = slot2
end

function slot0._getSkin(slot0, slot1)
	if FightConfig.instance:getSkinCO(slot1.skin) and not string.nilorempty(slot2.verticalDrawing) or slot2 and not string.nilorempty(slot2.live2d) then
		return slot2
	end
end

function slot0._setSpineVoice(slot0)
	if not slot0._randomEntityMO then
		return
	end

	if slot0:_getSkin(slot0._randomEntityMO) then
		slot0._spineLoaded = false

		slot0._uiSpine:setImgPos(0)
		slot0._uiSpine:setResPath(slot1, function ()
			uv0._spineLoaded = true

			uv0._uiSpine:setUIMask(true)
			uv0:_playSpineVoice()
		end, slot0)

		slot2, slot3 = SkinConfig.instance:getSkinOffset(slot1.fightSuccViewOffset)

		if slot3 then
			slot4, _ = SkinConfig.instance:getSkinOffset(slot1.characterViewOffset)
			slot2 = SkinConfig.instance:getAfterRelativeOffset(504, slot4)
		end

		slot4 = tonumber(slot2[3])

		recthelper.setAnchor(slot0._gospine.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._gospine.transform, slot4, slot4, slot4)
	else
		gohelper.setActive(slot0._gospine, false)
	end
end

function slot0._playSpineVoice(slot0)
	if not slot0._canPlayVoice then
		return
	end

	if not slot0._spineLoaded then
		return
	end

	if (HeroModel.instance:getVoiceConfig(slot0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, nil, slot0._randomEntityMO.skin) or FightAudioMgr.instance:_getHeroVoiceCOs(slot0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, slot0._randomEntityMO.skin)) and #slot1 > 0 then
		slot0._uiSpine:playVoice(slot1[1], nil, slot0._txtSayCn, slot0._txtSayEn)
	end
end

function slot0._getSayContent(slot0, slot1)
	for slot7, slot8 in ipairs(GameUtil.splitString2(slot1, false, "|", "#")) do
		slot3 = "" .. slot8[1]
	end

	return slot3
end

function slot0.onCloseFinish(slot0)
	slot0._simagecharacterbg:UnLoadImage()
	slot0._simagemaskImage:UnLoadImage()
	FightStatModel.instance:clear()
	slot0._animEventWrap:RemoveAllEventListener()

	if slot0._farmTweenId then
		ZProj.TweenHelper.KillById(slot0._farmTweenId)
	end
end

function slot0._getHeroIconPath(slot0)
	if slot0._randomEntityMO and FightConfig.instance:getSkinCO(slot0._randomEntityMO.skin) then
		return ResUrl.getHeadIconLarge(slot1.largeIcon)
	end
end

function slot0._onClickClose(slot0)
	if not slot0._canClick then
		return
	end

	if slot0._uiSpine then
		slot0._uiSpine:stopVoice()
	end

	slot0:closeThis()

	if FightModel.instance:getAfterStory() > 0 and not StoryModel.instance:isStoryFinished(slot1) then
		uv0._storyId = slot1
		uv0._clientFinish = false
		uv0._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, uv0._finishStoryFromServer)
		StoryController.instance:playStory(slot1, {
			mark = true,
			episodeId = DungeonModel.instance.curSendEpisodeId
		}, function ()
			TaskDispatcher.runDelay(uv0.onStoryEnd, nil, 3)

			uv0._clientFinish = true

			uv0.checkStoryEnd()
		end)

		return
	end

	uv0.onStoryEnd()
end

function slot0._finishStoryFromServer(slot0)
	if uv0._storyId == slot0 then
		uv0._serverFinish = true

		uv0.checkStoryEnd()
	end
end

function slot0.checkStoryEnd()
	if uv0._clientFinish and uv0._serverFinish then
		uv0.onStoryEnd()
	end
end

function slot0.onStoryEnd()
	uv0._storyId = nil
	uv0._clientFinish = false
	uv0._serverFinish = false

	TaskDispatcher.cancelTask(uv0.onStoryEnd, nil)
	StoryController.instance:unregisterCallback(StoryEvent.FinishFromServer, uv0._finishStoryFromServer)
	FightController.onResultViewClose()
end

function slot0.checkRecordFarmItem(slot0, slot1)
	if not slot1 then
		return false
	end

	if slot1.checkFunc then
		return slot1.checkFunc(slot1.checkFuncObj)
	end

	for slot6, slot7 in ipairs(ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList())) do
		if slot7.materilType == slot1.type and slot7.materilId == slot1.id then
			return true
		end
	end

	if not (slot0 and DungeonConfig.instance:getEpisodeCO(slot0)) then
		return false
	end

	if uv0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeFirstBonus(slot0), slot1) then
		return true
	end

	if uv0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeAdvancedBonus(slot0), slot1) then
		return true
	end

	if uv0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeBonus(slot0), slot1) then
		return true
	end

	if uv0.checkRecordFarmItemByReward(DungeonModel.instance:getEpisodeRewardList(slot0), slot1) then
		return true
	end

	return false
end

function slot0.checkRecordFarmItemByReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot0) do
		if tonumber(slot6[1]) == slot1.type and tonumber(slot6[2]) == slot1.id then
			return true
		end
	end

	return false
end

function slot0._showCharacterGetView(slot0)
	PopupController.instance:setPause("fightsuccess", false)

	slot0._canClick = true
end

function slot0.showWave(slot0)
	slot2 = FightModel.instance.maxWave
	slot0.txtCondition.text = luaLang("dungeon_beat_all")

	if FightDataHelper.entityMgr:getEnemyNormalList() and #slot3 > 0 then
		slot1 = FightModel.instance:getCurWaveId() - 1
	end

	slot0.txtWave.text = string.format("<color=#E57937>%s</color>/%s", slot1, slot2)
end

function slot0.showScore(slot0)
	slot0.txtScore.text = RoleStoryModel.instance:getById(RoleStoryModel.instance:getCurActStoryId()) and slot2:getScore() or 0
	slot0.txtScoreAdd.text = string.format("(+%s)", slot2 and slot2:getAddScore() or 0)

	slot0:_onAllTweenFinish()
end

function slot0._onAllTweenFinish(slot0)
	slot0:_showCharacterGetView()
end

function slot0._onClickData(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

return slot0

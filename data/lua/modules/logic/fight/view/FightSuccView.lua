module("modules.logic.fight.view.FightSuccView", package.seeall)

slot0 = class("FightSuccView", BaseView)

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
	slot0._txtLv = gohelper.findChildText(slot0.viewGO, "goalcontent/txtLv")
	slot0._txtExp = gohelper.findChildText(slot0.viewGO, "goalcontent/txtLv/txtExp")
	slot0._txtAddExp = gohelper.findChildText(slot0.viewGO, "goalcontent/txtLv/progress/txtAddExp")
	slot0._sliderExp = gohelper.findChildSlider(slot0.viewGO, "goalcontent/txtLv/progress")
	slot0._txtSayCn = gohelper.findChildText(slot0.viewGO, "txtSayCn")
	slot0._txtSayEn = gohelper.findChildText(slot0.viewGO, "SayEn/txtSayEn")
	slot0._favorIcon = gohelper.findChild(slot0.viewGO, "scroll/viewport/content/favor")
	slot0._goCondition = gohelper.findChild(slot0.viewGO, "goalcontent/goallist/fightgoal")
	slot0._goPlatCondition = gohelper.findChild(slot0.viewGO, "goalcontent/goallist/platinum")
	slot0._goPlatCondition2 = gohelper.findChild(slot0.viewGO, "goalcontent/goallist/platinum2")
	slot0._goPlatConditionMaterial = gohelper.findChild(slot0.viewGO, "goalcontent/goallist/platinumMaterial")
	slot0._bonusItemContainer = gohelper.findChild(slot0.viewGO, "scroll/viewport/content")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "scroll")
	slot0._bonusItemGo = gohelper.findChild(slot0.viewGO, "scroll/item")
	slot0._godemand = gohelper.findChild(slot0.viewGO, "#go_demand")
	slot0._txtdemand = gohelper.findChildText(slot0.viewGO, "#go_demand/#txt_demand")
	slot0._btnbacktosource = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_demand/#btn_backToSource")
	slot0._gocoverrecordpart = gohelper.findChild(slot0.viewGO, "#go_cover_record_part")
	slot0._btncoverrecord = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cover_record_part/#btn_cover_record")
	slot0._txtcurroundcount = gohelper.findChildText(slot0.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	slot0._txtmaxroundcount = gohelper.findChildText(slot0.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	slot0._goCoverLessThan = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	slot0._goCoverMuchThan = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	slot0._goCoverEqual = gohelper.findChild(slot0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	slot0._godetails = gohelper.findChild(slot0.viewGO, "#go_details")
	slot0._gogoallist = gohelper.findChild(slot0.viewGO, "goalcontent/goallist")
	slot0._goseason = gohelper.findChild(slot0.viewGO, "#go_season")
	slot0._txtseasongrade = gohelper.findChildText(slot0.viewGO, "#go_season/grade/#txt_grade")
	slot0._txtseasonlevel = gohelper.findChildText(slot0.viewGO, "#go_season/level/#txt_level")
	slot0._imagegradeicon = gohelper.findChildImage(slot0.viewGO, "#go_season/level/#image_gradeicon")
	slot0._txtgrademark = gohelper.findChildText(slot0.viewGO, "#go_season/grade/grade")
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0._onClickClose, slot0)
	slot0._btnData:AddClickListener(slot0._onClickData, slot0)
	slot0._btnbacktosource:AddClickListener(slot0._onClickBackToSource, slot0)
	slot0:addClickCb(slot0._btncoverrecord, slot0._onBtnCoverRecordClick, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, slot0._onCoverDungeonRecordReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._btnData:RemoveClickListener()
	slot0._btnbacktosource:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)

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
	slot4 = DungeonConfig.instance:getChapterCO(slot0._curChapterId) and slot3.type or DungeonEnum.ChapterType.Normal
	slot0._normalMode = slot4 == DungeonEnum.ChapterType.Normal
	slot0._hardMode = slot4 == DungeonEnum.ChapterType.Hard
	slot0._simpleMode = slot4 == DungeonEnum.ChapterType.Simple
	slot5 = slot2 and slot2.type or DungeonEnum.EpisodeType.Normal
	slot0._curEpisodeId = FightResultModel.instance.episodeId
	slot0.hadHighRareProp = false

	slot0:_loadBonusItems()
	slot0:_hideGoDemand()

	slot7 = DungeonConfig.instance:getEpisodeAdvancedConditionText(slot0._curEpisodeId, FightModel.instance:getBattleId())
	slot8 = slot0._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

	if string.nilorempty(DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())) then
		gohelper.setActive(slot0._goCondition, false)
	else
		gohelper.findChildText(slot0._goCondition, "condition").text = slot6
		slot9 = gohelper.findChildImage(slot0._goCondition, "star")

		UISpriteSetMgr.instance:setCommonSprite(slot9, slot8, true)
		SLFramework.UGUI.GuiHelper.SetColor(slot9, slot0._hardMode and "#FF4343" or "#F77040")
	end

	if slot3 and slot3.type == DungeonEnum.ChapterType.Simple then
		gohelper.setActive(slot0._goPlatCondition, false)
	else
		slot0:_showPlatCondition(slot7, slot0._goPlatCondition, slot8, DungeonEnum.StarType.Advanced)
	end

	slot0:_showPlatCondition(DungeonConfig.instance:getEpisodeAdvancedCondition2Text(slot0._curEpisodeId, FightModel.instance:getBattleId()), slot0._goPlatCondition2, slot8, DungeonEnum.StarType.Ultra)

	slot0._randomEntityMO = slot0:_getRandomEntityMO()

	slot0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	slot0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	slot11 = lua_chapter.configDict[slot1:getChapterId()] ~= nil and lua_episode.configDict[slot1:getEpisodeId()] ~= nil

	gohelper.setActive(slot0._txtFbName.gameObject, slot11)
	gohelper.setActive(slot0._txtFbNameEn.gameObject, slot11 and GameConfig:GetCurLangType() == LangSettings.zh)

	if slot11 then
		slot0:_setFbName(slot10)
	end

	slot13 = PlayerModel.instance:getExpNowAndMax()
	slot0._txtLv.text = "<size=36>Lv </size>" .. PlayerModel.instance:getPlayerLevel()

	slot0._sliderExp:SetValue(slot13[1] / slot13[2])

	slot0._txtExp.text = slot13[1] .. "/" .. slot13[2]

	if slot1:getPlayerExp() and slot14 > 0 then
		gohelper.setActive(slot0._txtAddExp.gameObject, true)

		slot0._txtAddExp.text = "EXP+" .. slot14
	else
		gohelper.setActive(slot0._txtAddExp.gameObject, false)
	end

	slot0:_setSpineVoice()
	NavigateMgr.instance:addEscape(ViewName.FightSuccView, slot0._onClickClose, slot0)

	slot0._canPlayVoice = false

	TaskDispatcher.runDelay(slot0._setCanPlayVoice, slot0, 0.9)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	slot0:_checkNewRecord()
	slot0:_detectCoverRecord()
	slot0:_checkTypeDetails()
	slot0:showUnLockCurrentEpisodeNewMode()
	slot0:_show1_2DailyEpisodeEndNotice()
	slot0:_show1_6EpisodeMaterial()
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

function slot0._checkTypeDetails(slot0)
	if not (lua_episode.configDict[slot0._curEpisodeId] and slot1.type == DungeonEnum.EpisodeType.Season) then
		return
	end

	gohelper.setActive(slot0._goseason, true)
	gohelper.setActive(slot0._txtLv.gameObject, false)
	gohelper.setActive(slot0._goscroll, false)
	gohelper.setActive(slot0._gogoallist, false)

	slot3 = Activity104Model.instance:getNewUnlockInfo()

	gohelper.setActive(slot0._txtseasonlevel.gameObject, false)
	UISpriteSetMgr.instance:setSeasonSprite(slot0._imagegradeicon, "sjwf_nandudengji_" .. tostring(Activity104Model.instance:getEpisodeLv(slot3.score)))

	slot0._txtseasongrade.text = slot3.score
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

	tabletool.addValues(slot4, FightEntityModel.instance:getMySideList())
	tabletool.addValues(slot4, FightEntityModel.instance:getSubModel(FightEnum.EntitySide.MySide):getList())
	tabletool.addValues(slot4, FightEntityModel.instance:getDeadModel(FightEnum.EntitySide.MySide):getList())

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
		elseif slot4.id == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
			slot0._txtChapterIndex.text = slot4.chapterIndex
		else
			slot0._txtChapterIndex.text = "SP" .. tostring(slot9)
		end
	else
		slot0._txtChapterIndex.text = slot4.chapterIndex
	end

	slot0:_setEpisodeName(slot1, slot7, slot3)
	slot0:_setTag(slot1)
end

function slot0._setTag(slot0, slot1)
	slot4 = tabletool.indexOf(string.splitToNumber(lua_const.configDict[ConstEnum.DungeonSuccessType].value, "#"), slot1.type)

	gohelper.setActive(slot0._gonormaltag, slot4)
	gohelper.setActive(slot0._goroletag, not slot4)
end

function slot0._setEpisodeName(slot0, slot1, slot2, slot3)
	if slot1.type == DungeonEnum.EpisodeType.WeekWalk then
		slot0._txtFbName.text, slot8 = WeekWalkModel.instance:getInfo():getNameIndexByBattleId(FightModel.instance:getFightParam().battleId)

		if slot8 then
			slot0._txtEpisodeIndex.text = slot8

			return
		end
	elseif slot1.type == DungeonEnum.EpisodeType.Season then
		slot5, slot6, slot7 = Activity104Model.instance:getSeasonEpisodeDifficultByBattleId(FightModel.instance:getFightParam().battleId)
		slot0._txtgrademark.text = slot6 == 1 and luaLang("season_permanent_level_score") or luaLang("season_limit_level_score")
		slot0._txtFbName.text = SeasonConfig.instance:getSeasonEpisodeConfig(slot5, slot6).name
		slot0._txtEpisodeIndex.text = slot6

		return
	elseif slot1.type == DungeonEnum.EpisodeType.Dog then
		slot4, slot5 = Activity109ChessController.instance:getFightSourceEpisode()

		if slot4 and slot5 and Activity109Config.instance:getEpisodeCo(slot4, slot5) then
			slot0._txtFbName.text = slot1.name
			slot0._txtEpisodeIndex.text = slot6.id

			return
		end
	end

	if DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(slot1) and #slot4 > 1 then
		slot2 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot4[1].id)
	end

	if DungeonConfig.instance:getChapterCO(slot1.chapterId) then
		if slot5.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or slot5.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or slot5.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or slot5.type == DungeonEnum.ChapterType.Activity1_2DungeonHard then
			slot2 = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(slot1.id)
		end

		if slot5.actId == VersionActivity1_3Enum.ActivityId.Dungeon then
			slot2 = VersionActivity1_3DungeonController.instance:getEpisodeIndex(slot1.id)
		end

		if slot5.actId == VersionActivity1_5Enum.ActivityId.Dungeon then
			slot2 = VersionActivity1_5DungeonController.instance:getEpisodeIndex(slot1.id)
		elseif slot5.actId == VersionActivity1_6Enum.ActivityId.Dungeon then
			slot2 = VersionActivity1_6DungeonController.instance:getEpisodeIndex(slot1.id)
		elseif slot5.actId == VersionActivity1_8Enum.ActivityId.Dungeon then
			slot2 = VersionActivity1_8DungeonConfig.instance:getEpisodeIndex(slot1.id)
		elseif slot5.actId == VersionActivity2_0Enum.ActivityId.Dungeon then
			slot2 = VersionActivity2_0DungeonConfig.instance:getEpisodeIndex(slot1.id)
		elseif slot5.actId == VersionActivity2_1Enum.ActivityId.Dungeon then
			slot2 = VersionActivity2_1DungeonConfig.instance:getEpisodeIndex(slot1.id)
		end
	end

	if slot1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard then
		slot2 = DungeonConfig.instance:getEpisodeLevelIndex(slot1)
	end

	slot0._txtFbName.text = slot3.name
	slot0._txtFbNameEn.text = slot3.name_En
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
			uv0._uiSpine:setAllLayer(UnityLayer.UI)
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

	if FightModel.instance:getAfterStory() > 0 and (DungeonConfig.instance:getChapterCO(slot0._curChapterId).type == DungeonEnum.ChapterType.RoleStory or not StoryModel.instance:isStoryFinished(slot1)) then
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

function slot0._loadBonusItems(slot0)
	slot0._firstBonusGOList = slot0:getUserDataTb_()
	slot0._additionBonusGOList = slot0:getUserDataTb_()
	slot0._additionContainerGODict = slot0:getUserDataTb_()
	slot0._bonusGOList = slot0:getUserDataTb_()
	slot0._moveBonusGOList = slot0:getUserDataTb_()
	slot0._extraBonusGOList = slot0:getUserDataTb_()
	slot0._containerGODict = slot0:getUserDataTb_()
	slot0._extraContainerGODict = slot0:getUserDataTb_()
	slot0._delayTime = 0.06
	slot0._itemDelay = 0.5

	if (slot0._curEpisodeId and tonumber(DungeonConfig.instance:getEndBattleCost(slot0._curEpisodeId)) or 0) and slot1 > 0 then
		table.insert(slot0._bonusGOList, slot0._favorIcon)
	end

	gohelper.setActive(slot0._favorIcon, false)

	slot0._favorIcon:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	if ItemModel.instance:processRPCItemList(FightResultModel.instance:getTimeFirstMaterialDataList()) then
		for slot8, slot9 in ipairs(LuaUtil.deepCopy(slot3)) do
			slot0:_addFirstItem(slot9)
		end

		slot0:checkHadHighRareProp(slot4)
	end

	if ItemModel.instance:processRPCItemList(FightResultModel.instance:getFirstMaterialDataList()) then
		for slot8, slot9 in ipairs(LuaUtil.deepCopy(slot3)) do
			slot0:_addFirstItem(slot9)
		end

		slot0:checkHadHighRareProp(slot4)
	end

	if ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct155MaterialDataList()) then
		for slot8, slot9 in ipairs(LuaUtil.deepCopy(slot3)) do
			if slot9.materilType == MaterialEnum.MaterialType.Currency and slot9.materilId == CurrencyEnum.CurrencyType.V1a9Dungeon then
				slot0:_addFirstItem(slot9, slot0.onRefreshV1a7Currency)
			elseif slot9.materilType == MaterialEnum.MaterialType.PowerPotion and slot9.materilId == MaterialEnum.PowerId.ActPowerId then
				slot0:_addFirstItem(slot9, slot0.onRefreshV1a7Power)
			elseif slot9.materilType == MaterialEnum.MaterialType.Currency and slot9.materilId == CurrencyEnum.CurrencyType.V1a9ToughEnter then
				slot0:_addFirstItem(slot9, slot0.onRefreshToughBattle)
			elseif slot9.materilType == MaterialEnum.MaterialType.Currency and slot9.materilId == CurrencyEnum.CurrencyType.V2a2Dungeon then
				slot0:_addFirstItem(slot9, slot0.onRefreshV2a2Dungeon)
			else
				slot0:_addFirstItem(slot9)
			end
		end

		slot0:checkHadHighRareProp(slot4)
	end

	if ItemModel.instance:processRPCItemList(FightResultModel.instance:getAct153MaterialDataList()) then
		for slot8, slot9 in ipairs(LuaUtil.deepCopy(slot3)) do
			slot0:_addAdditionItem(slot9)
		end

		slot0:checkHadHighRareProp(slot4)

		if #slot4 > 0 then
			slot5, slot6 = DoubleDropModel.instance:getDailyRemainTimes()

			if slot5 and slot6 then
				GameFacade.showToast(ToastEnum.DoubleDropTips, slot5, slot6)
			end
		end
	end

	if ItemModel.instance:processRPCItemList(FightResultModel.instance:getAdditionMaterialDataList()) then
		for slot8, slot9 in ipairs(LuaUtil.deepCopy(slot3)) do
			slot0:_addAdditionItem(slot9)
		end

		slot0:checkHadHighRareProp(slot4)
	end

	if FightModel.instance:isEnterUseFreeLimit() and FightResultModel.instance:getExtraMaterialDataList() then
		for slot9, slot10 in ipairs(LuaUtil.deepCopy(ItemModel.instance:processRPCItemList(slot4))) do
			slot10.bonusTag = FightEnum.FightBonusTag.EquipDailyFreeBonus

			slot0:_addExtraItem(slot10)
		end

		slot0:checkHadHighRareProp(slot5)
	end

	if ItemModel.instance:processRPCItemList(FightResultModel.instance:getNormal2SimpleMaterialDataList()) then
		for slot8, slot9 in ipairs(LuaUtil.deepCopy(slot3)) do
			slot0:_addFirstItem(slot9)
		end

		slot0:checkHadHighRareProp(slot4)
	end

	if ItemModel.instance:processRPCItemList(FightResultModel.instance:getMaterialDataList()) then
		for slot8, slot9 in ipairs(LuaUtil.deepCopy(slot3)) do
			slot0:_addNormalItem(slot9)
		end

		slot0:checkHadHighRareProp(slot4)
	end

	slot0._animEventWrap:AddEventListener("bonus", slot0._showPlayerLevelUpView, slot0)
end

function slot0.checkHadHighRareProp(slot0, slot1)
	if slot0.hadHighRareProp then
		return
	end

	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		if not ItemModel.instance:getItemConfig(tonumber(slot7.materilType), tonumber(slot7.materilId)) or not slot2.rare then
			logNormal(string.format("[checkMaterialRare] type : %s, id : %s; getConfig error", slot7.materilType, slot7.materilId))
		elseif CommonPropListModel.HighRare <= slot2.rare then
			slot0.hadHighRareProp = true

			return
		end
	end
end

function slot0._addFirstItem(slot0, slot1, slot2, slot3)
	slot0._containerGODict[slot0._delayTime * #slot0._bonusGOList + slot0._itemDelay], slot5 = slot0:_addItem(slot1, slot2, slot3)

	table.insert(slot0._bonusGOList, slot5)
	table.insert(slot0._firstBonusGOList, slot5)
end

function slot0._addAdditionItem(slot0, slot1)
	slot0._additionContainerGODict[slot0._delayTime * #slot0._additionBonusGOList + slot0._itemDelay], slot3 = slot0:_addItem(slot1)

	table.insert(slot0._additionBonusGOList, slot3)
end

function slot0._addExtraItem(slot0, slot1)
	slot0._extraContainerGODict[slot0._delayTime * #slot0._extraBonusGOList + slot0._itemDelay], slot3 = slot0:_addItem(slot1)

	table.insert(slot0._extraBonusGOList, slot3)
end

function slot0._addNormalItem(slot0, slot1)
	slot0._containerGODict[slot0._delayTime * #slot0._bonusGOList + slot0._itemDelay], slot3 = slot0:_addItem(slot1)

	table.insert(slot0._bonusGOList, slot3)
	table.insert(slot0._moveBonusGOList, slot3)
end

function slot0._addItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.clone(slot0._bonusItemGo, slot0._bonusItemContainer, slot1.id)
	slot6 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot4, "container/itemIcon"))

	gohelper.setActive(gohelper.findChild(slot4, "container"), false)
	gohelper.setActive(gohelper.findChild(slot4, "container/tag"), slot1.bonusTag)

	if slot1.bonusTag then
		gohelper.setActive(gohelper.findChild(slot4, "container/tag/imgFirst"), slot1.bonusTag == FightEnum.FightBonusTag.FirstBonus and slot0._normalMode)
		gohelper.setActive(gohelper.findChild(slot4, "container/tag/imgFirstHard"), slot1.bonusTag == FightEnum.FightBonusTag.FirstBonus and slot0._hardMode)
		gohelper.setActive(gohelper.findChild(slot4, "container/tag/imgNormal"), false)
		gohelper.setActive(gohelper.findChild(slot4, "container/tag/imgAdvance"), slot1.bonusTag == FightEnum.FightBonusTag.AdvencedBonus)
		gohelper.setActive(gohelper.findChild(slot4, "container/tag/imgEquipDaily"), slot1.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
		gohelper.setActive(gohelper.findChild(slot4, "container/tag/limitfirstbg"), slot1.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus)
		gohelper.setActive(gohelper.findChild(slot4, "container/tag/imgact"), slot1.bonusTag == FightEnum.FightBonusTag.ActBonus)
		gohelper.setActive(gohelper.findChild(slot4, "container/tag/imgFirstSimple"), slot1.bonusTag == FightEnum.FightBonusTag.SimpleBouns or FightEnum.FightBonusTag.FirstBonus and slot0._simpleMode)
	end

	slot1.isIcon = true

	slot6:onUpdateMO(slot1)
	slot6:setCantJump(true)
	slot6:setCountFontSize(40)
	slot6:setAutoPlay(true)
	slot6:isShowEquipRefineLv(true)

	slot17 = false

	if slot1.bonusTag and slot1.bonusTag == FightEnum.FightBonusTag.AdditionBonus then
		slot17 = true
	end

	slot6:isShowAddition(slot17)

	if slot2 then
		slot2(slot0, slot6, slot3)
	end

	gohelper.setActive(slot4, false)

	slot7:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	slot0:applyBonusVfx(slot1, slot4)

	return slot16, slot4
end

function slot0.applyBonusVfx(slot0, slot1, slot2)
	slot4 = ItemModel.instance:getItemConfig(slot1.materilType, slot1.materilId).rare
	slot4 = slot1.materilType == MaterialEnum.MaterialType.PlayerCloth and (slot4 or 5) or slot4 or 1

	for slot8 = 1, 6 do
		gohelper.setActive(gohelper.findChild(slot2, "vx/" .. slot8), slot8 == slot4)
	end

	for slot9 = 4, 5 do
		slot10 = gohelper.findChild(slot2, "vx/" .. slot9 .. "/#teshudaoju")

		if slot9 == slot4 and ItemModel.canShowVfx(slot1.materilType, slot3, slot4) then
			gohelper.setActive(slot10, false)
			gohelper.setActive(slot10, true)
		else
			gohelper.setActive(slot10, false)
		end
	end
end

function slot0.onRefreshV1a7Currency(slot0, slot1)
	slot2._gov1a7act = slot1._itemIcon._gov1a7act or gohelper.findChild(slot2.go, "act")

	gohelper.setActive(slot2._gov1a7act, true)
end

function slot0.onRefreshV1a7Power(slot0, slot1)
	slot2 = slot1._itemIcon

	slot2:setCanShowDeadLine(false)

	slot2._gov1a7act = slot2._gov1a7act or gohelper.findChild(slot2.go, "act")

	gohelper.setActive(slot2._gov1a7act, true)
end

function slot0.onRefreshToughBattle(slot0, slot1)
	slot2 = slot1._itemIcon

	slot2:setCanShowDeadLine(false)

	slot2._gov1a7act = slot2._gov1a7act or gohelper.findChild(slot2.go, "act")

	gohelper.setActive(slot2._gov1a7act, true)
end

function slot0.onRefreshV2a2Dungeon(slot0, slot1)
	slot2 = slot1._itemIcon

	slot2:setCanShowDeadLine(false)

	slot2._gov1a7act = slot2._gov1a7act or gohelper.findChild(slot2.go, "act")

	gohelper.setActive(slot2._gov1a7act, true)
end

function slot0._showRecordFarmItem(slot0)
	slot3 = uv0.checkRecordFarmItem(FightResultModel.instance:getEpisodeId(), JumpModel.instance:getRecordFarmItem())

	gohelper.setActive(slot0._godemand, slot3)

	if slot3 then
		slot0._godemand:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0
		slot0._farmTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._godemand, 0, 1, 0.3, nil, , , EaseType.Linear)

		if slot2.special then
			slot0._txtdemand.text = slot2.desc

			gohelper.setActive(slot0._btnbacktosource.gameObject, true)
		else
			slot6 = ItemModel.instance:getItemQuantity(slot2.type, slot2.id)

			if slot2.quantity then
				if slot2.quantity <= slot6 then
					slot0._txtdemand.text = string.format("%s %s <color=#81ce83>%s</color>/%s", luaLang("fightsuccview_demand"), ItemModel.instance:getItemConfig(slot2.type, slot2.id).name, GameUtil.numberDisplay(slot6), GameUtil.numberDisplay(slot2.quantity))
				else
					slot0._txtdemand.text = string.format("%s %s <color=#cc492f>%s</color>/%s", luaLang("fightsuccview_demand"), slot5.name, GameUtil.numberDisplay(slot6), GameUtil.numberDisplay(slot2.quantity))
				end

				gohelper.setActive(slot0._btnbacktosource.gameObject, true)
			else
				slot0._txtdemand.text = GameUtil.getSubPlaceholderLuaLang(luaLang("FightSuccView_txtdemand_overseas"), {
					slot5.name,
					GameUtil.numberDisplay(slot6)
				})

				gohelper.setActive(slot0._btnbacktosource.gameObject, true)
			end
		end
	else
		JumpModel.instance:clearRecordFarmItem()
	end
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

function slot0._showBonus(slot0)
	if slot0.hadHighRareProp then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_2)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_resources)
	end

	if #slot0._bonusGOList <= 0 then
		slot0:_showRecordFarmItem()
		slot0:_showCharacterGetView()

		return
	end

	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end

	slot0.popupFlow = FlowSequence.New()

	slot0.popupFlow:addWork(FightSuccShowBonusWork.New(slot0._bonusGOList, slot0._containerGODict, slot0._delayTime, slot0._itemDelay))
	slot0.popupFlow:addWork(FightSuccShowExtraBonusWork.New(slot0._extraBonusGOList, slot0._extraContainerGODict, slot0._showBonusEffect, slot0, slot0._moveBonusGOList, slot0._bonusItemContainer, slot0._delayTime, slot0._itemDelay))
	slot0.popupFlow:addWork(FightSuccShowExtraBonusWork.New(slot0._additionBonusGOList, slot0._additionContainerGODict, slot0._showBonusEffect, slot0, slot0._moveBonusGOList, slot0._bonusItemContainer, slot0._delayTime, slot0._itemDelay))
	slot0.popupFlow:registerDoneListener(slot0._onAllTweenFinish, slot0)
	slot0.popupFlow:start()
end

function slot0._showBonusEffect(slot0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "#reward_vx"), true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_extrafall)

	if #slot0._firstBonusGOList > 0 then
		recthelper.setAnchorX(slot1.transform, 169)
	end
end

function slot0._onAllTweenFinish(slot0)
	slot0:_showRecordFarmItem()
	slot0:_showCharacterGetView()

	if slot0.viewContainer.fightSuccActView then
		slot0.viewContainer.fightSuccActView:showReward()
	end
end

function slot0._showPlayerLevelUpView(slot0)
	slot2 = lua_episode.configDict[DungeonModel.instance.curSendEpisodeId]

	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	if PlayerModel.instance:getAndResetPlayerLevelUp() > 0 then
		ViewMgr.instance:openView(ViewName.PlayerLevelUpView, slot3)
	else
		slot0:_showBonus()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.PlayerLevelUpView or slot1 == ViewName.SeasonLevelView then
		slot0:_showBonus()
	end
end

function slot0._onClickData(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0._onClickBackToSource(slot0)
	if JumpModel.instance:getRecordFarmItem() then
		slot1.canBackSource = true
	end

	slot0:closeThis()
	uv0.onStoryEnd()
end

function slot0.showUnLockCurrentEpisodeNewMode(slot0)
	if not ActivityConfig.instance:getActIdByChapterId(slot0._curChapterId) then
		return
	end

	if not ActivityConfig.instance:getActivityDungeonConfig(slot1) then
		return
	end

	if slot2.story1ChapterId ~= slot0._curChapterId and slot2.story2ChapterId ~= slot0._curChapterId then
		return
	end

	if not DungeonModel.instance.curSendEpisodePass then
		return
	end

	if not DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(lua_episode.configDict[slot0._curEpisodeId]) or #slot3 <= 1 then
		return
	end

	GameFacade.showToast(ToastEnum.UnLockCurrentEpisode, luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[ActivityConfig.instance:getChapterIdMode(slot0._curChapterId) + 1]))
end

function slot0._hideGoDemand(slot0)
	gohelper.setActive(slot0._godemand, false)
end

function slot0._show1_2DailyEpisodeEndNotice(slot0)
	if lua_activity116_episode_sp.configDict[slot0._curEpisodeId] then
		ToastController.instance:showToastWithString(slot1.endShow)
	end
end

function slot0._show1_6EpisodeMaterial(slot0)
	if not lua_episode.configDict[slot0._curEpisodeId] or slot1.type ~= DungeonEnum.EpisodeType.Act1_6Dungeon or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101) then
		gohelper.setActive(slot0._goPlatConditionMaterial, false)

		return
	end

	gohelper.setActive(slot0._goPlatConditionMaterial, true)

	slot4, slot5, slot6 = nil

	UISpriteSetMgr.instance:setCurrencyItemSprite(gohelper.findChildImage(slot0._goPlatConditionMaterial, "icon"), string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill) and slot8.icon))

	gohelper.findChildText(slot0._goPlatConditionMaterial, "value").text = string.format("<color=#EB5F34>%s</color>/%s", VersionActivity1_6DungeonSkillModel.instance:getAllSkillPoint() or 0, Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum))
	gohelper.findChildText(slot0._goPlatConditionMaterial, "condition").text = luaLang("act1_6dungeonFightResultViewMaterialTitle")
end

return slot0

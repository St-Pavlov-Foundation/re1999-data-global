module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6BossFightSuccView", package.seeall)

local var_0_0 = class("VersionActivity1_6BossFightSuccView", BaseView)

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
	arg_1_0._txtcurroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	arg_1_0._txtmaxroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	arg_1_0._goCoverLessThan = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	arg_1_0._goCoverMuchThan = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	arg_1_0._goCoverEqual = gohelper.findChild(arg_1_0.viewGO, "#go_cover_record_part/tipbg/container/middle/#go_equal")
	arg_1_0.txtScore = gohelper.findChildText(arg_1_0.viewGO, "goRoleStorytips/#txt_num")
	arg_1_0._goscoreTips = gohelper.findChild(arg_1_0.viewGO, "Tips")
	arg_1_0._btnTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "goRoleStorytips/txt_tips/icon")
	arg_1_0.gofirstPass = gohelper.findChild(arg_1_0.viewGO, "firstpass")
	arg_1_0.txtFirstPassScore = gohelper.findChildText(arg_1_0.gofirstPass, "count")
	arg_1_0.txtHurtScore = gohelper.findChildText(arg_1_0.gofirstPass, "Tips/image_TipsBG/layout/txt_tips/value")
	arg_1_0.txtmultiple = gohelper.findChildText(arg_1_0.gofirstPass, "Tips/image_TipsBG/layout/txt_tips1/value")
	arg_1_0.totoalScore = gohelper.findChildText(arg_1_0.gofirstPass, "Tips/image_TipsBG/layout/txt_tips2/value")
	arg_1_0.gofightgoal = gohelper.findChild(arg_1_0.viewGO, "fightgoal")
	arg_1_0.txtCondition = gohelper.findChildText(arg_1_0.gofightgoal, "condition")
	arg_1_0.txtWave = gohelper.findChildText(arg_1_0.gofightgoal, "count")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnData:AddClickListener(arg_2_0._onClickData, arg_2_0)
	arg_2_0._btnTips:AddClickListener(arg_2_0._onClickTips, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnData:RemoveClickListener()
	arg_3_0._btnTips:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._canClick = false
	arg_4_0._animation = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animation))

	arg_4_0._animation:Play("fightsucc_in", UnityEngine.PlayMode.StopAll)
	arg_4_0._animation:PlayQueued("fightsucc_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)

	arg_4_0._animEventWrap = arg_4_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	FightController.instance:checkFightQuitTipViewClose()
	gohelper.setActive(arg_4_0._bonusItemGo, false)
	gohelper.setActive(arg_4_0._goscoreTips, false)
	gohelper.setActive(arg_4_0.gofirstPass, false)
	gohelper.setActive(arg_4_0._btnTips.gameObject, false)

	arg_4_0._curEpisodeId = DungeonModel.instance.curSendEpisodeId
	arg_4_0._curChapterId = DungeonModel.instance.curSendChapterId

	local var_4_0 = FightResultModel.instance
	local var_4_1 = lua_episode.configDict[arg_4_0._curEpisodeId]
	local var_4_2 = DungeonConfig.instance:getChapterCO(arg_4_0._curChapterId)

	if not var_4_1 or not var_4_1.type then
		local var_4_3 = DungeonEnum.EpisodeType.Normal
	end

	arg_4_0._curEpisodeId = FightResultModel.instance.episodeId
	arg_4_0._randomEntityMO = arg_4_0:_getRandomEntityMO()

	arg_4_0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	arg_4_0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	local var_4_4 = lua_chapter.configDict[var_4_0:getChapterId()]
	local var_4_5 = lua_episode.configDict[var_4_0:getEpisodeId()]
	local var_4_6 = var_4_4 ~= nil and var_4_5 ~= nil

	gohelper.setActive(arg_4_0._txtFbName.gameObject, var_4_6)
	gohelper.setActive(arg_4_0._txtFbNameEn.gameObject, var_4_6)

	if var_4_6 then
		arg_4_0:_setFbName(var_4_5)
	end

	arg_4_0:_setSpineVoice()
	NavigateMgr.instance:addEscape(ViewName.VersionActivity1_6BossFightSuccView, arg_4_0._onClickClose, arg_4_0)

	arg_4_0._canPlayVoice = false

	TaskDispatcher.runDelay(arg_4_0._setCanPlayVoice, arg_4_0, 0.9)
	TaskDispatcher.runDelay(arg_4_0._playScoreSound, arg_4_0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	arg_4_0:showWave()
	arg_4_0:showScore()
	arg_4_0:_refreshFirstPassTxt()
end

function var_0_0.onClose(arg_5_0)
	arg_5_0._canPlayVoice = false

	TaskDispatcher.cancelTask(arg_5_0._setCanPlayVoice, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._playScoreSound, arg_5_0)
	gohelper.setActive(arg_5_0._gospine, false)

	if FightResultModel.instance.canUpdateDungeonRecord and not arg_5_0._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	if arg_5_0._popupFlow then
		arg_5_0._popupFlow:destroy()

		arg_5_0._popupFlow = nil
	end
end

function var_0_0.onCloseFinish(arg_6_0)
	arg_6_0._simagecharacterbg:UnLoadImage()
	arg_6_0._simagemaskImage:UnLoadImage()
	FightStatModel.instance:clear()
	arg_6_0._animEventWrap:RemoveAllEventListener()

	if arg_6_0._farmTweenId then
		ZProj.TweenHelper.KillById(arg_6_0._farmTweenId)
	end
end

function var_0_0._setFbName(arg_7_0, arg_7_1)
	local var_7_0 = DungeonConfig.instance:getNormalEpisodeId(arg_7_1.id)
	local var_7_1 = DungeonConfig.instance:getEpisodeCO(var_7_0)
	local var_7_2 = DungeonConfig.instance:getChapterCO(var_7_1.chapterId)
	local var_7_3, var_7_4 = DungeonConfig.instance:getChapterIndex(var_7_2.type, var_7_1.chapterId)
	local var_7_5, var_7_6 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_7_1.chapterId, var_7_0)

	arg_7_0._txtChapterIndex.text = var_7_2.chapterIndex
	arg_7_0._txtFbNameEn.text = arg_7_1.name_En

	arg_7_0:_setEpisodeName(arg_7_1, var_7_5)
	arg_7_0:_setTag(arg_7_1)
end

function var_0_0._setTag(arg_8_0, arg_8_1)
	local var_8_0 = lua_const.configDict[ConstEnum.DungeonSuccessType].value
	local var_8_1 = string.splitToNumber(var_8_0, "#")
	local var_8_2 = tabletool.indexOf(var_8_1, arg_8_1.type)

	gohelper.setActive(arg_8_0._gonormaltag, var_8_2)
	gohelper.setActive(arg_8_0._goroletag, not var_8_2)
end

function var_0_0._setEpisodeName(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = FightModel.instance:getFightParam().battleId
	local var_9_1 = Activity149Config.instance:getAct149EpisodeCfgByEpisodeId(arg_9_1.id)

	arg_9_0._txtFbName.text = arg_9_1.name
	arg_9_0._txtEpisodeIndex.text = var_9_1.order
end

function var_0_0._refreshFirstPassTxt(arg_10_0)
	local var_10_0 = FightResultModel.instance.firstPass

	gohelper.setActive(arg_10_0.gofirstPass, var_10_0)

	if not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0._curEpisodeId
	local var_10_2 = Activity149Config.instance:getAct149EpisodeCfgByEpisodeId(var_10_1).firstPassScore

	arg_10_0.txtFirstPassScore.text = var_10_2
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

function var_0_0._getSkin(arg_12_0, arg_12_1)
	local var_12_0 = FightConfig.instance:getSkinCO(arg_12_1.skin)
	local var_12_1 = var_12_0 and not string.nilorempty(var_12_0.verticalDrawing)
	local var_12_2 = var_12_0 and not string.nilorempty(var_12_0.live2d)

	if var_12_1 or var_12_2 then
		return var_12_0
	end
end

function var_0_0._setSpineVoice(arg_13_0)
	if not arg_13_0._randomEntityMO then
		return
	end

	local var_13_0 = arg_13_0:_getSkin(arg_13_0._randomEntityMO)

	if var_13_0 then
		arg_13_0._spineLoaded = false

		arg_13_0._uiSpine:setImgPos(0)
		arg_13_0._uiSpine:setResPath(var_13_0, function()
			arg_13_0._spineLoaded = true

			arg_13_0._uiSpine:setUIMask(true)
			arg_13_0:_playSpineVoice()
		end, arg_13_0)

		local var_13_1, var_13_2 = SkinConfig.instance:getSkinOffset(var_13_0.fightSuccViewOffset)

		if var_13_2 then
			var_13_1, _ = SkinConfig.instance:getSkinOffset(var_13_0.characterViewOffset)
			var_13_1 = SkinConfig.instance:getAfterRelativeOffset(504, var_13_1)
		end

		local var_13_3 = tonumber(var_13_1[3])
		local var_13_4 = tonumber(var_13_1[1])
		local var_13_5 = tonumber(var_13_1[2])

		recthelper.setAnchor(arg_13_0._gospine.transform, var_13_4, var_13_5)
		transformhelper.setLocalScale(arg_13_0._gospine.transform, var_13_3, var_13_3, var_13_3)
	else
		gohelper.setActive(arg_13_0._gospine, false)
	end
end

function var_0_0._playSpineVoice(arg_15_0)
	if not arg_15_0._canPlayVoice then
		return
	end

	if not arg_15_0._spineLoaded then
		return
	end

	local var_15_0 = HeroModel.instance:getVoiceConfig(arg_15_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, nil, arg_15_0._randomEntityMO.skin) or FightAudioMgr.instance:_getHeroVoiceCOs(arg_15_0._randomEntityMO.modelId, CharacterEnum.VoiceType.FightResult, arg_15_0._randomEntityMO.skin)

	if var_15_0 and #var_15_0 > 0 then
		local var_15_1 = var_15_0[1]

		arg_15_0._uiSpine:playVoice(var_15_1, nil, arg_15_0._txtSayCn, arg_15_0._txtSayEn)
	end
end

function var_0_0._getSayContent(arg_16_0, arg_16_1)
	local var_16_0 = GameUtil.splitString2(arg_16_1, false, "|", "#")
	local var_16_1 = ""

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		var_16_1 = var_16_1 .. iter_16_1[1]
	end

	return var_16_1
end

function var_0_0._setCanPlayVoice(arg_17_0)
	arg_17_0._canPlayVoice = true

	arg_17_0:_playSpineVoice()
end

function var_0_0._finishStoryFromServer(arg_18_0)
	if var_0_0._storyId == arg_18_0 then
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

function var_0_0._showCharacterGetView(arg_21_0)
	PopupController.instance:setPause("fightsuccess", false)

	arg_21_0._canClick = true
end

function var_0_0.showWave(arg_22_0)
	local var_22_0 = FightModel.instance:getCurWaveId()
	local var_22_1 = FightModel.instance.maxWave

	arg_22_0.txtCondition.text = luaLang("dungeon_beat_all")

	local var_22_2 = FightDataHelper.entityMgr:getEnemyNormalList()

	if var_22_2 and #var_22_2 > 0 then
		var_22_0 = var_22_0 - 1
	end

	arg_22_0.txtWave.text = string.format("<color=#E57937>%s</color>/%s", var_22_0, var_22_1)
end

function var_0_0.showScore(arg_23_0)
	local var_23_0 = VersionActivity1_6DungeonBossModel.instance:getFightScore()

	arg_23_0.txtScore.text = var_23_0

	arg_23_0:_onAllTweenFinish()
end

function var_0_0._onAllTweenFinish(arg_24_0)
	arg_24_0:_showCharacterGetView()
end

function var_0_0._onClickClose(arg_25_0)
	if not arg_25_0._canClick then
		return
	end

	if arg_25_0._uiSpine then
		arg_25_0._uiSpine:stopVoice()
	end

	arg_25_0:closeThis()

	local var_25_0 = FightModel.instance:getAfterStory()

	if var_25_0 > 0 and not StoryModel.instance:isStoryFinished(var_25_0) then
		var_0_0._storyId = var_25_0
		var_0_0._clientFinish = false
		var_0_0._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, var_0_0._finishStoryFromServer)

		local var_25_1 = {}

		var_25_1.mark = true
		var_25_1.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_25_0, var_25_1, function()
			TaskDispatcher.runDelay(var_0_0.onStoryEnd, nil, 3)

			var_0_0._clientFinish = true

			var_0_0.checkStoryEnd()
		end)

		return
	end

	var_0_0.onStoryEnd()
end

function var_0_0._onClickData(arg_27_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._onClickTips(arg_28_0)
	gohelper.setActive(arg_28_0._goscoreTips, true)
end

function var_0_0._onClickTipsClose(arg_29_0)
	gohelper.setActive(arg_29_0._goscoreTips, false)
end

function var_0_0._playScoreSound(arg_30_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossFightResultScore)
end

return var_0_0

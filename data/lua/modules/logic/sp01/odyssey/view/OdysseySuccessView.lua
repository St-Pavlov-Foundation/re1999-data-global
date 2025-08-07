module("modules.logic.sp01.odyssey.view.OdysseySuccessView", package.seeall)

local var_0_0 = class("OdysseySuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0._btnData = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnData")
	arg_1_0._simagecharacterbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_characterbg")
	arg_1_0._simagemaskImage = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskImage")
	arg_1_0._goroletag = gohelper.findChild(arg_1_0.viewGO, "txtFbName/#go_roletag")
	arg_1_0._gonormaltag = gohelper.findChild(arg_1_0.viewGO, "txtFbName/#go_normaltag")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "spineContainer/spine")
	arg_1_0._uiSpine = GuiModelAgent.Create(arg_1_0._gospine, true)

	arg_1_0._uiSpine:useRT()

	arg_1_0._txtFbName = gohelper.findChildText(arg_1_0.viewGO, "txtFbName")
	arg_1_0._gosuit = gohelper.findChild(arg_1_0.viewGO, "txtFbName/#go_suit")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "txtFbName/#go_suit/#image_icon")
	arg_1_0._goalcontent = gohelper.findChild(arg_1_0.viewGO, "goalcontent")
	arg_1_0._goCondition = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/fightgoal")
	arg_1_0._goPlatCondition = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/platinum")
	arg_1_0._goPlatCondition2 = gohelper.findChild(arg_1_0.viewGO, "goalcontent/goallist/platinum2")
	arg_1_0._goconquer = gohelper.findChild(arg_1_0.viewGO, "#go_conquer")
	arg_1_0._txtcurRound = gohelper.findChildText(arg_1_0.viewGO, "#go_conquer/#txt_curRound")
	arg_1_0._txttotalRound = gohelper.findChildText(arg_1_0.viewGO, "#go_conquer/#txt_totalRound")
	arg_1_0._gonewrecordtag = gohelper.findChild(arg_1_0.viewGO, "#go_conquer/go_newRecord")
	arg_1_0._goscrollitem = gohelper.findChild(arg_1_0.viewGO, "scroll/item")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "scroll/viewport/content")
	arg_1_0._txtSayCn = gohelper.findChildText(arg_1_0.viewGO, "txtSayCn")
	arg_1_0._txtSayEn = gohelper.findChildText(arg_1_0.viewGO, "SayEn/txtSayEn")
	arg_1_0._rewardList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnData:AddClickListener(arg_2_0._onClickData, arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnData:RemoveClickListener()
	arg_3_0._click:RemoveClickListener()
end

function var_0_0._onClickData(arg_4_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._onClickClose(arg_5_0)
	if arg_5_0._uiSpine then
		arg_5_0._uiSpine:stopVoice()
	end

	arg_5_0:closeThis()

	local var_5_0 = FightModel.instance:getAfterStory()
	local var_5_1 = DungeonConfig.instance:getChapterCO(arg_5_0._curChapterId)
	local var_5_2 = var_5_1 and var_5_1.type == DungeonEnum.ChapterType.RoleStory or var_5_1.id == DungeonEnum.ChapterId.RoleDuDuGu

	if var_5_0 > 0 and (var_5_2 or not StoryModel.instance:isStoryFinished(var_5_0)) then
		var_0_0._storyId = var_5_0
		var_0_0._clientFinish = false
		var_0_0._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, var_0_0._finishStoryFromServer)

		local var_5_3 = {}

		var_5_3.mark = true
		var_5_3.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_5_0, var_5_3, function()
			TaskDispatcher.runDelay(var_0_0.onStoryEnd, nil, 3)

			var_0_0._clientFinish = true

			var_0_0.checkStoryEnd()
		end)

		return
	end

	var_0_0.onStoryEnd()
end

function var_0_0._finishStoryFromServer(arg_7_0)
	if var_0_0._storyId == arg_7_0 then
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

function var_0_0._editableInitView(arg_10_0)
	return
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._randomEntityMO = arg_12_0:_getRandomEntityMO()

	arg_12_0._simagecharacterbg:LoadImage(ResUrl.getFightQuitResultIcon("bg_renwubeiguang"))
	arg_12_0._simagemaskImage:LoadImage(ResUrl.getFightResultcIcon("bg_zhezhao"))

	arg_12_0._curChapterId = DungeonModel.instance.curSendChapterId
	arg_12_0._curEpisodeId = FightResultModel.instance.episodeId
	arg_12_0._fightParam = FightModel.instance:getFightParam()

	arg_12_0:_setSuitIfo()
	arg_12_0:_setSpineVoice()
	NavigateMgr.instance:addEscape(ViewName.OdysseySuccessView, arg_12_0._onClickClose, arg_12_0)

	arg_12_0._canPlayVoice = false

	TaskDispatcher.runDelay(arg_12_0._setCanPlayVoice, arg_12_0, 0.9)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
end

function var_0_0._setSuitIfo(arg_13_0)
	arg_13_0._resultMO = OdysseyModel.instance:getFightResultInfo()

	local var_13_0 = arg_13_0._resultMO:getRewardList()
	local var_13_1 = OdysseyItemModel.instance:getAddOuterItemList()
	local var_13_2 = {}

	tabletool.addValues(var_13_2, var_13_1)
	tabletool.addValues(var_13_2, var_13_0)
	gohelper.CreateObjList(arg_13_0, arg_13_0._creatItem, var_13_2, arg_13_0._goscrollcontent, arg_13_0._goscrollitem)

	arg_13_0._isConquer = arg_13_0._resultMO:checkFightTypeIsConquer()

	gohelper.setActive(arg_13_0._goconquer, arg_13_0._isConquer)
	gohelper.setActive(arg_13_0._goalcontent, not arg_13_0._isConquer)

	arg_13_0._fighteleCO = OdysseyConfig.instance:getElementFightConfig(arg_13_0._resultMO:getElementId())
	arg_13_0._txtFbName.text = arg_13_0._fighteleCO.title

	if arg_13_0._isConquer then
		local var_13_3 = arg_13_0._resultMO:getConquestEle()

		gohelper.setActive(arg_13_0._gonewrecordtag, var_13_3.newFlag)

		arg_13_0._txtcurRound.text = var_13_3.currWave
		arg_13_0._txttotalRound.text = arg_13_0._fightParam.monsterGroupIds and #arg_13_0._fightParam.monsterGroupIds or 0
	else
		local var_13_4 = DungeonConfig.instance:getChapterCO(arg_13_0._curChapterId)
		local var_13_5 = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())
		local var_13_6 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_13_0._curEpisodeId, FightModel.instance:getBattleId())
		local var_13_7 = arg_13_0._hardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

		if string.nilorempty(var_13_5) then
			gohelper.setActive(arg_13_0._goCondition, false)
		else
			gohelper.findChildText(arg_13_0._goCondition, "condition").text = var_13_5

			local var_13_8 = gohelper.findChildImage(arg_13_0._goCondition, "star")

			UISpriteSetMgr.instance:setCommonSprite(var_13_8, var_13_7, true)
			SLFramework.UGUI.GuiHelper.SetColor(var_13_8, arg_13_0._hardMode and "#FF4343" or "#F77040")
		end

		if var_13_4 and var_13_4.type == DungeonEnum.ChapterType.Simple then
			gohelper.setActive(arg_13_0._goPlatCondition, false)
		else
			arg_13_0:_showPlatCondition(var_13_6, arg_13_0._goPlatCondition, var_13_7, DungeonEnum.StarType.Advanced)
		end
	end
end

function var_0_0._creatItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_0._rewardList[arg_14_3] then
		local var_14_0 = arg_14_0:getUserDataTb_()
		local var_14_1 = arg_14_1

		var_14_0.itemGO = arg_14_0.viewContainer:getResInst(arg_14_0.viewContainer:getSetting().otherRes[1], var_14_1)
		var_14_0.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_0.itemGO, OdysseyItemIcon)

		if arg_14_2.rewardType == OdysseyEnum.ResultRewardType.Item then
			var_14_0.itemIcon:initItemInfo(arg_14_2.itemType, arg_14_2.itemId, arg_14_2.count)
		elseif arg_14_2.rewardType == OdysseyEnum.ResultRewardType.Exp then
			var_14_0.itemIcon:showTalentItem(arg_14_2.count)
		elseif arg_14_2.rewardType == OdysseyEnum.ResultRewardType.Talent then
			var_14_0.itemIcon:showExpItem(arg_14_2.count)
		elseif arg_14_2.itemType and arg_14_2.itemType == OdysseyEnum.RewardItemType.OuterItem then
			local var_14_2 = {
				type = tonumber(arg_14_2.type),
				id = tonumber(arg_14_2.id)
			}

			var_14_0.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.OuterItem, var_14_2, tonumber(arg_14_2.addCount))
		end

		table.insert(arg_14_0._rewardList, var_14_0)
	end
end

function var_0_0._showPlatCondition(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if string.nilorempty(arg_15_1) then
		gohelper.setActive(arg_15_2, false)
	else
		gohelper.setActive(arg_15_2, true)

		local var_15_0 = tonumber(FightResultModel.instance.star) or 0

		if var_15_0 < arg_15_4 then
			gohelper.findChildText(arg_15_2, "condition").text = gohelper.getRichColorText(arg_15_1, "#6C6C6B")
		else
			gohelper.findChildText(arg_15_2, "condition").text = gohelper.getRichColorText(arg_15_1, "#C4C0BD")
		end

		local var_15_1 = gohelper.findChildImage(arg_15_2, "star")
		local var_15_2 = "#87898C"

		if arg_15_4 <= var_15_0 then
			var_15_2 = arg_15_0._hardMode and "#FF4343" or "#F77040"
		end

		UISpriteSetMgr.instance:setCommonSprite(var_15_1, arg_15_3, true)
		SLFramework.UGUI.GuiHelper.SetColor(var_15_1, var_15_2)
	end
end

function var_0_0._setCanPlayVoice(arg_16_0)
	arg_16_0._canPlayVoice = true

	arg_16_0:_playSpineVoice()
end

function var_0_0._getRandomEntityMO(arg_17_0)
	local var_17_0 = FightDataHelper.entityMgr:getMyNormalList()
	local var_17_1 = FightDataHelper.entityMgr:getMySubList()
	local var_17_2 = FightDataHelper.entityMgr:getMyDeadList()
	local var_17_3 = {}

	tabletool.addValues(var_17_3, var_17_0)
	tabletool.addValues(var_17_3, var_17_1)
	tabletool.addValues(var_17_3, var_17_2)

	for iter_17_0 = #var_17_3, 1, -1 do
		local var_17_4 = var_17_3[iter_17_0]

		if not arg_17_0:_getSkin(var_17_4) then
			table.remove(var_17_3, iter_17_0)
		end
	end

	local var_17_5 = {}

	tabletool.addValues(var_17_5, var_17_3)

	for iter_17_1 = #var_17_5, 1, -1 do
		local var_17_6 = var_17_3[iter_17_1]
		local var_17_7 = FightAudioMgr.instance:_getHeroVoiceCOs(var_17_6.modelId, CharacterEnum.VoiceType.FightResult)

		if var_17_7 and #var_17_7 > 0 then
			if var_17_6:isMonster() then
				table.remove(var_17_5, iter_17_1)
			end
		else
			table.remove(var_17_5, iter_17_1)
		end
	end

	if #var_17_5 > 0 then
		return var_17_5[math.random(#var_17_5)]
	elseif #var_17_3 > 0 then
		return var_17_3[math.random(#var_17_3)]
	else
		logError("没有角色")
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

function var_0_0._getSkin(arg_24_0, arg_24_1)
	local var_24_0 = FightConfig.instance:getSkinCO(arg_24_1.skin)
	local var_24_1 = var_24_0 and not string.nilorempty(var_24_0.verticalDrawing)
	local var_24_2 = var_24_0 and not string.nilorempty(var_24_0.live2d)

	if var_24_1 or var_24_2 then
		return var_24_0
	end
end

function var_0_0.onClose(arg_25_0)
	arg_25_0._canPlayVoice = false

	TaskDispatcher.cancelTask(arg_25_0._setCanPlayVoice, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._delayPlayVoice, arg_25_0)
	gohelper.setActive(arg_25_0._gospine, false)
end

function var_0_0.onDestroyView(arg_26_0)
	OdysseyModel.instance:clearResultInfo()
end

return var_0_0

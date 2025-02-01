module("modules.logic.season.view1_4.Season1_4SettlementView", package.seeall)

slot0 = class("Season1_4SettlementView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._gosettlement = gohelper.findChild(slot0.viewGO, "#go_settlement")
	slot0._gospecialmarket = gohelper.findChild(slot0.viewGO, "#go_settlement/#go_specialmarket")
	slot0._simagespecialbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_settlement/#go_specialmarket/#simage_specialbg")
	slot0._animationEvent = slot0._gosettlement:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_settlement/#btn_close")
	slot0._simagedecorate6 = gohelper.findChildSingleImage(slot0.viewGO, "#go_settlement/decorate/mask/#simage_decorate6")
	slot0._simagedecorate10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_settlement/decorate/mask/#simage_decorate10")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_settlement/left/#simage_circlebg/#txt_index")
	slot0._txtlevelnamecn = gohelper.findChildText(slot0.viewGO, "#go_settlement/left/#txt_levelnamecn")
	slot0._gostageitem1 = gohelper.findChild(slot0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem1")
	slot0._gostageitem2 = gohelper.findChild(slot0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem2")
	slot0._gostageitem3 = gohelper.findChild(slot0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem3")
	slot0._gostageitem4 = gohelper.findChild(slot0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem4")
	slot0._gostageitem5 = gohelper.findChild(slot0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem5")
	slot0._gostageitem6 = gohelper.findChild(slot0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem6")
	slot0._gostageitem7 = gohelper.findChild(slot0.viewGO, "#go_settlement/left/#txt_levelnamecn/stage/#go_stageitem7")
	slot0._simageherodecorate = gohelper.findChildSingleImage(slot0.viewGO, "#go_settlement/right/herocard/#simage_herodecorate")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_progress")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_progress/#txt_progress")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._gohero1 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero1")
	slot0._gohero2 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero2")
	slot0._gohero3 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero3")
	slot0._gohero4 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero4")
	slot0._gosupercard = gohelper.findChild(slot0.viewGO, "#go_settlement/right/herocard/#go_supercard")
	slot0._gofightsucc = gohelper.findChild(slot0.viewGO, "#go_fightsucc")
	slot0._simagefightsuccbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_fightsucc/#simage_fightsuccbg")
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_fightsucc/#btn_closetip")
	slot0._gocoverrecordpart = gohelper.findChild(slot0.viewGO, "#go_settlement/#go_cover_record_part")
	slot0._btncoverrecord = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_settlement/#go_cover_record_part/#btn_cover_record")
	slot0._txtcurroundcount = gohelper.findChildText(slot0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	slot0._txtmaxroundcount = gohelper.findChildText(slot0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	slot0._goCoverLessThan = gohelper.findChild(slot0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	slot0._goCoverMuchThan = gohelper.findChild(slot0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	slot0._goCoverEqual = gohelper.findChild(slot0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_equal")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_bottom")
	slot0._gospace = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_space")
	slot0._btnstat = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_settlement/right/layout/middle/#btn_stat")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._btncloseaward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tips/#btn_closeaward")
	slot0._gorewardtip = gohelper.findChild(slot0.viewGO, "#go_tips/layout/vertical/#go_rewardtip")
	slot0._awardcontent = gohelper.findChild(slot0.viewGO, "#go_tips/layout/vertical/#go_rewardtip/#scroll_rewardtip/Viewport/Content")
	slot0._gorewardtipitem = gohelper.findChild(slot0.viewGO, "#go_tips/layout/vertical/#go_rewardtip/#scroll_rewardtip/Viewport/Content/#go_rewardtipitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnstat:AddClickListener(slot0._btnstatOnClick, slot0)
	slot0._btncloseaward:AddClickListener(slot0._btncloseawardOnClick, slot0)
	slot0:addClickCb(slot0._btncoverrecord, slot0._onBtnCoverRecordClick, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, slot0._onCoverDungeonRecordReply, slot0)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
	slot0._animationEvent:AddEventListener("reward", slot0._onRewardShow, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnstat:RemoveClickListener()
	slot0._btncloseaward:RemoveClickListener()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
	slot0._animationEvent:RemoveEventListener("reward")
end

function slot0._btnclosetipOnClick(slot0)
	slot0:_showAwardTip()
	gohelper.setActive(slot0._gofightsucc, false)
end

function slot0._btncloseawardOnClick(slot0)
	if Time.realtimeSinceStartup - slot0._startTime < 2 then
		return
	end

	slot0:_showSettlement()
end

function slot0._btnstatOnClick(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0._showAwardTip(slot0)
	FightHelper.hideAllEntity()

	if slot0._episode_config.type == DungeonEnum.EpisodeType.Season and FightResultModel.instance.firstPass then
		gohelper.setActive(slot0._gotips, true)
		slot0:_showAwardTipsData()
	else
		slot0:_showSettlement()
	end
end

function slot0._showSettlement(slot0)
	gohelper.setActive(slot0._gotips, false)

	slot0._startTime = Time.realtimeSinceStartup

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_clearing)
	gohelper.setActive(slot0._gosettlement, true)
	gohelper.setActive(slot0._gospecialmarket, slot0._episode_config.type == DungeonEnum.EpisodeType.SeasonSpecial)
	slot0:_checkNewRecord()
	slot0:_detectCoverRecord()
	TaskDispatcher.runDelay(slot0._dailyShowHero, slot0, 0.6)
end

function slot0._onRewardShow(slot0)
	slot0:_showSettlementReward()
end

function slot0._dailyShowHero(slot0)
	slot0._heroIndex = 0

	TaskDispatcher.runRepeat(slot0._showHeroItem, slot0, 0.03, #slot0._heroList)
	TaskDispatcher.runDelay(slot0._showGetCardView, slot0, 1.5)
end

function slot0._showHeroItem(slot0)
	slot0._heroIndex = slot0._heroIndex + 1

	gohelper.setActive(slot0._heroList[slot0._heroIndex].viewGO, true)
end

function slot0._showGetCardView(slot0)
	if slot0.equip_cards then
		slot0._showTipsFlow = FlowSequence.New()

		slot0._showTipsFlow:addWork(Season1_4SettlementTipsWork.New())
		slot0._showTipsFlow:registerDoneListener(slot0._onShowTipsFlowDone, slot0)
		slot0._showTipsFlow:start({
			delayTime = 0
		})
	end
end

function slot0._onShowTipsFlowDone(slot0)
	slot0.equip_cards = nil
end

function slot0._checkNewRecord(slot0)
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	end
end

function slot0._onCoverDungeonRecordReply(slot0, slot1)
	slot0._hasSendCoverRecord = true

	gohelper.setActive(slot0._gocoverrecordpart, false)

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
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

function slot0._editableInitView(slot0)
	slot0._simagedecorate10:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
	slot0._simagefightsuccbg:LoadImage(ResUrl.getSeasonIcon("full/diejia_bj.png"))
	slot0._simageherodecorate:LoadImage(ResUrl.getSeasonIcon("jiesuan_zhujue.png"))
	slot0._simagespecialbg:LoadImage(ResUrl.getSeasonIcon("full/img_bg3.png"))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
	gohelper.setActive(slot0._gofightsucc, true)
	gohelper.setActive(slot0._gosettlement, false)
	gohelper.setActive(slot0._gotips, false)

	slot0._fightsucc_click = gohelper.getClick(slot0._gofightsucc)
end

function slot0._btncloseOnClick(slot0)
	if Time.realtimeSinceStartup - slot0._startTime < 2.5 then
		return
	end

	if slot0.equip_cards then
		return
	end

	slot0:closeThis()

	if FightModel.instance:getAfterStory() > 0 and not StoryModel.instance:isStoryFinished(slot1) then
		StoryController.instance:playStory(slot1, {
			mark = true,
			episodeId = DungeonModel.instance.curSendEpisodeId
		}, function ()
			FightSuccView.onStoryEnd()
		end)

		return
	end

	FightSuccView.onStoryEnd()
end

function slot0.onOpen(slot0)
	slot0._startTime = Time.realtimeSinceStartup
	slot0._episode_config = lua_episode.configDict[FightResultModel.instance:getEpisodeId()]
	slot0._config = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), Activity104Model.instance:getBattleFinishLayer() or 1)

	if slot0._config then
		slot0._simagedecorate6:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/ty_chatu_%s.png", slot0._config.stagePicture)))
	end

	slot0._txtindex.text = string.format("%02d", slot1)
	slot0._txtlevelnamecn.text = slot0._episode_config.name
	slot2 = {}

	tabletool.addValues(slot2, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(slot2, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(slot2, FightResultModel.instance:getMaterialDataList())

	slot3 = {}

	for slot7 = #slot2, 1, -1 do
		if slot2[slot7].materilType == MaterialEnum.MaterialType.EquipCard then
			table.insert(slot3, slot8.materilId)
		end
	end

	slot0:_onHeroItemLoaded()

	if #slot3 > 0 then
		slot0.equip_cards = slot3
	end

	slot0.reward_list = slot2

	gohelper.setActive(slot0._goprogress, FightResultModel.instance.firstPass and slot0._episode_config.type == DungeonEnum.EpisodeType.Season)

	if #slot2 == 0 then
		if FightResultModel.instance.firstPass then
			logError("服务器没有下发奖励")
		end

		gohelper.setActive(slot0._gorewards, false)
	end

	gohelper.setActive(slot0._gobottom, FightResultModel.instance.firstPass or #slot2 > 0)
	gohelper.setActive(slot0._gospace, not FightResultModel.instance.firstPass and #slot2 <= 0)
	slot0:_setStages()

	slot0._reward_list = slot2

	TaskDispatcher.runDelay(slot0._btnclosetipOnClick, slot0, 1.5)

	CameraMgr.instance:getCameraRootAnimator().enabled = false
end

function slot0._showSettlementReward(slot0)
	gohelper.addChild(slot0.viewGO, slot0._gorewarditem)
	slot0:com_createObjList(slot0._onRewardItemShow, slot0.reward_list, gohelper.findChild(slot0._scrollrewards.gameObject, "Viewport/Content"), slot0._gorewarditem, nil, 0.1)
end

function slot0._setStages(slot0)
	gohelper.setActive(slot0._gostageitem7, SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), Activity104Model.instance:getBattleFinishLayer()).stage == 7)

	if slot0._episode_config.type == DungeonEnum.EpisodeType.SeasonSpecial then
		slot1 = 7

		gohelper.setActive(slot0._gostageitem7, false)
	end

	for slot5 = 1, 7 do
		gohelper.setActive(gohelper.findChildImage(slot0["_gostageitem" .. slot5], "light").gameObject, slot5 <= slot1)
		gohelper.setActive(gohelper.findChildImage(slot0["_gostageitem" .. slot5], "dark").gameObject, slot1 < slot5)
		SLFramework.UGUI.GuiHelper.SetColor(slot7, slot5 == 7 and "#B83838" or "#FFFFFF")
	end
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	if slot2.materilType == MaterialEnum.MaterialType.EquipCard then
		Season1_4CelebrityCardItem.New():init(gohelper.findChild(gohelper.findChild(slot1, "go_prop"), "cardicon"), slot2.materilId)

		slot0._equipAwardCards = slot0._equipAwardCards or {}

		table.insert(slot0._equipAwardCards, slot5)
	else
		slot5 = IconMgr.instance:getCommonPropListItemIcon(slot4)
		slot5._index = slot3

		function slot5.callback(slot0)
			slot0:setCountFontSize(40)
			slot0:hideName()
		end

		slot5:onUpdateMO(slot2)
	end
end

slot1 = {
	{
		Vector2.New(136.2, 196)
	},
	{
		Vector2.New(-92.3, 114),
		Vector2.New(149.7, 195.9)
	},
	{
		Vector2.New(-219.9, 195.9),
		Vector2.New(22.2, 116.1),
		Vector2.New(264.8, 195.9)
	},
	{
		Vector2.New(-340.6, 267.6),
		Vector2.New(-112.2, 195.9),
		Vector2.New(115, 115),
		Vector2.New(345.2, 195.9)
	}
}

function slot0._onHeroItemLoaded(slot0)
	slot0._heroList = {}
	slot0._hero_obj_list = slot0:getUserDataTb_()

	for slot6 = 1, 4 do
		slot7 = slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.itemRes, slot0["_gohero" .. slot6])

		gohelper.setActive(slot7, false)
		table.insert(slot0._hero_obj_list, slot7)
	end

	gohelper.setActive(slot0._gosupercard, false)

	slot3 = FightModel.instance:getFightParam()
	slot5 = FightModel.instance:getBattleId() and lua_battle.configDict[slot4]
	slot6 = slot5 and slot5.playerMax or ModuleEnum.HeroCountInGroup

	if not FightModel.instance.curFightModel then
		slot8 = {}

		for slot13, slot14 in ipairs(slot3.mySideUids) do
			table.insert({}, slot14)
		end

		for slot13, slot14 in ipairs(slot3.mySideSubUids) do
			table.insert(slot9, slot14)
		end

		slot10 = {
			[slot15.heroUid] = slot15
		}

		for slot14, slot15 in ipairs(slot3.equips) do
			-- Nothing
		end

		slot11 = {
			[slot16.heroUid] = slot16
		}

		for slot15, slot16 in ipairs(slot3.activity104Equips) do
			-- Nothing
		end

		if slot3.trialHeroList then
			for slot15, slot16 in ipairs(slot3.trialHeroList) do
				if slot16.pos < 0 then
					slot17 = slot6 - slot17
				end

				slot8[slot17] = slot16

				table.insert(slot9, slot17, 0)
			end
		end

		for slot15 = 1, 4 do
			if slot8[slot15] then
				if lua_hero_trial.configDict[slot8[slot15].trialId][0] then
					table.insert(slot0._heroList, slot0:openSubView(Season1_4SettlementHeroItem, slot0._hero_obj_list[slot15], nil, slot7, nil, slot8[slot15].equipUid, slot11[tostring(slot16.heroId - 1099511627776.0)] and slot11[slot17].equipUid, nil, slot8[slot15]))
				end
			elseif slot16 ~= "0" then
				table.insert(slot0._heroList, slot0:openSubView(Season1_4SettlementHeroItem, slot0._hero_obj_list[slot15], nil, slot7, slot16, slot9[slot15] ~= "0" and slot10[slot16] and slot10[slot16].equipUid, slot16 ~= "0" and slot11[slot16] and slot11[slot16].equipUid))
			end
		end

		slot0:_refreshHeroItemPos()

		if slot11["-100000"] and slot11[slot12].equipUid and slot11[slot12].equipUid[1] and slot13 ~= "0" then
			gohelper.setActive(slot0._gosupercard, true)
			slot0:openSubView(Season1_4CelebrityCardGetItem, Season1_4CelebrityCardItem.AssetPath, slot0._gosupercard, slot13, true)
		end
	else
		FightRpc.instance:sendGetFightRecordGroupRequest(slot3.episodeId)
	end
end

function slot0._refreshHeroItemPos(slot0)
	if (slot0._heroList and #slot0._heroList or 0) <= 0 then
		return
	end

	slot2 = uv0[slot1]

	for slot6 = 1, slot1 do
		recthelper.setAnchor(slot0._heroList[slot6].viewGO.transform.parent, slot2[slot6].x, slot2[slot6].y)
	end
end

function slot0._onGetFightRecordGroupReply(slot0, slot1)
	for slot5 = 1, 4 do
		slot6 = slot0._hero_obj_list[slot5]
		slot7 = slot1:getHeroByIndex(slot5)
		slot8 = slot1.replay_equip_data[slot7]
		slot9 = slot1.replay_activity104Equip_data[slot7]

		if not slot1.replay_hero_data[slot7] then
			for slot14, slot15 in pairs(slot1.replay_hero_data) do
				if slot15.heroId == slot7 then
					slot10 = slot15

					break
				end
			end
		end

		if slot7 ~= "0" then
			table.insert(slot0._heroList, slot0:openSubView(Season1_4SettlementHeroItem, slot6, nil, true, slot7, slot8, slot9, slot10))
		end
	end

	if slot1.replay_activity104Equip_data["-100000"] then
		gohelper.setActive(slot0._gosupercard, slot1.replay_activity104Equip_data[slot2][1].equipId ~= 0)
		slot0:openSubView(Season1_4CelebrityCardGetItem, Season1_4CelebrityCardItem.AssetPath, slot0._gosupercard, nil, , slot3)
	end
end

function slot0._showAwardTipsData(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_clearing_unfold)

	slot0._startTime = Time.realtimeSinceStartup

	gohelper.setActive(slot0._gorewardtip, #slot0._reward_list > 0)
	slot0:_releaseAwardImage()
	slot0:com_createObjList(slot0._onAwardItemShow, slot0._reward_list, slot0._awardcontent, slot0._gorewardtipitem)
	slot0:_showPassData()
end

function slot0._showPassData(slot0)
	slot1 = Activity104Model.instance:getBattleFinishLayer()
	slot2 = gohelper.findChild(slot0.viewGO, "#go_tips/layout/vertical/mask/#go_scrolllv/Viewport/Content")
	slot4 = string.format("%02d", slot1 - 1)

	if not SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), slot1 - 1) then
		slot4 = ""

		gohelper.setActive(gohelper.findChild(slot2, "#text1/pass"), false)
	end

	gohelper.findChildText(slot2, "#text1/#txt_passindex1").text = slot4
	gohelper.findChildText(slot2, "#text2/#txt_selectindex1").text = string.format("%02d", slot1)
	slot6 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), slot1 + 1)

	gohelper.setActive(gohelper.findChild(slot2, "#text3"), slot6)

	gohelper.findChildText(slot2, "#text3/#txt_passindex1").text = string.format("%02d", slot1 + 1)

	gohelper.setActive(gohelper.findChild(slot2, "maxlayer"), not slot6)
	gohelper.setActive(gohelper.findChild(slot2, "seleted"), slot6)
end

function slot0._releaseAwardImage(slot0)
	if slot0._awardImage then
		for slot4, slot5 in ipairs(slot0._awardImage) do
			slot5:UnLoadImage()
		end
	end

	if slot0._awardClick then
		for slot4, slot5 in ipairs(slot0._awardClick) do
			slot5:RemoveClickListener()
		end
	end

	slot0._awardImage = slot0:getUserDataTb_()
	slot0._awardClick = slot0:getUserDataTb_()
end

function slot0._onAwardItemShow(slot0, slot1, slot2, slot3)
	slot7, slot8 = ItemModel.instance:getItemConfigAndIcon(slot2.materilType, slot2.materilId, true)

	if slot7.subType == ItemEnum.SubType.Portrait then
		gohelper.setActive(slot5, true)
		gohelper.setActive(gohelper.findChildSingleImage(slot1, "simage_reward").gameObject, false)
		gohelper.findChildSingleImage(gohelper.findChild(slot1, "#go_headiconpos"), "#simage_headicon"):LoadImage(slot8)
	else
		gohelper.setActive(slot5, false)
		gohelper.setActive(slot4.gameObject, true)
		slot4:LoadImage(slot8)
	end

	table.insert(slot0._awardImage, slot6)
	table.insert(slot0._awardImage, slot4)

	gohelper.findChildText(slot1, "txt_rewardcount").text = luaLang("multiple") .. slot2.quantity
	slot11 = slot7.rare or 5

	UISpriteSetMgr.instance:setSeasonSprite(gohelper.findChildImage(slot1, "image_bg"), "img_pz_" .. slot11, true)
	UISpriteSetMgr.instance:setSeasonSprite(gohelper.findChildImage(slot1, "image_circle"), "bg_pinjidi_lanse_" .. slot11)

	slot13 = gohelper.findChildClick(slot1, "btnClick")

	slot13:AddClickListener(slot0._onAwardItemClick, slot0, slot2)
	table.insert(slot0._awardClick, slot13)

	if slot2.materilType == MaterialEnum.MaterialType.EquipCard then
		Season1_4CelebrityCardItem.New():init(gohelper.findChild(slot1, "cardicon"), slot2.materilId)

		slot0._equipAwardCards = slot0._equipAwardCards or {}

		table.insert(slot0._equipAwardCards, slot14)
		gohelper.setActive(gohelper.findChild(slot1, "image_circle"), false)
		gohelper.setActive(gohelper.findChild(slot1, "simage_reward"), false)
		gohelper.setActive(gohelper.findChild(slot1, "image_bg"), false)
	end
end

function slot0._onAwardItemClick(slot0, slot1)
	MaterialTipController.instance:showMaterialInfo(slot1.materilType, slot1.materilId)
end

function slot0.onClose(slot0)
	if slot0._equipAwardCards then
		for slot4, slot5 in ipairs(slot0._equipAwardCards) do
			slot5:destroy()
		end

		slot0._equipAwardCards = nil
	end

	if slot0._showTipsFlow then
		slot0._showTipsFlow:stop()

		slot0._showTipsFlow = nil
	end

	TaskDispatcher.cancelTask(slot0._showHeroItem, slot0)
	TaskDispatcher.cancelTask(slot0._dailyShowHero, slot0)
	TaskDispatcher.cancelTask(slot0._showGetCardView, slot0)
	TaskDispatcher.cancelTask(slot0._btnclosetipOnClick, slot0)
	slot0._simagedecorate6:UnLoadImage()
	slot0._simagedecorate10:UnLoadImage()
	slot0._simagefightsuccbg:UnLoadImage()
	slot0._simageherodecorate:UnLoadImage()
	slot0._simagespecialbg:UnLoadImage()

	if FightResultModel.instance.canUpdateDungeonRecord and not slot0._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end

	slot0:_releaseAwardImage()
end

return slot0

module("modules.logic.seasonver.act123.view1_8.Season123_1_8SettlementView", package.seeall)

slot0 = class("Season123_1_8SettlementView", BaseViewExtended)

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
	slot0._simageherodecorate = gohelper.findChildSingleImage(slot0.viewGO, "#go_settlement/right/herocard/#simage_herodecorate")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._gohero1 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero1")
	slot0._gohero2 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero2")
	slot0._gohero3 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero3")
	slot0._gohero4 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero4")
	slot0._gosupercard1 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/herocard/#go_supercard1")
	slot0._gosupercard2 = gohelper.findChild(slot0.viewGO, "#go_settlement/right/herocard/#go_supercard2")
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
	slot0._gofriendpart = gohelper.findChild(slot0.viewGO, "#go_settlement/#go_cover_friend_part")
	slot0._txtfriendtip = gohelper.findChildText(slot0.viewGO, "#go_settlement/#go_cover_friend_part/tipbg/container/#txt_tips")
	slot0._btnconfirmfriend = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_settlement/#go_cover_friend_part/#btn_cover_friend")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_bottom")
	slot0._gospace = gohelper.findChild(slot0.viewGO, "#go_settlement/right/layout/#go_space")
	slot0._btnstat = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_settlement/right/layout/middle/#btn_stat")
	slot0._totalTime = gohelper.findChildText(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/totaltime/#go_bestcircle/#txt_time")
	slot0._totalTimeBlue = gohelper.findChildText(slot0.viewGO, "#go_settlement/right/layout/#go_bottom/totaltime/#go_bestcircle/#txt_timeblue")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnstat:AddClickListener(slot0._btnstatOnClick, slot0)
	slot0:addClickCb(slot0._btncoverrecord, slot0._onBtnCoverRecordClick, slot0)
	slot0:addClickCb(slot0._btnconfirmfriend, slot0._onBtnConfirmFriendClick, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, slot0._onCoverDungeonRecordReply, slot0)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
	slot0._animationEvent:AddEventListener("reward", slot0._onRewardShow, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnstat:RemoveClickListener()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
	slot0._animationEvent:RemoveEventListener("reward")
end

function slot0._btnstatOnClick(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0._showSettlement(slot0)
	slot0._startTime = Time.realtimeSinceStartup

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_clearing)
	gohelper.setActive(slot0._gosettlement, true)
	gohelper.setActive(slot0._gospecialmarket, true)
	slot0:_checkNewRecord()
	slot0:_detectCoverRecord()
	slot0:_detectAddFriend()
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

		slot0._showTipsFlow:addWork(Season123_1_8SettlementTipsWork.New())
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

function slot0._detectAddFriend(slot0)
	slot1 = true

	if tonumber(FightResultModel.instance.assistUserId or 0) ~= 0 then
		slot1 = SocialModel.instance:isMyFriendByUserId(slot2)
	end

	slot4 = false
	slot7 = slot5 and slot5.stage or nil

	if (Season123Model.instance:getBattleContext() and slot5.actId or nil) and slot7 then
		slot4 = Season123ProgressUtils.checkStageIsFinish(slot6, slot7)
	end

	if not slot1 and slot4 then
		slot0._txtfriendtip.text = formatLuaLang("season123_add_assist_friend", FightResultModel.instance.assistNickname or "")
	end

	gohelper.setActive(slot0._gofriendpart, slot8)
end

function slot0._onBtnConfirmFriendClick(slot0)
	if (FightResultModel.instance.assistUserId or 0) ~= 0 and not SocialController.instance:AddFriend(slot1, slot0._onAddAssistFriendReply, slot0) then
		slot0:_onAddAssistFriendReply()
	end
end

function slot0._onAddAssistFriendReply(slot0)
	gohelper.setActive(slot0._gofriendpart, false)
end

function slot0._editableInitView(slot0)
	slot0._simagedecorate10:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
	slot0._simagefightsuccbg:LoadImage(ResUrl.getSeasonIcon("full/diejia_bj.png"))
	slot0._simageherodecorate:LoadImage(ResUrl.getSeasonIcon("jiesuan_zhujue.png"))
	slot0._simagespecialbg:LoadImage(ResUrl.getSeasonIcon("full/img_bg3.png"))

	slot0._gocardempty1 = gohelper.findChild(slot0._gosupercard1, "#go_supercardempty")
	slot0._gocardpos1 = gohelper.findChild(slot0._gosupercard1, "#go_supercardpos")
	slot0._gocardempty2 = gohelper.findChild(slot0._gosupercard2, "#go_supercardempty")
	slot0._gocardpos2 = gohelper.findChild(slot0._gosupercard2, "#go_supercardpos")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
	gohelper.setActive(slot0._gofightsucc, true)
	gohelper.setActive(slot0._gosettlement, false)

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
	slot0._battleContext = Season123Model.instance:getBattleContext()
	slot0._config = Season123Config.instance:getSeasonEpisodeCo(Season123Model.instance:getCurSeasonId(), slot0._battleContext.stage, slot0._battleContext.layer or 1)

	if not string.nilorempty(Season123ProgressUtils.getResultBg(slot0._config.stagePicture)) then
		slot0._simagedecorate6:LoadImage(slot2)
	end

	slot0._txtindex.text = string.format("%02d", slot1)
	slot0._txtlevelnamecn.text = slot0._episode_config.name

	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = Season123Model.instance:getCurSeasonId(),
		stage = slot0._battleContext.stage,
		layer = slot1
	})
	slot0:_refreshRound()

	slot3 = {}

	tabletool.addValues(slot3, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(slot3, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(slot3, FightResultModel.instance:getMaterialDataList())

	if #slot3 == 0 then
		slot3 = slot0:getCurEpisodeRewards()
	end

	slot4 = {}

	for slot8 = #slot3, 1, -1 do
		if slot3[slot8].materilType == MaterialEnum.MaterialType.Season123EquipCard then
			table.insert(slot4, slot9.materilId)
		end
	end

	slot0:_onHeroItemLoaded()

	if #slot4 > 0 then
		slot0.equip_cards = slot4
	end

	slot0.reward_list = slot3

	TaskDispatcher.runDelay(slot0._delayClosetip, slot0, 1.5)

	if #slot3 == 0 then
		if FightResultModel.instance.firstPass then
			logError("服务器没有下发奖励")
		end

		gohelper.setActive(slot0._gorewards, false)
	end

	gohelper.setActive(slot0._gobottom, #slot3 > 0)

	slot0._reward_list = slot3
	CameraMgr.instance:getCameraRootAnimator().enabled = false

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)
end

function slot0._refreshRound(slot0)
	if not Season123Model.instance:getActInfo(slot0._battleContext.actId) then
		return
	end

	if slot0._battleContext.stage and slot0._battleContext.layer then
		if not slot1:getStageMO(slot0._battleContext.stage) then
			return
		end

		if slot2.episodeMap[slot0._battleContext.layer] and slot3.round then
			slot4 = tostring(slot3.round)
			slot0._totalTime.text = string.format(Season123Controller.instance:isReduceRound(slot0._battleContext.actId, slot0._battleContext.stage, slot0._battleContext.layer) and "<color=#eecd8c>%s</color>" or "%s", slot4)
			slot0._totalTimeBlue.text = slot4
		end
	end
end

function slot0._showSettlementReward(slot0)
	gohelper.addChild(slot0.viewGO, slot0._gorewarditem)
	slot0:com_createObjList(slot0._onRewardItemShow, slot0.reward_list, gohelper.findChild(slot0._scrollrewards.gameObject, "Viewport/Content"), slot0._gorewarditem, nil, 0.1)
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	slot5 = gohelper.findChild(slot1, "go_receive")

	if slot2.materilType == MaterialEnum.MaterialType.Season123EquipCard then
		Season123_1_8CelebrityCardItem.New():init(gohelper.findChild(gohelper.findChild(slot1, "go_prop"), "cardicon"), slot2.materilId)

		slot0._equipAwardCards = slot0._equipAwardCards or {}

		table.insert(slot0._equipAwardCards, slot6)
	else
		slot6 = IconMgr.instance:getCommonPropListItemIcon(slot4)
		slot6._index = slot3

		function slot6.callback(slot0)
			slot0:setCountFontSize(40)
			slot0:hideName()
		end

		slot6:onUpdateMO(slot2)
		slot6:_setItem()
		slot6:setItemColor(not FightResultModel.instance.firstPass and "#7b7b7b" or "#ffffff")
		gohelper.setActive(slot5, slot7)
	end
end

function slot0.getCurEpisodeRewards(slot0)
	if not Season123Config.instance:getSeasonEpisodeCo(slot0._battleContext.actId, slot0._battleContext.stage, slot0._battleContext.layer) then
		return nil
	end

	slot5 = {}

	for slot11, slot12 in ipairs(DungeonModel.instance:getEpisodeFirstBonus(slot4.episodeId)) do
		if ({
			materilType = slot12[1],
			materilId = slot12[2],
			quantity = slot12[3]
		}).materilType ~= MaterialEnum.MaterialType.Faith and slot13.materilType ~= MaterialEnum.MaterialType.Exp then
			slot14 = MaterialDataMO.New()
			slot14.bonusTag = FightEnum.FightBonusTag.AdditionBonus

			slot14:init(slot13)
			table.insert(slot5, slot14)
		end
	end

	table.sort(slot5, FightResultModel._sortMaterial)

	return slot5
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

	gohelper.setActive(slot0._gosupercard1, false)
	gohelper.setActive(slot0._gosupercard2, false)

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
					table.insert(slot0._heroList, slot0:openSubView(Season123_1_8SettlementHeroItem, slot0._hero_obj_list[slot15], nil, slot7, nil, slot8[slot15].equipUid, slot11[tostring(slot16.heroId - 1099511627776.0)] and slot11[slot17].equipUid, nil, slot8[slot15]))
				end
			elseif slot16 ~= "0" then
				table.insert(slot0._heroList, slot0:openSubView(Season123_1_8SettlementHeroItem, slot0._hero_obj_list[slot15], nil, slot7, slot16, slot9[slot15] ~= "0" and slot10[slot16] and slot10[slot16].equipUid, slot16 ~= "0" and slot11[slot16] and slot11[slot16].equipUid))
			end
		end

		slot0:_refreshHeroItemPos()

		if slot11["-100000"] and slot11[slot12].equipUid then
			slot0:setMainPosCardItemByUid(1, slot13[1])
			slot0:setMainPosCardItemByUid(2, slot13[2])
		end
	else
		FightRpc.instance:sendGetFightRecordGroupRequest(slot3.episodeId)
	end
end

function slot0.setMainPosCardItemByUid(slot0, slot1, slot2)
	if not Season123Model.instance:getActInfo(slot0._battleContext.actId).unlockIndexSet[Season123Model.instance:getUnlockCardIndex(Activity123Enum.MainCharPos, slot1)] then
		gohelper.setActive(slot0["_gosupercard" .. tostring(slot1)], false)
	else
		gohelper.setActive(slot3, true)

		slot8 = slot0["_gocardpos" .. tostring(slot1)]

		if slot2 and slot2 ~= "0" then
			gohelper.setActive(slot0["_gocardempty" .. tostring(slot1)], false)
			gohelper.setActive(slot8, true)
			slot0:openSubView(Season123_1_8CelebrityCardGetItem, Season123_1_8CelebrityCardItem.AssetPath, slot8, slot2, true)
		else
			gohelper.setActive(slot7, true)
			gohelper.setActive(slot8, false)
		end
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
			table.insert(slot0._heroList, slot0:openSubView(Season123_1_8SettlementHeroItem, slot6, nil, true, slot7, slot8, slot9, slot10))
		end
	end

	slot0:_refreshHeroItemPos()

	if slot1.replay_activity104Equip_data["-100000"] then
		slot0:setMainPosCardItemById(1, slot1.replay_activity104Equip_data[slot2][1])
		slot0:setMainPosCardItemById(2, slot1.replay_activity104Equip_data[slot2][2])
	end
end

function slot0.setMainPosCardItemById(slot0, slot1, slot2)
	slot3 = nil

	if slot2 then
		slot3 = slot2.equipId
	end

	if not Season123Model.instance:getActInfo(slot0._battleContext.actId).unlockIndexSet[Season123Model.instance:getUnlockCardIndex(Activity123Enum.MainCharPos, slot1)] then
		gohelper.setActive(slot0["_gosupercard" .. tostring(slot1)], false)
	else
		gohelper.setActive(slot4, true)

		slot9 = slot0["_gocardpos" .. tostring(slot1)]

		if slot3 and slot3 ~= 0 then
			gohelper.setActive(slot0["_gocardempty" .. tostring(slot1)], false)
			gohelper.setActive(slot9, true)
			slot0:openSubView(Season123_1_8CelebrityCardGetItem, Season123_1_8CelebrityCardItem.AssetPath, slot9, nil, , slot3)
		else
			gohelper.setActive(slot8, true)
			gohelper.setActive(slot9, false)
		end
	end
end

function slot0._delayClosetip(slot0)
	gohelper.setActive(slot0._gofightsucc, false)
	slot0:_showSettlement()
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
	TaskDispatcher.cancelTask(slot0._delayClosetip, slot0)
	slot0._simagedecorate6:UnLoadImage()
	slot0._simagedecorate10:UnLoadImage()
	slot0._simagefightsuccbg:UnLoadImage()
	slot0._simageherodecorate:UnLoadImage()
	slot0._simagespecialbg:UnLoadImage()

	if FightResultModel.instance.canUpdateDungeonRecord and not slot0._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end
end

return slot0

module("modules.logic.seasonver.act166.view.Season166ResultView", package.seeall)

slot0 = class("Season166ResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._goBaseInfo = gohelper.findChild(slot0.viewGO, "Left/#go_BaseInfo")
	slot0._simageBase = gohelper.findChildSingleImage(slot0.viewGO, "Left/#go_BaseInfo/#simage_Base")
	slot0._txtBase = gohelper.findChildText(slot0.viewGO, "Left/#go_BaseInfo/#txt_Base")
	slot0._imageStar1 = gohelper.findChildImage(slot0.viewGO, "Left/#go_BaseInfo/Star/star1/#image_Star1")
	slot0._imageStar2 = gohelper.findChildImage(slot0.viewGO, "Left/#go_BaseInfo/Star/star2/#image_Star2")
	slot0._imageStar3 = gohelper.findChildImage(slot0.viewGO, "Left/#go_BaseInfo/Star/star3/#image_Star3")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "Left/#go_BaseInfo/Score/#txt_Score")
	slot0._goNewRecord = gohelper.findChild(slot0.viewGO, "Left/#go_BaseInfo/Score/#go_NewRecord")
	slot0._txtNewRecord = gohelper.findChildText(slot0.viewGO, "Left/#go_BaseInfo/Score/#go_NewRecord/#txt_NewRecord")
	slot0._goTrainInfo = gohelper.findChild(slot0.viewGO, "Left/#go_TrainInfo")
	slot0._txtTrain = gohelper.findChildText(slot0.viewGO, "Left/#go_TrainInfo/#txt_Train")
	slot0._goEpisode1 = gohelper.findChild(slot0.viewGO, "Left/#go_TrainInfo/Episode/Episode1/#go_Episode1")
	slot0._goEpisode2 = gohelper.findChild(slot0.viewGO, "Left/#go_TrainInfo/Episode/Episode2/#go_Episode2")
	slot0._goEpisode3 = gohelper.findChild(slot0.viewGO, "Left/#go_TrainInfo/Episode/Episode3/#go_Episode3")
	slot0._goEpisode4 = gohelper.findChild(slot0.viewGO, "Left/#go_TrainInfo/Episode/Episode4/#go_Episode4")
	slot0._goEpisode5 = gohelper.findChild(slot0.viewGO, "Left/#go_TrainInfo/Episode/Episode5/#go_Episode5")
	slot0._goEpisode6 = gohelper.findChild(slot0.viewGO, "Left/#go_TrainInfo/Episode/Episode6/#go_Episode6")
	slot0._simagePlayerHead = gohelper.findChildSingleImage(slot0.viewGO, "Left/Player/PlayerHead/#simage_PlayerHead")
	slot0._txtPlayerName = gohelper.findChildText(slot0.viewGO, "Left/Player/#txt_PlayerName")
	slot0._txtTime = gohelper.findChildText(slot0.viewGO, "Left/Player/#txt_Time")
	slot0._gostarList = gohelper.findChild(slot0.viewGO, "Right/heroitem/heroitemani/hero/vertical/#go_starList")
	slot0._imagetalent = gohelper.findChildImage(slot0.viewGO, "Right/TalentTree/#image_talent")
	slot0._gotalentReddot = gohelper.findChild(slot0.viewGO, "Right/TalentTree/#go_talentReddot")
	slot0._goReward = gohelper.findChild(slot0.viewGO, "Right/#go_Reward")
	slot0._goRewardRoot = gohelper.findChild(slot0.viewGO, "Right/#go_Reward/#go_RewardRoot")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "BtnGroup/#btn_close")
	slot0._btnRank = gohelper.findChildButtonWithAudio(slot0.viewGO, "BtnGroup/#btn_Rank")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnRank:AddClickListener(slot0._btnRankOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnRank:RemoveClickListener()
end

slot1 = "singlebg/seasonver/result/%s.png"

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnRankOnClick(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0._editableInitView(slot0)
	slot0.heroItemList = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.result = Season166Model.instance:getFightResult()

	slot0:_initPlayerInfo()
	slot0:_initHeroGroup()
	slot0:_refreshReward()
	slot0:_initTalentInfo()

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.Season166Base then
		gohelper.setActive(slot0._goTrainInfo, false)
		slot0:_refreshBaseInfo()
		gohelper.setActive(slot0._goBaseInfo, true)
	else
		gohelper.setActive(slot0._goBaseInfo, false)
		slot0:_refreshTrainInfo()
		gohelper.setActive(slot0._goTrainInfo, true)
	end
end

function slot0.onClose(slot0)
	Season166Model.instance:clearFightResult()
	FightController.onResultViewClose()
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshBaseInfo(slot0)
	slot1 = Season166Config.instance:getSeasonBaseSpotCo(slot0.result.activityId, slot0.result.id)
	slot0._txtBase.text = GameUtil.setFirstStrSize(slot1.name, 81)

	slot0._simageBase:LoadImage(string.format(uv0, "season166_result_level" .. slot1.baseId))

	for slot8 = 1, 3 do
		gohelper.setActive(slot0["_imageStar" .. slot8], slot8 <= (Season166BaseSpotModel.instance:getScoreLevelCfg(slot0.result.activityId, slot0.result.id, slot0.result.totalScore) and slot3.star or 0))

		if slot3 and slot3.level == 4 then
			UISpriteSetMgr.instance:setSeason166Sprite(slot0[slot9], "season166_result_bulb3")
		end
	end

	gohelper.setActive(slot0._goNewRecord, slot0.result.isHighestScore)

	slot0._txtScore.text = slot0.result.totalScore
end

function slot0._refreshTrainInfo(slot0)
	for slot5 = 1, 6 do
		if Season166Config.instance:getSeasonTrainCos(slot0.result.activityId)[slot5] then
			slot7 = nil

			if slot6.trainId == slot0.result.id then
				slot0._txtTrain.text = GameUtil.setFirstStrSize(slot6.name, 98)
				slot7 = true
			else
				slot7 = Season166Model.instance:isTrainPass(slot0.result.activityId, slot6.trainId)
			end

			gohelper.setActive(slot0["_goEpisode" .. slot5], slot7)
		end
	end
end

function slot0._refreshReward(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "Right/#go_Reward/#go_RewardRoot/item")

	if #FightResultModel.instance:getMaterialDataList() > 0 then
		for slot6 = 1, #slot2 do
			slot7 = gohelper.clone(slot1, slot0._goRewardRoot, "item" .. slot6)
			slot8 = slot2[slot6]
			slot9 = IconMgr.instance:getCommonItemIcon(slot7)

			slot9:setMOValue(slot8.materilType, slot8.materilId, slot8.quantity)
			slot9:setScale(0.8)
			recthelper.setAnchorY(slot9.tr, 10)
			gohelper.setActive(slot7, true)
		end

		gohelper.setActive(slot0._goReward, true)
	else
		gohelper.setActive(slot0._goReward, false)
	end
end

function slot0._initPlayerInfo(slot0)
	slot2 = PlayerModel.instance:getPlayinfo().portrait

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simagePlayerHead)
	end

	slot0._liveHeadIcon:setLiveHead(slot2)

	slot0._txtTime.text = TimeUtil.getServerDateToString()
	slot0._txtPlayerName.text = slot1.name
end

function slot0._initHeroGroup(slot0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	for slot7 = 1, 8 do
		slot9 = gohelper.clone(gohelper.findChild(slot0.viewGO, "Right/heroitem"), slot7 < 5 and gohelper.findChild(slot0.viewGO, "Right/Group1") or gohelper.findChild(slot0.viewGO, "Right/Group2"))
		slot0.heroItemList[slot7] = MonoHelper.addNoUpdateLuaComOnceToGo(slot9, Season166ResultHeroItem)

		gohelper.setActive(slot9, true)
	end

	slot0:_refreshHeroGroup()
end

function slot0._refreshHeroGroup(slot0)
	slot2, slot3 = FightModel.instance:getFightParam():getHeroEquipMoListWithTrial()

	for slot7 = 1, 4 do
		if slot2[slot7] then
			slot0.heroItemList[slot7]:setData(slot9.heroMo, slot9.equipMo)
		end

		if slot3[slot7] then
			slot0.heroItemList[slot7 + 4]:setData(slot11.heroMo, slot11.equipMo)
		end
	end
end

function slot0._initTalentInfo(slot0)
	if Season166Model.instance:getBattleContext() then
		slot2 = Season166Model.instance:getCurSeasonId()
		slot3 = slot1.talentId
		slot11 = "season166_talentree_btn_talen" .. lua_activity166_talent.configDict[slot2][slot3].sortIndex

		UISpriteSetMgr.instance:setSeason166Sprite(slot0._imagetalent, slot11)

		for slot11 = 1, 3 do
			UISpriteSetMgr.instance:setSeason166Sprite(gohelper.findChildImage(slot0.viewGO, "Right/TalentTree/equipslot/" .. slot11 .. "/light"), "season166_talentree_pointl" .. tostring(slot5.sortIndex))
			gohelper.setActive(gohelper.findChild(slot0.viewGO, "Right/TalentTree/equipslot/" .. slot11), slot11 <= lua_activity166_talent_style.configDict[slot3][Season166Model.instance:getTalentInfo(slot2, slot3).level].slot)
			gohelper.setActive(slot13, slot11 <= #slot4.skillIds)
			gohelper.setActive(gohelper.findChild(slot12, "light/" .. slot5.sortIndex), slot11 <= #slot4.skillIds)
		end
	end
end

return slot0

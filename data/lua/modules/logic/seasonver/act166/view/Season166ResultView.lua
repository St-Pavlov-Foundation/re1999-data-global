module("modules.logic.seasonver.act166.view.Season166ResultView", package.seeall)

local var_0_0 = class("Season166ResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._goBaseInfo = gohelper.findChild(arg_1_0.viewGO, "Left/#go_BaseInfo")
	arg_1_0._simageBase = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#go_BaseInfo/#simage_Base")
	arg_1_0._txtBase = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_BaseInfo/#txt_Base")
	arg_1_0._imageStar1 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_BaseInfo/Star/star1/#image_Star1")
	arg_1_0._imageStar2 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_BaseInfo/Star/star2/#image_Star2")
	arg_1_0._imageStar3 = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_BaseInfo/Star/star3/#image_Star3")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_BaseInfo/Score/#txt_Score")
	arg_1_0._goNewRecord = gohelper.findChild(arg_1_0.viewGO, "Left/#go_BaseInfo/Score/#go_NewRecord")
	arg_1_0._txtNewRecord = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_BaseInfo/Score/#go_NewRecord/#txt_NewRecord")
	arg_1_0._goTrainInfo = gohelper.findChild(arg_1_0.viewGO, "Left/#go_TrainInfo")
	arg_1_0._txtTrain = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_TrainInfo/#txt_Train")
	arg_1_0._goEpisode1 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_TrainInfo/Episode/Episode1/#go_Episode1")
	arg_1_0._goEpisode2 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_TrainInfo/Episode/Episode2/#go_Episode2")
	arg_1_0._goEpisode3 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_TrainInfo/Episode/Episode3/#go_Episode3")
	arg_1_0._goEpisode4 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_TrainInfo/Episode/Episode4/#go_Episode4")
	arg_1_0._goEpisode5 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_TrainInfo/Episode/Episode5/#go_Episode5")
	arg_1_0._goEpisode6 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_TrainInfo/Episode/Episode6/#go_Episode6")
	arg_1_0._simagePlayerHead = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/Player/PlayerHead/#simage_PlayerHead")
	arg_1_0._txtPlayerName = gohelper.findChildText(arg_1_0.viewGO, "Left/Player/#txt_PlayerName")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "Left/Player/#txt_Time")
	arg_1_0._gostarList = gohelper.findChild(arg_1_0.viewGO, "Right/heroitem/heroitemani/hero/vertical/#go_starList")
	arg_1_0._imagetalent = gohelper.findChildImage(arg_1_0.viewGO, "Right/TalentTree/#image_talent")
	arg_1_0._gotalentReddot = gohelper.findChild(arg_1_0.viewGO, "Right/TalentTree/#go_talentReddot")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Reward")
	arg_1_0._goRewardRoot = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Reward/#go_RewardRoot")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BtnGroup/#btn_close")
	arg_1_0._btnRank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BtnGroup/#btn_Rank")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnRank:AddClickListener(arg_2_0._btnRankOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnRank:RemoveClickListener()
end

local var_0_1 = "singlebg/seasonver/result/%s.png"

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnRankOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.heroItemList = {}
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.result = Season166Model.instance:getFightResult()

	local var_8_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	arg_8_0:_initPlayerInfo()
	arg_8_0:_initHeroGroup()
	arg_8_0:_refreshReward()
	arg_8_0:_initTalentInfo()

	if var_8_0.type == DungeonEnum.EpisodeType.Season166Base then
		gohelper.setActive(arg_8_0._goTrainInfo, false)
		arg_8_0:_refreshBaseInfo()
		gohelper.setActive(arg_8_0._goBaseInfo, true)
	else
		gohelper.setActive(arg_8_0._goBaseInfo, false)
		arg_8_0:_refreshTrainInfo()
		gohelper.setActive(arg_8_0._goTrainInfo, true)
	end
end

function var_0_0.onClose(arg_9_0)
	Season166Model.instance:clearFightResult()
	FightController.onResultViewClose()
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0._refreshBaseInfo(arg_11_0)
	local var_11_0 = Season166Config.instance:getSeasonBaseSpotCo(arg_11_0.result.activityId, arg_11_0.result.id)

	arg_11_0._txtBase.text = GameUtil.setFirstStrSize(var_11_0.name, 81)

	local var_11_1 = string.format(var_0_1, "season166_result_level" .. var_11_0.baseId)

	arg_11_0._simageBase:LoadImage(var_11_1)

	local var_11_2 = Season166BaseSpotModel.instance:getScoreLevelCfg(arg_11_0.result.activityId, arg_11_0.result.id, arg_11_0.result.totalScore)
	local var_11_3 = var_11_2 and var_11_2.star or 0

	for iter_11_0 = 1, 3 do
		local var_11_4 = "_imageStar" .. iter_11_0

		gohelper.setActive(arg_11_0[var_11_4], iter_11_0 <= var_11_3)

		if var_11_2 and var_11_2.level == 4 then
			UISpriteSetMgr.instance:setSeason166Sprite(arg_11_0[var_11_4], "season166_result_bulb3")
		end
	end

	gohelper.setActive(arg_11_0._goNewRecord, arg_11_0.result.isHighestScore)

	arg_11_0._txtScore.text = arg_11_0.result.totalScore
end

function var_0_0._refreshTrainInfo(arg_12_0)
	local var_12_0 = Season166Config.instance:getSeasonTrainCos(arg_12_0.result.activityId)

	for iter_12_0 = 1, 6 do
		local var_12_1 = var_12_0[iter_12_0]

		if var_12_1 then
			local var_12_2
			local var_12_3

			if var_12_1.trainId == arg_12_0.result.id then
				arg_12_0._txtTrain.text = GameUtil.setFirstStrSize(var_12_1.name, 98)
				var_12_3 = true
			else
				var_12_3 = Season166Model.instance:isTrainPass(arg_12_0.result.activityId, var_12_1.trainId)
			end

			gohelper.setActive(arg_12_0["_goEpisode" .. iter_12_0], var_12_3)
		end
	end
end

function var_0_0._refreshReward(arg_13_0)
	local var_13_0 = gohelper.findChild(arg_13_0.viewGO, "Right/#go_Reward/#go_RewardRoot/item")
	local var_13_1 = FightResultModel.instance:getMaterialDataList()

	if #var_13_1 > 0 then
		for iter_13_0 = 1, #var_13_1 do
			local var_13_2 = gohelper.clone(var_13_0, arg_13_0._goRewardRoot, "item" .. iter_13_0)
			local var_13_3 = var_13_1[iter_13_0]
			local var_13_4 = IconMgr.instance:getCommonItemIcon(var_13_2)

			var_13_4:setMOValue(var_13_3.materilType, var_13_3.materilId, var_13_3.quantity)
			var_13_4:setScale(0.8)
			recthelper.setAnchorY(var_13_4.tr, 10)
			gohelper.setActive(var_13_2, true)
		end

		gohelper.setActive(arg_13_0._goReward, true)
	else
		gohelper.setActive(arg_13_0._goReward, false)
	end
end

function var_0_0._initPlayerInfo(arg_14_0)
	local var_14_0 = PlayerModel.instance:getPlayinfo()
	local var_14_1 = var_14_0.portrait

	if not arg_14_0._liveHeadIcon then
		arg_14_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_14_0._simagePlayerHead)
	end

	arg_14_0._liveHeadIcon:setLiveHead(var_14_1)

	arg_14_0._txtTime.text = TimeUtil.getServerDateToString()
	arg_14_0._txtPlayerName.text = var_14_0.name
end

function var_0_0._initHeroGroup(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	local var_15_0 = gohelper.findChild(arg_15_0.viewGO, "Right/heroitem")
	local var_15_1 = gohelper.findChild(arg_15_0.viewGO, "Right/Group1")
	local var_15_2 = gohelper.findChild(arg_15_0.viewGO, "Right/Group2")

	for iter_15_0 = 1, 8 do
		local var_15_3 = iter_15_0 < 5 and var_15_1 or var_15_2
		local var_15_4 = gohelper.clone(var_15_0, var_15_3)

		arg_15_0.heroItemList[iter_15_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_4, Season166ResultHeroItem)

		gohelper.setActive(var_15_4, true)
	end

	arg_15_0:_refreshHeroGroup()
end

function var_0_0._refreshHeroGroup(arg_16_0)
	local var_16_0, var_16_1 = FightModel.instance:getFightParam():getHeroEquipMoListWithTrial()

	for iter_16_0 = 1, 4 do
		local var_16_2 = arg_16_0.heroItemList[iter_16_0]
		local var_16_3 = var_16_0[iter_16_0]

		if var_16_3 then
			var_16_2:setData(var_16_3.heroMo, var_16_3.equipMo)
		end

		local var_16_4 = arg_16_0.heroItemList[iter_16_0 + 4]
		local var_16_5 = var_16_1[iter_16_0]

		if var_16_5 then
			var_16_4:setData(var_16_5.heroMo, var_16_5.equipMo)
		end
	end
end

function var_0_0._initTalentInfo(arg_17_0)
	local var_17_0 = Season166Model.instance:getBattleContext()

	if var_17_0 then
		local var_17_1 = Season166Model.instance:getCurSeasonId()
		local var_17_2 = var_17_0.talentId
		local var_17_3 = Season166Model.instance:getTalentInfo(var_17_1, var_17_2)
		local var_17_4 = lua_activity166_talent.configDict[var_17_1][var_17_2]
		local var_17_5 = lua_activity166_talent_style.configDict[var_17_2][var_17_3.level]
		local var_17_6 = "season166_talentree_btn_talen" .. var_17_4.sortIndex

		UISpriteSetMgr.instance:setSeason166Sprite(arg_17_0._imagetalent, var_17_6)

		for iter_17_0 = 1, 3 do
			local var_17_7 = gohelper.findChild(arg_17_0.viewGO, "Right/TalentTree/equipslot/" .. iter_17_0)
			local var_17_8 = gohelper.findChildImage(arg_17_0.viewGO, "Right/TalentTree/equipslot/" .. iter_17_0 .. "/light")

			UISpriteSetMgr.instance:setSeason166Sprite(var_17_8, "season166_talentree_pointl" .. tostring(var_17_4.sortIndex))
			gohelper.setActive(var_17_7, iter_17_0 <= var_17_5.slot)
			gohelper.setActive(var_17_8, iter_17_0 <= #var_17_3.skillIds)

			local var_17_9 = gohelper.findChild(var_17_7, "light/" .. var_17_4.sortIndex)

			gohelper.setActive(var_17_9, iter_17_0 <= #var_17_3.skillIds)
		end
	end
end

return var_0_0

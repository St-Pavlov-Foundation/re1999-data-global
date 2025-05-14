module("modules.logic.seasonver.act123.view2_0.Season123_2_0SettlementView", package.seeall)

local var_0_0 = class("Season123_2_0SettlementView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosettlement = gohelper.findChild(arg_1_0.viewGO, "#go_settlement")
	arg_1_0._gospecialmarket = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_specialmarket")
	arg_1_0._simagespecialbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_settlement/#go_specialmarket/#simage_specialbg")
	arg_1_0._animationEvent = arg_1_0._gosettlement:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_settlement/#btn_close")
	arg_1_0._simagedecorate6 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_settlement/decorate/mask/#simage_decorate6")
	arg_1_0._simagedecorate10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_settlement/decorate/mask/#simage_decorate10")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/left/#simage_circlebg/#txt_index")
	arg_1_0._txtlevelnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/left/#txt_levelnamecn")
	arg_1_0._simageherodecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_settlement/right/herocard/#simage_herodecorate")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/#go_rewards/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._gohero1 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero1")
	arg_1_0._gohero2 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero2")
	arg_1_0._gohero3 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero3")
	arg_1_0._gohero4 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_top/herogroup/#go_hero4")
	arg_1_0._gosupercard1 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/herocard/#go_supercard1")
	arg_1_0._gosupercard2 = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/herocard/#go_supercard2")
	arg_1_0._gofightsucc = gohelper.findChild(arg_1_0.viewGO, "#go_fightsucc")
	arg_1_0._simagefightsuccbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_fightsucc/#simage_fightsuccbg")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightsucc/#btn_closetip")
	arg_1_0._gocoverrecordpart = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part")
	arg_1_0._btncoverrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/#btn_cover_record")
	arg_1_0._txtcurroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/current/#txt_curroundcount")
	arg_1_0._txtmaxroundcount = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/memory/#txt_maxroundcount")
	arg_1_0._goCoverLessThan = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_lessthan")
	arg_1_0._goCoverMuchThan = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_muchthan")
	arg_1_0._goCoverEqual = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_record_part/tipbg/container/middle/#go_equal")
	arg_1_0._gofriendpart = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/#go_cover_friend_part")
	arg_1_0._txtfriendtip = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/#go_cover_friend_part/tipbg/container/#txt_tips")
	arg_1_0._btnconfirmfriend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_settlement/#go_cover_friend_part/#btn_cover_friend")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom")
	arg_1_0._gospace = gohelper.findChild(arg_1_0.viewGO, "#go_settlement/right/layout/#go_space")
	arg_1_0._btnstat = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_settlement/right/layout/middle/#btn_stat")
	arg_1_0._totalTime = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/totaltime/#go_bestcircle/#txt_time")
	arg_1_0._totalTimeBlue = gohelper.findChildText(arg_1_0.viewGO, "#go_settlement/right/layout/#go_bottom/totaltime/#go_bestcircle/#txt_timeblue")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnstat:AddClickListener(arg_2_0._btnstatOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btncoverrecord, arg_2_0._onBtnCoverRecordClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnconfirmfriend, arg_2_0._onBtnConfirmFriendClick, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnCoverDungeonRecordReply, arg_2_0._onCoverDungeonRecordReply, arg_2_0)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, arg_2_0._onGetFightRecordGroupReply, arg_2_0)
	arg_2_0._animationEvent:AddEventListener("reward", arg_2_0._onRewardShow, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnstat:RemoveClickListener()
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_3_0._onGetFightRecordGroupReply, arg_3_0)
	arg_3_0._animationEvent:RemoveEventListener("reward")
end

function var_0_0._btnstatOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._showSettlement(arg_5_0)
	arg_5_0._startTime = Time.realtimeSinceStartup

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_clearing)
	gohelper.setActive(arg_5_0._gosettlement, true)
	gohelper.setActive(arg_5_0._gospecialmarket, true)
	arg_5_0:_checkNewRecord()
	arg_5_0:_detectCoverRecord()
	arg_5_0:_detectAddFriend()
	TaskDispatcher.runDelay(arg_5_0._dailyShowHero, arg_5_0, 0.6)
end

function var_0_0._onRewardShow(arg_6_0)
	arg_6_0:_showSettlementReward()
end

function var_0_0._dailyShowHero(arg_7_0)
	arg_7_0._heroIndex = 0

	TaskDispatcher.runRepeat(arg_7_0._showHeroItem, arg_7_0, 0.03, #arg_7_0._heroList)
	TaskDispatcher.runDelay(arg_7_0._showGetCardView, arg_7_0, 1.5)
end

function var_0_0._showHeroItem(arg_8_0)
	arg_8_0._heroIndex = arg_8_0._heroIndex + 1

	gohelper.setActive(arg_8_0._heroList[arg_8_0._heroIndex].viewGO, true)
end

function var_0_0._showGetCardView(arg_9_0)
	if arg_9_0.equip_cards then
		arg_9_0._showTipsFlow = FlowSequence.New()

		arg_9_0._showTipsFlow:addWork(Season123_2_0SettlementTipsWork.New())
		arg_9_0._showTipsFlow:registerDoneListener(arg_9_0._onShowTipsFlowDone, arg_9_0)

		local var_9_0 = {}

		var_9_0.delayTime = 0

		arg_9_0._showTipsFlow:start(var_9_0)
	end
end

function var_0_0._onShowTipsFlowDone(arg_10_0)
	arg_10_0.equip_cards = nil
end

function var_0_0._checkNewRecord(arg_11_0)
	if FightResultModel.instance.updateDungeonRecord then
		GameFacade.showToast(ToastEnum.FightNewRecord)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	end
end

function var_0_0._onCoverDungeonRecordReply(arg_12_0, arg_12_1)
	arg_12_0._hasSendCoverRecord = true

	gohelper.setActive(arg_12_0._gocoverrecordpart, false)

	if arg_12_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
		GameFacade.showToast(ToastEnum.FightSuccIsCover)
	end
end

function var_0_0._detectCoverRecord(arg_13_0)
	gohelper.setActive(arg_13_0._gocoverrecordpart, FightResultModel.instance.canUpdateDungeonRecord or false)

	if FightResultModel.instance.canUpdateDungeonRecord then
		arg_13_0._txtcurroundcount.text = FightResultModel.instance.newRecordRound or ""
		arg_13_0._txtmaxroundcount.text = FightResultModel.instance.oldRecordRound or ""

		gohelper.setActive(arg_13_0._goCoverLessThan, FightResultModel.instance.newRecordRound < FightResultModel.instance.oldRecordRound)
		gohelper.setActive(arg_13_0._goCoverMuchThan, FightResultModel.instance.newRecordRound > FightResultModel.instance.oldRecordRound)
		gohelper.setActive(arg_13_0._goCoverEqual, FightResultModel.instance.newRecordRound == FightResultModel.instance.oldRecordRound)

		if FightResultModel.instance.newRecordRound >= FightResultModel.instance.oldRecordRound then
			arg_13_0._txtcurroundcount.color = GameUtil.parseColor("#272525")
		else
			arg_13_0._txtcurroundcount.color = GameUtil.parseColor("#AC5320")
		end
	end
end

function var_0_0._onBtnCoverRecordClick(arg_14_0)
	DungeonRpc.instance:sendCoverDungeonRecordRequest(true)
end

function var_0_0._detectAddFriend(arg_15_0)
	local var_15_0 = true
	local var_15_1 = FightResultModel.instance.assistUserId or 0

	if tonumber(var_15_1) ~= 0 then
		var_15_0 = SocialModel.instance:isMyFriendByUserId(var_15_1)
	end

	local var_15_2 = false
	local var_15_3 = Season123Model.instance:getBattleContext()
	local var_15_4 = var_15_3 and var_15_3.actId or nil
	local var_15_5 = var_15_3 and var_15_3.stage or nil

	if var_15_4 and var_15_5 then
		var_15_2 = Season123ProgressUtils.checkStageIsFinish(var_15_4, var_15_5)
	end

	local var_15_6 = not var_15_0 and var_15_2

	if var_15_6 then
		local var_15_7 = FightResultModel.instance.assistNickname or ""

		arg_15_0._txtfriendtip.text = formatLuaLang("season123_add_assist_friend", var_15_7)
	end

	gohelper.setActive(arg_15_0._gofriendpart, var_15_6)
end

function var_0_0._onBtnConfirmFriendClick(arg_16_0)
	local var_16_0 = FightResultModel.instance.assistUserId or 0

	if var_16_0 ~= 0 and not SocialController.instance:AddFriend(var_16_0, arg_16_0._onAddAssistFriendReply, arg_16_0) then
		arg_16_0:_onAddAssistFriendReply()
	end
end

function var_0_0._onAddAssistFriendReply(arg_17_0)
	gohelper.setActive(arg_17_0._gofriendpart, false)
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._simagedecorate10:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
	arg_18_0._simagefightsuccbg:LoadImage(ResUrl.getSeasonIcon("full/diejia_bj.png"))
	arg_18_0._simageherodecorate:LoadImage(ResUrl.getSeasonIcon("jiesuan_zhujue.png"))
	arg_18_0._simagespecialbg:LoadImage(ResUrl.getSeasonIcon("full/img_bg3.png"))

	arg_18_0._gocardempty1 = gohelper.findChild(arg_18_0._gosupercard1, "#go_supercardempty")
	arg_18_0._gocardpos1 = gohelper.findChild(arg_18_0._gosupercard1, "#go_supercardpos")
	arg_18_0._gocardempty2 = gohelper.findChild(arg_18_0._gosupercard2, "#go_supercardempty")
	arg_18_0._gocardpos2 = gohelper.findChild(arg_18_0._gosupercard2, "#go_supercardpos")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
	gohelper.setActive(arg_18_0._gofightsucc, true)
	gohelper.setActive(arg_18_0._gosettlement, false)

	arg_18_0._fightsucc_click = gohelper.getClick(arg_18_0._gofightsucc)
end

function var_0_0._btncloseOnClick(arg_19_0)
	if Time.realtimeSinceStartup - arg_19_0._startTime < 2.5 then
		return
	end

	if arg_19_0.equip_cards then
		return
	end

	arg_19_0:closeThis()

	local var_19_0 = FightModel.instance:getAfterStory()

	if var_19_0 > 0 and not StoryModel.instance:isStoryFinished(var_19_0) then
		local var_19_1 = {}

		var_19_1.mark = true
		var_19_1.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_19_0, var_19_1, function()
			FightSuccView.onStoryEnd()
		end)

		return
	end

	FightSuccView.onStoryEnd()
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0._startTime = Time.realtimeSinceStartup
	arg_21_0._episode_config = lua_episode.configDict[FightResultModel.instance:getEpisodeId()]
	arg_21_0._battleContext = Season123Model.instance:getBattleContext()

	local var_21_0 = arg_21_0._battleContext.layer or 1

	arg_21_0._config = Season123Config.instance:getSeasonEpisodeCo(Season123Model.instance:getCurSeasonId(), arg_21_0._battleContext.stage, var_21_0)

	local var_21_1 = Season123ProgressUtils.getResultBg(arg_21_0._config.stagePicture)

	if not string.nilorempty(var_21_1) then
		arg_21_0._simagedecorate6:LoadImage(var_21_1)
	end

	arg_21_0._txtindex.text = string.format("%02d", var_21_0)
	arg_21_0._txtlevelnamecn.text = arg_21_0._episode_config.name

	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = Season123Model.instance:getCurSeasonId(),
		stage = arg_21_0._battleContext.stage,
		layer = var_21_0
	})
	arg_21_0:_refreshRound()

	local var_21_2 = {}

	tabletool.addValues(var_21_2, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(var_21_2, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(var_21_2, FightResultModel.instance:getMaterialDataList())

	if #var_21_2 == 0 then
		var_21_2 = arg_21_0:getCurEpisodeRewards()
	end

	local var_21_3 = {}

	for iter_21_0 = #var_21_2, 1, -1 do
		local var_21_4 = var_21_2[iter_21_0]

		if var_21_4.materilType == MaterialEnum.MaterialType.Season123EquipCard then
			table.insert(var_21_3, var_21_4.materilId)
		end
	end

	arg_21_0:_onHeroItemLoaded()

	if #var_21_3 > 0 then
		arg_21_0.equip_cards = var_21_3
	end

	arg_21_0.reward_list = var_21_2

	TaskDispatcher.runDelay(arg_21_0._delayClosetip, arg_21_0, 1.5)

	if #var_21_2 == 0 then
		if FightResultModel.instance.firstPass then
			logError("服务器没有下发奖励")
		end

		gohelper.setActive(arg_21_0._gorewards, false)
	end

	gohelper.setActive(arg_21_0._gobottom, #var_21_2 > 0)

	arg_21_0._reward_list = var_21_2
	CameraMgr.instance:getCameraRootAnimator().enabled = false

	NavigateMgr.instance:addEscape(arg_21_0.viewName, arg_21_0._btncloseOnClick, arg_21_0)
end

function var_0_0._refreshRound(arg_22_0)
	local var_22_0 = Season123Model.instance:getActInfo(arg_22_0._battleContext.actId)

	if not var_22_0 then
		return
	end

	if arg_22_0._battleContext.stage and arg_22_0._battleContext.layer then
		local var_22_1 = var_22_0:getStageMO(arg_22_0._battleContext.stage)

		if not var_22_1 then
			return
		end

		local var_22_2 = var_22_1.episodeMap[arg_22_0._battleContext.layer]

		if var_22_2 and var_22_2.round then
			local var_22_3 = tostring(var_22_2.round)
			local var_22_4 = arg_22_0._battleContext.actId
			local var_22_5 = arg_22_0._battleContext.stage
			local var_22_6 = arg_22_0._battleContext.layer
			local var_22_7 = Season123Controller.instance:isReduceRound(var_22_4, var_22_5, var_22_6) and "<color=#eecd8c>%s</color>" or "%s"

			arg_22_0._totalTime.text = string.format(var_22_7, var_22_3)
			arg_22_0._totalTimeBlue.text = var_22_3
		end
	end
end

function var_0_0._showSettlementReward(arg_23_0)
	local var_23_0 = gohelper.findChild(arg_23_0._scrollrewards.gameObject, "Viewport/Content")

	gohelper.addChild(arg_23_0.viewGO, arg_23_0._gorewarditem)
	arg_23_0:com_createObjList(arg_23_0._onRewardItemShow, arg_23_0.reward_list, var_23_0, arg_23_0._gorewarditem, nil, 0.1)
end

function var_0_0._onRewardItemShow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = gohelper.findChild(arg_24_1, "go_prop")
	local var_24_1 = gohelper.findChild(arg_24_1, "go_receive")

	if arg_24_2.materilType == MaterialEnum.MaterialType.Season123EquipCard then
		local var_24_2 = Season123_2_0CelebrityCardItem.New()

		var_24_2:init(gohelper.findChild(var_24_0, "cardicon"), arg_24_2.materilId)

		arg_24_0._equipAwardCards = arg_24_0._equipAwardCards or {}

		table.insert(arg_24_0._equipAwardCards, var_24_2)
	else
		local var_24_3 = IconMgr.instance:getCommonPropListItemIcon(var_24_0)

		var_24_3._index = arg_24_3

		function var_24_3.callback(arg_25_0)
			arg_25_0:setCountFontSize(40)
			arg_25_0:hideName()
		end

		var_24_3:onUpdateMO(arg_24_2)
		var_24_3:_setItem()

		local var_24_4 = not FightResultModel.instance.firstPass
		local var_24_5 = var_24_4 and "#7b7b7b" or "#ffffff"

		var_24_3:setItemColor(var_24_5)
		gohelper.setActive(var_24_1, var_24_4)
	end
end

function var_0_0.getCurEpisodeRewards(arg_26_0)
	local var_26_0 = arg_26_0._battleContext.actId
	local var_26_1 = arg_26_0._battleContext.stage
	local var_26_2 = arg_26_0._battleContext.layer
	local var_26_3 = Season123Config.instance:getSeasonEpisodeCo(var_26_0, var_26_1, var_26_2)

	if not var_26_3 then
		return nil
	end

	local var_26_4 = {}
	local var_26_5 = DungeonModel.instance:getEpisodeFirstBonus(var_26_3.episodeId)
	local var_26_6 = FightEnum.FightBonusTag.AdditionBonus

	for iter_26_0, iter_26_1 in ipairs(var_26_5) do
		local var_26_7 = {
			materilType = iter_26_1[1],
			materilId = iter_26_1[2],
			quantity = iter_26_1[3]
		}

		if var_26_7.materilType ~= MaterialEnum.MaterialType.Faith and var_26_7.materilType ~= MaterialEnum.MaterialType.Exp then
			local var_26_8 = MaterialDataMO.New()

			var_26_8.bonusTag = var_26_6

			var_26_8:init(var_26_7)
			table.insert(var_26_4, var_26_8)
		end
	end

	table.sort(var_26_4, FightResultModel._sortMaterial)

	return var_26_4
end

local var_0_1 = {
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

function var_0_0._onHeroItemLoaded(arg_27_0)
	arg_27_0._heroList = {}
	arg_27_0._hero_obj_list = arg_27_0:getUserDataTb_()

	local var_27_0 = arg_27_0.viewContainer:getSetting().otherRes.itemRes

	for iter_27_0 = 1, 4 do
		local var_27_1 = arg_27_0.viewContainer:getResInst(var_27_0, arg_27_0["_gohero" .. iter_27_0])

		gohelper.setActive(var_27_1, false)
		table.insert(arg_27_0._hero_obj_list, var_27_1)
	end

	gohelper.setActive(arg_27_0._gosupercard1, false)
	gohelper.setActive(arg_27_0._gosupercard2, false)

	local var_27_2 = FightModel.instance:getFightParam()
	local var_27_3 = FightModel.instance:getBattleId()
	local var_27_4 = var_27_3 and lua_battle.configDict[var_27_3]
	local var_27_5 = var_27_4 and var_27_4.playerMax or ModuleEnum.HeroCountInGroup
	local var_27_6 = FightModel.instance.curFightModel

	if not var_27_6 then
		local var_27_7 = {}
		local var_27_8 = {}

		for iter_27_1, iter_27_2 in ipairs(var_27_2.mySideUids) do
			table.insert(var_27_8, iter_27_2)
		end

		for iter_27_3, iter_27_4 in ipairs(var_27_2.mySideSubUids) do
			table.insert(var_27_8, iter_27_4)
		end

		local var_27_9 = {}

		for iter_27_5, iter_27_6 in ipairs(var_27_2.equips) do
			var_27_9[iter_27_6.heroUid] = iter_27_6
		end

		local var_27_10 = {}

		for iter_27_7, iter_27_8 in ipairs(var_27_2.activity104Equips) do
			var_27_10[iter_27_8.heroUid] = iter_27_8
		end

		if var_27_2.trialHeroList then
			for iter_27_9, iter_27_10 in ipairs(var_27_2.trialHeroList) do
				local var_27_11 = iter_27_10.pos

				if var_27_11 < 0 then
					var_27_11 = var_27_5 - var_27_11
				end

				var_27_7[var_27_11] = iter_27_10

				table.insert(var_27_8, var_27_11, 0)
			end
		end

		for iter_27_11 = 1, 4 do
			if var_27_7[iter_27_11] then
				local var_27_12 = lua_hero_trial.configDict[var_27_7[iter_27_11].trialId][0]

				if var_27_12 then
					local var_27_13 = tostring(var_27_12.heroId - 1099511627776)
					local var_27_14 = var_27_7[iter_27_11].equipUid
					local var_27_15 = var_27_10[var_27_13] and var_27_10[var_27_13].equipUid
					local var_27_16 = arg_27_0:openSubView(Season123_2_0SettlementHeroItem, arg_27_0._hero_obj_list[iter_27_11], nil, var_27_6, nil, var_27_14, var_27_15, nil, var_27_7[iter_27_11])

					table.insert(arg_27_0._heroList, var_27_16)
				end
			else
				local var_27_17 = var_27_8[iter_27_11]
				local var_27_18 = var_27_17 ~= "0" and var_27_9[var_27_17] and var_27_9[var_27_17].equipUid
				local var_27_19 = var_27_17 ~= "0" and var_27_10[var_27_17] and var_27_10[var_27_17].equipUid
				local var_27_20 = arg_27_0:openSubView(Season123_2_0SettlementHeroItem, arg_27_0._hero_obj_list[iter_27_11], nil, var_27_6, var_27_17, var_27_18, var_27_19)

				if var_27_17 ~= "0" then
					table.insert(arg_27_0._heroList, var_27_20)
				end
			end
		end

		arg_27_0:_refreshHeroItemPos()

		local var_27_21 = "-100000"

		if var_27_10[var_27_21] then
			local var_27_22 = var_27_10[var_27_21].equipUid

			if var_27_22 then
				arg_27_0:setMainPosCardItemByUid(1, var_27_22[1])
				arg_27_0:setMainPosCardItemByUid(2, var_27_22[2])
			end
		end
	else
		FightRpc.instance:sendGetFightRecordGroupRequest(var_27_2.episodeId)
	end
end

function var_0_0.setMainPosCardItemByUid(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0["_gosupercard" .. tostring(arg_28_1)]
	local var_28_1 = arg_28_0._battleContext.actId
	local var_28_2 = Season123Model.instance:getActInfo(var_28_1)
	local var_28_3 = Season123Model.instance:getUnlockCardIndex(Activity123Enum.MainCharPos, arg_28_1)

	if not var_28_2.unlockIndexSet[var_28_3] then
		gohelper.setActive(var_28_0, false)
	else
		gohelper.setActive(var_28_0, true)

		local var_28_4 = arg_28_0["_gocardempty" .. tostring(arg_28_1)]
		local var_28_5 = arg_28_0["_gocardpos" .. tostring(arg_28_1)]

		if arg_28_2 and arg_28_2 ~= "0" then
			gohelper.setActive(var_28_4, false)
			gohelper.setActive(var_28_5, true)
			arg_28_0:openSubView(Season123_2_0CelebrityCardGetItem, Season123_2_0CelebrityCardItem.AssetPath, var_28_5, arg_28_2, true)
		else
			gohelper.setActive(var_28_4, true)
			gohelper.setActive(var_28_5, false)
		end
	end
end

function var_0_0._refreshHeroItemPos(arg_29_0)
	local var_29_0 = arg_29_0._heroList and #arg_29_0._heroList or 0

	if var_29_0 <= 0 then
		return
	end

	local var_29_1 = var_0_1[var_29_0]

	for iter_29_0 = 1, var_29_0 do
		recthelper.setAnchor(arg_29_0._heroList[iter_29_0].viewGO.transform.parent, var_29_1[iter_29_0].x, var_29_1[iter_29_0].y)
	end
end

function var_0_0._onGetFightRecordGroupReply(arg_30_0, arg_30_1)
	for iter_30_0 = 1, 4 do
		local var_30_0 = arg_30_0._hero_obj_list[iter_30_0]
		local var_30_1 = arg_30_1:getHeroByIndex(iter_30_0)
		local var_30_2 = arg_30_1.replay_equip_data[var_30_1]
		local var_30_3 = arg_30_1.replay_activity104Equip_data[var_30_1]
		local var_30_4 = arg_30_1.replay_hero_data[var_30_1]

		if not var_30_4 then
			for iter_30_1, iter_30_2 in pairs(arg_30_1.replay_hero_data) do
				if iter_30_2.heroId == var_30_1 then
					var_30_4 = iter_30_2

					break
				end
			end
		end

		local var_30_5 = arg_30_0:openSubView(Season123_2_0SettlementHeroItem, var_30_0, nil, true, var_30_1, var_30_2, var_30_3, var_30_4)

		if var_30_1 ~= "0" then
			table.insert(arg_30_0._heroList, var_30_5)
		end
	end

	arg_30_0:_refreshHeroItemPos()

	local var_30_6 = "-100000"

	if arg_30_1.replay_activity104Equip_data[var_30_6] then
		local var_30_7 = arg_30_1.replay_activity104Equip_data[var_30_6][1]
		local var_30_8 = arg_30_1.replay_activity104Equip_data[var_30_6][2]

		arg_30_0:setMainPosCardItemById(1, var_30_7)
		arg_30_0:setMainPosCardItemById(2, var_30_8)
	end
end

function var_0_0.setMainPosCardItemById(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0

	if arg_31_2 then
		var_31_0 = arg_31_2.equipId
	end

	local var_31_1 = arg_31_0["_gosupercard" .. tostring(arg_31_1)]
	local var_31_2 = arg_31_0._battleContext.actId
	local var_31_3 = Season123Model.instance:getActInfo(var_31_2)
	local var_31_4 = Season123Model.instance:getUnlockCardIndex(Activity123Enum.MainCharPos, arg_31_1)

	if not var_31_3.unlockIndexSet[var_31_4] then
		gohelper.setActive(var_31_1, false)
	else
		gohelper.setActive(var_31_1, true)

		local var_31_5 = arg_31_0["_gocardempty" .. tostring(arg_31_1)]
		local var_31_6 = arg_31_0["_gocardpos" .. tostring(arg_31_1)]

		if var_31_0 and var_31_0 ~= 0 then
			gohelper.setActive(var_31_5, false)
			gohelper.setActive(var_31_6, true)
			arg_31_0:openSubView(Season123_2_0CelebrityCardGetItem, Season123_2_0CelebrityCardItem.AssetPath, var_31_6, nil, nil, var_31_0)
		else
			gohelper.setActive(var_31_5, true)
			gohelper.setActive(var_31_6, false)
		end
	end
end

function var_0_0._delayClosetip(arg_32_0)
	gohelper.setActive(arg_32_0._gofightsucc, false)
	arg_32_0:_showSettlement()
end

function var_0_0.onClose(arg_33_0)
	if arg_33_0._equipAwardCards then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0._equipAwardCards) do
			iter_33_1:destroy()
		end

		arg_33_0._equipAwardCards = nil
	end

	if arg_33_0._showTipsFlow then
		arg_33_0._showTipsFlow:stop()

		arg_33_0._showTipsFlow = nil
	end

	TaskDispatcher.cancelTask(arg_33_0._showHeroItem, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._dailyShowHero, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._showGetCardView, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._delayClosetip, arg_33_0)
	arg_33_0._simagedecorate6:UnLoadImage()
	arg_33_0._simagedecorate10:UnLoadImage()
	arg_33_0._simagefightsuccbg:UnLoadImage()
	arg_33_0._simageherodecorate:UnLoadImage()
	arg_33_0._simagespecialbg:UnLoadImage()

	if FightResultModel.instance.canUpdateDungeonRecord and not arg_33_0._hasSendCoverRecord then
		DungeonRpc.instance:sendCoverDungeonRecordRequest(false)
	end
end

return var_0_0

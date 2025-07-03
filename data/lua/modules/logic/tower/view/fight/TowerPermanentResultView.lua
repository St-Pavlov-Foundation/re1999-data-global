module("modules.logic.tower.view.fight.TowerPermanentResultView", package.seeall)

local var_0_0 = class("TowerPermanentResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0.goFinish = gohelper.findChild(arg_1_0.viewGO, "goFinish")
	arg_1_0.goResult = gohelper.findChild(arg_1_0.viewGO, "go_Result")
	arg_1_0.goRewards = gohelper.findChild(arg_1_0.viewGO, "go_Result/goReward")
	arg_1_0.goReward = gohelper.findChild(arg_1_0.viewGO, "go_Result/goReward/scroll_reward/Viewport/#go_rewards")
	arg_1_0.btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_Result/#btn_Detail")
	arg_1_0.goBossEmpty = gohelper.findChild(arg_1_0.viewGO, "go_Result/goGroup/assistBoss/boss/#go_Empty")
	arg_1_0.goBossRoot = gohelper.findChild(arg_1_0.viewGO, "go_Result/goGroup/assistBoss/boss/root")
	arg_1_0.simageBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_Result/goGroup/assistBoss/boss/root/icon")
	arg_1_0.txtBossName = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_Result/goGroup/assistBoss/boss/root/name")
	arg_1_0.txtBossLev = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_Result/goGroup/assistBoss/boss/root/lev")
	arg_1_0.imgBossCareer = gohelper.findChildImage(arg_1_0.viewGO, "go_Result/goGroup/assistBoss/boss/root/career")
	arg_1_0.goLimitDetail = gohelper.findChild(arg_1_0.viewGO, "go_Result/LimitDetail")
	arg_1_0.simageStageDetail = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_Result/LimitDetail/imgStage")
	arg_1_0.simageWaveDetail = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_Result/LimitDetail/wavebg")
	arg_1_0.txtTower = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_Result/LimitDetail/image_NameBG/txtTower")
	arg_1_0.difficultyItems = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		arg_1_0.difficultyItems[iter_1_0] = gohelper.findChild(arg_1_0.viewGO, string.format("go_Result/LimitDetail/Difficulty/image_Difficulty%s", iter_1_0))
	end

	arg_1_0.txtScoreDetail = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_Result/LimitDetail/image_ScoreBG/#txt_Score")
	arg_1_0.goPermanentDetail = gohelper.findChild(arg_1_0.viewGO, "go_Result/PermanentDetail")
	arg_1_0.imgStageDetail = gohelper.findChildImage(arg_1_0.viewGO, "go_Result/PermanentDetail/imgStage")
	arg_1_0.txtTowerPermanent = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_Result/PermanentDetail/image_NameBG/txtTower")
	arg_1_0.goSchedule = gohelper.findChild(arg_1_0.viewGO, "go_Result/PermanentDetail/LayoutGroup/Schedule")
	arg_1_0.txtSchedule = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_Result/PermanentDetail/LayoutGroup/Schedule/image_ScheduleBG/txt_Schedule")
	arg_1_0.goComplete = gohelper.findChild(arg_1_0.viewGO, "go_Result/PermanentDetail/LayoutGroup/Complete")
	arg_1_0.goEntry = gohelper.findChild(arg_1_0.viewGO, "go_Entry")
	arg_1_0.goEntryLimit = gohelper.findChild(arg_1_0.viewGO, "go_Entry/#go_Limit")
	arg_1_0.txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "go_Entry/#go_Limit/image_ScoreBG/#txt_Score")
	arg_1_0.simageStageEntry = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_Entry/#go_Limit/imgStage")
	arg_1_0.simageWaveEntry = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_Entry/#go_Limit/wavebg")
	arg_1_0.goEntryPermanent = gohelper.findChild(arg_1_0.viewGO, "go_Entry/#go_Permanent")
	arg_1_0.imgStage = gohelper.findChildImage(arg_1_0.viewGO, "go_Entry/#go_Permanent/imgStage")
	arg_1_0.goScoreStar = gohelper.findChild(arg_1_0.viewGO, "go_Result/LimitDetail/#go_scoreStar")
	arg_1_0.goPointContent = gohelper.findChild(arg_1_0.viewGO, "go_Result/LimitDetail/#go_scoreStar/#go_PointContent")
	arg_1_0.goPointItem = gohelper.findChild(arg_1_0.viewGO, "go_Result/LimitDetail/#go_scoreStar/#go_PointContent/#go_PointItem")

	gohelper.setActive(arg_1_0.goFinish, false)
	gohelper.setActive(arg_1_0.goEntry, false)
	gohelper.setActive(arg_1_0.goResult, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnDetail, arg_2_0._onBtnRankClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._click, arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnDetail)
	arg_3_0:removeClickCb(arg_3_0._click)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onClickClose(arg_5_0)
	if not arg_5_0.canClick then
		if arg_5_0.popupFlow then
			local var_5_0 = arg_5_0.popupFlow:getWorkList()[arg_5_0.popupFlow._curIndex]

			if var_5_0 then
				var_5_0:onDone(true)
			end
		end

		return
	end

	arg_5_0:closeThis()
end

function var_0_0._onBtnRankClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshParam(arg_8_0)
	arg_8_0.episodeId = DungeonModel.instance.curSendEpisodeId
	arg_8_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_8_0.episodeId)
	arg_8_0.fightFinishParam = TowerModel.instance:getFightFinishParam()
	arg_8_0.towerType = arg_8_0.fightFinishParam.towerType
	arg_8_0.towerId = arg_8_0.fightFinishParam.towerId
	arg_8_0.layerId = arg_8_0.fightFinishParam.layerId
	arg_8_0.score = arg_8_0.fightFinishParam.score
	arg_8_0.difficulty = arg_8_0.fightFinishParam.difficulty
	arg_8_0.bossLevel = arg_8_0.fightFinishParam.bossLevel
	arg_8_0.layer = arg_8_0.fightFinishParam.layer
	arg_8_0.isLimit = arg_8_0.towerType == TowerEnum.TowerType.Limited

	if arg_8_0.isLimit then
		arg_8_0.layerConfig = TowerConfig.instance:getLimitEpisodeConfig(arg_8_0.layerId, arg_8_0.difficulty)
	else
		arg_8_0.layerConfig = TowerConfig.instance:getPermanentEpisodeCo(arg_8_0.layerId)
	end
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0:refreshEntry()
	arg_9_0:refreshResult()
	arg_9_0:startFlow()
end

function var_0_0.startFlow(arg_10_0)
	if arg_10_0._popupFlow then
		arg_10_0._popupFlow:destroy()

		arg_10_0._popupFlow = nil
	end

	arg_10_0.popupFlow = FlowSequence.New()

	arg_10_0.popupFlow:addWork(TowerBossResultShowFinishWork.New(arg_10_0.goFinish, AudioEnum.Tower.play_ui_fight_explore))
	arg_10_0.popupFlow:addWork(TowerBossResultShowFinishWork.New(arg_10_0.goEntry, AudioEnum.Tower.play_ui_fight_ui_appear))
	arg_10_0.popupFlow:addWork(TowerBossResultShowResultWork.New(arg_10_0.goResult, AudioEnum.Tower.play_ui_fight_card_flip, arg_10_0.onResultShowCallBack, arg_10_0))
	arg_10_0.popupFlow:registerDoneListener(arg_10_0._onAllFinish, arg_10_0)
	arg_10_0.popupFlow:start()
end

function var_0_0.onResultShowCallBack(arg_11_0)
	if arg_11_0._isComplete then
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)
	end
end

function var_0_0.refreshEntry(arg_12_0)
	gohelper.setActive(arg_12_0.goEntryPermanent, not arg_12_0.isLimit)
	gohelper.setActive(arg_12_0.goEntryLimit, arg_12_0.isLimit)

	if arg_12_0.isLimit then
		arg_12_0.txtScore.text = tostring(arg_12_0.score)

		arg_12_0.simageStageEntry:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s.png", arg_12_0.layerConfig.entrance))
		arg_12_0.simageWaveEntry:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s_2.png", arg_12_0.layerConfig.entrance))
	else
		local var_12_0 = string.splitToNumber(arg_12_0.layerConfig.episodeIds, "|")
		local var_12_1 = tabletool.indexOf(var_12_0, arg_12_0.episodeId)

		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_12_0.imgStage, string.format("towerpermanent_stage_%s_1", var_12_1))
	end
end

function var_0_0.refreshResult(arg_13_0)
	gohelper.setActive(arg_13_0.goLimitDetail, arg_13_0.isLimit)
	gohelper.setActive(arg_13_0.goPermanentDetail, not arg_13_0.isLimit)
	gohelper.setActive(arg_13_0.goScoreStar, arg_13_0.isLimit)

	if arg_13_0.isLimit then
		arg_13_0.txtScoreDetail.text = tostring(arg_13_0.score)

		arg_13_0.simageStageDetail:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s.png", arg_13_0.layerConfig.entrance))
		arg_13_0.simageWaveDetail:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s_2.png", arg_13_0.layerConfig.entrance))

		arg_13_0.txtTower.text = arg_13_0.episodeConfig.name

		for iter_13_0, iter_13_1 in ipairs(arg_13_0.difficultyItems) do
			gohelper.setActive(iter_13_1, iter_13_0 == arg_13_0.difficulty)
		end

		local var_13_0 = TowerConfig.instance:getScoreToStarConfig(arg_13_0.score)

		gohelper.setActive(arg_13_0.goScoreStar, var_13_0 > 0)

		if var_13_0 > 0 then
			local var_13_1 = {}

			for iter_13_2 = 1, var_13_0 do
				table.insert(var_13_1, iter_13_2)
			end

			gohelper.CreateObjList(arg_13_0, arg_13_0.scoreStarShow, var_13_1, arg_13_0.goPointContent, arg_13_0.goPointItem)
		end
	else
		local var_13_2 = string.splitToNumber(arg_13_0.layerConfig.episodeIds, "|") or {}
		local var_13_3 = tabletool.indexOf(var_13_2, arg_13_0.episodeId)

		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_13_0.imgStageDetail, string.format("towerpermanent_stage_%s_1", var_13_3))

		arg_13_0.txtTowerPermanent.text = arg_13_0.episodeConfig.name

		local var_13_4 = 0

		if arg_13_0.layer and arg_13_0.layer.episodeNOs then
			for iter_13_3 = 1, #arg_13_0.layer.episodeNOs do
				if arg_13_0.layer.episodeNOs[iter_13_3].status == 1 then
					var_13_4 = var_13_4 + 1
				end
			end
		end

		local var_13_5 = #var_13_2
		local var_13_6 = var_13_5 <= var_13_4

		arg_13_0.txtSchedule.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerpermanentresultview_schedule"), var_13_4, var_13_5)

		gohelper.setActive(arg_13_0.goSchedule, var_13_5 > 1)

		arg_13_0._isComplete = var_13_6

		gohelper.setActive(arg_13_0.goComplete, var_13_6)
	end

	arg_13_0:refreshHeroGroup()
	arg_13_0:refreshRewards(arg_13_0.goReward, arg_13_0.goRewards)
end

function var_0_0.scoreStarShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	gohelper.setActive(arg_14_1, arg_14_3 <= arg_14_2)
end

function var_0_0.refreshRewards(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.rewardItems == nil then
		arg_15_0.rewardItems = {}
	end

	local var_15_0 = FightResultModel.instance:getMaterialDataList() or {}

	for iter_15_0 = 1, math.max(#arg_15_0.rewardItems, #var_15_0) do
		local var_15_1 = arg_15_0.rewardItems[iter_15_0]
		local var_15_2 = var_15_0[iter_15_0]

		if not var_15_1 then
			var_15_1 = IconMgr.instance:getCommonPropItemIcon(arg_15_1)
			arg_15_0.rewardItems[iter_15_0] = var_15_1
		end

		gohelper.setActive(var_15_1.go, var_15_2 ~= nil)

		if var_15_2 then
			var_15_1:setMOValue(var_15_2.materilType, var_15_2.materilId, var_15_2.quantity)
			var_15_1:setScale(0.7)
			var_15_1:setCountTxtSize(51)
		end
	end

	gohelper.setActive(arg_15_2, #var_15_0 ~= 0)
end

function var_0_0.refreshHeroGroup(arg_16_0)
	if arg_16_0.heroItemList == nil then
		arg_16_0.heroItemList = arg_16_0:getUserDataTb_()
	end

	local var_16_0 = FightModel.instance:getFightParam()
	local var_16_1 = var_16_0:getHeroEquipAndTrialMoList(true)

	for iter_16_0 = 1, 4 do
		local var_16_2 = arg_16_0.heroItemList[iter_16_0]

		if var_16_2 == nil then
			local var_16_3 = gohelper.findChild(arg_16_0.viewGO, string.format("go_Result/goGroup/Group/heroitem%s", iter_16_0))

			var_16_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_3, TowerBossResultHeroItem)
			arg_16_0.heroItemList[iter_16_0] = var_16_2
		end

		local var_16_4 = var_16_1[iter_16_0]

		if var_16_4 then
			var_16_2:setData(var_16_4.heroMo, var_16_4.equipMo)
		else
			var_16_2:setData()
		end
	end

	local var_16_5 = var_16_0.assistBossId
	local var_16_6 = TowerConfig.instance:getAssistBossConfig(var_16_5)
	local var_16_7 = var_16_6 == nil

	gohelper.setActive(arg_16_0.goBossEmpty, var_16_7)
	gohelper.setActive(arg_16_0.goBossRoot, not var_16_7)

	if not var_16_7 then
		arg_16_0.simageBoss:LoadImage(var_16_6.bossPic)

		arg_16_0.txtBossName.text = var_16_6.name
		arg_16_0.txtBossLev.text = tostring(arg_16_0.bossLevel)

		UISpriteSetMgr.instance:setCommonSprite(arg_16_0.imgBossCareer, string.format("lssx_%s", var_16_6.career))
	end
end

function var_0_0._onAllFinish(arg_17_0)
	arg_17_0.canClick = true
end

function var_0_0.onClose(arg_18_0)
	FightController.onResultViewClose()
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0.simageBoss:UnLoadImage()
	arg_19_0.simageWaveEntry:UnLoadImage()
	arg_19_0.simageStageEntry:UnLoadImage()
	arg_19_0.simageStageDetail:UnLoadImage()
	arg_19_0.simageWaveDetail:UnLoadImage()

	if arg_19_0._popupFlow then
		arg_19_0._popupFlow:destroy()

		arg_19_0._popupFlow = nil
	end
end

return var_0_0

module("modules.logic.tower.view.fight.TowerPermanentResultView", package.seeall)

slot0 = class("TowerPermanentResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._click = gohelper.getClick(slot0.viewGO)
	slot0.goFinish = gohelper.findChild(slot0.viewGO, "goFinish")
	slot0.goResult = gohelper.findChild(slot0.viewGO, "go_Result")
	slot0.goRewards = gohelper.findChild(slot0.viewGO, "go_Result/goReward")
	slot0.goReward = gohelper.findChild(slot0.viewGO, "go_Result/goReward/scroll_reward/Viewport/#go_rewards")
	slot0.btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_Result/#btn_Detail")
	slot0.goBossEmpty = gohelper.findChild(slot0.viewGO, "go_Result/goGroup/assistBoss/boss/#go_Empty")
	slot0.goBossRoot = gohelper.findChild(slot0.viewGO, "go_Result/goGroup/assistBoss/boss/root")
	slot0.simageBoss = gohelper.findChildSingleImage(slot0.viewGO, "go_Result/goGroup/assistBoss/boss/root/icon")
	slot0.txtBossName = gohelper.findChildTextMesh(slot0.viewGO, "go_Result/goGroup/assistBoss/boss/root/name")
	slot0.txtBossLev = gohelper.findChildTextMesh(slot0.viewGO, "go_Result/goGroup/assistBoss/boss/root/lev")
	slot0.imgBossCareer = gohelper.findChildImage(slot0.viewGO, "go_Result/goGroup/assistBoss/boss/root/career")
	slot0.goLimitDetail = gohelper.findChild(slot0.viewGO, "go_Result/LimitDetail")
	slot0.simageStageDetail = gohelper.findChildSingleImage(slot0.viewGO, "go_Result/LimitDetail/imgStage")
	slot0.simageWaveDetail = gohelper.findChildSingleImage(slot0.viewGO, "go_Result/LimitDetail/wavebg")
	slot0.txtTower = gohelper.findChildTextMesh(slot0.viewGO, "go_Result/LimitDetail/image_NameBG/txtTower")
	slot0.difficultyItems = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0.difficultyItems[slot4] = gohelper.findChild(slot0.viewGO, string.format("go_Result/LimitDetail/Difficulty/image_Difficulty%s", slot4))
	end

	slot0.txtScoreDetail = gohelper.findChildTextMesh(slot0.viewGO, "go_Result/LimitDetail/image_ScoreBG/#txt_Score")
	slot0.goPermanentDetail = gohelper.findChild(slot0.viewGO, "go_Result/PermanentDetail")
	slot0.imgStageDetail = gohelper.findChildImage(slot0.viewGO, "go_Result/PermanentDetail/imgStage")
	slot0.txtTowerPermanent = gohelper.findChildTextMesh(slot0.viewGO, "go_Result/PermanentDetail/image_NameBG/txtTower")
	slot0.goSchedule = gohelper.findChild(slot0.viewGO, "go_Result/PermanentDetail/LayoutGroup/Schedule")
	slot0.txtSchedule = gohelper.findChildTextMesh(slot0.viewGO, "go_Result/PermanentDetail/LayoutGroup/Schedule/image_ScheduleBG/txt_Schedule")
	slot0.goComplete = gohelper.findChild(slot0.viewGO, "go_Result/PermanentDetail/LayoutGroup/Complete")
	slot0.goEntry = gohelper.findChild(slot0.viewGO, "go_Entry")
	slot0.goEntryLimit = gohelper.findChild(slot0.viewGO, "go_Entry/#go_Limit")
	slot0.txtScore = gohelper.findChildTextMesh(slot0.viewGO, "go_Entry/#go_Limit/image_ScoreBG/#txt_Score")
	slot0.simageStageEntry = gohelper.findChildSingleImage(slot0.viewGO, "go_Entry/#go_Limit/imgStage")
	slot0.simageWaveEntry = gohelper.findChildSingleImage(slot0.viewGO, "go_Entry/#go_Limit/wavebg")
	slot0.goEntryPermanent = gohelper.findChild(slot0.viewGO, "go_Entry/#go_Permanent")
	slot0.imgStage = gohelper.findChildImage(slot0.viewGO, "go_Entry/#go_Permanent/imgStage")

	gohelper.setActive(slot0.goFinish, false)
	gohelper.setActive(slot0.goEntry, false)
	gohelper.setActive(slot0.goResult, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnDetail, slot0._onBtnRankClick, slot0)
	slot0:addClickCb(slot0._click, slot0._onClickClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnDetail)
	slot0:removeClickCb(slot0._click)
end

function slot0._editableInitView(slot0)
end

function slot0._onClickClose(slot0)
	if not slot0.canClick then
		if slot0.popupFlow and slot0.popupFlow:getWorkList()[slot0.popupFlow._curIndex] then
			slot2:onDone(true)
		end

		return
	end

	slot0:closeThis()
end

function slot0._onBtnRankClick(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.episodeId = DungeonModel.instance.curSendEpisodeId
	slot0.episodeConfig = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot0.fightFinishParam = TowerModel.instance:getFightFinishParam()
	slot0.towerType = slot0.fightFinishParam.towerType
	slot0.towerId = slot0.fightFinishParam.towerId
	slot0.layerId = slot0.fightFinishParam.layerId
	slot0.score = slot0.fightFinishParam.score
	slot0.difficulty = slot0.fightFinishParam.difficulty
	slot0.bossLevel = slot0.fightFinishParam.bossLevel
	slot0.layer = slot0.fightFinishParam.layer
	slot0.isLimit = slot0.towerType == TowerEnum.TowerType.Limited

	if slot0.isLimit then
		slot0.layerConfig = TowerConfig.instance:getLimitEpisodeConfig(slot0.layerId, slot0.difficulty)
	else
		slot0.layerConfig = TowerConfig.instance:getPermanentEpisodeCo(slot0.layerId)
	end
end

function slot0.refreshView(slot0)
	slot0:refreshEntry()
	slot0:refreshResult()
	slot0:startFlow()
end

function slot0.startFlow(slot0)
	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end

	slot0.popupFlow = FlowSequence.New()

	slot0.popupFlow:addWork(TowerBossResultShowFinishWork.New(slot0.goFinish, AudioEnum.Tower.play_ui_fight_explore))
	slot0.popupFlow:addWork(TowerBossResultShowFinishWork.New(slot0.goEntry, AudioEnum.Tower.play_ui_fight_ui_appear))
	slot0.popupFlow:addWork(TowerBossResultShowResultWork.New(slot0.goResult, AudioEnum.Tower.play_ui_fight_card_flip, slot0.onResultShowCallBack, slot0))
	slot0.popupFlow:registerDoneListener(slot0._onAllFinish, slot0)
	slot0.popupFlow:start()
end

function slot0.onResultShowCallBack(slot0)
	if slot0._isComplete then
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)
	end
end

function slot0.refreshEntry(slot0)
	gohelper.setActive(slot0.goEntryPermanent, not slot0.isLimit)
	gohelper.setActive(slot0.goEntryLimit, slot0.isLimit)

	if slot0.isLimit then
		slot0.txtScore.text = tostring(slot0.score)

		slot0.simageStageEntry:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s.png", slot0.layerConfig.entrance))
		slot0.simageWaveEntry:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s_2.png", slot0.layerConfig.entrance))
	else
		UISpriteSetMgr.instance:setTowerPermanentSprite(slot0.imgStage, string.format("towerpermanent_stage_%s_1", tabletool.indexOf(string.splitToNumber(slot0.layerConfig.episodeIds, "|"), slot0.episodeId)))
	end
end

function slot0.refreshResult(slot0)
	gohelper.setActive(slot0.goLimitDetail, slot0.isLimit)
	gohelper.setActive(slot0.goPermanentDetail, not slot0.isLimit)

	if slot0.isLimit then
		slot0.txtScoreDetail.text = tostring(slot0.score)

		slot0.simageStageDetail:LoadImage(string.format("singlebg/tower_singlebg/level/tower_level_stage_%s.png", slot0.layerConfig.entrance))

		slot4 = "singlebg/tower_singlebg/level/tower_level_stage_%s_2.png"
		slot5 = slot0.layerConfig.entrance

		slot0.simageWaveDetail:LoadImage(string.format(slot4, slot5))

		slot0.txtTower.text = slot0.episodeConfig.name

		for slot4, slot5 in ipairs(slot0.difficultyItems) do
			gohelper.setActive(slot5, slot4 == slot0.difficulty)
		end
	else
		UISpriteSetMgr.instance:setTowerPermanentSprite(slot0.imgStageDetail, string.format("towerpermanent_stage_%s_1", tabletool.indexOf(string.splitToNumber(slot0.layerConfig.episodeIds, "|") or {}, slot0.episodeId)))

		slot0.txtTowerPermanent.text = slot0.episodeConfig.name
		slot3 = 0

		if slot0.layer and slot0.layer.episodeNOs then
			for slot7 = 1, #slot0.layer.episodeNOs do
				if slot0.layer.episodeNOs[slot7].status == 1 then
					slot3 = slot3 + 1
				end
			end
		end

		slot5 = slot3 >= #slot1
		slot0.txtSchedule.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerpermanentresultview_schedule"), slot3, slot4)

		gohelper.setActive(slot0.goSchedule, slot4 > 1)

		slot0._isComplete = slot5

		gohelper.setActive(slot0.goComplete, slot5)
	end

	slot0:refreshHeroGroup()
	slot0:refreshRewards(slot0.goReward, slot0.goRewards)
end

function slot0.refreshRewards(slot0, slot1, slot2)
	if slot0.rewardItems == nil then
		slot0.rewardItems = {}
	end

	slot7 = #(FightResultModel.instance:getMaterialDataList() or {})

	for slot7 = 1, math.max(#slot0.rewardItems, slot7) do
		slot9 = slot3[slot7]

		if not slot0.rewardItems[slot7] then
			slot0.rewardItems[slot7] = IconMgr.instance:getCommonPropItemIcon(slot1)
		end

		gohelper.setActive(slot8.go, slot9 ~= nil)

		if slot9 then
			slot8:setMOValue(slot9.materilType, slot9.materilId, slot9.quantity)
			slot8:setScale(0.7)
			slot8:setCountTxtSize(51)
		end
	end

	gohelper.setActive(slot2, #slot3 ~= 0)
end

function slot0.refreshHeroGroup(slot0)
	if slot0.heroItemList == nil then
		slot0.heroItemList = slot0:getUserDataTb_()
	end

	slot2 = FightModel.instance:getFightParam():getHeroEquipMoList()

	for slot6 = 1, 4 do
		if slot0.heroItemList[slot6] == nil then
			slot0.heroItemList[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, string.format("go_Result/goGroup/Group/heroitem%s", slot6)), TowerBossResultHeroItem)
		end

		if slot2[slot6] then
			slot7:setData(slot8.heroMo, slot8.equipMo)
		else
			slot7:setData()
		end
	end

	slot5 = TowerConfig.instance:getAssistBossConfig(slot1.assistBossId) == nil

	gohelper.setActive(slot0.goBossEmpty, slot5)
	gohelper.setActive(slot0.goBossRoot, not slot5)

	if not slot5 then
		slot0.simageBoss:LoadImage(slot4.bossPic)

		slot0.txtBossName.text = slot4.name
		slot0.txtBossLev.text = tostring(slot0.bossLevel)

		UISpriteSetMgr.instance:setCommonSprite(slot0.imgBossCareer, string.format("lssx_%s", slot4.career))
	end
end

function slot0._onAllFinish(slot0)
	slot0.canClick = true
end

function slot0.onClose(slot0)
	FightController.onResultViewClose()
end

function slot0.onDestroyView(slot0)
	slot0.simageBoss:UnLoadImage()
	slot0.simageWaveEntry:UnLoadImage()
	slot0.simageStageEntry:UnLoadImage()
	slot0.simageStageDetail:UnLoadImage()
	slot0.simageWaveDetail:UnLoadImage()

	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end
end

return slot0

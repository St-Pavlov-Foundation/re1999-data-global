module("modules.logic.tower.view.fight.TowerBossResultView", package.seeall)

slot0 = class("TowerBossResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._click = gohelper.getClick(slot0.viewGO)
	slot0.goFinish = gohelper.findChild(slot0.viewGO, "goFinish")
	slot0.goBossLevChange = gohelper.findChild(slot0.viewGO, "goBossLevChange")
	slot0.txtLev1 = gohelper.findChildTextMesh(slot0.goBossLevChange, "goLev/Lv1/txtLev1")
	slot0.txtLev2 = gohelper.findChildTextMesh(slot0.goBossLevChange, "goLev/Lv2/txtLev2")
	slot0.goResult = gohelper.findChild(slot0.viewGO, "goResult")
	slot0.goInfo = gohelper.findChild(slot0.goResult, "goInfo")
	slot0.txtLev = gohelper.findChildTextMesh(slot0.goInfo, "Lv/txtLev")
	slot0.goAttrItem = gohelper.findChild(slot0.goInfo, "attrInfo/attrItem")

	gohelper.setActive(slot0.goAttrItem, false)

	slot0.goTalentPoint = gohelper.findChild(slot0.goInfo, "attrInfo/talentPoint")
	slot0.txtTalentPoint = gohelper.findChildTextMesh(slot0.goTalentPoint, "value")
	slot0.goRewards = gohelper.findChild(slot0.goResult, "goReward")
	slot0.goReward = gohelper.findChild(slot0.goResult, "goReward/scroll_reward/Viewport/#go_rewards")
	slot0.goSpResult = gohelper.findChild(slot0.viewGO, "goSpResult")
	slot0.goHeroItem = gohelper.findChild(slot0.viewGO, "goSpResult/goGroup/Group/heroitem")
	slot0.simageSpBoss = gohelper.findChildSingleImage(slot0.viewGO, "goSpResult/goBoss/imgBoss")
	slot0.txtSpTower = gohelper.findChildTextMesh(slot0.viewGO, "goSpResult/goBoss/txtTower")
	slot0.txtSpIndex = gohelper.findChildTextMesh(slot0.viewGO, "goSpResult/goBoss/episodeItem/goOpen/txtCurEpisode")
	slot0.goSpRewards = gohelper.findChild(slot0.viewGO, "goSpResult/goReward")
	slot0.goSpReward = gohelper.findChild(slot0.viewGO, "goSpResult/goReward/scroll_reward/Viewport/#go_rewards")
	slot0.btnRank = gohelper.findChildButtonWithAudio(slot0.viewGO, "goResult/#btn_Rank")
	slot0.btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "goSpResult/#btn_Detail")
	slot0.goBoss = gohelper.findChild(slot0.viewGO, "goBoss")
	slot0.simageBoss = gohelper.findChildSingleImage(slot0.viewGO, "goBoss/imgBoss")
	slot0.txtTower = gohelper.findChildTextMesh(slot0.goBoss, "txtTower")

	gohelper.setActive(slot0.goFinish, false)
	gohelper.setActive(slot0.goBossLevChange, false)
	gohelper.setActive(slot0.goResult, false)
	gohelper.setActive(slot0.goInfo, false)
	gohelper.setActive(slot0.goSpResult, false)
	gohelper.setActive(slot0.goBoss, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnDetail, slot0._onBtnRankClick, slot0)
	slot0:addClickCb(slot0.btnRank, slot0._onBtnRankClick, slot0)
	slot0:addClickCb(slot0._click, slot0._onClickClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnDetail)
	slot0:removeClickCb(slot0.btnRank)
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
	slot0.towerConfig = TowerConfig.instance:getBossTowerConfig(slot0.towerId)
	slot0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(slot0.towerType)
	slot0.layerConfig = slot0.episodeMo:getEpisodeConfig(slot0.towerId, slot0.layerId)
	slot0.bossConfig = TowerConfig.instance:getAssistBossConfig(slot0.towerConfig.bossId)
end

function slot0.refreshView(slot0)
	slot0.txtTower.text = slot0.towerConfig.name

	slot0.simageBoss:LoadImage(slot0.bossConfig.bossPic)

	if slot0.layerConfig.openRound > 0 then
		slot0:refreshSp()
	else
		slot0:refreshAttr()
	end

	slot0:refreshLev()
	slot0:refreshRewards(slot1 and slot0.goSpReward or slot0.goReward, slot1 and slot0.goSpRewards or slot0.goRewards)
	slot0:startFlow(slot1)
end

function slot0.startFlow(slot0, slot1)
	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end

	slot0.popupFlow = FlowSequence.New()

	slot0.popupFlow:addWork(TowerBossResultShowFinishWork.New(slot0.goFinish, AudioEnum.Tower.play_ui_fight_explore))
	slot0.popupFlow:addWork(TowerBossResultShowLevChangeWork.New(slot0.goBossLevChange, slot0.goBoss, slot0.isBossLevChange))
	slot0.popupFlow:addWork(TowerBossResultShowResultWork.New(slot1 and slot0.goSpResult or slot0.goResult, AudioEnum.Tower.play_ui_fight_explore))
	slot0.popupFlow:registerDoneListener(slot0._onAllFinish, slot0)
	slot0.popupFlow:start()
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

function slot0.refreshLev(slot0)
	slot1 = slot0.towerConfig.bossId
	slot0.isBossLevChange = slot0.layerConfig.bossLevel ~= (slot0.episodeMo:getEpisodeConfig(slot0.towerId, slot0.layerConfig.preLayerId) and slot3.bossLevel or 0)

	if not slot0.isBossLevChange then
		return
	end

	slot0.txtLev1.text = tostring(slot4)
	slot0.txtLev2.text = tostring(slot2)
end

function slot0.refreshAttr(slot0)
	gohelper.setActive(slot0.goInfo, true)

	if slot0.attrItems == nil then
		slot0.attrItems = {}
	end

	slot3 = TowerConfig.instance:getAssistDevelopConfig(slot0.towerConfig.bossId, slot0.layerConfig.bossLevel) and slot2.talentPoint
	slot0.txtLev.text = tostring(slot1)
	slot8 = #(GameUtil.splitString2(slot2 and slot2.attribute, true) or {})

	for slot8 = 1, math.max(#slot0.attrItems, slot8) do
		if not slot0.attrItems[slot8] then
			slot0.attrItems[slot8] = slot0:createAttrItem(slot8)
		end

		slot0:refreshAttrItem(slot9, slot4[slot8])
	end

	slot5 = slot3 and slot3 > 0 or false

	gohelper.setActive(slot0.goTalentPoint, slot5)

	if slot5 then
		gohelper.setAsLastSibling(slot0.goTalentPoint)

		slot0.txtTalentPoint.text = string.format("+%s", slot3)
	end
end

function slot0.createAttrItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.index = slot1
	slot2.go = gohelper.cloneInPlace(slot0.goAttrItem, string.format("attrItem%s", slot1))
	slot2.icon = gohelper.findChildImage(slot2.go, "icon")
	slot2.txtName = gohelper.findChildTextMesh(slot2.go, "name")
	slot2.txtValue = gohelper.findChildTextMesh(slot2.go, "value")

	return slot2
end

function slot0.refreshAttrItem(slot0, slot1, slot2)
	gohelper.setActive(slot1.go, slot2 ~= nil)

	if slot2 then
		slot3 = slot2[1]
		slot1.txtName.text = HeroConfig.instance:getHeroAttributeCO(slot3).name
		slot1.txtValue.text = string.format("+%s%%", slot2[2] * 0.1)

		UISpriteSetMgr.instance:setCommonSprite(slot1.icon, string.format("icon_att_%s", slot3))
	end
end

function slot0.refreshSp(slot0)
	slot0.simageSpBoss:LoadImage(slot0.bossConfig.bossPic)

	slot0.txtSpTower.text = slot0.towerConfig.name
	slot0.txtSpIndex.text = slot0.episodeMo:getEpisodeIndex(slot0.towerId, slot0.layerId)

	slot0:refreshHeroGroup()
end

function slot0.refreshHeroGroup(slot0)
	if slot0.heroItemList == nil then
		slot0.heroItemList = slot0:getUserDataTb_()
	end

	for slot6 = 1, 4 do
		slot7 = slot0.heroItemList[slot6]

		if FightModel.instance:getFightParam():getHeroEquipMoList()[slot6] then
			if slot7 == nil then
				slot0.heroItemList[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, string.format("goSpResult/goGroup/Group/heroitem%s", slot6)), TowerBossResultHeroItem)
			end

			slot7:setData(slot8.heroMo, slot8.equipMo)
		end
	end
end

function slot0._onAllFinish(slot0)
	slot0.canClick = true
end

function slot0.onClose(slot0)
	FightController.onResultViewClose()
end

function slot0.onDestroyView(slot0)
	slot0.simageSpBoss:UnLoadImage()
	slot0.simageBoss:UnLoadImage()

	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
	end
end

return slot0

module("modules.logic.tower.view.bosstower.TowerBossEpisodeView", package.seeall)

slot0 = class("TowerBossEpisodeView", BaseView)

function slot0.onInitView(slot0)
	slot0.txtName = gohelper.findChildTextMesh(slot0.viewGO, "root/episodeNode/nameBg/txtName")
	slot0.btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/Right/btnStart")
	slot0.goRewards = gohelper.findChild(slot0.viewGO, "root/Right/Reward/scroll_reward/Viewport/#go_rewards")
	slot0.goAttrInfo = gohelper.findChild(slot0.viewGO, "root/Right/attrInfo")
	slot0.goLevItem = gohelper.findChild(slot0.viewGO, "root/Right/attrInfo/levItem")
	slot0.txtCurLev = gohelper.findChildTextMesh(slot0.goLevItem, "curLev")
	slot0.txtNextLev = gohelper.findChildTextMesh(slot0.goLevItem, "nextLev")
	slot0.goAttrItem = gohelper.findChild(slot0.viewGO, "root/Right/attrInfo/attrItem")

	gohelper.setActive(slot0.goAttrItem, false)

	slot0.goTalentPoint = gohelper.findChild(slot0.viewGO, "root/Right/attrInfo/talentPoint")
	slot0.txtTalentPoint = gohelper.findChildTextMesh(slot0.goTalentPoint, "value")
	slot0.goSkillUnlock = gohelper.findChild(slot0.viewGO, "root/Right/attrInfo/skillUnlock")
	slot0.imgSkillUnlock = gohelper.findChildImage(slot0.viewGO, "root/Right/attrInfo/skillUnlock/icon")
	slot0.goBossUnlock = gohelper.findChild(slot0.viewGO, "root/Right/attrInfo/bossUnlock")
	slot0.txtPreIndex = gohelper.findChildTextMesh(slot0.viewGO, "root/episodeNode/Levels/indexBg2/txtCurEpisode")
	slot0.txtCurIndex = gohelper.findChildTextMesh(slot0.viewGO, "root/episodeNode/Levels/indexBg3/txtCurEpisode")
	slot0.txtNextIndex = gohelper.findChildTextMesh(slot0.viewGO, "root/episodeNode/Levels/indexBg4/txtCurEpisode")
	slot0.simageBoss = gohelper.findChildSingleImage(slot0.viewGO, "root/episodeNode/BOSS/#simage_BossPic")
	slot0.simageShadow = gohelper.findChildSingleImage(slot0.viewGO, "root/episodeNode/BOSS/#simage_BossShadow")
	slot0.animLevels = gohelper.findChildComponent(slot0.viewGO, "root/episodeNode/Levels", gohelper.Type_Animator)
	slot0.goLevels = gohelper.findChild(slot0.viewGO, "root/episodeNode/Levels")
	slot0.goRight = gohelper.findChild(slot0.viewGO, "root/Right")
	slot0.goLevMax = gohelper.findChild(slot0.viewGO, "root/#go_levelmax")
	slot0.txtMaxLevel = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_levelmax/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnStart, slot0._onBtnStartClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnStart)
end

function slot0._editableInitView(slot0)
end

function slot0._onBtnStartClick(slot0)
	if not slot0.episodeConfig then
		return
	end

	TowerController.instance:enterFight({
		towerType = slot0.towerType,
		towerId = slot0.towerId,
		layerId = slot0.episodeConfig.layerId,
		episodeId = slot0.episodeConfig.episodeId
	})
end

function slot0._onMove(slot0)
	slot0:refreshCurLayerId()
	slot0:refreshLayerInfo()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()

	if slot0.needChangeLayer then
		UIBlockMgr.instance:startBlock("delayMove")
		TaskDispatcher.runDelay(slot0.delayMove, slot0, 1)
	end
end

function slot0.delayMove(slot0)
	UIBlockMgr.instance:endBlock("delayMove")
	slot0.animLevels:Play("move")
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_boss_swtich)
	TaskDispatcher.runDelay(slot0._onMove, slot0, 0.167)
end

function slot0.refreshParam(slot0)
	slot0.episodeConfig = slot0.viewParam.episodeConfig
	slot0.towerId = slot0.episodeConfig.towerId
	slot0.towerType = TowerEnum.TowerType.Boss
	slot0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(slot0.towerType)
	slot0.towerConfig = TowerConfig.instance:getBossTowerConfig(slot0.towerId)
	slot0.bossConfig = TowerConfig.instance:getAssistBossConfig(slot0.towerConfig.bossId)
	slot0.towerInfo = TowerModel.instance:getTowerInfoById(slot0.towerType, slot0.towerId)

	slot0:refreshCurLayerId()
end

function slot0.refreshCurLayerId(slot0)
	if slot0.viewParam and slot0.viewParam.passLayerId then
		slot0.curLayer = slot1
		slot0.viewParam.passLayerId = nil
	else
		slot0.curLayer = slot0.episodeConfig.layerId
	end

	slot0.needChangeLayer = slot0.curLayer ~= slot0.episodeConfig.layerId
end

function slot0.refreshView(slot0)
	slot0.txtName.text = slot0.towerConfig.name

	slot0.simageBoss:LoadImage(slot0.bossConfig.bossPic)
	slot0.simageShadow:LoadImage(slot0.bossConfig.bossShadowPic)
	slot0:refreshLayerInfo()
end

function slot0.refreshLayerInfo(slot0)
	slot1 = not slot0.needChangeLayer and slot0.towerInfo:isLayerPass(slot0.curLayer, slot0.episodeMo)

	gohelper.setActive(slot0.goLevMax, slot1)
	gohelper.setActive(slot0.goLevels, not slot1)
	gohelper.setActive(slot0.goRight, not slot1)

	if not slot1 then
		slot0:refreshIndex()
		slot0:refreshRewards(slot0.episodeConfig.firstReward)
		slot0:refreshAttr()
	else
		slot0.txtMaxLevel.text = tostring(slot0.episodeMo:getEpisodeIndex(slot0.towerId, slot0.curLayer))
	end
end

function slot0.refreshIndex(slot0)
	slot1 = slot0.episodeMo:getEpisodeConfig(slot0.towerId, slot0.curLayer)
	slot0.txtCurIndex.text = tostring(slot0.episodeMo:getEpisodeIndex(slot0.towerId, slot0.curLayer))

	if slot0.episodeMo:getNextEpisodeLayer(slot0.towerId, slot0.curLayer) then
		if slot0.episodeMo:getEpisodeConfig(slot0.towerId, slot2).openRound > 0 then
			slot0.txtNextIndex.text = ""
		else
			slot0.txtNextIndex.text = tostring(slot0.episodeMo:getEpisodeIndex(slot0.towerId, slot2))
		end
	else
		slot0.txtNextIndex.text = ""
	end

	if slot1.preLayerId and slot3 > 0 then
		slot0.txtPreIndex.text = tostring(slot0.episodeMo:getEpisodeIndex(slot0.towerId, slot3))
	else
		slot0.txtPreIndex.text = ""
	end
end

function slot0.refreshRewards(slot0, slot1)
	if slot0.rewardItems == nil then
		slot0.rewardItems = {}
	end

	slot6 = #(GameUtil.splitString2(slot1, true) or {})

	for slot6 = 1, math.max(#slot0.rewardItems, slot6) do
		if not slot0.rewardItems[slot6] then
			slot0.rewardItems[slot6] = IconMgr.instance:getCommonPropItemIcon(slot0.goRewards)
		end

		gohelper.setActive(slot7.go, slot2[slot6] ~= nil)

		if slot2[slot6] then
			slot7:setMOValue(slot2[slot6][1], slot2[slot6][2], slot2[slot6][3], nil, true)
			slot7:setScale(0.7)
			slot7:setCountTxtSize(51)
		end
	end
end

function slot0.refreshAttr(slot0)
	if slot0.attrItems == nil then
		slot0.attrItems = {}
	end

	slot2 = slot0.episodeConfig.bossLevel
	slot6 = TowerConfig.instance:getAssistDevelopConfig(slot0.towerConfig.bossId, slot2) and slot5.talentPoint
	slot0.txtCurLev.text = string.format("Lv.%s", slot0.episodeMo:getEpisodeConfig(slot0.towerId, slot0.episodeConfig.preLayerId) and slot3.bossLevel or 0)
	slot0.txtNextLev.text = string.format("Lv.%s", slot2)
	slot11 = #(GameUtil.splitString2(slot5 and slot5.attribute, true) or {})

	for slot11 = 1, math.max(#slot0.attrItems, slot11) do
		if not slot0.attrItems[slot11] then
			slot0.attrItems[slot11] = slot0:createAttrItem(slot11)
		end

		slot0:refreshAttrItem(slot12, slot7[slot11])
	end

	slot8 = slot6 and slot6 > 0 or false

	gohelper.setActive(slot0.goTalentPoint, slot8)

	if slot8 then
		slot0.txtTalentPoint.text = string.format("+%s", slot6)
	end

	gohelper.setActive(slot0.goBossUnlock, slot2 == 1)

	slot9 = nil

	for slot14, slot15 in ipairs(TowerConfig.instance:getPassiveSKills(slot1)) do
		if TowerConfig.instance:getPassiveSkillActiveLev(slot1, slot15[1]) == slot2 then
			slot9 = slot14

			break
		end
	end

	gohelper.setActive(slot0.goSkillUnlock, slot9 ~= nil)

	if slot9 then
		UISpriteSetMgr.instance:setCommonSprite(slot0.imgSkillUnlock, string.format("icon_att_%s", slot9 + 221))
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

function slot0.onOpenFinish(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("delayMove")
	TaskDispatcher.cancelTask(slot0.delayMove, slot0)
	TaskDispatcher.cancelTask(slot0._onMove, slot0)
	slot0.simageShadow:UnLoadImage()
	slot0.simageBoss:UnLoadImage()
end

return slot0

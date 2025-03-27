module("modules.logic.tower.view.bosstower.TowerBossSpEpisodeView", package.seeall)

slot0 = class("TowerBossSpEpisodeView", BaseView)

function slot0.onInitView(slot0)
	slot0.simageBoss = gohelper.findChildSingleImage(slot0.viewGO, "root/episodeNode/BOSS/#simage_BossPic")
	slot0.txtName = gohelper.findChildTextMesh(slot0.viewGO, "root/episodeNode/nameBg/txtName")
	slot0.simageShadow = gohelper.findChildSingleImage(slot0.viewGO, "root/episodeNode/BOSS/#simage_BossShadow")
	slot0.txtLev = gohelper.findChildTextMesh(slot0.viewGO, "root/episodeNode/#go_episodes/Bottom/txtCurEpisode")
	slot0.goEpisodeInfo = gohelper.findChild(slot0.viewGO, "root/episodeInfo")
	slot0.txtEpisodeIndex = gohelper.findChildTextMesh(slot0.goEpisodeInfo, "Title/txtIndex")
	slot0.txtEpisodeName = gohelper.findChildTextMesh(slot0.goEpisodeInfo, "Title/txtTitle")
	slot0.txtEpisodeNameEn = gohelper.findChildTextMesh(slot0.goEpisodeInfo, "Title/txt_TitleEn")
	slot0.txtEpisodeDesc = gohelper.findChildTextMesh(slot0.goEpisodeInfo, "desc/Viewport/content")
	slot0._gorecommendattr = gohelper.findChild(slot0.goEpisodeInfo, "#go_recommendAttr")
	slot0._gorecommendattrlist = gohelper.findChild(slot0._gorecommendattr, "attrlist")
	slot0._goattritem = gohelper.findChild(slot0.goEpisodeInfo, "#go_recommendAttr/attrlist/#go_attritem")
	slot0._txtrecommonddes = gohelper.findChildTextMesh(slot0.goEpisodeInfo, "#go_recommendAttr/#txt_recommonddes")
	slot0._txtrecommendlevel = gohelper.findChildText(slot0.goEpisodeInfo, "recommend/#txt_recommendLevel")
	slot0.btnStart = gohelper.findChildButtonWithAudio(slot0.goEpisodeInfo, "btnStart")
	slot0.btnReStart = gohelper.findChildButtonWithAudio(slot0.goEpisodeInfo, "btnReStart")
	slot0.goRewards = gohelper.findChild(slot0.goEpisodeInfo, "Reward/scroll_reward/Viewport/#go_rewards")
	slot0.goItem = gohelper.findChild(slot0.goRewards, "goItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnStart, slot0._onBtnStartClick, slot0)
	slot0:addClickCb(slot0.btnReStart, slot0._onBtnStartClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnStart)
	slot0:removeClickCb(slot0.btnReStart)
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

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.episodeConfig = slot0.viewParam.episodeConfig
	slot0.towerId = slot0.episodeConfig.towerId
	slot0.towerType = TowerEnum.TowerType.Boss
	slot0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(slot0.towerType)
	slot0.towerConfig = TowerConfig.instance:getBossTowerConfig(slot0.towerId)
	slot0.towerMo = TowerModel.instance:getTowerInfoById(slot0.towerType, slot0.towerId)
	slot0.bossConfig = TowerConfig.instance:getAssistBossConfig(slot0.towerConfig.bossId)
	slot0.bossInfo = TowerAssistBossModel.instance:getById(slot0.towerConfig.bossId)

	if slot0.selectLayerId == nil then
		slot0.selectLayerId = slot0.episodeConfig.layerId
	end
end

function slot0.refreshView(slot0)
	slot0.txtName.text = slot0.towerConfig.name
	slot0.txtLev.text = slot0.bossInfo and slot0.bossInfo.level or 0

	slot0.simageBoss:LoadImage(slot0.bossConfig.bossPic)
	slot0.simageShadow:LoadImage(slot0.bossConfig.bossShadowPic)
	slot0:refreshEpisodeList()
	slot0:refreshEpisodeInfo()
end

function slot0.refreshEpisodeList(slot0)
	slot1 = slot0.episodeMo:getSpEpisodes(slot0.towerId)

	if slot0.episodeItems == nil then
		slot0.episodeItems = {}
	end

	for slot5 = 1, 3 do
		if not slot0.episodeItems[slot5] then
			slot0.episodeItems[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, string.format("root/episodeNode/#go_episodes/episodeItem%s", slot5)), TowerBossSpEpisodeItem)
		end

		slot6:updateItem(slot1[slot5], slot5, slot0)
	end
end

function slot0.isSelectEpisode(slot0, slot1)
	return slot0.selectLayerId == slot1
end

function slot0.onClickEpisode(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:isSelectEpisode(slot1) then
		return
	end

	if not slot0.towerMo:isSpLayerOpen(slot1) then
		GameFacade.showToast(111)

		return
	end

	if not slot0.towerMo:isLayerUnlock(slot1, slot0.episodeMo) then
		GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

		return
	end

	slot0.selectLayerId = slot1

	if slot0.episodeItems then
		for slot8, slot9 in ipairs(slot0.episodeItems) do
			slot9:updateSelect()
		end
	end

	slot0:refreshEpisodeInfo()
end

function slot0.refreshEpisodeInfo(slot0)
	slot0.isPassLayer = slot0.selectLayerId <= slot0.towerMo.passLayerId
	slot2 = DungeonConfig.instance:getEpisodeCO(slot0.episodeMo:getEpisodeConfig(slot0.towerId, slot0.selectLayerId).episodeId)
	slot0.txtEpisodeIndex.text = string.format("SP-%s", slot0.episodeMo:getEpisodeIndex(slot0.towerId, slot0.selectLayerId))
	slot0.txtEpisodeName.text = slot2.name
	slot0.txtEpisodeNameEn.text = slot2.name_En
	slot0.txtEpisodeDesc.text = slot2.desc

	if FightHelper.getBattleRecommendLevel(slot2.battleId) >= 0 then
		slot0._txtrecommendlevel.text = HeroConfig.instance:getLevelDisplayVariant(slot4)
	else
		slot0._txtrecommendlevel.text = ""
	end

	slot7 = FightHelper.getAttributeCounter(string.splitToNumber(lua_battle.configDict[slot2.battleId].monsterGroupIds, "#"))

	gohelper.CreateObjList(slot0, slot0._onRecommendCareerItemShow, slot7, slot0._gorecommendattrlist, slot0._goattritem)

	if #slot7 == 0 then
		slot0._txtrecommonddes.text = luaLang("new_common_none")
	else
		slot0._txtrecommonddes.text = ""
	end

	slot0:refreshRewards(slot1.firstReward)
	gohelper.setActive(slot0.btnReStart, slot0.isPassLayer)
	gohelper.setActive(slot0.btnStart, not slot0.isPassLayer)
end

function slot0._onRecommendCareerItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot1, "icon"), "career_" .. slot2)
end

function slot0.refreshRewards(slot0, slot1)
	if slot0.rewardItems == nil then
		slot0.rewardItems = {}
	end

	slot6 = #(GameUtil.splitString2(slot1, true) or {})

	for slot6 = 1, math.max(#slot0.rewardItems, slot6) do
		if not slot0.rewardItems[slot6] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0.goItem)
			slot7.goReward = gohelper.findChild(slot7.go, "reward")
			slot7.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot7.goReward)
			slot7.goHasGet = gohelper.findChild(slot7.go, "#goHasGet")
			slot0.rewardItems[slot6] = slot7
		end

		gohelper.setActive(slot7.go, slot2[slot6] ~= nil)

		if slot2[slot6] then
			slot7.itemIcon:setMOValue(slot2[slot6][1], slot2[slot6][2], slot2[slot6][3], nil, true)
			slot7.itemIcon:setScale(0.7)
			slot7.itemIcon:setCountTxtSize(51)
			gohelper.setActive(slot7.goHasGet, slot0.isPassLayer)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simageBoss:UnLoadImage()
	slot0.simageShadow:UnLoadImage()
end

return slot0

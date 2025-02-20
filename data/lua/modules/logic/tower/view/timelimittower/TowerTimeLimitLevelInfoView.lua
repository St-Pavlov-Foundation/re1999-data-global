module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelInfoView", package.seeall)

slot0 = class("TowerTimeLimitLevelInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._godetailInfo = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo")
	slot0._txtIndex = gohelper.findChildText(slot0.viewGO, "root/#go_detailInfo/#txt_Index")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "root/#go_detailInfo/#txt_Title")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "root/#go_detailInfo/#txt_en")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_detailInfo/#btn_detail")
	slot0._gorecommendAttr = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_recommendAttr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_recommendAttr/attrlist/#go_attritem")
	slot0._txtrecommonddes = gohelper.findChildText(slot0.viewGO, "root/#go_detailInfo/#go_recommendAttr/#txt_recommonddes")
	slot0._txtrecommendLevel = gohelper.findChildText(slot0.viewGO, "root/#go_detailInfo/recommendtxt/#txt_recommendLevel")
	slot0._goadditionRule = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_additionRule")
	slot0._scrollrules = gohelper.findChildScrollRect(slot0.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules")
	slot0._gorules = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules/Viewport/#go_rules")
	slot0._goruletemp = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules/Viewport/#go_rules/#go_ruletemp")
	slot0._godifficulty = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_difficulty")
	slot0._goeasy = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_difficulty/#go_easy")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_difficulty/#go_normal")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_difficulty/#go_hard")
	slot0._btnswitchleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_detailInfo/#go_difficulty/#btn_switchleft")
	slot0._btnswitchright = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_detailInfo/#go_difficulty/#btn_switchright")
	slot0._txtmultiIndex = gohelper.findChildText(slot0.viewGO, "root/#go_detailInfo/#go_difficulty/index/#txt_multiIndex")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_detailInfo/#btn_Start")
	slot0._btnStartAgain = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_detailInfo/#btn_StartAgain")
	slot0._btnrefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#btn_refresh")
	slot0._goruleWindow = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_rulewindow")
	slot0._btncloseRule = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/#btn_closerule")
	slot0._goruleItem = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/bg/#go_ruleDescList/#go_ruleitem")
	slot0._goruleDescList = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/bg/#go_ruleDescList")
	slot0._goenemy = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy")
	slot0._simageenemy = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy/#simage_enemy")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/hero")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/hero/heroItem")
	slot0._goSwitchEfeect = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_difficulty/index/vx_refresh")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnswitchleft:AddClickListener(slot0._btnswitchleftOnClick, slot0)
	slot0._btnswitchright:AddClickListener(slot0._btnswitchrightOnClick, slot0)
	slot0._btnStart:AddClickListener(slot0._btnStartOnClick, slot0)
	slot0._btnStartAgain:AddClickListener(slot0._btnStartAgainOnClick, slot0)
	slot0._btnrefresh:AddClickListener(slot0._btnrefreshOnClick, slot0)
	slot0._btncloseRule:AddClickListener(slot0._btnCloseRuleOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
	slot0._btnswitchleft:RemoveClickListener()
	slot0._btnswitchright:RemoveClickListener()
	slot0._btnStart:RemoveClickListener()
	slot0._btnStartAgain:RemoveClickListener()
	slot0._btnrefresh:RemoveClickListener()
	slot0._btncloseRule:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.refreshUI, slot0)
end

function slot0._btndetailOnClick(slot0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot0.episodeConfig.battleId)
end

function slot0._btnadditionRuleclickOnClick(slot0)
	gohelper.setActive(slot0._goruleWindow, true)
end

function slot0._btnswitchleftOnClick(slot0)
	if slot0.difficulty == TowerEnum.Difficulty.Easy then
		return
	end

	slot0.difficulty = Mathf.Max(slot0.difficulty - 1, TowerEnum.Difficulty.Easy)

	gohelper.setActive(slot0._goSwitchEfeect, false)
	gohelper.setActive(slot0._goSwitchEfeect, true)
	TowerTimeLimitLevelModel.instance:setEntranceDifficulty(slot0.entranceId, slot0.difficulty)
	slot0:refreshUI()
end

function slot0._btnswitchrightOnClick(slot0)
	if slot0.difficulty == TowerEnum.Difficulty.Hard then
		return
	end

	slot0.difficulty = Mathf.Min(slot0.difficulty + 1, TowerEnum.Difficulty.Hard)

	gohelper.setActive(slot0._goSwitchEfeect, false)
	gohelper.setActive(slot0._goSwitchEfeect, true)
	TowerTimeLimitLevelModel.instance:setEntranceDifficulty(slot0.entranceId, slot0.difficulty)
	slot0:refreshUI()
end

function slot0._btnStartOnClick(slot0)
	TowerTimeLimitLevelModel.instance:saveLastEntranceDifficulty(slot0.curOpenMo)
	TowerController.instance:enterFight({
		towerType = TowerEnum.TowerType.Limited,
		towerId = slot0.seasonId,
		layerId = slot0.layerId,
		difficulty = slot0.difficulty,
		episodeId = slot0.episodeConfig.id
	})
end

function slot0._btnStartAgainOnClick(slot0)
	slot0:_btnStartOnClick()
end

function slot0._btnrefreshOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetSubEpisode, MsgBoxEnum.BoxType.Yes_No, slot0.sendDecomposeEquipRequest, nil, , slot0, nil, , TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, slot0.seasonId):getLayerScore(slot0.layerId))
end

function slot0.sendDecomposeEquipRequest(slot0)
	TowerRpc.instance:sendTowerResetSubEpisodeRequest(TowerEnum.TowerType.Limited, slot0.seasonId, slot0.layerId, 0, slot0.refreshUI, slot0)
end

function slot0._btnCloseRuleOnClick(slot0)
	gohelper.setActive(slot0._goruleWindow, false)
end

function slot0._editableInitView(slot0)
	slot0.goRoot = gohelper.findChild(slot0.viewGO, "root")
	slot0._animEventWrap = slot0.goRoot:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEventWrap:AddEventListener("switch", slot0.refreshUI, slot0)

	slot0.ruleItemTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goruleWindow, false)

	slot0.difficultyItemTab = {
		slot0._goeasy,
		slot0._gonormal,
		slot0._gohard
	}
	slot0.heroItemTab = slot0:getUserDataTb_()
	slot0.goLightLeftArrow = gohelper.findChild(slot0._btnswitchleft.gameObject, "light")
	slot0.goDarkLeftArrow = gohelper.findChild(slot0._btnswitchleft.gameObject, "dark")
	slot0.goLightRightArrow = gohelper.findChild(slot0._btnswitchright.gameObject, "light")
	slot0.goDarkRightArrow = gohelper.findChild(slot0._btnswitchright.gameObject, "dark")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.curOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if slot0.curOpenMo then
		slot0.seasonId = slot0.curOpenMo.towerId

		TowerTimeLimitLevelModel.instance:initEntranceDifficulty(slot0.curOpenMo)
	else
		logError("数据异常，当前没有开启的限时塔")

		return
	end
end

function slot0.refreshUI(slot0)
	slot0.entranceId = TowerTimeLimitLevelModel.instance.curSelectEntrance

	if slot0.entranceId == 0 or slot0.seasonId == 0 then
		return
	end

	slot0.difficulty = TowerTimeLimitLevelModel.instance:getEntranceDifficulty(slot0.entranceId)
	slot0.episodeConfig = DungeonConfig.instance:getEpisodeCO(TowerConfig.instance:getTowerLimitedTimeCoByDifficulty(slot0.seasonId, slot0.entranceId, slot0.difficulty).episodeId)
	slot0._txtIndex.text = string.format("SP%s", slot0.entranceId)
	slot0._txtTitle.text = slot0.episodeConfig.name
	slot0._txten.text = slot0.episodeConfig.name_En
	slot0._txtmultiIndex.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_multiindex"), {
		TowerTimeLimitLevelModel.instance:getDifficultyMulti(slot0.difficulty)
	})

	slot0:refreshDifficulty()
	slot0:refreshRecommend()
	slot0:refreshAdditionRule()
	slot0:refreshHeroList()
end

function slot0.refreshDifficulty(slot0)
	for slot4 = 1, 3 do
		gohelper.setActive(slot0.difficultyItemTab[slot4], slot4 == slot0.difficulty)
	end

	gohelper.setActive(slot0.goLightLeftArrow, TowerEnum.Difficulty.Easy < slot0.difficulty)
	gohelper.setActive(slot0.goDarkLeftArrow, slot0.difficulty == TowerEnum.Difficulty.Easy)
	gohelper.setActive(slot0.goLightRightArrow, slot0.difficulty < TowerEnum.Difficulty.Hard)
	gohelper.setActive(slot0.goDarkRightArrow, slot0.difficulty == TowerEnum.Difficulty.Hard)
end

function slot0.refreshRecommend(slot0)
	slot0._txtrecommendLevel.text = FightHelper.getBattleRecommendLevel(slot0.episodeConfig.battleId) >= 0 and HeroConfig.instance:getLevelDisplayVariant(slot1) or ""
	slot2, slot3 = TowerController.instance:getRecommendList(slot0.episodeConfig.battleId)

	gohelper.CreateObjList(slot0, slot0._onRecommendCareerItemShow, slot2, gohelper.findChild(slot0._gorecommendAttr.gameObject, "attrlist"), slot0._goattritem)

	slot0._txtrecommonddes.text = #slot2 == 0 and luaLang("new_common_none") or ""
end

function slot0._onRecommendCareerItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot1, "icon"), "career_" .. slot2)
end

function slot0.refreshAdditionRule(slot0)
	if not FightStrUtil.instance:getSplitString2Cache(lua_battle.configDict[slot0.episodeConfig.battleId] and slot1.additionRule or "", true, "|", "#") or #slot3 == 0 then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	gohelper.setActive(slot0._goadditionRule, true)
	gohelper.CreateObjList(slot0, slot0.ruleItemShow, slot3, slot0._gorules, slot0._goruletemp)
	gohelper.CreateObjList(slot0, slot0.ruleDescWindowShow, slot3, slot0._goruleDescList, slot0._goruleItem)
end

function slot0.ruleItemShow(slot0, slot1, slot2, slot3)
	if not slot0.ruleItemTab[slot3] then
		slot0.ruleItemTab[slot3] = {}
	end

	slot4.go = slot1
	slot4.tagicon = gohelper.findChildImage(slot4.go, "image_tagicon")
	slot4.simage = gohelper.findChildImage(slot4.go, "")
	slot4.btnClick = gohelper.findChildButtonWithAudio(slot4.go, "btn_additionRuleclick")

	UISpriteSetMgr.instance:setCommonSprite(slot4.tagicon, "wz_" .. slot2[1])
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot4.simage, lua_rule.configDict[slot2[2]].icon)
	slot4.btnClick:AddClickListener(slot0._btnadditionRuleclickOnClick, slot0)
end

function slot0.ruleDescWindowShow(slot0, slot1, slot2, slot3)
	slot6 = gohelper.findChildText(slot1, "desc")
	slot7 = slot2[1]
	slot9 = lua_rule.configDict[slot2[2]]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot1, "icon"), slot9.icon)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot1, "tag"), "wz_" .. slot7)
	SkillHelper.addHyperLinkClick(slot6)

	slot6.text = string.format("<color=%s>[%s]</color>%s", ({
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	})[slot7], luaLang("dungeon_add_rule_target_" .. slot7), SkillHelper.buildDesc(slot9.desc, nil, "#6680bd"))
end

function slot0.refreshHeroList(slot0)
	slot0.layerId = TowerConfig.instance:getTowerLimitedTimeCoList(slot0.seasonId, slot0.entranceId)[1].layerId
	slot4 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, slot0.seasonId):getLayerSubEpisodeList(slot0.layerId) and slot3[1].assistBossId or 0
	slot5 = slot3 and slot3[1].heroIds or {}
	slot0._simageenemy = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy/#simage_enemy")

	gohelper.setActive(slot0._goenemy, slot4 > 0)

	if slot4 > 0 then
		slot0._simageenemy:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(TowerConfig.instance:getAssistBossConfig(slot4).skinId).headIcon))
	end

	gohelper.setActive(slot0._btnStartAgain, slot5 and #slot5 > 0)
	gohelper.setActive(slot0._btnStart, not slot5 or #slot5 == 0)

	if slot5 and #slot5 > 0 then
		gohelper.CreateObjList(slot0, slot0._onHeroItemShow, slot5, slot0._gohero, slot0._goheroitem)
	end
end

function slot0._onHeroItemShow(slot0, slot1, slot2, slot3)
	if not slot0.heroItemTab[slot3] then
		slot0.heroItemTab[slot3] = {
			simagehero = gohelper.findChildSingleImage(slot1, "simage_hero")
		}
	end

	slot4.simagehero:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(HeroModel.instance:getByHeroId(slot2).skin).retangleIcon))
end

function slot0.onClose(slot0)
	TowerTimeLimitLevelModel.instance:saveLastEntranceDifficulty(slot0.curOpenMo)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.ruleItemTab) do
		slot5.btnClick:RemoveClickListener()
	end

	for slot4, slot5 in pairs(slot0.heroItemTab) do
		slot5.simagehero:UnLoadImage()
	end

	slot0._simageenemy:UnLoadImage()
	slot0._animEventWrap:RemoveAllEventListener()
end

return slot0

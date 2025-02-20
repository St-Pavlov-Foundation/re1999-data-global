module("modules.logic.tower.view.permanenttower.TowerPermanentInfoView", package.seeall)

slot0 = class("TowerPermanentInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtepisode = gohelper.findChildText(slot0.viewGO, "right/Title/#txt_episode")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "right/Title/#txt_name")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "right/Title/txt_TitleEn")
	slot0._btnenemyInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/Title/#btn_enemyInfo")
	slot0._gorecommendAttr = gohelper.findChild(slot0.viewGO, "right/#go_recommendAttr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "right/#go_recommendAttr/attrlist/#go_attritem")
	slot0._txtrecommonddes = gohelper.findChildText(slot0.viewGO, "right/#go_recommendAttr/#txt_recommonddes")
	slot0._txtrecommendLevel = gohelper.findChildText(slot0.viewGO, "right/recommendlevel/#txt_recommendLevel")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "right/desc/Viewport/#txt_desc")
	slot0._gocurherogroup = gohelper.findChild(slot0.viewGO, "right/#go_curherogroup")
	slot0._goherogroupItem = gohelper.findChild(slot0.viewGO, "right/#go_curherogroup/#go_herogroupItem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_reset")
	slot0._golock = gohelper.findChild(slot0.viewGO, "right/#btn_fight/#go_lock")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "right/#btn_fight/#go_start")
	slot0._gorestart = gohelper.findChild(slot0.viewGO, "right/#btn_fight/#go_restart")
	slot0._gostartElite = gohelper.findChild(slot0.viewGO, "right/#btn_fight/#go_startelite")
	slot0._gorestartElite = gohelper.findChild(slot0.viewGO, "right/#btn_fight/#go_restartelite")
	slot0._btnlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_fight/#go_lock")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_fight/#go_start")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_fight/#go_restart")
	slot0._btnstartElite = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_fight/#go_startelite")
	slot0._btnrestartElite = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_fight/#go_restartelite")
	slot0._gomopup = gohelper.findChild(slot0.viewGO, "#go_mopup")
	slot0._btnticket = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mopup/ticket/#btn_ticket")
	slot0._imageticket = gohelper.findChildImage(slot0.viewGO, "#go_mopup/ticket/#btn_ticket/#image_ticket")
	slot0._txtticketNum = gohelper.findChildText(slot0.viewGO, "#go_mopup/ticket/#btn_ticket/#txt_ticketNum")
	slot0._btnmopup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mopup/#btn_mopup")
	slot0._goMopUpReddot = gohelper.findChild(slot0.viewGO, "#go_mopup/#btn_mopup/#go_mopupReddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnenemyInfo:AddClickListener(slot0._btnenemyInfoOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnlock:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnstartElite:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnrestartElite:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnticket:AddClickListener(slot0._btnticketOnClick, slot0)
	slot0._btnmopup:AddClickListener(slot0._btnmopupOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.SelectPermanentEpisode, slot0.refreshUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.refreshUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerMopUp, slot0.refreshTicket, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshTicket, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnenemyInfo:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnlock:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnstartElite:RemoveClickListener()
	slot0._btnrestartElite:RemoveClickListener()
	slot0._btnticket:RemoveClickListener()
	slot0._btnmopup:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.SelectPermanentEpisode, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, slot0.refreshTicket, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshTicket, slot0)
end

function slot0._btnenemyInfoOnClick(slot0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot0.episodeCo.battleId)
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetPermanentEpisode, MsgBoxEnum.BoxType.Yes_No, slot0.sendTowerResetSubEpisodeRequest, nil, , slot0)
end

function slot0.sendTowerResetSubEpisodeRequest(slot0)
	TowerRpc.instance:sendTowerResetSubEpisodeRequest(TowerEnum.TowerType.Normal, TowerEnum.PermanentTowerId, slot0.layerConfig.layerId, slot0.curSelectEpisodeId)
end

function slot0._btnfightOnClick(slot0)
	if not slot0.layerConfig then
		return
	end

	if not TowerPermanentModel.instance:checkLayerUnlock(slot0.layerConfig) then
		return
	end

	TowerController.instance:enterFight({
		towerType = TowerEnum.TowerType.Normal,
		towerId = TowerEnum.PermanentTowerId,
		layerId = slot0.layerConfig.layerId,
		episodeId = slot0.curSelectEpisodeId
	})
end

function slot0._btnticketOnClick(slot0)
	slot1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)
end

function slot0._btnmopupOnClick(slot0)
	TowerController.instance:openTowerMopUpView()
end

function slot0._editableInitView(slot0)
	slot0.simageHeroGroupTab = slot0:getUserDataTb_()
	slot0._animEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEventWrap:AddEventListener("switchright", slot0.refreshUI, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	RedDotController.instance:addRedDot(slot0._goMopUpReddot, RedDotEnum.DotNode.TowerMopUp)
	slot0:refreshUI()
	slot0:refreshTicket()
end

function slot0.refreshUI(slot0)
	slot0.permanentTowerMo = TowerModel.instance:getCurPermanentMo()
	slot0.curSelectEpisodeId = TowerPermanentModel.instance:getCurSelectEpisodeId()
	slot1, slot2 = TowerPermanentModel.instance:getRealSelectStage()
	slot0.layerConfig = TowerConfig.instance:getPermanentEpisodeLayerCo(slot1, slot2)
	slot0.episodeCo = lua_episode.configDict[slot0.curSelectEpisodeId]
	slot0.isElite = slot0.layerConfig.isElite == 1
	slot0._txtepisode.text = "ST - " .. slot2
	slot0._txtname.text = GameUtil.setFirstStrSize(slot0.episodeCo.name, 90)
	slot0._txtTitleEn.text = slot0.episodeCo.name_En
	slot0._txtdesc.text = slot0.episodeCo.desc
	slot3, slot4 = TowerPermanentModel.instance:checkLayerSubEpisodeFinish(slot0.layerConfig.layerId, slot0.curSelectEpisodeId)
	slot5 = slot0.layerConfig.layerId <= slot0.permanentTowerMo.passLayerId

	gohelper.setActive(slot0._golock, not TowerPermanentModel.instance:checkLayerUnlock(slot0.layerConfig))
	gohelper.setActive(slot0._gorestart, slot5 and slot6 and not slot0.isElite)
	gohelper.setActive(slot0._gostart, not slot5 and slot6 and not slot0.isElite)
	gohelper.setActive(slot0._gorestartElite, slot3 and slot6 and slot0.isElite)
	gohelper.setActive(slot0._gostartElite, not slot3 and slot6 and slot0.isElite)
	gohelper.setActive(slot0._gocurherogroup, slot3 and slot4 and #slot4.heroIds > 0)
	gohelper.setActive(slot0._btnreset.gameObject, slot3 and slot4 and #slot4.heroIds > 0)

	if slot4 then
		if slot4.assistBossId > 0 then
			table.insert({}, {
				isAssistBoss = true,
				id = slot8
			})
		end

		for slot12, slot13 in ipairs(slot4.heroIds) do
			table.insert(slot7, {
				id = slot13
			})
		end

		gohelper.CreateObjList(slot0, slot0.showHeroGroupItem, slot7, slot0._gocurherogroup, slot0._goherogroupItem)
	end

	slot0:refreshRecommend()
end

function slot0.showHeroGroupItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChild(slot1, "go_herogItem")
	slot5 = gohelper.findChild(slot1, "go_bossItem")
	slot8 = {
		gohelper.findChildSingleImage(slot4, "simage_hero"),
		gohelper.findChildSingleImage(slot5, "simage_enemy")
	}

	gohelper.setActive(slot4, not slot2.isAssistBoss)
	gohelper.setActive(slot5, slot2.isAssistBoss)

	if slot2.isAssistBoss then
		slot7:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(TowerConfig.instance:getAssistBossConfig(slot2.id).skinId).headIcon))
	else
		slot6:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(HeroModel.instance:getByHeroId(slot2.id).skin).retangleIcon))
	end

	slot0.simageHeroGroupTab[slot3] = slot8
end

function slot0.refreshRecommend(slot0)
	slot0._txtrecommendLevel.text = FightHelper.getBattleRecommendLevel(slot0.episodeCo.battleId) >= 0 and HeroConfig.instance:getLevelDisplayVariant(slot1) or ""
	slot2, slot3 = TowerController.instance:getRecommendList(slot0.episodeCo.battleId)

	gohelper.CreateObjList(slot0, slot0._onRecommendCareerItemShow, slot2, gohelper.findChild(slot0._gorecommendAttr.gameObject, "attrlist"), slot0._goattritem)

	slot0._txtrecommonddes.text = #slot2 == 0 and luaLang("new_common_none") or ""
end

function slot0._onRecommendCareerItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot1, "icon"), "career_" .. slot2)
end

function slot0.refreshTicket(slot0)
	slot2 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)) <= slot0.permanentTowerMo.passLayerId

	gohelper.setActive(slot0._gomopup, slot2)

	if not slot2 then
		return
	end

	slot0._txtticketNum.text = string.format("%s/%s", TowerModel.instance:getMopUpTimes(), TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes))

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageticket, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon) .. "_1", true)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.simageHeroGroupTab) do
		for slot9, slot10 in pairs(slot5) do
			slot10:UnLoadImage()
		end
	end

	slot0._animEventWrap:RemoveAllEventListener()
end

return slot0

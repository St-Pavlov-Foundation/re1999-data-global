module("modules.logic.tower.view.permanenttower.TowerPermanentInfoView", package.seeall)

local var_0_0 = class("TowerPermanentInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtepisode = gohelper.findChildText(arg_1_0.viewGO, "right/Title/#txt_episode")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "right/Title/#txt_name")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "right/Title/txt_TitleEn")
	arg_1_0._btnenemyInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/Title/#btn_enemyInfo")
	arg_1_0._gorecommendAttr = gohelper.findChild(arg_1_0.viewGO, "right/#go_recommendAttr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "right/#go_recommendAttr/attrlist/#go_attritem")
	arg_1_0._txtrecommonddes = gohelper.findChildText(arg_1_0.viewGO, "right/#go_recommendAttr/#txt_recommonddes")
	arg_1_0._txtrecommendLevel = gohelper.findChildText(arg_1_0.viewGO, "right/recommendlevel/#txt_recommendLevel")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "right/desc/Viewport/#txt_desc")
	arg_1_0._gocurherogroup = gohelper.findChild(arg_1_0.viewGO, "right/#go_curherogroup")
	arg_1_0._goherogroupItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_curherogroup/#go_herogroupItem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_reset")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "right/#btn_fight/#go_lock")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "right/#btn_fight/#go_start")
	arg_1_0._gorestart = gohelper.findChild(arg_1_0.viewGO, "right/#btn_fight/#go_restart")
	arg_1_0._gostartElite = gohelper.findChild(arg_1_0.viewGO, "right/#btn_fight/#go_startelite")
	arg_1_0._gorestartElite = gohelper.findChild(arg_1_0.viewGO, "right/#btn_fight/#go_restartelite")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_fight/#go_lock")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_fight/#go_start")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_fight/#go_restart")
	arg_1_0._btnstartElite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_fight/#go_startelite")
	arg_1_0._btnrestartElite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_fight/#go_restartelite")
	arg_1_0._gomopup = gohelper.findChild(arg_1_0.viewGO, "#go_mopup")
	arg_1_0._btnticket = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_mopup/ticket/#btn_ticket")
	arg_1_0._imageticket = gohelper.findChildImage(arg_1_0.viewGO, "#go_mopup/ticket/#btn_ticket/#image_ticket")
	arg_1_0._txtticketNum = gohelper.findChildText(arg_1_0.viewGO, "#go_mopup/ticket/#btn_ticket/#txt_ticketNum")
	arg_1_0._btnmopup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_mopup/#btn_mopup")
	arg_1_0._goMopUpReddot = gohelper.findChild(arg_1_0.viewGO, "#go_mopup/#btn_mopup/#go_mopupReddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenemyInfo:AddClickListener(arg_2_0._btnenemyInfoOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnstartElite:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnrestartElite:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnticket:AddClickListener(arg_2_0._btnticketOnClick, arg_2_0)
	arg_2_0._btnmopup:AddClickListener(arg_2_0._btnmopupOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.SelectPermanentEpisode, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_2_0.refreshTicket, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.refreshTicket, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenemyInfo:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnstartElite:RemoveClickListener()
	arg_3_0._btnrestartElite:RemoveClickListener()
	arg_3_0._btnticket:RemoveClickListener()
	arg_3_0._btnmopup:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.SelectPermanentEpisode, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerMopUp, arg_3_0.refreshTicket, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.refreshTicket, arg_3_0)
end

function var_0_0._btnenemyInfoOnClick(arg_4_0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(arg_4_0.episodeCo.battleId)
end

function var_0_0._btnresetOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetPermanentEpisode, MsgBoxEnum.BoxType.Yes_No, arg_5_0.sendTowerResetSubEpisodeRequest, nil, nil, arg_5_0)
end

function var_0_0.sendTowerResetSubEpisodeRequest(arg_6_0)
	TowerRpc.instance:sendTowerResetSubEpisodeRequest(TowerEnum.TowerType.Normal, TowerEnum.PermanentTowerId, arg_6_0.layerConfig.layerId, arg_6_0.curSelectEpisodeId)
end

function var_0_0._btnfightOnClick(arg_7_0)
	if not arg_7_0.layerConfig then
		return
	end

	if not TowerPermanentModel.instance:checkLayerUnlock(arg_7_0.layerConfig) then
		return
	end

	local var_7_0 = {
		towerType = TowerEnum.TowerType.Normal,
		towerId = TowerEnum.PermanentTowerId,
		layerId = arg_7_0.layerConfig.layerId,
		episodeId = arg_7_0.curSelectEpisodeId
	}

	TowerController.instance:enterFight(var_7_0)
end

function var_0_0._btnticketOnClick(arg_8_0)
	local var_8_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)
end

function var_0_0._btnmopupOnClick(arg_9_0)
	TowerController.instance:openTowerMopUpView()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.simageHeroGroupTab = arg_10_0:getUserDataTb_()
	arg_10_0._animEventWrap = arg_10_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_10_0._animEventWrap:AddEventListener("switchright", arg_10_0.refreshUI, arg_10_0)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	RedDotController.instance:addRedDot(arg_12_0._goMopUpReddot, RedDotEnum.DotNode.TowerMopUp)
	arg_12_0:refreshUI()
	arg_12_0:refreshTicket()
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0.permanentTowerMo = TowerModel.instance:getCurPermanentMo()
	arg_13_0.curSelectEpisodeId = TowerPermanentModel.instance:getCurSelectEpisodeId()

	local var_13_0, var_13_1 = TowerPermanentModel.instance:getRealSelectStage()

	arg_13_0.layerConfig = TowerConfig.instance:getPermanentEpisodeLayerCo(var_13_0, var_13_1)
	arg_13_0.episodeCo = lua_episode.configDict[arg_13_0.curSelectEpisodeId]
	arg_13_0.isElite = arg_13_0.layerConfig.isElite == 1
	arg_13_0._txtepisode.text = "ST - " .. var_13_1
	arg_13_0._txtname.text = GameUtil.setFirstStrSize(arg_13_0.episodeCo.name, 90)
	arg_13_0._txtTitleEn.text = arg_13_0.episodeCo.name_En
	arg_13_0._txtdesc.text = arg_13_0.episodeCo.desc

	local var_13_2, var_13_3 = TowerPermanentModel.instance:checkLayerSubEpisodeFinish(arg_13_0.layerConfig.layerId, arg_13_0.curSelectEpisodeId)
	local var_13_4 = arg_13_0.layerConfig.layerId <= arg_13_0.permanentTowerMo.passLayerId
	local var_13_5 = TowerPermanentModel.instance:checkLayerUnlock(arg_13_0.layerConfig)

	gohelper.setActive(arg_13_0._golock, not var_13_5)
	gohelper.setActive(arg_13_0._gorestart, var_13_4 and var_13_5 and not arg_13_0.isElite)
	gohelper.setActive(arg_13_0._gostart, not var_13_4 and var_13_5 and not arg_13_0.isElite)
	gohelper.setActive(arg_13_0._gorestartElite, var_13_2 and var_13_5 and arg_13_0.isElite)
	gohelper.setActive(arg_13_0._gostartElite, not var_13_2 and var_13_5 and arg_13_0.isElite)
	gohelper.setActive(arg_13_0._gocurherogroup, var_13_2 and var_13_3 and #var_13_3.heroIds > 0)
	gohelper.setActive(arg_13_0._btnreset.gameObject, var_13_2 and var_13_3 and #var_13_3.heroIds > 0)

	if var_13_3 then
		local var_13_6 = {}
		local var_13_7 = var_13_3.assistBossId

		if var_13_7 > 0 then
			table.insert(var_13_6, {
				isAssistBoss = true,
				id = var_13_7
			})
		end

		for iter_13_0, iter_13_1 in ipairs(var_13_3.heroIds) do
			table.insert(var_13_6, {
				id = iter_13_1
			})
		end

		gohelper.CreateObjList(arg_13_0, arg_13_0.showHeroGroupItem, var_13_6, arg_13_0._gocurherogroup, arg_13_0._goherogroupItem)
	end

	arg_13_0:refreshRecommend()
end

function var_0_0.showHeroGroupItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChild(arg_14_1, "go_herogItem")
	local var_14_1 = gohelper.findChild(arg_14_1, "go_bossItem")
	local var_14_2 = gohelper.findChildSingleImage(var_14_0, "simage_hero")
	local var_14_3 = gohelper.findChildSingleImage(var_14_1, "simage_enemy")
	local var_14_4 = {
		var_14_2,
		var_14_3
	}

	gohelper.setActive(var_14_0, not arg_14_2.isAssistBoss)
	gohelper.setActive(var_14_1, arg_14_2.isAssistBoss)

	if arg_14_2.isAssistBoss then
		local var_14_5 = TowerConfig.instance:getAssistBossConfig(arg_14_2.id)
		local var_14_6 = FightConfig.instance:getSkinCO(var_14_5.skinId)

		var_14_3:LoadImage(ResUrl.monsterHeadIcon(var_14_6.headIcon))
	else
		local var_14_7 = HeroModel.instance:getByHeroId(arg_14_2.id)
		local var_14_8 = {}

		if not var_14_7 then
			local var_14_9 = HeroConfig.instance:getHeroCO(arg_14_2.id)

			var_14_8 = SkinConfig.instance:getSkinCo(var_14_9.skinId)
		else
			var_14_8 = FightConfig.instance:getSkinCO(var_14_7.skin)
		end

		var_14_2:LoadImage(ResUrl.getHeadIconSmall(var_14_8.retangleIcon))
	end

	arg_14_0.simageHeroGroupTab[arg_14_3] = var_14_4
end

function var_0_0.refreshRecommend(arg_15_0)
	local var_15_0 = FightHelper.getBattleRecommendLevel(arg_15_0.episodeCo.battleId)

	arg_15_0._txtrecommendLevel.text = var_15_0 >= 0 and HeroConfig.instance:getLevelDisplayVariant(var_15_0) or ""

	local var_15_1, var_15_2 = TowerController.instance:getRecommendList(arg_15_0.episodeCo.battleId)

	gohelper.CreateObjList(arg_15_0, arg_15_0._onRecommendCareerItemShow, var_15_1, gohelper.findChild(arg_15_0._gorecommendAttr.gameObject, "attrlist"), arg_15_0._goattritem)

	arg_15_0._txtrecommonddes.text = #var_15_1 == 0 and luaLang("new_common_none") or ""
end

function var_0_0._onRecommendCareerItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = gohelper.findChildImage(arg_16_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_16_0, "career_" .. arg_16_2)
end

function var_0_0.refreshTicket(arg_17_0)
	local var_17_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)
	local var_17_1 = arg_17_0.permanentTowerMo.passLayerId >= tonumber(var_17_0)

	gohelper.setActive(arg_17_0._gomopup, var_17_1)

	if not var_17_1 then
		return
	end

	local var_17_2 = TowerModel.instance:getMopUpTimes()
	local var_17_3 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	arg_17_0._txtticketNum.text = string.format("%s/%s", var_17_2, var_17_3)

	local var_17_4 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_17_0._imageticket, var_17_4 .. "_1", true)
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.simageHeroGroupTab) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			iter_19_3:UnLoadImage()
		end
	end

	arg_19_0._animEventWrap:RemoveAllEventListener()
end

return var_0_0

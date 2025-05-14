module("modules.logic.tower.view.bosstower.TowerBossSpEpisodeView", package.seeall)

local var_0_0 = class("TowerBossSpEpisodeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.simageBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/episodeNode/BOSS/#simage_BossPic")
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/episodeNode/nameBg/txtName")
	arg_1_0.simageShadow = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/episodeNode/BOSS/#simage_BossShadow")
	arg_1_0.txtLev = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/episodeNode/#go_episodes/Bottom/txtCurEpisode")
	arg_1_0.goEpisodeInfo = gohelper.findChild(arg_1_0.viewGO, "root/episodeInfo")
	arg_1_0.txtEpisodeIndex = gohelper.findChildTextMesh(arg_1_0.goEpisodeInfo, "Title/txtIndex")
	arg_1_0.txtEpisodeName = gohelper.findChildTextMesh(arg_1_0.goEpisodeInfo, "Title/txtTitle")
	arg_1_0.txtEpisodeNameEn = gohelper.findChildTextMesh(arg_1_0.goEpisodeInfo, "Title/txt_TitleEn")
	arg_1_0.txtEpisodeDesc = gohelper.findChildTextMesh(arg_1_0.goEpisodeInfo, "desc/Viewport/content")
	arg_1_0._gorecommendattr = gohelper.findChild(arg_1_0.goEpisodeInfo, "#go_recommendAttr")
	arg_1_0._gorecommendattrlist = gohelper.findChild(arg_1_0._gorecommendattr, "attrlist")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.goEpisodeInfo, "#go_recommendAttr/attrlist/#go_attritem")
	arg_1_0._txtrecommonddes = gohelper.findChildTextMesh(arg_1_0.goEpisodeInfo, "#go_recommendAttr/#txt_recommonddes")
	arg_1_0._txtrecommendlevel = gohelper.findChildText(arg_1_0.goEpisodeInfo, "recommend/#txt_recommendLevel")
	arg_1_0.btnStart = gohelper.findChildButtonWithAudio(arg_1_0.goEpisodeInfo, "btnStart")
	arg_1_0.btnReStart = gohelper.findChildButtonWithAudio(arg_1_0.goEpisodeInfo, "btnReStart")
	arg_1_0.goRewards = gohelper.findChild(arg_1_0.goEpisodeInfo, "Reward/scroll_reward/Viewport/#go_rewards")
	arg_1_0.goItem = gohelper.findChild(arg_1_0.goRewards, "goItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnStart, arg_2_0._onBtnStartClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnReStart, arg_2_0._onBtnStartClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnStart)
	arg_3_0:removeClickCb(arg_3_0.btnReStart)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onBtnStartClick(arg_5_0)
	if not arg_5_0.episodeConfig then
		return
	end

	local var_5_0 = {
		towerType = arg_5_0.towerType,
		towerId = arg_5_0.towerId,
		layerId = arg_5_0.episodeConfig.layerId,
		episodeId = arg_5_0.episodeConfig.episodeId
	}

	TowerController.instance:enterFight(var_5_0)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshParam(arg_8_0)
	arg_8_0.episodeConfig = arg_8_0.viewParam.episodeConfig
	arg_8_0.towerId = arg_8_0.episodeConfig.towerId
	arg_8_0.towerType = TowerEnum.TowerType.Boss
	arg_8_0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(arg_8_0.towerType)
	arg_8_0.towerConfig = TowerConfig.instance:getBossTowerConfig(arg_8_0.towerId)
	arg_8_0.towerMo = TowerModel.instance:getTowerInfoById(arg_8_0.towerType, arg_8_0.towerId)
	arg_8_0.bossConfig = TowerConfig.instance:getAssistBossConfig(arg_8_0.towerConfig.bossId)
	arg_8_0.bossInfo = TowerAssistBossModel.instance:getById(arg_8_0.towerConfig.bossId)

	if arg_8_0.selectLayerId == nil then
		arg_8_0.selectLayerId = arg_8_0.episodeConfig.layerId
	end
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0.txtName.text = arg_9_0.towerConfig.name
	arg_9_0.txtLev.text = arg_9_0.bossInfo and arg_9_0.bossInfo.level or 0

	arg_9_0.simageBoss:LoadImage(arg_9_0.bossConfig.bossPic)
	arg_9_0.simageShadow:LoadImage(arg_9_0.bossConfig.bossShadowPic)
	arg_9_0:refreshEpisodeList()
	arg_9_0:refreshEpisodeInfo()
end

function var_0_0.refreshEpisodeList(arg_10_0)
	local var_10_0 = arg_10_0.episodeMo:getSpEpisodes(arg_10_0.towerId)

	if arg_10_0.episodeItems == nil then
		arg_10_0.episodeItems = {}
	end

	for iter_10_0 = 1, 3 do
		local var_10_1 = arg_10_0.episodeItems[iter_10_0]

		if not var_10_1 then
			local var_10_2 = gohelper.findChild(arg_10_0.viewGO, string.format("root/episodeNode/#go_episodes/episodeItem%s", iter_10_0))

			var_10_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_2, TowerBossSpEpisodeItem)
			arg_10_0.episodeItems[iter_10_0] = var_10_1
		end

		var_10_1:updateItem(var_10_0[iter_10_0], iter_10_0, arg_10_0)
	end
end

function var_0_0.isSelectEpisode(arg_11_0, arg_11_1)
	return arg_11_0.selectLayerId == arg_11_1
end

function var_0_0.onClickEpisode(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	if arg_12_0:isSelectEpisode(arg_12_1) then
		return
	end

	if not arg_12_0.towerMo:isSpLayerOpen(arg_12_1) then
		GameFacade.showToast(111)

		return
	end

	if not arg_12_0.towerMo:isLayerUnlock(arg_12_1, arg_12_0.episodeMo) then
		GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

		return
	end

	arg_12_0.selectLayerId = arg_12_1

	if arg_12_0.episodeItems then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.episodeItems) do
			iter_12_1:updateSelect()
		end
	end

	arg_12_0:refreshEpisodeInfo()
end

function var_0_0.refreshEpisodeInfo(arg_13_0)
	arg_13_0.isPassLayer = arg_13_0.towerMo.passLayerId >= arg_13_0.selectLayerId

	local var_13_0 = arg_13_0.episodeMo:getEpisodeConfig(arg_13_0.towerId, arg_13_0.selectLayerId)
	local var_13_1 = DungeonConfig.instance:getEpisodeCO(var_13_0.episodeId)
	local var_13_2 = arg_13_0.episodeMo:getEpisodeIndex(arg_13_0.towerId, arg_13_0.selectLayerId)

	arg_13_0.txtEpisodeIndex.text = string.format("SP-%s", var_13_2)
	arg_13_0.txtEpisodeName.text = var_13_1.name
	arg_13_0.txtEpisodeNameEn.text = var_13_1.name_En
	arg_13_0.txtEpisodeDesc.text = var_13_1.desc

	local var_13_3 = FightHelper.getBattleRecommendLevel(var_13_1.battleId)

	if var_13_3 >= 0 then
		arg_13_0._txtrecommendlevel.text = HeroConfig.instance:getLevelDisplayVariant(var_13_3)
	else
		arg_13_0._txtrecommendlevel.text = ""
	end

	local var_13_4 = lua_battle.configDict[var_13_1.battleId]
	local var_13_5 = string.splitToNumber(var_13_4.monsterGroupIds, "#")
	local var_13_6 = FightHelper.getAttributeCounter(var_13_5)

	gohelper.CreateObjList(arg_13_0, arg_13_0._onRecommendCareerItemShow, var_13_6, arg_13_0._gorecommendattrlist, arg_13_0._goattritem)

	if #var_13_6 == 0 then
		arg_13_0._txtrecommonddes.text = luaLang("new_common_none")
	else
		arg_13_0._txtrecommonddes.text = ""
	end

	arg_13_0:refreshRewards(var_13_0.firstReward)
	gohelper.setActive(arg_13_0.btnReStart, arg_13_0.isPassLayer)
	gohelper.setActive(arg_13_0.btnStart, not arg_13_0.isPassLayer)
end

function var_0_0._onRecommendCareerItemShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChildImage(arg_14_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_14_0, "career_" .. arg_14_2)
end

function var_0_0.refreshRewards(arg_15_0, arg_15_1)
	if arg_15_0.rewardItems == nil then
		arg_15_0.rewardItems = {}
	end

	local var_15_0 = GameUtil.splitString2(arg_15_1, true) or {}

	for iter_15_0 = 1, math.max(#arg_15_0.rewardItems, #var_15_0) do
		local var_15_1 = arg_15_0.rewardItems[iter_15_0]

		if not var_15_1 then
			var_15_1 = arg_15_0:getUserDataTb_()
			var_15_1.go = gohelper.cloneInPlace(arg_15_0.goItem)
			var_15_1.goReward = gohelper.findChild(var_15_1.go, "reward")
			var_15_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_15_1.goReward)
			var_15_1.goHasGet = gohelper.findChild(var_15_1.go, "#goHasGet")
			arg_15_0.rewardItems[iter_15_0] = var_15_1
		end

		gohelper.setActive(var_15_1.go, var_15_0[iter_15_0] ~= nil)

		if var_15_0[iter_15_0] then
			var_15_1.itemIcon:setMOValue(var_15_0[iter_15_0][1], var_15_0[iter_15_0][2], var_15_0[iter_15_0][3], nil, true)
			var_15_1.itemIcon:setScale(0.7)
			var_15_1.itemIcon:setCountTxtSize(51)
			gohelper.setActive(var_15_1.goHasGet, arg_15_0.isPassLayer)
		end
	end
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0.simageBoss:UnLoadImage()
	arg_17_0.simageShadow:UnLoadImage()
end

return var_0_0

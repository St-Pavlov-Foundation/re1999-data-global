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
	arg_1_0.btnTeach = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/episodeInfo/btnTeach")
	arg_1_0.goTeachFinish = gohelper.findChild(arg_1_0.viewGO, "root/episodeInfo/btnTeach/go_teachFinish")
	arg_1_0.animTeachFinishEffect = gohelper.findChild(arg_1_0.viewGO, "root/episodeInfo/btnTeach/go_teachFinish/go_hasget"):GetComponent(gohelper.Type_Animator)
	arg_1_0.goRewards = gohelper.findChild(arg_1_0.goEpisodeInfo, "Reward/scroll_reward/Viewport/#go_rewards")
	arg_1_0.goItem = gohelper.findChild(arg_1_0.goRewards, "goItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnStart, arg_2_0._onBtnStartClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnReStart, arg_2_0._onBtnStartClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTeach, arg_2_0._onBtnTeachClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnStart)
	arg_3_0:removeClickCb(arg_3_0.btnReStart)
	arg_3_0:removeClickCb(arg_3_0.btnTeach)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onBtnStartClick(arg_5_0)
	if not arg_5_0.selectLayerId then
		return
	end

	local var_5_0 = {
		towerType = arg_5_0.towerType,
		towerId = arg_5_0.towerId,
		layerId = arg_5_0.selectLayerId,
		episodeId = arg_5_0.episodeMo:getEpisodeConfig(arg_5_0.towerId, arg_5_0.selectLayerId).episodeId
	}

	TowerController.instance:enterFight(var_5_0)
end

function var_0_0._onBtnTeachClick(arg_6_0)
	local var_6_0 = {
		towerType = arg_6_0.towerType,
		towerId = arg_6_0.towerId
	}

	TowerController.instance:openTowerBossTeachView(var_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.refreshParam(arg_9_0)
	arg_9_0.episodeConfig = arg_9_0.viewParam.episodeConfig
	arg_9_0.towerId = arg_9_0.episodeConfig.towerId
	arg_9_0.towerType = TowerEnum.TowerType.Boss
	arg_9_0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(arg_9_0.towerType)
	arg_9_0.towerConfig = TowerConfig.instance:getBossTowerConfig(arg_9_0.towerId)
	arg_9_0.towerMo = TowerModel.instance:getTowerInfoById(arg_9_0.towerType, arg_9_0.towerId)
	arg_9_0.bossConfig = TowerConfig.instance:getAssistBossConfig(arg_9_0.towerConfig.bossId)
	arg_9_0.bossInfo = TowerAssistBossModel.instance:getById(arg_9_0.towerConfig.bossId)

	if arg_9_0.selectLayerId == nil then
		arg_9_0.selectLayerId = arg_9_0.episodeConfig.layerId
	end

	if arg_9_0.viewParam.isTeach then
		arg_9_0:_onBtnTeachClick()
	end
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0.txtName.text = arg_10_0.towerConfig.name
	arg_10_0.txtLev.text = arg_10_0.bossInfo and arg_10_0.bossInfo.level or 0

	arg_10_0.simageBoss:LoadImage(arg_10_0.bossConfig.bossPic)
	arg_10_0.simageShadow:LoadImage(arg_10_0.bossConfig.bossShadowPic)
	arg_10_0:refreshEpisodeList()
	arg_10_0:refreshEpisodeInfo()
end

function var_0_0.refreshEpisodeList(arg_11_0)
	local var_11_0 = arg_11_0.episodeMo:getSpEpisodes(arg_11_0.towerId)

	if arg_11_0.episodeItems == nil then
		arg_11_0.episodeItems = {}
	end

	for iter_11_0 = 1, 3 do
		local var_11_1 = arg_11_0.episodeItems[iter_11_0]

		if not var_11_1 then
			local var_11_2 = gohelper.findChild(arg_11_0.viewGO, string.format("root/episodeNode/#go_episodes/episodeItem%s", iter_11_0))

			var_11_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_2, TowerBossSpEpisodeItem)
			arg_11_0.episodeItems[iter_11_0] = var_11_1
		end

		var_11_1:updateItem(var_11_0[iter_11_0], iter_11_0, arg_11_0)
	end
end

function var_0_0.isSelectEpisode(arg_12_0, arg_12_1)
	return arg_12_0.selectLayerId == arg_12_1
end

function var_0_0.onClickEpisode(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	if arg_13_0:isSelectEpisode(arg_13_1) then
		return
	end

	if not arg_13_0.towerMo:isSpLayerOpen(arg_13_1) then
		GameFacade.showToast(111)

		return
	end

	if not arg_13_0.towerMo:isLayerUnlock(arg_13_1, arg_13_0.episodeMo) then
		GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

		return
	end

	arg_13_0.selectLayerId = arg_13_1

	if arg_13_0.episodeItems then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.episodeItems) do
			iter_13_1:updateSelect()
		end
	end

	arg_13_0:refreshEpisodeInfo()
end

function var_0_0.refreshEpisodeInfo(arg_14_0)
	arg_14_0.isPassLayer = arg_14_0.towerMo.passLayerId >= arg_14_0.selectLayerId

	local var_14_0 = arg_14_0.episodeMo:getEpisodeConfig(arg_14_0.towerId, arg_14_0.selectLayerId)
	local var_14_1 = DungeonConfig.instance:getEpisodeCO(var_14_0.episodeId)
	local var_14_2 = arg_14_0.episodeMo:getEpisodeIndex(arg_14_0.towerId, arg_14_0.selectLayerId)

	arg_14_0.txtEpisodeIndex.text = string.format("SP-%s", var_14_2)
	arg_14_0.txtEpisodeName.text = var_14_1.name
	arg_14_0.txtEpisodeNameEn.text = var_14_1.name_En
	arg_14_0.txtEpisodeDesc.text = var_14_1.desc

	local var_14_3 = FightHelper.getBattleRecommendLevel(var_14_1.battleId)

	if var_14_3 >= 0 then
		arg_14_0._txtrecommendlevel.text = HeroConfig.instance:getLevelDisplayVariant(var_14_3)
	else
		arg_14_0._txtrecommendlevel.text = ""
	end

	local var_14_4 = lua_battle.configDict[var_14_1.battleId]
	local var_14_5 = string.splitToNumber(var_14_4.monsterGroupIds, "#")
	local var_14_6 = FightHelper.getAttributeCounter(var_14_5)

	gohelper.CreateObjList(arg_14_0, arg_14_0._onRecommendCareerItemShow, var_14_6, arg_14_0._gorecommendattrlist, arg_14_0._goattritem)

	if #var_14_6 == 0 then
		arg_14_0._txtrecommonddes.text = luaLang("new_common_none")
	else
		arg_14_0._txtrecommonddes.text = ""
	end

	arg_14_0:refreshRewards(var_14_0.firstReward)
	gohelper.setActive(arg_14_0.btnReStart, arg_14_0.isPassLayer)
	gohelper.setActive(arg_14_0.btnStart, not arg_14_0.isPassLayer)
	arg_14_0:refreshTeachUI()
end

function var_0_0.refreshTeachUI(arg_15_0)
	local var_15_0 = TowerBossTeachModel.instance:isAllEpisodeFinish(arg_15_0.towerConfig.bossId)

	gohelper.setActive(arg_15_0.goTeachFinish, var_15_0)

	local var_15_1 = TowerBossTeachModel.instance:getTeachFinishEffectSaveKey(arg_15_0.towerConfig.bossId)

	if TowerController.instance:getPlayerPrefs(var_15_1, 0) == 0 and var_15_0 then
		arg_15_0.animTeachFinishEffect:Play("go_hasget_in", 0, 0)
		TowerController.instance:setPlayerPrefs(var_15_1, 1)
	else
		arg_15_0.animTeachFinishEffect:Play("go_hasget_idle", 0, 0)
	end
end

function var_0_0._onRecommendCareerItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = gohelper.findChildImage(arg_16_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_16_0, "career_" .. arg_16_2)
end

function var_0_0.refreshRewards(arg_17_0, arg_17_1)
	if arg_17_0.rewardItems == nil then
		arg_17_0.rewardItems = {}
	end

	local var_17_0 = GameUtil.splitString2(arg_17_1, true) or {}

	for iter_17_0 = 1, math.max(#arg_17_0.rewardItems, #var_17_0) do
		local var_17_1 = arg_17_0.rewardItems[iter_17_0]

		if not var_17_1 then
			var_17_1 = arg_17_0:getUserDataTb_()
			var_17_1.go = gohelper.cloneInPlace(arg_17_0.goItem)
			var_17_1.goReward = gohelper.findChild(var_17_1.go, "reward")
			var_17_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_17_1.goReward)
			var_17_1.goHasGet = gohelper.findChild(var_17_1.go, "#goHasGet")
			arg_17_0.rewardItems[iter_17_0] = var_17_1
		end

		gohelper.setActive(var_17_1.go, var_17_0[iter_17_0] ~= nil)

		if var_17_0[iter_17_0] then
			var_17_1.itemIcon:setMOValue(var_17_0[iter_17_0][1], var_17_0[iter_17_0][2], var_17_0[iter_17_0][3], nil, true)
			var_17_1.itemIcon:setScale(0.7)
			var_17_1.itemIcon:setCountTxtSize(51)
			gohelper.setActive(var_17_1.goHasGet, arg_17_0.isPassLayer)
		end
	end
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0.simageBoss:UnLoadImage()
	arg_19_0.simageShadow:UnLoadImage()
end

return var_0_0

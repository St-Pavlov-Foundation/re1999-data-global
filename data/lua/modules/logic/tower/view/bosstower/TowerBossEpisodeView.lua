module("modules.logic.tower.view.bosstower.TowerBossEpisodeView", package.seeall)

local var_0_0 = class("TowerBossEpisodeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/episodeNode/nameBg/txtName")
	arg_1_0.btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Right/btnStart")
	arg_1_0.btnTeach = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnTeach")
	arg_1_0.goTeachFinish = gohelper.findChild(arg_1_0.viewGO, "root/btnTeach/go_teachFinish")
	arg_1_0.animTeachFinishEffect = gohelper.findChild(arg_1_0.viewGO, "root/btnTeach/go_teachFinish/go_hasget"):GetComponent(gohelper.Type_Animator)
	arg_1_0.goRewards = gohelper.findChild(arg_1_0.viewGO, "root/Right/Reward/scroll_reward/Viewport/#go_rewards")
	arg_1_0.goAttrInfo = gohelper.findChild(arg_1_0.viewGO, "root/Right/attrInfo")
	arg_1_0.goLevItem = gohelper.findChild(arg_1_0.viewGO, "root/Right/attrInfo/levItem")
	arg_1_0.txtCurLev = gohelper.findChildTextMesh(arg_1_0.goLevItem, "curLev")
	arg_1_0.txtNextLev = gohelper.findChildTextMesh(arg_1_0.goLevItem, "nextLev")
	arg_1_0.goAttrItem = gohelper.findChild(arg_1_0.viewGO, "root/Right/attrInfo/attrItem")

	gohelper.setActive(arg_1_0.goAttrItem, false)

	arg_1_0.goTalentPoint = gohelper.findChild(arg_1_0.viewGO, "root/Right/attrInfo/talentPoint")
	arg_1_0.txtTalentPoint = gohelper.findChildTextMesh(arg_1_0.goTalentPoint, "value")
	arg_1_0.goSkillUnlock = gohelper.findChild(arg_1_0.viewGO, "root/Right/attrInfo/skillUnlock")
	arg_1_0.imgSkillUnlock = gohelper.findChildImage(arg_1_0.viewGO, "root/Right/attrInfo/skillUnlock/icon")
	arg_1_0.goBossUnlock = gohelper.findChild(arg_1_0.viewGO, "root/Right/attrInfo/bossUnlock")
	arg_1_0.txtPreIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/episodeNode/Levels/indexBg2/txtCurEpisode")
	arg_1_0.txtCurIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/episodeNode/Levels/indexBg3/txtCurEpisode")
	arg_1_0.txtNextIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/episodeNode/Levels/indexBg4/txtCurEpisode")
	arg_1_0.simageBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/episodeNode/BOSS/#simage_BossPic")
	arg_1_0.simageShadow = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/episodeNode/BOSS/#simage_BossShadow")
	arg_1_0.animLevels = gohelper.findChildComponent(arg_1_0.viewGO, "root/episodeNode/Levels", gohelper.Type_Animator)
	arg_1_0.goLevels = gohelper.findChild(arg_1_0.viewGO, "root/episodeNode/Levels")
	arg_1_0.goRight = gohelper.findChild(arg_1_0.viewGO, "root/Right")
	arg_1_0.goLevMax = gohelper.findChild(arg_1_0.viewGO, "root/#go_levelmax")
	arg_1_0.txtMaxLevel = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_levelmax/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnStart, arg_2_0._onBtnStartClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTeach, arg_2_0._onBtnTeachClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnStart)
	arg_3_0:removeClickCb(arg_3_0.btnTeach)
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

function var_0_0._onBtnTeachClick(arg_6_0)
	local var_6_0 = {
		towerType = arg_6_0.towerType,
		towerId = arg_6_0.towerId,
		lastFightTeachId = arg_6_0.viewParam.lastFightTeachId
	}

	TowerController.instance:openTowerBossTeachView(var_6_0)

	arg_6_0.viewParam.lastFightTeachId = 0
end

function var_0_0._onMove(arg_7_0)
	arg_7_0:refreshCurLayerId()
	arg_7_0:refreshLayerInfo()
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:refreshParam()
	arg_9_0:refreshView()

	if arg_9_0.needChangeLayer then
		UIBlockMgr.instance:startBlock("delayMove")
		TaskDispatcher.runDelay(arg_9_0.delayMove, arg_9_0, 1)
	end
end

function var_0_0.delayMove(arg_10_0)
	UIBlockMgr.instance:endBlock("delayMove")
	arg_10_0.animLevels:Play("move")
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_boss_swtich)
	TaskDispatcher.runDelay(arg_10_0._onMove, arg_10_0, 0.167)
end

function var_0_0.refreshParam(arg_11_0)
	arg_11_0.episodeConfig = arg_11_0.viewParam.episodeConfig
	arg_11_0.towerId = arg_11_0.episodeConfig.towerId
	arg_11_0.towerType = TowerEnum.TowerType.Boss
	arg_11_0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(arg_11_0.towerType)
	arg_11_0.towerConfig = TowerConfig.instance:getBossTowerConfig(arg_11_0.towerId)
	arg_11_0.bossConfig = TowerConfig.instance:getAssistBossConfig(arg_11_0.towerConfig.bossId)
	arg_11_0.towerInfo = TowerModel.instance:getTowerInfoById(arg_11_0.towerType, arg_11_0.towerId)

	arg_11_0:refreshCurLayerId()

	if arg_11_0.viewParam.isTeach then
		arg_11_0:_onBtnTeachClick()
	end
end

function var_0_0.refreshCurLayerId(arg_12_0)
	local var_12_0 = arg_12_0.viewParam and arg_12_0.viewParam.passLayerId

	if var_12_0 then
		arg_12_0.curLayer = var_12_0
		arg_12_0.viewParam.passLayerId = nil
	else
		arg_12_0.curLayer = arg_12_0.episodeConfig.layerId
	end

	arg_12_0.needChangeLayer = arg_12_0.curLayer ~= arg_12_0.episodeConfig.layerId
end

function var_0_0.refreshView(arg_13_0)
	arg_13_0.txtName.text = arg_13_0.towerConfig.name

	arg_13_0.simageBoss:LoadImage(arg_13_0.bossConfig.bossPic)
	arg_13_0.simageShadow:LoadImage(arg_13_0.bossConfig.bossShadowPic)
	arg_13_0:refreshLayerInfo()
end

function var_0_0.refreshLayerInfo(arg_14_0)
	local var_14_0 = not arg_14_0.needChangeLayer and arg_14_0.towerInfo:isLayerPass(arg_14_0.curLayer, arg_14_0.episodeMo)

	gohelper.setActive(arg_14_0.goLevMax, var_14_0)
	gohelper.setActive(arg_14_0.goLevels, not var_14_0)
	gohelper.setActive(arg_14_0.goRight, not var_14_0)

	if not var_14_0 then
		arg_14_0:refreshIndex()
		arg_14_0:refreshRewards(arg_14_0.episodeConfig.firstReward)
		arg_14_0:refreshAttr()
	else
		arg_14_0.txtMaxLevel.text = tostring(arg_14_0.episodeMo:getEpisodeIndex(arg_14_0.towerId, arg_14_0.curLayer))
	end

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

function var_0_0.refreshIndex(arg_16_0)
	local var_16_0 = arg_16_0.episodeMo:getEpisodeConfig(arg_16_0.towerId, arg_16_0.curLayer)

	arg_16_0.txtCurIndex.text = tostring(arg_16_0.episodeMo:getEpisodeIndex(arg_16_0.towerId, arg_16_0.curLayer))

	local var_16_1 = arg_16_0.episodeMo:getNextEpisodeLayer(arg_16_0.towerId, arg_16_0.curLayer)

	if var_16_1 then
		if arg_16_0.episodeMo:getEpisodeConfig(arg_16_0.towerId, var_16_1).openRound > 0 then
			arg_16_0.txtNextIndex.text = ""
		else
			arg_16_0.txtNextIndex.text = tostring(arg_16_0.episodeMo:getEpisodeIndex(arg_16_0.towerId, var_16_1))
		end
	else
		arg_16_0.txtNextIndex.text = ""
	end

	local var_16_2 = var_16_0.preLayerId

	if var_16_2 and var_16_2 > 0 then
		arg_16_0.txtPreIndex.text = tostring(arg_16_0.episodeMo:getEpisodeIndex(arg_16_0.towerId, var_16_2))
	else
		arg_16_0.txtPreIndex.text = ""
	end
end

function var_0_0.refreshRewards(arg_17_0, arg_17_1)
	if arg_17_0.rewardItems == nil then
		arg_17_0.rewardItems = {}
	end

	local var_17_0 = GameUtil.splitString2(arg_17_1, true) or {}

	for iter_17_0 = 1, math.max(#arg_17_0.rewardItems, #var_17_0) do
		local var_17_1 = arg_17_0.rewardItems[iter_17_0]

		if not var_17_1 then
			var_17_1 = IconMgr.instance:getCommonPropItemIcon(arg_17_0.goRewards)
			arg_17_0.rewardItems[iter_17_0] = var_17_1
		end

		gohelper.setActive(var_17_1.go, var_17_0[iter_17_0] ~= nil)

		if var_17_0[iter_17_0] then
			var_17_1:setMOValue(var_17_0[iter_17_0][1], var_17_0[iter_17_0][2], var_17_0[iter_17_0][3], nil, true)
			var_17_1:setScale(0.7)
			var_17_1:setCountTxtSize(51)
		end
	end
end

function var_0_0.refreshAttr(arg_18_0)
	if arg_18_0.attrItems == nil then
		arg_18_0.attrItems = {}
	end

	local var_18_0 = arg_18_0.towerConfig.bossId
	local var_18_1 = arg_18_0.episodeConfig.bossLevel
	local var_18_2 = arg_18_0.episodeMo:getEpisodeConfig(arg_18_0.towerId, arg_18_0.episodeConfig.preLayerId)
	local var_18_3 = var_18_2 and var_18_2.bossLevel or 0
	local var_18_4 = TowerConfig.instance:getAssistDevelopConfig(var_18_0, var_18_1)
	local var_18_5 = var_18_4 and var_18_4.talentPoint

	arg_18_0.txtCurLev.text = string.format("Lv.%s", var_18_3)
	arg_18_0.txtNextLev.text = string.format("Lv.%s", var_18_1)

	local var_18_6 = GameUtil.splitString2(var_18_4 and var_18_4.attribute, true) or {}

	for iter_18_0 = 1, math.max(#arg_18_0.attrItems, #var_18_6) do
		local var_18_7 = arg_18_0.attrItems[iter_18_0]

		if not var_18_7 then
			var_18_7 = arg_18_0:createAttrItem(iter_18_0)
			arg_18_0.attrItems[iter_18_0] = var_18_7
		end

		arg_18_0:refreshAttrItem(var_18_7, var_18_6[iter_18_0])
	end

	local var_18_8 = var_18_5 and var_18_5 > 0 or false

	gohelper.setActive(arg_18_0.goTalentPoint, var_18_8)

	if var_18_8 then
		arg_18_0.txtTalentPoint.text = string.format("+%s", var_18_5)
	end

	gohelper.setActive(arg_18_0.goBossUnlock, var_18_1 == 1)

	local var_18_9
	local var_18_10 = TowerConfig.instance:getPassiveSKills(var_18_0)

	for iter_18_1, iter_18_2 in ipairs(var_18_10) do
		if TowerConfig.instance:getPassiveSkillActiveLev(var_18_0, iter_18_2[1]) == var_18_1 then
			var_18_9 = iter_18_1

			break
		end
	end

	gohelper.setActive(arg_18_0.goSkillUnlock, var_18_9 ~= nil)

	if var_18_9 then
		UISpriteSetMgr.instance:setCommonSprite(arg_18_0.imgSkillUnlock, string.format("icon_att_%s", var_18_9 + 221))
	end
end

function var_0_0.createAttrItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getUserDataTb_()

	var_19_0.index = arg_19_1
	var_19_0.go = gohelper.cloneInPlace(arg_19_0.goAttrItem, string.format("attrItem%s", arg_19_1))
	var_19_0.icon = gohelper.findChildImage(var_19_0.go, "icon")
	var_19_0.txtName = gohelper.findChildTextMesh(var_19_0.go, "name")
	var_19_0.txtValue = gohelper.findChildTextMesh(var_19_0.go, "value")

	return var_19_0
end

function var_0_0.refreshAttrItem(arg_20_0, arg_20_1, arg_20_2)
	gohelper.setActive(arg_20_1.go, arg_20_2 ~= nil)

	if arg_20_2 then
		local var_20_0 = arg_20_2[1]
		local var_20_1 = arg_20_2[2]
		local var_20_2 = HeroConfig.instance:getHeroAttributeCO(var_20_0)

		arg_20_1.txtName.text = var_20_2.name
		arg_20_1.txtValue.text = string.format("+%s%%", var_20_1 * 0.1)

		UISpriteSetMgr.instance:setCommonSprite(arg_20_1.icon, string.format("icon_att_%s", var_20_0))
	end
end

function var_0_0.onOpenFinish(arg_21_0)
	return
end

function var_0_0.onClose(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	UIBlockMgr.instance:endBlock("delayMove")
	TaskDispatcher.cancelTask(arg_23_0.delayMove, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onMove, arg_23_0)
	arg_23_0.simageShadow:UnLoadImage()
	arg_23_0.simageBoss:UnLoadImage()
end

return var_0_0

module("modules.logic.tower.view.bosstower.TowerBossEpisodeView", package.seeall)

local var_0_0 = class("TowerBossEpisodeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/episodeNode/nameBg/txtName")
	arg_1_0.btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Right/btnStart")
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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnStart)
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

function var_0_0._onMove(arg_6_0)
	arg_6_0:refreshCurLayerId()
	arg_6_0:refreshLayerInfo()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()

	if arg_8_0.needChangeLayer then
		UIBlockMgr.instance:startBlock("delayMove")
		TaskDispatcher.runDelay(arg_8_0.delayMove, arg_8_0, 1)
	end
end

function var_0_0.delayMove(arg_9_0)
	UIBlockMgr.instance:endBlock("delayMove")
	arg_9_0.animLevels:Play("move")
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_boss_swtich)
	TaskDispatcher.runDelay(arg_9_0._onMove, arg_9_0, 0.167)
end

function var_0_0.refreshParam(arg_10_0)
	arg_10_0.episodeConfig = arg_10_0.viewParam.episodeConfig
	arg_10_0.towerId = arg_10_0.episodeConfig.towerId
	arg_10_0.towerType = TowerEnum.TowerType.Boss
	arg_10_0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(arg_10_0.towerType)
	arg_10_0.towerConfig = TowerConfig.instance:getBossTowerConfig(arg_10_0.towerId)
	arg_10_0.bossConfig = TowerConfig.instance:getAssistBossConfig(arg_10_0.towerConfig.bossId)
	arg_10_0.towerInfo = TowerModel.instance:getTowerInfoById(arg_10_0.towerType, arg_10_0.towerId)

	arg_10_0:refreshCurLayerId()
end

function var_0_0.refreshCurLayerId(arg_11_0)
	local var_11_0 = arg_11_0.viewParam and arg_11_0.viewParam.passLayerId

	if var_11_0 then
		arg_11_0.curLayer = var_11_0
		arg_11_0.viewParam.passLayerId = nil
	else
		arg_11_0.curLayer = arg_11_0.episodeConfig.layerId
	end

	arg_11_0.needChangeLayer = arg_11_0.curLayer ~= arg_11_0.episodeConfig.layerId
end

function var_0_0.refreshView(arg_12_0)
	arg_12_0.txtName.text = arg_12_0.towerConfig.name

	arg_12_0.simageBoss:LoadImage(arg_12_0.bossConfig.bossPic)
	arg_12_0.simageShadow:LoadImage(arg_12_0.bossConfig.bossShadowPic)
	arg_12_0:refreshLayerInfo()
end

function var_0_0.refreshLayerInfo(arg_13_0)
	local var_13_0 = not arg_13_0.needChangeLayer and arg_13_0.towerInfo:isLayerPass(arg_13_0.curLayer, arg_13_0.episodeMo)

	gohelper.setActive(arg_13_0.goLevMax, var_13_0)
	gohelper.setActive(arg_13_0.goLevels, not var_13_0)
	gohelper.setActive(arg_13_0.goRight, not var_13_0)

	if not var_13_0 then
		arg_13_0:refreshIndex()
		arg_13_0:refreshRewards(arg_13_0.episodeConfig.firstReward)
		arg_13_0:refreshAttr()
	else
		arg_13_0.txtMaxLevel.text = tostring(arg_13_0.episodeMo:getEpisodeIndex(arg_13_0.towerId, arg_13_0.curLayer))
	end
end

function var_0_0.refreshIndex(arg_14_0)
	local var_14_0 = arg_14_0.episodeMo:getEpisodeConfig(arg_14_0.towerId, arg_14_0.curLayer)

	arg_14_0.txtCurIndex.text = tostring(arg_14_0.episodeMo:getEpisodeIndex(arg_14_0.towerId, arg_14_0.curLayer))

	local var_14_1 = arg_14_0.episodeMo:getNextEpisodeLayer(arg_14_0.towerId, arg_14_0.curLayer)

	if var_14_1 then
		if arg_14_0.episodeMo:getEpisodeConfig(arg_14_0.towerId, var_14_1).openRound > 0 then
			arg_14_0.txtNextIndex.text = ""
		else
			arg_14_0.txtNextIndex.text = tostring(arg_14_0.episodeMo:getEpisodeIndex(arg_14_0.towerId, var_14_1))
		end
	else
		arg_14_0.txtNextIndex.text = ""
	end

	local var_14_2 = var_14_0.preLayerId

	if var_14_2 and var_14_2 > 0 then
		arg_14_0.txtPreIndex.text = tostring(arg_14_0.episodeMo:getEpisodeIndex(arg_14_0.towerId, var_14_2))
	else
		arg_14_0.txtPreIndex.text = ""
	end
end

function var_0_0.refreshRewards(arg_15_0, arg_15_1)
	if arg_15_0.rewardItems == nil then
		arg_15_0.rewardItems = {}
	end

	local var_15_0 = GameUtil.splitString2(arg_15_1, true) or {}

	for iter_15_0 = 1, math.max(#arg_15_0.rewardItems, #var_15_0) do
		local var_15_1 = arg_15_0.rewardItems[iter_15_0]

		if not var_15_1 then
			var_15_1 = IconMgr.instance:getCommonPropItemIcon(arg_15_0.goRewards)
			arg_15_0.rewardItems[iter_15_0] = var_15_1
		end

		gohelper.setActive(var_15_1.go, var_15_0[iter_15_0] ~= nil)

		if var_15_0[iter_15_0] then
			var_15_1:setMOValue(var_15_0[iter_15_0][1], var_15_0[iter_15_0][2], var_15_0[iter_15_0][3], nil, true)
			var_15_1:setScale(0.7)
			var_15_1:setCountTxtSize(51)
		end
	end
end

function var_0_0.refreshAttr(arg_16_0)
	if arg_16_0.attrItems == nil then
		arg_16_0.attrItems = {}
	end

	local var_16_0 = arg_16_0.towerConfig.bossId
	local var_16_1 = arg_16_0.episodeConfig.bossLevel
	local var_16_2 = arg_16_0.episodeMo:getEpisodeConfig(arg_16_0.towerId, arg_16_0.episodeConfig.preLayerId)
	local var_16_3 = var_16_2 and var_16_2.bossLevel or 0
	local var_16_4 = TowerConfig.instance:getAssistDevelopConfig(var_16_0, var_16_1)
	local var_16_5 = var_16_4 and var_16_4.talentPoint

	arg_16_0.txtCurLev.text = string.format("Lv.%s", var_16_3)
	arg_16_0.txtNextLev.text = string.format("Lv.%s", var_16_1)

	local var_16_6 = GameUtil.splitString2(var_16_4 and var_16_4.attribute, true) or {}

	for iter_16_0 = 1, math.max(#arg_16_0.attrItems, #var_16_6) do
		local var_16_7 = arg_16_0.attrItems[iter_16_0]

		if not var_16_7 then
			var_16_7 = arg_16_0:createAttrItem(iter_16_0)
			arg_16_0.attrItems[iter_16_0] = var_16_7
		end

		arg_16_0:refreshAttrItem(var_16_7, var_16_6[iter_16_0])
	end

	local var_16_8 = var_16_5 and var_16_5 > 0 or false

	gohelper.setActive(arg_16_0.goTalentPoint, var_16_8)

	if var_16_8 then
		arg_16_0.txtTalentPoint.text = string.format("+%s", var_16_5)
	end

	gohelper.setActive(arg_16_0.goBossUnlock, var_16_1 == 1)

	local var_16_9
	local var_16_10 = TowerConfig.instance:getPassiveSKills(var_16_0)

	for iter_16_1, iter_16_2 in ipairs(var_16_10) do
		if TowerConfig.instance:getPassiveSkillActiveLev(var_16_0, iter_16_2[1]) == var_16_1 then
			var_16_9 = iter_16_1

			break
		end
	end

	gohelper.setActive(arg_16_0.goSkillUnlock, var_16_9 ~= nil)

	if var_16_9 then
		UISpriteSetMgr.instance:setCommonSprite(arg_16_0.imgSkillUnlock, string.format("icon_att_%s", var_16_9 + 221))
	end
end

function var_0_0.createAttrItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getUserDataTb_()

	var_17_0.index = arg_17_1
	var_17_0.go = gohelper.cloneInPlace(arg_17_0.goAttrItem, string.format("attrItem%s", arg_17_1))
	var_17_0.icon = gohelper.findChildImage(var_17_0.go, "icon")
	var_17_0.txtName = gohelper.findChildTextMesh(var_17_0.go, "name")
	var_17_0.txtValue = gohelper.findChildTextMesh(var_17_0.go, "value")

	return var_17_0
end

function var_0_0.refreshAttrItem(arg_18_0, arg_18_1, arg_18_2)
	gohelper.setActive(arg_18_1.go, arg_18_2 ~= nil)

	if arg_18_2 then
		local var_18_0 = arg_18_2[1]
		local var_18_1 = arg_18_2[2]
		local var_18_2 = HeroConfig.instance:getHeroAttributeCO(var_18_0)

		arg_18_1.txtName.text = var_18_2.name
		arg_18_1.txtValue.text = string.format("+%s%%", var_18_1 * 0.1)

		UISpriteSetMgr.instance:setCommonSprite(arg_18_1.icon, string.format("icon_att_%s", var_18_0))
	end
end

function var_0_0.onOpenFinish(arg_19_0)
	return
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	UIBlockMgr.instance:endBlock("delayMove")
	TaskDispatcher.cancelTask(arg_21_0.delayMove, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._onMove, arg_21_0)
	arg_21_0.simageShadow:UnLoadImage()
	arg_21_0.simageBoss:UnLoadImage()
end

return var_0_0

module("modules.logic.tower.view.fight.TowerBossResultView", package.seeall)

local var_0_0 = class("TowerBossResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0.goFinish = gohelper.findChild(arg_1_0.viewGO, "goFinish")
	arg_1_0.goBossLevChange = gohelper.findChild(arg_1_0.viewGO, "goBossLevChange")
	arg_1_0.txtLev1 = gohelper.findChildTextMesh(arg_1_0.goBossLevChange, "goLev/Lv1/txtLev1")
	arg_1_0.txtLev2 = gohelper.findChildTextMesh(arg_1_0.goBossLevChange, "goLev/Lv2/txtLev2")
	arg_1_0.goResult = gohelper.findChild(arg_1_0.viewGO, "goResult")
	arg_1_0.goInfo = gohelper.findChild(arg_1_0.goResult, "goInfo")
	arg_1_0.txtLev = gohelper.findChildTextMesh(arg_1_0.goInfo, "Lv/txtLev")
	arg_1_0.goAttrItem = gohelper.findChild(arg_1_0.goInfo, "attrInfo/attrItem")

	gohelper.setActive(arg_1_0.goAttrItem, false)

	arg_1_0.goTalentPoint = gohelper.findChild(arg_1_0.goInfo, "attrInfo/talentPoint")
	arg_1_0.txtTalentPoint = gohelper.findChildTextMesh(arg_1_0.goTalentPoint, "value")
	arg_1_0.goRewards = gohelper.findChild(arg_1_0.goResult, "goReward")
	arg_1_0.goReward = gohelper.findChild(arg_1_0.goResult, "goReward/scroll_reward/Viewport/#go_rewards")
	arg_1_0.goSpResult = gohelper.findChild(arg_1_0.viewGO, "goSpResult")
	arg_1_0.goHeroItem = gohelper.findChild(arg_1_0.viewGO, "goSpResult/goGroup/Group/heroitem")
	arg_1_0.simageSpBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "goSpResult/goBoss/imgBoss")
	arg_1_0.txtSpTower = gohelper.findChildTextMesh(arg_1_0.viewGO, "goSpResult/goBoss/txtTower")
	arg_1_0.txtSpIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "goSpResult/goBoss/episodeItem/goOpen/txtCurEpisode")
	arg_1_0.goEpisodeItem = gohelper.findChild(arg_1_0.viewGO, "goSpResult/goBoss/episodeItem")
	arg_1_0.goSpRewards = gohelper.findChild(arg_1_0.viewGO, "goSpResult/goReward")
	arg_1_0.goSpReward = gohelper.findChild(arg_1_0.viewGO, "goSpResult/goReward/scroll_reward/Viewport/#go_rewards")
	arg_1_0.btnRank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "goResult/#btn_Rank")
	arg_1_0.btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "goSpResult/#btn_Detail")
	arg_1_0.goBoss = gohelper.findChild(arg_1_0.viewGO, "goBoss")
	arg_1_0.simageBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "goBoss/imgBoss")
	arg_1_0.txtTower = gohelper.findChildTextMesh(arg_1_0.goBoss, "txtTower")

	gohelper.setActive(arg_1_0.goFinish, false)
	gohelper.setActive(arg_1_0.goBossLevChange, false)
	gohelper.setActive(arg_1_0.goResult, false)
	gohelper.setActive(arg_1_0.goInfo, false)
	gohelper.setActive(arg_1_0.goSpResult, false)
	gohelper.setActive(arg_1_0.goBoss, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnDetail, arg_2_0._onBtnRankClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRank, arg_2_0._onBtnRankClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._click, arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnDetail)
	arg_3_0:removeClickCb(arg_3_0.btnRank)
	arg_3_0:removeClickCb(arg_3_0._click)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onClickClose(arg_5_0)
	if not arg_5_0.canClick then
		if arg_5_0.popupFlow then
			local var_5_0 = arg_5_0.popupFlow:getWorkList()[arg_5_0.popupFlow._curIndex]

			if var_5_0 then
				var_5_0:onDone(true)
			end
		end

		return
	end

	arg_5_0:closeThis()
end

function var_0_0._onBtnRankClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshParam(arg_8_0)
	arg_8_0.episodeId = DungeonModel.instance.curSendEpisodeId
	arg_8_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_8_0.episodeId)
	arg_8_0.fightFinishParam = TowerModel.instance:getFightFinishParam()
	arg_8_0.towerType = arg_8_0.fightFinishParam.towerType
	arg_8_0.towerId = arg_8_0.fightFinishParam.towerId
	arg_8_0.layerId = arg_8_0.fightFinishParam.layerId
	arg_8_0.towerConfig = TowerConfig.instance:getBossTowerConfig(arg_8_0.towerId)
	arg_8_0.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(arg_8_0.towerType)
	arg_8_0.layerConfig = arg_8_0.episodeMo:getEpisodeConfig(arg_8_0.towerId, arg_8_0.layerId)
	arg_8_0.bossConfig = TowerConfig.instance:getAssistBossConfig(arg_8_0.towerConfig.bossId)
	arg_8_0.isTeach = arg_8_0.towerType == TowerEnum.TowerType.Boss and arg_8_0.layerId == 0
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0.txtTower.text = arg_9_0.towerConfig.name

	arg_9_0.simageBoss:LoadImage(arg_9_0.bossConfig.bossPic)

	local var_9_0 = arg_9_0.layerConfig and arg_9_0.layerConfig.openRound > 0

	if var_9_0 or arg_9_0.isTeach then
		arg_9_0:refreshSp()
	else
		arg_9_0:refreshAttr()
	end

	arg_9_0:refreshLev()
	arg_9_0:refreshRewards((var_9_0 or arg_9_0.isTeach) and arg_9_0.goSpReward or arg_9_0.goReward, (var_9_0 or arg_9_0.isTeach) and arg_9_0.goSpRewards or arg_9_0.goRewards)
	arg_9_0:startFlow(var_9_0)
end

function var_0_0.startFlow(arg_10_0, arg_10_1)
	if arg_10_0._popupFlow then
		arg_10_0._popupFlow:destroy()

		arg_10_0._popupFlow = nil
	end

	arg_10_0.popupFlow = FlowSequence.New()

	arg_10_0.popupFlow:addWork(TowerBossResultShowFinishWork.New(arg_10_0.goFinish, AudioEnum.Tower.play_ui_fight_explore))
	arg_10_0.popupFlow:addWork(TowerBossResultShowLevChangeWork.New(arg_10_0.goBossLevChange, arg_10_0.goBoss, arg_10_0.isBossLevChange))
	arg_10_0.popupFlow:addWork(TowerBossResultShowResultWork.New((arg_10_1 or arg_10_0.isTeach) and arg_10_0.goSpResult or arg_10_0.goResult, AudioEnum.Tower.play_ui_fight_explore))
	arg_10_0.popupFlow:registerDoneListener(arg_10_0._onAllFinish, arg_10_0)
	arg_10_0.popupFlow:start()
end

function var_0_0.refreshRewards(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.rewardItems == nil then
		arg_11_0.rewardItems = {}
	end

	local var_11_0 = FightResultModel.instance:getMaterialDataList() or {}

	for iter_11_0 = 1, math.max(#arg_11_0.rewardItems, #var_11_0) do
		local var_11_1 = arg_11_0.rewardItems[iter_11_0]
		local var_11_2 = var_11_0[iter_11_0]

		if not var_11_1 then
			var_11_1 = IconMgr.instance:getCommonPropItemIcon(arg_11_1)
			arg_11_0.rewardItems[iter_11_0] = var_11_1
		end

		gohelper.setActive(var_11_1.go, var_11_2 ~= nil)

		if var_11_2 then
			var_11_1:setMOValue(var_11_2.materilType, var_11_2.materilId, var_11_2.quantity)
			var_11_1:setScale(0.7)
			var_11_1:setCountTxtSize(51)
		end
	end

	gohelper.setActive(arg_11_2, #var_11_0 ~= 0)
end

function var_0_0.refreshLev(arg_12_0)
	if arg_12_0.isTeach then
		arg_12_0.isBossLevChange = false

		return
	end

	local var_12_0 = arg_12_0.towerConfig.bossId
	local var_12_1 = arg_12_0.layerConfig.bossLevel
	local var_12_2 = arg_12_0.episodeMo:getEpisodeConfig(arg_12_0.towerId, arg_12_0.layerConfig.preLayerId)
	local var_12_3 = var_12_2 and var_12_2.bossLevel or 0

	arg_12_0.isBossLevChange = var_12_1 ~= var_12_3

	if not arg_12_0.isBossLevChange then
		return
	end

	arg_12_0.txtLev1.text = tostring(var_12_3)
	arg_12_0.txtLev2.text = tostring(var_12_1)
end

function var_0_0.refreshAttr(arg_13_0)
	gohelper.setActive(arg_13_0.goInfo, true)

	if arg_13_0.attrItems == nil then
		arg_13_0.attrItems = {}
	end

	local var_13_0 = arg_13_0.layerConfig.bossLevel
	local var_13_1 = TowerConfig.instance:getAssistDevelopConfig(arg_13_0.towerConfig.bossId, var_13_0)
	local var_13_2 = var_13_1 and var_13_1.talentPoint

	arg_13_0.txtLev.text = tostring(var_13_0)

	local var_13_3 = GameUtil.splitString2(var_13_1 and var_13_1.attribute, true) or {}

	for iter_13_0 = 1, math.max(#arg_13_0.attrItems, #var_13_3) do
		local var_13_4 = arg_13_0.attrItems[iter_13_0]

		if not var_13_4 then
			var_13_4 = arg_13_0:createAttrItem(iter_13_0)
			arg_13_0.attrItems[iter_13_0] = var_13_4
		end

		arg_13_0:refreshAttrItem(var_13_4, var_13_3[iter_13_0])
	end

	local var_13_5 = var_13_2 and var_13_2 > 0 or false

	gohelper.setActive(arg_13_0.goTalentPoint, var_13_5)

	if var_13_5 then
		gohelper.setAsLastSibling(arg_13_0.goTalentPoint)

		arg_13_0.txtTalentPoint.text = string.format("+%s", var_13_2)
	end
end

function var_0_0.createAttrItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.index = arg_14_1
	var_14_0.go = gohelper.cloneInPlace(arg_14_0.goAttrItem, string.format("attrItem%s", arg_14_1))
	var_14_0.icon = gohelper.findChildImage(var_14_0.go, "icon")
	var_14_0.txtName = gohelper.findChildTextMesh(var_14_0.go, "name")
	var_14_0.txtValue = gohelper.findChildTextMesh(var_14_0.go, "value")

	return var_14_0
end

function var_0_0.refreshAttrItem(arg_15_0, arg_15_1, arg_15_2)
	gohelper.setActive(arg_15_1.go, arg_15_2 ~= nil)

	if arg_15_2 then
		local var_15_0 = arg_15_2[1]
		local var_15_1 = arg_15_2[2]
		local var_15_2 = HeroConfig.instance:getHeroAttributeCO(var_15_0)

		arg_15_1.txtName.text = var_15_2.name
		arg_15_1.txtValue.text = string.format("+%s%%", var_15_1 * 0.1)

		UISpriteSetMgr.instance:setCommonSprite(arg_15_1.icon, string.format("icon_att_%s", var_15_0))
	end
end

function var_0_0.refreshSp(arg_16_0)
	arg_16_0.simageSpBoss:LoadImage(arg_16_0.bossConfig.bossPic)

	arg_16_0.txtSpTower.text = arg_16_0.towerConfig.name

	if not arg_16_0.isTeach then
		arg_16_0.txtSpIndex.text = arg_16_0.episodeMo:getEpisodeIndex(arg_16_0.towerId, arg_16_0.layerId)
	end

	gohelper.setActive(arg_16_0.goEpisodeItem, not arg_16_0.isTeach)
	arg_16_0:refreshHeroGroup()
end

function var_0_0.refreshHeroGroup(arg_17_0)
	if arg_17_0.heroItemList == nil then
		arg_17_0.heroItemList = arg_17_0:getUserDataTb_()
	end

	local var_17_0 = FightModel.instance:getFightParam():getHeroEquipAndTrialMoList(true)

	for iter_17_0 = 1, 4 do
		local var_17_1 = arg_17_0.heroItemList[iter_17_0]
		local var_17_2 = var_17_0[iter_17_0]

		if var_17_2 then
			if var_17_1 == nil then
				local var_17_3 = gohelper.findChild(arg_17_0.viewGO, string.format("goSpResult/goGroup/Group/heroitem%s", iter_17_0))

				var_17_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_3, TowerBossResultHeroItem)
				arg_17_0.heroItemList[iter_17_0] = var_17_1
			end

			var_17_1:setData(var_17_2.heroMo, var_17_2.equipMo)
		end
	end
end

function var_0_0._onAllFinish(arg_18_0)
	arg_18_0.canClick = true
end

function var_0_0.onClose(arg_19_0)
	FightController.onResultViewClose()
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0.simageSpBoss:UnLoadImage()
	arg_20_0.simageBoss:UnLoadImage()

	if arg_20_0._popupFlow then
		arg_20_0._popupFlow:destroy()

		arg_20_0._popupFlow = nil
	end
end

return var_0_0

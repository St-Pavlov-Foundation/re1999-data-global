module("modules.logic.fight.view.rouge.FightViewRougePianzhenGongZhenJinBi", package.seeall)

local var_0_0 = class("FightViewRougePianzhenGongZhenJinBi", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._coinRoot = gohelper.findChild(arg_1_0.viewGO, "coin")
	arg_1_0._coinText = gohelper.findChildText(arg_1_0.viewGO, "coin/#txt_num")
	arg_1_0._addCoinEffect = gohelper.findChild(arg_1_0.viewGO, "coin/obtain")
	arg_1_0._minCoinEffect = gohelper.findChild(arg_1_0.viewGO, "coin/without")
	arg_1_0._resonancelObj = gohelper.findChild(arg_1_0.viewGO, "layout/buffitem_short")
	arg_1_0._resonancelNameText = gohelper.findChildText(arg_1_0.viewGO, "layout/buffitem_short/bg/#txt_name")
	arg_1_0._resonancelLevelText = gohelper.findChildText(arg_1_0.viewGO, "layout/buffitem_short/bg/#txt_level")
	arg_1_0._clickResonancel = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "layout/buffitem_short/bg")
	arg_1_0._polarizationRoot = gohelper.findChild(arg_1_0.viewGO, "layout/polarizationRoot")
	arg_1_0._polarizationItem = gohelper.findChild(arg_1_0.viewGO, "layout/polarizationRoot/buffitem_long")
	arg_1_0._desTips = gohelper.findChild(arg_1_0.viewGO, "#go_desc_tips")
	arg_1_0._clickTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_desc_tips/#btn_click")
	arg_1_0._tipsContentObj = gohelper.findChild(arg_1_0.viewGO, "#go_desc_tips/Content")
	arg_1_0._tipsContentTransform = arg_1_0._tipsContentObj and arg_1_0._tipsContentObj.transform
	arg_1_0._tipsNameText = gohelper.findChildText(arg_1_0.viewGO, "#go_desc_tips/Content/#txt_title")
	arg_1_0._tipsDescText = gohelper.findChildText(arg_1_0.viewGO, "#go_desc_tips/Content/#txt_details")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._clickResonancel, arg_2_0._onBtnResonancel, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._clickTips, arg_2_0._onBtnTips, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ResonanceLevel, arg_2_0._onResonanceLevel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PolarizationLevel, arg_2_0._onPolarizationLevel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RougeCoinChange, arg_2_0._onRougeCoinChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_2_0._onRespBeginFight, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0._onBtnTips(arg_6_0)
	gohelper.setActive(arg_6_0._desTips, false)
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_7_0)
	arg_7_0:_hideObj()
end

function var_0_0._onRoundSequenceFinish(arg_8_0)
	arg_8_0:_hideObj()
end

function var_0_0._onRespBeginFight(arg_9_0)
	arg_9_0:_refreshCoin()
end

function var_0_0._hideObj(arg_10_0)
	gohelper.setActive(arg_10_0._resonancelObj, false)
	gohelper.setActive(arg_10_0._polarizationRoot, false)
	gohelper.setActive(arg_10_0._desTips, false)
	arg_10_0.viewContainer.rightElementLayoutView:hideElement(FightRightElementEnum.Elements.Rouge)
end

function var_0_0._onResonanceLevel(arg_11_0)
	arg_11_0:_refreshData()
end

function var_0_0._onPolarizationLevel(arg_12_0)
	arg_12_0:_refreshData()
end

function var_0_0._cancelCoinTimer(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._hideCoinEffect, arg_13_0)
end

function var_0_0._hideCoinEffect(arg_14_0)
	gohelper.setActive(arg_14_0._addCoinEffect, false)
	gohelper.setActive(arg_14_0._minCoinEffect, false)
end

function var_0_0._onRougeCoinChange(arg_15_0, arg_15_1)
	arg_15_0:_refreshData()
	arg_15_0:_cancelCoinTimer()
	TaskDispatcher.runDelay(arg_15_0._hideCoinEffect, arg_15_0, 0.6)

	if arg_15_1 > 0 then
		gohelper.setActive(arg_15_0._addCoinEffect, true)
		gohelper.setActive(arg_15_0._minCoinEffect, false)
	else
		gohelper.setActive(arg_15_0._addCoinEffect, false)
		gohelper.setActive(arg_15_0._minCoinEffect, true)
	end
end

function var_0_0.onOpen(arg_16_0)
	gohelper.setActive(arg_16_0._desTips, false)
	arg_16_0:_refreshData()
end

function var_0_0._refreshData(arg_17_0)
	gohelper.setActive(arg_17_0.viewGO, true)
	arg_17_0:_refreshCoin()
	arg_17_0:_refreshPianZhenGongZhen()
end

function var_0_0._onBtnResonancel(arg_18_0)
	local var_18_0 = arg_18_0:getUserDataTb_()

	var_18_0.config = arg_18_0._resonancelConfig
	var_18_0.obj = arg_18_0._resonancelObj

	arg_18_0:_showTips(var_18_0)
end

function var_0_0._refreshPianZhenGongZhen(arg_19_0)
	arg_19_0._resonancelLevel = FightRoundSequence.roundTempData.ResonanceLevel

	local var_19_0 = arg_19_0._resonancelLevel and arg_19_0._resonancelLevel ~= 0

	gohelper.setActive(arg_19_0._resonancelObj, var_19_0)

	if var_19_0 then
		arg_19_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.Rouge)

		local var_19_1 = lua_resonance.configDict[arg_19_0._resonancelLevel]

		if var_19_1 then
			arg_19_0._resonancelConfig = var_19_1
			arg_19_0._resonancelNameText.text = var_19_1 and var_19_1.name
			arg_19_0._resonancelLevelText.text = "Lv." .. arg_19_0._resonancelLevel

			for iter_19_0 = 1, 3 do
				local var_19_2 = gohelper.findChild(arg_19_0.viewGO, "buffitem_short/effect_lv/effect_lv" .. iter_19_0)

				gohelper.setActive(var_19_2, iter_19_0 == arg_19_0._resonancelLevel)
			end

			if arg_19_0._resonancelLevel > 3 then
				gohelper.setActive(gohelper.findChild(arg_19_0.viewGO, "buffitem_short/effect_lv/effect_lv3"), true)
			end
		else
			gohelper.setActive(arg_19_0._resonancelObj, false)
		end
	end

	arg_19_0._polarizationDic = FightRoundSequence.roundTempData.PolarizationLevel

	if arg_19_0._polarizationDic then
		for iter_19_1, iter_19_2 in pairs(arg_19_0._polarizationDic) do
			if iter_19_2.effectNum == 0 then
				arg_19_0._polarizationDic[iter_19_1] = nil
			end
		end
	end

	local var_19_3 = arg_19_0._polarizationDic and tabletool.len(arg_19_0._polarizationDic) > 0

	gohelper.setActive(arg_19_0._polarizationRoot, var_19_3)

	if var_19_3 then
		arg_19_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.Rouge)

		local var_19_4 = {}

		for iter_19_3, iter_19_4 in pairs(arg_19_0._polarizationDic) do
			table.insert(var_19_4, iter_19_4)
		end

		table.sort(var_19_4, var_0_0.sortPolarization)
		arg_19_0:com_createObjList(arg_19_0._onPolarizationItemShow, var_19_4, arg_19_0._polarizationRoot, arg_19_0._polarizationItem)
	end
end

function var_0_0.sortPolarization(arg_20_0, arg_20_1)
	return arg_20_0.configEffect < arg_20_1.configEffect
end

function var_0_0._onPolarizationItemShow(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = lua_polarization.configDict[arg_21_2.effectNum] and lua_polarization.configDict[arg_21_2.effectNum][arg_21_2.configEffect]

	if not var_21_0 then
		gohelper.setActive(arg_21_1, false)

		return
	end

	local var_21_1 = gohelper.findChildText(arg_21_1, "bg/#txt_name")
	local var_21_2 = gohelper.findChildText(arg_21_1, "bg/#txt_level")

	var_21_1.text = var_21_0 and var_21_0.name

	local var_21_3 = arg_21_2.effectNum

	var_21_2.text = "Lv." .. var_21_3

	local var_21_4 = gohelper.getClickWithDefaultAudio(gohelper.findChild(arg_21_1, "bg"))

	arg_21_0:removeClickCb(var_21_4)

	local var_21_5 = arg_21_0:getUserDataTb_()

	var_21_5.config = var_21_0
	var_21_5.obj = arg_21_1

	arg_21_0:addClickCb(var_21_4, arg_21_0._onBtnPolarization, arg_21_0, var_21_5)

	for iter_21_0 = 1, 3 do
		local var_21_6 = gohelper.findChild(arg_21_1, "effect_lv/effect_lv" .. iter_21_0)

		gohelper.setActive(var_21_6, iter_21_0 == var_21_3)
	end

	if var_21_3 > 3 then
		gohelper.setActive(gohelper.findChild(arg_21_1, "effect_lv/effect_lv3"), true)
	end
end

function var_0_0._onBtnPolarization(arg_22_0, arg_22_1)
	arg_22_0:_showTips(arg_22_1)
end

function var_0_0._showTips(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 and arg_23_1.config

	if var_23_0 then
		gohelper.setActive(arg_23_0._desTips, true)

		arg_23_0._tipsNameText.text = var_23_0.name
		arg_23_0._tipsDescText.text = HeroSkillModel.instance:skillDesToSpot(var_23_0.desc)

		if arg_23_0._tipsContentTransform then
			local var_23_1, var_23_2 = recthelper.rectToRelativeAnchorPos2(arg_23_1.obj.transform.position, arg_23_0.viewGO.transform)

			recthelper.setAnchorY(arg_23_0._tipsContentTransform, var_23_2)
		end
	end
end

function var_0_0._refreshCoin(arg_24_0)
	local var_24_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local var_24_1 = var_24_0 and var_24_0.type == DungeonEnum.EpisodeType.Rouge

	if var_24_1 then
		arg_24_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.Rouge)
	end

	gohelper.setActive(arg_24_0._coinRoot, var_24_1)

	arg_24_0._coinText.text = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)
end

function var_0_0.onClose(arg_25_0)
	arg_25_0:_cancelCoinTimer()
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0

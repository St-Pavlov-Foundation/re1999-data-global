module("modules.logic.fight.view.FightViewRougePianzhenGongZhenJinBi", package.seeall)

slot0 = class("FightViewRougePianzhenGongZhenJinBi", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._coinRoot = gohelper.findChild(slot0.viewGO, "coin")
	slot0._coinText = gohelper.findChildText(slot0.viewGO, "coin/#txt_num")
	slot0._addCoinEffect = gohelper.findChild(slot0.viewGO, "coin/obtain")
	slot0._minCoinEffect = gohelper.findChild(slot0.viewGO, "coin/without")
	slot0._resonancelObj = gohelper.findChild(slot0.viewGO, "layout/buffitem_short")
	slot0._resonancelNameText = gohelper.findChildText(slot0.viewGO, "layout/buffitem_short/bg/#txt_name")
	slot0._resonancelLevelText = gohelper.findChildText(slot0.viewGO, "layout/buffitem_short/bg/#txt_level")
	slot0._clickResonancel = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "layout/buffitem_short/bg")
	slot0._polarizationRoot = gohelper.findChild(slot0.viewGO, "layout/polarizationRoot")
	slot0._polarizationItem = gohelper.findChild(slot0.viewGO, "layout/polarizationRoot/buffitem_long")
	slot0._desTips = gohelper.findChild(slot0.viewGO, "#go_desc_tips")
	slot0._clickTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_desc_tips/#btn_click")
	slot0._tipsContentObj = gohelper.findChild(slot0.viewGO, "#go_desc_tips/Content")
	slot0._tipsContentTransform = slot0._tipsContentObj and slot0._tipsContentObj.transform
	slot0._tipsNameText = gohelper.findChildText(slot0.viewGO, "#go_desc_tips/Content/#txt_title")
	slot0._tipsDescText = gohelper.findChildText(slot0.viewGO, "#go_desc_tips/Content/#txt_details")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._clickResonancel, slot0._onBtnResonancel, slot0)
	slot0:addClickCb(slot0._clickTips, slot0._onBtnTips, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ResonanceLevel, slot0._onResonanceLevel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PolarizationLevel, slot0._onPolarizationLevel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RougeCoinChange, slot0._onRougeCoinChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginFight, slot0._onRespBeginFight, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0._onBtnTips(slot0)
	gohelper.setActive(slot0._desTips, false)
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	slot0:_hideObj()
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:_hideObj()
end

function slot0._onRespBeginFight(slot0)
	slot0:_refreshCoin()
end

function slot0._hideObj(slot0)
	gohelper.setActive(slot0._resonancelObj, false)
	gohelper.setActive(slot0._polarizationRoot, false)
	gohelper.setActive(slot0._desTips, false)
end

function slot0._onResonanceLevel(slot0)
	slot0:_refreshData()
end

function slot0._onPolarizationLevel(slot0)
	slot0:_refreshData()
end

function slot0._cancelCoinTimer(slot0)
	TaskDispatcher.cancelTask(slot0._hideCoinEffect, slot0)
end

function slot0._hideCoinEffect(slot0)
	gohelper.setActive(slot0._addCoinEffect, false)
	gohelper.setActive(slot0._minCoinEffect, false)
end

function slot0._onRougeCoinChange(slot0, slot1)
	slot0:_refreshData()
	slot0:_cancelCoinTimer()
	TaskDispatcher.runDelay(slot0._hideCoinEffect, slot0, 0.6)

	if slot1 > 0 then
		gohelper.setActive(slot0._addCoinEffect, true)
		gohelper.setActive(slot0._minCoinEffect, false)
	else
		gohelper.setActive(slot0._addCoinEffect, false)
		gohelper.setActive(slot0._minCoinEffect, true)
	end
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._desTips, false)
	slot0:_refreshData()
end

function slot0._refreshData(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0:_refreshCoin()
	slot0:_refreshPianZhenGongZhen()
end

function slot0._onBtnResonancel(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.config = slot0._resonancelConfig
	slot1.obj = slot0._resonancelObj

	slot0:_showTips(slot1)
end

function slot0._refreshPianZhenGongZhen(slot0)
	slot0._resonancelLevel = FightRoundSequence.roundTempData.ResonanceLevel
	slot1 = slot0._resonancelLevel and slot0._resonancelLevel ~= 0

	gohelper.setActive(slot0._resonancelObj, slot1)

	if slot1 then
		if lua_resonance.configDict[slot0._resonancelLevel] then
			slot0._resonancelConfig = slot2
			slot0._resonancelNameText.text = slot2 and slot2.name
			slot0._resonancelLevelText.text = "Lv." .. slot0._resonancelLevel

			for slot6 = 1, 3 do
				gohelper.setActive(gohelper.findChild(slot0.viewGO, "buffitem_short/effect_lv/effect_lv" .. slot6), slot6 == slot0._resonancelLevel)
			end

			if slot0._resonancelLevel > 3 then
				gohelper.setActive(gohelper.findChild(slot0.viewGO, "buffitem_short/effect_lv/effect_lv3"), true)
			end
		else
			gohelper.setActive(slot0._resonancelObj, false)
		end
	end

	slot0._polarizationDic = FightRoundSequence.roundTempData.PolarizationLevel

	if slot0._polarizationDic then
		for slot5, slot6 in pairs(slot0._polarizationDic) do
			if slot6.effectNum == 0 then
				slot0._polarizationDic[slot5] = nil
			end
		end
	end

	slot2 = slot0._polarizationDic and tabletool.len(slot0._polarizationDic) > 0

	gohelper.setActive(slot0._polarizationRoot, slot2)

	if slot2 then
		slot3 = {}

		for slot7, slot8 in pairs(slot0._polarizationDic) do
			table.insert(slot3, slot8)
		end

		table.sort(slot3, uv0.sortPolarization)
		slot0:com_createObjList(slot0._onPolarizationItemShow, slot3, slot0._polarizationRoot, slot0._polarizationItem)
	end
end

function slot0.sortPolarization(slot0, slot1)
	return slot0.configEffect < slot1.configEffect
end

function slot0._onPolarizationItemShow(slot0, slot1, slot2, slot3)
	if not (lua_polarization.configDict[slot2.effectNum] and lua_polarization.configDict[slot2.effectNum][slot2.configEffect]) then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.findChildText(slot1, "bg/#txt_name").text = slot4 and slot4.name
	gohelper.findChildText(slot1, "bg/#txt_level").text = "Lv." .. slot2.effectNum
	slot8 = gohelper.getClickWithDefaultAudio(gohelper.findChild(slot1, "bg"))

	slot0:removeClickCb(slot8)

	slot9 = slot0:getUserDataTb_()
	slot9.config = slot4
	slot9.obj = slot1

	slot0:addClickCb(slot8, slot0._onBtnPolarization, slot0, slot9)

	for slot13 = 1, 3 do
		gohelper.setActive(gohelper.findChild(slot1, "effect_lv/effect_lv" .. slot13), slot13 == slot7)
	end

	if slot7 > 3 then
		gohelper.setActive(gohelper.findChild(slot1, "effect_lv/effect_lv3"), true)
	end
end

function slot0._onBtnPolarization(slot0, slot1)
	slot0:_showTips(slot1)
end

function slot0._showTips(slot0, slot1)
	if slot1 and slot1.config then
		gohelper.setActive(slot0._desTips, true)

		slot0._tipsNameText.text = slot2.name
		slot0._tipsDescText.text = HeroSkillModel.instance:skillDesToSpot(slot2.desc)

		if slot0._tipsContentTransform then
			slot3, slot4 = recthelper.rectToRelativeAnchorPos2(slot1.obj.transform.position, slot0.viewGO.transform)

			recthelper.setAnchorY(slot0._tipsContentTransform, slot4)
		end
	end
end

function slot0._refreshCoin(slot0)
	gohelper.setActive(slot0._coinRoot, DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type == DungeonEnum.EpisodeType.Rouge)

	slot0._coinText.text = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)
end

function slot0.onClose(slot0)
	slot0:_cancelCoinTimer()
end

function slot0.onDestroyView(slot0)
end

return slot0

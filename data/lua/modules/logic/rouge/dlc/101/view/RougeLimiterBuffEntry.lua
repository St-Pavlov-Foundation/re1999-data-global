module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffEntry", package.seeall)

slot0 = class("RougeLimiterBuffEntry", LuaCompBase)
slot0.DefaultDifficultyFontSize = 38

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._txtdifficulty = gohelper.findChildText(slot0.viewGO, "#txt_difficulty")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_num")
	slot0._gonamebg = gohelper.findChild(slot0.viewGO, "namebg")
	slot0._numAnim = gohelper.onceAddComponent(slot0._txtnum.gameObject, gohelper.Type_Animator)
	slot0._canvasgroup = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_CanvasGroup)
	slot0._selectIndex = 0
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, slot0._onUpdateBuffState, slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, slot0._onUpdateLimiterGroup, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfo, slot0._onUpdateRougeInfo, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.refreshUI(slot0, slot1)
	slot0:refreshRisk()
	slot0:refreshAllBuffEntry()
	slot0:refreshRiskIcon(slot1)
end

function slot0.refreshRisk(slot0)
	slot2 = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(slot0:getTotalRiskValue())
	slot0._switchRiskStage = not slot0._riskCo or not slot2 or slot0._riskCo.id ~= slot2.id
	slot0._riskCo = slot2
	slot0._txtdifficulty.text = slot0._riskCo and slot0._riskCo.title
	slot0._txtnum.text = slot1

	slot0._numAnim:Play(slot0._switchRiskStage and "refresh" or "idle", 0, 0)

	slot0._isCurMaxLevel = RougeDLCConfig101.instance:getMaxLevlRiskCo() and slot0._riskCo and slot3.id == slot0._riskCo.id
end

function slot0.getTotalRiskValue(slot0)
	return RougeDLCModel101.instance:getTotalRiskValue()
end

function slot0.refreshRiskIcon(slot0, slot1)
	slot2 = false

	for slot6 = 1, #lua_rouge_risk.configList do
		slot9 = slot0._riskCo and slot0._riskCo.id == slot7.id

		gohelper.setActive(gohelper.findChild(slot0.viewGO, "difficulty/" .. lua_rouge_risk.configList[slot6].id), slot9)

		if slot9 then
			slot2 = true

			if slot0._switchRiskStage and slot1 then
				slot10 = gohelper.onceAddComponent(slot8, gohelper.Type_Animator)

				slot10:Play("open", 0, 0)
				slot10:Update(0)
			end
		end
	end

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "difficulty/none"), not slot2)

	if not slot2 and slot1 then
		gohelper.onceAddComponent(slot3, gohelper.Type_Animator):Play("open", 0, 0)
	end
end

function slot0.refreshAllBuffEntry(slot0)
	for slot6, slot7 in ipairs(slot0:_getAllBuffTypes()) do
		slot0:refreshBuffEntry(slot7, slot7 <= (slot0._riskCo and slot0._riskCo.buffNum or 0))
	end
end

function slot0._getAllBuffTypes(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(RougeDLCEnum101.LimiterBuffType) do
		table.insert(slot1, slot6)
	end

	table.sort(slot1, uv0._sortBuffType)

	return slot1
end

function slot0._sortBuffType(slot0, slot1)
	return slot0 < slot1
end

function slot0.refreshBuffEntry(slot0, slot1, slot2)
	gohelper.setActive(slot0:_getOrCreateBuffPart(slot1).gobuff, slot2)

	if not slot2 then
		return
	end

	slot5 = slot0:_getTypeBuffEquiped(slot1) ~= nil
	slot6 = slot4 and slot4.blank == 1

	gohelper.setActive(slot3.imageunequiped.gameObject, not slot5)
	gohelper.setActive(slot3.imageequipednormal.gameObject, slot5 and not slot6)
	gohelper.setActive(slot3.goquipedblank, slot6 and not slot0._isCurMaxLevel)
	gohelper.setActive(slot3.goequipedblankred, slot6 and slot0._isCurMaxLevel)
	gohelper.setActive(slot3.imageselect.gameObject, slot0._selectIndex == slot1)

	if slot0._isCurMaxLevel then
		slot8 = string.format("rouge_dlc1_buffbtn" .. slot1) .. "_hong"
	end

	UISpriteSetMgr.instance:setRouge3Sprite(slot3.imageunequiped, slot8, true)
	UISpriteSetMgr.instance:setRouge3Sprite(slot3.imageequipednormal, slot8, true)
end

function slot0._getOrCreateBuffPart(slot0, slot1)
	slot0._buffPartTab = slot0._buffPartTab or slot0:getUserDataTb_()

	if not slot0._buffPartTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.gobuff = gohelper.findChild(slot0.viewGO, "#go_buff" .. slot1)
		slot2.imageunequiped = gohelper.findChildImage(slot2.gobuff, "unselect_unequip")
		slot2.imageequipednormal = gohelper.findChildImage(slot2.gobuff, "unselect_equiped")
		slot2.goquipedblank = gohelper.findChild(slot2.gobuff, "none")
		slot2.goequipedblankred = gohelper.findChild(slot2.gobuff, "none_red")
		slot2.imageselect = gohelper.findChildImage(slot2.gobuff, "select_equiped")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.gobuff, "btn_click")

		slot2.btnclick:AddClickListener(slot0._btnbuffOnClick, slot0, slot1)

		slot0._buffPartTab[slot1] = slot2
	end

	return slot2
end

function slot0._getTypeBuffEquiped(slot0, slot1)
	if RougeDLCConfig101.instance:getAllLimiterBuffCosByType(RougeModel.instance:getVersion(), slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if RougeDLCModel101.instance:getLimiterBuffState(slot8.id) == RougeDLCEnum101.BuffState.Equiped then
				return slot8
			end
		end
	end
end

function slot0._onUpdateBuffState(slot0, slot1)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(slot1) then
		return
	end

	slot0:refreshBuffEntry(slot2.buffType, true)
end

function slot0._onUpdateLimiterGroup(slot0, slot1)
	slot0:refreshUI(true)
end

function slot0._onUpdateRougeInfo(slot0)
	slot0:refreshUI()
end

function slot0._btnbuffOnClick(slot0, slot1)
	slot0:selectBuffEntry(slot1)
	RougeDLCController101.instance:openRougeLimiterBuffView({
		buffType = slot1
	})
end

function slot0.selectBuffEntry(slot0, slot1)
	slot0._selectIndex = slot1 or 0

	slot0:refreshAllBuffEntry()
end

function slot0.setDifficultyTxtFontSize(slot0, slot1)
	slot0._txtdifficulty.fontSize = slot1 or uv0.DefaultDifficultyFontSize
end

function slot0.setDifficultyVisible(slot0, slot1)
	gohelper.setActive(slot0._txtdifficulty.gameObject, slot1)
	gohelper.setActive(slot0._gonamebg, slot1)
end

function slot0.setPlaySwitchAnim(slot0, slot1)
	slot0._enabledPlaySwitchAnim = slot1
end

function slot0.setInteractable(slot0, slot1)
	slot0._canvasgroup.interactable = slot1
	slot0._canvasgroup.blocksRaycasts = slot1
end

function slot0.removeAllBuffPartClick(slot0)
	if slot0._buffPartTab then
		for slot4, slot5 in pairs(slot0._buffPartTab) do
			if slot5.btnclick then
				slot5.btnclick:RemoveClickListener()
			end
		end
	end
end

function slot0.onDestroy(slot0)
	slot0:removeAllBuffPartClick()
end

return slot0

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentView", package.seeall)

slot0 = class("TowerAssistBossTalentView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnBottomClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Scroll/Viewport/btnBottomClose")
	slot0.goBottom = gohelper.findChild(slot0.viewGO, "Bottom")
	slot0._bottomAnim = slot0.goBottom:GetComponent(gohelper.Type_Animator)
	slot0._bottomCanvasGroup = gohelper.onceAddComponent(slot0.goBottom, typeof(UnityEngine.CanvasGroup))
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.goBottom, "root/btn_Close")
	slot0.btnCancel = gohelper.findChildButtonWithAudio(slot0.goBottom, "root/btn_cancel")
	slot0.btnSure = gohelper.findChildButtonWithAudio(slot0.goBottom, "root/btn_sure")
	slot0.txtCost = gohelper.findChildTextMesh(slot0.goBottom, "root/btn_sure/txtCost")
	slot0.btnLocked = gohelper.findChildButtonWithAudio(slot0.goBottom, "root/btn_Locked")
	slot0.txtLock = gohelper.findChildTextMesh(slot0.goBottom, "root/btn_Locked/txtLock")
	slot0.btnTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/image_TitleBG/#btn_Tips")
	slot0.goTips = gohelper.findChild(slot0.viewGO, "Tips/#go_Tips")
	slot0.btnCloseTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tips/#go_Tips/#btn_closeMopupTip")
	slot0.imgTypeIcon = gohelper.findChildImage(slot0.goBottom, "root/Top/TypeIcon/#simage_TypeIcon")
	slot0.txtType = gohelper.findChildTextMesh(slot0.goBottom, "root/Top/#txt_Type")
	slot0.txtDesc = gohelper.findChildTextMesh(slot0.goBottom, "root/Scroll View/Viewport/desc")

	SkillHelper.addHyperLinkClick(slot0.txtDesc, slot0._onHyperLinkClick, slot0)

	slot0.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.txtDesc.gameObject, FixTmpBreakLine)
	slot0.bossIcon = gohelper.findChildSingleImage(slot0.viewGO, "BOSS/Head/Mask/image_bossIcon")
	slot0.txtActiveCount = gohelper.findChildTextMesh(slot0.viewGO, "BOSS/#txt_PassLevel")
	slot0.btnResetAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "BOSS/btn_reset")
	slot0.txtPoint = gohelper.findChildTextMesh(slot0.viewGO, "Tips/txt_point")
	slot0.btnAttr = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_Attr")
	slot0.isBottomVisible = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnAttr, slot0.onBtnAttr, slot0)
	slot0:addClickCb(slot0.btnCloseTips, slot0.onBtnCloseTips, slot0)
	slot0:addClickCb(slot0.btnTips, slot0.onBtnTips, slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onBtnBottomClose, slot0)
	slot0:addClickCb(slot0.btnBottomClose, slot0.onBtnBottomClose, slot0)
	slot0:addClickCb(slot0.btnCancel, slot0.onBtnReset, slot0)
	slot0:addClickCb(slot0.btnSure, slot0.onBtnSure, slot0)
	slot0:addClickCb(slot0.btnResetAll, slot0.onBtnResetAll, slot0)
	slot0:addClickCb(slot0.btnLocked, slot0.onBtnLocked, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, slot0._onResetTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, slot0._onActiveTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.SelectTalentItem, slot0._onSelectTalentItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnAttr)
	slot0:removeClickCb(slot0.btnCloseTips)
	slot0:removeClickCb(slot0.btnTips)
	slot0:removeClickCb(slot0.btnClose)
	slot0:removeClickCb(slot0.btnBottomClose)
	slot0:removeClickCb(slot0.btnCancel)
	slot0:removeClickCb(slot0.btnSure)
	slot0:removeClickCb(slot0.btnResetAll)
	slot0:removeClickCb(slot0.btnLocked)
	slot0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, slot0._onResetTalent, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, slot0._onActiveTalent, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.SelectTalentItem, slot0._onSelectTalentItem, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onBtnLocked(slot0)
	if not TowerAssistBossTalentListModel.instance:getSelectTalent() then
		return
	end

	if not (slot0.bossMo:getTalentTree() and slot2:getNode(slot1)) then
		return
	end

	slot4, slot5 = slot3:isActiveGroup()

	if slot4 then
		GameFacade.showToast(ToastEnum.ToweTalentMutex, slot2:getNode(slot5).config.nodeName)
	elseif slot3:getParentActiveResult() == 0 then
		GameFacade.showToast(ToastEnum.ToweTalentPreNotActive)
	else
		GameFacade.showToast(ToastEnum.ToweTalentPreNotAllActive)
	end
end

function slot0.onBtnAttr(slot0)
	if not slot0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentTallView, {
		bossId = slot0.bossId
	})
end

function slot0.onBtnTips(slot0)
	gohelper.setActive(slot0.goTips, true)
end

function slot0.onBtnCloseTips(slot0)
	gohelper.setActive(slot0.goTips, false)
end

function slot0.onBtnReset(slot0)
	if TowerAssistBossTalentListModel.instance:isTalentCanReset(TowerAssistBossTalentListModel.instance:getSelectTalent(), true) then
		TowerRpc.instance:sendTowerResetTalentRequest(slot0.bossId, slot1)
	end
end

function slot0.onBtnResetAll(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.TowerTalentReset, MsgBoxEnum.BoxType.Yes_No, slot0._sendTowerResetAllTalentRequest, nil, , slot0)
end

function slot0._sendTowerResetAllTalentRequest(slot0)
	TowerRpc.instance:sendTowerResetTalentRequest(slot0.bossId, 0)
end

function slot0.onBtnSure(slot0)
	if not TowerAssistBossTalentListModel.instance:getSelectTalent() then
		return
	end

	if not (slot0.bossMo:getTalentTree() and slot2:getNode(slot1)) then
		return
	end

	if slot3:isActiveTalent() then
		return
	end

	if slot3:isActiveGroup() then
		return
	end

	if not slot3:isParentActive() then
		GameFacade.showToast(ToastEnum.ToweTalentPreNotActive)

		return
	end

	if not slot3:isTalentConsumeEnough() then
		GameFacade.showToast(ToastEnum.ToweTalentPointNotEnough)

		return
	end

	TowerRpc.instance:sendTowerActiveTalentRequest(slot0.bossId, slot1)
	TowerAssistBossTalentListModel.instance:setSelectTalent()
	slot0:setBottomVisible(false)
end

function slot0.onBtnBottomClose(slot0)
	if slot0:setBottomVisible(false) then
		TowerAssistBossTalentListModel.instance:setSelectTalent()
	end
end

function slot0.setBottomVisible(slot0, slot1)
	if slot0.isBottomVisible == slot1 then
		return
	end

	slot0.isBottomVisible = slot1

	if slot1 then
		gohelper.setActive(slot0.goBottom, true)
		slot0._bottomAnim:Play("open")

		slot0._bottomCanvasGroup.interactable = true
		slot0._bottomCanvasGroup.blocksRaycasts = true

		gohelper.setActive(slot0.btnAttr, false)
	else
		slot0._bottomAnim:Play("close")

		slot0._bottomCanvasGroup.interactable = false
		slot0._bottomCanvasGroup.blocksRaycasts = false

		gohelper.setActive(slot0.btnAttr, true)
	end

	return true
end

function slot0._onResetTalent(slot0, slot1)
	slot0:refreshView()
end

function slot0._onActiveTalent(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_talent_light)
	slot0:refreshView()
end

function slot0._onSelectTalentItem(slot0)
	slot0:refreshBottom()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_enter_talent_tree)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.bossId = slot0.viewParam.bossId
	slot0.bossMo = TowerAssistBossModel.instance:getBoss(slot0.bossId)
end

function slot0.refreshView(slot0)
	TowerAssistBossTalentListModel.instance:refreshList()
	slot0:refreshBoss()
	slot0:refreshBottom()

	slot0.txtPoint.text = tostring(slot0.bossMo:getTalentPoint())
end

function slot0.refreshBoss(slot0)
	slot1, slot2 = slot0.bossMo:getTalentActiveCount()
	slot0.txtActiveCount.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towertalent_already_light"), slot1, slot1 + slot2)

	slot0.bossIcon:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(TowerConfig.instance:getAssistBossConfig(slot0.bossId).skinId) and slot5.headIcon))
	gohelper.setActive(slot0.btnResetAll, TowerAssistBossModel.instance:getById(slot0.bossId) ~= nil)
end

function slot0.refreshBottom(slot0)
	if not TowerAssistBossTalentListModel.instance:getSelectTalent() then
		slot0:setBottomVisible(false)

		return
	end

	slot0:setBottomVisible(true)

	if not slot0.bossMo:getTalentTree():getNode(slot1) then
		return
	end

	slot4 = slot3.config
	slot6 = slot3:isActiveGroup()
	slot7 = slot3:isParentActive()

	gohelper.setActive(slot0.btnSure, not slot3:isActiveTalent() and not slot6 and slot7)
	gohelper.setActive(slot0.btnCancel, slot3:isLeafNode() and slot5)

	slot10 = not slot5 and (slot6 or not slot7)

	gohelper.setActive(slot0.btnLocked, slot10)

	if slot10 then
		slot11 = slot3:getParentActiveResult()

		if slot6 then
			slot0.txtLock.text = luaLang("towertalent_txt_Locked2")
		elseif slot11 == 0 then
			slot0.txtLock.text = luaLang("towertalent_txt_Locked1")
		else
			slot0.txtLock.text = luaLang("towertalent_txt_Locked3")
		end
	end

	if not slot5 then
		if slot3:isTalentConsumeEnough() then
			slot0.txtCost.text = string.format("<color=#070706>-%s</color>", slot3.config.consume)
		else
			slot0.txtCost.text = string.format("-%s", slot3.config.consume)
		end
	end

	TowerConfig.instance:setTalentImg(slot0.imgTypeIcon, slot4)

	slot0.txtType.text = slot4.nodeName
	slot0.txtDesc.text = SkillHelper.buildDesc(slot4.nodeDesc)

	slot0.descFixTmpBreakLine:refreshTmpContent(slot0.txtDesc)
end

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(slot1), CommonBuffTipEnum.Anchor[slot0.viewName], CommonBuffTipEnum.Pivot.Down)
end

function slot0.onClose(slot0)
	TowerAssistBossTalentListModel.instance:setSelectTalent()
end

function slot0.onDestroyView(slot0)
	slot0.bossIcon:UnLoadImage()
end

return slot0

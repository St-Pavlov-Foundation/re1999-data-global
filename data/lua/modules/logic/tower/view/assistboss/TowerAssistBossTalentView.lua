module("modules.logic.tower.view.assistboss.TowerAssistBossTalentView", package.seeall)

local var_0_0 = class("TowerAssistBossTalentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnBottomClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Scroll/Viewport/btnBottomClose")
	arg_1_0.goBottom = gohelper.findChild(arg_1_0.viewGO, "Bottom")
	arg_1_0._bottomAnim = arg_1_0.goBottom:GetComponent(gohelper.Type_Animator)
	arg_1_0._bottomCanvasGroup = gohelper.onceAddComponent(arg_1_0.goBottom, typeof(UnityEngine.CanvasGroup))
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.goBottom, "root/btn_Close")
	arg_1_0.btnCancel = gohelper.findChildButtonWithAudio(arg_1_0.goBottom, "root/btn_cancel")
	arg_1_0.btnSure = gohelper.findChildButtonWithAudio(arg_1_0.goBottom, "root/btn_sure")
	arg_1_0.txtCost = gohelper.findChildTextMesh(arg_1_0.goBottom, "root/btn_sure/txtCost")
	arg_1_0.btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.goBottom, "root/btn_Locked")
	arg_1_0.txtLock = gohelper.findChildTextMesh(arg_1_0.goBottom, "root/btn_Locked/txtLock")
	arg_1_0.btnTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/image_TitleBG/#btn_Tips")
	arg_1_0.goTips = gohelper.findChild(arg_1_0.viewGO, "Tips/#go_Tips")
	arg_1_0.btnCloseTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Tips/#go_Tips/#btn_closeMopupTip")
	arg_1_0.imgTypeIcon = gohelper.findChildImage(arg_1_0.goBottom, "root/Top/TypeIcon/#simage_TypeIcon")
	arg_1_0.txtType = gohelper.findChildTextMesh(arg_1_0.goBottom, "root/Top/#txt_Type")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.goBottom, "root/Scroll View/Viewport/desc")

	SkillHelper.addHyperLinkClick(arg_1_0.txtDesc, arg_1_0._onHyperLinkClick, arg_1_0)

	arg_1_0.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.txtDesc.gameObject, FixTmpBreakLine)
	arg_1_0.bossIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "BOSS/Head/Mask/image_bossIcon")
	arg_1_0.txtActiveCount = gohelper.findChildTextMesh(arg_1_0.viewGO, "BOSS/layout/#txt_PassLevel")
	arg_1_0.btnResetAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BOSS/layout/btn_reset")
	arg_1_0.txtPoint = gohelper.findChildTextMesh(arg_1_0.viewGO, "Tips/txt_point")
	arg_1_0.btnAttr = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_Attr")
	arg_1_0.isBottomVisible = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnAttr, arg_2_0.onBtnAttr, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCloseTips, arg_2_0.onBtnCloseTips, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTips, arg_2_0.onBtnTips, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onBtnBottomClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBottomClose, arg_2_0.onBtnBottomClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCancel, arg_2_0.onBtnReset, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSure, arg_2_0.onBtnSure, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnResetAll, arg_2_0.onBtnResetAll, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnLocked, arg_2_0.onBtnLocked, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_2_0._onResetTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_2_0._onActiveTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.SelectTalentItem, arg_2_0._onSelectTalentItem, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_2_0.refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnAttr)
	arg_3_0:removeClickCb(arg_3_0.btnCloseTips)
	arg_3_0:removeClickCb(arg_3_0.btnTips)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
	arg_3_0:removeClickCb(arg_3_0.btnBottomClose)
	arg_3_0:removeClickCb(arg_3_0.btnCancel)
	arg_3_0:removeClickCb(arg_3_0.btnSure)
	arg_3_0:removeClickCb(arg_3_0.btnResetAll)
	arg_3_0:removeClickCb(arg_3_0.btnLocked)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_3_0._onResetTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_3_0._onActiveTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.SelectTalentItem, arg_3_0._onSelectTalentItem, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_3_0.refreshView, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onBtnLocked(arg_5_0)
	local var_5_0 = TowerAssistBossTalentListModel.instance:getSelectTalent()

	if not var_5_0 then
		return
	end

	local var_5_1 = arg_5_0.bossMo:getTalentTree()
	local var_5_2 = var_5_1 and var_5_1:getNode(var_5_0)

	if not var_5_2 then
		return
	end

	local var_5_3, var_5_4 = var_5_2:isActiveGroup()

	if var_5_3 then
		local var_5_5 = var_5_1:getNode(var_5_4)

		GameFacade.showToast(ToastEnum.ToweTalentMutex, var_5_5.config.nodeName)
	elseif var_5_2:getParentActiveResult() == 0 then
		GameFacade.showToast(ToastEnum.ToweTalentPreNotActive)
	else
		GameFacade.showToast(ToastEnum.ToweTalentPreNotAllActive)
	end
end

function var_0_0.onBtnAttr(arg_6_0)
	if not arg_6_0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentTallView, {
		bossId = arg_6_0.bossId
	})
end

function var_0_0.onBtnTips(arg_7_0)
	gohelper.setActive(arg_7_0.goTips, true)
end

function var_0_0.onBtnCloseTips(arg_8_0)
	gohelper.setActive(arg_8_0.goTips, false)
end

function var_0_0.onBtnReset(arg_9_0)
	if TowerAssistBossTalentListModel.instance:getAutoTalentState() then
		GameFacade.showToast(ToastEnum.TowerBossTalentPlanCantModify)

		return
	end

	local var_9_0 = TowerAssistBossTalentListModel.instance:getSelectTalent()

	if TowerAssistBossTalentListModel.instance:isTalentCanReset(var_9_0, true) then
		TowerRpc.instance:sendTowerResetTalentRequest(arg_9_0.bossId, var_9_0)
	end
end

function var_0_0.onBtnResetAll(arg_10_0)
	if TowerAssistBossTalentListModel.instance:getAutoTalentState() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.TowerTalentReset, MsgBoxEnum.BoxType.Yes_No, arg_10_0._sendTowerResetAllTalentRequest, nil, nil, arg_10_0)
end

function var_0_0._sendTowerResetAllTalentRequest(arg_11_0)
	TowerRpc.instance:sendTowerResetTalentRequest(arg_11_0.bossId, 0)
end

function var_0_0.onBtnSure(arg_12_0)
	local var_12_0 = TowerAssistBossTalentListModel.instance:getSelectTalent()

	if not var_12_0 then
		return
	end

	local var_12_1 = arg_12_0.bossMo:getTalentTree()
	local var_12_2 = var_12_1 and var_12_1:getNode(var_12_0)

	if not var_12_2 then
		return
	end

	if TowerAssistBossTalentListModel.instance:getAutoTalentState() then
		GameFacade.showToast(ToastEnum.TowerBossTalentPlanCantModify)

		return
	end

	if var_12_2:isActiveTalent() then
		return
	end

	if var_12_2:isActiveGroup() then
		return
	end

	if not var_12_2:isParentActive() then
		GameFacade.showToast(ToastEnum.ToweTalentPreNotActive)

		return
	end

	if not var_12_2:isTalentConsumeEnough() then
		GameFacade.showToast(ToastEnum.ToweTalentPointNotEnough)

		return
	end

	TowerRpc.instance:sendTowerActiveTalentRequest(arg_12_0.bossId, var_12_0)
	TowerAssistBossTalentListModel.instance:setSelectTalent()
	arg_12_0:setBottomVisible(false)
end

function var_0_0.onBtnBottomClose(arg_13_0)
	if arg_13_0:setBottomVisible(false) then
		TowerAssistBossTalentListModel.instance:setSelectTalent()
	end
end

function var_0_0.setBottomVisible(arg_14_0, arg_14_1)
	if arg_14_0.isBottomVisible == arg_14_1 then
		return
	end

	arg_14_0.isBottomVisible = arg_14_1

	if arg_14_1 then
		gohelper.setActive(arg_14_0.goBottom, true)
		arg_14_0._bottomAnim:Play("open")

		arg_14_0._bottomCanvasGroup.interactable = true
		arg_14_0._bottomCanvasGroup.blocksRaycasts = true

		gohelper.setActive(arg_14_0.btnAttr, false)
	else
		arg_14_0._bottomAnim:Play("close")

		arg_14_0._bottomCanvasGroup.interactable = false
		arg_14_0._bottomCanvasGroup.blocksRaycasts = false

		gohelper.setActive(arg_14_0.btnAttr, true)
	end

	return true
end

function var_0_0._onResetTalent(arg_15_0, arg_15_1)
	arg_15_0:refreshView()
end

function var_0_0._onActiveTalent(arg_16_0, arg_16_1)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_talent_light)
	arg_16_0:refreshView()
end

function var_0_0._onSelectTalentItem(arg_17_0)
	arg_17_0:refreshBottom()
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0:refreshParam()
	arg_18_0:refreshView()
end

function var_0_0.onOpen(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_enter_talent_tree)
	arg_19_0:refreshParam()
	arg_19_0:refreshView()
end

function var_0_0.refreshParam(arg_20_0)
	arg_20_0.bossId = arg_20_0.viewParam.bossId
	arg_20_0.bossMo = TowerAssistBossModel.instance:getBoss(arg_20_0.bossId)
end

function var_0_0.refreshView(arg_21_0)
	TowerAssistBossTalentListModel.instance:refreshList()
	arg_21_0:refreshBoss()
	arg_21_0:refreshBottom()

	arg_21_0.txtPoint.text = tostring(arg_21_0.bossMo:getTalentPoint())
end

function var_0_0.refreshBoss(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0.bossMo:getTalentActiveCount()
	local var_22_2 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towertalent_already_light"), var_22_0, var_22_0 + var_22_1)

	arg_22_0.txtActiveCount.text = var_22_2

	local var_22_3 = TowerConfig.instance:getAssistBossConfig(arg_22_0.bossId)
	local var_22_4 = FightConfig.instance:getSkinCO(var_22_3.skinId)

	arg_22_0.bossIcon:LoadImage(ResUrl.monsterHeadIcon(var_22_4 and var_22_4.headIcon))

	local var_22_5 = TowerAssistBossModel.instance:getById(arg_22_0.bossId)
	local var_22_6 = TowerAssistBossTalentListModel.instance:getAutoTalentState()

	gohelper.setActive(arg_22_0.btnResetAll, var_22_5 ~= nil and not var_22_6)
end

function var_0_0.refreshBottom(arg_23_0)
	local var_23_0 = TowerAssistBossTalentListModel.instance:getSelectTalent()

	if not var_23_0 then
		arg_23_0:setBottomVisible(false)

		return
	end

	arg_23_0:setBottomVisible(true)

	local var_23_1 = arg_23_0.bossMo:getTalentTree():getNode(var_23_0)

	if not var_23_1 then
		return
	end

	local var_23_2 = var_23_1.config
	local var_23_3 = var_23_1:isActiveTalent()
	local var_23_4 = var_23_1:isActiveGroup()
	local var_23_5 = var_23_1:isParentActive()
	local var_23_6 = var_23_1:isLeafNode()
	local var_23_7 = not var_23_3 and not var_23_4 and var_23_5

	gohelper.setActive(arg_23_0.btnSure, var_23_7)
	gohelper.setActive(arg_23_0.btnCancel, var_23_6 and var_23_3)

	local var_23_8 = not var_23_3 and (var_23_4 or not var_23_5)

	gohelper.setActive(arg_23_0.btnLocked, var_23_8)

	if var_23_8 then
		local var_23_9 = var_23_1:getParentActiveResult()

		if var_23_4 then
			arg_23_0.txtLock.text = luaLang("towertalent_txt_Locked2")
		elseif var_23_9 == 0 then
			arg_23_0.txtLock.text = luaLang("towertalent_txt_Locked1")
		else
			arg_23_0.txtLock.text = luaLang("towertalent_txt_Locked3")
		end
	end

	if not var_23_3 then
		if var_23_1:isTalentConsumeEnough() then
			arg_23_0.txtCost.text = string.format("<color=#070706>-%s</color>", var_23_1.config.consume)
		else
			arg_23_0.txtCost.text = string.format("-%s", var_23_1.config.consume)
		end
	end

	TowerConfig.instance:setTalentImg(arg_23_0.imgTypeIcon, var_23_2)

	arg_23_0.txtType.text = var_23_2.nodeName
	arg_23_0.txtDesc.text = SkillHelper.buildDesc(var_23_2.nodeDesc)

	arg_23_0.descFixTmpBreakLine:refreshTmpContent(arg_23_0.txtDesc)
end

function var_0_0._onHyperLinkClick(arg_24_0, arg_24_1, arg_24_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_24_1), CommonBuffTipEnum.Anchor[arg_24_0.viewName], CommonBuffTipEnum.Pivot.Down)
end

function var_0_0.onClose(arg_25_0)
	TowerAssistBossTalentListModel.instance:setSelectTalent()
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0.bossIcon:UnLoadImage()
end

return var_0_0

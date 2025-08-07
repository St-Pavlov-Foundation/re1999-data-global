module("modules.logic.sp01.odyssey.view.OdysseyTalentTreeView", package.seeall)

local var_0_0 = class("OdysseyTalentTreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._txtremainTalentPoint = gohelper.findChildText(arg_1_0.viewGO, "talentpoint/#txt_remainTalentPoint")
	arg_1_0._gotalentTree = gohelper.findChild(arg_1_0.viewGO, "talentTree")
	arg_1_0._gotreeType1 = gohelper.findChild(arg_1_0.viewGO, "talentTree/#go_treeType1")
	arg_1_0._gotreeType2 = gohelper.findChild(arg_1_0.viewGO, "talentTree/#go_treeType2")
	arg_1_0._gotreeType3 = gohelper.findChild(arg_1_0.viewGO, "talentTree/#go_treeType3")
	arg_1_0._gotalentDetailTipView = gohelper.findChild(arg_1_0.viewGO, "#go_talentDetailTipView")
	arg_1_0._txttalentName = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/title/#txt_talentName")
	arg_1_0._gotalentNode = gohelper.findChild(arg_1_0.viewGO, "#go_talentDetailTipView/#go_talentNode")
	arg_1_0._scrolltalentEffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_talentDetailTipView/#scroll_talentEffect")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#go_talentDetailTipView/#scroll_talentEffect/Viewport/#go_Content")
	arg_1_0._gotalentEffectItem = gohelper.findChild(arg_1_0.viewGO, "#go_talentDetailTipView/#scroll_talentEffect/Viewport/#go_Content/#go_talentEffectItem")
	arg_1_0._btnNotLvDown = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_NotLvDown")
	arg_1_0._txtNotLvDownNum = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_NotLvDown/#txt_NotLvDownNum")
	arg_1_0._txtNotLvDown = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_NotLvDown/txt_LvDown")
	arg_1_0._btnLvDown = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_LvDown")
	arg_1_0._txtLvDownNum = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_LvDown/#txt_LvDownNum")
	arg_1_0._txtLvDown = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_LvDown/txt_LvDown")
	arg_1_0._btnLvUp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_LvUp")
	arg_1_0._txtLvUpNum = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_LvUp/#txt_LvUpNum")
	arg_1_0._goLvUpMax = gohelper.findChild(arg_1_0.viewGO, "#go_talentDetailTipView/#go_LvUpMax")
	arg_1_0._btnLvUpFirst = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_LvUpFirst")
	arg_1_0._txtLvUpFirstNum = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/#btn_LvUpFirst/#txt_LvUpFirstNum")
	arg_1_0._goLvUpLock = gohelper.findChild(arg_1_0.viewGO, "#go_talentDetailTipView/#go_LvUpLock")
	arg_1_0._txtLvUpLockNum = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/#go_LvUpLock/#txt_LvUpLockNum")
	arg_1_0._txtlockTip = gohelper.findChildText(arg_1_0.viewGO, "#go_talentDetailTipView/#go_LvUpLock/LockTips/#txt_lockTip")
	arg_1_0._btnCloseTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeTip")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnNotLvDown:AddClickListener(arg_2_0._btnNotLvDownOnClick, arg_2_0)
	arg_2_0._btnLvDown:AddClickListener(arg_2_0._btnLvDownOnClick, arg_2_0)
	arg_2_0._btnLvUp:AddClickListener(arg_2_0._btnLvUpOnClick, arg_2_0)
	arg_2_0._btnLvUpFirst:AddClickListener(arg_2_0._btnLvUpFirstOnClick, arg_2_0)
	arg_2_0._btnCloseTip:AddClickListener(arg_2_0._btnCloseTipOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.RefreshTalentNodeSelect, arg_2_0.onTalentNodeSelect, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.ResetTalent, arg_2_0.resetTalent, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.RefreshTalent, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnNotLvDown:RemoveClickListener()
	arg_3_0._btnLvDown:RemoveClickListener()
	arg_3_0._btnLvUp:RemoveClickListener()
	arg_3_0._btnLvUpFirst:RemoveClickListener()
	arg_3_0._btnCloseTip:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.RefreshTalentNodeSelect, arg_3_0.onTalentNodeSelect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.ResetTalent, arg_3_0.resetTalent, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.RefreshTalent, arg_3_0.refreshUI, arg_3_0)
end

var_0_0.NodeRadius = 60
var_0_0.ScaleOffset = 720
var_0_0.NormalScale = 0
var_0_0.ScaleTime = 0.3

function var_0_0._btnLvUpFirstOnClick(arg_4_0)
	if arg_4_0.curSelectNodeId > 0 and arg_4_0.canConsume then
		OdysseyRpc.instance:sendOdysseyTalentNodeLevelUpRequest(arg_4_0.curSelectNodeId, arg_4_0.playTalentNodeLevelUpEffect, arg_4_0)
	elseif not arg_4_0.canConsume then
		GameFacade.showToast(ToastEnum.OdysseyTalentPointLack)
	end
end

function var_0_0._btnresetOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.OdysseyResetTalentTree, MsgBoxEnum.BoxType.Yes_No, arg_5_0.sendResetTalentTree, nil, nil, arg_5_0)
end

function var_0_0.sendResetTalentTree(arg_6_0)
	OdysseyRpc.instance:sendOdysseyTalentAllResetRequest()
end

function var_0_0._btnNotLvDownOnClick(arg_7_0)
	if arg_7_0.isHasChildNode then
		GameFacade.showToast(ToastEnum.OdysseyTalentNotLvDown)
	elseif arg_7_0.isLvDownNotAccordLightNum then
		GameFacade.showToast(ToastEnum.OdysseyTalentNotAccordLightNum)
	end
end

function var_0_0._btnLvDownOnClick(arg_8_0)
	OdysseyRpc.instance:sendOdysseyTalentNodeLevelDownRequest(arg_8_0.curSelectNodeId)
	arg_8_0._animTalentPoint:Play("click", 0, 0)
	arg_8_0._animTalentPoint:Update(0)
end

function var_0_0._btnLvUpOnClick(arg_9_0)
	if arg_9_0.canConsume then
		OdysseyRpc.instance:sendOdysseyTalentNodeLevelUpRequest(arg_9_0.curSelectNodeId, arg_9_0.playTalentNodeLevelUpEffect, arg_9_0)
	else
		GameFacade.showToast(ToastEnum.OdysseyTalentPointLack)
	end
end

function var_0_0._btnCloseTipOnClick(arg_10_0)
	if not arg_10_0.curIsTreeSmallScale then
		return
	end

	OdysseyTalentModel.instance:setCurselectNodeId(0)

	arg_10_0.curIsTreeSmallScale = true

	arg_10_0:createAndRefreshTalentNodeItem()
	arg_10_0:doTalentTreeScaleAnim()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.talentTreeMap = arg_11_0:getUserDataTb_()
	arg_11_0.talentTreeLineMap = arg_11_0:getUserDataTb_()

	gohelper.setActive(arg_11_0._gotalentDetailTipView, false)

	arg_11_0.tempLineVector = Vector2(0, 0)
	arg_11_0.curIsTreeSmallScale = false
	arg_11_0.screenWidth = gohelper.getUIScreenWidth()

	recthelper.setWidth(arg_11_0._gotalentTree.transform, arg_11_0.screenWidth)

	arg_11_0._animTalentTree = gohelper.findChild(arg_11_0.viewGO, "talentTree"):GetComponent(gohelper.Type_Animator)
	arg_11_0._animPlayerDetailTip = SLFramework.AnimatorPlayer.Get(arg_11_0._gotalentDetailTipView)
	arg_11_0._animTalentPoint = gohelper.findChild(arg_11_0.viewGO, "talentpoint"):GetComponent(gohelper.Type_Animator)
	arg_11_0._txtTalentPointEffect = gohelper.findChildText(arg_11_0.viewGO, "talentpoint/#txt_effect")
	arg_11_0._talentSelectFrameFlashMap = arg_11_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.resetTalent(arg_13_0)
	if arg_13_0._gotalentDetailTipView.activeSelf then
		arg_13_0:_btnCloseTipOnClick()
	end

	arg_13_0._animTalentPoint:Play("click", 0, 0)
	arg_13_0._animTalentPoint:Update(0)
	arg_13_0:refreshUI()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:refreshUI()
	OdysseyStatHelper.instance:initViewStartTime()
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:createAndRefreshTalentNodeItem()
	arg_15_0:createAndRefreshNodeItemLine()

	arg_15_0.curTalentPoint = OdysseyTalentModel.instance:getCurTalentPoint()
	arg_15_0._txtremainTalentPoint.text = arg_15_0.curTalentPoint
	arg_15_0._txtTalentPointEffect.text = arg_15_0.curTalentPoint
	arg_15_0.curSelectNodeId = OdysseyTalentModel.instance:getCurSelectNodeId()

	if arg_15_0.curSelectNodeId > 0 then
		if not arg_15_0.curIsTreeSmallScale then
			arg_15_0:doTalentTreeScaleAnim()
		end

		arg_15_0:refreshTalentDetailTipView()
	end

	local var_15_0 = OdysseyTalentModel.instance:isHasTalentNode()

	gohelper.setActive(arg_15_0._btnreset.gameObject, var_15_0)
end

function var_0_0.createAndRefreshTalentNodeItem(arg_16_0)
	for iter_16_0 = OdysseyEnum.TalentType.Hunter, OdysseyEnum.TalentType.Assassin do
		local var_16_0 = arg_16_0.talentTreeMap[iter_16_0]

		if not var_16_0 then
			var_16_0 = {
				treeGO = arg_16_0["_gotreeType" .. iter_16_0]
			}
			var_16_0.lastCostPoint = -1
			var_16_0.txtCostPoint = gohelper.findChildText(var_16_0.treeGO, "treeInfo/txt_costPoint")
			var_16_0.txtTypeName = gohelper.findChildText(var_16_0.treeGO, "treeInfo/txt_typeName")
			var_16_0.goLineContent = gohelper.findChild(var_16_0.treeGO, "go_lineContent")
			var_16_0.goLine = gohelper.findChild(var_16_0.treeGO, "go_lineContent/go_line")
			var_16_0.upgradeEffect = gohelper.findChild(var_16_0.treeGO, "treeInfo/vx_upgrade")
			var_16_0.talentItemPos = {}

			for iter_16_1 = 1, 8 do
				local var_16_1 = gohelper.findChild(var_16_0.treeGO, "go_talentitem" .. iter_16_1)

				if not var_16_1 then
					break
				end

				var_16_0.talentItemPos[iter_16_1] = var_16_1
			end

			var_16_0.talentTypeCoList = OdysseyConfig.instance:getAllTalentConfigByType(iter_16_0)
			var_16_0.talentNodeItemMap = {}

			for iter_16_2, iter_16_3 in ipairs(var_16_0.talentTypeCoList) do
				local var_16_2 = iter_16_3.position
				local var_16_3 = var_16_0.talentItemPos[var_16_2]

				if var_16_3 then
					local var_16_4 = arg_16_0.viewContainer:getResInst(arg_16_0.viewContainer:getSetting().otherRes[1], var_16_3, tostring(iter_16_3.nodeId))
					local var_16_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_4, OdysseyTalentNodeItem)

					var_16_0.talentNodeItemMap[iter_16_3.nodeId] = var_16_5
				end
			end

			arg_16_0.talentTreeMap[iter_16_0] = var_16_0
		end

		for iter_16_4, iter_16_5 in ipairs(var_16_0.talentTypeCoList) do
			local var_16_6 = var_16_0.talentNodeItemMap[iter_16_5.nodeId]

			if var_16_6 then
				var_16_6:refreshNode(iter_16_5)
			end
		end

		local var_16_7 = OdysseyTalentModel.instance:getTalentConsumeCount(iter_16_0)

		if var_16_0.lastCostPoint > -1 and var_16_7 > var_16_0.lastCostPoint then
			gohelper.setActive(var_16_0.upgradeEffect, false)
			gohelper.setActive(var_16_0.upgradeEffect, true)
		end

		var_16_0.lastCostPoint = var_16_7
		var_16_0.txtCostPoint.text = var_16_7
		var_16_0.txtTypeName.text = luaLang("odyssey_talenttree_type" .. iter_16_0)
	end
end

function var_0_0.createAndRefreshNodeItemLine(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.talentTreeMap) do
		local var_17_0 = iter_17_1.goLineContent
		local var_17_1 = iter_17_1.goLine

		gohelper.setActive(var_17_1, false)

		for iter_17_2, iter_17_3 in ipairs(iter_17_1.talentTypeCoList) do
			local var_17_2 = OdysseyConfig.instance:getTalentParentNodeConfig(iter_17_3.nodeId)

			if var_17_2 then
				local var_17_3 = arg_17_0.talentTreeLineMap[iter_17_3.nodeId]

				if not var_17_3 then
					var_17_3 = {}

					local var_17_4 = iter_17_1.talentItemPos[var_17_2.position]
					local var_17_5 = iter_17_1.talentItemPos[iter_17_3.position]
					local var_17_6 = var_17_4.transform.localPosition
					local var_17_7 = var_17_5.transform.localPosition
					local var_17_8 = (var_17_6 + var_17_7) * 0.5
					local var_17_9 = Vector2.Distance(var_17_6, var_17_7) - 2 * var_0_0.NodeRadius

					arg_17_0.tempLineVector:Set(var_17_7.x - var_17_6.x, var_17_7.y - var_17_6.y)

					var_17_3.go = gohelper.clone(var_17_1, var_17_0, "lineItem" .. iter_17_3.nodeId)
					var_17_3.lightGO = gohelper.findChild(var_17_3.go, "go_linelight")

					gohelper.setActive(var_17_3.go, true)
					recthelper.setAnchor(var_17_3.go.transform, var_17_8.x, var_17_8.y)
					recthelper.setHeight(var_17_3.go.transform, var_17_9)

					local var_17_10 = Mathf.Atan2(arg_17_0.tempLineVector.y, arg_17_0.tempLineVector.x) * Mathf.Rad2Deg - 90

					transformhelper.setLocalRotation(var_17_3.go.transform, 0, 0, var_17_10)

					arg_17_0.talentTreeLineMap[iter_17_3.nodeId] = var_17_3
				end

				local var_17_11 = OdysseyTalentModel.instance:getTalentMo(iter_17_3.nodeId)

				gohelper.setActive(var_17_3.lightGO, var_17_11)
			end
		end
	end
end

function var_0_0.refreshTalentDetailTipView(arg_18_0)
	arg_18_0.curSelectNodeId = OdysseyTalentModel.instance:getCurSelectNodeId()

	if arg_18_0.curSelectNodeId == 0 then
		return
	end

	gohelper.setActive(arg_18_0._gotalentDetailTipView, true)

	arg_18_0.curTalentEffectCoList = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(arg_18_0.curSelectNodeId)
	arg_18_0._txttalentName.text = arg_18_0.curTalentEffectCoList[1] and arg_18_0.curTalentEffectCoList[1].nodeName or ""
	arg_18_0._scrolltalentEffect.verticalNormalizedPosition = 1
	arg_18_0.selectTalentMo = OdysseyTalentModel.instance:getTalentMo(arg_18_0.curSelectNodeId)
	arg_18_0.isHasChildNode = arg_18_0.selectTalentMo and arg_18_0.selectTalentMo:isHasChildNode()
	arg_18_0.isLvDownNotAccordLightNum = OdysseyTalentModel.instance:checkLvDownHasNotAccordLightNumNode(arg_18_0.curSelectNodeId)
	arg_18_0.isUnlock, arg_18_0.unlockConditionData = OdysseyTalentModel.instance:checkTalentCanUnlock(arg_18_0.curSelectNodeId)
	arg_18_0._talentSelectFrameFlashMap = arg_18_0:getUserDataTb_()

	gohelper.CreateObjList(arg_18_0, arg_18_0.onTalentEffectShow, arg_18_0.curTalentEffectCoList, arg_18_0._goContent, arg_18_0._gotalentEffectItem)
	gohelper.setActive(arg_18_0._goLvUpLock, not arg_18_0.isUnlock)
	gohelper.setActive(arg_18_0._btnLvUpFirst.gameObject, arg_18_0.isUnlock and (not arg_18_0.selectTalentMo or arg_18_0.selectTalentMo.level == 0))
	gohelper.setActive(arg_18_0._btnNotLvDown.gameObject, arg_18_0.isUnlock and arg_18_0.selectTalentMo and arg_18_0.selectTalentMo.level > 0 and (arg_18_0.isHasChildNode or arg_18_0.isLvDownNotAccordLightNum))
	gohelper.setActive(arg_18_0._btnLvDown.gameObject, arg_18_0.isUnlock and arg_18_0.selectTalentMo and arg_18_0.selectTalentMo.level > 0 and not arg_18_0.isHasChildNode and not arg_18_0.isLvDownNotAccordLightNum)
	gohelper.setActive(arg_18_0._goLvUpMax, arg_18_0.isUnlock and arg_18_0.selectTalentMo and arg_18_0.selectTalentMo.level == #arg_18_0.curTalentEffectCoList)
	gohelper.setActive(arg_18_0._btnLvUp.gameObject, arg_18_0.isUnlock and arg_18_0.selectTalentMo and arg_18_0.selectTalentMo.level < #arg_18_0.curTalentEffectCoList and arg_18_0.selectTalentMo.level > 0)

	local var_18_0 = arg_18_0.selectTalentMo and arg_18_0.selectTalentMo.level or 0
	local var_18_1 = var_18_0 + 1

	arg_18_0.canConsume = var_18_1 <= #arg_18_0.curTalentEffectCoList and arg_18_0.curTalentPoint >= arg_18_0.curTalentEffectCoList[var_18_1].consume

	if var_18_1 <= #arg_18_0.curTalentEffectCoList then
		local var_18_2 = arg_18_0.canConsume and "-%s" or "<#ff0000>-%s</color>"

		arg_18_0._txtLvUpLockNum.text = string.format(var_18_2, arg_18_0.curTalentEffectCoList[var_18_1] and arg_18_0.curTalentEffectCoList[var_18_1].consume or 0)
		arg_18_0._txtLvUpNum.text = string.format(var_18_2, arg_18_0.curTalentEffectCoList[var_18_1] and arg_18_0.curTalentEffectCoList[var_18_1].consume or 0)
		arg_18_0._txtLvUpFirstNum.text = string.format(var_18_2, arg_18_0.curTalentEffectCoList[var_18_1] and arg_18_0.curTalentEffectCoList[var_18_1].consume or 0)
	end

	arg_18_0._txtNotLvDownNum.text = var_18_0 > 0 and string.format("+%s", arg_18_0.curTalentEffectCoList[var_18_0].consume) or ""
	arg_18_0._txtLvDownNum.text = var_18_0 > 0 and string.format("+%s", arg_18_0.curTalentEffectCoList[var_18_0].consume) or ""
	arg_18_0._txtNotLvDown.text = var_18_0 > 1 and luaLang("odyssey_lvdown") or luaLang("odyssey_lvcancel")
	arg_18_0._txtLvDown.text = var_18_0 > 1 and luaLang("odyssey_lvdown") or luaLang("odyssey_lvcancel")

	if not arg_18_0.isUnlock then
		if arg_18_0.unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentType then
			local var_18_3 = tonumber(arg_18_0.unlockConditionData[2])
			local var_18_4 = tonumber(arg_18_0.unlockConditionData[3])
			local var_18_5 = luaLang("odyssey_talenttree_type" .. var_18_3)

			arg_18_0._txtlockTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("odyssey_talenttree_locktip_needlight"), var_18_4, var_18_5)
		elseif arg_18_0.unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentNode then
			arg_18_0._txtlockTip.text = luaLang("odyssey_talenttree_locktip_prenode")
		end
	else
		arg_18_0._txtlockTip.text = ""
	end

	arg_18_0:refreshTalentDetailTipTalentNode()
end

function var_0_0.refreshTalentDetailTipTalentNode(arg_19_0)
	if not arg_19_0.curDetailTalentNodeItem then
		local var_19_0 = arg_19_0.viewContainer:getResInst(arg_19_0.viewContainer:getSetting().otherRes[1], arg_19_0._gotalentNode)

		arg_19_0.curDetailTalentNodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_0, OdysseyTalentNodeItem)

		arg_19_0.curDetailTalentNodeItem:hideBtn()
	end

	local var_19_1 = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(arg_19_0.curSelectNodeId)

	arg_19_0.curDetailTalentNodeItem:refreshNode(var_19_1[1], true)
end

function var_0_0.onTalentEffectShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = gohelper.findChildText(arg_20_1, "txt_desc")
	local var_20_1 = gohelper.findChild(arg_20_1, "txt_desc/go_selectFrame")
	local var_20_2 = gohelper.findChild(arg_20_1, "txt_desc/go_selectFrame_flash")
	local var_20_3 = gohelper.findChild(arg_20_1, "txt_desc/go_line")
	local var_20_4 = (arg_20_0.selectTalentMo and arg_20_0.selectTalentMo.level or 0) + 1

	var_20_0.text = SkillHelper.buildDesc(arg_20_2.nodeDesc)

	local var_20_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_0.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(var_20_0, arg_20_0._onHyperLinkClick, arg_20_0)
	var_20_5:refreshTmpContent(var_20_0)
	SLFramework.UGUI.GuiHelper.SetColor(var_20_0, var_20_4 <= arg_20_3 and "#5C5C5C" or "#BEB9A6")
	gohelper.setActive(var_20_1, arg_20_3 == var_20_4)
	gohelper.setActive(var_20_3, arg_20_3 ~= #arg_20_0.curTalentEffectCoList)
	gohelper.setActive(var_20_2, false)

	arg_20_0._talentSelectFrameFlashMap[arg_20_3] = var_20_2
end

function var_0_0.onTalentEffectFlashShow(arg_21_0)
	local var_21_0 = arg_21_0.selectTalentMo and arg_21_0.selectTalentMo.level or 0

	for iter_21_0, iter_21_1 in pairs(arg_21_0._talentSelectFrameFlashMap) do
		gohelper.setActive(iter_21_1, false)
		gohelper.setActive(iter_21_1, iter_21_0 == var_21_0)
	end
end

function var_0_0._onHyperLinkClick(arg_22_0, arg_22_1, arg_22_2)
	CommonBuffTipController.instance:openCommonTipView(tonumber(arg_22_1), arg_22_2)
end

function var_0_0.doTalentTreeScaleAnim(arg_23_0)
	arg_23_0._animTalentTree:Play(arg_23_0.curIsTreeSmallScale and "close" or "open", 0, 0)
	gohelper.setActive(arg_23_0._gotalentDetailTipView, true)

	if arg_23_0.curIsTreeSmallScale then
		arg_23_0._animPlayerDetailTip:Play("close", arg_23_0.hideTalentDetailTip, arg_23_0)
	else
		arg_23_0._animPlayerDetailTip:Play("open", nil, arg_23_0)
	end

	arg_23_0.curIsTreeSmallScale = not arg_23_0.curIsTreeSmallScale
end

function var_0_0.onTalentNodeSelect(arg_24_0)
	if arg_24_0.curIsTreeSmallScale then
		arg_24_0._animPlayerDetailTip:Play("open", nil, arg_24_0)
	end

	arg_24_0:refreshUI()
end

function var_0_0.hideTalentDetailTip(arg_25_0)
	gohelper.setActive(arg_25_0._gotalentDetailTipView, false)
end

function var_0_0.playTalentNodeLevelUpEffect(arg_26_0)
	for iter_26_0 = OdysseyEnum.TalentType.Hunter, OdysseyEnum.TalentType.Assassin do
		local var_26_0 = arg_26_0.talentTreeMap[iter_26_0]

		if not var_26_0 then
			return
		end

		local var_26_1 = var_26_0.talentNodeItemMap[arg_26_0.curSelectNodeId]

		if var_26_1 then
			var_26_1:playLevelUpEffect()

			break
		end
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_activate)
	arg_26_0._animTalentPoint:Play("click", 0, 0)
	arg_26_0._animTalentPoint:Update(0)
	arg_26_0:onTalentEffectFlashShow()
end

function var_0_0.onClose(arg_27_0)
	OdysseyTalentModel.instance:setCurselectNodeId(0)
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyTalentTreeView")
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

return var_0_0

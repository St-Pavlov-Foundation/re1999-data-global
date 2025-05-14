﻿module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTreeView", package.seeall)

local var_0_0 = class("TowerAssistBossTalentTreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goNode = gohelper.findChild(arg_1_0.viewGO, "Scroll/Viewport/Tree/node/#goNode")
	arg_1_0.goLine = gohelper.findChild(arg_1_0.viewGO, "Scroll/Viewport/Tree/line/#goLine")
	arg_1_0.nodeItems = {}
	arg_1_0.lineItems = {}
	arg_1_0.tempVect2 = Vector2(0, 0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_2_0._onResetTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_2_0._onActiveTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.SelectTalentItem, arg_2_0._onSelectTalentItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_3_0._onResetTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_3_0._onActiveTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.SelectTalentItem, arg_3_0._onSelectTalentItem, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onResetTalent(arg_5_0, arg_5_1)
	arg_5_0:refreshView()
end

function var_0_0._onActiveTalent(arg_6_0, arg_6_1)
	arg_6_0:playNodeLightingAnim(arg_6_1)
end

function var_0_0._onSelectTalentItem(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.nodeItems) do
		iter_7_1:refreshSelect()
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:refreshParam()
	TowerAssistBossTalentListModel.instance:initBoss(arg_9_0.bossId)
	arg_9_0:refreshView()
end

function var_0_0.refreshParam(arg_10_0)
	arg_10_0.bossId = arg_10_0.viewParam.bossId
	arg_10_0.bossMo = TowerAssistBossModel.instance:getBoss(arg_10_0.bossId)
	arg_10_0.talentTree = arg_10_0.bossMo:getTalentTree()
end

function var_0_0.refreshView(arg_11_0)
	arg_11_0:refreshTree()
end

function var_0_0.refreshTree(arg_12_0)
	local var_12_0 = arg_12_0.talentTree:getList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		arg_12_0:updateNode(iter_12_1)
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.nodeItems) do
		local var_12_1 = iter_12_3._mo:getParents()

		for iter_12_4, iter_12_5 in pairs(var_12_1) do
			if not iter_12_5:isRootNode() then
				arg_12_0:updateLineItem(iter_12_3._mo.nodeId, iter_12_5.nodeId)
			end
		end
	end
end

function var_0_0.updateNode(arg_13_0, arg_13_1)
	arg_13_0:getNodeItem(arg_13_1.id):onUpdateMO(arg_13_1)
end

function var_0_0.getNodeItem(arg_14_0, arg_14_1)
	if not arg_14_0.nodeItems[arg_14_1] then
		local var_14_0 = gohelper.cloneInPlace(arg_14_0.goNode, tostring(arg_14_1))
		local var_14_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_0, TowerAssistBossTalentItem)

		arg_14_0.nodeItems[arg_14_1] = var_14_1
	end

	return arg_14_0.nodeItems[arg_14_1]
end

function var_0_0.updateLineItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getLineItem(arg_15_1, arg_15_2)
	local var_15_1 = arg_15_0.talentTree:getNode(arg_15_1)
	local var_15_2 = arg_15_0.talentTree:getNode(arg_15_2)
	local var_15_3 = var_15_1:isActiveTalent()
	local var_15_4 = var_15_1:isActiveGroup()
	local var_15_5 = var_15_1:isParentActive()
	local var_15_6 = var_15_2:isActiveTalent()
	local var_15_7 = not var_15_3 and not var_15_4 and var_15_5 and var_15_6

	if var_15_7 then
		if var_15_0.isGray then
			var_15_0.anim:Play("tocanlight")
		else
			var_15_0.anim:Play("canlight")
		end
	elseif var_15_3 and var_15_6 then
		var_15_0.anim:Play("lighted")
	else
		var_15_0.anim:Play("gray")
	end

	var_15_0.isGray = not var_15_7 and not var_15_3 and not var_15_5
	var_15_0.isActive = var_15_3 and var_15_5

	arg_15_0:updateLineItemPos(var_15_0, arg_15_1, arg_15_2)

	return var_15_0
end

function var_0_0.updateLineItemPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0.nodeItems[arg_16_2]
	local var_16_1 = arg_16_0.nodeItems[arg_16_3]
	local var_16_2, var_16_3 = var_16_0:getLocalPos()
	local var_16_4 = var_16_0.transform.anchoredPosition
	local var_16_5 = var_16_1.transform.anchoredPosition
	local var_16_6 = var_16_0:getWidth()
	local var_16_7 = var_16_1:getWidth()
	local var_16_8 = Vector2.Distance(var_16_5, var_16_4)
	local var_16_9 = var_16_6 + var_16_8 * 0.5

	arg_16_0.tempVect2:Set(var_16_4.x - var_16_5.x, var_16_4.y - var_16_5.y)

	local var_16_10 = arg_16_0.tempVect2
	local var_16_11 = (var_16_4 + var_16_5) * 0.5

	recthelper.setAnchor(arg_16_1.transform, var_16_11.x, var_16_11.y)
	recthelper.setHeight(arg_16_1.imgLine.transform, var_16_8)
	recthelper.setHeight(arg_16_1.imgLine1.transform, var_16_8)

	local var_16_12 = Mathf.Atan2(var_16_10.y, var_16_10.x) * Mathf.Rad2Deg - 90

	transformhelper.setLocalRotation(arg_16_1.transform, 0, 0, var_16_12)
end

function var_0_0.getLineItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = string.format("%s_%s", arg_17_1, arg_17_2)

	if not arg_17_0.lineItems[var_17_0] then
		local var_17_1 = gohelper.cloneInPlace(arg_17_0.goLine, var_17_0)
		local var_17_2 = arg_17_0:getUserDataTb_()

		var_17_2.key = var_17_0
		var_17_2.go = var_17_1
		var_17_2.transform = var_17_1.transform
		var_17_2.imgLine = gohelper.findChildImage(var_17_1, "#go_Line")
		var_17_2.imgLine1 = gohelper.findChildImage(var_17_1, "Line1")
		var_17_2.anim = var_17_1:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(var_17_1, true)

		arg_17_0.lineItems[var_17_0] = var_17_2
	end

	return arg_17_0.lineItems[var_17_0]
end

function var_0_0.playNodeLightingAnim(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.talentTree:getNode(arg_18_1)

	if not var_18_0 then
		return
	end

	UIBlockMgr.instance:startBlock("playNodeLightingAnim")

	local var_18_1 = {}
	local var_18_2 = var_18_0:getParents()

	for iter_18_0, iter_18_1 in pairs(var_18_2) do
		if iter_18_1:isActiveTalent() then
			local var_18_3 = string.format("%s_%s", arg_18_1, iter_18_1.nodeId)
			local var_18_4 = arg_18_0.lineItems[var_18_3]

			if var_18_4 and not var_18_4.isActive then
				table.insert(var_18_1, var_18_4)
			end
		end
	end

	local var_18_5 = var_18_0.childs

	for iter_18_2, iter_18_3 in pairs(var_18_5) do
		if iter_18_3:isActiveTalent() then
			local var_18_6 = string.format("%s_%s", iter_18_3.nodeId, arg_18_1)
			local var_18_7 = arg_18_0.lineItems[var_18_6]

			if var_18_7 and not var_18_7.isActive then
				table.insert(var_18_1, var_18_7)
			end
		end
	end

	for iter_18_4, iter_18_5 in ipairs(var_18_1) do
		iter_18_5.isActive = true

		iter_18_5.anim:Play("lighting")
	end

	if #var_18_1 > 0 then
		arg_18_0.lightingNodeId = arg_18_1

		TaskDispatcher.runDelay(arg_18_0.delayLightNode, arg_18_0, 0.5)
	else
		arg_18_0:_lightingNode(arg_18_1)
	end
end

function var_0_0.delayLightNode(arg_19_0)
	arg_19_0:_lightingNode(arg_19_0.lightingNodeId)
end

function var_0_0._lightingNode(arg_20_0, arg_20_1)
	UIBlockMgr.instance:endBlock("playNodeLightingAnim")

	arg_20_0.lightingNodeId = nil

	local var_20_0 = arg_20_0.nodeItems[arg_20_1]

	if var_20_0 then
		var_20_0:playLightingAnim()
	end

	arg_20_0:delayRefreshView()
end

function var_0_0.delayRefreshView(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.refreshView, arg_21_0)
	TaskDispatcher.runDelay(arg_21_0.refreshView, arg_21_0, 0.5)
end

function var_0_0.onClose(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	UIBlockMgr.instance:endBlock("playNodeLightingAnim")
	TaskDispatcher.cancelTask(arg_23_0.delayLightNode, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.refreshView, arg_23_0)
end

return var_0_0

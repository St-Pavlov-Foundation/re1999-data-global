module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTreeView", package.seeall)

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
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_2_0._onRefreshTalent, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_3_0._onResetTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_3_0._onActiveTalent, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.SelectTalentItem, arg_3_0._onSelectTalentItem, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.RefreshTalent, arg_3_0._onRefreshTalent, arg_3_0)
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

function var_0_0._onRefreshTalent(arg_8_0)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshParam()
	arg_9_0:refreshView()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refreshParam()
	TowerAssistBossTalentListModel.instance:initBoss(arg_10_0.bossId)
	arg_10_0:refreshView()
end

function var_0_0.refreshParam(arg_11_0)
	arg_11_0.bossId = arg_11_0.viewParam.bossId
	arg_11_0.bossMo = TowerAssistBossModel.instance:getBoss(arg_11_0.bossId)
	arg_11_0.talentTree = arg_11_0.bossMo:getTalentTree()
end

function var_0_0.refreshView(arg_12_0)
	arg_12_0:refreshTree()
end

function var_0_0.refreshTree(arg_13_0)
	local var_13_0 = arg_13_0.talentTree:getList()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		arg_13_0:updateNode(iter_13_1)
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0.nodeItems) do
		local var_13_1 = iter_13_3._mo:getParents()

		for iter_13_4, iter_13_5 in pairs(var_13_1) do
			if not iter_13_5:isRootNode() then
				arg_13_0:updateLineItem(iter_13_3._mo.nodeId, iter_13_5.nodeId)
			end
		end
	end
end

function var_0_0.updateNode(arg_14_0, arg_14_1)
	arg_14_0:getNodeItem(arg_14_1.id):onUpdateMO(arg_14_1)
end

function var_0_0.getNodeItem(arg_15_0, arg_15_1)
	if not arg_15_0.nodeItems[arg_15_1] then
		local var_15_0 = gohelper.cloneInPlace(arg_15_0.goNode, tostring(arg_15_1))
		local var_15_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_0, TowerAssistBossTalentItem)

		arg_15_0.nodeItems[arg_15_1] = var_15_1
	end

	return arg_15_0.nodeItems[arg_15_1]
end

function var_0_0.updateLineItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getLineItem(arg_16_1, arg_16_2)
	local var_16_1 = arg_16_0.talentTree:getNode(arg_16_1)
	local var_16_2 = arg_16_0.talentTree:getNode(arg_16_2)
	local var_16_3 = var_16_1:isActiveTalent()
	local var_16_4 = var_16_1:isActiveGroup()
	local var_16_5 = var_16_1:isParentActive()
	local var_16_6 = var_16_2:isActiveTalent()
	local var_16_7 = arg_16_0.talentTree:isSelectedSystemTalentPlan()
	local var_16_8 = not var_16_3 and not var_16_4 and var_16_5 and var_16_6

	if var_16_8 and not var_16_7 then
		if var_16_0.isGray then
			var_16_0.anim:Play("tocanlight")
		else
			var_16_0.anim:Play("canlight")
		end
	elseif var_16_3 and var_16_6 then
		var_16_0.anim:Play("lighted")
	else
		var_16_0.anim:Play("gray")
	end

	var_16_0.isGray = not var_16_8 and not var_16_3 and not var_16_5
	var_16_0.isActive = var_16_3 and var_16_5

	arg_16_0:updateLineItemPos(var_16_0, arg_16_1, arg_16_2)

	return var_16_0
end

function var_0_0.updateLineItemPos(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0.nodeItems[arg_17_2]
	local var_17_1 = arg_17_0.nodeItems[arg_17_3]
	local var_17_2, var_17_3 = var_17_0:getLocalPos()
	local var_17_4 = var_17_0.transform.anchoredPosition
	local var_17_5 = var_17_1.transform.anchoredPosition
	local var_17_6 = var_17_0:getWidth()
	local var_17_7 = var_17_1:getWidth()
	local var_17_8 = Vector2.Distance(var_17_5, var_17_4)
	local var_17_9 = var_17_6 + var_17_8 * 0.5

	arg_17_0.tempVect2:Set(var_17_4.x - var_17_5.x, var_17_4.y - var_17_5.y)

	local var_17_10 = arg_17_0.tempVect2
	local var_17_11 = (var_17_4 + var_17_5) * 0.5

	recthelper.setAnchor(arg_17_1.transform, var_17_11.x, var_17_11.y)
	recthelper.setHeight(arg_17_1.imgLine.transform, var_17_8)
	recthelper.setHeight(arg_17_1.imgLine1.transform, var_17_8)

	local var_17_12 = Mathf.Atan2(var_17_10.y, var_17_10.x) * Mathf.Rad2Deg - 90

	transformhelper.setLocalRotation(arg_17_1.transform, 0, 0, var_17_12)
end

function var_0_0.getLineItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = string.format("%s_%s", arg_18_1, arg_18_2)

	if not arg_18_0.lineItems[var_18_0] then
		local var_18_1 = gohelper.cloneInPlace(arg_18_0.goLine, var_18_0)
		local var_18_2 = arg_18_0:getUserDataTb_()

		var_18_2.key = var_18_0
		var_18_2.go = var_18_1
		var_18_2.transform = var_18_1.transform
		var_18_2.imgLine = gohelper.findChildImage(var_18_1, "#go_Line")
		var_18_2.imgLine1 = gohelper.findChildImage(var_18_1, "Line1")
		var_18_2.anim = var_18_1:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(var_18_1, true)

		arg_18_0.lineItems[var_18_0] = var_18_2
	end

	return arg_18_0.lineItems[var_18_0]
end

function var_0_0.playNodeLightingAnim(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.talentTree:getNode(arg_19_1)

	if not var_19_0 then
		return
	end

	UIBlockMgr.instance:startBlock("playNodeLightingAnim")

	local var_19_1 = {}
	local var_19_2 = var_19_0:getParents()

	for iter_19_0, iter_19_1 in pairs(var_19_2) do
		if iter_19_1:isActiveTalent() then
			local var_19_3 = string.format("%s_%s", arg_19_1, iter_19_1.nodeId)
			local var_19_4 = arg_19_0.lineItems[var_19_3]

			if var_19_4 and not var_19_4.isActive then
				table.insert(var_19_1, var_19_4)
			end
		end
	end

	local var_19_5 = var_19_0.childs

	for iter_19_2, iter_19_3 in pairs(var_19_5) do
		if iter_19_3:isActiveTalent() then
			local var_19_6 = string.format("%s_%s", iter_19_3.nodeId, arg_19_1)
			local var_19_7 = arg_19_0.lineItems[var_19_6]

			if var_19_7 and not var_19_7.isActive then
				table.insert(var_19_1, var_19_7)
			end
		end
	end

	for iter_19_4, iter_19_5 in ipairs(var_19_1) do
		iter_19_5.isActive = true

		iter_19_5.anim:Play("lighting")
	end

	if #var_19_1 > 0 then
		arg_19_0.lightingNodeId = arg_19_1

		TaskDispatcher.runDelay(arg_19_0.delayLightNode, arg_19_0, 0.5)
	else
		arg_19_0:_lightingNode(arg_19_1)
	end
end

function var_0_0.delayLightNode(arg_20_0)
	arg_20_0:_lightingNode(arg_20_0.lightingNodeId)
end

function var_0_0._lightingNode(arg_21_0, arg_21_1)
	UIBlockMgr.instance:endBlock("playNodeLightingAnim")

	arg_21_0.lightingNodeId = nil

	local var_21_0 = arg_21_0.nodeItems[arg_21_1]

	if var_21_0 then
		var_21_0:playLightingAnim()
	end

	arg_21_0:delayRefreshView()
end

function var_0_0.delayRefreshView(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.refreshView, arg_22_0)
	TaskDispatcher.runDelay(arg_22_0.refreshView, arg_22_0, 0.5)
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	UIBlockMgr.instance:endBlock("playNodeLightingAnim")
	TaskDispatcher.cancelTask(arg_24_0.delayLightNode, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.refreshView, arg_24_0)
end

return var_0_0

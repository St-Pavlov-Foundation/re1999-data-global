module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTreeView", package.seeall)

slot0 = class("TowerAssistBossTalentTreeView", BaseView)

function slot0.onInitView(slot0)
	slot0.goNode = gohelper.findChild(slot0.viewGO, "Scroll/Viewport/Tree/node/#goNode")
	slot0.goLine = gohelper.findChild(slot0.viewGO, "Scroll/Viewport/Tree/line/#goLine")
	slot0.nodeItems = {}
	slot0.lineItems = {}
	slot0.tempVect2 = Vector2(0, 0)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, slot0._onResetTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, slot0._onActiveTalent, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.SelectTalentItem, slot0._onSelectTalentItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.ResetTalent, slot0._onResetTalent, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.ActiveTalent, slot0._onActiveTalent, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.SelectTalentItem, slot0._onSelectTalentItem, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onResetTalent(slot0, slot1)
	slot0:refreshView()
end

function slot0._onActiveTalent(slot0, slot1)
	slot0:playNodeLightingAnim(slot1)
end

function slot0._onSelectTalentItem(slot0)
	for slot4, slot5 in pairs(slot0.nodeItems) do
		slot5:refreshSelect()
	end
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	TowerAssistBossTalentListModel.instance:initBoss(slot0.bossId)
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.bossId = slot0.viewParam.bossId
	slot0.bossMo = TowerAssistBossModel.instance:getBoss(slot0.bossId)
	slot0.talentTree = slot0.bossMo:getTalentTree()
end

function slot0.refreshView(slot0)
	slot0:refreshTree()
end

function slot0.refreshTree(slot0)
	for slot5, slot6 in ipairs(slot0.talentTree:getList()) do
		slot0:updateNode(slot6)
	end

	for slot5, slot6 in pairs(slot0.nodeItems) do
		for slot11, slot12 in pairs(slot6._mo:getParents()) do
			if not slot12:isRootNode() then
				slot0:updateLineItem(slot6._mo.nodeId, slot12.nodeId)
			end
		end
	end
end

function slot0.updateNode(slot0, slot1)
	slot0:getNodeItem(slot1.id):onUpdateMO(slot1)
end

function slot0.getNodeItem(slot0, slot1)
	if not slot0.nodeItems[slot1] then
		slot0.nodeItems[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0.goNode, tostring(slot1)), TowerAssistBossTalentItem)
	end

	return slot0.nodeItems[slot1]
end

function slot0.updateLineItem(slot0, slot1, slot2)
	slot3 = slot0:getLineItem(slot1, slot2)
	slot4 = slot0.talentTree:getNode(slot1)

	if not slot4:isActiveTalent() and not slot4:isActiveGroup() and slot4:isParentActive() and slot0.talentTree:getNode(slot2):isActiveTalent() then
		if slot3.isGray then
			slot3.anim:Play("tocanlight")
		else
			slot3.anim:Play("canlight")
		end
	elseif slot6 and slot9 then
		slot3.anim:Play("lighted")
	else
		slot3.anim:Play("gray")
	end

	slot3.isGray = not slot10 and not slot6 and not slot8
	slot3.isActive = slot6 and slot8

	slot0:updateLineItemPos(slot3, slot1, slot2)

	return slot3
end

function slot0.updateLineItemPos(slot0, slot1, slot2, slot3)
	slot4 = slot0.nodeItems[slot2]
	slot5 = slot0.nodeItems[slot3]
	slot6, slot7 = slot4:getLocalPos()
	slot8 = slot4.transform.anchoredPosition
	slot9 = slot5.transform.anchoredPosition
	slot11 = slot5:getWidth()
	slot13 = Vector2.Distance(slot9, slot8)
	slot14 = slot4:getWidth() + slot13 * 0.5

	slot0.tempVect2:Set(slot8.x - slot9.x, slot8.y - slot9.y)

	slot15 = slot0.tempVect2
	slot16 = (slot8 + slot9) * 0.5

	recthelper.setAnchor(slot1.transform, slot16.x, slot16.y)
	recthelper.setHeight(slot1.imgLine.transform, slot13)
	recthelper.setHeight(slot1.imgLine1.transform, slot13)
	transformhelper.setLocalRotation(slot1.transform, 0, 0, Mathf.Atan2(slot15.y, slot15.x) * Mathf.Rad2Deg - 90)
end

function slot0.getLineItem(slot0, slot1, slot2)
	if not slot0.lineItems[string.format("%s_%s", slot1, slot2)] then
		slot4 = gohelper.cloneInPlace(slot0.goLine, slot3)
		slot5 = slot0:getUserDataTb_()
		slot5.key = slot3
		slot5.go = slot4
		slot5.transform = slot4.transform
		slot5.imgLine = gohelper.findChildImage(slot4, "#go_Line")
		slot5.imgLine1 = gohelper.findChildImage(slot4, "Line1")
		slot5.anim = slot4:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(slot4, true)

		slot0.lineItems[slot3] = slot5
	end

	return slot0.lineItems[slot3]
end

function slot0.playNodeLightingAnim(slot0, slot1)
	if not slot0.talentTree:getNode(slot1) then
		return
	end

	UIBlockMgr.instance:startBlock("playNodeLightingAnim")

	for slot8, slot9 in pairs(slot2:getParents()) do
		if slot9:isActiveTalent() and slot0.lineItems[string.format("%s_%s", slot1, slot9.nodeId)] and not slot11.isActive then
			table.insert({}, slot11)
		end
	end

	for slot9, slot10 in pairs(slot2.childs) do
		if slot10:isActiveTalent() and slot0.lineItems[string.format("%s_%s", slot10.nodeId, slot1)] and not slot12.isActive then
			table.insert(slot3, slot12)
		end
	end

	for slot9, slot10 in ipairs(slot3) do
		slot10.isActive = true

		slot10.anim:Play("lighting")
	end

	if #slot3 > 0 then
		slot0.lightingNodeId = slot1

		TaskDispatcher.runDelay(slot0.delayLightNode, slot0, 0.5)
	else
		slot0:_lightingNode(slot1)
	end
end

function slot0.delayLightNode(slot0)
	slot0:_lightingNode(slot0.lightingNodeId)
end

function slot0._lightingNode(slot0, slot1)
	UIBlockMgr.instance:endBlock("playNodeLightingAnim")

	slot0.lightingNodeId = nil

	if slot0.nodeItems[slot1] then
		slot2:playLightingAnim()
	end

	slot0:delayRefreshView()
end

function slot0.delayRefreshView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshView, slot0)
	TaskDispatcher.runDelay(slot0.refreshView, slot0, 0.5)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("playNodeLightingAnim")
	TaskDispatcher.cancelTask(slot0.delayLightNode, slot0)
	TaskDispatcher.cancelTask(slot0.refreshView, slot0)
end

return slot0

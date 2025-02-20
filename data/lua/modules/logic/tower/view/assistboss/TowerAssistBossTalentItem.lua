module("modules.logic.tower.view.assistboss.TowerAssistBossTalentItem", package.seeall)

slot0 = class("TowerAssistBossTalentItem", ListScrollCellExtend)
slot1 = 0
slot2 = -385

function slot0.onInitView(slot0)
	slot0.transform = slot0.viewGO.transform
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.imgTalent = gohelper.findChildImage(slot0.viewGO, "btn/image_BG")
	slot0.goSelect = gohelper.findChild(slot0.viewGO, "btn/goSelect")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn")
	slot0.bigEff = gohelper.findChild(slot0.viewGO, "btn/btneff_big")
	slot0.smallEff = gohelper.findChild(slot0.viewGO, "btn/btneff_small")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onBtnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnClick)
end

function slot0._editableInitView(slot0)
end

function slot0.onBtnClick(slot0)
	if not slot0._mo then
		return
	end

	TowerAssistBossTalentListModel.instance:setSelectTalent(slot0._mo.id)
end

function slot0.onUpdateMO(slot0, slot1)
	gohelper.setActive(slot0.viewGO, true)

	slot0._mo = slot1
	slot0.isBigNode = slot0._mo.config.isBigNode == 1

	slot0:refreshNode()
	slot0:refreshState()
	slot0:refreshSelect()
end

function slot0.refreshNode(slot0)
	if not slot0._mo then
		return
	end

	TowerConfig.instance:setTalentImg(slot0.imgTalent, slot0._mo.config, true)

	slot1, slot2 = slot0:getNodePos()

	recthelper.setAnchor(slot0.transform, slot1, slot2)

	slot3 = slot0.isBigNode and 1.2 or 0.6

	transformhelper.setLocalScale(slot0.goSelect.transform, slot3, slot3, 1)

	slot4 = 1

	if slot0.isBigNode and not slot0._mo:isRootNode() then
		slot4 = 0.7
	end

	transformhelper.setLocalScale(slot0.transform, slot4, slot4, 1)
end

function slot0.getWidth(slot0)
	if not slot0._mo then
		return 0
	end

	return slot0.isBigNode and 72 or 24
end

function slot0.getLocalPos(slot0)
	slot1, slot2 = recthelper.getAnchor(slot0.transform)

	return slot1 - uv0, slot2 - uv1
end

function slot0.refreshState(slot0)
	if not slot0._mo then
		return
	end

	slot1 = slot0._mo

	if not slot1:isActiveTalent() and not slot1:isActiveGroup() and slot1:isParentActive() then
		if slot0.isGray then
			slot0.anim:Play("tocanlight")
		else
			slot0.anim:Play("canlight")
		end

		slot0.isGray = false
	elseif slot2 then
		if not slot0.isLighted then
			slot0.anim:Play("lighted")
		end

		slot0.isGray = false
	else
		slot0.anim:Play("gray")

		slot0.isGray = true
	end

	slot0.isLighted = slot2

	gohelper.setActive(slot0.bigEff, slot2 and slot0.isBigNode)
	gohelper.setActive(slot0.smallEff, slot2 and not slot0.isBigNode)
end

function slot0.refreshSelect(slot0)
	if not slot0._mo then
		return
	end

	gohelper.setActive(slot0.goSelect, TowerAssistBossTalentListModel.instance:isSelectTalent(slot0._mo.id))
end

function slot0.getNodePos(slot0)
	slot2 = string.splitToNumber(slot0._mo.config.position, "#") or {}
	slot3 = slot2[1] or 0
	slot5 = math.rad(slot2[2] or 0)

	return slot3 * math.cos(slot5) + uv0, slot3 * math.sin(slot5) + uv1
end

function slot0.playLightingAnim(slot0)
	slot0.isLighted = true

	slot0.anim:Play("lighting")
	gohelper.setActive(slot0.bigEff, slot0.isBigNode)
	gohelper.setActive(slot0.smallEff, not slot0.isBigNode)
end

function slot0.onDestroyView(slot0)
end

return slot0

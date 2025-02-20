module("modules.logic.dungeon.view.rolestory.RoleStoryItemRewardView", package.seeall)

slot0 = class("RoleStoryItemRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0.goRewardPanel = gohelper.findChild(slot0.viewGO, "goRewardPanel")
	slot0.btnclose = gohelper.findChildButtonWithAudio(slot0.goRewardPanel, "btnclose")
	slot0.goNode = gohelper.findChild(slot0.goRewardPanel, "#go_node")
	slot0.rewardContent = gohelper.findChild(slot0.goRewardPanel, "#go_node/Content")
	slot0.rewardItems = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnclose:AddClickListener(slot0.onClickClose, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, slot0.showReward, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnclose:RemoveClickListener()
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, slot0.showReward, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClickClose(slot0)
	gohelper.setActive(slot0.goRewardPanel, false)
end

function slot0.showReward(slot0, slot1, slot2, slot3, slot4)
	if not slot1 then
		slot0:onClickClose()

		return
	end

	transformhelper.setPos(slot0.goNode.transform, slot2, slot3, slot4)
	gohelper.setActive(slot0.goRewardPanel, true)

	slot9 = #slot1.rewards

	for slot9 = 1, math.max(slot9, #slot0.rewardItems) do
		slot11 = slot5[slot9]

		if not slot0.rewardItems[slot9] then
			slot10 = IconMgr.instance:getCommonItemIcon(slot0.rewardContent)
			slot0.rewardItems[slot9] = slot10

			transformhelper.setLocalScale(slot10.tr, 0.5, 0.5, 1)
		end

		if slot11 then
			gohelper.setActive(slot10.go, true)
			slot10:setMOValue(slot11[1], slot11[2], slot11[3])
			slot10:setCountFontSize(42)
		else
			gohelper.setActive(slot10.go, false)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.rewardItems then
		for slot4, slot5 in pairs(slot0.rewardItems) do
			slot5:onDestroy()
		end

		slot0.rewardItems = nil
	end
end

return slot0

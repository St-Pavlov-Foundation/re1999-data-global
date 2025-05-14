module("modules.logic.dungeon.view.rolestory.RoleStoryItemRewardView", package.seeall)

local var_0_0 = class("RoleStoryItemRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRewardPanel = gohelper.findChild(arg_1_0.viewGO, "goRewardPanel")
	arg_1_0.btnclose = gohelper.findChildButtonWithAudio(arg_1_0.goRewardPanel, "btnclose")
	arg_1_0.goNode = gohelper.findChild(arg_1_0.goRewardPanel, "#go_node")
	arg_1_0.rewardContent = gohelper.findChild(arg_1_0.goRewardPanel, "#go_node/Content")
	arg_1_0.rewardItems = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnclose:AddClickListener(arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, arg_2_0.showReward, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, arg_3_0.showReward, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0.onClickClose(arg_6_0)
	gohelper.setActive(arg_6_0.goRewardPanel, false)
end

function var_0_0.showReward(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if not arg_7_1 then
		arg_7_0:onClickClose()

		return
	end

	transformhelper.setPos(arg_7_0.goNode.transform, arg_7_2, arg_7_3, arg_7_4)
	gohelper.setActive(arg_7_0.goRewardPanel, true)

	local var_7_0 = arg_7_1.rewards

	for iter_7_0 = 1, math.max(#var_7_0, #arg_7_0.rewardItems) do
		local var_7_1 = arg_7_0.rewardItems[iter_7_0]
		local var_7_2 = var_7_0[iter_7_0]

		if not var_7_1 then
			var_7_1 = IconMgr.instance:getCommonItemIcon(arg_7_0.rewardContent)
			arg_7_0.rewardItems[iter_7_0] = var_7_1

			transformhelper.setLocalScale(var_7_1.tr, 0.5, 0.5, 1)
		end

		if var_7_2 then
			gohelper.setActive(var_7_1.go, true)
			var_7_1:setMOValue(var_7_2[1], var_7_2[2], var_7_2[3])
			var_7_1:setCountFontSize(42)
		else
			gohelper.setActive(var_7_1.go, false)
		end
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	if arg_9_0.rewardItems then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.rewardItems) do
			iter_9_1:onDestroy()
		end

		arg_9_0.rewardItems = nil
	end
end

return var_0_0

module("modules.logic.dungeon.view.DungeonElementRewardView", package.seeall)

local var_0_0 = class("DungeonElementRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._goreward0 = gohelper.findChild(arg_1_0.viewGO, "reward/#go_reward0")
	arg_1_0._gocontent0 = gohelper.findChild(arg_1_0.viewGO, "reward/#go_reward0/#go_content0")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:showReward(arg_6_0._gocontent0, arg_6_0.viewParam)
end

function var_0_0.showReward(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 80
	local var_7_1 = 205

	recthelper.setWidth(arg_7_1.transform, #arg_7_2 * var_7_1 + 20)

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		local var_7_2 = gohelper.clone(arg_7_0._goitem, arg_7_1)

		gohelper.setActive(var_7_2, true)
		recthelper.setAnchor(var_7_2.transform, var_7_0 + var_7_1 * (iter_7_0 - 1), -75)

		local var_7_3 = gohelper.findChild(var_7_2, "itemicon")
		local var_7_4 = IconMgr.instance:getCommonPropItemIcon(var_7_3)
		local var_7_5 = gohelper.findChild(var_7_2.gameObject, "countbg")

		var_7_4:setMOValue(iter_7_1[1], iter_7_1[2], iter_7_1[3], nil, true)
		var_7_4:isShowCount(true)
		var_7_4:hideEquipLvAndBreak(true)
		var_7_4:setHideLvAndBreakFlag(true)
		var_7_4:setCountFontSize(40)
		var_7_4:SetCountLocalY(43.6)
		var_7_4:SetCountBgHeight(30)
		var_7_4:SetCountBgScale(1, 1.3, 1)
		var_7_4:setHideLvAndBreakFlag(true)
		var_7_4:hideEquipLvAndBreak(true)
		var_7_4._itemIcon:setJumpFinishCallback(arg_7_0.jumpFinishCallback, arg_7_0)
		gohelper.setActive(var_7_5, false)
	end
end

function var_0_0.jumpFinishCallback(arg_8_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function var_0_0.onClose(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0

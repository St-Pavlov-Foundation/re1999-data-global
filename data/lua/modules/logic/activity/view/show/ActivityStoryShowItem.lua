module("modules.logic.activity.view.show.ActivityStoryShowItem", package.seeall)

local var_0_0 = class("ActivityStoryShowItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._config = arg_1_3
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.go, "txt_taskdesc")
	arg_1_0._goRewardContent = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/go_rewardContent")
	arg_1_0._goRewardItem = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/go_rewardContent/go_rewarditem")
	arg_1_0._goItemPos = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/go_rewardContent/go_rewarditem/itempos")
	arg_1_0._goline = gohelper.findChild(arg_1_0.go, "go_line")

	arg_1_0:addEvents()
	arg_1_0:_refreshItem()
end

var_0_0.ShowCount = 1

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._refreshItem(arg_4_0)
	arg_4_0._txtdesc.text = arg_4_0._config.taskDesc
	arg_4_0._rewardItems = arg_4_0:getUserDataTb_()

	local var_4_0 = string.split(arg_4_0._config.showBonus, "|")

	arg_4_0._goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_4_0 > 2

	for iter_4_0 = 1, #var_4_0 do
		if not arg_4_0._rewardItems[iter_4_0] then
			local var_4_1 = arg_4_0:getUserDataTb_()

			var_4_1.parentGo = gohelper.cloneInPlace(arg_4_0._goRewardItem)
			var_4_1.itemPos = gohelper.findChild(var_4_1.parentGo, "itempos")
			var_4_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_4_1.itemPos)

			table.insert(arg_4_0._rewardItems, var_4_1)
		end

		gohelper.setActive(arg_4_0._rewardItems[iter_4_0].parentGo, true)

		local var_4_2 = string.splitToNumber(var_4_0[iter_4_0], "#")

		arg_4_0._rewardItems[iter_4_0].itemIcon:setMOValue(var_4_2[1], var_4_2[2], var_4_2[3], nil, true)
		arg_4_0._rewardItems[iter_4_0].itemIcon:isShowCount(var_4_2[4] == var_0_0.ShowCount)
		arg_4_0._rewardItems[iter_4_0].itemIcon:setCountFontSize(56)
		arg_4_0._rewardItems[iter_4_0].itemIcon:setHideLvAndBreakFlag(true)
		arg_4_0._rewardItems[iter_4_0].itemIcon:hideEquipLvAndBreak(true)
	end

	for iter_4_1 = #var_4_0 + 1, #arg_4_0._rewardItems do
		gohelper.setActive(arg_4_0._rewardItems[iter_4_1].parentGo, false)
	end

	gohelper.setActive(arg_4_0._goline, arg_4_0._index ~= GameUtil.getTabLen(ActivityConfig.instance:getActivityShowTaskCount(ActivityEnum.Activity.StoryShow)))
end

function var_0_0.destroy(arg_5_0)
	arg_5_0:removeEvents()

	arg_5_0._rewardItems = nil
end

return var_0_0

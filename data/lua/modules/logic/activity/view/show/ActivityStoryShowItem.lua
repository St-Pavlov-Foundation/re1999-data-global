module("modules.logic.activity.view.show.ActivityStoryShowItem", package.seeall)

slot0 = class("ActivityStoryShowItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.go = slot1
	slot0._index = slot2
	slot0._config = slot3
	slot0._txtdesc = gohelper.findChildText(slot0.go, "txt_taskdesc")
	slot0._goRewardContent = gohelper.findChild(slot0.go, "scroll_reward/Viewport/go_rewardContent")
	slot0._goRewardItem = gohelper.findChild(slot0.go, "scroll_reward/Viewport/go_rewardContent/go_rewarditem")
	slot0._goItemPos = gohelper.findChild(slot0.go, "scroll_reward/Viewport/go_rewardContent/go_rewarditem/itempos")
	slot0._goline = gohelper.findChild(slot0.go, "go_line")

	slot0:addEvents()
	slot0:_refreshItem()
end

slot0.ShowCount = 1

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._refreshItem(slot0)
	slot0._txtdesc.text = slot0._config.taskDesc
	slot0._rewardItems = slot0:getUserDataTb_()
	slot0._goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #string.split(slot0._config.showBonus, "|") > 2

	for slot5 = 1, #slot1 do
		if not slot0._rewardItems[slot5] then
			slot6 = slot0:getUserDataTb_()
			slot6.parentGo = gohelper.cloneInPlace(slot0._goRewardItem)
			slot6.itemPos = gohelper.findChild(slot6.parentGo, "itempos")
			slot6.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot6.itemPos)

			table.insert(slot0._rewardItems, slot6)
		end

		gohelper.setActive(slot0._rewardItems[slot5].parentGo, true)

		slot7 = string.splitToNumber(slot1[slot5], "#")

		slot0._rewardItems[slot5].itemIcon:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
		slot0._rewardItems[slot5].itemIcon:isShowCount(slot7[4] == uv0.ShowCount)
		slot0._rewardItems[slot5].itemIcon:setCountFontSize(56)
		slot0._rewardItems[slot5].itemIcon:setHideLvAndBreakFlag(true)
		slot0._rewardItems[slot5].itemIcon:hideEquipLvAndBreak(true)
	end

	for slot5 = #slot1 + 1, #slot0._rewardItems do
		gohelper.setActive(slot0._rewardItems[slot5].parentGo, false)
	end

	gohelper.setActive(slot0._goline, slot0._index ~= GameUtil.getTabLen(ActivityConfig.instance:getActivityShowTaskCount(ActivityEnum.Activity.StoryShow)))
end

function slot0.destroy(slot0)
	slot0:removeEvents()

	slot0._rewardItems = nil
end

return slot0

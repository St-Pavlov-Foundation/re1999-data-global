module("modules.logic.voyage.view.ActivityGiftForTheVoyageItem", package.seeall)

slot0 = class("ActivityGiftForTheVoyageItem", ActivityGiftForTheVoyageItemBase)

function slot0.onInitView(slot0)
	slot0._txttaskdesc = gohelper.findChildText(slot0.viewGO, "#txt_taskdesc")
	slot0._gotxttaskdesc1 = gohelper.findChild(slot0.viewGO, "#go_txt_taskdesc1")
	slot0._gotxttaskdesc2 = gohelper.findChild(slot0.viewGO, "#go_txt_taskdesc2")
	slot0._gotxttaskdesc3 = gohelper.findChild(slot0.viewGO, "#go_txt_taskdesc3")
	slot0._txttaskdesc_client = gohelper.findChildText(slot0.viewGO, "#txt_taskdesc_client")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_line")
	slot0._scrollRewards = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_Rewards")
	slot0._goRewards = gohelper.findChild(slot0.viewGO, "#scroll_Rewards/Viewport/#go_Rewards")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#scroll_Rewards/Viewport/#go_Rewards/#go_Item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onRefresh(slot0)
	slot2 = slot0._mo.id
	slot3 = VoyageModel.instance:getStateById(slot2)

	gohelper.setActive(slot0._gotxttaskdesc1, slot2 > 0 and slot3 == VoyageEnum.State.Got)
	gohelper.setActive(slot0._gotxttaskdesc2, slot2 > 0 and slot3 == VoyageEnum.State.Available)
	gohelper.setActive(slot0._gotxttaskdesc3, slot2 > 0 and slot3 == VoyageEnum.State.None)

	slot0._txttaskdesc.text = slot2 > 0 and slot1.desc or ""
	slot0._txttaskdesc_client.text = slot2 > 0 and "" or slot1.desc

	slot0:_refreshRewards()

	slot0._scrollRewards.horizontalNormalizedPosition = 0
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	uv0.super._onRewardItemShow(slot0, slot1, slot2, slot3)
	slot1:setGetMask(true)
end

function slot0.setActiveLine(slot0, slot1)
	gohelper.setActive(slot0._goline, slot1)
end

function slot0._isGot(slot0)
	return VoyageModel.instance:getStateById(slot0._mo.id) == VoyageEnum.State.Got
end

function slot0._createItemList(slot0)
	if slot0._itemList then
		return
	end

	gohelper.setActive(slot0._goitem, true)

	slot0._itemList = {}

	for slot7, slot8 in ipairs(VoyageConfig.instance:getRewardStrList(slot0._mo.id)) do
		slot10 = slot0:_createRewardItem(ActivityGiftForTheVoyageItemRewardItem)

		table.insert(slot0._itemList, slot10)
		slot10:refreshRewardItem(string.splitToNumber(slot8, "#"), slot0:_isGot())
	end

	gohelper.setActive(slot0._goitem, false)
end

function slot0._createRewardItem(slot0, slot1)
	return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goitem, slot1.__name), slot1)
end

function slot0._refreshRewards(slot0)
	slot0:_createItemList()
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")
end

return slot0

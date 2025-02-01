module("modules.logic.voyage.view.ActivityGiftForTheVoyageItemRewardItem", package.seeall)

slot0 = class("ActivityGiftForTheVoyageItemRewardItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_item")
	slot0._gohasGet = gohelper.findChild(slot0.viewGO, "#go_hasGet")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gohasGet, false)

	slot0._item = IconMgr.instance:getCommonItemIcon(slot0._goitem)
end

function slot0.refreshRewardItem(slot0, slot1, slot2)
	slot3 = slot0._item

	slot3:setMOValue(slot1[1], slot1[2], slot1[3], nil, true)
	slot3:setConsume(true)
	slot3:isShowEffect(true)
	slot3:setAutoPlay(true)
	slot3:setCountFontSize(48)
	slot3:showStackableNum2()
	slot3:setGetMask(slot2)
	gohelper.setActive(slot0._gohasGet, slot2)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_item")
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

return slot0

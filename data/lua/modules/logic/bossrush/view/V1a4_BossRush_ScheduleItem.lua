module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleItem", package.seeall)

slot0 = class("V1a4_BossRush_ScheduleItem", LuaCompBase)
slot1 = string.split
slot2 = string.splitToNumber

function slot0.init(slot0, slot1)
	slot0._goBg = gohelper.findChildImage(slot1, "#go_Bg")
	slot0._imageStatus = gohelper.findChildImage(slot1, "verticalLayout/#image_Status")
	slot0._txtPointValue = gohelper.findChildText(slot1, "verticalLayout/#image_Status/#txt_PointValue")

	slot0:_initItems(slot1)

	slot0._txtPointValue.text = ""

	gohelper.setActive(slot0._goBg, false)
end

function slot0._initItems(slot0, slot1)
	slot0._itemList = {}
	slot3 = gohelper.findChild(slot1, "verticalLayout/item" .. 1)
	slot4 = V1a4_BossRush_ScheduleItemRewardItem

	while not gohelper.isNil(slot3) do
		slot0._itemList[slot2] = MonoHelper.addNoUpdateLuaComOnceToGo(slot3, slot4)
		slot3 = gohelper.findChild(slot1, "verticalLayout/item" .. slot2 + 1)
	end
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1

	slot0:_refresh()
	slot0:_playOpen()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._playOpenInner, slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")
end

function slot0._refresh(slot0)
	slot3 = slot0._mo.stageRewardCO.display > 0
	slot4 = uv0(slot2.reward, "|")

	for slot8, slot9 in ipairs(slot0._itemList) do
		slot9:setActive(false)
	end

	for slot8, slot9 in ipairs(slot4) do
		if slot0._itemList[slot8] then
			slot11:setData(uv1(slot9, "#"))
			slot11:setActive(true)
		end
	end

	UISpriteSetMgr.instance:setV1a4BossRushSprite(slot0._imageStatus, BossRushConfig.instance:getRewardStatusSpriteName(slot3, slot0:_isGot()))
	gohelper.setActive(slot0._goBg, slot3)

	slot0._txtPointValue.text = slot2.rewardPointNum

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtPointValue, slot0:_isGot() and BossRushEnum.Color.POINTVALUE_GOT or BossRushEnum.Color.POINTVALUE_NORMAL)
end

function slot0.refreshByDisplayTarget(slot0, slot1)
	slot0._mo = slot1
	slot0._index = slot1._index

	slot0:_refresh()
	gohelper.setActive(slot0._goBg, false)
end

function slot0._isNewGot(slot0)
	slot2 = V1a4_BossRush_ScheduleViewListModel.instance:getStaticData()

	return slot2.fromIndex <= slot0._index and slot1 <= slot2.toIndex
end

function slot0._isAlreadyGot(slot0)
	return slot0._mo.isGot or slot0._index < V1a4_BossRush_ScheduleViewListModel.instance:getStaticData().fromIndex
end

function slot0._isGot(slot0)
	return slot0:_isAlreadyGot() or slot0:_isNewGot()
end

function slot0._playOpen(slot0)
	if slot0:_isGot() then
		TaskDispatcher.runDelay(slot0._playOpenInner, slot0, 0.1 + (slot0._index - V1a4_BossRush_ScheduleViewListModel.instance:getStaticData().fromIndex) * 0.02)
	end
end

slot3 = BossRushEnum.AnimScheduleItemRewardItem
slot4 = BossRushEnum.AnimScheduleItemRewardItem_HasGet

function slot0._playOpenInner(slot0)
	for slot4, slot5 in ipairs(slot0._itemList) do
		if slot0:_isNewGot() then
			slot5:playAnim(uv0.ReceiveEnter)
			slot5:playAnim_HasGet(uv1.Got)
		else
			slot5:playAnim(slot0:_isGot() and uv0.Got or uv0.Idle)
		end
	end
end

return slot0

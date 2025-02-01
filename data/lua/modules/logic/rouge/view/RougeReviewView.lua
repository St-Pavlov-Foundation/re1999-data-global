module("modules.logic.rouge.view.RougeReviewView", package.seeall)

slot0 = class("RougeReviewView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content")
	slot0._goMask = gohelper.findChild(slot0.viewGO, "#go_Mask")
	slot0._simageMask = gohelper.findChildSingleImage(slot0.viewGO, "#go_Mask/#simage_Mask")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "#go_Mask/#txt_Tips")
	slot0._goLeftTop = gohelper.findChild(slot0.viewGO, "#go_LeftTop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._initStoryStatus(slot0)
	slot0._unlockStageId = 0

	for slot5, slot6 in ipairs(RougeFavoriteConfig.instance:getStoryList()) do
		if slot0:_sotryListIsPass(slot6.storyIdList) then
			slot0._unlockStageId = slot6.config.stageId
		end
	end
end

function slot0._sotryListIsPass(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if RougeOutsideModel.instance:storyIsPass(slot6) then
			return true
		end
	end
end

function slot0._initStoryItems(slot0)
	slot1 = RougeFavoriteConfig.instance:getStoryList()
	slot0.storyList = slot1
	slot2 = slot0.viewContainer:getSetting().otherRes[1]
	slot3 = 1
	slot4 = #slot1
	slot5 = false

	while slot3 <= slot4 do
		slot6 = slot3
		slot7 = slot1[slot3]
		slot8, slot9 = slot0:_findNextSameStageStory(slot3, slot1)
		slot10 = slot0:_getStoryItem(slot3, slot2)
		slot9 = slot9 or {
			slot1[slot3 + 1]
		}

		if slot8 then
			slot3 = slot8
		end

		slot10.item:setMaxUnlockStateId(slot0._unlockStageId)
		slot10.item:onUpdateMO(slot7, slot4 < slot3 + 1, slot0, slot9, slot2)

		if not slot10.item:isUnlock() then
			slot5 = false

			break
		end

		slot0._lastNodeIndex = slot6
	end

	gohelper.setActive(slot0._goMask, not slot5)

	slot0._isEnd = slot5
	slot0._lastNodeIndex = slot0._lastNodeIndex or 1
end

function slot0._getStoryItem(slot0, slot1, slot2)
	if not slot0._storyItemList[slot1] then
		slot3 = {
			go = slot0:getResInst(slot2, slot0._gocontent, "item" .. slot1)
		}
		slot3.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot3.go, RougeReviewItem)

		slot3.item:setIndex(slot1)
		table.insert(slot0._storyItemList, slot3)
	end

	return slot3
end

function slot0._findNextSameStageStory(slot0, slot1, slot2)
	slot4 = slot2[slot1 + 2]

	if slot2[slot1 + 1] and slot4 and slot3.config.stageId == slot4.config.stageId then
		return slot1 + 2, {
			slot3,
			slot4
		}
	end
end

function slot0._editableInitView(slot0)
	slot0._initX = 220
	slot0._initY = -450
	slot0._itemContentWidth = 700
	slot0._itemIconWidth = 400
	slot0._storyItemList = slot0:getUserDataTb_()
	slot0._horizontalLayoutGroup = slot0._gocontent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
end

function slot0._resetPos(slot0)
	slot0._rootWidth = recthelper.getWidth(slot0.viewGO.transform)
	slot0._viewportWidth = recthelper.getWidth(slot0._scrollview.transform)
	slot0._curViewportWidth = slot0._viewportWidth
	slot1 = (slot0._lastNodeIndex - 1) * slot0._itemContentWidth + slot0._itemIconWidth

	if slot0._isEnd then
		slot1 = slot1 + math.max(slot0._viewportWidth - slot1, 0) + slot0._itemContentWidth + slot0._itemIconWidth
	end

	for slot6, slot7 in ipairs(slot0._storyItemList) do
		recthelper.setAnchor(slot7.go.transform, (slot6 - 1) * slot0._itemContentWidth + slot0._initX + slot2, slot0._initY)
	end

	recthelper.setWidth(slot0._gocontent.transform, slot1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_initStoryStatus()
	slot0:_initStoryItems()

	if not slot0._isEnd then
		slot1 = slot0._scrollview.transform.offsetMax
		slot1.x = -670
		slot0._scrollview.transform.offsetMax = slot1
	end

	slot0:_resetPos()

	slot0._scrollview.horizontalNormalizedPosition = 1
	slot0._scrollX = 1

	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio2)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
	slot0._scrollview:AddOnValueChanged(slot0._onScrollRectValueChanged, slot0)
end

function slot0._onScrollRectValueChanged(slot0, slot1, slot2)
	if slot0._curViewportWidth == recthelper.getWidth(slot0._scrollview.transform) then
		slot0._scrollX = slot1
	end
end

function slot0._onScreenSizeChange(slot0)
	slot0:_resetPos()

	slot0._scrollview.horizontalNormalizedPosition = slot0._scrollX
end

function slot0.onClose(slot0)
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Story) > 0 then
		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(RougeOutsideModel.instance:season(), RougeEnum.FavoriteType.Story, 0)
	end

	slot0._scrollview:RemoveOnValueChanged()
end

function slot0.onDestroyView(slot0)
end

return slot0

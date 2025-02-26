module("modules.logic.dungeon.view.DungeonElementRewardView", package.seeall)

slot0 = class("DungeonElementRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_item")
	slot0._goreward0 = gohelper.findChild(slot0.viewGO, "reward/#go_reward0")
	slot0._gocontent0 = gohelper.findChild(slot0.viewGO, "reward/#go_reward0/#go_content0")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:showReward(slot0._gocontent0, slot0.viewParam)
end

function slot0.showReward(slot0, slot1, slot2)
	recthelper.setWidth(slot1.transform, #slot2 * 205 + 20)

	for slot8, slot9 in ipairs(slot2) do
		slot10 = gohelper.clone(slot0._goitem, slot1)

		gohelper.setActive(slot10, true)
		recthelper.setAnchor(slot10.transform, 80 + slot4 * (slot8 - 1), -75)

		slot12 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot10, "itemicon"))

		slot12:setMOValue(slot9[1], slot9[2], slot9[3], nil, true)
		slot12:isShowCount(true)
		slot12:hideEquipLvAndBreak(true)
		slot12:setHideLvAndBreakFlag(true)
		slot12:setCountFontSize(40)
		slot12:SetCountLocalY(43.6)
		slot12:SetCountBgHeight(30)
		slot12:SetCountBgScale(1, 1.3, 1)
		slot12:setHideLvAndBreakFlag(true)
		slot12:hideEquipLvAndBreak(true)
		slot12._itemIcon:setJumpFinishCallback(slot0.jumpFinishCallback, slot0)
		gohelper.setActive(gohelper.findChild(slot10.gameObject, "countbg"), false)
	end
end

function slot0.jumpFinishCallback(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
end

function slot0.onDestroyView(slot0)
end

return slot0

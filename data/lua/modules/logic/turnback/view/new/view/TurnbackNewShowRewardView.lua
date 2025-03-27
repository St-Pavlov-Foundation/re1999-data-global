module("modules.logic.turnback.view.new.view.TurnbackNewShowRewardView", package.seeall)

slot0 = class("TurnbackNewShowRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "reward/#scroll_reward")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "reward/#scroll_reward/Viewport/#go_content")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._rewardItemList = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.bonus = slot0.viewParam.bonus

	slot0:_refreshReward()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
end

function slot0._refreshReward(slot0)
	for slot5, slot6 in ipairs(GameUtil.splitString2(slot0.bonus, true)) do
		slot7 = slot0:getUserDataTb_()
		slot7.go = gohelper.cloneInPlace(slot0._gorewarditem, "item" .. slot5)

		gohelper.setActive(slot7.go, true)

		slot8 = slot6[1]
		slot9 = slot6[2]
		slot10 = slot6[3]

		if not slot7.itemIcon then
			slot7.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot7.go)
		end

		slot7.itemIcon:setMOValue(slot8, slot9, slot10, nil, true)
		slot7.itemIcon:isShowQuality(true)
		slot7.itemIcon:isShowCount(true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

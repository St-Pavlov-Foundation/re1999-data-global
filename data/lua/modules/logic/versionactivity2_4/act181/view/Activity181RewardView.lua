module("modules.logic.versionactivity2_4.act181.view.Activity181RewardView", package.seeall)

slot0 = class("Activity181RewardView", BaseView)
slot0.DISPLAY_TYPE = {
	Reward = 2,
	Effect = 1
}

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
	slot0._actId = slot0.viewParam.actId

	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
end

function slot0.refreshUI(slot0)
	slot0:_refreshReward()
end

function slot0._refreshReward(slot0)
	if not Activity181Config.instance:getBoxListByActivityId(slot0._actId) then
		return
	end

	slot3 = {}
	slot4 = {
		[slot10] = Activity181Model.instance:getActivityInfo(slot1):getBonusStateById(slot10) == Activity181Enum.BonusState.HaveGet
	}

	for slot9, slot10 in ipairs(slot2) do
		table.insert(slot3, slot10)
	end

	table.sort(slot3, function (slot0, slot1)
		if uv0[slot0] == uv0[slot1] then
			return slot0 < slot1
		end

		return uv0[slot1]
	end)

	slot7 = #slot0._rewardItemList

	for slot11 = 1, #slot3 do
		slot12 = nil

		if slot11 <= slot7 then
			slot12 = slot0._rewardItemList[slot11]
		else
			table.insert(slot0._rewardItemList, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gorewarditem, slot0._gocontent), Activity181RewardItem))
		end

		slot13 = slot3[slot11]
		slot15 = string.splitToNumber(Activity181Config.instance:getBoxListConfig(slot1, slot13).bonus, "#")

		slot12:setEnable(true)
		slot12:onUpdateMO(slot15[1], slot15[2], slot15[3], slot4[slot13])
	end

	if slot6 < slot7 then
		for slot11 = slot6 + 1, slot7 do
			slot0._rewardItemList[slot11]:setEnable(true)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

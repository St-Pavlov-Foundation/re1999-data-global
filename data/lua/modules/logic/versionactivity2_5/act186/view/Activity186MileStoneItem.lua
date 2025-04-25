module("modules.logic.versionactivity2_5.act186.view.Activity186MileStoneItem", package.seeall)

slot0 = class("Activity186MileStoneItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.transform = slot0.viewGO.transform
	slot0.txtValue = gohelper.findChildTextMesh(slot0.viewGO, "txt_pointvalue")
	slot0.goStatus = gohelper.findChild(slot0.viewGO, "#image_status")
	slot0.goStatusGrey = gohelper.findChild(slot0.viewGO, "#image_statusgrey")
	slot0.rewardList = {}

	for slot4 = 1, 2 do
		slot0:getOrCreateRewardItem(slot4)
	end

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

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not slot1 then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0.actMo = Activity186Model.instance:getById(slot0._mo.activityId)

	slot0:refreshValue()
	slot0:refreshReward()
end

function slot0.refreshValue(slot0)
	slot3 = slot0.actMo:getMilestoneRewardStatus(slot0._mo.rewardId) == Activity186Enum.RewardStatus.Canget or slot2 == Activity186Enum.RewardStatus.Hasget

	if slot0._mo.isLoopBonus then
		slot0.txtValue.text = "∞"
	elseif slot3 then
		slot0.txtValue.text = string.format("<color=#BF5E26>%s</color>", slot0.actMo:getMilestoneValue(slot0._mo.rewardId))
	else
		slot0.txtValue.text = slot4
	end

	gohelper.setActive(slot0.goStatus, slot3)
	gohelper.setActive(slot0.goStatusGrey, not slot3)
end

function slot0.refreshReward(slot0)
	slot1 = GameUtil.splitString2(slot0._mo.bonus, true)
	slot2 = #slot1
	slot7 = #slot0.rewardList

	for slot7 = 1, math.max(#slot1, slot7) do
		slot0:updateRewardItem(slot0:getOrCreateRewardItem(slot7), slot1[slot7], slot0.actMo:getMilestoneRewardStatus(slot0._mo.rewardId))
	end

	slot0.itemWidth = slot2 * 210 + (slot2 - 1) * 10

	recthelper.setWidth(slot0.transform, slot0.itemWidth)
end

function slot0.getOrCreateRewardItem(slot0, slot1)
	if not slot0.rewardList[slot1] then
		if not gohelper.findChild(slot0.viewGO, "#go_rewards/#go_reward" .. slot1) then
			return
		end

		slot2 = slot0:getUserDataTb_()
		slot2.go = slot3
		slot2.imgCircle = gohelper.findChildImage(slot3, "#image_circle")
		slot2.imgQuality = gohelper.findChildImage(slot3, "#image_quality")
		slot2.goIcon = gohelper.findChild(slot3, "go_icon")
		slot2.goCanget = gohelper.findChild(slot3, "go_canget")
		slot2.goReceive = gohelper.findChild(slot3, "go_receive")
		slot2.txtNum = gohelper.findChildTextMesh(slot3, "#txt_num")
		slot0.rewardList[slot1] = slot2
	end

	return slot2
end

function slot0.updateRewardItem(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot4 = ItemModel.instance:getItemConfigAndIcon(slot2[1], slot2[2])

	UISpriteSetMgr.instance:setUiFBSprite(slot1.imgQuality, "bg_pinjidi_" .. slot4.rare)
	UISpriteSetMgr.instance:setUiFBSprite(slot1.imgCircle, "bg_pinjidi_lanse_" .. slot4.rare)

	if not slot1.itemIcon then
		slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.goIcon)
	end

	slot1.itemIcon:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1.itemIcon:setScale(0.7)
	slot1.itemIcon:isShowQuality(false)
	slot1.itemIcon:isShowEquipAndItemCount(false)
	gohelper.setActive(slot1.goCanget, slot3 == Activity186Enum.RewardStatus.Canget)
	gohelper.setActive(slot1.goReceive, slot3 == Activity186Enum.RewardStatus.Hasget)
	slot1.itemIcon:customOnClickCallback(uv0.onClickItemIcon, {
		actId = slot0._mo.activityId,
		status = slot3,
		itemCo = slot2
	})

	if slot2[2] == 171504 then
		slot1.txtNum.text = ""
	else
		slot1.txtNum.text = string.format("×%s", slot2[3])
	end
end

function slot0.onClickItemIcon(slot0)
	if not ActivityModel.instance:isActOnLine(slot0.actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if slot0.status == Activity186Enum.RewardStatus.Canget then
		Activity186Rpc.instance:sendGetAct186MilestoneRewardRequest(slot1)

		return
	end

	slot3 = slot0.itemCo

	MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2])
end

function slot0.getItemWidth(slot0)
	return slot0.itemWidth
end

function slot0.onDestroyView(slot0)
end

return slot0

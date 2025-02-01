module("modules.logic.versionactivity1_4.act129.view.Activity129ResultView", package.seeall)

slot0 = class("Activity129ResultView", BaseView)

function slot0.onInitView(slot0)
	slot0.goRewards = gohelper.findChild(slot0.viewGO, "#go_Result")
	slot0.bigList = slot0:createList(gohelper.findChild(slot0.goRewards, "#go_BigList"))
	slot0.smallList = slot0:createList(gohelper.findChild(slot0.goRewards, "#go_SmallList"))
	slot0.rewardItems = {}
	slot0.click = gohelper.findChildClick(slot0.goRewards, "click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.click:AddClickListener(slot0.onClick, slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnShowReward, slot0.showReward, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onOnCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0.click:RemoveClickListener()
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnShowReward, slot0.showReward, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onOnCloseViewFinish, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onOnCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.RoomBlockPackageGetView then
		RoomController.instance:checkThemeCollerctFullReward()
	end
end

function slot0.onClick(slot0)
	gohelper.setActive(slot0.goRewards, false)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnLotteryEnd)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	Activity129ResultModel.instance:clear()
end

function slot0.showReward(slot0, slot1)
	if not slot1 then
		gohelper.setActive(slot0.goRewards, false)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_all)
	gohelper.setActive(slot0.goRewards, true)
	gohelper.setActive(slot0.bigList.go, false)
	gohelper.setActive(slot0.smallList.go, false)
	gohelper.setActive((#slot1 > 8 and slot0.bigList or slot0.smallList).go, true)

	if slot2 > 8 then
		slot4 = {}

		for slot8, slot9 in ipairs(slot1) do
			table.insert(slot4, {
				materilType = slot9[1],
				materilId = slot9[2],
				quantity = slot9[3],
				isIcon = true
			})
		end

		Activity129ResultModel.instance:setList(slot4)
	else
		slot7 = #slot0.rewardItems

		for slot7 = 1, math.max(slot2, slot7) do
			if not slot0.rewardItems[slot7] then
				slot0.rewardItems[slot7] = IconMgr.instance:getCommonPropItemIcon(slot3.goContent)
			end

			if slot1[slot7] then
				gohelper.addChild(slot3.goContent, slot8.go)
				gohelper.setAsLastSibling(slot8.go)
				gohelper.setActive(slot8.go, true)
				slot8:setMOValue(slot9[1], slot9[2], slot9[3], nil, true)
				slot8:isShowEffect(true)
			else
				gohelper.setActive(slot8.go, false)
			end
		end
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if slot9[1] == MaterialEnum.MaterialType.Building or slot9[1] == MaterialEnum.MaterialType.BlockPackage then
			slot10 = MaterialDataMO.New()

			slot10:initValue(slot9[1], slot9[2], 1, 0)
			table.insert(slot4, slot10)
		end
	end

	if #slot4 > 0 then
		RoomController.instance:popUpRoomBlockPackageView(slot4)
	end
end

function slot0.createList(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.title1 = gohelper.findChild(slot1, "image_SmallTitle1")
	slot2.title2 = gohelper.findChild(slot1, "image_SmallTitle2")
	slot2.goContent = gohelper.findChild(slot1, "#scroll_GetRewardList/Viewport/Content")

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

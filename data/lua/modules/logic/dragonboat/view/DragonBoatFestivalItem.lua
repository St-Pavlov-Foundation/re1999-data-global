module("modules.logic.dragonboat.view.DragonBoatFestivalItem", package.seeall)

slot0 = class("DragonBoatFestivalItem", ListScrollCell)

function slot0.init(slot0, slot1, slot2)
	slot0.viewGO = slot1
	slot0._id = slot2
	slot0._goNormalBG = gohelper.findChild(slot0.viewGO, "Root/#go_NormalBG")
	slot0._goSelectedBG = gohelper.findChild(slot0.viewGO, "Root/#go_SelectedBG")
	slot0._txtDay = gohelper.findChildText(slot0.viewGO, "Root/#txt_Day")
	slot0._txtDayEn = gohelper.findChildText(slot0.viewGO, "Root/#txt_DayEn")
	slot0._goTomorrowTag = gohelper.findChild(slot0.viewGO, "Root/#go_TomorrowTag")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item1")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2")
	slot0._goIcon1 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2/#go_Icon1")
	slot0._goIcon2 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2/#go_Icon2")
	slot0._goFinishedBG = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG")
	slot0._goTick1 = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	slot0._goTick2 = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG/#go_Tick2")
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "Root/#go_Selected")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "Root/#txt_Name")
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._itemClick = gohelper.getClickWithAudio(slot0._goSelectedBG)
	slot0._itemClick1 = gohelper.getClickWithAudio(slot0._goNormalBG)
	slot0._itemAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0.viewGO, false)
	gohelper.setActive(slot0._goSelected, false)
	TaskDispatcher.runDelay(slot0._playOpen, slot0, 0.03 * slot0._id)

	slot0._itemList = {}
	slot0._item = IconMgr.instance:getCommonPropItemIcon(slot0._goitem1)

	slot0:_editableAddEvents()
	slot0:refresh(slot0._id)
end

function slot0._playOpen(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0._itemAnimator:Play("open", 0, 0)
end

function slot0._editableAddEvents(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	slot0._itemClick1:AddClickListener(slot0._onItemClick, slot0)
	DragonBoatFestivalController.instance:registerCallback(DragonBoatFestivalEvent.SelectItem, slot0._onSelectItem, slot0)
	DragonBoatFestivalController.instance:registerCallback(DragonBoatFestivalEvent.ShowMapFinished, slot0._startGetReward, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._itemClick:RemoveClickListener()
	slot0._itemClick1:RemoveClickListener()
	DragonBoatFestivalController.instance:unregisterCallback(DragonBoatFestivalEvent.SelectItem, slot0._onSelectItem, slot0)
	DragonBoatFestivalController.instance:unregisterCallback(DragonBoatFestivalEvent.ShowMapFinished, slot0._startGetReward, slot0)
end

function slot0._onSelectItem(slot0)
	gohelper.setActive(slot0._goSelected, DragonBoatFestivalModel.instance:getCurDay() == slot0._id)
end

function slot0._onItemClick(slot0)
	if not DragonBoatFestivalModel.instance:isGiftUnlock(slot0._id) then
		return
	end

	if DragonBoatFestivalModel.instance:isGiftGet(DragonBoatFestivalModel.instance:getCurDay()) and slot1 == slot0._id then
		return
	end

	if not DragonBoatFestivalModel.instance:isGiftGet(slot0._id) then
		DragonBoatFestivalModel.instance:setCurDay(slot0._id)
		slot0:_startGetReward()

		return
	end

	gohelper.setActive(slot0._goSelected, true)
	DragonBoatFestivalModel.instance:setCurDay(slot0._id)
	UIBlockMgrExtend.setNeedCircleMv(false)
	DragonBoatFestivalController.instance:dispatchEvent(DragonBoatFestivalEvent.SelectItem)
end

function slot0._startGetReward(slot0)
	if not DragonBoatFestivalModel.instance:isGiftGet(slot0._id) and DragonBoatFestivalModel.instance:isGiftUnlock(slot0._id) then
		Activity101Rpc.instance:sendGet101BonusRequest(ActivityEnum.Activity.DragonBoatFestival, slot0._id)
	end
end

function slot0.refresh(slot0, slot1)
	slot0._id = slot1
	slot3 = DragonBoatFestivalModel.instance:isGiftGet(slot0._id)
	slot4 = DragonBoatFestivalModel.instance:isGiftUnlock(slot0._id)
	slot5 = DragonBoatFestivalModel.instance:getLoginCount()
	slot6 = DragonBoatFestivalModel.instance:getCurDay()
	slot10 = #string.split(ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.DragonBoatFestival, slot0._id).bonus, "|") == 1
	slot0._txtName.text = ""

	for slot14 = 1, slot9 do
		slot15 = string.splitToNumber(slot8[slot14], "#")

		if not slot0._itemList[slot14] then
			table.insert(slot0._itemList, IconMgr.instance:getCommonPropItemIcon(slot0["_goIcon" .. slot14]))
		end

		slot0:_refreshRewardItem(slot16, slot15)

		if slot14 == 1 then
			slot0:_refreshRewardItem(slot0._item, slot15)

			if slot10 then
				slot0._txtName.text = ItemModel.instance:getItemConfig(slot15[1], slot15[2]).name
			end
		end
	end

	slot0._txtDay.text = string.format("%02d", slot0._id)
	slot0._txtDayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(slot0._id))

	gohelper.setActive(slot0._goitem1, slot10)
	gohelper.setActive(slot0._goTick1, slot10)
	gohelper.setActive(slot0._goitem2, not slot10)
	gohelper.setActive(slot0._goTick2, not slot10)
	gohelper.setActive(slot0._goSelectedBG, not slot3 and slot4)
	gohelper.setActive(slot0._goTomorrowTag, slot0._id == slot5 + 1)
	gohelper.setActive(slot0._goFinishedBG, slot3)

	slot11 = DragonBoatFestivalModel.instance:getMaxUnlockDay()

	if slot0._id == slot11 and not DragonBoatFestivalModel.instance:isGiftGet(slot11) then
		gohelper.setActive(slot0._goSelected, slot0._goSelected.activeSelf)
	else
		gohelper.setActive(slot0._goSelected, slot0._id == slot6)
	end
end

function slot0._refreshRewardItem(slot0, slot1, slot2)
	slot1:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1:setCountFontSize(46)
	slot1:setHideLvAndBreakFlag(true)
	slot1:hideEquipLvAndBreak(true)
	slot1:customOnClickCallback(function ()
		if not DragonBoatFestivalModel.instance:isGiftGet(uv0._id) and DragonBoatFestivalModel.instance:isGiftUnlock(uv0._id) then
			uv0:_onItemClick()

			return
		end

		MaterialTipController.instance:showMaterialInfo(uv1[1], uv1[2])
	end)
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._playOpen, slot0)
	slot0:_editableRemoveEvents()
end

return slot0

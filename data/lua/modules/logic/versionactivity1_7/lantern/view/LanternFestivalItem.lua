module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalItem", package.seeall)

slot0 = class("LanternFestivalItem", ListScrollCell)

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.viewGO = slot1
	slot0._index = slot2
	slot0._puzzleId = slot3
	slot0._goNormalBG = gohelper.findChild(slot0.viewGO, "Root/#go_NormalBG")
	slot0._goSelectedBG = gohelper.findChild(slot0.viewGO, "Root/#go_SelectedBG")
	slot0._txtDay = gohelper.findChildText(slot0.viewGO, "Root/#txt_Day")
	slot0._txtDayEn = gohelper.findChildText(slot0.viewGO, "Root/#txt_DayEn")
	slot0._goFinishedImg = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedImg")
	slot0._goTomorrowTag = gohelper.findChild(slot0.viewGO, "Root/#go_TomorrowTag")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item1")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2")
	slot0._goIcon1 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2/#go_Icon1")
	slot0._goIcon2 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2/#go_Icon2")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "Root/#txt_Name")
	slot0._goFinishedBG = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG")
	slot0._goTick1 = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	slot0._goTick2 = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG/#go_Tick2")
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._itemClick = gohelper.getClickWithAudio(slot0._goSelectedBG)
	slot0._itemClick1 = gohelper.getClickWithAudio(slot0._goFinishedImg)
	slot0._itemClick2 = gohelper.getClickWithAudio(slot0._goNormalBG)
	slot0._itemAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.runDelay(slot0._playOpen, slot0, 0.03 * slot0._index)

	slot0._itemList = {}
	slot0._item = IconMgr.instance:getCommonPropItemIcon(slot0._goitem1)

	slot0:_editableAddEvents()
	slot0:refresh(slot2, slot3)
end

function slot0._playOpen(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0._itemAnimator:Play("open", 0, 0)
end

function slot0._editableAddEvents(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	slot0._itemClick1:AddClickListener(slot0._onItemClick, slot0)
	slot0._itemClick2:AddClickListener(slot0._onItemClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._itemClick:RemoveClickListener()
	slot0._itemClick1:RemoveClickListener()
	slot0._itemClick2:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	if not LanternFestivalModel.instance:isPuzzleUnlock(slot0._puzzleId) then
		return
	end

	LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.SelectPuzzleItem)
	LanternFestivalController.instance:openQuestionTipView({
		puzzleId = slot0._puzzleId,
		day = slot0._index
	})
end

function slot0.refresh(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._puzzleId = slot2
	slot3 = LanternFestivalModel.instance:isPuzzleGiftGet(slot0._puzzleId)

	gohelper.setActive(slot0._goFinishedImg, slot3)

	slot4 = not slot3 and LanternFestivalModel.instance:isPuzzleUnlock(slot0._puzzleId)
	slot5 = LanternFestivalModel.instance:getLoginCount()
	slot10 = #string.split(LanternFestivalConfig.instance:getAct154Co(ActivityEnum.Activity.LanternFestival, slot1).bonus, "|") == 1

	gohelper.setActive(slot0._goitem1, slot10)
	gohelper.setActive(slot0._goTick1, slot10)
	gohelper.setActive(slot0._goitem2, not slot10)
	gohelper.setActive(slot0._goTick2, not slot10)

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

	slot0._txtDay.text = string.format("%02d", slot1)
	slot0._txtDayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(slot1))

	gohelper.setActive(slot0._goSelectedBG, slot4)
	gohelper.setActive(slot0._goTomorrowTag, slot1 == slot5 + 1)
	gohelper.setActive(slot0._goFinishedBG, slot3)
end

function slot0._refreshRewardItem(slot0, slot1, slot2)
	slot1:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1:setCountFontSize(46)
	slot1:setHideLvAndBreakFlag(true)
	slot1:hideEquipLvAndBreak(true)
	slot1:customOnClickCallback(function ()
		if not LanternFestivalModel.instance:isPuzzleGiftGet(uv0._puzzleId) and LanternFestivalModel.instance:isPuzzleUnlock(uv0._puzzleId) then
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

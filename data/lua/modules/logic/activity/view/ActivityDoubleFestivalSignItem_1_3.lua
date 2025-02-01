module("modules.logic.activity.view.ActivityDoubleFestivalSignItem_1_3", package.seeall)

slot0 = class("ActivityDoubleFestivalSignItem_1_3", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goNormalBG = gohelper.findChild(slot0.viewGO, "Root/#go_NormalBG")
	slot0._goSelectedBG = gohelper.findChild(slot0.viewGO, "Root/#go_SelectedBG")
	slot0._txtDay = gohelper.findChildText(slot0.viewGO, "Root/#txt_Day")
	slot0._txtDayEn = gohelper.findChildText(slot0.viewGO, "Root/#txt_DayEn")
	slot0._goTomorrowTag = gohelper.findChild(slot0.viewGO, "Root/#go_TomorrowTag")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item1")
	slot0._goItem2 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_Item2")
	slot0._goIcon1 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_Item2/#go_Icon1")
	slot0._goIcon2 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_Item2/#go_Icon2")
	slot0._goFinishedBG = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG")
	slot0._goTick1 = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	slot0._goTick2 = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG/#go_Tick2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = string.format
slot2 = string.splitToNumber
slot3 = string.split

function slot0._editableInitView(slot0)
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._itemClick = gohelper.getClickWithAudio(slot0._goSelectedBG)
	slot0._itemClick2 = gohelper.getClickWithAudio(slot0._goNormalBG)
	slot0._itemList = {}
	slot0._item = IconMgr.instance:getCommonPropItemIcon(slot0._goitem1)
end

function slot0._editableAddEvents(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	slot0._itemClick2:AddClickListener(slot0._onItemClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._itemClick:RemoveClickListener()
	slot0._itemClick2:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not slot0._openAnim then
		slot0:_playOpen()
	else
		slot0:_playIdle()
	end

	slot0:_refreshItem()
end

function slot0.onSelect(slot0, slot1)
end

function slot0._refreshRewardItem(slot0, slot1, slot2)
	slot3 = slot0._mo.data[1]
	slot4 = slot0._index

	slot1:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1:setCountFontSize(46)
	slot1:setHideLvAndBreakFlag(true)
	slot1:hideEquipLvAndBreak(true)
	slot1:customOnClickCallback(function ()
		if ActivityType101Model.instance:isType101RewardCouldGet(uv0, uv1) then
			Activity101Rpc.instance:sendGet101BonusRequest(uv0, uv1)

			return
		end

		MaterialTipController.instance:showMaterialInfo(uv2[1], uv2[2])
	end)
end

function slot0._refreshItem(slot0)
	slot1 = slot0._mo.data[1]
	slot2 = slot0._index
	slot3 = ActivityType101Model.instance:isType101RewardGet(slot1, slot2)
	slot4 = ActivityType101Model.instance:isType101RewardCouldGet(slot1, slot2)
	slot5 = ActivityType101Model.instance:getType101LoginCount(slot1)
	slot9 = #uv0(ActivityConfig.instance:getNorSignActivityCo(slot1, slot2).bonus, "|") == 1

	gohelper.setActive(slot0._goitem1, slot9)
	gohelper.setActive(slot0._goTick1, slot9)
	gohelper.setActive(slot0._goitem2, not slot9)
	gohelper.setActive(slot0._goTick2, not slot9)

	for slot13 = 1, slot8 do
		slot14 = uv1(slot7[slot13], "#")

		if not slot0._itemList[slot13] then
			table.insert(slot0._itemList, IconMgr.instance:getCommonPropItemIcon(slot0["_goIcon" .. slot13]))
		end

		slot0:_refreshRewardItem(slot15, slot14)

		if slot13 == 1 then
			slot0:_refreshRewardItem(slot0._item, slot14)
		end
	end

	slot0._txtDay.text = slot2 < 10 and "0" .. slot2 or slot2
	slot0._txtDayEn.text = uv2("DAY\n%s", GameUtil.getEnglishNumber(slot2))

	gohelper.setActive(slot0._goSelectedBG, slot4)
	gohelper.setActive(slot0._goTomorrowTag, slot2 ~= 10 and slot2 == slot5 + 1)
	gohelper.setActive(slot0._goFinishedBG, slot3)
end

function slot0.onDestroyView(slot0)
	slot0._openAnim = nil

	TaskDispatcher.cancelTask(slot0._playOpenInner, slot0)
end

function slot0._onItemClick(slot0)
	slot1 = slot0._mo.data[1]

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	slot4 = ActivityType101Model.instance:getType101LoginCount(slot1)

	if ActivityType101Model.instance:isType101RewardCouldGet(slot1, slot0._index) then
		Activity101Rpc.instance:sendGet101BonusRequest(slot1, slot2)
	end

	if slot4 < slot2 then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function slot0._playOpenInner(slot0)
	slot0:_setActive(true)
	slot0._anim:Play(UIAnimationName.Open)
end

function slot0._playOpen(slot0)
	if slot0._openAnim then
		return
	end

	slot0._openAnim = true

	slot0:_setActive(false)
	TaskDispatcher.runDelay(slot0._playOpenInner, slot0, slot0._index * 0.03)
end

function slot0._playIdle(slot0)
	if slot0._openAnim then
		return
	end

	slot0._anim:Play(UIAnimationName.Idle, 0, 1)
end

function slot0._setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

return slot0

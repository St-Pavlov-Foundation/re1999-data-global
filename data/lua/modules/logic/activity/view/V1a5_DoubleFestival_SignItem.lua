module("modules.logic.activity.view.V1a5_DoubleFestival_SignItem", package.seeall)

slot0 = class("V1a5_DoubleFestival_SignItem", Activity101SignViewItemBase)

function slot0.onInitView(slot0)
	slot0._goNormalBG = gohelper.findChild(slot0.viewGO, "Root/#go_NormalBG")
	slot0._goSelectedBG = gohelper.findChild(slot0.viewGO, "Root/#go_SelectedBG")
	slot0._goFinishedImg = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedImg")
	slot0._txtDay = gohelper.findChildText(slot0.viewGO, "Root/#txt_Day")
	slot0._txtDayEn = gohelper.findChildText(slot0.viewGO, "Root/#txt_DayEn")
	slot0._goTomorrowTag = gohelper.findChild(slot0.viewGO, "Root/#go_TomorrowTag")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item1")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2")
	slot0._goIcon1 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2/#go_Icon1")
	slot0._goIcon2 = gohelper.findChild(slot0.viewGO, "Root/Item/#go_item2/#go_Icon2")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "Root/#txt_Name")
	slot0._goFinishedBG = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG")
	slot0._goTick1 = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG/#go_Tick1")
	slot0._goTick2 = gohelper.findChild(slot0.viewGO, "Root/#go_FinishedBG/#go_Tick2")
	slot0._txtWish = gohelper.findChildText(slot0.viewGO, "Root/#go_FinishedBG/#txt_Wish")

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
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._itemClick = gohelper.getClickWithAudio(slot0._goSelectedBG)
	slot0._itemClick2 = gohelper.getClickWithAudio(slot0._goNormalBG)
	slot0._itemClickBless = gohelper.getClickWithAudio(slot0._txtWish.gameObject)
	slot0._itemList = {}
	slot0._item = IconMgr.instance:getCommonPropItemIcon(slot0._goitem1)
	slot0._kelinqu = gohelper.findChild(slot0.viewGO, "Root/#go_SelectedBG/kelinqu")
	slot0._txtWish.text = ""
end

function slot0._editableAddEvents(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	slot0._itemClick2:AddClickListener(slot0._onItemClick, slot0)
	slot0._itemClickBless:AddClickListener(slot0._onClickBless, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._itemClick:RemoveClickListener()
	slot0._itemClick2:RemoveClickListener()
	slot0._itemClickBless:RemoveClickListener()
end

function slot0.onRefresh(slot0)
	slot1 = slot0._mo.data[1]
	slot2 = slot0._index
	slot3 = ActivityType101Model.instance:isType101RewardGet(slot1, slot2)
	slot4 = ActivityType101Model.instance:isType101RewardCouldGet(slot1, slot2)
	slot5 = ActivityType101Model.instance:getType101LoginCount(slot1)
	slot9 = #uv0(ActivityConfig.instance:getNorSignActivityCo(slot1, slot2).bonus, "|") == 1

	gohelper.setActive(slot0._goitem1, slot9)
	gohelper.setActive(slot0._goTick1, slot9)
	gohelper.setActive(slot0._kelinqu, slot9)
	gohelper.setActive(slot0._goitem2, not slot9)
	gohelper.setActive(slot0._goTick2, not slot9)

	slot0._txtName.text = ""

	if slot9 then
		slot10 = uv1(slot7[1], "#")

		slot0:_refreshRewardItem(slot0._item, slot10)

		slot0._txtName.text = ItemModel.instance:getItemConfig(slot10[1], slot10[2]).name
	else
		for slot13 = 1, slot8 do
			slot14 = uv1(slot7[slot13], "#")

			if not slot0._itemList[slot13] then
				table.insert(slot0._itemList, IconMgr.instance:getCommonPropItemIcon(slot0["_goIcon" .. slot13]))
			end

			slot0:_refreshRewardItem(slot15, slot14)
		end
	end

	slot0._txtDay.text = slot2 < 10 and "0" .. slot2 or slot2
	slot0._txtDayEn.text = uv2("DAY\n%s", GameUtil.getEnglishNumber(slot2))

	gohelper.setActive(slot0._goSelectedBG, slot4)
	gohelper.setActive(slot0._goTomorrowTag, slot2 == slot5 + 1)
	gohelper.setActive(slot0._goFinishedBG, slot3)
	gohelper.setActive(slot0._goFinishedImg, slot3)

	if ActivityType101Config.instance:getDoubleFestivalCOByDay(slot1, slot2) then
		slot0._txtWish.text = slot10.btnDesc
	end
end

function slot0._refreshRewardItem(slot0, slot1, slot2)
	slot1:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1:setCountFontSize(46)
	slot1:setHideLvAndBreakFlag(true)
	slot1:hideEquipLvAndBreak(true)
	slot1:customOnClickCallback(function ()
		if ActivityType101Model.instance:isType101RewardCouldGet(uv0._mo.data[1], uv0._index) then
			ActivityType101Model.instance:setCurIndex(slot1)
			Activity101Rpc.instance:sendGet101BonusRequest(slot0, slot1)

			return
		end

		MaterialTipController.instance:showMaterialInfo(uv1[1], uv1[2])
	end)
end

function slot0._onClickBless(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_feedback_open)
	ViewMgr.instance:openView(ViewName.V1a5_DoubleFestival_WishPanel, {
		day = slot0._index
	})
end

function slot0._onItemClick(slot0)
	slot1 = slot0._mo.data[1]

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	slot4 = ActivityType101Model.instance:getType101LoginCount(slot1)

	if ActivityType101Model.instance:isType101RewardCouldGet(slot1, slot0._index) then
		ActivityType101Model.instance:setCurIndex(slot2)
		Activity101Rpc.instance:sendGet101BonusRequest(slot1, slot2)
	end

	if slot4 < slot2 then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

return slot0

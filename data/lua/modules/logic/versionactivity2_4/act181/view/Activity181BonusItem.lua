module("modules.logic.versionactivity2_4.act181.view.Activity181BonusItem", package.seeall)

slot0 = class("Activity181BonusItem", LuaCompBase)
slot0.ANI_IDLE = "idle"
slot0.ANI_CAN_GET = "get"
slot0.ANI_COVER_OPEN = "coveropen"

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._imgQuality = gohelper.findChildImage(slot1, "OptionalItem/#img_Quality")
	slot0._simgItem = gohelper.findChildSingleImage(slot1, "OptionalItem/#simage_Item")
	slot0._goOptionalItem = gohelper.findChild(slot1, "OptionalItem")
	slot0._goImageBg = gohelper.findChild(slot1, "image_BG")
	slot0._txtNum = gohelper.findChildTextMesh(slot1, "OptionalItem/image_NumBG/#txt_Num")
	slot0._txtItemName = gohelper.findChildTextMesh(slot1, "OptionalItem/#txt_ItemName")
	slot0._goCover = gohelper.findChild(slot1, "#go_Cover")
	slot0._goGet = gohelper.findChild(slot1, "#go_Get")
	slot0._goCoverClose = gohelper.findChild(slot1, "image_Cover")
	slot0._goCoverOpen = gohelper.findChild(slot1, "image_CoverOpen")
	slot0._btnClick = gohelper.findChildButton(slot1, "click")
	slot0._goType1 = gohelper.findChild(slot1, "#go_Cover/#go_Type1")
	slot0._goType2 = gohelper.findChild(slot1, "#go_Cover/#go_Type2")
	slot0._goType3 = gohelper.findChild(slot1, "#go_Cover/#go_Type3")
	slot0._goType4 = gohelper.findChild(slot1, "#go_Cover/#go_Type4")

	slot0:initItem()
end

function slot0.initItem(slot0)
	slot0._typeList = {
		slot0._goType1,
		slot0._goType2,
		slot0._goType3,
		slot0._goType4
	}

	slot0._btnClick:AddClickListener(slot0.onClickItem, slot0)

	slot0._animator = gohelper.findChildComponent(slot0.go, "", gohelper.Type_Animator)

	gohelper.setActive(slot0._txtItemName, false)

	slot0._animator.enabled = true
end

function slot0.onClickItem(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if not Activity181Model.instance:isActivityInTime(slot0._activityId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if Activity181Model.instance:getActivityInfo(slot0._activityId):getBonusState(slot0._pos) == Activity181Enum.BonusState.HaveGet then
		slot3 = string.splitToNumber(Activity181Config.instance:getBoxListConfig(slot0._activityId, slot0._boxId).bonus, "#")

		MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2], false)

		return
	end

	if slot1.canGetTimes <= 0 then
		GameFacade.showToast(ToastEnum.NorSign)

		return
	end

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	Activity181Controller.instance:getBonus(slot0._activityId, slot0._pos)
end

function slot0.setEnable(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0._pos = slot1
	slot0._activityId = slot2
	slot5 = Activity181Model.instance:getActivityInfo(slot2):getBonusState(slot1) == Activity181Enum.BonusState.HaveGet
	slot6 = slot4:getBonusTimes() > 0
	slot7, slot8 = nil

	if slot3 then
		slot7 = true
		slot8 = slot0.ANI_COVER_OPEN

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_get)
	else
		slot7 = slot5
		slot8 = slot6 and not slot5 and slot0.ANI_CAN_GET or slot0.ANI_IDLE
	end

	gohelper.setActive(slot0._goImageBg, slot7)
	gohelper.setActive(slot0._goOptionalItem, slot7)
	gohelper.setActive(slot0._goCover, not slot5 or slot3)
	gohelper.setActive(slot0._goCoverClose, not slot5)
	gohelper.setActive(slot0._goCoverOpen, slot5)
	gohelper.setActive(slot0._simgItem.gameObject, slot5)
	slot0._animator:Play(slot8)
	math.randomseed(tonumber(PlayerModel.instance:getMyUserId()) * slot1)

	for slot15, slot16 in ipairs(slot0._typeList) do
		gohelper.setActive(slot16, slot15 == math.random(1, #slot0._typeList))
	end

	if not slot5 then
		return
	end

	slot0._boxId = slot4:getBonusIdByPos(slot1)
	slot13 = string.splitToNumber(Activity181Config.instance:getBoxListConfig(slot0._activityId, slot0._boxId).bonus, "#")
	slot14, slot15 = ItemModel.instance:getItemConfigAndIcon(slot13[1], slot13[2], true)
	slot0._txtNum.text = tostring(slot13[3])

	slot0._simgItem:LoadImage(slot15)
	UISpriteSetMgr.instance:setUiFBSprite(slot0._imgQuality, "bg_pinjidi_" .. tostring(slot14.rare))
end

function slot0.setBonusFxState(slot0, slot1, slot2)
	gohelper.setActive(slot0._goCover, not slot1)
	slot0._animator:Play(not slot1 and slot2 and slot0.ANI_CAN_GET or slot0.ANI_IDLE)
end

function slot0.onDestroy(slot0)
	slot0._btnClick:RemoveClickListener()

	slot0._typeList = nil
end

return slot0

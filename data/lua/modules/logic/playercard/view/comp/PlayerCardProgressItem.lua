module("modules.logic.playercard.view.comp.PlayerCardProgressItem", package.seeall)

slot0 = class("PlayerCardProgressItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagepic = gohelper.findChildImage(slot0.viewGO, "#image_pic")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#txt_en")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "select")
	slot0._txtorder = gohelper.findChildText(slot0.viewGO, "select/#txt_order")
	slot0._goselecteffect = gohelper.findChild(slot0.viewGO, "select/#go_click")
	slot0._btnclick = gohelper.findChildButton(slot0.viewGO, "#btn_click")
	slot0._typeItemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	for slot4, slot5 in pairs(PlayerCardEnum.ProgressShowType) do
		slot6 = gohelper.findChild(slot0.viewGO, "progress/type" .. slot5)

		gohelper.setActive(slot6, false)

		slot0._typeItemList[slot5] = slot6
	end

	gohelper.setActive(slot0._goselect, false)
end

function slot0.resetType(slot0)
	for slot4, slot5 in pairs(slot0._typeItemList) do
		gohelper.setActive(slot5, false)
	end
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._btnclickOnClick(slot0)
	PlayerCardProgressModel.instance:clickItem(slot0.index)
	gohelper.setActive(slot0._goselecteffect, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0.config = slot1.config
	slot0.playercardinfo = slot0.mo.info
	slot0.index = slot0.mo.index
	slot0.type = slot0.config.type

	UISpriteSetMgr.instance:setPlayerCardSprite(slot0._imagepic, "playercard_progress_img_" .. slot0.index)
	UISpriteSetMgr.instance:setPlayerCardSprite(slot0._imageicon, "playercard_progress_icon_" .. slot0.index)
	slot0:refreshItem()

	if PlayerCardProgressModel.instance:getSelectIndex(slot0.index) then
		gohelper.setActive(slot0._goselect, true)

		slot0._txtorder.text = tostring(slot2)
	else
		gohelper.setActive(slot0._goselect, false)
		gohelper.setActive(slot0._goselecteffect, false)
	end
end

function slot0.refreshItem(slot0)
	slot0._txtname.text = slot0.config.name
	slot0._txten.text = slot0.config.nameEn

	gohelper.setActive(slot0._typeItemList[slot0.type], true)

	if slot0.type == PlayerCardEnum.ProgressShowType.Normal then
		slot2 = gohelper.findChildText(slot1, "#txt_progress")
		slot5 = slot0.playercardinfo:getProgressByIndex(slot0.index) ~= -1

		gohelper.setActive(gohelper.findChild(slot1, "none"), not slot5)
		gohelper.setActive(slot2.gameObject, slot5)

		slot2.text = slot4
	elseif slot0.type == PlayerCardEnum.ProgressShowType.Explore then
		if not string.nilorempty(slot0.playercardinfo.exploreCollection) then
			slot6 = GameUtil.splitString2(slot2, true) or {}
			gohelper.findChildText(slot1, "#txt_num1").text = slot6[3][1] or 0
			gohelper.findChildText(slot1, "#txt_num2").text = slot6[1][1] or 0
			gohelper.findChildText(slot1, "#txt_num3").text = slot6[2][1] or 0
		else
			slot3.text = 0
			slot4.text = 0
			slot5.text = 0
		end
	elseif slot0.type == PlayerCardEnum.ProgressShowType.Room then
		slot3 = gohelper.findChildText(slot1, "#txt_num2")

		if string.splitToNumber(slot0.playercardinfo.roomCollection, "#") and slot5[1] or 0 then
			gohelper.findChildText(slot1, "#txt_num1").text = slot6
		else
			slot2.text = 0
		end

		if slot5 and slot5[2] or 0 then
			slot3.text = slot7
		else
			slot3.text = 0
		end
	end
end

function slot0.onDestroyView(slot0)
end

return slot0

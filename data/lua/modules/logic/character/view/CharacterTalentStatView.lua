module("modules.logic.character.view.CharacterTalentStatView", package.seeall)

slot0 = class("CharacterTalentStatView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/Content/#go_item")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#go_normal")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#image_icon")
	slot0._imageglow = gohelper.findChildImage(slot0.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#image_glow")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "Scroll View/Viewport/Content/#go_item/#txt_name")
	slot0._gopercent = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/Content/#go_item/#go_percent")
	slot0._txtpercent = gohelper.findChildText(slot0.viewGO, "Scroll View/Viewport/Content/#go_item/#txt_percent")

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
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._goitem, false)

	slot0.heroId = slot0.viewParam.heroId

	slot0:showStylePercentList()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.showStylePercentList(slot0)
	if not TalentStyleModel.instance:getStyleCoList(slot0.heroId) then
		return
	end

	if not slot0._itemList then
		slot0._itemList = slot0:getUserDataTb_()
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot7)
	end

	slot6 = TalentStyleModel.sortUnlockPercent

	table.sort(slot2, slot6)

	for slot6, slot7 in ipairs(slot2) do
		slot0:getItem(slot6):onRefreshMo(slot7)
	end

	for slot6 = 1, #slot0._itemList do
		gohelper.setActive(slot0._itemList[slot6].viewGO, slot6 <= #slot1)
	end
end

function slot0.getItem(slot0, slot1)
	if not slot0._itemList[slot1] then
		slot0._itemList[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goitem, "item_" .. slot1), CharacterTalentStatItem)
	end

	return slot2
end

return slot0

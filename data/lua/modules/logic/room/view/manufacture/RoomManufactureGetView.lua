module("modules.logic.room.view.manufacture.RoomManufactureGetView", package.seeall)

slot0 = class("RoomManufactureGetView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._scrollproduct = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_product")
	slot0._goproductitem = gohelper.findChild(slot0.viewGO, "#scroll_product/Viewport/Content/#go_productitem")
	slot0._gonormalLayout = gohelper.findChild(slot0.viewGO, "#scroll_product/Viewport/Content/#go_normalLayout")
	slot0._gousedTitle = gohelper.findChild(slot0.viewGO, "#scroll_product/Viewport/Content/txt_tips")
	slot0._gousedLayout = gohelper.findChild(slot0.viewGO, "#scroll_product/Viewport/Content/#go_usedLayout")

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
	gohelper.setActive(slot0._goproductitem, false)
end

function slot0.onUpdateParam(slot0)
	if slot0.viewParam then
		slot0.normalList = slot0.viewParam.normalList
		slot0.usedList = slot0.viewParam.usedList
	end

	slot0.normalList = slot0.normalList or {}
	slot0.usedList = slot0.usedList or {}
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
	slot0:setNormalList()
	slot0:setUsedList()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shouhuo_2_2)
end

function slot0.setNormalList(slot0)
	gohelper.CreateObjList(slot0, slot0._onSeItem, slot0.normalList, slot0._gonormalLayout, slot0._goproductitem)
end

function slot0.setUsedList(slot0)
	slot1 = slot0.usedList and #slot0.usedList > 0

	gohelper.setActive(slot0._gousedTitle, slot1)
	gohelper.setActive(slot0._gousedLayout, slot1)
	gohelper.CreateObjList(slot0, slot0._onSeItem, slot0.usedList, slot0._gousedLayout, slot0._goproductitem)
end

function slot0._onSeItem(slot0, slot1, slot2, slot3)
	slot4 = slot2.isShowExtra

	gohelper.setActive(gohelper.findChild(slot1, "tag_extra"), slot4)
	gohelper.setActive(gohelper.findChild(slot1, "#baoji"), slot4)

	slot8 = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot1, "go_icon"))

	slot8:isShowQuality(false)
	recthelper.setAnchorY(slot8:getCountBg().transform, RoomManufactureEnum.ItemCountBgY)
	recthelper.setAnchorY(slot8:getCount().transform, RoomManufactureEnum.ItemCountY)
	slot8:onUpdateMO(slot2)
	UISpriteSetMgr.instance:setCritterSprite(gohelper.findChildImage(slot1, "#image_quality"), RoomManufactureEnum.RareImageMap[slot8:getRare()])
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

module("modules.logic.room.view.critter.detail.RoomCritterDetailAttrItem", package.seeall)

slot0 = class("RoomCritterDetailAttrItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#txt_name/#image_icon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_num")
	slot0._txtratio = gohelper.findChildText(slot0.viewGO, "#txt_ratio")
	slot0._goArrow = gohelper.findChild(slot0.viewGO, "#txt_ratio/arrow")
	slot0._goClick = gohelper.findChild(slot0.viewGO, "#txt_ratio/arrow/clickarea")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
	end
end

function slot0.onClick(slot0)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0._editableInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "bg")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.setRatioColor(slot0, slot1, slot2)
	slot0._normalColor = slot1
	slot0._addColor = slot2
end

function slot0.onRefreshMo(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0._mo = slot1

	if slot0._txtnum then
		slot0._txtnum.text = slot3 or slot1:getValueNum()
	end

	if slot0._txtratio then
		slot0._txtratio.text = slot4 or slot1:getRateStr()
	end

	if slot0._txtname then
		slot0._txtname.text = slot5 or slot1:getName()
	end

	if slot0._imageicon and not string.nilorempty(slot1:getIcon()) then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imageicon, slot1:getIcon())
	end

	slot8 = slot1:getIsAddition()

	gohelper.setActive(slot0._goArrow, slot8)

	slot0._txtratio.color = GameUtil.parseColor(slot8 and slot0._addColor or slot0._normalColor)

	if not slot0._btnClick and slot0._goClick then
		slot0._btnClick = SLFramework.UGUI.UIClickListener.Get(slot0._goClick)

		slot0._btnClick:AddClickListener(slot6, slot7)
	end

	if slot0._gobg then
		gohelper.setActive(slot0._gobg, slot2 % 2 == 0)
	end
end

function slot0.setMaturityNum(slot0)
	if slot0._txtratio then
		slot0._txtratio.text = slot0._mo:getValueNum()
	end
end

return slot0

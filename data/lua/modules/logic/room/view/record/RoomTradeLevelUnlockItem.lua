module("modules.logic.room.view.record.RoomTradeLevelUnlockItem", package.seeall)

slot0 = class("RoomTradeLevelUnlockItem", BaseView)

function slot0.onInitView(slot0)
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "normal/#image_bg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "normal/prop/#txt_num")
	slot0._goprop = gohelper.findChild(slot0.viewGO, "normal/prop")
	slot0._imagepropicon = gohelper.findChildSingleImage(slot0.viewGO, "normal/prop/propicon")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "normal/#image_icon")
	slot0._simagepropicon = gohelper.findChildSingleImage(slot0.viewGO, "normal/prop/propicon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "normal/txt/#txt_name")
	slot0._gonum = gohelper.findChild(slot0.viewGO, "normal/txt/#go_num")
	slot0._txtcur = gohelper.findChildText(slot0.viewGO, "normal/txt/#go_num/#txt_cur")
	slot0._txtnext = gohelper.findChildText(slot0.viewGO, "normal/txt/#go_num/#txt_next")
	slot0._goup = gohelper.findChild(slot0.viewGO, "normal/go_up")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "normal/go_new")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
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
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._imagebg.gameObject)

	slot0._click:AddClickListener(slot0._btnClickOnClick, slot0)
end

function slot0._btnClickOnClick(slot0)
	if not slot0._mo or not slot0._mo.type then
		return
	end

	if slot0._co.itemType == 1 and slot0._mo.buildingId then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Building, slot0._mo.buildingId)
	elseif slot0._mo.type == RoomTradeEnum.LevelUnlock.GetBouns then
		slot1 = string.split(slot0._mo.bouns, "#")

		MaterialTipController.instance:showMaterialInfo(slot1[1], slot1[2])
	end
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
	slot0._imagepropicon:UnLoadImage()
	slot0._simagepropicon:UnLoadImage()

	if slot0._click then
		slot0._click:RemoveClickListener()
	end
end

function slot0.onRefreshMo(slot0, slot1)
	slot0._co = RoomTradeConfig.instance:getLevelUnlockCo(slot1.type)
	slot0._mo = slot1

	if slot0._co then
		slot0._txtname.text = slot0._co.name

		gohelper.setActive(slot0._goup, slot0._co.type == 2)
		gohelper.setActive(slot0._gonew.gameObject, slot0._co.type == 1)

		if slot1.type == RoomTradeEnum.LevelUnlock.GetBouns then
			if not string.nilorempty(slot1.bouns) then
				slot2 = string.split(slot1.bouns, "#")
				slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot2[1], slot2[2])

				if not string.nilorempty(slot4) then
					slot0._imagepropicon:LoadImage(slot4)
				end

				slot0._txtnum.text = luaLang("multiple") .. slot2[3]
			end
		elseif slot0._co.itemType == 1 and slot1.buildingId then
			if not string.nilorempty(RoomTradeTaskModel.instance:getBuildingTaskIcon(slot1.buildingId)) then
				slot0._simagepropicon:LoadImage(slot2)
			end

			recthelper.setWidth(slot0._simagepropicon.transform, 308)
			recthelper.setHeight(slot0._simagepropicon.transform, 277.2)

			slot0._txtnum.text = ""
		elseif not string.nilorempty(slot0._co.icon) then
			UISpriteSetMgr.instance:setCritterSprite(slot0._imageicon, slot2)
		end

		slot2 = slot1.type == RoomTradeEnum.LevelUnlock.GetBouns or slot0._co.itemType == 1

		gohelper.setActive(slot0._goprop, slot2)
		gohelper.setActive(slot0._imageicon.gameObject, not slot2)
	end

	if LuaUtil.tableNotEmpty(slot1.num) then
		slot0._txtcur.text = slot1.num.last
		slot0._txtnext.text = slot1.num.cur
	end

	recthelper.setAnchorY(slot0._imageicon.transform, slot2 and 0 or 8)
	gohelper.setActive(slot0._gonum, slot2)
end

return slot0

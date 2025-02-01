module("modules.logic.room.view.building.RoomStrengthView", package.seeall)

slot0 = class("RoomStrengthView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageproducticon = gohelper.findChildSingleImage(slot0.viewGO, "productdetail/#simage_producticon")
	slot0._txtnameEn = gohelper.findChildText(slot0.viewGO, "productdetail/#txt_nameEn")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "productdetail/#txt_name")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "productdetail/#txt_name/#txt_lv")
	slot0._txtnosetting = gohelper.findChildText(slot0.viewGO, "productdetail/#txt_name/#txt_nosetting")
	slot0._goslotitem = gohelper.findChild(slot0.viewGO, "productdetail/scroll_productprop/viewport/content/#go_slotitem")
	slot0._golevelitem = gohelper.findChild(slot0.viewGO, "scroll_level/viewport/content/#go_levelitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

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

function slot0._btnclickOnClick(slot0, slot1)
	slot0._level = slot0._levelItemDict[slot1].level

	slot0:_refreshLevel()
	slot0:_refreshStrength()
end

function slot0._editableInitView(slot0)
	slot0._levelItemDict = {}

	gohelper.setActive(slot0._golevelitem, false)

	slot0._slotItemList = {}

	gohelper.setActive(slot0._goslotitem, false)
end

function slot0._refreshUI(slot0)
	slot0:_refreshLevel()
	slot0:_refreshStrength()
end

function slot0._refreshLevel(slot0)
	for slot5 = 0, RoomConfig.instance:getLevelGroupMaxLevel(slot0._levelGroup) do
		slot6 = slot5

		if not slot0._levelItemDict[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.index = slot5
			slot7.go = gohelper.cloneInPlace(slot0._golevelitem, "item" .. slot5)
			slot7.goselect = gohelper.findChild(slot7.go, "go_beselect")
			slot7.gounselect = gohelper.findChild(slot7.go, "go_unselect")
			slot7.txtlvselect = gohelper.findChildText(slot7.go, "go_beselect/txt_lv")
			slot7.txtlvunselect = gohelper.findChildText(slot7.go, "go_unselect/txt_lv")
			slot7.btnclick = gohelper.findChildButtonWithAudio(slot7.go, "btn_click")

			slot7.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot7.index)

			slot0._levelItemDict[slot5] = slot7
		end

		slot7.level = slot6

		if slot6 > 0 then
			slot7.txtlvselect.text = string.format("Lv.%s", slot6)
			slot7.txtlvunselect.text = string.format("Lv.%s", slot6)
		else
			slot7.txtlvselect.text = luaLang("roomtradeitemdetail_nosetting")
			slot7.txtlvunselect.text = luaLang("roomtradeitemdetail_nosetting")
		end

		gohelper.setActive(slot7.goselect, slot0._level == slot7.level)
		gohelper.setActive(slot7.gounselect, slot0._level ~= slot7.level)
		gohelper.setActive(slot7.go, true)
	end

	for slot5, slot6 in pairs(slot0._levelItemDict) do
		if slot1 < slot5 then
			gohelper.setActive(slot6.go, false)
		end
	end
end

function slot0._refreshStrength(slot0)
	slot1 = slot0._level or 0
	slot2 = RoomConfig.instance:getLevelGroupInfo(slot0._levelGroup, slot1)

	slot0._simageproducticon:LoadImage(ResUrl.getRoomImage("modulepart/" .. slot2.icon))

	slot0._txtname.text = slot2.name
	slot0._txtnameEn.text = slot2.nameEn

	gohelper.setActive(slot0._txtlv.gameObject, slot1 > 0)
	gohelper.setActive(slot0._txtnosetting.gameObject, slot1 <= 0)

	if slot1 > 0 then
		slot0._txtlv.text = string.format("Lv.%s", slot1)
	end

	if slot1 == 0 then
		if not string.nilorempty(slot2.desc) then
			table.insert({}, {
				desc = string.format("<color=#57503B>%s</color>", slot2.desc)
			})
		end
	else
		slot4 = RoomConfig.instance:getLevelGroupConfig(slot0._levelGroup, slot1)

		table.insert(slot3, {
			desc = string.format("<color=#608C54>%s</color>", slot4.desc)
		})

		if slot4.costResource > 0 then
			table.insert(slot3, {
				desc = string.format("<color=#943330>%s+%s</color>", luaLang("roomstrengthview_costresource"), slot4.costResource)
			})
		elseif slot4.costResource < 0 then
			table.insert(slot3, {
				desc = string.format("<color=#608C54>%s-%s</color>", luaLang("roomstrengthview_costresource"), math.abs(slot4.costResource))
			})
		end
	end

	for slot7, slot8 in ipairs(slot3) do
		if not slot0._slotItemList[slot7] then
			slot9 = slot0:getUserDataTb_()
			slot9.go = gohelper.cloneInPlace(slot0._goslotitem, "item" .. slot7)
			slot9.gopoint1 = gohelper.findChild(slot9.go, "go_point1")
			slot9.gopoint2 = gohelper.findChild(slot9.go, "go_point2")
			slot9.txtslotdesc = gohelper.findChildText(slot9.go, "")

			gohelper.setActive(slot9.gopoint1, slot7 % 2 == 1)
			gohelper.setActive(slot9.gopoint2, slot7 % 2 == 0)
			table.insert(slot0._slotItemList, slot9)
		end

		slot9.txtslotdesc.text = slot8.desc

		gohelper.setActive(slot9.go, true)
	end

	for slot7 = #slot3 + 1, #slot0._slotItemList do
		gohelper.setActive(slot0._slotItemList[slot7].go, false)
	end
end

function slot0.onOpen(slot0)
	slot0._levelGroup = slot0.viewParam.levelGroup
	slot0._level = slot0.viewParam.level

	slot0:_refreshUI()
end

function slot0.onUpdateParam(slot0)
	slot0._levelGroup = slot0.viewParam.levelGroup
	slot0._level = slot0.viewParam.level

	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageproducticon:UnLoadImage()

	for slot4, slot5 in pairs(slot0._levelItemDict) do
		slot5.btnclick:RemoveClickListener()
	end
end

return slot0

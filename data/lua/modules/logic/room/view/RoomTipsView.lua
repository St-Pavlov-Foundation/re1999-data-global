module("modules.logic.room.view.RoomTipsView", package.seeall)

slot0 = class("RoomTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "container/title/#txt_name")
	slot0._gotitleLv = gohelper.findChild(slot0.viewGO, "container/title/#txt_name/#go_titleLv")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "container/title/#txt_name/#go_titleLv/#txt_lv")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "container/title/#txt_num")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "container/title/#image_icon")
	slot0._gocurrent = gohelper.findChild(slot0.viewGO, "container/#go_current")
	slot0._gocurrentitem = gohelper.findChild(slot0.viewGO, "container/#go_current/#go_currentitem")
	slot0._gonext = gohelper.findChild(slot0.viewGO, "container/#go_next")
	slot0._gonextline = gohelper.findChild(slot0.viewGO, "container/#go_next/#go_nextline")
	slot0._txtnextmaindesc = gohelper.findChildText(slot0.viewGO, "container/#go_next/next/nextmain/#txt_nextmaindesc")
	slot0._txtnextmainnum = gohelper.findChildText(slot0.viewGO, "container/#go_next/next/nextmain/#txt_nextmainnum")
	slot0._imagenextmain = gohelper.findChildImage(slot0.viewGO, "container/#go_next/next/nextmain/#txt_nextmainnum/resource/#image_nextmain")
	slot0._gonextsub = gohelper.findChild(slot0.viewGO, "container/#go_next/next/#go_nextsub")
	slot0._gonextsubitem = gohelper.findChild(slot0.viewGO, "container/#go_next/next/#go_nextsub/#go_nextsubitem")
	slot0._gosubline = gohelper.findChild(slot0.viewGO, "container/#go_next/next/#go_subline")
	slot0._goline = gohelper.findChild(slot0.viewGO, "container/tips/#go_line")
	slot0._txttipdesc = gohelper.findChildText(slot0.viewGO, "container/tips/#txt_tipdesc")

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

slot0.ViewType = {
	Block = 3,
	PlanShare = 4,
	Character = 2,
	BuildDegree = 1
}

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gocurrentitem, false)

	slot0._currentItemList = {}

	gohelper.setActive(slot0._gonextsubitem, false)

	slot0._nextItemList = {}
end

function slot0._getOrCreateCurrentItemList(slot0, slot1)
	slot2 = {}

	for slot6 = 1, slot1 do
		if not slot0._currentItemList[slot6] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._gocurrentitem, "item" .. tostring(slot6))
			slot7.txtdesc = gohelper.findChildText(slot7.go, "txt_desc")
			slot7.txtnum = gohelper.findChildText(slot7.go, "txt_num")
			slot7.goresourceitem = gohelper.findChild(slot7.go, "txt_num/resource/go_resourceitem")

			gohelper.setActive(slot7.goresourceitem, false)

			slot7.resourceItemList = {}

			table.insert(slot0._currentItemList, slot7)
		end

		gohelper.setActive(slot7.go, true)
		table.insert(slot2, slot7)
	end

	for slot6 = slot1 + 1, #slot0._currentItemList do
		gohelper.setActive(slot0._currentItemList[slot6].go, false)
	end

	return slot2
end

function slot0._getOrCreateNextSubItemList(slot0, slot1)
	slot2 = {}

	for slot6 = 1, slot1 do
		if not slot0._nextItemList[slot6] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._gonextsubitem, "item" .. tostring(slot6))
			slot7.txtdesc = gohelper.findChildText(slot7.go, "txt_desc")
			slot7.txtnum = gohelper.findChildText(slot7.go, "txt_num")
			slot7.goresourceitem = gohelper.findChild(slot7.go, "txt_num/resource/go_resourceitem")

			gohelper.setActive(slot7.goresourceitem, false)

			slot7.resourceItemList = {}

			table.insert(slot0._nextItemList, slot7)
		end

		gohelper.setActive(slot7.go, true)
		table.insert(slot2, slot7)
	end

	for slot6 = slot1 + 1, #slot0._nextItemList do
		gohelper.setActive(slot0._nextItemList[slot6].go, false)
	end

	return slot2
end

function slot0._getOrCreateItemImageItemList(slot0, slot1, slot2)
	slot3 = {}

	for slot7 = 1, slot2 do
		if not slot1.resourceItemList[slot7] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.cloneInPlace(slot1.goresourceitem, "item" .. tostring(slot7))
			slot8.imageicon = gohelper.findChildImage(slot8.go, "")

			table.insert(slot1.resourceItemList, slot8)
		end

		gohelper.setActive(slot8.go, true)
		table.insert(slot3, slot8)
	end

	for slot7 = slot2 + 1, #slot1.resourceItemList do
		gohelper.setActive(slot1.resourceItemList[slot7].go, false)
	end

	return slot3
end

function slot0._refreshUI(slot0)
	if slot0._type == uv0.ViewType.BuildDegree then
		slot0:_refreshBuildDegreeUI()
	elseif slot0._type == uv0.ViewType.Character then
		slot0:_refreshCharacterUI()
	elseif slot0._type == uv0.ViewType.Block then
		slot0:_refreshBlockUI()
	elseif slot0._type == uv0.ViewType.PlanShare then
		slot0:_refreshPlanShareUI()
	end
end

function slot0._refreshBuildDegreeUI(slot0)
	slot1 = RoomMapModel.instance:getAllBuildDegree()
	slot3, slot4, slot5 = RoomConfig.instance:getBuildBonusByBuildDegree(slot1)
	slot0._txtname.text = luaLang("room_topright_builddegree")

	gohelper.setActive(slot0._gotitleLv, true)

	slot0._txtlv.text = string.format("lv.%d", slot5)
	slot0._txtnum.text = tostring(slot1)

	UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "jianshezhi")
	transformhelper.setLocalScale(slot0._imageicon.transform, 1, 1, 1)

	slot0._txttipdesc.text = luaLang("room_topright_builddegree_tips")

	gohelper.setActive(slot0._gocurrent, true)

	slot8 = slot0:_getOrCreateCurrentItemList(2)
	slot9 = slot8[1]
	slot9.txtdesc.text = luaLang("room_topright_builddegree_current_resource")
	slot9.txtnum.text = string.format("+%.1f%%", slot3 / 10)
	slot10 = slot0:_getOrCreateItemImageItemList(slot9, 2)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot10[1].imageicon, "203_1")
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot10[2].imageicon, "205_1")

	slot13 = slot8[2]
	slot13.txtdesc.text = luaLang("room_topright_builddegree_current_character")
	slot13.txtnum.text = tostring(RoomConfig.instance:getCharacterLimitAddByBuildDegree(slot1))

	UISpriteSetMgr.instance:setRoomSprite(slot0:_getOrCreateItemImageItemList(slot13, 1)[1].imageicon, "img_juese")
	gohelper.setActive(slot0._gonext, slot4 > 0)
	gohelper.setActive(slot0._gonextline, true)
	gohelper.setActive(slot0._goline, slot4 < 0)

	if slot4 > 0 then
		slot0._txtnextmaindesc.text = luaLang("room_topright_builddegree_next_title")
		slot0._txtnextmainnum.text = tostring(slot1 + slot4)

		gohelper.setActive(slot0._imagenextmain.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagenextmain, "jianshezhi")

		slot15 = slot0:_getOrCreateNextSubItemList(2)
		slot16 = slot15[1]
		slot16.txtdesc.text = luaLang("room_topright_builddegree_next_resource")
		slot16.txtnum.text = string.format("+%.1f%%", RoomConfig.instance:getBuildBonusByBuildDegree(slot1 + slot4) / 10)
		slot17 = slot0:_getOrCreateItemImageItemList(slot16, 2)

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot17[1].imageicon, "203_1")
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot17[2].imageicon, "205_1")

		slot20 = slot15[2]
		slot20.txtdesc.text = luaLang("room_topright_builddegree_next_character")
		slot20.txtnum.text = tostring(RoomConfig.instance:getCharacterLimitAddByBuildDegree(slot1 + slot4))

		UISpriteSetMgr.instance:setRoomSprite(slot0:_getOrCreateItemImageItemList(slot20, 1)[1].imageicon, "img_juese")
	end
end

function slot0._refreshCharacterUI(slot0)
	slot2 = RoomMapModel.instance:getAllBuildDegree()
	slot3 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(slot2)
	slot4, slot5, slot6 = RoomConfig.instance:getBuildBonusByBuildDegree(slot2)
	slot0._txtname.text = luaLang("room_topright_character")

	gohelper.setActive(slot0._gotitleLv, false)

	slot0._txtnum.text = tostring(RoomCharacterModel.instance:getMaxCharacterCount())

	UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "img_juese")

	slot8 = 1.0666666666666667

	transformhelper.setLocalScale(slot0._imageicon.transform, slot8, slot8, slot8)

	slot0._txttipdesc.text = luaLang("room_topright_character_tips")

	gohelper.setActive(slot0._gocurrent, false)
	gohelper.setActive(slot0._gonext, slot5 > 0)
	gohelper.setActive(slot0._gonextline, false)
	gohelper.setActive(slot0._goline, slot5 > 0)

	if slot5 > 0 then
		slot0._txtnextmaindesc.text = luaLang("room_topright_character_next_title")
		slot0._txtnextmainnum.text = tostring(slot2 + slot5)

		gohelper.setActive(slot0._imagenextmain.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagenextmain, "jianshezhi")

		slot9 = slot0:_getOrCreateNextSubItemList(1)[1]
		slot9.txtdesc.text = luaLang("room_topright_character_next_desc")
		slot9.txtnum.text = tostring(RoomConfig.instance:getCharacterLimitAddByBuildDegree(slot2 + slot5))

		UISpriteSetMgr.instance:setRoomSprite(slot0:_getOrCreateItemImageItemList(slot9, 1)[1].imageicon, "img_juese")
	end
end

function slot0._refreshBlockUI(slot0)
	slot0._txtname.text = luaLang("room_topright_block")

	gohelper.setActive(slot0._gotitleLv, false)

	slot0._txtnum.text = tostring(RoomMapBlockModel.instance:getMaxBlockCount())

	UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "icon_zongkuai_light", true)
	transformhelper.setLocalScale(slot0._imageicon.transform, 0.8, 0.8, 0.8)

	slot0._txttipdesc.text = luaLang("room_topright_block_tips")

	gohelper.setActive(slot0._gocurrent, false)
	gohelper.setActive(slot0._gonext, RoomMapModel.instance:getRoomLevel() < RoomConfig.instance:getMaxRoomLevel())
	gohelper.setActive(slot0._gonextline, false)
	gohelper.setActive(slot0._goline, slot1 < slot3)

	if slot1 < slot3 then
		slot0._txtnextmaindesc.text = luaLang("room_topright_block_next_title")
		slot0._txtnextmainnum.text = string.format("lv.%d", slot1 + 1)

		gohelper.setActive(slot0._imagenextmain.gameObject, false)

		slot5 = slot0:_getOrCreateNextSubItemList(1)[1]
		slot5.txtdesc.text = luaLang("room_topright_block_next_desc")
		slot5.txtnum.text = tostring(RoomMapBlockModel.instance:getMaxBlockCount(slot1 + 1))

		UISpriteSetMgr.instance:setRoomSprite(slot0:_getOrCreateItemImageItemList(slot5, 1)[1].imageicon, "icon_zongkuai_light", true)
	end
end

function slot0._refreshPlanShareUI(slot0)
	slot0._txtname.text = luaLang("room_topright_plan_share_count_name")

	gohelper.setActive(slot0._gotitleLv, false)

	slot0._txtnum.text = tostring(slot0.viewParam and slot0.viewParam.shareCount or 0)

	UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "room_layout_icon_redu", true)
	transformhelper.setLocalScale(slot0._imageicon.transform, 0.8, 0.8, 0.8)

	slot0._txttipdesc.text = luaLang("room_topright_plan_share_count_desc")

	gohelper.setActive(slot0._gocurrent, false)
	gohelper.setActive(slot0._gonext, false)
	gohelper.setActive(slot0._gonextline, false)
	gohelper.setActive(slot0._goline, false)
end

function slot0.onOpen(slot0)
	slot0._type = slot0.viewParam.type

	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

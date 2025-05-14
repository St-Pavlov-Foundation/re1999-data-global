module("modules.logic.room.view.RoomTipsView", package.seeall)

local var_0_0 = class("RoomTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "container/title/#txt_name")
	arg_1_0._gotitleLv = gohelper.findChild(arg_1_0.viewGO, "container/title/#txt_name/#go_titleLv")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "container/title/#txt_name/#go_titleLv/#txt_lv")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "container/title/#txt_num")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "container/title/#image_icon")
	arg_1_0._gocurrent = gohelper.findChild(arg_1_0.viewGO, "container/#go_current")
	arg_1_0._gocurrentitem = gohelper.findChild(arg_1_0.viewGO, "container/#go_current/#go_currentitem")
	arg_1_0._gonext = gohelper.findChild(arg_1_0.viewGO, "container/#go_next")
	arg_1_0._gonextline = gohelper.findChild(arg_1_0.viewGO, "container/#go_next/#go_nextline")
	arg_1_0._txtnextmaindesc = gohelper.findChildText(arg_1_0.viewGO, "container/#go_next/next/nextmain/#txt_nextmaindesc")
	arg_1_0._txtnextmainnum = gohelper.findChildText(arg_1_0.viewGO, "container/#go_next/next/nextmain/#txt_nextmainnum")
	arg_1_0._imagenextmain = gohelper.findChildImage(arg_1_0.viewGO, "container/#go_next/next/nextmain/#txt_nextmainnum/resource/#image_nextmain")
	arg_1_0._gonextsub = gohelper.findChild(arg_1_0.viewGO, "container/#go_next/next/#go_nextsub")
	arg_1_0._gonextsubitem = gohelper.findChild(arg_1_0.viewGO, "container/#go_next/next/#go_nextsub/#go_nextsubitem")
	arg_1_0._gosubline = gohelper.findChild(arg_1_0.viewGO, "container/#go_next/next/#go_subline")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "container/tips/#go_line")
	arg_1_0._txttipdesc = gohelper.findChildText(arg_1_0.viewGO, "container/tips/#txt_tipdesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

var_0_0.ViewType = {
	Block = 3,
	PlanShare = 4,
	Character = 2,
	BuildDegree = 1
}

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gocurrentitem, false)

	arg_5_0._currentItemList = {}

	gohelper.setActive(arg_5_0._gonextsubitem, false)

	arg_5_0._nextItemList = {}
end

function var_0_0._getOrCreateCurrentItemList(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = 1, arg_6_1 do
		local var_6_1 = arg_6_0._currentItemList[iter_6_0]

		if not var_6_1 then
			var_6_1 = arg_6_0:getUserDataTb_()
			var_6_1.go = gohelper.cloneInPlace(arg_6_0._gocurrentitem, "item" .. tostring(iter_6_0))
			var_6_1.txtdesc = gohelper.findChildText(var_6_1.go, "txt_desc")
			var_6_1.txtnum = gohelper.findChildText(var_6_1.go, "txt_num")
			var_6_1.goresourceitem = gohelper.findChild(var_6_1.go, "txt_num/resource/go_resourceitem")

			gohelper.setActive(var_6_1.goresourceitem, false)

			var_6_1.resourceItemList = {}

			table.insert(arg_6_0._currentItemList, var_6_1)
		end

		gohelper.setActive(var_6_1.go, true)
		table.insert(var_6_0, var_6_1)
	end

	for iter_6_1 = arg_6_1 + 1, #arg_6_0._currentItemList do
		local var_6_2 = arg_6_0._currentItemList[iter_6_1]

		gohelper.setActive(var_6_2.go, false)
	end

	return var_6_0
end

function var_0_0._getOrCreateNextSubItemList(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0 = 1, arg_7_1 do
		local var_7_1 = arg_7_0._nextItemList[iter_7_0]

		if not var_7_1 then
			var_7_1 = arg_7_0:getUserDataTb_()
			var_7_1.go = gohelper.cloneInPlace(arg_7_0._gonextsubitem, "item" .. tostring(iter_7_0))
			var_7_1.txtdesc = gohelper.findChildText(var_7_1.go, "txt_desc")
			var_7_1.txtnum = gohelper.findChildText(var_7_1.go, "txt_num")
			var_7_1.goresourceitem = gohelper.findChild(var_7_1.go, "txt_num/resource/go_resourceitem")

			gohelper.setActive(var_7_1.goresourceitem, false)

			var_7_1.resourceItemList = {}

			table.insert(arg_7_0._nextItemList, var_7_1)
		end

		gohelper.setActive(var_7_1.go, true)
		table.insert(var_7_0, var_7_1)
	end

	for iter_7_1 = arg_7_1 + 1, #arg_7_0._nextItemList do
		local var_7_2 = arg_7_0._nextItemList[iter_7_1]

		gohelper.setActive(var_7_2.go, false)
	end

	return var_7_0
end

function var_0_0._getOrCreateItemImageItemList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0 = 1, arg_8_2 do
		local var_8_1 = arg_8_1.resourceItemList[iter_8_0]

		if not var_8_1 then
			var_8_1 = arg_8_0:getUserDataTb_()
			var_8_1.go = gohelper.cloneInPlace(arg_8_1.goresourceitem, "item" .. tostring(iter_8_0))
			var_8_1.imageicon = gohelper.findChildImage(var_8_1.go, "")

			table.insert(arg_8_1.resourceItemList, var_8_1)
		end

		gohelper.setActive(var_8_1.go, true)
		table.insert(var_8_0, var_8_1)
	end

	for iter_8_1 = arg_8_2 + 1, #arg_8_1.resourceItemList do
		local var_8_2 = arg_8_1.resourceItemList[iter_8_1]

		gohelper.setActive(var_8_2.go, false)
	end

	return var_8_0
end

function var_0_0._refreshUI(arg_9_0)
	if arg_9_0._type == var_0_0.ViewType.BuildDegree then
		arg_9_0:_refreshBuildDegreeUI()
	elseif arg_9_0._type == var_0_0.ViewType.Character then
		arg_9_0:_refreshCharacterUI()
	elseif arg_9_0._type == var_0_0.ViewType.Block then
		arg_9_0:_refreshBlockUI()
	elseif arg_9_0._type == var_0_0.ViewType.PlanShare then
		arg_9_0:_refreshPlanShareUI()
	end
end

function var_0_0._refreshBuildDegreeUI(arg_10_0)
	local var_10_0 = RoomMapModel.instance:getAllBuildDegree()
	local var_10_1 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(var_10_0)
	local var_10_2, var_10_3, var_10_4 = RoomConfig.instance:getBuildBonusByBuildDegree(var_10_0)
	local var_10_5 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(var_10_0 + var_10_3)
	local var_10_6 = RoomConfig.instance:getBuildBonusByBuildDegree(var_10_0 + var_10_3)

	arg_10_0._txtname.text = luaLang("room_topright_builddegree")

	gohelper.setActive(arg_10_0._gotitleLv, true)

	arg_10_0._txtlv.text = string.format("lv.%d", var_10_4)
	arg_10_0._txtnum.text = tostring(var_10_0)

	UISpriteSetMgr.instance:setRoomSprite(arg_10_0._imageicon, "jianshezhi")
	transformhelper.setLocalScale(arg_10_0._imageicon.transform, 1, 1, 1)

	arg_10_0._txttipdesc.text = luaLang("room_topright_builddegree_tips")

	gohelper.setActive(arg_10_0._gocurrent, true)

	local var_10_7 = arg_10_0:_getOrCreateCurrentItemList(2)
	local var_10_8 = var_10_7[1]

	var_10_8.txtdesc.text = luaLang("room_topright_builddegree_current_resource")
	var_10_8.txtnum.text = string.format("+%.1f%%", var_10_2 / 10)

	local var_10_9 = arg_10_0:_getOrCreateItemImageItemList(var_10_8, 2)
	local var_10_10 = var_10_9[1]

	UISpriteSetMgr.instance:setCurrencyItemSprite(var_10_10.imageicon, "203_1")

	local var_10_11 = var_10_9[2]

	UISpriteSetMgr.instance:setCurrencyItemSprite(var_10_11.imageicon, "205_1")

	local var_10_12 = var_10_7[2]

	var_10_12.txtdesc.text = luaLang("room_topright_builddegree_current_character")
	var_10_12.txtnum.text = tostring(var_10_1)

	local var_10_13 = arg_10_0:_getOrCreateItemImageItemList(var_10_12, 1)[1]

	UISpriteSetMgr.instance:setRoomSprite(var_10_13.imageicon, "img_juese")
	gohelper.setActive(arg_10_0._gonext, var_10_3 > 0)
	gohelper.setActive(arg_10_0._gonextline, true)
	gohelper.setActive(arg_10_0._goline, var_10_3 < 0)

	if var_10_3 > 0 then
		arg_10_0._txtnextmaindesc.text = luaLang("room_topright_builddegree_next_title")
		arg_10_0._txtnextmainnum.text = tostring(var_10_0 + var_10_3)

		gohelper.setActive(arg_10_0._imagenextmain.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(arg_10_0._imagenextmain, "jianshezhi")

		local var_10_14 = arg_10_0:_getOrCreateNextSubItemList(2)
		local var_10_15 = var_10_14[1]

		var_10_15.txtdesc.text = luaLang("room_topright_builddegree_next_resource")
		var_10_15.txtnum.text = string.format("+%.1f%%", var_10_6 / 10)

		local var_10_16 = arg_10_0:_getOrCreateItemImageItemList(var_10_15, 2)
		local var_10_17 = var_10_16[1]

		UISpriteSetMgr.instance:setCurrencyItemSprite(var_10_17.imageicon, "203_1")

		local var_10_18 = var_10_16[2]

		UISpriteSetMgr.instance:setCurrencyItemSprite(var_10_18.imageicon, "205_1")

		local var_10_19 = var_10_14[2]

		var_10_19.txtdesc.text = luaLang("room_topright_builddegree_next_character")
		var_10_19.txtnum.text = tostring(var_10_5)

		local var_10_20 = arg_10_0:_getOrCreateItemImageItemList(var_10_19, 1)[1]

		UISpriteSetMgr.instance:setRoomSprite(var_10_20.imageicon, "img_juese")
	end
end

function var_0_0._refreshCharacterUI(arg_11_0)
	local var_11_0 = RoomCharacterModel.instance:getMaxCharacterCount()
	local var_11_1 = RoomMapModel.instance:getAllBuildDegree()
	local var_11_2 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(var_11_1)
	local var_11_3, var_11_4, var_11_5 = RoomConfig.instance:getBuildBonusByBuildDegree(var_11_1)
	local var_11_6 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(var_11_1 + var_11_4)

	arg_11_0._txtname.text = luaLang("room_topright_character")

	gohelper.setActive(arg_11_0._gotitleLv, false)

	arg_11_0._txtnum.text = tostring(var_11_0)

	UISpriteSetMgr.instance:setRoomSprite(arg_11_0._imageicon, "img_juese")

	local var_11_7 = 1.0666666666666667

	transformhelper.setLocalScale(arg_11_0._imageicon.transform, var_11_7, var_11_7, var_11_7)

	arg_11_0._txttipdesc.text = luaLang("room_topright_character_tips")

	gohelper.setActive(arg_11_0._gocurrent, false)
	gohelper.setActive(arg_11_0._gonext, var_11_4 > 0)
	gohelper.setActive(arg_11_0._gonextline, false)
	gohelper.setActive(arg_11_0._goline, var_11_4 > 0)

	if var_11_4 > 0 then
		arg_11_0._txtnextmaindesc.text = luaLang("room_topright_character_next_title")
		arg_11_0._txtnextmainnum.text = tostring(var_11_1 + var_11_4)

		gohelper.setActive(arg_11_0._imagenextmain.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(arg_11_0._imagenextmain, "jianshezhi")

		local var_11_8 = arg_11_0:_getOrCreateNextSubItemList(1)[1]

		var_11_8.txtdesc.text = luaLang("room_topright_character_next_desc")
		var_11_8.txtnum.text = tostring(var_11_6)

		local var_11_9 = arg_11_0:_getOrCreateItemImageItemList(var_11_8, 1)[1]

		UISpriteSetMgr.instance:setRoomSprite(var_11_9.imageicon, "img_juese")
	end
end

function var_0_0._refreshBlockUI(arg_12_0)
	local var_12_0 = RoomMapModel.instance:getRoomLevel()
	local var_12_1 = RoomMapBlockModel.instance:getMaxBlockCount()
	local var_12_2 = RoomConfig.instance:getMaxRoomLevel()

	arg_12_0._txtname.text = luaLang("room_topright_block")

	gohelper.setActive(arg_12_0._gotitleLv, false)

	arg_12_0._txtnum.text = tostring(var_12_1)

	UISpriteSetMgr.instance:setRoomSprite(arg_12_0._imageicon, "icon_zongkuai_light", true)
	transformhelper.setLocalScale(arg_12_0._imageicon.transform, 0.8, 0.8, 0.8)

	arg_12_0._txttipdesc.text = luaLang("room_topright_block_tips")

	gohelper.setActive(arg_12_0._gocurrent, false)
	gohelper.setActive(arg_12_0._gonext, var_12_0 < var_12_2)
	gohelper.setActive(arg_12_0._gonextline, false)
	gohelper.setActive(arg_12_0._goline, var_12_0 < var_12_2)

	if var_12_0 < var_12_2 then
		local var_12_3 = RoomMapBlockModel.instance:getMaxBlockCount(var_12_0 + 1)

		arg_12_0._txtnextmaindesc.text = luaLang("room_topright_block_next_title")
		arg_12_0._txtnextmainnum.text = string.format("lv.%d", var_12_0 + 1)

		gohelper.setActive(arg_12_0._imagenextmain.gameObject, false)

		local var_12_4 = arg_12_0:_getOrCreateNextSubItemList(1)[1]

		var_12_4.txtdesc.text = luaLang("room_topright_block_next_desc")
		var_12_4.txtnum.text = tostring(var_12_3)

		local var_12_5 = arg_12_0:_getOrCreateItemImageItemList(var_12_4, 1)[1]

		UISpriteSetMgr.instance:setRoomSprite(var_12_5.imageicon, "icon_zongkuai_light", true)
	end
end

function var_0_0._refreshPlanShareUI(arg_13_0)
	arg_13_0._txtname.text = luaLang("room_topright_plan_share_count_name")

	gohelper.setActive(arg_13_0._gotitleLv, false)

	local var_13_0 = arg_13_0.viewParam and arg_13_0.viewParam.shareCount or 0

	arg_13_0._txtnum.text = tostring(var_13_0)

	UISpriteSetMgr.instance:setRoomSprite(arg_13_0._imageicon, "room_layout_icon_redu", true)
	transformhelper.setLocalScale(arg_13_0._imageicon.transform, 0.8, 0.8, 0.8)

	arg_13_0._txttipdesc.text = luaLang("room_topright_plan_share_count_desc")

	gohelper.setActive(arg_13_0._gocurrent, false)
	gohelper.setActive(arg_13_0._gonext, false)
	gohelper.setActive(arg_13_0._gonextline, false)
	gohelper.setActive(arg_13_0._goline, false)
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0._type = arg_14_0.viewParam.type

	arg_14_0:_refreshUI()
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0

module("modules.logic.room.view.RoomLevelUpTipsView", package.seeall)

local var_0_0 = class("RoomLevelUpTipsView", BaseView)
local var_0_1 = 43

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskbg")
	arg_1_0._txttype = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_type")
	arg_1_0._gopreviouslevel = gohelper.findChild(arg_1_0.viewGO, "levelup/previous/node/#go_previouslevel")
	arg_1_0._txtpreviouslv = gohelper.findChildText(arg_1_0.viewGO, "levelup/previous/#txt_previouslv")
	arg_1_0._gocurrentlevel = gohelper.findChild(arg_1_0.viewGO, "levelup/current/node/#go_currentlevel")
	arg_1_0._txtcurrentlv = gohelper.findChildText(arg_1_0.viewGO, "levelup/current/#txt_currentlv")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "levelupInfo/#go_info")

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

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(arg_5_0._gopreviouslevel, false)
	gohelper.setActive(arg_5_0._gocurrentlevel, false)
	gohelper.setActive(arg_5_0._goinfo, false)

	arg_5_0._previousLevelItemList = {}
	arg_5_0._currentLevelItemList = {}
	arg_5_0._infoItemList = {}
	arg_5_0._btnclose = gohelper.findChildClickWithAudio(arg_5_0.viewGO, "bg")
end

function var_0_0._refreshLevel(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	for iter_6_0 = 1, arg_6_4 do
		local var_6_0 = arg_6_1[iter_6_0]

		if not var_6_0 then
			var_6_0 = arg_6_0:getUserDataTb_()
			var_6_0.go = gohelper.cloneInPlace(arg_6_2, "item" .. iter_6_0)
			var_6_0.golight = gohelper.findChild(var_6_0.go, "active")

			table.insert(arg_6_1, var_6_0)
		end

		gohelper.setActive(var_6_0.golight, iter_6_0 <= arg_6_3)
		gohelper.setActive(var_6_0.go, true)
	end

	for iter_6_1 = arg_6_4 + 1, #arg_6_1 do
		local var_6_1 = arg_6_1[iter_6_1]

		gohelper.setActive(var_6_1.go, false)
	end
end

function var_0_0._playLevelAnimation(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or #arg_7_1 <= 0 then
		return
	end

	for iter_7_0 = 1, arg_7_2 do
		local var_7_0 = arg_7_1[iter_7_0]

		gohelper.setActive(var_7_0.golight, false)
	end

	local var_7_1 = 0.6
	local var_7_2 = 0.06
	local var_7_3 = var_7_1 + (arg_7_2 - 1) * var_7_2

	if arg_7_0._scene and arg_7_0._scene.tween then
		arg_7_0._levelTweenId = arg_7_0._scene.tween:tweenFloat(0, var_7_3, var_7_3, arg_7_0._levelAnimationFrame, arg_7_0._levelAnimationFinish, arg_7_0, {
			delay = var_7_1,
			interval = var_7_2,
			level = arg_7_2,
			duration = var_7_3,
			itemList = arg_7_1
		})
	else
		arg_7_0._levelTweenId = ZProj.TweenHelper.DOTweenFloat(0, var_7_3, var_7_3, arg_7_0._levelAnimationFrame, arg_7_0._levelAnimationFinish, arg_7_0, {
			delay = var_7_1,
			interval = var_7_2,
			level = arg_7_2,
			duration = var_7_3,
			itemList = arg_7_1
		})
	end
end

function var_0_0._levelAnimationFrame(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0 = 1, arg_8_2.level do
		local var_8_0 = arg_8_2.itemList[iter_8_0]

		gohelper.setActive(var_8_0.golight, arg_8_1 >= arg_8_2.delay + (iter_8_0 - 1) * arg_8_2.interval)
	end
end

function var_0_0._levelAnimationFinish(arg_9_0, arg_9_1)
	arg_9_0:_levelAnimationFrame(arg_9_1.duration + 0.001, arg_9_1)
end

function var_0_0.onOpen(arg_10_0)
	if arg_10_0.viewParam.level then
		arg_10_0:_updateLevelInfo(arg_10_0.viewParam.level)
	elseif arg_10_0.viewParam.buildingUid then
		arg_10_0:_updateBuildingLevelInfo(arg_10_0.viewParam.buildingUid)
	else
		arg_10_0:_updateProductLineLevelInfo(arg_10_0.viewParam.productLineMO)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function var_0_0._updateLevelInfo(arg_11_0, arg_11_1)
	arg_11_0._txttype.text = luaLang("room_level_up")
	arg_11_0._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", arg_11_1 - 1)
	arg_11_0._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", arg_11_1)

	local var_11_0 = RoomConfig.instance:getMaxRoomLevel()

	arg_11_0:_refreshLevel(arg_11_0._previousLevelItemList, arg_11_0._gopreviouslevel, arg_11_1 - 1, var_11_0)
	arg_11_0:_refreshLevel(arg_11_0._currentLevelItemList, arg_11_0._gocurrentlevel, arg_11_1, var_11_0)
	arg_11_0:_playLevelAnimation(arg_11_0._currentLevelItemList, arg_11_1)

	local var_11_1 = RoomProductionHelper.getRoomLevelUpParams(arg_11_1 - 1, arg_11_1, true)

	arg_11_0:_refreshDescTips(var_11_1)
end

function var_0_0._updateBuildingLevelInfo(arg_12_0, arg_12_1)
	local var_12_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_12_1)

	arg_12_0._txttype.text = luaLang("room_building_level_up")

	local var_12_1 = 0
	local var_12_2 = 0
	local var_12_3 = 0

	if var_12_0 then
		var_12_3 = var_12_0:getLevel()
		var_12_2 = Mathf.Max(0, var_12_3 - 1)
	end

	arg_12_0._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", var_12_2)
	arg_12_0._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", var_12_3)

	arg_12_0:_refreshLevel(arg_12_0._previousLevelItemList, arg_12_0._gopreviouslevel, var_12_2, var_12_1)
	arg_12_0:_refreshLevel(arg_12_0._currentLevelItemList, arg_12_0._gocurrentlevel, var_12_3, var_12_1)
	arg_12_0:_playLevelAnimation(arg_12_0._currentLevelItemList, var_12_3)

	local var_12_4 = RoomHelper.getBuildingLevelUpTipsParam(arg_12_1)

	arg_12_0:_refreshDescTips(var_12_4)
end

function var_0_0._updateProductLineLevelInfo(arg_13_0, arg_13_1)
	arg_13_0._txttype.text = luaLang("room_production_line_level_up")
	arg_13_0._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", arg_13_1.level - 1)
	arg_13_0._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", arg_13_1.level)

	arg_13_0:_refreshLevel(arg_13_0._previousLevelItemList, arg_13_0._gopreviouslevel, arg_13_1.level - 1, arg_13_1.maxLevel)
	arg_13_0:_refreshLevel(arg_13_0._currentLevelItemList, arg_13_0._gocurrentlevel, arg_13_1.level, arg_13_1.maxLevel)
	arg_13_0:_playLevelAnimation(arg_13_0._currentLevelItemList, arg_13_1.level)

	local var_13_0 = RoomProductionHelper.getProductLineLevelUpParams(arg_13_1.id, arg_13_1.level - 1, arg_13_1.level, true)

	arg_13_0:_refreshDescTips(var_13_0)
end

function var_0_0._refreshDescTips(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_0 = arg_14_0._infoItemList[iter_14_0]

		if not var_14_0 then
			var_14_0 = arg_14_0:getUserDataTb_()
			var_14_0.go = gohelper.cloneInPlace(arg_14_0._goinfo, "item" .. iter_14_0)
			var_14_0.trans = var_14_0.go.transform
			var_14_0.gonormal = gohelper.findChild(var_14_0.go, "#go_normal")
			var_14_0.txtinfo = gohelper.findChildText(var_14_0.go, "#go_normal/txt_info")
			var_14_0.gohasNewItem = gohelper.findChild(var_14_0.go, "#go_hasNewItem")
			var_14_0.txtnewItemInfo = gohelper.findChildText(var_14_0.go, "#go_hasNewItem/txt_newItemInfo")
			var_14_0.goNewItemLayout = gohelper.findChild(var_14_0.go, "#go_hasNewItem/#go_newItemLayout")
			var_14_0.goNewItem = gohelper.findChild(var_14_0.go, "#go_hasNewItem/#go_newItemLayout/#go_newItem")

			table.insert(arg_14_0._infoItemList, var_14_0)
		end

		local var_14_1 = iter_14_1.newItemInfoList and true or false
		local var_14_2 = recthelper.getHeight(var_14_0.trans)

		if var_14_1 then
			var_14_2 = recthelper.getHeight(var_14_0.goNewItemLayout.transform)
			var_14_0.txtnewItemInfo.text = iter_14_1.desc

			gohelper.CreateObjList(arg_14_0, arg_14_0._onSetNewItem, iter_14_1.newItemInfoList, var_14_0.goNewItemLayout, var_14_0.goNewItem)
		else
			var_14_0.txtinfo.text = iter_14_1.desc
		end

		recthelper.setHeight(var_14_0.trans, var_14_2)
		gohelper.setActive(var_14_0.gonormal, not var_14_1)
		gohelper.setActive(var_14_0.gohasNewItem, var_14_1)
		gohelper.setActive(var_14_0.go, true)
	end

	for iter_14_2 = #arg_14_1 + 1, #arg_14_0._infoItemList do
		local var_14_3 = arg_14_0._infoItemList[iter_14_2]

		gohelper.setActive(var_14_3.go, false)
	end
end

function var_0_0._onSetNewItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_2.type
	local var_15_1 = arg_15_2.id
	local var_15_2 = arg_15_2.quantity or 0
	local var_15_3 = IconMgr.instance:getCommonItemIcon(arg_15_1)

	var_15_3:setCountFontSize(var_0_1)
	var_15_3:setMOValue(var_15_0, var_15_1, var_15_2)
	var_15_3:isShowCount(var_15_2 ~= 0)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0._levelTweenId then
		if arg_17_0._scene and arg_17_0._scene.tween then
			arg_17_0._scene.tween:killById(arg_17_0._levelTweenId)
		else
			ZProj.TweenHelper.KillById(arg_17_0._levelTweenId)
		end

		arg_17_0._levelTweenId = nil
	end
end

return var_0_0

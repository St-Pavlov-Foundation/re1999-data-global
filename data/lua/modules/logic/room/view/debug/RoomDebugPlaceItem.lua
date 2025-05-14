module("modules.logic.room.view.debug.RoomDebugPlaceItem", package.seeall)

local var_0_0 = class("RoomDebugPlaceItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._icon = gohelper.onceAddComponent(gohelper.findChild(arg_1_0.viewGO, "icon"), gohelper.Type_RawImage)
	arg_1_0._txtdefineid = gohelper.findChildText(arg_1_0.viewGO, "#txt_defineid")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._txtuseCount = gohelper.findChildText(arg_1_0.viewGO, "#txt_useCount")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugReplaceBlock, arg_2_0._delayUpdateTask, arg_2_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBlock, arg_2_0._delayUpdateTask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugReplaceBlock, arg_3_0._delayUpdateTask, arg_3_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBlock, arg_3_0._delayUpdateTask, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	RoomDebugPlaceListModel.instance:setSelect(arg_4_0._mo.id)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._isSelect = false

	gohelper.addUIClickAudio(arg_5_0._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0._txtdefineid.text = "资源id：" .. arg_6_0._mo.id
	arg_6_0._txtname.text = RoomHelper.getBlockPrefabName(arg_6_0._mo.config.prefabPath)
	arg_6_0._txtuseCount.text = string.format("使用总次数：%s\n本地图次数：%s", RoomDebugController.instance:getUseCountByDefineId(arg_6_0._mo.id), arg_6_0:_getMapUseCountByDefineId(arg_6_0._mo.id))
end

function var_0_0._getMapUseCountByDefineId(arg_7_0, arg_7_1)
	local var_7_0 = RoomMapBlockModel.instance:getFullBlockMOList()
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.blockState == RoomBlockEnum.BlockState.Map and iter_7_1.blockId > 0 and iter_7_1.defineId == arg_7_1 then
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_1
end

function var_0_0._delayUpdateTask(arg_8_0)
	if not arg_8_0._hasDelayUpdateTask then
		arg_8_0._hasDelayUpdateTask = true

		TaskDispatcher.runDelay(arg_8_0._onRunDelayUpdateTask, arg_8_0, 0.1)
	end
end

function var_0_0._onRunDelayUpdateTask(arg_9_0)
	if arg_9_0._hasDelayUpdateTask then
		arg_9_0._hasDelayUpdateTask = false

		arg_9_0:_refreshUI()
	end
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselect, arg_10_0._isSelect)

	if arg_10_0._mo then
		local var_10_0 = arg_10_0._mo.blockId
	end

	arg_10_0._mo = arg_10_1

	arg_10_0:_refreshBlock(arg_10_1 and arg_10_1.blockId)
	arg_10_0:_refreshUI()
end

function var_0_0._refreshBlock(arg_11_0, arg_11_1)
	local var_11_0 = GameSceneMgr.instance:getCurScene()
	local var_11_1 = arg_11_0._lastOldBlockId

	arg_11_0._lastOldBlockId = arg_11_1

	if var_11_1 then
		var_11_0.inventorymgr:removeBlockEntity(var_11_1)
	end

	gohelper.setActive(arg_11_0._icon, arg_11_1 and true or false)

	if arg_11_1 then
		var_11_0.inventorymgr:addBlockEntity(arg_11_1)

		local var_11_2 = var_11_0.inventorymgr:getIndexById(arg_11_1)

		OrthCameraRTMgr.instance:setRawImageUvRect(arg_11_0._icon, var_11_2)
	end
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goselect, arg_12_1)

	arg_12_0._isSelect = arg_12_1
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0:_refreshBlock(nil)
	TaskDispatcher.cancelTask(arg_13_0._onRunDelayUpdateTask, arg_13_0)
end

return var_0_0

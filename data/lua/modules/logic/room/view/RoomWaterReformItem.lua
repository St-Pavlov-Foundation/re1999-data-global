module("modules.logic.room.view.RoomWaterReformItem", package.seeall)

local var_0_0 = class("RoomWaterReformItem", ListScrollCellExtend)
local var_0_1 = "#BFB5A3"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "go_empty")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "go_icon")
	arg_1_0._btnItem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_icon")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "go_locked")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "#go_num")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_num/#txt_num")
	arg_1_0._rawImageIcon = gohelper.onceAddComponent(arg_1_0._goicon, gohelper.Type_RawImage)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnItem:AddClickListener(arg_2_0._onBtnItemClick, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_2_0._waterReformShowChanged, arg_2_0)
	arg_2_0:addEventCb(UnlockVoucherController.instance, UnlockVoucherEvent.OnUpdateUnlockVoucherInfo, arg_2_0._onVoucherInfoChange, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.OnRoomBlockReform, arg_2_0._onRoomBlockReform, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnItem:RemoveClickListener()
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_3_0._waterReformShowChanged, arg_3_0)
	arg_3_0:removeEventCb(UnlockVoucherController.instance, UnlockVoucherEvent.OnUpdateUnlockVoucherInfo, arg_3_0._onVoucherInfoChange, arg_3_0)
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.OnRoomBlockReform, arg_3_0._onRoomBlockReform, arg_3_0)
end

function var_0_0._onBtnItemClick(arg_4_0)
	if not arg_4_0._mo then
		return
	end

	if arg_4_0._mo.waterType then
		RoomWaterReformController.instance:selectWaterType(arg_4_0._mo.waterType)
	elseif arg_4_0._mo.blockColor then
		RoomWaterReformController.instance:selectBlockColorType(arg_4_0._mo.blockColor)
	end
end

function var_0_0._waterReformShowChanged(arg_5_0)
	if RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	if arg_5_0._rawImageIcon then
		arg_5_0._rawImageIcon.texture = nil
	end

	arg_5_0:clearItem()
end

function var_0_0._onVoucherInfoChange(arg_6_0)
	if not arg_6_0._mo or not arg_6_0._mo.blockColor then
		return
	end

	arg_6_0:_refreshLocked()
end

function var_0_0._onRoomBlockReform(arg_7_0)
	arg_7_0:_refreshNum()
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.setActive(arg_8_0._goempty, false)

	arg_8_0._rtIndex = OrthCameraRTMgr.instance:getNewIndex()

	OrthCameraRTMgr.instance:setRawImageUvRect(arg_8_0._rawImageIcon, arg_8_0._rtIndex)
	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._rawImageIcon, var_0_1)

	arg_8_0._scene = GameSceneMgr.instance:getCurScene()
	arg_8_0._backBlockIds = {}
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 and arg_9_1.blockId
	local var_9_1 = arg_9_0._mo and arg_9_0._mo.blockId

	if var_9_0 and var_9_0 ~= var_9_1 then
		arg_9_0:clearItem()

		arg_9_0._mo = arg_9_1

		arg_9_0:_refreshBlock()
	end

	arg_9_0:_refreshLocked()
	arg_9_0:_refreshNum()
end

function var_0_0._refreshBlock(arg_10_0)
	local var_10_0 = arg_10_0._mo and arg_10_0._mo.blockId

	if not var_10_0 then
		return
	end

	arg_10_0._scene.inventorymgr:addBlockEntity(var_10_0, true)

	local var_10_1 = arg_10_0._scene.inventorymgr:getIndexById(var_10_0)

	OrthCameraRTMgr.instance:setRawImageUvRect(arg_10_0._rawImageIcon, var_10_1)
end

function var_0_0._refreshLocked(arg_11_0)
	local var_11_0 = false

	if arg_11_0._mo.waterType then
		var_11_0 = RoomWaterReformModel.instance:isUnlockWaterReform(arg_11_0._mo.waterType)
	elseif arg_11_0._mo.blockColor then
		var_11_0 = RoomWaterReformModel.instance:isUnlockBlockColor(arg_11_0._mo.blockColor)
	end

	gohelper.setActive(arg_11_0._golocked, not var_11_0)
end

function var_0_0._refreshNum(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = arg_12_0._mo and arg_12_0._mo.blockColor

	if var_12_1 then
		var_12_0 = RoomWaterReformModel.instance:getChangedBlockColorCount(var_12_1)
	end

	arg_12_0._txtnum.text = var_12_0

	gohelper.setActive(arg_12_0._gonum, var_12_0 > 0)
end

function var_0_0.clearItem(arg_13_0)
	local var_13_0 = arg_13_0._mo and arg_13_0._mo.blockId

	if not var_13_0 then
		return
	end

	arg_13_0._scene.inventorymgr:removeBlockEntity(var_13_0)

	arg_13_0._mo = nil
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._goselect, arg_14_1)
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._rawImageIcon then
		arg_15_0._rawImageIcon.texture = nil
	end

	arg_15_0:clearItem()
end

return var_0_0

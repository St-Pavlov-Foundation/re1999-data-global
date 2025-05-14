module("modules.logic.room.view.RoomWaterReformItem", package.seeall)

local var_0_0 = class("RoomWaterReformItem", ListScrollCellExtend)
local var_0_1 = "#BFB5A3"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "go_empty")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "go_icon")
	arg_1_0._btnItem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_icon")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "go_locked")
	arg_1_0._rawImageIcon = gohelper.onceAddComponent(arg_1_0._goicon, gohelper.Type_RawImage)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnItem:AddClickListener(arg_2_0._onBtnItemClick, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_2_0._waterReformShowChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnItem:RemoveClickListener()
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_3_0._waterReformShowChanged, arg_3_0)
end

function var_0_0._onBtnItemClick(arg_4_0)
	if not arg_4_0._mo then
		return
	end

	RoomWaterReformController.instance:selectWaterType(arg_4_0._mo.waterType)
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

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goempty, false)

	arg_6_0._rtIndex = OrthCameraRTMgr.instance:getNewIndex()

	OrthCameraRTMgr.instance:setRawImageUvRect(arg_6_0._rawImageIcon, arg_6_0._rtIndex)
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._rawImageIcon, var_0_1)

	arg_6_0._scene = GameSceneMgr.instance:getCurScene()
	arg_6_0._backBlockIds = {}
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 and arg_7_1.blockId
	local var_7_1 = arg_7_0._mo and arg_7_0._mo.blockId

	if var_7_0 and var_7_0 ~= var_7_1 then
		arg_7_0:clearItem()

		arg_7_0._mo = arg_7_1

		arg_7_0:_refreshBlock()
	end

	arg_7_0:_refreshLocked()
end

function var_0_0._refreshBlock(arg_8_0)
	local var_8_0 = arg_8_0._mo and arg_8_0._mo.blockId

	if not var_8_0 then
		return
	end

	arg_8_0._scene.inventorymgr:addBlockEntity(var_8_0, true)

	local var_8_1 = arg_8_0._scene.inventorymgr:getIndexById(var_8_0)

	OrthCameraRTMgr.instance:setRawImageUvRect(arg_8_0._rawImageIcon, var_8_1)
end

function var_0_0._refreshLocked(arg_9_0)
	local var_9_0 = RoomWaterReformModel.instance:isUnlockWaterReform(arg_9_0._mo.waterType)

	gohelper.setActive(arg_9_0._golocked, not var_9_0)
end

function var_0_0.clearItem(arg_10_0)
	local var_10_0 = arg_10_0._mo and arg_10_0._mo.blockId

	if not var_10_0 then
		return
	end

	arg_10_0._scene.inventorymgr:removeBlockEntity(var_10_0)

	arg_10_0._mo = nil
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goselect, arg_11_1)
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._rawImageIcon then
		arg_12_0._rawImageIcon.texture = nil
	end

	arg_12_0:clearItem()
end

return var_0_0

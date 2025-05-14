module("modules.logic.room.view.manufacture.RoomManufactureCritterInfo", package.seeall)

local var_0_0 = class("RoomManufactureCritterInfo", LuaCompBase)
local var_0_1 = "critterInfo"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gohas = gohelper.findChild(arg_1_0.go, "#go_has")
	arg_1_0._gocrittericon = gohelper.findChild(arg_1_0.go, "#go_has/#go_critterIcon")
	arg_1_0._gonone = gohelper.findChild(arg_1_0.go, "#go_none")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.go, "#go_selected")
	arg_1_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_1_0.go, "#btn_click")
	arg_1_0._goplaceEff = gohelper.findChild(arg_1_0.go, "#add")

	arg_1_0:reset()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, arg_2_0._onChangeSelectedCritterSlotItem, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, arg_2_0._onCritterWorkInfoChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.PlayAddCritterEff, arg_2_0._onAddCritter, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, arg_3_0._onChangeSelectedCritterSlotItem, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, arg_3_0._onCritterWorkInfoChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.PlayAddCritterEff, arg_3_0._onAddCritter, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._onClick(arg_4_0)
	local var_4_0 = arg_4_0:getViewBuilding()

	if arg_4_0.parent and arg_4_0.parent.setViewBuildingUid then
		arg_4_0.parent:setViewBuildingUid()
	end

	ManufactureController.instance:clickCritterSlotItem(var_4_0, arg_4_0.critterSlotId)
end

function var_0_0._onChangeSelectedCritterSlotItem(arg_5_0)
	arg_5_0:refreshSelected()
end

function var_0_0._onCritterWorkInfoChange(arg_6_0)
	arg_6_0:setCritter()
	arg_6_0:refresh()
end

function var_0_0._onAddCritter(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or arg_7_2 then
		return
	end

	local var_7_0 = arg_7_0:getViewBuilding()

	if arg_7_1[var_7_0] and arg_7_1[var_7_0][arg_7_0.critterSlotId] then
		arg_7_0:playPlaceCritterEff()
	end
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.RoomCritterOneKeyView and arg_8_0._playEffWaitCloseView then
		arg_8_0:playPlaceCritterEff()
	end
end

function var_0_0.getViewBuilding(arg_9_0)
	local var_9_0
	local var_9_1

	if arg_9_0.parent then
		var_9_0, var_9_1 = arg_9_0.parent:getViewBuilding()
	end

	return var_9_0, var_9_1
end

function var_0_0.setData(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.critterSlotId = arg_10_1
	arg_10_0.index = arg_10_2
	arg_10_0.parent = arg_10_3
	arg_10_0._playEffWaitCloseView = false

	local var_10_0 = string.format("id-%s_i-%s", arg_10_0.critterSlotId, arg_10_0.index)

	arg_10_0.go.name = var_10_0

	arg_10_0:setCritter()
	arg_10_0:refresh()
	gohelper.setActive(arg_10_0._goplaceEff, false)
	gohelper.setActive(arg_10_0.go, true)
end

function var_0_0.setCritter(arg_11_0)
	local var_11_0, var_11_1 = arg_11_0:getViewBuilding()
	local var_11_2 = var_11_1 and var_11_1:getWorkingCritter(arg_11_0.critterSlotId)

	if var_11_2 then
		if not arg_11_0.critterIcon then
			arg_11_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_11_0._gocrittericon)
		end

		arg_11_0.critterIcon:setMOValue(var_11_2)
		arg_11_0.critterIcon:showMood()
	end

	gohelper.setActive(arg_11_0._gohas, var_11_2)
	gohelper.setActive(arg_11_0._gonone, not var_11_2)
end

function var_0_0.refresh(arg_12_0)
	arg_12_0:refreshSelected()
end

function var_0_0.refreshSelected(arg_13_0)
	local var_13_0 = false

	if arg_13_0.critterSlotId then
		local var_13_1 = arg_13_0:getViewBuilding()
		local var_13_2, var_13_3 = ManufactureModel.instance:getSelectedCritterSlot()

		if var_13_1 and var_13_1 == var_13_2 then
			var_13_0 = true
		end
	end

	gohelper.setActive(arg_13_0._goselected, var_13_0)
end

function var_0_0.playPlaceCritterEff(arg_14_0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterOneKeyView) then
		arg_14_0._playEffWaitCloseView = true
	else
		gohelper.setActive(arg_14_0._goplaceEff, false)
		gohelper.setActive(arg_14_0._goplaceEff, true)

		arg_14_0._playEffWaitCloseView = false
	end
end

function var_0_0.reset(arg_15_0)
	arg_15_0.critterSlotId = nil
	arg_15_0.index = nil
	arg_15_0.parent = nil
	arg_15_0.go.name = var_0_1
	arg_15_0._playEffWaitCloseView = false

	gohelper.setActive(arg_15_0._goplaceEff, false)
	gohelper.setActive(arg_15_0.go, false)
end

function var_0_0.onDestroy(arg_16_0)
	return
end

return var_0_0

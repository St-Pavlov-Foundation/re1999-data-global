module("modules.logic.room.view.manufacture.RoomTransportCritterInfo", package.seeall)

local var_0_0 = class("RoomTransportCritterInfo", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gohas = gohelper.findChild(arg_1_0.go, "#go_has")
	arg_1_0._gocrittericon = gohelper.findChild(arg_1_0.go, "#go_has/#go_critterIcon")
	arg_1_0._gonone = gohelper.findChild(arg_1_0.go, "#go_none")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.go, "#go_selected")
	arg_1_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_1_0.go, "#btn_click")
	arg_1_0._goplaceEff = gohelper.findChild(arg_1_0.go, "#add")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, arg_2_0._onChangeSelectedTransportPath, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.PlayAddCritterEff, arg_2_0._onAddCritter, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, arg_3_0._onChangeSelectedTransportPath, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.PlayAddCritterEff, arg_3_0._onAddCritter, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._onClick(arg_4_0)
	ManufactureController.instance:clickTransportCritterSlotItem(arg_4_0.pathId)
end

function var_0_0._onChangeSelectedTransportPath(arg_5_0)
	arg_5_0:refreshSelected()
end

function var_0_0._onAddCritter(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return
	end

	if arg_6_1[arg_6_0.pathId] then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1[arg_6_0.pathId]) do
			if arg_6_0.critterUid == iter_6_1 then
				arg_6_0:playPlaceCritterEff()

				break
			end
		end
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.RoomCritterOneKeyView and arg_7_0._playEffWaitCloseView then
		arg_7_0:playPlaceCritterEff()
	end
end

function var_0_0.setData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.critterUid = arg_8_1
	arg_8_0.pathId = arg_8_2
	arg_8_0._playEffWaitCloseView = false

	arg_8_0:setCritter()
	arg_8_0:refresh()
	gohelper.setActive(arg_8_0.go, true)
end

function var_0_0.setCritter(arg_9_0)
	if arg_9_0.critterUid then
		if not arg_9_0.critterIcon then
			arg_9_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_9_0._gocrittericon)
		end

		arg_9_0.critterIcon:setMOValue(arg_9_0.critterUid)
		arg_9_0.critterIcon:showMood()
	end

	gohelper.setActive(arg_9_0._gohas, arg_9_0.critterUid)
	gohelper.setActive(arg_9_0._gonone, not arg_9_0.critterUid)
end

function var_0_0.refresh(arg_10_0)
	arg_10_0:refreshSelected()
end

function var_0_0.refreshSelected(arg_11_0)
	local var_11_0 = false

	if arg_11_0.pathId and ManufactureModel.instance:getSelectedTransportPath() == arg_11_0.pathId then
		var_11_0 = true
	end

	gohelper.setActive(arg_11_0._goselected, var_11_0)
end

function var_0_0.playPlaceCritterEff(arg_12_0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterOneKeyView) then
		arg_12_0._playEffWaitCloseView = true
	else
		gohelper.setActive(arg_12_0._goplaceEff, false)
		gohelper.setActive(arg_12_0._goplaceEff, true)

		arg_12_0._playEffWaitCloseView = false
	end
end

function var_0_0.onDestroy(arg_13_0)
	return
end

return var_0_0

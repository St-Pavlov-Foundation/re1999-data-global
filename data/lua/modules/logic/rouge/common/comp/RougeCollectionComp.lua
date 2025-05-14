module("modules.logic.rouge.common.comp.RougeCollectionComp", package.seeall)

local var_0_0 = class("RougeCollectionComp", RougeLuaCompBase)

function var_0_0.Get(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.go = arg_2_1
	arg_2_0._gostate1 = gohelper.findChild(arg_2_0.go, "Root/#go_state1")
	arg_2_0._gostate2 = gohelper.findChild(arg_2_0.go, "Root/#go_state2")
	arg_2_0._goicon = gohelper.findChild(arg_2_0.go, "Root/#go_state1/#go_icon")
	arg_2_0._gostate2Normal = gohelper.findChild(arg_2_0.go, "Root/#go_state2/#go_Normal")
	arg_2_0._gostate2Light = gohelper.findChild(arg_2_0.go, "Root/#go_state2/#go_Light")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.go, "Root/#btn_click")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)

	arg_3_0._animator = gohelper.onceAddComponent(arg_3_0.go, gohelper.Type_Animator)
	arg_3_0._slotComp = RougeCollectionSlotComp.Get(arg_3_0._goicon, RougeCollectionHelper.BagEntrySlotParam)

	arg_3_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, arg_3_0.placeCollection2SlotArea, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	RougeController.instance:openRougeCollectionChessView()
end

function var_0_0.onOpen(arg_5_0, arg_5_1)
	local var_5_0 = RougeCollectionModel.instance:getSlotAreaCollection()
	local var_5_1 = RougeCollectionModel.instance:getCurSlotAreaSize()
	local var_5_2 = var_5_1.col
	local var_5_3 = var_5_1.row

	arg_5_0._slotComp:onUpdateMO(var_5_2, var_5_3, var_5_0)
	arg_5_0:switchEntryState(arg_5_1)
	arg_5_0:tickUpdateDLCs()
end

function var_0_0.onClose(arg_6_0)
	return
end

function var_0_0.switchEntryState(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or RougeEnum.CollectionEntryState.Grid

	if arg_7_0._curState == arg_7_1 then
		return
	end

	arg_7_0._curState = arg_7_1

	if arg_7_1 == RougeEnum.CollectionEntryState.Icon then
		arg_7_0:onSwitch2IconState()
	elseif arg_7_1 == RougeEnum.CollectionEntryState.Grid then
		arg_7_0:onSwitch2GridState()
	end
end

function var_0_0.onSwitch2IconState(arg_8_0)
	arg_8_0:setState2IconLight(false)
	arg_8_0._animator:Play("swicth_state2", 0, 0)
end

function var_0_0.onSwitch2GridState(arg_9_0)
	arg_9_0._animator:Play("swicth_state1", 0, 0)
end

function var_0_0.setState2IconLight(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._gostate2Normal, not arg_10_1)
	gohelper.setActive(arg_10_0._gostate2Light, arg_10_1)
end

function var_0_0.placeCollection2SlotArea(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = RougeCollectionHelper.isNewGetCollection(arg_11_2)

	if arg_11_1 and var_11_0 and arg_11_0._curState == RougeEnum.CollectionEntryState.Icon then
		arg_11_0:setState2IconLight(true)
	end
end

function var_0_0.destroy(arg_12_0)
	arg_12_0._btnclick:RemoveClickListener()

	if arg_12_0._slotComp then
		arg_12_0._slotComp:destroy()
	end

	arg_12_0:__onDispose()
end

return var_0_0

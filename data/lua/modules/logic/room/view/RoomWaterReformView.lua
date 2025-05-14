module("modules.logic.room.view.RoomWaterReformView", package.seeall)

local var_0_0 = class("RoomWaterReformView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_save")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_reset")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_tip")
	arg_1_0._goblockContent = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#go_blockContent")
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._contentAnimator = arg_1_0._goblockContent:GetComponent(RoomEnum.ComponentType.Animator)
	arg_1_0._contentAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goblockContent)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsave:AddClickListener(arg_2_0._btnsaveOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_2_0._waterReformShowChanged, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformSelectWaterChange, arg_2_0.refreshSelectWater, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsave:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_3_0._waterReformShowChanged, arg_3_0)
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformSelectWaterChange, arg_3_0.refreshSelectWater, arg_3_0)
end

function var_0_0._btnsaveOnClick(arg_4_0)
	RoomWaterReformController.instance:saveReform()
end

function var_0_0._btnresetOnClick(arg_5_0)
	if RoomWaterReformModel.instance:hasChangedWaterType() then
		GameFacade.showMessageBox(MessageBoxIdDefine.WaterReformResetConfirm, MsgBoxEnum.BoxType.Yes_No, arg_5_0._confirmReset, nil, nil, arg_5_0)
	else
		GameFacade.showToast(ToastEnum.NoWaterReform)
	end
end

function var_0_0._confirmReset(arg_6_0)
	RoomWaterReformController.instance:resetReform()
end

function var_0_0._waterReformShowChanged(arg_7_0)
	if RoomWaterReformModel.instance:isWaterReform() then
		arg_7_0._animatorPlayer:Play("open")
		arg_7_0:refreshUI()
	else
		arg_7_0._animatorPlayer:Play("close", arg_7_0._showBackBlock, arg_7_0)
	end
end

function var_0_0._showBackBlock(arg_8_0)
	arg_8_0.viewContainer:selectBlockOpTab(RoomEnum.RoomViewBlockOpMode.BackBlock)
end

function var_0_0._editableInitView(arg_9_0)
	return
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.showWaterType = nil

	gohelper.setActive(arg_11_0._gotip, false)
	arg_11_0:refreshUI(true)
end

function var_0_0.refreshUI(arg_12_0, arg_12_1)
	arg_12_0:refreshSelectWater(arg_12_1)
end

function var_0_0.refreshSelectWater(arg_13_0, arg_13_1)
	local var_13_0 = RoomWaterReformListModel.instance:getDefaultSelectWaterType()

	RoomWaterReformListModel.instance:setSelectWaterType(var_13_0)

	local var_13_1 = RoomWaterReformModel.instance:hasSelectWaterArea()

	if arg_13_0.showWaterType ~= nil and arg_13_0.showWaterType == var_13_1 then
		return
	end

	if var_13_1 then
		gohelper.setActive(arg_13_0._gotip, false)
		arg_13_0._contentAnimatorPlayer:Play("open")
	elseif arg_13_1 then
		arg_13_0:showTip()
		arg_13_0._contentAnimator:Play("close", 0, 1)
	else
		arg_13_0._contentAnimatorPlayer:Play("close", arg_13_0.showTip, arg_13_0)
	end

	arg_13_0.showWaterType = var_13_1
end

function var_0_0.showTip(arg_14_0)
	gohelper.setActive(arg_14_0._gotip, true)
end

function var_0_0.onClose(arg_15_0)
	arg_15_0.showWaterType = nil
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0

module("modules.logic.room.view.backpack.RoomCritterDecomposeItem", package.seeall)

local var_0_0 = class("RoomCritterDecomposeItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocritterIcon = gohelper.findChild(arg_1_0.viewGO, "#go_critterIcon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._goAni = gohelper.findChild(arg_1_0.viewGO, "vx_compose")
	arg_1_0.click = gohelper.getClickWithDefaultAudio(arg_1_0.viewGO)
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.click:AddClickListener(arg_2_0.onClick, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, arg_2_0.refreshSelected, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.BeforeDecomposeCritter, arg_2_0.beforeDecompose, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, arg_2_0._onCritterLockStatusChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.click:RemoveClickListener()
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, arg_3_0.refreshSelected, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.BeforeDecomposeCritter, arg_3_0.beforeDecompose, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, arg_3_0._onCritterLockStatusChange, arg_3_0)
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0._mo:isLock() then
		GameFacade.showToast(ToastEnum.RoomCritterIsLock)

		return
	end

	local var_4_0 = arg_4_0._mo:getId()

	if RoomCritterDecomposeListModel.instance:isSelect(var_4_0) then
		RoomCritterDecomposeListModel.instance:unselectDecomposeCritter(arg_4_0._mo)
	else
		RoomCritterDecomposeListModel.instance:selectDecomposeCritter(arg_4_0._mo)
	end
end

function var_0_0.beforeDecompose(arg_5_0)
	local var_5_0 = arg_5_0._mo:getId()

	if RoomCritterDecomposeListModel.instance:isSelect(var_5_0) then
		gohelper.setActive(arg_5_0._goAni, true)
	end
end

function var_0_0._onCritterLockStatusChange(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._mo and arg_6_0._mo:getId()

	if not arg_6_0._critterIcon or not var_6_0 or var_6_0 ~= arg_6_1 then
		return
	end

	arg_6_0._critterIcon:refreshLockIcon()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	if not arg_8_0._critterIcon then
		arg_8_0._critterIcon = IconMgr.instance:getCommonCritterIcon(arg_8_0._gocritterIcon)

		arg_8_0._critterIcon:setCanClick(false)
		arg_8_0._critterIcon:setLockIconShow(true)
		arg_8_0._critterIcon:setMaturityIconShow(true)
	end

	arg_8_0._critterIcon:onUpdateMO(arg_8_0._mo)
	arg_8_0:refreshSelected()
	gohelper.setActive(arg_8_0._goAni, false)
end

function var_0_0.refreshSelected(arg_9_0)
	local var_9_0 = arg_9_0._mo:getId()
	local var_9_1 = RoomCritterDecomposeListModel.instance:isSelect(var_9_0)

	gohelper.setActive(arg_9_0._goselect, var_9_1)
end

function var_0_0.getAnimator(arg_10_0)
	return arg_10_0.animator
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0

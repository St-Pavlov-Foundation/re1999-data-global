module("modules.logic.room.view.critter.RoomCritterTrainViewAnim", package.seeall)

local var_0_0 = class("RoomCritterTrainViewAnim", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._lastIshow = true
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0._onOpenView, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseView, arg_6_0)
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	arg_7_0:_setShowView(arg_7_0:_isCheckShowView())
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	arg_8_0:_setShowView(arg_8_0:_isCheckShowView())
end

function var_0_0._setShowView(arg_9_0, arg_9_1)
	if arg_9_0._lastIshow ~= arg_9_1 then
		arg_9_0._lastIshow = arg_9_1

		gohelper.setActive(arg_9_0.viewGO, arg_9_1)

		if arg_9_1 then
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
		else
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
		end
	end
end

function var_0_0._setBuildingShowView(arg_10_0, arg_10_1)
	if arg_10_0._lastBuildingShow ~= arg_10_1 then
		arg_10_0._lastBuildingShow = arg_10_1
	end
end

function var_0_0._isCheckShowView(arg_11_0)
	if not arg_11_0._showHitViewNameList then
		arg_11_0._showHitViewNameList = {
			ViewName.RoomCritterTrainEventView,
			ViewName.RoomCritterTrainStoryView,
			ViewName.RoomBranchView,
			ViewName.RoomCritterTrainEventResultView
		}
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._showHitViewNameList) do
		if ViewMgr.instance:isOpen(iter_11_1) then
			return false
		end
	end

	return true
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0

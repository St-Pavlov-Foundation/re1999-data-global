module("modules.logic.room.view.interact.RoomInteractSelectItem", package.seeall)

local var_0_0 = class("RoomInteractSelectItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "#go_has")
	arg_1_0._goheroicon = gohelper.findChild(arg_1_0.viewGO, "#go_has/#go_heroicon")
	arg_1_0._goloading = gohelper.findChild(arg_1_0.viewGO, "#go_loading")
	arg_1_0._goheroicon2 = gohelper.findChild(arg_1_0.viewGO, "#go_loading/#go_heroicon")
	arg_1_0._gonone = gohelper.findChild(arg_1_0.viewGO, "#go_none")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "#go_tag")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._view and arg_4_0._view.viewContainer and arg_4_0._characterMO then
		arg_4_0._view.viewContainer:dispatchEvent(RoomEvent.InteractBuildingSelectHero, arg_4_0._characterMO.heroId)
	end
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gotag, false)
	gohelper.setActive(arg_5_0._goloading, false)

	arg_5_0._simageicon = gohelper.findChildSingleImage(arg_5_0.viewGO, "#go_has/#go_heroicon")
	arg_5_0._simageicon2 = gohelper.findChildSingleImage(arg_5_0.viewGO, "#go_loading/#go_heroicon")
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._characterMO = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageicon:UnLoadImage()
	arg_10_0._simageicon2:UnLoadImage()
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = arg_11_0._characterMO
	local var_11_1 = var_11_0 and true or false

	if arg_11_0._lastIsHas ~= var_11_1 then
		arg_11_0._lastIsHas = var_11_1

		gohelper.setActive(arg_11_0._gohas, var_11_1)
		gohelper.setActive(arg_11_0._gonone, not var_11_1)
	end

	if var_11_1 and arg_11_0._lastMOid ~= var_11_0.id then
		arg_11_0._lastMOid = var_11_0.id

		local var_11_2 = ResUrl.getRoomHeadIcon(var_11_0.skinConfig.headIcon)

		arg_11_0._simageicon:LoadImage(var_11_2)
		arg_11_0._simageicon2:LoadImage(var_11_2)
	end
end

return var_0_0

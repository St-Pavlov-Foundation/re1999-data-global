module("modules.logic.dungeon.view.rolestory.RoleStoryActivityBgView", package.seeall)

local var_0_0 = class("RoleStoryActivityBgView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.bgNode = gohelper.findChild(arg_1_0.viewGO, "fullbg")
	arg_1_0.bg1 = gohelper.findChild(arg_1_0.bgNode, "#simage_fullbg1")
	arg_1_0.bg2 = gohelper.findChild(arg_1_0.bgNode, "#simage_fullbg2")
	arg_1_0._showActView = true

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, arg_2_0._onChangeMainViewShow, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, arg_3_0._onChangeMainViewShow, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	if arg_5_0.viewParam and arg_5_0.viewParam[1] == 1 then
		arg_5_0._showActView = false
	end
end

function var_0_0._onChangeMainViewShow(arg_6_0, arg_6_1)
	if arg_6_0._showActView == arg_6_1 then
		return
	end

	arg_6_0._showActView = arg_6_1
end

function var_0_0.refreshBg(arg_7_0)
	gohelper.setActive(arg_7_0.bg1, arg_7_0._showActView)
	gohelper.setActive(arg_7_0.bg2, not arg_7_0._showActView)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0

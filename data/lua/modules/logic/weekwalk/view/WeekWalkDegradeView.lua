module("modules.logic.weekwalk.view.WeekWalkDegradeView", package.seeall)

local var_0_0 = class("WeekWalkDegradeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetipbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_tipbg")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_no")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_sure")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
end

function var_0_0._btnnoOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnsureOnClick(arg_5_0)
	WeekwalkRpc.instance:sendSelectWeekwalkLevelRequest(arg_5_0._level - 1)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._level = WeekWalkModel.instance:getLevel()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0

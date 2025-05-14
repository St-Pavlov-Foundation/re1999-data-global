module("modules.logic.activity.view.chessmap.Activity109ChessGameClear", package.seeall)

local var_0_0 = class("Activity109ChessGameClear", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gotaskitemcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_task/viewport/#go_taskitemcontent")

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
	arg_4_0._simagebg:LoadImage(ResUrl.getActivityBg("full/barqiandao_bj_009"))
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagebg:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onClose(arg_7_0)
	return
end

return var_0_0

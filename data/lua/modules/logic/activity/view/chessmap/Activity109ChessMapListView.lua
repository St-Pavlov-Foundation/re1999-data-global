module("modules.logic.activity.view.chessmap.Activity109ChessMapListView", package.seeall)

local var_0_0 = class("Activity109ChessMapListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
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

function var_0_0._btntaskOnClick(arg_8_0)
	local var_8_0 = Activity109ChessModel.instance:getActId()
	local var_8_1 = Activity109ChessModel.instance:getMapId()
	local var_8_2 = Activity109ChessModel.instance:getEpisodeId()
	local var_8_3 = 1

	Activity109ChessController.instance:startNewEpisode(var_8_3)
end

return var_0_0

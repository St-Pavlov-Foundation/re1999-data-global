module("modules.logic.meilanni.view.MeilanniTaskView", package.seeall)

local var_0_0 = class("MeilanniTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._simageb3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_b3")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#scroll_reward")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_reward/Viewport/#go_rewardcontent")

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
	arg_4_0._simagebg1:LoadImage(ResUrl.getMeilanniIcon("full/bg_beijing"))
	arg_4_0._simagebg2:LoadImage(ResUrl.getMeilanniIcon("bg_beijing3"))
	arg_4_0._simageb3:LoadImage(ResUrl.getMeilanniIcon("bg_beijing4"))
end

function var_0_0.onOpen(arg_5_0)
	MeilanniTaskListModel.instance:showTaskList()
	arg_5_0:addEventCb(MeilanniController.instance, MeilanniEvent.bonusReply, arg_5_0._bonusReply, arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Open)
end

function var_0_0._bonusReply(arg_6_0)
	MeilanniTaskListModel.instance:showTaskList()
end

function var_0_0.onClose(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagebg1:UnLoadImage()
	arg_8_0._simagebg2:UnLoadImage()
	arg_8_0._simageb3:UnLoadImage()
end

return var_0_0

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TravelView", package.seeall)

local var_0_0 = class("Activity114TravelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskbg")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._simagebg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg3")
	arg_1_0._simagebg5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg5")
	arg_1_0._simageqianbi = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_qianbi")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagemaskbg:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_beijing"))
	arg_5_0._simagebg1:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang1"))
	arg_5_0._simagebg2:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang2"))
	arg_5_0._simagebg3:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang3"))
	arg_5_0._simagebg5:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_zhizhang5"))
	arg_5_0._simageqianbi:LoadImage(ResUrl.getVersionActivityTrip_1_2("bg_qianbi"))

	arg_5_0.entrances = {}

	for iter_5_0 = 1, 6 do
		arg_5_0.entrances[iter_5_0] = Activity114TravelItem.New(gohelper.findChild(arg_5_0.viewGO, "entrances/entrance" .. iter_5_0), iter_5_0)
	end
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
end

function var_0_0.onClose(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_delete)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagemaskbg:UnLoadImage()
	arg_8_0._simagebg1:UnLoadImage()
	arg_8_0._simagebg2:UnLoadImage()
	arg_8_0._simagebg3:UnLoadImage()
	arg_8_0._simagebg5:UnLoadImage()
	arg_8_0._simageqianbi:UnLoadImage()

	for iter_8_0 = 1, 6 do
		arg_8_0.entrances[iter_8_0]:onDestroy()
	end
end

return var_0_0

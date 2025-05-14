module("modules.logic.versionactivity1_2.jiexika.view.Activity114MeetView", package.seeall)

local var_0_0 = class("Activity114MeetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._itemParents = gohelper.findChild(arg_1_0.viewGO, "root/items")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_right")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagehuimianpu1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_huimianpu1")
	arg_1_0._simagehuimianpu3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_huimianpu3")
	arg_1_0._simagehuimianpu4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_huimianpu4")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnleftOnClick(arg_4_0)
	arg_4_0:updatePage(arg_4_0.curPage - 1)
end

function var_0_0._btnrightOnClick(arg_5_0)
	arg_5_0:updatePage(arg_5_0.curPage + 1)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg:LoadImage(ResUrl.getAct114MeetIcon("bg"))
	arg_7_0._simagehuimianpu1:LoadImage(ResUrl.getAct114MeetIcon("bg_huimianpu1"))
	arg_7_0._simagehuimianpu3:LoadImage(ResUrl.getAct114MeetIcon("bg_huimianpu3"))
	arg_7_0._simagehuimianpu4:LoadImage(ResUrl.getAct114MeetIcon("bg_huimianpu4"))

	arg_7_0.meetList = {}

	for iter_7_0 = 1, 6 do
		local var_7_0 = gohelper.findChild(arg_7_0._itemParents, "#go_characteritem" .. iter_7_0)

		arg_7_0.meetList[iter_7_0] = Activity114MeetItem.New(var_7_0)

		arg_7_0:addChildView(arg_7_0.meetList[iter_7_0])
	end

	arg_7_0:updatePage(1)
end

function var_0_0.updatePage(arg_8_0, arg_8_1)
	arg_8_0.curPage = arg_8_1

	local var_8_0 = Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id)
	local var_8_1 = #var_8_0
	local var_8_2 = math.ceil(var_8_1 / 6)

	for iter_8_0 = 1, 6 do
		arg_8_0.meetList[iter_8_0]:updateMo(var_8_0[iter_8_0 + (arg_8_0.curPage - 1) * 6])
	end

	gohelper.setActive(arg_8_0._btnleft.gameObject, arg_8_1 > 1)
	gohelper.setActive(arg_8_0._btnright.gameObject, arg_8_1 < var_8_2)
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_meeting_book_open)
end

function var_0_0.onClose(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_meeting_book_close)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
	arg_11_0._simagehuimianpu1:UnLoadImage()
	arg_11_0._simagehuimianpu3:UnLoadImage()
	arg_11_0._simagehuimianpu4:UnLoadImage()
end

return var_0_0

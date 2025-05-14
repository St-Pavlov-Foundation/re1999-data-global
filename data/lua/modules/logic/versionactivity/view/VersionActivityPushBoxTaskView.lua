module("modules.logic.versionactivity.view.VersionActivityPushBoxTaskView", package.seeall)

local var_0_0 = class("VersionActivityPushBoxTaskView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_heroicon")
	arg_1_0._scrolltasklist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tasklist")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_tasklist/Viewport/Content/#go_taskitem")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "#go_hero")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btnclose2OnClick, arg_2_0)
	arg_2_0:addEventCb(PushBoxController.instance, PushBoxEvent.DataEvent.ReceiveTaskRewardReply, arg_2_0._onReceiveTaskRewardReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0._btnclose1OnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclose2OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_showTaskList()
	arg_6_0._simageheroicon:LoadImage(ResUrl.getVersionActivityIcon("pushbox/img_lihui_rw"))
	arg_6_0._simagebg2:LoadImage(ResUrl.getVersionActivityIcon("pushbox/bg_rwdi2"))
end

function var_0_0._showTaskList(arg_7_0)
	arg_7_0._task_list = PushBoxEpisodeConfig.instance:getTaskList()

	PushBoxTaskListModel.instance:initData(arg_7_0._task_list)
	PushBoxTaskListModel.instance:sortData()
	PushBoxTaskListModel.instance:refreshData()
	gohelper.addChild(arg_7_0.viewGO, arg_7_0._gotaskitem)
	gohelper.setActive(arg_7_0._gotaskitem, false)
	TaskDispatcher.runDelay(arg_7_0._showTaskItem, arg_7_0, 0.2)
end

function var_0_0._showTaskItem(arg_8_0)
	arg_8_0:com_createObjList(arg_8_0._onItemShow, PushBoxTaskListModel.instance.data, gohelper.findChild(arg_8_0.viewGO, "#scroll_tasklist/Viewport/Content"), arg_8_0._gotaskitem, nil, 0.1)
end

function var_0_0._onItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0._item_list then
		arg_9_0._item_list = {}
	end

	local var_9_0 = false

	if not arg_9_0._item_list[arg_9_3] then
		var_9_0 = true
		arg_9_0._item_list[arg_9_3] = arg_9_0:openSubView(PushBoxTaskItem, arg_9_1)
	end

	arg_9_0._item_list[arg_9_3]:_refreshData(arg_9_2)

	if var_9_0 then
		arg_9_0._item_list[arg_9_3]:playOpenAni(arg_9_3)
	end
end

function var_0_0._onReceiveTaskRewardReply(arg_10_0)
	arg_10_0:_showTaskList()
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._showTaskItem, arg_11_0, 0.2)

	arg_11_0._item_list = nil

	PushBoxTaskListModel.instance:clearData()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageheroicon:UnLoadImage()
	arg_12_0._simagebg2:UnLoadImage()
end

return var_0_0

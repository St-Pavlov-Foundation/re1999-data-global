module("modules.logic.activity.view.show.ActivityStoryShowView", package.seeall)

local var_0_0 = class("ActivityStoryShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_icon")
	arg_1_0._simagescrollbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_scrollbg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/time/#txt_time")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_desc")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_task")
	arg_1_0._gotaskContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_task/Viewport/#go_taskContent")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_task/Viewport/#go_taskContent/#go_taskitem")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
end

var_0_0.unlimitDay = 42

function var_0_0._btnjumpOnClick(arg_4_0)
	local var_4_0 = arg_4_0._taskConfigDataTab[1].jumpId

	if var_4_0 ~= 0 then
		GameFacade.jump(var_4_0, arg_4_0.jumpFinishCallBack, arg_4_0)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simageimgchar = gohelper.findChildSingleImage(arg_5_0.viewGO, "bg/character/img_character")

	arg_5_0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_begin_bg"))
	arg_5_0._simageicon:LoadImage(ResUrl.getActivityBg("show/img_begin_lihui"))
	arg_5_0._simagescrollbg:LoadImage(ResUrl.getActivityBg("show/img_begin_reward_bg"))
	arg_5_0._simageimgchar:LoadImage(ResUrl.getActivityBg("show/img_begin_lihui"))
	gohelper.setActive(arg_5_0._gotaskitem, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	gohelper.addChild(var_7_0, arg_7_0.viewGO)

	arg_7_0._actId = arg_7_0.viewParam.actId
	arg_7_0._taskConfigDataTab = arg_7_0:getUserDataTb_()
	arg_7_0._taskItemTab = arg_7_0:getUserDataTb_()

	arg_7_0:refreshData()
	arg_7_0:refreshView()
end

function var_0_0.refreshData(arg_8_0)
	for iter_8_0 = 1, GameUtil.getTabLen(ActivityConfig.instance:getActivityShowTaskCount(arg_8_0._actId)) do
		local var_8_0 = ActivityConfig.instance:getActivityShowTaskList(arg_8_0._actId, iter_8_0)

		table.insert(arg_8_0._taskConfigDataTab, var_8_0)
	end
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0._txtdesc.text = arg_9_0._taskConfigDataTab[1].actDesc

	local var_9_0, var_9_1 = ActivityModel.instance:getRemainTime(arg_9_0._actId)

	arg_9_0._txttime.text = var_9_0 > var_0_0.unlimitDay and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), var_9_0, var_9_1)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._taskConfigDataTab) do
		local var_9_2 = arg_9_0._taskItemTab[iter_9_0]

		if not var_9_2 then
			var_9_2 = arg_9_0:getUserDataTb_()
			var_9_2.go = gohelper.clone(arg_9_0._gotaskitem, arg_9_0._gotaskContent, "task" .. iter_9_0)
			var_9_2.item = ActivityStoryShowItem.New()

			var_9_2.item:init(var_9_2.go, iter_9_0, iter_9_1)
			table.insert(arg_9_0._taskItemTab, var_9_2)
		end

		gohelper.setActive(var_9_2.go, true)
	end

	for iter_9_2 = #arg_9_0._taskConfigDataTab + 1, #arg_9_0._taskItemTab do
		gohelper.setActive(arg_9_0._taskItemTab[iter_9_2].go, false)
	end
end

function var_0_0.jumpFinishCallBack(arg_10_0)
	ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagebg:UnLoadImage()
	arg_12_0._simageicon:UnLoadImage()
	arg_12_0._simagescrollbg:UnLoadImage()
	arg_12_0._simageimgchar:UnLoadImage()
end

return var_0_0

module("modules.logic.investigate.view.InvestigateOpinionView", package.seeall)

local var_0_0 = class("InvestigateOpinionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageunfinishedbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_unfinishedbg")
	arg_1_0._simagefinishedbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_finishedbg")
	arg_1_0._simagecircle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_circle")
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_role")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_mask")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/view/#txt_title")
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/view/#txt_title/#btn_leftarrow")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/view/#txt_title/#btn_rightarrow")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_progress")
	arg_1_0._goprogresitem = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_progress/#go_progresitem")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/view/#scroll_desc")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/view/#scroll_desc/viewport/#go_content")
	arg_1_0._txtroledec = gohelper.findChildText(arg_1_0.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_roledec")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_dec")
	arg_1_0._btnextend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/view/#btn_extend")
	arg_1_0._goOpinion = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_Opinion")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnextend:AddClickListener(arg_2_0._btnextendOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnextend:RemoveClickListener()
end

function var_0_0._btnextendOnClick(arg_4_0)
	arg_4_0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
end

local var_0_1 = "delayOpenInvestigateRoleStoryView"

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, arg_5_0._onLinkedOpinionSuccess, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinish, arg_5_0)

	arg_5_0._goFinish = gohelper.findChild(arg_5_0.viewGO, "root/view/Bottom/#finish")

	local var_5_0 = AudioEnum.VersionActivity2_2Investigate.play_ui_activity_course_open

	gohelper.addUIClickAudio(arg_5_0._btnextend.gameObject, var_5_0)
end

function var_0_0._onLinkedOpinionSuccess(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = InvestigateOpinionModel.instance:getInfo()

	if InvestigateOpinionModel.instance:allOpinionLinked(var_6_0.id) then
		UIBlockMgr.instance:startBlock(var_0_1)
		TaskDispatcher.cancelTask(arg_6_0._openInvestigateRoleStoryView, arg_6_0)
		TaskDispatcher.runDelay(arg_6_0._openInvestigateRoleStoryView, arg_6_0, 1.3)
		gohelper.setActive(arg_6_0._goFinish, true)
	end
end

function var_0_0._openInvestigateRoleStoryView(arg_7_0)
	UIBlockMgr.instance:endBlock(var_0_1)

	local var_7_0, var_7_1 = InvestigateOpinionModel.instance:getInfo()

	InvestigateController.instance:openInvestigateRoleStoryView(var_7_0.id)
end

function var_0_0._onOpenViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.InvestigateRoleStoryView then
		arg_8_0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
	end
end

function var_0_0.onTabSwitchOpen(arg_9_0)
	return
end

function var_0_0.onTabSwitchClose(arg_10_0)
	return
end

function var_0_0.onClose(arg_11_0)
	UIBlockMgr.instance:endBlock(var_0_1)
	TaskDispatcher.cancelTask(arg_11_0._openInvestigateRoleStoryView, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0

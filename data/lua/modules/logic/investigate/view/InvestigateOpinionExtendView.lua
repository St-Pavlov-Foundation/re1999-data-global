module("modules.logic.investigate.view.InvestigateOpinionExtendView", package.seeall)

local var_0_0 = class("InvestigateOpinionExtendView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageunfinishedbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_unfinishedbg")
	arg_1_0._simagefinishedbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_finishedbg")
	arg_1_0._simagefullbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_fullbg2")
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/view/#simage_role")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/view/#txt_title")
	arg_1_0._goOpinion = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_Opinion")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_progress")
	arg_1_0._goprogresitem = gohelper.findChild(arg_1_0.viewGO, "root/view/#go_progress/#go_progresitem")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/view/#scroll_desc")
	arg_1_0._txtroledec = gohelper.findChildText(arg_1_0.viewGO, "root/view/#scroll_desc/viewport/content/#txt_roledec")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "root/view/#scroll_desc/viewport/content/#txt_dec")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/view/#btn_close")
	arg_1_0._btnrolestory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/view/#btn_rolestory")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnrolestory:AddClickListener(arg_2_0._btnrolestoryOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnrolestory:RemoveClickListener()
end

function var_0_0._btnrolestoryOnClick(arg_4_0)
	local var_4_0, var_4_1 = InvestigateOpinionModel.instance:getInfo()

	if InvestigateOpinionModel.instance:allOpinionLinked(var_4_0.id) then
		InvestigateController.instance:openInvestigateRoleStoryView(var_4_0.id)
	end
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Normal)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._btnAnimator = arg_6_0._btnrolestory.gameObject:GetComponent("Animator")
	arg_6_0._rootAnimator = ZProj.ProjAnimatorPlayer.Get(arg_6_0.viewGO)

	local var_6_0 = AudioEnum.VersionActivity2_2Investigate.play_ui_activity_course_open

	gohelper.addUIClickAudio(arg_6_0._btnclose.gameObject, var_6_0)
end

function var_0_0.playAnim(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._rootAnimator:Play(arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.onTabSwitchOpen(arg_8_0)
	arg_8_0:addEventCb(InvestigateController.instance, InvestigateEvent.ChangeArrow, arg_8_0._onChangeArrow, arg_8_0)
	arg_8_0:_onChangeArrow()
end

function var_0_0.onTabSwitchClose(arg_9_0)
	arg_9_0:removeEventCb(InvestigateController.instance, InvestigateEvent.ChangeArrow, arg_9_0._onChangeArrow, arg_9_0)
end

function var_0_0._onChangeArrow(arg_10_0)
	local var_10_0, var_10_1 = InvestigateOpinionModel.instance:getInfo()
	local var_10_2 = InvestigateOpinionModel.instance:allOpinionLinked(var_10_0.id)

	gohelper.setActive(arg_10_0._btnclose, true)
	gohelper.setActive(arg_10_0._btnrolestory, var_10_2)

	if var_10_2 and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.StoryBtn, var_10_0.id) then
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.StoryBtn, var_10_0.id)
		arg_10_0._btnAnimator:Play("finish", 0, 0)
	end
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:_onChangeArrow()
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0

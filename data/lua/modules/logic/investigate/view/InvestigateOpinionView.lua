module("modules.logic.investigate.view.InvestigateOpinionView", package.seeall)

slot0 = class("InvestigateOpinionView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageunfinishedbg = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_unfinishedbg")
	slot0._simagefinishedbg = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_finishedbg")
	slot0._simagecircle = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_circle")
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_role")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_mask")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/view/#txt_title")
	slot0._btnleftarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/view/#txt_title/#btn_leftarrow")
	slot0._btnrightarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/view/#txt_title/#btn_rightarrow")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "root/view/#go_progress")
	slot0._goprogresitem = gohelper.findChild(slot0.viewGO, "root/view/#go_progress/#go_progresitem")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "root/view/#scroll_desc")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "root/view/#scroll_desc/viewport/#go_content")
	slot0._txtroledec = gohelper.findChildText(slot0.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_roledec")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_dec")
	slot0._btnextend = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/view/#btn_extend")
	slot0._goOpinion = gohelper.findChild(slot0.viewGO, "root/view/#go_Opinion")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnextend:AddClickListener(slot0._btnextendOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnextend:RemoveClickListener()
end

function slot0._btnextendOnClick(slot0)
	slot0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
end

slot1 = "delayOpenInvestigateRoleStoryView"

function slot0._editableInitView(slot0)
	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, slot0._onLinkedOpinionSuccess, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)

	slot0._goFinish = gohelper.findChild(slot0.viewGO, "root/view/Bottom/#finish")

	gohelper.addUIClickAudio(slot0._btnextend.gameObject, AudioEnum.VersionActivity2_2Investigate.play_ui_activity_course_open)
end

function slot0._onLinkedOpinionSuccess(slot0, slot1)
	slot2, slot3 = InvestigateOpinionModel.instance:getInfo()

	if InvestigateOpinionModel.instance:allOpinionLinked(slot2.id) then
		UIBlockMgr.instance:startBlock(uv0)
		TaskDispatcher.cancelTask(slot0._openInvestigateRoleStoryView, slot0)
		TaskDispatcher.runDelay(slot0._openInvestigateRoleStoryView, slot0, 1.3)
		gohelper.setActive(slot0._goFinish, true)
	end
end

function slot0._openInvestigateRoleStoryView(slot0)
	UIBlockMgr.instance:endBlock(uv0)

	slot1, slot2 = InvestigateOpinionModel.instance:getInfo()

	InvestigateController.instance:openInvestigateRoleStoryView(slot1.id)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.InvestigateRoleStoryView then
		slot0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
	end
end

function slot0.onTabSwitchOpen(slot0)
end

function slot0.onTabSwitchClose(slot0)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0)
	TaskDispatcher.cancelTask(slot0._openInvestigateRoleStoryView, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

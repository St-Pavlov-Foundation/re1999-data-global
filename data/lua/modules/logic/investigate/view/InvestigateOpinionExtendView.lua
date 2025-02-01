module("modules.logic.investigate.view.InvestigateOpinionExtendView", package.seeall)

slot0 = class("InvestigateOpinionExtendView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageunfinishedbg = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_unfinishedbg")
	slot0._simagefinishedbg = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_finishedbg")
	slot0._simagefullbg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_fullbg2")
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "root/view/#simage_role")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/view/#txt_title")
	slot0._goOpinion = gohelper.findChild(slot0.viewGO, "root/view/#go_Opinion")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "root/view/#go_progress")
	slot0._goprogresitem = gohelper.findChild(slot0.viewGO, "root/view/#go_progress/#go_progresitem")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "root/view/#scroll_desc")
	slot0._txtroledec = gohelper.findChildText(slot0.viewGO, "root/view/#scroll_desc/viewport/content/#txt_roledec")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "root/view/#scroll_desc/viewport/content/#txt_dec")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/view/#btn_close")
	slot0._btnrolestory = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/view/#btn_rolestory")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnrolestory:AddClickListener(slot0._btnrolestoryOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnrolestory:RemoveClickListener()
end

function slot0._btnrolestoryOnClick(slot0)
	slot1, slot2 = InvestigateOpinionModel.instance:getInfo()

	if InvestigateOpinionModel.instance:allOpinionLinked(slot1.id) then
		InvestigateController.instance:openInvestigateRoleStoryView(slot1.id)
	end
end

function slot0._btncloseOnClick(slot0)
	slot0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Normal)
end

function slot0._editableInitView(slot0)
	slot0._btnAnimator = slot0._btnrolestory.gameObject:GetComponent("Animator")
	slot0._rootAnimator = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)

	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.VersionActivity2_2Investigate.play_ui_activity_course_open)
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	slot0._rootAnimator:Play(slot1, slot2, slot3)
end

function slot0.onTabSwitchOpen(slot0)
	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.ChangeArrow, slot0._onChangeArrow, slot0)
	slot0:_onChangeArrow()
end

function slot0.onTabSwitchClose(slot0)
	slot0:removeEventCb(InvestigateController.instance, InvestigateEvent.ChangeArrow, slot0._onChangeArrow, slot0)
end

function slot0._onChangeArrow(slot0)
	slot1, slot2 = InvestigateOpinionModel.instance:getInfo()
	slot3 = InvestigateOpinionModel.instance:allOpinionLinked(slot1.id)

	gohelper.setActive(slot0._btnclose, true)
	gohelper.setActive(slot0._btnrolestory, slot3)

	if slot3 and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.StoryBtn, slot1.id) then
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.StoryBtn, slot1.id)
		slot0._btnAnimator:Play("finish", 0, 0)
	end
end

function slot0.onOpen(slot0)
	slot0:_onChangeArrow()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

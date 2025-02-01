module("modules.logic.rouge.view.RougeTeamView", package.seeall)

slot0 = class("RougeTeamView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorolecontainer = gohelper.findChild(slot0.viewGO, "#go_rolecontainer")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/#scroll_view")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._goevent = gohelper.findChild(slot0.viewGO, "#go_event")
	slot0._gogreen = gohelper.findChild(slot0.viewGO, "#go_event/#go_green")
	slot0._goblue = gohelper.findChild(slot0.viewGO, "#go_event/#go_blue")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_event/#go_topright")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_event/#go_topright/#txt_num")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_event/#btn_confirm")
	slot0._gounenough = gohelper.findChild(slot0.viewGO, "#go_event/#go_unenough")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title/#txt_Title")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	if slot0._selctedNum == 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RougeTeamSelectedHeroConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._onConfirm, nil, , slot0)

		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeTeamViewConfirm")
	gohelper.setActive(slot0._btnconfirm, false)
	RougeController.instance:dispatchEvent(RougeEvent.OnTeamViewSelectedHeroPlayEffect, slot0._teamType)

	slot1 = 1.6

	if slot0._teamType == RougeEnum.TeamType.Assignment then
		slot1 = 0.6
	end

	TaskDispatcher.runDelay(slot0._onConfirm, slot0, slot1)
end

function slot0._onConfirm(slot0)
	if slot0._callback then
		slot0._callback(slot0._callbackTarget, RougeTeamListModel.instance:getSelectedHeroList())
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnTeamViewSelectedHero, slot0._onTeamViewSelectedHero, slot0)
end

function slot0._onTeamViewSelectedHero(slot0)
	slot0:_updateSelected()
end

function slot0.onOpen(slot0)
	RougeTeamListModel.addAssistHook()

	slot0._heroNum = slot0.viewParam.heroNum or 1
	slot0._teamType = slot0.viewParam.teamType
	slot0._callback = slot0.viewParam.callback
	slot0._callbackTarget = slot0.viewParam.callbackTarget
	slot0._selctedNum = 0

	gohelper.setActive(slot0._golefttop, slot0._teamType == RougeEnum.TeamType.View)
	RougeTeamListModel.instance:initList(slot0._teamType, slot0._heroNum)
	slot0:_initTitle()
	slot0:_initEvent()
	slot0:_updateSelected()
	slot0:setContentAnchor()
end

function slot0._initTitle(slot0)
	if slot0._teamType == RougeEnum.TeamType.View then
		slot0._txtTitle.text = formatLuaLang("p_rougeteamview_txt_title")
	elseif slot0._teamType == RougeEnum.TeamType.Treat then
		slot0._txtTitle.text = formatLuaLang("rouge_teamview_treat_title", slot0._heroNum)
	elseif slot0._teamType == RougeEnum.TeamType.Revive then
		slot0._txtTitle.text = formatLuaLang("rouge_teamview_revive_title", slot0._heroNum)
	elseif slot0._teamType == RougeEnum.TeamType.Assignment then
		slot0._txtTitle.text = formatLuaLang("rouge_teamview_assignment_title", slot0._heroNum)
	end
end

function slot0._initEvent(slot0)
	if slot0._teamType == RougeEnum.TeamType.View then
		return
	end

	gohelper.setActive(slot0._goevent, true)
	gohelper.setActive(slot0._gotopright, true)

	if slot0._teamType == RougeEnum.TeamType.Assignment then
		gohelper.setActive(slot0._goblue, true)
	else
		gohelper.setActive(slot0._gogreen, true)
	end
end

function slot0._updateSelected(slot0)
	if slot0._teamType == RougeEnum.TeamType.View then
		return
	end

	slot0._selctedNum = tabletool.len(RougeTeamListModel.instance:getSelectedHeroMap())
	slot0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_teamview_selected_num"), {
		string.format("<#C66030>%s</COLOR>", slot0._selctedNum),
		slot0._heroNum
	})

	if slot0._teamType == RougeEnum.TeamType.Assignment then
		slot2 = slot0._heroNum <= slot0._selctedNum

		gohelper.setActive(slot0._btnconfirm, slot2)
		gohelper.setActive(slot0._gounenough, not slot2)
	else
		gohelper.setActive(slot0._btnconfirm, true)
	end
end

function slot0.setContentAnchor(slot0)
	recthelper.setAnchorX(gohelper.findChildComponent(slot0.viewGO, "#go_rolecontainer/#scroll_view/Viewport/Content", gohelper.Type_RectTransform), 18)
end

function slot0.onClose(slot0)
	RougeTeamListModel.removeAssistHook()
	TaskDispatcher.cancelTask(slot0._onConfirm, slot0)
	UIBlockMgr.instance:endBlock("RougeTeamViewConfirm")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onDestroyView(slot0)
end

return slot0

module("modules.logic.rouge.view.RougeTeamView", package.seeall)

local var_0_0 = class("RougeTeamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorolecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_view")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._goevent = gohelper.findChild(arg_1_0.viewGO, "#go_event")
	arg_1_0._gogreen = gohelper.findChild(arg_1_0.viewGO, "#go_event/#go_green")
	arg_1_0._goblue = gohelper.findChild(arg_1_0.viewGO, "#go_event/#go_blue")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_event/#go_topright")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_event/#go_topright/#txt_num")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_event/#btn_confirm")
	arg_1_0._gounenough = gohelper.findChild(arg_1_0.viewGO, "#go_event/#go_unenough")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_Title")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	if arg_4_0._selctedNum == 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RougeTeamSelectedHeroConfirm, MsgBoxEnum.BoxType.Yes_No, arg_4_0._onConfirm, nil, nil, arg_4_0)

		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeTeamViewConfirm")
	gohelper.setActive(arg_4_0._btnconfirm, false)
	RougeController.instance:dispatchEvent(RougeEvent.OnTeamViewSelectedHeroPlayEffect, arg_4_0._teamType)

	local var_4_0 = 1.6

	if arg_4_0._teamType == RougeEnum.TeamType.Assignment then
		var_4_0 = 0.6
	end

	TaskDispatcher.runDelay(arg_4_0._onConfirm, arg_4_0, var_4_0)
end

function var_0_0._onConfirm(arg_5_0)
	local var_5_0 = RougeTeamListModel.instance:getSelectedHeroList()

	if arg_5_0._callback then
		arg_5_0._callback(arg_5_0._callbackTarget, var_5_0)
	end

	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addEventCb(RougeController.instance, RougeEvent.OnTeamViewSelectedHero, arg_6_0._onTeamViewSelectedHero, arg_6_0)
end

function var_0_0._onTeamViewSelectedHero(arg_7_0)
	arg_7_0:_updateSelected()
end

function var_0_0.onOpen(arg_8_0)
	RougeTeamListModel.addAssistHook()

	arg_8_0._heroNum = arg_8_0.viewParam.heroNum or 1
	arg_8_0._teamType = arg_8_0.viewParam.teamType
	arg_8_0._callback = arg_8_0.viewParam.callback
	arg_8_0._callbackTarget = arg_8_0.viewParam.callbackTarget
	arg_8_0._selctedNum = 0

	gohelper.setActive(arg_8_0._golefttop, arg_8_0._teamType == RougeEnum.TeamType.View)
	RougeTeamListModel.instance:initList(arg_8_0._teamType, arg_8_0._heroNum)
	arg_8_0:_initTitle()
	arg_8_0:_initEvent()
	arg_8_0:_updateSelected()
	arg_8_0:setContentAnchor()
end

function var_0_0._initTitle(arg_9_0)
	if arg_9_0._teamType == RougeEnum.TeamType.View then
		arg_9_0._txtTitle.text = formatLuaLang("p_rougeteamview_txt_title")
	elseif arg_9_0._teamType == RougeEnum.TeamType.Treat then
		arg_9_0._txtTitle.text = formatLuaLang("rouge_teamview_treat_title", arg_9_0._heroNum)
	elseif arg_9_0._teamType == RougeEnum.TeamType.Revive then
		arg_9_0._txtTitle.text = formatLuaLang("rouge_teamview_revive_title", arg_9_0._heroNum)
	elseif arg_9_0._teamType == RougeEnum.TeamType.Assignment then
		arg_9_0._txtTitle.text = formatLuaLang("rouge_teamview_assignment_title", arg_9_0._heroNum)
	end
end

function var_0_0._initEvent(arg_10_0)
	if arg_10_0._teamType == RougeEnum.TeamType.View then
		return
	end

	gohelper.setActive(arg_10_0._goevent, true)
	gohelper.setActive(arg_10_0._gotopright, true)

	if arg_10_0._teamType == RougeEnum.TeamType.Assignment then
		gohelper.setActive(arg_10_0._goblue, true)
	else
		gohelper.setActive(arg_10_0._gogreen, true)
	end
end

function var_0_0._updateSelected(arg_11_0)
	if arg_11_0._teamType == RougeEnum.TeamType.View then
		return
	end

	arg_11_0._selctedNum = tabletool.len(RougeTeamListModel.instance:getSelectedHeroMap())

	local var_11_0 = string.format("<#C66030>%s</COLOR>", arg_11_0._selctedNum)

	arg_11_0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_teamview_selected_num"), {
		var_11_0,
		arg_11_0._heroNum
	})

	if arg_11_0._teamType == RougeEnum.TeamType.Assignment then
		local var_11_1 = arg_11_0._selctedNum >= arg_11_0._heroNum

		gohelper.setActive(arg_11_0._btnconfirm, var_11_1)
		gohelper.setActive(arg_11_0._gounenough, not var_11_1)
	else
		gohelper.setActive(arg_11_0._btnconfirm, true)
	end
end

function var_0_0.setContentAnchor(arg_12_0)
	local var_12_0 = gohelper.findChildComponent(arg_12_0.viewGO, "#go_rolecontainer/#scroll_view/Viewport/Content", gohelper.Type_RectTransform)

	recthelper.setAnchorX(var_12_0, 18)
end

function var_0_0.onClose(arg_13_0)
	RougeTeamListModel.removeAssistHook()
	TaskDispatcher.cancelTask(arg_13_0._onConfirm, arg_13_0)
	UIBlockMgr.instance:endBlock("RougeTeamViewConfirm")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0

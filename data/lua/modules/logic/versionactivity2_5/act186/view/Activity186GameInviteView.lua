module("modules.logic.versionactivity2_5.act186.view.Activity186GameInviteView", package.seeall)

local var_0_0 = class("Activity186GameInviteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "root/goSelect")
	arg_1_0.goRight = gohelper.findChild(arg_1_0.viewGO, "root/right")
	arg_1_0.btnSure = gohelper.findChildButtonWithAudio(arg_1_0.goSelect, "btnSure")
	arg_1_0.btnCancel = gohelper.findChildButtonWithAudio(arg_1_0.goSelect, "btnCancel")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.goSelect, "content")
	arg_1_0.txtSure = gohelper.findChildTextMesh(arg_1_0.goSelect, "btnSure/txt")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSure, arg_2_0.onClickBtnSure, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCancel, arg_2_0.onClickBtnCancel, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnSure(arg_5_0)
	Activity186Controller.instance:enterGame(arg_5_0.actId, arg_5_0.gameId)
end

function var_0_0.onClickBtnCancel(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_leimi_theft_open)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.refreshParam(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam.activityId
	arg_9_0.gameId = arg_9_0.viewParam.gameId
	arg_9_0.gameStatus = arg_9_0.viewParam.gameStatus
	arg_9_0.gameType = arg_9_0.viewParam.gameType
end

function var_0_0.refreshView(arg_10_0)
	gohelper.setActive(arg_10_0.goSelect, arg_10_0.gameStatus == Activity186Enum.GameStatus.Start)
	gohelper.setActive(arg_10_0.goRight, arg_10_0.gameStatus == Activity186Enum.GameStatus.Playing)

	if arg_10_0.gameStatus == Activity186Enum.GameStatus.Start then
		if arg_10_0.gameType == 1 then
			arg_10_0.viewContainer.heroView:showText(luaLang("p_activity186gameinviteview_txt_content1"))

			arg_10_0.txtTitle.text = luaLang("p_activity186gameinviteview_txt_title1")
			arg_10_0.txtSure.text = luaLang("p_activity186gameinviteview_txt_start2")
		else
			arg_10_0.viewContainer.heroView:showText(luaLang("p_activity186gameinviteview_txt_content2"))

			arg_10_0.txtTitle.text = luaLang("p_activity186gameinviteview_txt_title2")
			arg_10_0.txtSure.text = luaLang("p_activity186gameinviteview_txt_start")
		end

		arg_10_0:_showDeadline()
	else
		TaskDispatcher.cancelTask(arg_10_0._onRefreshDeadline, arg_10_0)
	end
end

function var_0_0._showDeadline(arg_11_0)
	arg_11_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_11_0._onRefreshDeadline, arg_11_0)
	TaskDispatcher.runRepeat(arg_11_0._onRefreshDeadline, arg_11_0, 1)
end

function var_0_0._onRefreshDeadline(arg_12_0)
	arg_12_0:checkGameNotOnline()
end

function var_0_0.checkGameNotOnline(arg_13_0)
	local var_13_0 = Activity186Model.instance:getById(arg_13_0.actId)

	if not var_13_0 then
		return
	end

	if not var_13_0:getGameInfo(arg_13_0.gameId) then
		return
	end

	if not var_13_0:isGameOnline(arg_13_0.gameId) then
		arg_13_0:closeThis()
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._onRefreshDeadline, arg_15_0)
end

return var_0_0

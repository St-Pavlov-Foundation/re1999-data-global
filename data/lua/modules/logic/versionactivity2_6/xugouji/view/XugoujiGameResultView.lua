module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameResultView", package.seeall)

local var_0_0 = class("XugoujiGameResultView", BaseView)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_successClick")
	arg_1_0._btnExit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_quitgame")
	arg_1_0._btnRestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_restart")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._goBtns = gohelper.findChild(arg_1_0.viewGO, "#go_btn")
	arg_1_0._goTargetRoot = gohelper.findChild(arg_1_0.viewGO, "targets")
	arg_1_0._goTargetItem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "content/Layout/#go_Tips")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "Tips/#txt_Tips")
	arg_1_0._scrollItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_List/Viewport/Content/#go_Item")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_List/Viewport/Content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnExit:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnRestart:AddClickListener(arg_2_0._btnRestartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnExit:RemoveClickListener()
	arg_3_0._btnRestart:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	if arg_4_0:isLockOp() then
		return
	end

	XugoujiController.instance:gameResultOver()
end

function var_0_0._btnRestartOnClick(arg_5_0)
	if arg_5_0:isLockOp() then
		return
	end

	arg_5_0:closeThis()
	XugoujiController.instance:restartEpisode()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._animator = arg_8_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	arg_8_0:addEventCb(XugoujiController.instance, XugoujiEvent.ExitGame, arg_8_0.onExitGame, arg_8_0)

	if arg_8_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_8_0.viewContainer.viewName, arg_8_0._btncloseOnClick, arg_8_0)
	end

	arg_8_0:_setLockOpTime(1)
	arg_8_0:refreshUI()
end

function var_0_0.onExitGame(arg_9_0)
	XugoujiController.instance:getStatMo():sendDungeonFinishStatData()
	arg_9_0:closeThis()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.playViewAnimator(arg_12_0, arg_12_1)
	if arg_12_0._animator then
		arg_12_0._animator.enabled = true

		arg_12_0._animator:Play(arg_12_1, 0, 0)
	end
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = Activity188Model.instance:getCurEpisodeId()
	local var_13_1 = arg_13_0.viewParam.reason

	arg_13_0._star = arg_13_0.viewParam.star

	local var_13_2 = var_13_1 == XugoujiEnum.ResultEnum.Completed
	local var_13_3 = var_13_1 == XugoujiEnum.ResultEnum.PowerUseup
	local var_13_4 = var_13_1 == XugoujiEnum.ResultEnum.Quit
	local var_13_5 = var_13_3 or var_13_4

	gohelper.setActive(arg_13_0._gosuccess, var_13_2)
	gohelper.setActive(arg_13_0._gofail, var_13_5)
	gohelper.setActive(arg_13_0._goBtns, var_13_5)
	gohelper.setActive(arg_13_0._btnclose.gameObject, var_13_2)
	AudioMgr.instance:trigger(var_13_5 and AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_challenge_fail or AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_endpoint_arriva)
	arg_13_0:_createTargetList()
end

function var_0_0._createTargetList(arg_14_0)
	arg_14_0._targetDataList = {}

	local var_14_0 = Activity188Model.instance:getCurGameId()
	local var_14_1 = Activity188Config.instance:getGameCfg(var_0_1, var_14_0)
	local var_14_2 = string.split(var_14_1.passRound, "#")

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		local var_14_3 = iter_14_1

		table.insert(arg_14_0._targetDataList, var_14_3)
	end

	gohelper.CreateObjList(arg_14_0, arg_14_0._createTargetItem, arg_14_0._targetDataList, arg_14_0._goTargetRoot, arg_14_0._goTargetItem)
end

function var_0_0._createTargetItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("xugouji_round_target"), arg_15_2)

	gohelper.setActive(arg_15_1, true)

	gohelper.findChildText(arg_15_1, "#txt_taskdesc").text = var_15_0

	local var_15_1 = gohelper.findChild(arg_15_1, "result/#go_finish")
	local var_15_2 = gohelper.findChild(arg_15_1, "result/#go_unfinish")

	gohelper.setActive(var_15_1, arg_15_3 <= arg_15_0._star)
	gohelper.setActive(var_15_2, arg_15_3 > arg_15_0._star)
end

function var_0_0._setLockOpTime(arg_16_0, arg_16_1)
	arg_16_0._lockTime = Time.time + arg_16_1
end

function var_0_0.isLockOp(arg_17_0)
	if arg_17_0._lockTime and Time.time < arg_17_0._lockTime then
		return true
	end

	return false
end

return var_0_0

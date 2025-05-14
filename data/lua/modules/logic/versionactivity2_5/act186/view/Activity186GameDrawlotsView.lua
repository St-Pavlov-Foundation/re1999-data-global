module("modules.logic.versionactivity2_5.act186.view.Activity186GameDrawlotsView", package.seeall)

local var_0_0 = class("Activity186GameDrawlotsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goQian = gohelper.findChild(arg_1_0.viewGO, "chouqian")
	arg_1_0.goResult = gohelper.findChild(arg_1_0.viewGO, "result")
	arg_1_0.txtResult = gohelper.findChildTextMesh(arg_1_0.viewGO, "result/left/#txt_resultdec")
	arg_1_0.simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "result/right/#simage_title")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "result/right/#simage_title/#txt_result")
	arg_1_0.goReward1 = gohelper.findChild(arg_1_0.viewGO, "result/right/rewards/reward1")
	arg_1_0.txtRewardNum1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "result/right/rewards/reward1/#txt_num")
	arg_1_0.goReward2 = gohelper.findChild(arg_1_0.viewGO, "result/right/rewards/reward2")
	arg_1_0.simageReward2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "result/right/rewards/reward2/icon")
	arg_1_0.txtRewardNum2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "result/right/rewards/reward2/#txt_num")
	arg_1_0.btnSure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "result/right/#btn_Sure")
	arg_1_0.btnAgain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "result/right/#btn_Again")
	arg_1_0.txtRest = gohelper.findChildTextMesh(arg_1_0.viewGO, "result/right/#btn_Again/#txt_rest")
	arg_1_0.goExit = gohelper.findChild(arg_1_0.viewGO, "result/right/txt_exit")
	arg_1_0.viewAnim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.qiantongAnim = gohelper.findChildComponent(arg_1_0.viewGO, "chouqian/qiantong", gohelper.Type_Animator)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "FullBG")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickBtnClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSure, arg_2_0.onClickBtnSure, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnAgain, arg_2_0.onClickBtnAgain, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.PlayGame, arg_2_0.onPlayGame, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.FinishGame, arg_2_0.onFinishGame, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnClose(arg_5_0)
	if arg_5_0.gameStatus == Activity186Enum.GameStatus.Result then
		local var_5_0 = Activity186Model.instance:getById(arg_5_0.actId)
		local var_5_1 = var_5_0 and var_5_0:getGameInfo(arg_5_0.gameId)

		if not var_5_1 then
			return
		end

		local var_5_2 = var_5_1.rewardId

		if var_5_1.bTypeRetryCount <= 0 then
			arg_5_0:closeThis()
		end
	end
end

function var_0_0.onClickBtnSure(arg_6_0)
	local var_6_0 = Activity186Model.instance:getById(arg_6_0.actId)
	local var_6_1 = var_6_0 and var_6_0:getGameInfo(arg_6_0.gameId)

	if not var_6_1 then
		return
	end

	local var_6_2 = var_6_1.rewardId

	if var_6_2 and var_6_2 > 0 then
		Activity186Rpc.instance:sendFinishAct186BTypeGameRequest(arg_6_0.actId, arg_6_0.gameId)
		arg_6_0:closeThis()
	end
end

function var_0_0.onClickBtnAgain(arg_7_0)
	arg_7_0.viewAnim:Play("change")
	arg_7_0:startGame()
end

function var_0_0.onPlayGame(arg_8_0)
	arg_8_0.viewAnim:Play("finish")
	arg_8_0:_showResult()
end

function var_0_0.onFinishGame(arg_9_0)
	arg_9_0:checkGameNotOnline()
end

function var_0_0.checkGameNotOnline(arg_10_0)
	local var_10_0 = Activity186Model.instance:getById(arg_10_0.actId)

	if not var_10_0 then
		return
	end

	if not var_10_0:getGameInfo(arg_10_0.gameId) then
		return
	end

	if not var_10_0:isGameOnline(arg_10_0.gameId) then
		arg_10_0:closeThis()
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_page_turn)
	ViewMgr.instance:closeView(ViewName.Activity186GameInviteView)

	arg_12_0.actId = arg_12_0.viewParam.activityId
	arg_12_0.gameId = arg_12_0.viewParam.gameId
	arg_12_0.gameStatus = arg_12_0.viewParam.gameStatus

	arg_12_0:refreshView()
	arg_12_0:_showDeadline()
end

function var_0_0.refreshView(arg_13_0)
	local var_13_0 = Activity186Model.instance:getById(arg_13_0.actId)
	local var_13_1 = var_13_0 and var_13_0:getGameInfo(arg_13_0.gameId)

	if not var_13_1 then
		return
	end

	local var_13_2 = var_13_1.rewardId

	if var_13_2 and var_13_2 > 0 then
		arg_13_0.viewAnim:Play("open1")
		arg_13_0:_showResult()
	else
		arg_13_0.viewAnim:Play("open")
		arg_13_0:startGame()
	end
end

function var_0_0.startGame(arg_14_0)
	arg_14_0.gameStatus = Activity186Enum.GameStatus.Playing

	arg_14_0.qiantongAnim:Play("idle")

	arg_14_0.inDelayTime = false

	arg_14_0:addTouchEvents()
	arg_14_0:startCheckShake()
end

function var_0_0.startCheckShake(arg_15_0)
	local var_15_0, var_15_1, var_15_2 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	arg_15_0.previousAcceleration = Vector3.New(var_15_0, var_15_1, var_15_2)

	TaskDispatcher.cancelTask(arg_15_0._onCheckShake, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0._onCheckShake, arg_15_0, 0.1)
end

function var_0_0._onCheckShake(arg_16_0)
	if arg_16_0.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	local var_16_0, var_16_1, var_16_2 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)
	local var_16_3 = Vector3.New(var_16_0, var_16_1, var_16_2)

	if (var_16_3 - arg_16_0.previousAcceleration).magnitude > 0.5 then
		arg_16_0:startDelayTime()
	end

	arg_16_0.previousAcceleration = var_16_3
end

function var_0_0.addTouchEvents(arg_17_0)
	if arg_17_0._touchEventMgr then
		return
	end

	arg_17_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_17_0.goQian)

	arg_17_0._touchEventMgr:SetIgnoreUI(true)
	arg_17_0._touchEventMgr:SetOnlyTouch(true)
	arg_17_0._touchEventMgr:SetOnDragBeginCb(arg_17_0._onDragBegin, arg_17_0)
	arg_17_0._touchEventMgr:SetOnDragEndCb(arg_17_0._onDragEnd, arg_17_0)
end

function var_0_0._onDragBegin(arg_18_0)
	arg_18_0.inDrag = true

	if arg_18_0.gameStatus == Activity186Enum.GameStatus.Playing then
		arg_18_0:startDelayTime()
	end
end

function var_0_0._onDragEnd(arg_19_0)
	arg_19_0.inDrag = false

	if arg_19_0.gameStatus == Activity186Enum.GameStatus.Playing then
		-- block empty
	end
end

function var_0_0.startDelayTime(arg_20_0)
	if arg_20_0.inDelayTime then
		return
	end

	arg_20_0.inDelayTime = true

	arg_20_0.qiantongAnim:Play("open")
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_tangren_qiuqian)
	TaskDispatcher.cancelTask(arg_20_0.checkFinish, arg_20_0)
	TaskDispatcher.runDelay(arg_20_0.checkFinish, arg_20_0, 3)
end

function var_0_0.checkFinish(arg_21_0)
	if arg_21_0.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	arg_21_0:showResult()
end

function var_0_0.showResult(arg_22_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)

	arg_22_0.gameStatus = Activity186Enum.GameStatus.Result

	Activity186Rpc.instance:sendAct186BTypeGamePlayRequest(arg_22_0.actId, arg_22_0.gameId)
end

function var_0_0._showResult(arg_23_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_day_night)

	arg_23_0.gameStatus = Activity186Enum.GameStatus.Result

	local var_23_0 = Activity186Model.instance:getById(arg_23_0.actId)
	local var_23_1 = var_23_0 and var_23_0:getGameInfo(arg_23_0.gameId)

	if not var_23_1 then
		return
	end

	local var_23_2 = var_23_1.rewardId
	local var_23_3 = var_23_1.bTypeRetryCount
	local var_23_4 = Activity186Config.instance:getGameRewardConfig(2, var_23_2)

	if var_23_4 then
		if var_23_2 == 6 then
			arg_23_0.simageTitle:LoadImage("singlebg/v2a5_act186_singlebg/tag/v2a5_act186_tag5.png")
		else
			arg_23_0.simageTitle:LoadImage(string.format("singlebg/v2a5_act186_singlebg/tag/v2a5_act186_tag%s.png", var_23_2))
		end

		arg_23_0.txtTitle.text = var_23_4.blessingtitle
		arg_23_0.txtResult.text = var_23_4.blessingdes

		arg_23_0:refreshReward(var_23_4.bonus)
	end

	gohelper.setActive(arg_23_0.btnAgain, var_23_3 > 0)
	gohelper.setActive(arg_23_0.goExit, var_23_3 <= 0)

	if var_23_3 > 0 then
		arg_23_0.txtRest.text = formatLuaLang("act186_gameview_remaintimes", var_23_3)
	end
end

function var_0_0.refreshReward(arg_24_0, arg_24_1)
	local var_24_0 = GameUtil.splitString2(arg_24_1, true)
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1[1] ~= 26 then
			table.insert(var_24_1, iter_24_1)
		end
	end

	local var_24_2 = var_24_1[1]
	local var_24_3 = var_24_1[2]

	if var_24_2 then
		arg_24_0.txtRewardNum1.text = string.format("×%s", var_24_2[3])

		gohelper.setActive(arg_24_0.goReward1, true)
	else
		gohelper.setActive(arg_24_0.goReward1, false)
	end

	if var_24_3 then
		gohelper.setActive(arg_24_0.goReward2, true)

		local var_24_4, var_24_5 = ItemModel.instance:getItemConfigAndIcon(var_24_3[1], var_24_3[2], true)

		arg_24_0.simageReward2:LoadImage(var_24_5)

		arg_24_0.txtRewardNum2.text = string.format("×%s", var_24_3[3])
	else
		gohelper.setActive(arg_24_0.goReward2, false)
	end
end

function var_0_0._showDeadline(arg_25_0)
	arg_25_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_25_0._onRefreshDeadline, arg_25_0)
	TaskDispatcher.runRepeat(arg_25_0._onRefreshDeadline, arg_25_0, 1)
end

function var_0_0._onRefreshDeadline(arg_26_0)
	arg_26_0:checkGameNotOnline()
end

function var_0_0.onClose(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._onRefreshDeadline, arg_27_0)
end

function var_0_0.onDestroyView(arg_28_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)
	arg_28_0.simageReward2:UnLoadImage()
	arg_28_0.simageTitle:UnLoadImage()
	ViewMgr.instance:closeView(ViewName.Activity186GameInviteView)
	TaskDispatcher.cancelTask(arg_28_0.checkFinish, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._onCheckShake, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._onRefreshDeadline, arg_28_0)
end

return var_0_0

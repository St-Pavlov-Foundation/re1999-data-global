module("modules.logic.pushbox.view.PushBoxView", package.seeall)

local var_0_0 = class("PushBoxView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_up")
	arg_1_0._btndown = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_down")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_right")
	arg_1_0._btnrevertoperation = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_revert_operation")
	arg_1_0._btnrevertgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_revert_game")
	arg_1_0._btntaskreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task_reward")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnup:AddClickListener(arg_2_0._btnupOnClick, arg_2_0)
	arg_2_0._btndown:AddClickListener(arg_2_0._btndownOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnrevertoperation:AddClickListener(arg_2_0._btnrevertoperationOnClick, arg_2_0)
	arg_2_0._btnrevertgame:AddClickListener(arg_2_0._btnrevertgameOnClick, arg_2_0)
	arg_2_0._btntaskreward:AddClickListener(arg_2_0._btntaskrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnup:RemoveClickListener()
	arg_3_0._btndown:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnrevertoperation:RemoveClickListener()
	arg_3_0._btnrevertgame:RemoveClickListener()
	arg_3_0._btntaskreward:RemoveClickListener()
end

function var_0_0._btnrevertoperationOnClick(arg_4_0)
	arg_4_0._game_mgr:revertStep()
end

function var_0_0._btnrevertgameOnClick(arg_5_0)
	arg_5_0._game_mgr:revertGame()
end

function var_0_0._btntaskrewardOnClick(arg_6_0)
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, 1)
end

function var_0_0._btnupOnClick(arg_7_0)
	arg_7_0:_walk(PushBoxGameMgr.Direction.Up)
end

function var_0_0._btndownOnClick(arg_8_0)
	arg_8_0:_walk(PushBoxGameMgr.Direction.Down)
end

function var_0_0._btnleftOnClick(arg_9_0)
	arg_9_0:_walk(PushBoxGameMgr.Direction.Left)
end

function var_0_0._btnrightOnClick(arg_10_0)
	arg_10_0:_walk(PushBoxGameMgr.Direction.Right)
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0.viewContainer._navigateButtonView:setOverrideClose(arg_13_0._onNavigateCloseCallback, arg_13_0)

	arg_13_0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr

	arg_13_0._game_mgr:startGame(1)
end

function var_0_0._onNavigateCloseCallback(arg_14_0)
	arg_14_0.viewContainer._navigateButtonView:setOverrideClose(nil, nil)
	arg_14_0:closeThis()
	MainController.instance:enterMainScene()
end

function var_0_0._walk(arg_15_0, arg_15_1)
	if not arg_15_0._last_time then
		arg_15_0._last_time = Time.time
	elseif Time.time - arg_15_0._last_time < 0.2 then
		return
	end

	arg_15_0._last_time = Time.time

	arg_15_0._game_mgr:_onMove(arg_15_1)
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0

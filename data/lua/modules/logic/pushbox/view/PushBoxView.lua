module("modules.logic.pushbox.view.PushBoxView", package.seeall)

slot0 = class("PushBoxView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_up")
	slot0._btndown = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_down")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_left")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_right")
	slot0._btnrevertoperation = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_revert_operation")
	slot0._btnrevertgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_revert_game")
	slot0._btntaskreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task_reward")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnup:AddClickListener(slot0._btnupOnClick, slot0)
	slot0._btndown:AddClickListener(slot0._btndownOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnrevertoperation:AddClickListener(slot0._btnrevertoperationOnClick, slot0)
	slot0._btnrevertgame:AddClickListener(slot0._btnrevertgameOnClick, slot0)
	slot0._btntaskreward:AddClickListener(slot0._btntaskrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnup:RemoveClickListener()
	slot0._btndown:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnrevertoperation:RemoveClickListener()
	slot0._btnrevertgame:RemoveClickListener()
	slot0._btntaskreward:RemoveClickListener()
end

function slot0._btnrevertoperationOnClick(slot0)
	slot0._game_mgr:revertStep()
end

function slot0._btnrevertgameOnClick(slot0)
	slot0._game_mgr:revertGame()
end

function slot0._btntaskrewardOnClick(slot0)
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, 1)
end

function slot0._btnupOnClick(slot0)
	slot0:_walk(PushBoxGameMgr.Direction.Up)
end

function slot0._btndownOnClick(slot0)
	slot0:_walk(PushBoxGameMgr.Direction.Down)
end

function slot0._btnleftOnClick(slot0)
	slot0:_walk(PushBoxGameMgr.Direction.Left)
end

function slot0._btnrightOnClick(slot0)
	slot0:_walk(PushBoxGameMgr.Direction.Right)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.viewContainer._navigateButtonView:setOverrideClose(slot0._onNavigateCloseCallback, slot0)

	slot0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr

	slot0._game_mgr:startGame(1)
end

function slot0._onNavigateCloseCallback(slot0)
	slot0.viewContainer._navigateButtonView:setOverrideClose(nil, )
	slot0:closeThis()
	MainController.instance:enterMainScene()
end

function slot0._walk(slot0, slot1)
	if not slot0._last_time then
		slot0._last_time = Time.time
	elseif Time.time - slot0._last_time < 0.2 then
		return
	end

	slot0._last_time = Time.time

	slot0._game_mgr:_onMove(slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

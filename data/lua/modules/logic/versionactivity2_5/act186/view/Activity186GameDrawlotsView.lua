module("modules.logic.versionactivity2_5.act186.view.Activity186GameDrawlotsView", package.seeall)

slot0 = class("Activity186GameDrawlotsView", BaseView)

function slot0.onInitView(slot0)
	slot0.goQian = gohelper.findChild(slot0.viewGO, "chouqian")
	slot0.goResult = gohelper.findChild(slot0.viewGO, "result")
	slot0.txtResult = gohelper.findChildTextMesh(slot0.viewGO, "result/left/#txt_resultdec")
	slot0.simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "result/right/#simage_title")
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "result/right/#simage_title/#txt_result")
	slot0.goReward1 = gohelper.findChild(slot0.viewGO, "result/right/rewards/reward1")
	slot0.txtRewardNum1 = gohelper.findChildTextMesh(slot0.viewGO, "result/right/rewards/reward1/#txt_num")
	slot0.goReward2 = gohelper.findChild(slot0.viewGO, "result/right/rewards/reward2")
	slot0.simageReward2 = gohelper.findChildSingleImage(slot0.viewGO, "result/right/rewards/reward2/icon")
	slot0.txtRewardNum2 = gohelper.findChildTextMesh(slot0.viewGO, "result/right/rewards/reward2/#txt_num")
	slot0.btnSure = gohelper.findChildButtonWithAudio(slot0.viewGO, "result/right/#btn_Sure")
	slot0.btnAgain = gohelper.findChildButtonWithAudio(slot0.viewGO, "result/right/#btn_Again")
	slot0.txtRest = gohelper.findChildTextMesh(slot0.viewGO, "result/right/#btn_Again/#txt_rest")
	slot0.goExit = gohelper.findChild(slot0.viewGO, "result/right/txt_exit")
	slot0.viewAnim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.qiantongAnim = gohelper.findChildComponent(slot0.viewGO, "chouqian/qiantong", gohelper.Type_Animator)
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "FullBG")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onClickBtnClose, slot0)
	slot0:addClickCb(slot0.btnSure, slot0.onClickBtnSure, slot0)
	slot0:addClickCb(slot0.btnAgain, slot0.onClickBtnAgain, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.PlayGame, slot0.onPlayGame, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.FinishGame, slot0.onFinishGame, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnClose(slot0)
	if slot0.gameStatus == Activity186Enum.GameStatus.Result then
		if not (Activity186Model.instance:getById(slot0.actId) and slot1:getGameInfo(slot0.gameId)) then
			return
		end

		slot3 = slot2.rewardId

		if slot2.bTypeRetryCount <= 0 then
			slot0:closeThis()
		end
	end
end

function slot0.onClickBtnSure(slot0)
	if not (Activity186Model.instance:getById(slot0.actId) and slot1:getGameInfo(slot0.gameId)) then
		return
	end

	if slot2.rewardId and slot3 > 0 then
		Activity186Rpc.instance:sendFinishAct186BTypeGameRequest(slot0.actId, slot0.gameId)
		slot0:closeThis()
	end
end

function slot0.onClickBtnAgain(slot0)
	slot0.viewAnim:Play("change")
	slot0:startGame()
end

function slot0.onPlayGame(slot0)
	slot0.viewAnim:Play("finish")
	slot0:_showResult()
end

function slot0.onFinishGame(slot0)
	slot0:checkGameNotOnline()
end

function slot0.checkGameNotOnline(slot0)
	if not Activity186Model.instance:getById(slot0.actId) then
		return
	end

	if not slot1:getGameInfo(slot0.gameId) then
		return
	end

	if not slot1:isGameOnline(slot0.gameId) then
		slot0:closeThis()
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_page_turn)
	ViewMgr.instance:closeView(ViewName.Activity186GameInviteView)

	slot0.actId = slot0.viewParam.activityId
	slot0.gameId = slot0.viewParam.gameId
	slot0.gameStatus = slot0.viewParam.gameStatus

	slot0:refreshView()
	slot0:_showDeadline()
end

function slot0.refreshView(slot0)
	if not (Activity186Model.instance:getById(slot0.actId) and slot1:getGameInfo(slot0.gameId)) then
		return
	end

	if slot2.rewardId and slot3 > 0 then
		slot0.viewAnim:Play("open1")
		slot0:_showResult()
	else
		slot0.viewAnim:Play("open")
		slot0:startGame()
	end
end

function slot0.startGame(slot0)
	slot0.gameStatus = Activity186Enum.GameStatus.Playing

	slot0.qiantongAnim:Play("idle")

	slot0.inDelayTime = false

	slot0:addTouchEvents()
	slot0:startCheckShake()
end

function slot0.startCheckShake(slot0)
	slot1, slot2, slot3 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)
	slot0.previousAcceleration = Vector3.New(slot1, slot2, slot3)

	TaskDispatcher.cancelTask(slot0._onCheckShake, slot0)
	TaskDispatcher.runRepeat(slot0._onCheckShake, slot0, 0.1)
end

function slot0._onCheckShake(slot0)
	if slot0.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	slot1, slot2, slot3 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	if (Vector3.New(slot1, slot2, slot3) - slot0.previousAcceleration).magnitude > 0.5 then
		slot0:startDelayTime()
	end

	slot0.previousAcceleration = slot4
end

function slot0.addTouchEvents(slot0)
	if slot0._touchEventMgr then
		return
	end

	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0.goQian)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetOnlyTouch(true)
	slot0._touchEventMgr:SetOnDragBeginCb(slot0._onDragBegin, slot0)
	slot0._touchEventMgr:SetOnDragEndCb(slot0._onDragEnd, slot0)
end

function slot0._onDragBegin(slot0)
	slot0.inDrag = true

	if slot0.gameStatus == Activity186Enum.GameStatus.Playing then
		slot0:startDelayTime()
	end
end

function slot0._onDragEnd(slot0)
	slot0.inDrag = false

	if slot0.gameStatus == Activity186Enum.GameStatus.Playing then
		-- Nothing
	end
end

function slot0.startDelayTime(slot0)
	if slot0.inDelayTime then
		return
	end

	slot0.inDelayTime = true

	slot0.qiantongAnim:Play("open")
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_tangren_qiuqian)
	TaskDispatcher.cancelTask(slot0.checkFinish, slot0)
	TaskDispatcher.runDelay(slot0.checkFinish, slot0, 3)
end

function slot0.checkFinish(slot0)
	if slot0.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	slot0:showResult()
end

function slot0.showResult(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)

	slot0.gameStatus = Activity186Enum.GameStatus.Result

	Activity186Rpc.instance:sendAct186BTypeGamePlayRequest(slot0.actId, slot0.gameId)
end

function slot0._showResult(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_day_night)

	slot0.gameStatus = Activity186Enum.GameStatus.Result

	if not (Activity186Model.instance:getById(slot0.actId) and slot1:getGameInfo(slot0.gameId)) then
		return
	end

	slot4 = slot2.bTypeRetryCount

	if Activity186Config.instance:getGameRewardConfig(2, slot2.rewardId) then
		if slot3 == 6 then
			slot0.simageTitle:LoadImage("singlebg/v2a5_act186_singlebg/tag/v2a5_act186_tag5.png")
		else
			slot0.simageTitle:LoadImage(string.format("singlebg/v2a5_act186_singlebg/tag/v2a5_act186_tag%s.png", slot3))
		end

		slot0.txtTitle.text = slot5.blessingtitle
		slot0.txtResult.text = slot5.blessingdes

		slot0:refreshReward(slot5.bonus)
	end

	gohelper.setActive(slot0.btnAgain, slot4 > 0)
	gohelper.setActive(slot0.goExit, slot4 <= 0)

	if slot4 > 0 then
		slot0.txtRest.text = formatLuaLang("act186_gameview_remaintimes", slot4)
	end
end

function slot0.refreshReward(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(GameUtil.splitString2(slot1, true)) do
		if slot8[1] ~= 26 then
			table.insert(slot3, slot8)
		end
	end

	slot5 = slot3[2]

	if slot3[1] then
		slot0.txtRewardNum1.text = string.format("×%s", slot4[3])

		gohelper.setActive(slot0.goReward1, true)
	else
		gohelper.setActive(slot0.goReward1, false)
	end

	if slot5 then
		gohelper.setActive(slot0.goReward2, true)

		slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot5[1], slot5[2], true)

		slot0.simageReward2:LoadImage(slot7)

		slot0.txtRewardNum2.text = string.format("×%s", slot5[3])
	else
		gohelper.setActive(slot0.goReward2, false)
	end
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
end

function slot0._onRefreshDeadline(slot0)
	slot0:checkGameNotOnline()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

function slot0.onDestroyView(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)
	slot0.simageReward2:UnLoadImage()
	slot0.simageTitle:UnLoadImage()
	ViewMgr.instance:closeView(ViewName.Activity186GameInviteView)
	TaskDispatcher.cancelTask(slot0.checkFinish, slot0)
	TaskDispatcher.cancelTask(slot0._onCheckShake, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

return slot0

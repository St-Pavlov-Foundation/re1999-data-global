module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluGameView", package.seeall)

slot0 = class("PeaceUluGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._golive2d = gohelper.findChild(slot0.viewGO, "#go_live2d")
	slot0._gotalk = gohelper.findChild(slot0.viewGO, "#go_live2d/#go_talk")
	slot0._gotalkbg = gohelper.findChild(slot0.viewGO, "#go_live2d/#go_talkbg")
	slot0._txttalk = gohelper.findChildText(slot0.viewGO, "#go_live2d/#go_talk/bg/#txt_talk")
	slot0._goleftbg = gohelper.findChild(slot0.viewGO, "game/left/#go_bg")
	slot0._gostartmask = gohelper.findChild(slot0.viewGO, "game/#go_BlackMask1")
	slot0._goresultmask = gohelper.findChild(slot0.viewGO, "game/#go_BlackMask2")
	slot0._goleftselected = gohelper.findChild(slot0.viewGO, "game/left/#go_selected")
	slot0._imgleftselected = gohelper.findChildImage(slot0.viewGO, "game/left/#go_selected")
	slot0._txtleft = gohelper.findChildText(slot0.viewGO, "game/left/#go_selected/#txt_left")
	slot0._goxian = gohelper.findChild(slot0.viewGO, "game/#go_xian")
	slot0._gorightbg = gohelper.findChild(slot0.viewGO, "game/right/#go_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "game/#go_btns")
	slot0._btnpaper = gohelper.findChildButtonWithAudio(slot0.viewGO, "game/#go_btns/#btn_paper")
	slot0._btnrock = gohelper.findChildButtonWithAudio(slot0.viewGO, "game/#go_btns/#btn_rock")
	slot0._btnscissors = gohelper.findChildButtonWithAudio(slot0.viewGO, "game/#go_btns/#btn_scissors")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "game/#go_btns/#btn_confirm")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "game/#go_tips")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "game/right/#go_tips/bg/#txt_tips")
	slot0._gorightselected = gohelper.findChild(slot0.viewGO, "game/right/#go_selected")
	slot0._imgrightselected = gohelper.findChildImage(slot0.viewGO, "game/right/#go_selected")
	slot0._txtright = gohelper.findChildText(slot0.viewGO, "game/right/#go_selected/#txt_right")
	slot0._gostate = gohelper.findChild(slot0.viewGO, "game/#go_state")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "game/#go_state/#go_start")
	slot0._btndraw = gohelper.findChildButton(slot0.viewGO, "game/#go_state/0/#btn_draw")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "bottom/#go_contentbg")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_cn")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_en")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._stateList = {}
	slot0._btnItemList = {}
	slot0._isSelect = false
	slot0.tweenDuration = 0.5
	slot0._isTips = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btndraw:AddClickListener(slot0._onClickDraw, slot0)
	slot0:addEventCb(PeaceUluController.instance, PeaceUluEvent.onGetGameResult, slot0._getResult, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btndraw:RemoveClickListener()
	slot0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.onGetGameResult, slot0._getResult, slot0)
end

function slot0._editableInitView(slot0)
	for slot4 = 0, 2 do
		table.insert(slot0._stateList, gohelper.findChild(slot0.viewGO, "game/#go_state/" .. slot4))
	end

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.trs = gohelper.findChild(slot0.viewGO, "game/#go_btns/" .. slot4).transform
		slot5.go = gohelper.findChild(slot0.viewGO, "game/#go_btns/" .. slot4 .. "/img")
		slot5.btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "game/#go_btns/" .. slot4)
		slot5.id = slot4

		gohelper.setActive(slot5.go, false)
		slot5.btn:AddClickListener(slot0._onClickGameBtn, slot0, slot5)
		table.insert(slot0._btnItemList, slot5)
	end
end

function slot0._onClickGameBtn(slot0, slot1)
	slot0.selectId = slot1.id

	for slot5, slot6 in ipairs(slot0._btnItemList) do
		if slot6.id ~= slot0.selectId then
			gohelper.setActive(slot6.go, false)
		else
			gohelper.setActive(slot6.go, true)
		end
	end

	gohelper.setActive(slot0._btnconfirm.gameObject, true)
end

function slot0._btnconfirmOnClick(slot0)
	PeaceUluRpc.instance:sendAct145GameRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, slot0.selectId)
	gohelper.setActive(slot0._btnconfirm.gameObject, false)
	TaskDispatcher.runDelay(slot0._onGameTipsFinish, slot0, 2)
end

function slot0._getResult(slot0)
	gohelper.setActive(slot0._gobtns, false)
	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._goresultmask, true)
	gohelper.setActive(slot0._goxian, true)
	gohelper.setActive(slot0._goleftselected, true)
	gohelper.setActive(slot0._gorightselected, true)
	UISpriteSetMgr.instance:setPeaceUluSprite(slot0._imgleftselected, PeaceUluModel.instance:getOtherChoice())
	UISpriteSetMgr.instance:setPeaceUluSprite(slot0._imgrightselected, slot0.selectId)
	slot0._animator:Play("play", 0, 0)
	slot0._animator:Update(0)
	slot0.viewContainer:getNavigateButtonView():setParam({
		false,
		false,
		false
	})
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_caiquan_decide)
	TaskDispatcher.runDelay(slot0._showResult, slot0, 1.6)
end

function slot0._showResult(slot0)
	TaskDispatcher.cancelTask(slot0._showResult, slot0)

	if PeaceUluModel.instance:getGameRes() == PeaceUluEnum.GameResult.Win then
		slot0._animator:Play("success", 0, 0)
		slot0._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_endpoint_arrival)
		TaskDispatcher.runDelay(slot0._showResultFinish, slot0, 2.2)
	elseif slot1 == PeaceUluEnum.GameResult.Fail then
		slot0._animator:Play("fail", 0, 0)
		slot0._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail)
		TaskDispatcher.runDelay(slot0._showResultFinish, slot0, 2.2)
	else
		slot0._animator:Play("draw", 0, 0)
		slot0._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_endpoint_arrival)
	end

	gohelper.setActive(slot0._stateList[slot1 + 1], true)
end

function slot0._onClickDraw(slot0)
	slot0._animator:Play("drawend", 0, 0)
	slot0._animator:Update(0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	TaskDispatcher.runDelay(slot0._showResultFinish, slot0, 0.5)
end

function slot0._showResultFinish(slot0)
	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._showResultFinish, slot4)

	for slot4, slot5 in ipairs(slot0._stateList) do
		gohelper.setActive(slot5, false)
	end

	if PeaceUluModel.instance:getGameRes() == PeaceUluEnum.GameResult.Draw then
		gohelper.setActive(slot0._gostate, false)
		slot0:_onGameStart()
	else
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.reInitResultView)
		slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, PeaceUluEnum.TabIndex.Result)
		gohelper.setActive(slot0._goresultmask, false)
	end
end

function slot0._reInitUI(slot0)
	for slot4, slot5 in ipairs(slot0._btnItemList) do
		gohelper.setActive(slot5.go, false)
	end

	gohelper.setActive(slot0._btnconfirm.gameObject, false)
end

function slot0._onGameStart(slot0)
	slot0._animator:Play("start", 0, 0)
	slot0._animator:Update(0)
	gohelper.setActive(slot0._gobtns, true)
	gohelper.setActive(slot0._gostate, true)
	gohelper.setActive(slot0._gostart, true)
	gohelper.setActive(slot0._goresultmask, true)
	gohelper.setActive(slot0._goxian, false)
	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._goleftbg, false)
	gohelper.setActive(slot0._goleftselected, false)
	gohelper.setActive(slot0._gorightselected, false)
	gohelper.setActive(slot0._gorightbg, false)
	slot0:_reInitUI()
	TaskDispatcher.runDelay(slot0._onGameStartFinish, slot0, 2)
end

function slot0._onGameStartFinish(slot0)
	TaskDispatcher.cancelTask(slot0._onGameStartFinish, slot0)
	gohelper.setActive(slot0._goresultmask, false)
	gohelper.setActive(slot0._gostartmask, true)
	gohelper.setActive(slot0._gostart, false)
	gohelper.setActive(slot0._gotips, true)
end

function slot0._onGameTipsFinish(slot0)
	TaskDispatcher.cancelTask(slot0._onGameTipsFinish, slot0)
	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._gostartmask, false)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0._animator:Play("start", 0, 0)
	slot0._animator:Update(0)
	slot0:_onGameStart()
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_caiquan_open)
end

function slot0._refreshUI(slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showResult, slot0)
	TaskDispatcher.cancelTask(slot0._onGameStartFinish, slot0)
	TaskDispatcher.cancelTask(slot0._onGameTipsFinish, slot0)
	TaskDispatcher.cancelTask(slot0._showResultFinish, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._btnItemList) do
		slot5.btn:RemoveClickListener()
	end
end

return slot0

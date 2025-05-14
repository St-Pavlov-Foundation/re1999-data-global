module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluGameView", package.seeall)

local var_0_0 = class("PeaceUluGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golive2d = gohelper.findChild(arg_1_0.viewGO, "#go_live2d")
	arg_1_0._gotalk = gohelper.findChild(arg_1_0.viewGO, "#go_live2d/#go_talk")
	arg_1_0._gotalkbg = gohelper.findChild(arg_1_0.viewGO, "#go_live2d/#go_talkbg")
	arg_1_0._txttalk = gohelper.findChildText(arg_1_0.viewGO, "#go_live2d/#go_talk/bg/#txt_talk")
	arg_1_0._goleftbg = gohelper.findChild(arg_1_0.viewGO, "game/left/#go_bg")
	arg_1_0._gostartmask = gohelper.findChild(arg_1_0.viewGO, "game/#go_BlackMask1")
	arg_1_0._goresultmask = gohelper.findChild(arg_1_0.viewGO, "game/#go_BlackMask2")
	arg_1_0._goleftselected = gohelper.findChild(arg_1_0.viewGO, "game/left/#go_selected")
	arg_1_0._imgleftselected = gohelper.findChildImage(arg_1_0.viewGO, "game/left/#go_selected")
	arg_1_0._txtleft = gohelper.findChildText(arg_1_0.viewGO, "game/left/#go_selected/#txt_left")
	arg_1_0._goxian = gohelper.findChild(arg_1_0.viewGO, "game/#go_xian")
	arg_1_0._gorightbg = gohelper.findChild(arg_1_0.viewGO, "game/right/#go_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "game/#go_btns")
	arg_1_0._btnpaper = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "game/#go_btns/#btn_paper")
	arg_1_0._btnrock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "game/#go_btns/#btn_rock")
	arg_1_0._btnscissors = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "game/#go_btns/#btn_scissors")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "game/#go_btns/#btn_confirm")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "game/#go_tips")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "game/right/#go_tips/bg/#txt_tips")
	arg_1_0._gorightselected = gohelper.findChild(arg_1_0.viewGO, "game/right/#go_selected")
	arg_1_0._imgrightselected = gohelper.findChildImage(arg_1_0.viewGO, "game/right/#go_selected")
	arg_1_0._txtright = gohelper.findChildText(arg_1_0.viewGO, "game/right/#go_selected/#txt_right")
	arg_1_0._gostate = gohelper.findChild(arg_1_0.viewGO, "game/#go_state")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "game/#go_state/#go_start")
	arg_1_0._btndraw = gohelper.findChildButton(arg_1_0.viewGO, "game/#go_state/0/#btn_draw")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_en")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._stateList = {}
	arg_1_0._btnItemList = {}
	arg_1_0._isSelect = false
	arg_1_0.tweenDuration = 0.5
	arg_1_0._isTips = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btndraw:AddClickListener(arg_2_0._onClickDraw, arg_2_0)
	arg_2_0:addEventCb(PeaceUluController.instance, PeaceUluEvent.onGetGameResult, arg_2_0._getResult, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btndraw:RemoveClickListener()
	arg_3_0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.onGetGameResult, arg_3_0._getResult, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	for iter_4_0 = 0, 2 do
		local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "game/#go_state/" .. iter_4_0)

		table.insert(arg_4_0._stateList, var_4_0)
	end

	for iter_4_1 = 1, 3 do
		local var_4_1 = arg_4_0:getUserDataTb_()

		var_4_1.trs = gohelper.findChild(arg_4_0.viewGO, "game/#go_btns/" .. iter_4_1).transform
		var_4_1.go = gohelper.findChild(arg_4_0.viewGO, "game/#go_btns/" .. iter_4_1 .. "/img")
		var_4_1.btn = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "game/#go_btns/" .. iter_4_1)
		var_4_1.id = iter_4_1

		gohelper.setActive(var_4_1.go, false)
		var_4_1.btn:AddClickListener(arg_4_0._onClickGameBtn, arg_4_0, var_4_1)
		table.insert(arg_4_0._btnItemList, var_4_1)
	end
end

function var_0_0._onClickGameBtn(arg_5_0, arg_5_1)
	arg_5_0.selectId = arg_5_1.id

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._btnItemList) do
		if iter_5_1.id ~= arg_5_0.selectId then
			gohelper.setActive(iter_5_1.go, false)
		else
			gohelper.setActive(iter_5_1.go, true)
		end
	end

	gohelper.setActive(arg_5_0._btnconfirm.gameObject, true)
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	PeaceUluRpc.instance:sendAct145GameRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, arg_6_0.selectId)
	gohelper.setActive(arg_6_0._btnconfirm.gameObject, false)
	TaskDispatcher.runDelay(arg_6_0._onGameTipsFinish, arg_6_0, 2)
end

function var_0_0._getResult(arg_7_0)
	local var_7_0 = PeaceUluModel.instance:getOtherChoice()

	gohelper.setActive(arg_7_0._gobtns, false)
	gohelper.setActive(arg_7_0._gotips, false)
	gohelper.setActive(arg_7_0._goresultmask, true)
	gohelper.setActive(arg_7_0._goxian, true)
	gohelper.setActive(arg_7_0._goleftselected, true)
	gohelper.setActive(arg_7_0._gorightselected, true)
	UISpriteSetMgr.instance:setPeaceUluSprite(arg_7_0._imgleftselected, var_7_0)
	UISpriteSetMgr.instance:setPeaceUluSprite(arg_7_0._imgrightselected, arg_7_0.selectId)
	arg_7_0._animator:Play("play", 0, 0)
	arg_7_0._animator:Update(0)
	arg_7_0.viewContainer:getNavigateButtonView():setParam({
		false,
		false,
		false
	})
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_caiquan_decide)
	TaskDispatcher.runDelay(arg_7_0._showResult, arg_7_0, 1.6)
end

function var_0_0._showResult(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._showResult, arg_8_0)

	local var_8_0 = PeaceUluModel.instance:getGameRes()

	if var_8_0 == PeaceUluEnum.GameResult.Win then
		arg_8_0._animator:Play("success", 0, 0)
		arg_8_0._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_endpoint_arrival)
		TaskDispatcher.runDelay(arg_8_0._showResultFinish, arg_8_0, 2.2)
	elseif var_8_0 == PeaceUluEnum.GameResult.Fail then
		arg_8_0._animator:Play("fail", 0, 0)
		arg_8_0._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_challenge_fail)
		TaskDispatcher.runDelay(arg_8_0._showResultFinish, arg_8_0, 2.2)
	else
		arg_8_0._animator:Play("draw", 0, 0)
		arg_8_0._animator:Update(0)
		AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_pkls_endpoint_arrival)
	end

	gohelper.setActive(arg_8_0._stateList[var_8_0 + 1], true)
end

function var_0_0._onClickDraw(arg_9_0)
	arg_9_0._animator:Play("drawend", 0, 0)
	arg_9_0._animator:Update(0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	TaskDispatcher.runDelay(arg_9_0._showResultFinish, arg_9_0, 0.5)
end

function var_0_0._showResultFinish(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._showResultFinish, arg_10_0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._stateList) do
		gohelper.setActive(iter_10_1, false)
	end

	if PeaceUluModel.instance:getGameRes() == PeaceUluEnum.GameResult.Draw then
		gohelper.setActive(arg_10_0._gostate, false)
		arg_10_0:_onGameStart()
	else
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.reInitResultView)
		arg_10_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, PeaceUluEnum.TabIndex.Result)
		gohelper.setActive(arg_10_0._goresultmask, false)
	end
end

function var_0_0._reInitUI(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._btnItemList) do
		gohelper.setActive(iter_11_1.go, false)
	end

	gohelper.setActive(arg_11_0._btnconfirm.gameObject, false)
end

function var_0_0._onGameStart(arg_12_0)
	arg_12_0._animator:Play("start", 0, 0)
	arg_12_0._animator:Update(0)
	gohelper.setActive(arg_12_0._gobtns, true)
	gohelper.setActive(arg_12_0._gostate, true)
	gohelper.setActive(arg_12_0._gostart, true)
	gohelper.setActive(arg_12_0._goresultmask, true)
	gohelper.setActive(arg_12_0._goxian, false)
	gohelper.setActive(arg_12_0._gotips, false)
	gohelper.setActive(arg_12_0._goleftbg, false)
	gohelper.setActive(arg_12_0._goleftselected, false)
	gohelper.setActive(arg_12_0._gorightselected, false)
	gohelper.setActive(arg_12_0._gorightbg, false)
	arg_12_0:_reInitUI()
	TaskDispatcher.runDelay(arg_12_0._onGameStartFinish, arg_12_0, 2)
end

function var_0_0._onGameStartFinish(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onGameStartFinish, arg_13_0)
	gohelper.setActive(arg_13_0._goresultmask, false)
	gohelper.setActive(arg_13_0._gostartmask, true)
	gohelper.setActive(arg_13_0._gostart, false)
	gohelper.setActive(arg_13_0._gotips, true)
end

function var_0_0._onGameTipsFinish(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._onGameTipsFinish, arg_14_0)
	gohelper.setActive(arg_14_0._gotips, false)
	gohelper.setActive(arg_14_0._gostartmask, false)
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:_refreshUI()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0._animator:Play("start", 0, 0)
	arg_16_0._animator:Update(0)
	arg_16_0:_onGameStart()
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_caiquan_open)
end

function var_0_0._refreshUI(arg_17_0)
	return
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showResult, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._onGameStartFinish, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._onGameTipsFinish, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showResultFinish, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._btnItemList) do
		iter_19_1.btn:RemoveClickListener()
	end
end

return var_0_0

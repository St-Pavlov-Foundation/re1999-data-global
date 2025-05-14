module("modules.logic.meilanni.view.MeilanniDialogBtnView", package.seeall)

local var_0_0 = class("MeilanniDialogBtnView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "top_right/btncontain/#go_btntype1")
	arg_1_0._gotalkitem = gohelper.findChild(arg_1_0.viewGO, "top_right/btncontain/#go_btntype1/#btn_templateclick")
	arg_1_0._gobtnpos1 = gohelper.findChild(arg_1_0.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos1")
	arg_1_0._gobtnpos2 = gohelper.findChild(arg_1_0.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos2")
	arg_1_0._gobtnpos3 = gohelper.findChild(arg_1_0.viewGO, "top_right/btncontain/#go_btntype1/#go_btnpos3")
	arg_1_0._btnend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top_right/btncontain/#btn_end")
	arg_1_0._txtendinfo = gohelper.findChildText(arg_1_0.viewGO, "top_right/btncontain/#btn_end/layout/txt_info")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnend:AddClickListener(arg_2_0._btnendOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnend:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._optionBtnList = arg_5_0:getUserDataTb_()
	arg_5_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0._gooptions)
	arg_5_0._endPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0._btnend.gameObject)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.startShowDialogOptionBtn, arg_7_0._startShowDialogOptionBtn, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.refreshDialogBtnState, arg_7_0._refreshDialogBtnState, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.showDialogOptionBtn, arg_7_0._showDialogOptionBtn, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.showDialogEndBtn, arg_7_0._showDialogEndBtn, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.dialogClose, arg_7_0._dialogClose, arg_7_0)
	arg_7_0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, arg_7_0._resetMap, arg_7_0)
end

function var_0_0._onAnimDone(arg_8_0)
	gohelper.setActive(arg_8_0._gooptions, arg_8_0._showOption)
end

function var_0_0._refreshDialogBtnState(arg_9_0, arg_9_1)
	arg_9_0._showOption = arg_9_1

	if not arg_9_1 then
		if not arg_9_0._gooptions.activeSelf then
			return
		end

		arg_9_0._animatorPlayer:Play("close", arg_9_0._onAnimDone, arg_9_0)

		return
	end

	gohelper.setActive(arg_9_0._gooptions, arg_9_1)
	arg_9_0._animatorPlayer:Play("open", arg_9_0._onAnimDone, arg_9_0)
end

function var_0_0._onEndAnimDone(arg_10_0)
	gohelper.setActive(arg_10_0._btnend, arg_10_0._showEndBtn)
end

function var_0_0._refreshEndBtnState(arg_11_0, arg_11_1)
	arg_11_0._showEndBtn = arg_11_1

	if not arg_11_1 then
		if not arg_11_0._btnend.gameObject.activeSelf then
			return
		end

		arg_11_0._endPlayer:Play("close", arg_11_0._onEndAnimDone, arg_11_0)

		return
	end

	gohelper.setActive(arg_11_0._btnend, arg_11_1)
	arg_11_0._endPlayer:Play("open", arg_11_0._onEndAnimDone, arg_11_0)
end

function var_0_0._startShowDialogOptionBtn(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._optionBtnList) do
		gohelper.setActive(iter_12_1[1], false)
	end
end

function var_0_0._showDialogOptionBtn(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1[1]
	local var_13_1 = var_13_0[1]
	local var_13_2 = var_13_0[5]
	local var_13_3 = var_13_0[6]
	local var_13_4 = var_13_0[2]
	local var_13_5 = var_13_0[3]

	arg_13_0._optionCallbackTarget = arg_13_1[2]
	arg_13_0._optionCallback = arg_13_1[3]

	if var_13_2 < 3 then
		var_13_5 = var_13_5 + 1
	end

	local var_13_6 = arg_13_0._optionBtnList[var_13_5] and arg_13_0._optionBtnList[var_13_5][1] or gohelper.clone(arg_13_0._gotalkitem, arg_13_0["_gobtnpos" .. var_13_5])

	gohelper.setActive(var_13_6, true)

	local var_13_7 = var_13_4

	gohelper.findChildText(var_13_6, "layout/txt_info").text = ":" .. var_13_7

	local var_13_8 = gohelper.findChildImage(var_13_6, "layout/txt_info/image_icon")

	UISpriteSetMgr.instance:setMeilanniSprite(var_13_8, var_13_3 or "bg_xuanzhe_1")

	local var_13_9 = var_13_6:GetComponent(gohelper.Type_Image)

	UISpriteSetMgr.instance:setMeilanniSprite(var_13_9, var_13_1 == -1 and "btn000" or "btn001")

	local var_13_10 = gohelper.findButtonWithAudio(var_13_6, AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

	var_13_10:AddClickListener(arg_13_0._onOptionClick, arg_13_0, var_13_0)

	if not arg_13_0._optionBtnList[var_13_5] then
		arg_13_0._optionBtnList[var_13_5] = {
			var_13_6,
			var_13_10
		}
		var_13_6.name = "talkitem_" .. tostring(var_13_5)
	end
end

function var_0_0._onOptionClick(arg_14_0, arg_14_1)
	arg_14_0._optionCallback(arg_14_0._optionCallbackTarget, arg_14_1)
end

function var_0_0._showDialogEndBtn(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1[1]

	arg_15_0._txtendinfo.text = var_15_0
	arg_15_0._callbackTarget = arg_15_1[2]
	arg_15_0._callback = arg_15_1[3]

	local var_15_1 = arg_15_1[4]

	if not var_15_1 then
		arg_15_0:_refreshEndBtnState(true)

		return
	end

	TaskDispatcher.cancelTask(arg_15_0._delayShowEndBtn, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._delayShowEndBtn, arg_15_0, var_15_1)
end

function var_0_0._delayShowEndBtn(arg_16_0)
	arg_16_0:_refreshEndBtnState(true)
end

function var_0_0._btnendOnClick(arg_17_0)
	arg_17_0._callback(arg_17_0._callbackTarget)
end

function var_0_0._dialogClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._delayShowEndBtn, arg_18_0)
	arg_18_0:_refreshEndBtnState(false)
	arg_18_0:_refreshDialogBtnState(false)
end

function var_0_0._resetMap(arg_19_0)
	arg_19_0:_dialogClose()
end

function var_0_0.onClose(arg_20_0)
	arg_20_0:_dialogClose()

	for iter_20_0, iter_20_1 in pairs(arg_20_0._optionBtnList) do
		iter_20_1[2]:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0

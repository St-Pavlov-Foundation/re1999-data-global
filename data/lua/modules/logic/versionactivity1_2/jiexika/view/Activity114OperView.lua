module("modules.logic.versionactivity1_2.jiexika.view.Activity114OperView", package.seeall)

local var_0_0 = class("Activity114OperView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._path = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.go = gohelper.findChild(arg_2_0.viewGO, arg_2_0._path)

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0.viewContainer:registerCallback(Activity114Event.ShowHideEduOper, arg_3_0.changeGoShow, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, arg_3_0.updateLock, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.UnLockRedDotUpdate, arg_3_0.updateUnLockRed, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0.viewContainer:unregisterCallback(Activity114Event.ShowHideEduOper, arg_4_0.changeGoShow, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, arg_4_0.updateLock, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.UnLockRedDotUpdate, arg_4_0.updateUnLockRed, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.opers = {}

	for iter_5_0 = 1, 4 do
		arg_5_0.opers[iter_5_0] = arg_5_0:getUserDataTb_()
		arg_5_0.opers[iter_5_0].btn = gohelper.findChildButtonWithAudio(arg_5_0.go, "#btn_oper" .. iter_5_0)
		arg_5_0.opers[iter_5_0].icon = gohelper.findChildImage(arg_5_0.go, "#btn_oper" .. iter_5_0 .. "/icon")
		arg_5_0.opers[iter_5_0].txticon = gohelper.findChildImage(arg_5_0.go, "#btn_oper" .. iter_5_0 .. "/txt")
		arg_5_0.opers[iter_5_0].line = gohelper.findChildImage(arg_5_0.go, "#btn_oper" .. iter_5_0 .. "/line")
		arg_5_0.opers[iter_5_0].go_lock = gohelper.findChild(arg_5_0.go, "#btn_oper" .. iter_5_0 .. "/#go_lock")
		arg_5_0.opers[iter_5_0].redPoint = gohelper.findChild(arg_5_0.go, "#btn_oper" .. iter_5_0 .. "/redPoint")
		arg_5_0.opers[iter_5_0].lockdesc = gohelper.findChildTextMesh(arg_5_0.go, "#btn_oper" .. iter_5_0 .. "/#go_lock/lockdesc")

		arg_5_0:addClickCb(arg_5_0.opers[iter_5_0].btn, arg_5_0.onBtnClick, arg_5_0, iter_5_0)
	end

	arg_5_0:updateLock()
end

function var_0_0.onBtnClick(arg_6_0, arg_6_1)
	if arg_6_0.opers[arg_6_1].go_lock.activeSelf then
		GameFacade.showToast(ToastEnum.Act114LockOper)

		return
	end

	if Activity114Model.instance:have114StoryFlow() then
		local var_6_0 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round)

		if var_6_0 and var_6_0.isSkip == 1 then
			return
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)

	if arg_6_1 == Activity114Enum.EventType.Edu then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)
		arg_6_0:_btneduOnClick()
	elseif arg_6_1 == Activity114Enum.EventType.Travel then
		arg_6_0:_btntravelOnClick()
	elseif arg_6_1 == Activity114Enum.EventType.Meet then
		arg_6_0:_btnmeetOnClick()
	elseif arg_6_1 == Activity114Enum.EventType.Rest then
		arg_6_0:_btnrestOnClick()
	end
end

function var_0_0.changeGoShow(arg_7_0, arg_7_1)
	if arg_7_0.go.activeSelf ~= arg_7_1 then
		return
	end

	if not arg_7_1 then
		gohelper.setActive(arg_7_0.go, true)
	end
end

function var_0_0.updateUnLockRed(arg_8_0)
	gohelper.setActive(arg_8_0.opers[Activity114Enum.EventType.Meet].redPoint, Activity114Model.instance:haveUnLockMeeting() and not arg_8_0.opers[Activity114Enum.EventType.Meet].go_lock.activeSelf)
	gohelper.setActive(arg_8_0.opers[Activity114Enum.EventType.Travel].redPoint, Activity114Model.instance:haveUnLockTravel() and not arg_8_0.opers[Activity114Enum.EventType.Travel].go_lock.activeSelf)
end

function var_0_0.updateLock(arg_9_0)
	local var_9_0 = Activity114Model.instance.serverData.week
	local var_9_1 = Activity114Model.instance.serverData.day
	local var_9_2 = Activity114Model.instance.serverData.round
	local var_9_3 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, var_9_1, var_9_2)

	if not var_9_3["banButton" .. var_9_0] then
		for iter_9_0 = 1, 4 do
			arg_9_0:setLock(iter_9_0, false)
		end

		arg_9_0:updateUnLockRed()

		return
	end

	local var_9_4 = string.splitToNumber(var_9_3["banButton" .. var_9_0], "#")
	local var_9_5 = {}

	for iter_9_1, iter_9_2 in pairs(var_9_4) do
		var_9_5[iter_9_2] = true
	end

	for iter_9_3 = 1, 4 do
		arg_9_0:setLock(iter_9_3, var_9_5[iter_9_3])
	end

	arg_9_0:updateUnLockRed()
end

function var_0_0.setLock(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:setLockColor(arg_10_0.opers[arg_10_1].icon, arg_10_2)

	if arg_10_0.opers[arg_10_1].txticon then
		arg_10_0:setLockColor(arg_10_0.opers[arg_10_1].txticon, arg_10_2)
		arg_10_0:setLockColor(arg_10_0.opers[arg_10_1].line, arg_10_2)
	end

	gohelper.setActive(arg_10_0.opers[arg_10_1].go_lock, arg_10_2)

	arg_10_0.opers[arg_10_1].btn.enabled = not arg_10_2 and true or false

	if arg_10_2 then
		local var_10_0 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round)

		arg_10_0.opers[arg_10_1].lockdesc.text = formatLuaLang("versionactivity_1_2_114mainview_lockdesc", var_10_0.desc)
	end
end

function var_0_0.setLockColor(arg_11_0, arg_11_1, arg_11_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_11_1, arg_11_2 and "#666666" or "#FFFFFF")
	ZProj.UGUIHelper.SetColorAlpha(arg_11_1, arg_11_2 and 0.8 or 1)
end

function var_0_0._btneduOnClick(arg_12_0)
	gohelper.setActive(arg_12_0.go, false)
	arg_12_0.viewContainer:dispatchEvent(Activity114Event.ShowHideEduOper, true)
end

function var_0_0._btntravelOnClick(arg_13_0)
	ViewMgr.instance:openView(ViewName.Activity114TravelView)
end

function var_0_0._btnrestOnClick(arg_14_0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Act114Rest, MsgBoxEnum.BoxType.Yes_No, arg_14_0._restClick, nil, nil, arg_14_0)
end

function var_0_0._restClick(arg_15_0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:restRequest(Activity114Model.instance.id)
end

function var_0_0._btnmeetOnClick(arg_16_0)
	ViewMgr.instance:openView(ViewName.Activity114MeetView)
end

return var_0_0

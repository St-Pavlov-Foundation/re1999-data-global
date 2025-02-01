module("modules.logic.versionactivity1_2.jiexika.view.Activity114OperView", package.seeall)

slot0 = class("Activity114OperView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._path = slot1
end

function slot0.onInitView(slot0)
	slot0.go = gohelper.findChild(slot0.viewGO, slot0._path)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.viewContainer:registerCallback(Activity114Event.ShowHideEduOper, slot0.changeGoShow, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, slot0.updateLock, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.UnLockRedDotUpdate, slot0.updateUnLockRed, slot0)
end

function slot0.removeEvents(slot0)
	slot0.viewContainer:unregisterCallback(Activity114Event.ShowHideEduOper, slot0.changeGoShow, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, slot0.updateLock, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.UnLockRedDotUpdate, slot0.updateUnLockRed, slot0)
end

function slot0._editableInitView(slot0)
	slot0.opers = {}

	for slot4 = 1, 4 do
		slot0.opers[slot4] = slot0:getUserDataTb_()
		slot0.opers[slot4].btn = gohelper.findChildButtonWithAudio(slot0.go, "#btn_oper" .. slot4)
		slot0.opers[slot4].icon = gohelper.findChildImage(slot0.go, "#btn_oper" .. slot4 .. "/icon")
		slot0.opers[slot4].txticon = gohelper.findChildImage(slot0.go, "#btn_oper" .. slot4 .. "/txt")
		slot0.opers[slot4].line = gohelper.findChildImage(slot0.go, "#btn_oper" .. slot4 .. "/line")
		slot0.opers[slot4].go_lock = gohelper.findChild(slot0.go, "#btn_oper" .. slot4 .. "/#go_lock")
		slot0.opers[slot4].redPoint = gohelper.findChild(slot0.go, "#btn_oper" .. slot4 .. "/redPoint")
		slot0.opers[slot4].lockdesc = gohelper.findChildTextMesh(slot0.go, "#btn_oper" .. slot4 .. "/#go_lock/lockdesc")

		slot0:addClickCb(slot0.opers[slot4].btn, slot0.onBtnClick, slot0, slot4)
	end

	slot0:updateLock()
end

function slot0.onBtnClick(slot0, slot1)
	if slot0.opers[slot1].go_lock.activeSelf then
		GameFacade.showToast(ToastEnum.Act114LockOper)

		return
	end

	if Activity114Model.instance:have114StoryFlow() and Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round) and slot2.isSkip == 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)

	if slot1 == Activity114Enum.EventType.Edu then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)
		slot0:_btneduOnClick()
	elseif slot1 == Activity114Enum.EventType.Travel then
		slot0:_btntravelOnClick()
	elseif slot1 == Activity114Enum.EventType.Meet then
		slot0:_btnmeetOnClick()
	elseif slot1 == Activity114Enum.EventType.Rest then
		slot0:_btnrestOnClick()
	end
end

function slot0.changeGoShow(slot0, slot1)
	if slot0.go.activeSelf ~= slot1 then
		return
	end

	if not slot1 then
		gohelper.setActive(slot0.go, true)
	end
end

function slot0.updateUnLockRed(slot0)
	gohelper.setActive(slot0.opers[Activity114Enum.EventType.Meet].redPoint, Activity114Model.instance:haveUnLockMeeting() and not slot0.opers[Activity114Enum.EventType.Meet].go_lock.activeSelf)
	gohelper.setActive(slot0.opers[Activity114Enum.EventType.Travel].redPoint, Activity114Model.instance:haveUnLockTravel() and not slot0.opers[Activity114Enum.EventType.Travel].go_lock.activeSelf)
end

function slot0.updateLock(slot0)
	if not Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round)["banButton" .. Activity114Model.instance.serverData.week] then
		for slot8 = 1, 4 do
			slot0:setLock(slot8, false)
		end

		slot0:updateUnLockRed()

		return
	end

	slot6 = {
		[slot11] = true
	}

	for slot10, slot11 in pairs(string.splitToNumber(slot4["banButton" .. slot1], "#")) do
		-- Nothing
	end

	for slot10 = 1, 4 do
		slot0:setLock(slot10, slot6[slot10])
	end

	slot0:updateUnLockRed()
end

function slot0.setLock(slot0, slot1, slot2)
	slot0:setLockColor(slot0.opers[slot1].icon, slot2)

	if slot0.opers[slot1].txticon then
		slot0:setLockColor(slot0.opers[slot1].txticon, slot2)
		slot0:setLockColor(slot0.opers[slot1].line, slot2)
	end

	gohelper.setActive(slot0.opers[slot1].go_lock, slot2)

	slot0.opers[slot1].btn.enabled = not slot2 and true or false

	if slot2 then
		slot0.opers[slot1].lockdesc.text = formatLuaLang("versionactivity_1_2_114mainview_lockdesc", Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round).desc)
	end
end

function slot0.setLockColor(slot0, slot1, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot1, slot2 and "#666666" or "#FFFFFF")
	ZProj.UGUIHelper.SetColorAlpha(slot1, slot2 and 0.8 or 1)
end

function slot0._btneduOnClick(slot0)
	gohelper.setActive(slot0.go, false)
	slot0.viewContainer:dispatchEvent(Activity114Event.ShowHideEduOper, true)
end

function slot0._btntravelOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Activity114TravelView)
end

function slot0._btnrestOnClick(slot0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Act114Rest, MsgBoxEnum.BoxType.Yes_No, slot0._restClick, nil, , slot0)
end

function slot0._restClick(slot0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:restRequest(Activity114Model.instance.id)
end

function slot0._btnmeetOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Activity114MeetView)
end

return slot0

module("modules.logic.versionactivity1_2.jiexika.view.Activity114EduOperView", package.seeall)

slot0 = class("Activity114EduOperView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._path = slot1
end

function slot0.onInitView(slot0)
	slot0.go = gohelper.findChild(slot0.viewGO, slot0._path)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.go, "#btn_close")
	slot0._btneduoper = gohelper.findChildButtonWithAudio(slot0.go, "title/#btn_eduoper")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._hideGo, slot0)
	slot0._btneduoper:AddClickListener(slot0.onLearn, slot0)
	slot0.viewContainer:registerCallback(Activity114Event.ShowHideEduOper, slot0.changeGoShow, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, slot0.updateLock, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttentionUpdate, slot0.updateFailRate, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btneduoper:RemoveClickListener()
	slot0.viewContainer:unregisterCallback(Activity114Event.ShowHideEduOper, slot0.changeGoShow, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, slot0.updateLock, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttentionUpdate, slot0.updateFailRate, slot0)
end

function slot0._editableInitView(slot0)
	Activity114Model.instance.eduSelectAttr = nil
	slot0.attrTb = {}

	for slot4 = 1, Activity114Enum.Attr.End - 1 do
		slot5 = slot0:getUserDataTb_()
		slot5.btn = gohelper.findChildButtonWithAudio(slot0.go, "#btn_attr" .. slot4)
		slot5.normal = gohelper.findChild(slot0.go, "#btn_attr" .. slot4 .. "/normal")
		slot5.select = gohelper.findChild(slot0.go, "#btn_attr" .. slot4 .. "/select")
		slot5.txtFailRate = gohelper.findChildTextMesh(slot0.go, "#btn_attr" .. slot4 .. "/select/#txt_failRate")

		slot0:addClickCb(slot5.btn, slot0.selectLearnAttr, slot0, slot4)

		slot0.attrTb[slot4] = slot5
	end

	slot0:updateFailRate()
	slot0:_hideGo()
end

function slot0.changeGoShow(slot0, slot1)
	if slot0.go.activeSelf == slot1 then
		return
	end

	if slot1 then
		gohelper.setActive(slot0.go, true)
		slot0:selectLearnAttr(PlayerPrefsHelper.getNumber(PlayerPrefsKey.JieXiKaLastEduSelect, 0) > 0 and slot2 or nil, true)
	end
end

function slot0.updateFailRate(slot0)
	for slot4 = 1, Activity114Enum.Attr.End - 1 do
		slot6 = 0

		if Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, slot4) and slot5.successVerify[Activity114Enum.AddAttrType.Attention] then
			slot6 = slot5.successVerify[Activity114Enum.AddAttrType.Attention]
		end

		slot0.attrTb[slot4].txtFailRate.text = formatLuaLang("versionactivity_1_2_114success_rate", Activity114Config.instance:getEduSuccessRate(Activity114Model.instance.id, slot4, Activity114Model.instance.serverData.attention + slot6))
	end
end

function slot0.selectLearnAttr(slot0, slot1, slot2)
	if Activity114Model.instance.eduSelectAttr ~= slot1 then
		if not slot2 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_subject_choose)
		end

		Activity114Model.instance.eduSelectAttr = slot1

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.JieXiKaLastEduSelect, slot1)
		slot0.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
	end

	for slot6 = 1, Activity114Enum.Attr.End - 1 do
		gohelper.setActive(slot0.attrTb[slot6].select, slot6 == slot1)
		gohelper.setActive(slot0.attrTb[slot6].normal, slot6 ~= slot1)
	end
end

function slot0.onLearn(slot0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	if not Activity114Model.instance.eduSelectAttr then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	Activity114Model.instance:beginEvent({
		type = Activity114Enum.EventType.Edu,
		eventId = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, Activity114Model.instance.eduSelectAttr).config.id
	})
	slot0:_hideGo()
end

function slot0.updateLock(slot0)
	if not slot0.go.activeSelf then
		return
	end

	if not Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round)["banButton" .. Activity114Model.instance.serverData.week] then
		return
	end

	for slot9, slot10 in pairs(string.splitToNumber(slot4["banButton" .. slot1], "#")) do
		if slot10 == Activity114Enum.EventType.Edu then
			slot0:_hideGo()

			return
		end
	end
end

function slot0._hideGo(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	gohelper.setActive(slot0.go, false)
	slot0.viewContainer:dispatchEvent(Activity114Event.ShowHideEduOper, false)

	if Activity114Model.instance.eduSelectAttr then
		Activity114Model.instance.eduSelectAttr = nil

		slot0.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
	end
end

function slot0.onClose(slot0)
	Activity114Model.instance.eduSelectAttr = nil

	slot0.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
end

return slot0

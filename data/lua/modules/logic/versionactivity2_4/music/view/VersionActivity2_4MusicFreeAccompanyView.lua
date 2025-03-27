module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeAccompanyView", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeAccompanyView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotime = gohelper.findChild(slot0.viewGO, "root/#go_time")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "root/#go_time/valuebg/#input_value")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_time/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_time/#btn_add")
	slot0._godynamics = gohelper.findChild(slot0.viewGO, "root/centercir/#go_dynamics")
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "root/centercir/#go_center")
	slot0._gostate = gohelper.findChild(slot0.viewGO, "root/centercir/#go_state")
	slot0._gostate1 = gohelper.findChild(slot0.viewGO, "root/centercir/#go_state/#go_state1")
	slot0._gostate2 = gohelper.findChild(slot0.viewGO, "root/centercir/#go_state/#go_state2")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/centercir/#btn_click")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if not slot0._audioStartScale then
		return
	end

	slot0._curValue = math.ceil((slot0._audioStartScale - slot0._dynamicScale) * slot0._time * 1000)

	if slot0._curValue < 0 then
		slot0._curValue = 0
	end

	slot0._audioStartScale = nil

	slot0:_checkLimit()
end

function slot0._btnsubOnClick(slot0)
	slot0._curValue = slot0._curValue - slot0._stepValue

	slot0:_checkLimit()
end

function slot0._btnaddOnClick(slot0)
	slot0._curValue = slot0._curValue + slot0._stepValue

	slot0:_checkLimit()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._minValue = 0
	slot0._maxValue = 2000
	slot0._stepValue = 1
	slot0._curValue = Activity179Model.instance:getCalibration() * 1000
	slot0._time = 2
	slot0._audioId = 20240027
	slot0._centerScale = 3
	slot0._startScale = 1
	slot0._endScale = 0
	slot0._audioScale = 0.75
	slot0._audioOffsetTime = (slot0._startScale - slot0._audioScale) * slot0._time * 1000

	slot0:_checkLimit()
	slot0._inputvalue:AddOnEndEdit(slot0._onEndEdit, slot0)
	slot0:_startCalibration()
end

function slot0._updateInputValue(slot0)
	slot0._inputvalue:SetText(slot0._curValue)
end

function slot0._onEndEdit(slot0)
	slot0._curValue = tonumber(slot0._inputvalue:GetText()) or 0

	slot0:_checkLimit()
end

function slot0._checkLimit(slot0)
	slot0._curValue = math.max(slot0._minValue, math.min(slot0._maxValue, slot0._curValue))

	Activity179Model.instance:setCalibration(slot0._curValue)
	slot0:_updateInputValue()

	slot2 = (slot0._maxValue - (slot0._curValue + slot0._audioOffsetTime)) / slot0._maxValue * slot0._centerScale

	transformhelper.setLocalScale(slot0._gocenter.transform, slot2, slot2, slot2)
end

function slot0._startCalibration(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._audioStartScale = nil
	slot0._dynamicScale = slot0._startScale
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._startScale, slot0._endScale, slot0._time, slot0._frameCallback, slot0._tweenFinish, slot0)
end

function slot0._frameCallback(slot0, slot1)
	if slot0._audioScale <= slot0._dynamicScale and slot1 <= slot0._audioScale then
		AudioMgr.instance:trigger(slot0._audioId)

		slot0._audioStartScale = slot1
	end

	slot0._dynamicScale = slot1

	transformhelper.setLocalScale(slot0._godynamics.transform, slot1, slot1, slot1)
end

function slot0._tweenFinish(slot0)
	slot0:_startCalibration()
end

function slot0.onClose(slot0)
	slot0._inputvalue:RemoveOnEndEdit()

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0

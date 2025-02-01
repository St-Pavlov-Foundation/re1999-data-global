module("modules.logic.versionactivity1_4.act131.view.Activity131LogItem", package.seeall)

slot0 = class("Activity131LogItem", MixScrollCell)
slot1 = SLFramework.UGUI.GuiHelper

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._goname = gohelper.findChild(slot0.viewGO, "#go_normal/#go_name")
	slot0._goplayicon = gohelper.findChild(slot0.viewGO, "#go_normal/#go_playicon")
	slot0._gostopicon = gohelper.findChild(slot0.viewGO, "#go_normal/#go_stopicon")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_normal/#go_name/#go_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_normal/#go_name/#txt_name")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_content")
	slot0._gonorole = gohelper.findChild(slot0.viewGO, "#go_normal/#go_norole")
	slot0._btnplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_play")
	slot0._btnstop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_stop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._btnplay:AddClickListener(slot0._onPlayClick, slot0)
	slot0._btnstop:AddClickListener(slot0._onStopClick, slot0)
	Activity131Controller.instance:registerCallback(Activity131Event.LogSelected, slot0._onItemSelected, slot0)
	Activity131Controller.instance:registerCallback(Activity131Event.LogAudioFinished, slot0._onItemAudioFinished, slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._onItemAudioFinished(slot0)
	if not slot0._audioId or slot0._audioId == 0 then
		return
	end

	if not slot0._mo or type(slot0._mo.info) ~= "number" then
		return
	end

	if slot0._audioId == Activity131LogListModel.instance:getPlayingLogAudioId() then
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._goplayicon, true)
		gohelper.setActive(slot0._btnplay.gameObject, true)
		gohelper.setActive(slot0._btnstop.gameObject, false)

		if slot0:_isPlayerSpeech() then
			uv0.SetColor(slot0._txtname, "#CCAD8F")
			uv0.SetColor(slot0._txtcontent, "#CCAD8F")
			slot0:_setSpriteMeshColor("#CCAD8F")
		else
			uv0.SetColor(slot0._txtname, "#EEF1E8")
			uv0.SetColor(slot0._txtcontent, "#EEF1E8")
			slot0:_setSpriteMeshColor("#EEF1E8")
			uv0.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
		end
	end
end

function slot0._onItemSelected(slot0, slot1)
	if not slot1 or slot1 == 0 or not slot0._audioId or slot0._audioId == 0 then
		return
	end

	if slot0._audioId == slot1 then
		return
	end

	if slot0._audioId ~= 0 then
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
		gohelper.setActive(slot0._goplayicon, true)
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._btnplay.gameObject, true)
		gohelper.setActive(slot0._btnstop.gameObject, false)
	else
		gohelper.setActive(slot0._goplayicon, false)
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._btnplay.gameObject, false)
		gohelper.setActive(slot0._btnstop.gameObject, false)
	end
end

function slot0._onPlayClick(slot0)
	gohelper.setActive(slot0._gostopicon, true)
	gohelper.setActive(slot0._goplayicon, false)
	gohelper.setActive(slot0._btnplay.gameObject, false)
	gohelper.setActive(slot0._btnstop.gameObject, true)
	uv0.SetColor(slot0._txtname, "#D56B39")
	uv0.SetColor(slot0._txtcontent, "#D56B39")
	slot0:_setSpriteMeshColor("#D56B39")
	uv0.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")

	if slot0._audioId ~= 0 and Activity131LogListModel.instance:getPlayingLogAudioId() ~= slot0._audioId then
		AudioEffectMgr.instance:stopAudio(Activity131LogListModel.instance:getPlayingLogAudioId(), 0)
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
	end

	AudioEffectMgr.instance:playAudio(slot0._audioId, {
		loopNum = 1,
		fadeInTime = 0,
		fadeOutTime = 0,
		volume = 100,
		callback = slot0._onAudioFinished,
		callbackTarget = slot0
	})
	Activity131LogListModel.instance:setPlayingLogAudio(slot0._audioId)
	Activity131Controller.instance:dispatchEvent(Activity131Event.LogSelected, slot0._audioId)
end

function slot0._onStopClick(slot0)
	gohelper.setActive(slot0._gostopicon, false)
	gohelper.setActive(slot0._goplayicon, true)
	gohelper.setActive(slot0._btnplay.gameObject, true)
	gohelper.setActive(slot0._btnstop.gameObject, false)

	if slot0:_isPlayerSpeech() then
		uv0.SetColor(slot0._txtname, "#CCAD8F")
		uv0.SetColor(slot0._txtcontent, "#CCAD8F")
		slot0:_setSpriteMeshColor("#CCAD8F")
	else
		uv0.SetColor(slot0._txtname, "#EEF1E8")
		uv0.SetColor(slot0._txtcontent, "#EEF1E8")
		slot0:_setSpriteMeshColor("#EEF1E8")
		uv0.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end

	Activity131LogListModel.instance:setPlayingLogAudioFinished(slot0._audioId)
	AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
end

function slot0._onAudioFinished(slot0)
	Activity131Controller.instance:dispatchEvent(Activity131Event.LogAudioFinished)

	if slot0._audioId ~= Activity131LogListModel.instance:getPlayingLogAudioId() then
		Activity131LogListModel.instance:setPlayingLogAudio(0)
	end

	if slot0._audioId == 0 then
		return
	end

	Activity131LogListModel.instance:setPlayingLogAudioFinished(slot0._audioId)
	gohelper.setActive(slot0._gostopicon, false)
	gohelper.setActive(slot0._goplayicon, true)
	gohelper.setActive(slot0._btnplay.gameObject, true)
	gohelper.setActive(slot0._btnstop.gameObject, false)

	if slot0:_isPlayerSpeech() then
		uv0.SetColor(slot0._txtname, "#CCAD8F")
		uv0.SetColor(slot0._txtcontent, "#CCAD8F")
		slot0:_setSpriteMeshColor("#CCAD8F")
	else
		uv0.SetColor(slot0._txtname, "#EEF1E8")
		uv0.SetColor(slot0._txtcontent, "#EEF1E8")
		slot0:_setSpriteMeshColor("#EEF1E8")
		uv0.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._mo = slot1

	uv0.SetColor(slot0._txtname, "#EEF1E8")
	uv0.SetColor(slot0._txtcontent, "#EEF1E8")
	slot0:_setSpriteMeshColor("#EEF1E8")
	uv0.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")

	slot0._txtcontent.text = slot1:getSpeech()
	slot0._audioId = slot1:getAudioId()

	gohelper.setActive(slot0._gonorole, false)

	if string.nilorempty(slot1:getSpeaker()) or slot2 == 1 then
		gohelper.setActive(slot0._goname, false)
	else
		slot0._txtname.text = string.format("%s:", slot1:getSpeaker())

		gohelper.setActive(slot0._goname, true)
	end

	slot0:_refreshAudioStatus()

	if slot0:_isPlayerSpeech() then
		gohelper.setActive(slot0._goicon, true)
		uv0.SetColor(slot0._txtname, "#CCAD8F")
		uv0.SetColor(slot0._txtcontent, "#CCAD8F")
		slot0:_setSpriteMeshColor("#CCAD8F")
	else
		gohelper.setActive(slot0._goicon, false)
	end
end

function slot0._refreshAudioStatus(slot0)
	if slot0._audioId ~= 0 then
		slot1 = slot0._audioId == Activity131LogListModel.instance:getPlayingLogAudioId()

		gohelper.setActive(slot0._gostopicon, slot1)
		gohelper.setActive(slot0._goplayicon, not slot1)
		gohelper.setActive(slot0._btnplay.gameObject, not slot1)
		gohelper.setActive(slot0._btnstop.gameObject, slot1)

		if slot1 then
			uv0.SetColor(slot0._txtname, "#D56B39")
			uv0.SetColor(slot0._txtcontent, "#D56B39")
			slot0:_setSpriteMeshColor("#D56B39")
			uv0.SetColor(slot0._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")
		end
	else
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._goplayicon, false)
		gohelper.setActive(slot0._btnplay.gameObject, false)
		gohelper.setActive(slot0._btnstop.gameObject, false)
	end
end

function slot0._setSpriteMeshColor(slot0, slot1)
	TaskDispatcher.runDelay(function ()
		if not uv0._txtcontent then
			return
		end

		slot0 = {}

		if uv0._txtcontent.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true) then
			slot2 = slot1:GetEnumerator()

			while slot2:MoveNext() do
				table.insert(slot0, slot2.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI)))
			end
		end

		for slot6, slot7 in pairs(slot0) do
			if slot7.materialForRendering then
				slot7.materialForRendering:EnableKeyword("_GRADUAL_ON")
				slot7.materialForRendering:SetColor("_Color", GameUtil.parseColor(uv1 .. "FF"))
			end
		end
	end, nil, 0.01)
end

function slot0._isPlayerSpeech(slot0)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroy(slot0)
	if slot0._audioId ~= 0 then
		Activity131LogListModel.instance:setPlayingLogAudioFinished(slot0._audioId)
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
	end

	slot0._btnplay:RemoveClickListener()
	slot0._btnstop:RemoveClickListener()
	Activity131Controller.instance:unregisterCallback(Activity131Event.LogSelected, slot0._onItemSelected, slot0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.LogAudioFinished, slot0._onItemAudioFinished, slot0)
end

return slot0

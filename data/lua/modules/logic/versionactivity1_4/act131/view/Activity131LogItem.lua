module("modules.logic.versionactivity1_4.act131.view.Activity131LogItem", package.seeall)

local var_0_0 = class("Activity131LogItem", MixScrollCell)
local var_0_1 = SLFramework.UGUI.GuiHelper

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_name")
	arg_1_0._goplayicon = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_playicon")
	arg_1_0._gostopicon = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_stopicon")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_name/#go_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#go_name/#txt_name")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_content")
	arg_1_0._gonorole = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_norole")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_play")
	arg_1_0._btnstop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_stop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._btnplay:AddClickListener(arg_4_0._onPlayClick, arg_4_0)
	arg_4_0._btnstop:AddClickListener(arg_4_0._onStopClick, arg_4_0)
	Activity131Controller.instance:registerCallback(Activity131Event.LogSelected, arg_4_0._onItemSelected, arg_4_0)
	Activity131Controller.instance:registerCallback(Activity131Event.LogAudioFinished, arg_4_0._onItemAudioFinished, arg_4_0)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0._onItemAudioFinished(arg_7_0)
	if not arg_7_0._audioId or arg_7_0._audioId == 0 then
		return
	end

	if not arg_7_0._mo or type(arg_7_0._mo.info) ~= "number" then
		return
	end

	if arg_7_0._audioId == Activity131LogListModel.instance:getPlayingLogAudioId() then
		gohelper.setActive(arg_7_0._gostopicon, false)
		gohelper.setActive(arg_7_0._goplayicon, true)
		gohelper.setActive(arg_7_0._btnplay.gameObject, true)
		gohelper.setActive(arg_7_0._btnstop.gameObject, false)

		if arg_7_0:_isPlayerSpeech() then
			var_0_1.SetColor(arg_7_0._txtname, "#CCAD8F")
			var_0_1.SetColor(arg_7_0._txtcontent, "#CCAD8F")
			arg_7_0:_setSpriteMeshColor("#CCAD8F")
		else
			var_0_1.SetColor(arg_7_0._txtname, "#EEF1E8")
			var_0_1.SetColor(arg_7_0._txtcontent, "#EEF1E8")
			arg_7_0:_setSpriteMeshColor("#EEF1E8")
			var_0_1.SetColor(arg_7_0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
		end
	end
end

function var_0_0._onItemSelected(arg_8_0, arg_8_1)
	if not arg_8_1 or arg_8_1 == 0 or not arg_8_0._audioId or arg_8_0._audioId == 0 then
		return
	end

	if arg_8_0._audioId == arg_8_1 then
		return
	end

	if arg_8_0._audioId ~= 0 then
		AudioEffectMgr.instance:stopAudio(arg_8_0._audioId, 0)
		gohelper.setActive(arg_8_0._goplayicon, true)
		gohelper.setActive(arg_8_0._gostopicon, false)
		gohelper.setActive(arg_8_0._btnplay.gameObject, true)
		gohelper.setActive(arg_8_0._btnstop.gameObject, false)
	else
		gohelper.setActive(arg_8_0._goplayicon, false)
		gohelper.setActive(arg_8_0._gostopicon, false)
		gohelper.setActive(arg_8_0._btnplay.gameObject, false)
		gohelper.setActive(arg_8_0._btnstop.gameObject, false)
	end
end

function var_0_0._onPlayClick(arg_9_0)
	gohelper.setActive(arg_9_0._gostopicon, true)
	gohelper.setActive(arg_9_0._goplayicon, false)
	gohelper.setActive(arg_9_0._btnplay.gameObject, false)
	gohelper.setActive(arg_9_0._btnstop.gameObject, true)
	var_0_1.SetColor(arg_9_0._txtname, "#D56B39")
	var_0_1.SetColor(arg_9_0._txtcontent, "#D56B39")
	arg_9_0:_setSpriteMeshColor("#D56B39")
	var_0_1.SetColor(arg_9_0._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")

	if arg_9_0._audioId ~= 0 and Activity131LogListModel.instance:getPlayingLogAudioId() ~= arg_9_0._audioId then
		AudioEffectMgr.instance:stopAudio(Activity131LogListModel.instance:getPlayingLogAudioId(), 0)
		AudioEffectMgr.instance:stopAudio(arg_9_0._audioId, 0)
	end

	local var_9_0 = {}

	var_9_0.loopNum = 1
	var_9_0.fadeInTime = 0
	var_9_0.fadeOutTime = 0
	var_9_0.volume = 100
	var_9_0.callback = arg_9_0._onAudioFinished
	var_9_0.callbackTarget = arg_9_0

	AudioEffectMgr.instance:playAudio(arg_9_0._audioId, var_9_0)
	Activity131LogListModel.instance:setPlayingLogAudio(arg_9_0._audioId)
	Activity131Controller.instance:dispatchEvent(Activity131Event.LogSelected, arg_9_0._audioId)
end

function var_0_0._onStopClick(arg_10_0)
	gohelper.setActive(arg_10_0._gostopicon, false)
	gohelper.setActive(arg_10_0._goplayicon, true)
	gohelper.setActive(arg_10_0._btnplay.gameObject, true)
	gohelper.setActive(arg_10_0._btnstop.gameObject, false)

	if arg_10_0:_isPlayerSpeech() then
		var_0_1.SetColor(arg_10_0._txtname, "#CCAD8F")
		var_0_1.SetColor(arg_10_0._txtcontent, "#CCAD8F")
		arg_10_0:_setSpriteMeshColor("#CCAD8F")
	else
		var_0_1.SetColor(arg_10_0._txtname, "#EEF1E8")
		var_0_1.SetColor(arg_10_0._txtcontent, "#EEF1E8")
		arg_10_0:_setSpriteMeshColor("#EEF1E8")
		var_0_1.SetColor(arg_10_0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end

	Activity131LogListModel.instance:setPlayingLogAudioFinished(arg_10_0._audioId)
	AudioEffectMgr.instance:stopAudio(arg_10_0._audioId, 0)
end

function var_0_0._onAudioFinished(arg_11_0)
	Activity131Controller.instance:dispatchEvent(Activity131Event.LogAudioFinished)

	if arg_11_0._audioId ~= Activity131LogListModel.instance:getPlayingLogAudioId() then
		Activity131LogListModel.instance:setPlayingLogAudio(0)
	end

	if arg_11_0._audioId == 0 then
		return
	end

	Activity131LogListModel.instance:setPlayingLogAudioFinished(arg_11_0._audioId)
	gohelper.setActive(arg_11_0._gostopicon, false)
	gohelper.setActive(arg_11_0._goplayicon, true)
	gohelper.setActive(arg_11_0._btnplay.gameObject, true)
	gohelper.setActive(arg_11_0._btnstop.gameObject, false)

	if arg_11_0:_isPlayerSpeech() then
		var_0_1.SetColor(arg_11_0._txtname, "#CCAD8F")
		var_0_1.SetColor(arg_11_0._txtcontent, "#CCAD8F")
		arg_11_0:_setSpriteMeshColor("#CCAD8F")
	else
		var_0_1.SetColor(arg_11_0._txtname, "#EEF1E8")
		var_0_1.SetColor(arg_11_0._txtcontent, "#EEF1E8")
		arg_11_0:_setSpriteMeshColor("#EEF1E8")
		var_0_1.SetColor(arg_11_0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_1 then
		return
	end

	arg_12_0._mo = arg_12_1

	var_0_1.SetColor(arg_12_0._txtname, "#EEF1E8")
	var_0_1.SetColor(arg_12_0._txtcontent, "#EEF1E8")
	arg_12_0:_setSpriteMeshColor("#EEF1E8")
	var_0_1.SetColor(arg_12_0._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")

	arg_12_0._txtcontent.text = arg_12_1:getSpeech()
	arg_12_0._audioId = arg_12_1:getAudioId()

	gohelper.setActive(arg_12_0._gonorole, false)

	if string.nilorempty(arg_12_1:getSpeaker()) or arg_12_2 == 1 then
		gohelper.setActive(arg_12_0._goname, false)
	else
		arg_12_0._txtname.text = string.format("%s:", arg_12_1:getSpeaker())

		gohelper.setActive(arg_12_0._goname, true)
	end

	arg_12_0:_refreshAudioStatus()

	if arg_12_0:_isPlayerSpeech() then
		gohelper.setActive(arg_12_0._goicon, true)
		var_0_1.SetColor(arg_12_0._txtname, "#CCAD8F")
		var_0_1.SetColor(arg_12_0._txtcontent, "#CCAD8F")
		arg_12_0:_setSpriteMeshColor("#CCAD8F")
	else
		gohelper.setActive(arg_12_0._goicon, false)
	end
end

function var_0_0._refreshAudioStatus(arg_13_0)
	if arg_13_0._audioId ~= 0 then
		local var_13_0 = arg_13_0._audioId == Activity131LogListModel.instance:getPlayingLogAudioId()

		gohelper.setActive(arg_13_0._gostopicon, var_13_0)
		gohelper.setActive(arg_13_0._goplayicon, not var_13_0)
		gohelper.setActive(arg_13_0._btnplay.gameObject, not var_13_0)
		gohelper.setActive(arg_13_0._btnstop.gameObject, var_13_0)

		if var_13_0 then
			var_0_1.SetColor(arg_13_0._txtname, "#D56B39")
			var_0_1.SetColor(arg_13_0._txtcontent, "#D56B39")
			arg_13_0:_setSpriteMeshColor("#D56B39")
			var_0_1.SetColor(arg_13_0._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")
		end
	else
		gohelper.setActive(arg_13_0._gostopicon, false)
		gohelper.setActive(arg_13_0._goplayicon, false)
		gohelper.setActive(arg_13_0._btnplay.gameObject, false)
		gohelper.setActive(arg_13_0._btnstop.gameObject, false)
	end
end

function var_0_0._setSpriteMeshColor(arg_14_0, arg_14_1)
	TaskDispatcher.runDelay(function()
		if not arg_14_0._txtcontent then
			return
		end

		local var_15_0 = {}
		local var_15_1 = arg_14_0._txtcontent.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

		if var_15_1 then
			local var_15_2 = var_15_1:GetEnumerator()

			while var_15_2:MoveNext() do
				local var_15_3 = var_15_2.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

				table.insert(var_15_0, var_15_3)
			end
		end

		local var_15_4 = GameUtil.parseColor(arg_14_1 .. "FF")

		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			if iter_15_1.materialForRendering then
				iter_15_1.materialForRendering:EnableKeyword("_GRADUAL_ON")
				iter_15_1.materialForRendering:SetColor("_Color", var_15_4)
			end
		end
	end, nil, 0.01)
end

function var_0_0._isPlayerSpeech(arg_16_0)
	return
end

function var_0_0.onSelect(arg_17_0, arg_17_1)
	return
end

function var_0_0.onDestroy(arg_18_0)
	if arg_18_0._audioId ~= 0 then
		Activity131LogListModel.instance:setPlayingLogAudioFinished(arg_18_0._audioId)
		AudioEffectMgr.instance:stopAudio(arg_18_0._audioId, 0)
	end

	arg_18_0._btnplay:RemoveClickListener()
	arg_18_0._btnstop:RemoveClickListener()
	Activity131Controller.instance:unregisterCallback(Activity131Event.LogSelected, arg_18_0._onItemSelected, arg_18_0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.LogAudioFinished, arg_18_0._onItemAudioFinished, arg_18_0)
end

return var_0_0

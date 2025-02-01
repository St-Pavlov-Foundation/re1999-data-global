module("modules.logic.versionactivity1_8.warmup.view.Act1_8WarmUpLeftView", package.seeall)

slot0 = class("Act1_8WarmUpLeftView", BaseView)
slot1 = "v1a8_warmup_img_pic"
slot2 = "v1a8_warmup_img_test"

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "Middle/#image_icon")
	slot0._imagetest = gohelper.findChildImage(slot0.viewGO, "Middle/#image_test")
	slot0._gocorrect = gohelper.findChild(slot0.viewGO, "Middle/#go_correct")
	slot0._btncorrect = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#go_correct/#btn_correct")
	slot0._goerror = gohelper.findChild(slot0.viewGO, "Middle/#go_error")
	slot0._btnerror = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#go_error/#btn_error")
	slot0._gofile = gohelper.findChild(slot0.viewGO, "Middle/#go_file")
	slot0._btnfile = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#go_file/#btn_file")
	slot0._goinput = gohelper.findChild(slot0.viewGO, "Middle/#go_input")
	slot0._btnbubblemask = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#go_input/#btn_bubblemask")
	slot0._inputanswer = gohelper.findChildTextMeshInputField(slot0.viewGO, "Middle/#go_input/#input_answer")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#go_input/#btn_confirm")
	slot0._btntips = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#go_input/#btn_tips")
	slot0._gobubble = gohelper.findChild(slot0.viewGO, "Middle/#go_input/#btn_tips/bubble")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "Middle/#go_input/#btn_tips/bubble/#txt_tips")
	slot0._btnbubble = gohelper.findChildButtonWithAudio(slot0._gobubble, "")
	slot0._flashAnim = gohelper.findChild(slot0.viewGO, "Middle/eff_badtv"):GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncorrect:AddClickListener(slot0._btnCorrectOnClick, slot0)
	slot0._btnerror:AddClickListener(slot0._btnErrorOnClick, slot0)
	slot0._btnfile:AddClickListener(slot0._btnFileOnClick, slot0)
	slot0._btnbubblemask:AddClickListener(slot0._btnMaskOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnConfirmOnClick, slot0)
	slot0._btntips:AddClickListener(slot0._btnTipsOnClick, slot0)
	slot0._btnbubble:AddClickListener(slot0._btnBubbleOnClick, slot0)
	slot0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0._refreshUI, slot0)
	slot0:addEventCb(Activity125Controller.instance, Activity125Event.SwitchEpisode, slot0._onSwitchEpisode, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncorrect:RemoveClickListener()
	slot0._btnerror:RemoveClickListener()
	slot0._btnfile:RemoveClickListener()
	slot0._btnbubblemask:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btntips:RemoveClickListener()
	slot0._btnbubble:RemoveClickListener()
	slot0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0._refreshUI, slot0)
	slot0:removeEventCb(Activity125Controller.instance, Activity125Event.SwitchEpisode, slot0._onSwitchEpisode, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)

	slot0.userId = PlayerModel.instance:getMyUserId()
	slot0._actId = ActivityEnum.Activity.Activity1_8WarmUp

	if Activity125Model.instance:getById(slot0._actId) then
		slot0:_refreshUI()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshUI(slot0)
	slot0._curLvl = Activity125Model.instance:getSelectEpisodeId(slot0._actId)
	slot0._errorTimesKey = string.format("%s_%s_%s_%s", slot0.userId, "1_8WarmUpErrorTime", slot0._actId, slot0._curLvl)
	slot0._episodeCfg = Activity125Config.instance:getEpisodeConfig(slot0._actId, slot0._curLvl)

	UISpriteSetMgr.instance:setV1a8WarmUpSprite(slot0._imageicon, uv0 .. slot0._curLvl)
	UISpriteSetMgr.instance:setV1a8WarmUpSprite(slot0._imagetest, uv1 .. slot0._curLvl)

	slot0._txttips.text = slot0._episodeCfg.key

	slot0._inputanswer:SetText("")
	slot0:_refreshActiveStatus()
end

function slot0._refreshActiveStatus(slot0)
	slot4 = Activity125Model.instance:isEpisodeFinished(slot0._actId, slot0._curLvl) or Activity125Model.instance:checkLocalIsPlay(slot0._actId, slot0._curLvl) or Activity125Model.instance:checkIsOldEpisode(slot0._actId, slot0._curLvl)
	slot6 = slot0._curLvl == 1 and PlayerPrefsHelper.getNumber(PlayerPrefsKey.Act1_8WarmUpClickFile .. slot0.userId, 0) == 0

	gohelper.setActive(slot0._imageicon, slot4)
	gohelper.setActive(slot0._gofile, not slot4 and slot6)
	gohelper.setActive(slot0._imagetest, not slot4 and not slot6)
	gohelper.setActive(slot0._goinput, not slot4 and not slot6)
	gohelper.setActive(slot0._gocorrect, false)
	gohelper.setActive(slot0._goerror, false)

	if slot0:_getErrorTimes(slot0._actId, slot0._curLvl) < 3 then
		gohelper.setActive(slot0._btntips, false)
	else
		gohelper.setActive(slot0._btntips, true)
	end
end

function slot0._btnCorrectOnClick(slot0)
	slot0._flashAnim:Play("switch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
end

function slot0._btnErrorOnClick(slot0)
	gohelper.setActive(slot0._imagetest, true)
	gohelper.setActive(slot0._goinput, true)
	gohelper.setActive(slot0._goerror, false)

	if slot0:_getErrorTimes(slot0._actId, slot0._curLvl) >= 3 then
		gohelper.setActive(slot0._btntips, true)
	end
end

function slot0._btnFileOnClick(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.Act1_8WarmUpClickFile .. slot0.userId, 1)
	gohelper.setActive(slot0._gofile, false)
	gohelper.setActive(slot0._imagetest, true)
	gohelper.setActive(slot0._goinput, true)
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnClickFile)
end

function slot0._btnMaskOnClick(slot0)
	gohelper.setActive(slot0._gobubble, false)
	gohelper.setActive(slot0._btnbubblemask, false)
end

function slot0._btnConfirmOnClick(slot0)
	if string.lower(LuaUtil.full2HalfWidth(slot0._inputanswer:GetText())) == string.lower(slot0._episodeCfg.key) then
		slot0:_delErrorTimes()
		slot0:_showRight()
	else
		slot0:_upErrorTimes()
		slot0:_showError()
	end
end

function slot0._btnTipsOnClick(slot0)
	slot1 = slot0._gobubble.activeInHierarchy

	gohelper.setActive(slot0._gobubble, not slot1)
	gohelper.setActive(slot0._btnbubblemask, not slot1)
end

function slot0._btnBubbleOnClick(slot0)
	gohelper.setActive(slot0._gobubble, false)
	gohelper.setActive(slot0._btnbubblemask, false)
	slot0._inputanswer:SetText(slot0._episodeCfg.key)
end

function slot0._showRight(slot0)
	gohelper.setActive(slot0._gobubble, false)
	gohelper.setActive(slot0._btnbubblemask, false)
	gohelper.setActive(slot0._imagetest, false)
	gohelper.setActive(slot0._gocorrect, true)
	gohelper.setActive(slot0._goinput, false)
	Activity125Model.instance:setOldEpisode(slot0._actId, slot0._curLvl)
end

function slot0._showError(slot0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_wrong)
	gohelper.setActive(slot0._imagetest, false)
	gohelper.setActive(slot0._goinput, false)
	gohelper.setActive(slot0._goerror, true)
end

function slot0._upErrorTimes(slot0)
	PlayerPrefsHelper.setNumber(slot0._errorTimesKey, slot0:_getErrorTimes() + 1)
end

function slot0._getErrorTimes(slot0)
	return PlayerPrefsHelper.getNumber(slot0._errorTimesKey, 0)
end

function slot0._delErrorTimes(slot0)
	PlayerPrefsHelper.deleteKey(slot0._errorTimesKey)
end

function slot0._onSwitchEpisode(slot0)
	slot0._flashAnim:Play("switch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)
	slot0:_refreshUI()
end

return slot0

module("modules.logic.versionactivity1_8.warmup.view.Act1_8WarmUpLeftView", package.seeall)

local var_0_0 = class("Act1_8WarmUpLeftView", BaseView)
local var_0_1 = "v1a8_warmup_img_pic"
local var_0_2 = "v1a8_warmup_img_test"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#image_icon")
	arg_1_0._imagetest = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#image_test")
	arg_1_0._gocorrect = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_correct")
	arg_1_0._btncorrect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#go_correct/#btn_correct")
	arg_1_0._goerror = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_error")
	arg_1_0._btnerror = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#go_error/#btn_error")
	arg_1_0._gofile = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_file")
	arg_1_0._btnfile = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#go_file/#btn_file")
	arg_1_0._goinput = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_input")
	arg_1_0._btnbubblemask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#go_input/#btn_bubblemask")
	arg_1_0._inputanswer = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "Middle/#go_input/#input_answer")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#go_input/#btn_confirm")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#go_input/#btn_tips")
	arg_1_0._gobubble = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_input/#btn_tips/bubble")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "Middle/#go_input/#btn_tips/bubble/#txt_tips")
	arg_1_0._btnbubble = gohelper.findChildButtonWithAudio(arg_1_0._gobubble, "")
	arg_1_0._flashAnim = gohelper.findChild(arg_1_0.viewGO, "Middle/eff_badtv"):GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncorrect:AddClickListener(arg_2_0._btnCorrectOnClick, arg_2_0)
	arg_2_0._btnerror:AddClickListener(arg_2_0._btnErrorOnClick, arg_2_0)
	arg_2_0._btnfile:AddClickListener(arg_2_0._btnFileOnClick, arg_2_0)
	arg_2_0._btnbubblemask:AddClickListener(arg_2_0._btnMaskOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnConfirmOnClick, arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btnTipsOnClick, arg_2_0)
	arg_2_0._btnbubble:AddClickListener(arg_2_0._btnBubbleOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity125Controller.instance, Activity125Event.SwitchEpisode, arg_2_0._onSwitchEpisode, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncorrect:RemoveClickListener()
	arg_3_0._btnerror:RemoveClickListener()
	arg_3_0._btnfile:RemoveClickListener()
	arg_3_0._btnbubblemask:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btnbubble:RemoveClickListener()
	arg_3_0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity125Controller.instance, Activity125Event.SwitchEpisode, arg_3_0._onSwitchEpisode, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)

	arg_5_0.userId = PlayerModel.instance:getMyUserId()
	arg_5_0._actId = ActivityEnum.Activity.Activity1_8WarmUp

	if Activity125Model.instance:getById(arg_5_0._actId) then
		arg_5_0:_refreshUI()
	end
end

function var_0_0.onClose(arg_6_0)
	return
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

function var_0_0._refreshUI(arg_8_0)
	arg_8_0._curLvl = Activity125Model.instance:getSelectEpisodeId(arg_8_0._actId)
	arg_8_0._errorTimesKey = string.format("%s_%s_%s_%s", arg_8_0.userId, "1_8WarmUpErrorTime", arg_8_0._actId, arg_8_0._curLvl)
	arg_8_0._episodeCfg = Activity125Config.instance:getEpisodeConfig(arg_8_0._actId, arg_8_0._curLvl)

	UISpriteSetMgr.instance:setV1a8WarmUpSprite(arg_8_0._imageicon, var_0_1 .. arg_8_0._curLvl)
	UISpriteSetMgr.instance:setV1a8WarmUpSprite(arg_8_0._imagetest, var_0_2 .. arg_8_0._curLvl)

	arg_8_0._txttips.text = arg_8_0._episodeCfg.key

	arg_8_0._inputanswer:SetText("")
	arg_8_0:_refreshActiveStatus()
end

function var_0_0._refreshActiveStatus(arg_9_0)
	local var_9_0 = Activity125Model.instance:isEpisodeFinished(arg_9_0._actId, arg_9_0._curLvl)
	local var_9_1 = Activity125Model.instance:checkIsOldEpisode(arg_9_0._actId, arg_9_0._curLvl)
	local var_9_2 = Activity125Model.instance:checkLocalIsPlay(arg_9_0._actId, arg_9_0._curLvl)
	local var_9_3 = var_9_0 or var_9_2 or var_9_1
	local var_9_4 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.Act1_8WarmUpClickFile .. arg_9_0.userId, 0)
	local var_9_5 = arg_9_0._curLvl == 1 and var_9_4 == 0

	gohelper.setActive(arg_9_0._imageicon, var_9_3)
	gohelper.setActive(arg_9_0._gofile, not var_9_3 and var_9_5)
	gohelper.setActive(arg_9_0._imagetest, not var_9_3 and not var_9_5)
	gohelper.setActive(arg_9_0._goinput, not var_9_3 and not var_9_5)
	gohelper.setActive(arg_9_0._gocorrect, false)
	gohelper.setActive(arg_9_0._goerror, false)

	if arg_9_0:_getErrorTimes(arg_9_0._actId, arg_9_0._curLvl) < 3 then
		gohelper.setActive(arg_9_0._btntips, false)
	else
		gohelper.setActive(arg_9_0._btntips, true)
	end
end

function var_0_0._btnCorrectOnClick(arg_10_0)
	arg_10_0._flashAnim:Play("switch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)
	Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate)
end

function var_0_0._btnErrorOnClick(arg_11_0)
	gohelper.setActive(arg_11_0._imagetest, true)
	gohelper.setActive(arg_11_0._goinput, true)
	gohelper.setActive(arg_11_0._goerror, false)

	if arg_11_0:_getErrorTimes(arg_11_0._actId, arg_11_0._curLvl) >= 3 then
		gohelper.setActive(arg_11_0._btntips, true)
	end
end

function var_0_0._btnFileOnClick(arg_12_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.Act1_8WarmUpClickFile .. arg_12_0.userId, 1)
	gohelper.setActive(arg_12_0._gofile, false)
	gohelper.setActive(arg_12_0._imagetest, true)
	gohelper.setActive(arg_12_0._goinput, true)
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnClickFile)
end

function var_0_0._btnMaskOnClick(arg_13_0)
	gohelper.setActive(arg_13_0._gobubble, false)
	gohelper.setActive(arg_13_0._btnbubblemask, false)
end

function var_0_0._btnConfirmOnClick(arg_14_0)
	local var_14_0 = LuaUtil.full2HalfWidth(arg_14_0._inputanswer:GetText())
	local var_14_1 = string.lower(arg_14_0._episodeCfg.key)

	if string.lower(var_14_0) == var_14_1 then
		arg_14_0:_delErrorTimes()
		arg_14_0:_showRight()
	else
		arg_14_0:_upErrorTimes()
		arg_14_0:_showError()
	end
end

function var_0_0._btnTipsOnClick(arg_15_0)
	local var_15_0 = arg_15_0._gobubble.activeInHierarchy

	gohelper.setActive(arg_15_0._gobubble, not var_15_0)
	gohelper.setActive(arg_15_0._btnbubblemask, not var_15_0)
end

function var_0_0._btnBubbleOnClick(arg_16_0)
	gohelper.setActive(arg_16_0._gobubble, false)
	gohelper.setActive(arg_16_0._btnbubblemask, false)
	arg_16_0._inputanswer:SetText(arg_16_0._episodeCfg.key)
end

function var_0_0._showRight(arg_17_0)
	gohelper.setActive(arg_17_0._gobubble, false)
	gohelper.setActive(arg_17_0._btnbubblemask, false)
	gohelper.setActive(arg_17_0._imagetest, false)
	gohelper.setActive(arg_17_0._gocorrect, true)
	gohelper.setActive(arg_17_0._goinput, false)
	Activity125Model.instance:setOldEpisode(arg_17_0._actId, arg_17_0._curLvl)
end

function var_0_0._showError(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_wrong)
	gohelper.setActive(arg_18_0._imagetest, false)
	gohelper.setActive(arg_18_0._goinput, false)
	gohelper.setActive(arg_18_0._goerror, true)
end

function var_0_0._upErrorTimes(arg_19_0)
	local var_19_0 = arg_19_0:_getErrorTimes()

	PlayerPrefsHelper.setNumber(arg_19_0._errorTimesKey, var_19_0 + 1)
end

function var_0_0._getErrorTimes(arg_20_0)
	return PlayerPrefsHelper.getNumber(arg_20_0._errorTimesKey, 0)
end

function var_0_0._delErrorTimes(arg_21_0)
	PlayerPrefsHelper.deleteKey(arg_21_0._errorTimesKey)
end

function var_0_0._onSwitchEpisode(arg_22_0)
	arg_22_0._flashAnim:Play("switch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Warmup1_8.play_noise)
	arg_22_0:_refreshUI()
end

return var_0_0

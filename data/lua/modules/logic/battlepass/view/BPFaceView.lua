module("modules.logic.battlepass.view.BPFaceView", package.seeall)

local var_0_0 = class("BPFaceView", BaseView)
local var_0_1 = {
	Idle = 1,
	CardAnimIdle = 3,
	FinalIdle = 5,
	OpenCardAnim = 2,
	TweenAnim = 4
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/#simage_fullbg/icon/#btn_close")
	arg_1_0._btnCloseBg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/#btn_closeBg")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/#btn_start")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "main/desc/#simage_signature")
	arg_1_0._txtskinname = gohelper.findChildTextMesh(arg_1_0.viewGO, "main/desc/#txt_skinname")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "main/desc/#txt_skinname/#txt_name")
	arg_1_0._txtnameEn = gohelper.findChildTextMesh(arg_1_0.viewGO, "main/desc/#txt_skinname/#txt_name/#txt_enname")
	arg_1_0._btnClickCard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullclick")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.onBtnCloseClick, arg_2_0, BpEnum.ButtonName.Close)
	arg_2_0._btnCloseBg:AddClickListener(arg_2_0.onBtnCloseClick, arg_2_0, BpEnum.ButtonName.CloseBg)
	arg_2_0._btnStart:AddClickListener(arg_2_0._openBpView, arg_2_0)
	arg_2_0._btnClickCard:AddClickListener(arg_2_0._onClickCard, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnCloseBg:RemoveClickListener()
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0._btnClickCard:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onViewClose, arg_3_0)
end

function var_0_0._openBpView(arg_4_0)
	if not arg_4_0:canClickClose() then
		return
	end

	arg_4_0:statData(BpEnum.ButtonName.Goto)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_4_0._onViewClose, arg_4_0)
	BpController.instance:openBattlePassView(nil, nil, true)
end

function var_0_0.onClickModalMask(arg_5_0)
	if not arg_5_0:canClickClose() then
		return
	end

	arg_5_0:onBtnCloseClick(BpEnum.ButtonName.CloseBg)
end

function var_0_0._onClickCard(arg_6_0)
	if arg_6_0._statu == var_0_1.Idle then
		arg_6_0._statu = var_0_1.OpenCardAnim

		TaskDispatcher.runDelay(arg_6_0._delayPlayAudio, arg_6_0, 1.5)
		arg_6_0._anim:Play("tarot_click", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_6.BP.FaceView)
	elseif arg_6_0._statu == var_0_1.CardAnimIdle then
		arg_6_0._statu = var_0_1.TweenAnim

		arg_6_0._anim:Play("tarot_click1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
		TaskDispatcher.runDelay(arg_6_0._delayFinishAnim, arg_6_0, 1)
	end
end

function var_0_0.canClickClose(arg_7_0)
	return arg_7_0._statu == var_0_1.FinalIdle
end

function var_0_0._delayPlayAudio(arg_8_0)
	arg_8_0._statu = var_0_1.CardAnimIdle
end

function var_0_0._delayFinishAnim(arg_9_0)
	arg_9_0._statu = var_0_1.FinalIdle

	gohelper.setActive(arg_9_0._btnClickCard, false)
end

function var_0_0.onBtnCloseClick(arg_10_0, arg_10_1)
	if not arg_10_0:canClickClose() then
		return
	end

	arg_10_0:statData(arg_10_1)
	arg_10_0:closeThis()
end

function var_0_0._onViewClose(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.BpView then
		arg_11_0:closeThis()
	end
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._statu = var_0_1.Idle

	local var_12_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_12_0 then
		arg_12_0._txtskinname.text = var_12_0.bpSkinDesc
		arg_12_0._txtname.text = var_12_0.bpSkinNametxt
		arg_12_0._txtnameEn.text = var_12_0.bpSkinEnNametxt

		local var_12_1 = BpConfig.instance:getCurSkinId(BpModel.instance.id)
		local var_12_2 = lua_skin.configDict[var_12_1].characterId
		local var_12_3 = lua_character.configDict[var_12_2]

		arg_12_0._simagesignature:LoadImage(ResUrl.getSignature(var_12_3.signature))
	end

	local var_12_4 = string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, "BPFace", PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(var_12_4, tostring(BpModel.instance.id))
end

function var_0_0.statData(arg_13_0, arg_13_1)
	StatController.instance:track(StatEnum.EventName.BP_Click_Face_Slapping, {
		[StatEnum.EventProperties.BP_Button_Name] = arg_13_1
	})
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayFinishAnim, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayPlayAudio, arg_14_0)
end

return var_0_0

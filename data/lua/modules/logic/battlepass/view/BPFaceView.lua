module("modules.logic.battlepass.view.BPFaceView", package.seeall)

slot0 = class("BPFaceView", BaseView)
slot1 = {
	Idle = 1,
	CardAnimIdle = 3,
	FinalIdle = 5,
	OpenCardAnim = 2,
	TweenAnim = 4
}

function slot0.onInitView(slot0)
	slot0._anim = gohelper.findChildAnim(slot0.viewGO, "")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "main/#simage_fullbg/icon/#btn_close")
	slot0._btnCloseBg = gohelper.findChildButtonWithAudio(slot0.viewGO, "main/#btn_closeBg")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "main/#btn_start")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "main/desc/#simage_signature")
	slot0._txtskinname = gohelper.findChildTextMesh(slot0.viewGO, "main/desc/#txt_skinname")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "main/desc/#txt_skinname/#txt_name")
	slot0._txtnameEn = gohelper.findChildTextMesh(slot0.viewGO, "main/desc/#txt_skinname/#txt_name/#txt_enname")
	slot0._btnClickCard = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fullclick")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.onBtnCloseClick, slot0, BpEnum.ButtonName.Close)
	slot0._btnCloseBg:AddClickListener(slot0.onBtnCloseClick, slot0, BpEnum.ButtonName.CloseBg)
	slot0._btnStart:AddClickListener(slot0._openBpView, slot0)
	slot0._btnClickCard:AddClickListener(slot0._onClickCard, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnCloseBg:RemoveClickListener()
	slot0._btnStart:RemoveClickListener()
	slot0._btnClickCard:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
end

function slot0._openBpView(slot0)
	if not slot0:canClickClose() then
		return
	end

	slot0:statData(BpEnum.ButtonName.Goto)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
	BpController.instance:openBattlePassView(nil, , true)
end

function slot0.onClickModalMask(slot0)
	if not slot0:canClickClose() then
		return
	end

	slot0:onBtnCloseClick(BpEnum.ButtonName.CloseBg)
end

function slot0._onClickCard(slot0)
	if slot0._statu == uv0.Idle then
		slot0._statu = uv0.OpenCardAnim

		TaskDispatcher.runDelay(slot0._delayPlayAudio, slot0, 1.5)
		slot0._anim:Play("tarot_click", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_6.BP.FaceView)
	elseif slot0._statu == uv0.CardAnimIdle then
		slot0._statu = uv0.TweenAnim

		slot0._anim:Play("tarot_click1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
		TaskDispatcher.runDelay(slot0._delayFinishAnim, slot0, 1)
	end
end

function slot0.canClickClose(slot0)
	return slot0._statu == uv0.FinalIdle
end

function slot0._delayPlayAudio(slot0)
	slot0._statu = uv0.CardAnimIdle
end

function slot0._delayFinishAnim(slot0)
	slot0._statu = uv0.FinalIdle

	gohelper.setActive(slot0._btnClickCard, false)
end

function slot0.onBtnCloseClick(slot0, slot1)
	if not slot0:canClickClose() then
		return
	end

	slot0:statData(slot1)
	slot0:closeThis()
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == ViewName.BpView then
		slot0:closeThis()
	end
end

function slot0.onOpen(slot0)
	slot0._statu = uv0.Idle

	if BpConfig.instance:getBpCO(BpModel.instance.id) then
		slot0._txtskinname.text = slot1.bpSkinDesc
		slot0._txtname.text = slot1.bpSkinNametxt
		slot0._txtnameEn.text = slot1.bpSkinEnNametxt

		slot0._simagesignature:LoadImage(ResUrl.getSignature(lua_character.configDict[lua_skin.configDict[BpConfig.instance:getCurSkinId(BpModel.instance.id)].characterId].signature))
	end

	PlayerPrefsHelper.setString(string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, "BPFace", PlayerModel.instance:getPlayinfo().userId), tostring(BpModel.instance.id))
end

function slot0.statData(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.BP_Click_Face_Slapping, {
		[StatEnum.EventProperties.BP_Button_Name] = slot1
	})
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayFinishAnim, slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayAudio, slot0)
end

return slot0

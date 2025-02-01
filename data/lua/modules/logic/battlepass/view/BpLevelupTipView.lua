module("modules.logic.battlepass.view.BpLevelupTipView", package.seeall)

slot0 = class("BpLevelupTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._animationEvent = gohelper.findChild(slot0.viewGO, "root"):GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_bg")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "root/main/icon/#txt_lv")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.onCloseClick, slot0)
	slot0._animationEvent:AddEventListener("levelup", slot0.onLevelUp, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._animationEvent:RemoveEventListener("levelup")
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getBpBg("full/img_shengji_bg"))

	slot0._txtlv.text = math.floor((BpModel.instance.preStatus and BpModel.instance.preStatus.score or BpModel.instance.score) / BpConfig.instance:getLevelScore(BpModel.instance.id))
	slot0._openTime = ServerTime.now()

	TaskDispatcher.runDelay(slot0.onCloseClick, slot0, BpEnum.LevelUpTotalTime)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_decibel_upgrade)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onLevelUp(slot0)
	slot0._txtlv.text = math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id))

	if not BpModel.instance.preStatus then
		return
	end

	StatController.instance:track(StatEnum.EventName.BPUp, {
		[StatEnum.EventProperties.BP_Type] = StatEnum.BpType[BpModel.instance.payStatus],
		[StatEnum.EventProperties.BeforeLevel] = math.floor(BpModel.instance.preStatus.score / slot1),
		[StatEnum.EventProperties.AfterLevel] = slot2,
		[StatEnum.EventProperties.BP_ID] = tostring(BpModel.instance.id)
	})
end

function slot0.onCloseClick(slot0)
	if not slot0._openTime or ServerTime.now() - slot0._openTime < BpEnum.LevelUpMinTime then
		return
	end

	slot0:closeThis()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	if not BpModel.instance:isInFlow() then
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end

	TaskDispatcher.cancelTask(slot0.onCloseClick, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0

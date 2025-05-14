module("modules.logic.battlepass.view.BpLevelupTipView", package.seeall)

local var_0_0 = class("BpLevelupTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._animationEvent = gohelper.findChild(arg_1_0.viewGO, "root"):GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_bg")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "root/main/icon/#txt_lv")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.onCloseClick, arg_2_0)
	arg_2_0._animationEvent:AddEventListener("levelup", arg_2_0.onLevelUp, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._animationEvent:RemoveEventListener("levelup")
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getBpBg("full/img_shengji_bg"))

	local var_4_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_4_1 = BpModel.instance.preStatus and BpModel.instance.preStatus.score or BpModel.instance.score

	arg_4_0._txtlv.text = math.floor(var_4_1 / var_4_0)
	arg_4_0._openTime = ServerTime.now()

	TaskDispatcher.runDelay(arg_4_0.onCloseClick, arg_4_0, BpEnum.LevelUpTotalTime)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_decibel_upgrade)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onLevelUp(arg_6_0)
	local var_6_0 = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local var_6_1 = math.floor(BpModel.instance.score / var_6_0)

	arg_6_0._txtlv.text = var_6_1

	if not BpModel.instance.preStatus then
		return
	end

	StatController.instance:track(StatEnum.EventName.BPUp, {
		[StatEnum.EventProperties.BP_Type] = StatEnum.BpType[BpModel.instance.payStatus],
		[StatEnum.EventProperties.BeforeLevel] = math.floor(BpModel.instance.preStatus.score / var_6_0),
		[StatEnum.EventProperties.AfterLevel] = var_6_1,
		[StatEnum.EventProperties.BP_ID] = tostring(BpModel.instance.id)
	})
end

function var_0_0.onCloseClick(arg_7_0)
	if not arg_7_0._openTime or ServerTime.now() - arg_7_0._openTime < BpEnum.LevelUpMinTime then
		return
	end

	arg_7_0:closeThis()
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	if not BpModel.instance:isInFlow() then
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end

	TaskDispatcher.cancelTask(arg_9_0.onCloseClick, arg_9_0)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebg:UnLoadImage()
end

return var_0_0

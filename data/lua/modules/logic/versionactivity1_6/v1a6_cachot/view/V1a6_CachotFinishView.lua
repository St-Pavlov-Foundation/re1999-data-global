module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotFinishView", package.seeall)

local var_0_0 = class("V1a6_CachotFinishView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._txtsuccesstips = gohelper.findChildText(arg_1_0.viewGO, "success/#txt_successtips")
	arg_1_0._txtfailedtips = gohelper.findChildText(arg_1_0.viewGO, "failed/#txt_failedtips")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofailed = gohelper.findChild(arg_1_0.viewGO, "#go_failed")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
end

function var_0_0._btnjumpOnClick(arg_4_0)
	if arg_4_0._isFinish then
		local var_4_0 = arg_4_0._rogueEndingInfo and arg_4_0._rogueEndingInfo._ending

		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnFinishGame, var_4_0)
	else
		arg_4_0:_jump2ResultView()
	end

	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotFinishView, arg_7_0._btnjumpOnClick, arg_7_0)
	RogueRpc.instance:sendRogueReadEndingRequest(V1a6_CachotEnum.ActivityId)

	arg_7_0._rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()
	arg_7_0._isFinish = false

	if arg_7_0._rogueEndingInfo then
		arg_7_0._isFinish = arg_7_0._rogueEndingInfo._isFinish

		arg_7_0._rogueEndingInfo:onEnterEndingFlow()
	end

	arg_7_0:refreshUI()
	arg_7_0:playAudioEffect()
end

function var_0_0.refreshUI(arg_8_0)
	gohelper.setActive(arg_8_0._gosuccess, arg_8_0._isFinish)
	gohelper.setActive(arg_8_0._gofailed, not arg_8_0._isFinish)
end

function var_0_0._jump2ResultView(arg_9_0)
	V1a6_CachotController.instance:openV1a6_CachotResultView()
end

function var_0_0.playAudioEffect(arg_10_0)
	if arg_10_0._isFinish then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_victory_open)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_fail_open)
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._rogueEndingInfo = nil
end

return var_0_0

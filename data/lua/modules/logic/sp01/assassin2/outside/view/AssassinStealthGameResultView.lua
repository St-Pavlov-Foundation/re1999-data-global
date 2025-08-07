module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameResultView", package.seeall)

local var_0_0 = class("AssassinStealthGameResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#simage_FullBG", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gosucceed = gohelper.findChild(arg_1_0.viewGO, "root/#go_succeed")
	arg_1_0._gofailed = gohelper.findChild(arg_1_0.viewGO, "root/#go_failed")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._onClick(arg_4_0)
	if AssassinStealthGameModel.instance:getGameState() == AssassinEnum.GameState.Win then
		AssassinStealthGameController.instance:exitGame()
		arg_4_0:closeThis()
	else
		AssassinStealthGameController.instance:recoverAssassinStealthGame()
		arg_4_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = AssassinStealthGameModel.instance:getGameState() == AssassinEnum.GameState.Win

	gohelper.setActive(arg_5_0._gosucceed, var_5_0)
	gohelper.setActive(arg_5_0._gofailed, not var_5_0)

	if var_5_0 then
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_syncsucceed)
	end

	local var_5_1 = var_5_0 and StatEnum.Result2Cn[StatEnum.Result.Success] or StatEnum.Result2Cn[StatEnum.Result.Fail]

	AssassinStealthGameController.instance:sendSettleTrack(var_5_1, not var_5_0)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0

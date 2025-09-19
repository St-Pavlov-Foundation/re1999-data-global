module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessResultView", package.seeall)

local var_0_0 = class("AutoChessResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtHp = gohelper.findChildText(arg_1_0.viewGO, "Hp/#txt_Hp")
	arg_1_0._txtDamage = gohelper.findChildText(arg_1_0.viewGO, "Damage/#txt_Damage")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0._editableInitView(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = AudioMgr.instance:getIdFromString("autochess")
	local var_4_1 = AudioMgr.instance:getIdFromString("prepare")

	AudioMgr.instance:setSwitch(var_4_0, var_4_1)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)

	local var_4_2 = AutoChessModel.instance.resultData

	if var_4_2 then
		arg_4_0._txtHp.text = var_4_2.remainingHp
		arg_4_0._txtDamage.text = var_4_2.injury

		AutoChessController.instance:statFightEnd(tonumber(var_4_2.remainingHp))
	end
end

function var_0_0.onClose(arg_5_0)
	AutoChessController.instance:onResultViewClose()
end

return var_0_0

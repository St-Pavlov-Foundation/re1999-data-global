module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessCrazySettleView", package.seeall)

local var_0_0 = class("AutoChessCrazySettleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "Round/image/#txt_Round")
	arg_1_0._txtHp = gohelper.findChildText(arg_1_0.viewGO, "Hp/#txt_Hp")
	arg_1_0._txtDamage = gohelper.findChildText(arg_1_0.viewGO, "Damage/#txt_Damage")
	arg_1_0._goWin = gohelper.findChild(arg_1_0.viewGO, "#go_Win")
	arg_1_0._goLose = gohelper.findChild(arg_1_0.viewGO, "#go_Lose")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0.settleData = AutoChessModel.instance.settleData

	if arg_3_0.settleData then
		arg_3_0._txtRound.text = arg_3_0.settleData.round
		arg_3_0._txtHp.text = arg_3_0.settleData.remainingHp
		arg_3_0._txtDamage.text = arg_3_0.settleData.totalInjury

		local var_3_0 = AutoChessConfig.instance:getEpisodeCO(arg_3_0.settleData.episodeId)
		local var_3_1 = var_3_0 and var_3_0.maxRound or 0

		gohelper.setActive(arg_3_0._goWin, arg_3_0.settleData.round == var_3_1)
		gohelper.setActive(arg_3_0._goLose, arg_3_0.settleData.round ~= var_3_1)
	end
end

function var_0_0.onClose(arg_4_0)
	AutoChessController.instance:onSettleViewClose()
end

return var_0_0

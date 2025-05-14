module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessResultView", package.seeall)

local var_0_0 = class("AutoChessResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtHp = gohelper.findChildText(arg_1_0.viewGO, "Hp/#txt_Hp")
	arg_1_0._txtDamage = gohelper.findChildText(arg_1_0.viewGO, "Damage/#txt_Damage")
	arg_1_0._txtTarDesc1 = gohelper.findChildText(arg_1_0.viewGO, "Target/Target1/#txt_TarDesc1")
	arg_1_0._goTarStar1 = gohelper.findChild(arg_1_0.viewGO, "Target/Target1/start/#go_TarStar1")
	arg_1_0._txtTarDesc2 = gohelper.findChildText(arg_1_0.viewGO, "Target/Target2/#txt_TarDesc2")
	arg_1_0._goTarStar2 = gohelper.findChild(arg_1_0.viewGO, "Target/Target2/start/#go_TarStar2")
	arg_1_0._txtTarDesc3 = gohelper.findChildText(arg_1_0.viewGO, "Target/Target3/#txt_TarDesc3")
	arg_1_0._goTarStar3 = gohelper.findChild(arg_1_0.viewGO, "Target/Target3/start/#go_TarStar3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = AudioMgr.instance:getIdFromString("autochess")
	local var_7_1 = AudioMgr.instance:getIdFromString("prepare")

	AudioMgr.instance:setSwitch(var_7_0, var_7_1)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)

	local var_7_2 = AutoChessModel.instance.resultData

	if var_7_2 then
		local var_7_3 = AutoChessModel.instance:getChessMo()
		local var_7_4 = Activity182Model.instance:getCurActId()
		local var_7_5 = var_7_3.sceneRound

		arg_7_0._txtHp.text = var_7_2.remainingHp
		arg_7_0._txtDamage.text = var_7_2.injury

		local var_7_6 = lua_auto_chess_round.configDict[var_7_4][var_7_5]

		if var_7_6 then
			local var_7_7 = var_7_6.assess
			local var_7_8 = string.split(var_7_7, "#")
			local var_7_9 = luaLang("autochess_resultview_damage")

			for iter_7_0 = 1, 3 do
				arg_7_0["_txtTarDesc" .. iter_7_0].text = GameUtil.getSubPlaceholderLuaLangOneParam(var_7_9, var_7_8[iter_7_0])

				gohelper.setActive(arg_7_0["_goTarStar" .. iter_7_0], iter_7_0 <= var_7_2.star)
			end
		else
			logError(string.format("异常:不存在轮数配置actId:%sround:%s", var_7_4, var_7_5))
		end

		AutoChessController.instance:statFightEnd(tonumber(var_7_2.remainingHp))
	end
end

function var_0_0.onClose(arg_8_0)
	AutoChessController.instance:onResultViewClose()
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0

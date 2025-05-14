module("modules.logic.player.view.PlayerIdView", package.seeall)

local var_0_0 = class("PlayerIdView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "node/#txt_desc")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:addEventCb(PlayerController.instance, PlayerEvent.ShowPlayerId, arg_2_0._showId, arg_2_0)
	arg_2_0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_2_0._updateText, arg_2_0)
	arg_2_0:_updateText()
end

function var_0_0.onUpdateParam(arg_3_0)
	arg_3_0:_updateText()
end

function var_0_0._updateText(arg_4_0)
	arg_4_0._txtDesc.text = luaLang("ID_desc") .. " ID: " .. arg_4_0.viewParam.userId
end

function var_0_0.onClose(arg_5_0)
	arg_5_0:removeEventCb(PlayerController.instance, PlayerEvent.ShowPlayerId, arg_5_0._showId, arg_5_0)
	arg_5_0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_5_0._updateText, arg_5_0)
end

function var_0_0._showId(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.viewGO, arg_6_1)
end

return var_0_0

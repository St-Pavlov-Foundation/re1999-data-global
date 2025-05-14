module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallLevelUpView", package.seeall)

local var_0_0 = class("AutoChessMallLevelUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageLevel1 = gohelper.findChildImage(arg_1_0.viewGO, "icon/#image_Level1")
	arg_1_0._txtMallLv1 = gohelper.findChildText(arg_1_0.viewGO, "icon/#image_Level1/#txt_MallLv1")
	arg_1_0._imageLevel2 = gohelper.findChildImage(arg_1_0.viewGO, "icon/#image_Level2")
	arg_1_0._txtMallLv2 = gohelper.findChildText(arg_1_0.viewGO, "icon/#image_Level2/#txt_MallLv2")

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

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_store_upgrade)

	local var_5_0 = AutoChessModel.instance:getChessMo()
	local var_5_1 = AutoChessHelper.getMallRegionByType(var_5_0.svrMall.regions, AutoChessEnum.MallType.Normal)
	local var_5_2 = lua_auto_chess_mall.configDict[var_5_1.mallId].showLevel
	local var_5_3 = var_5_2 - 1

	UISpriteSetMgr.instance:setAutoChessSprite(arg_5_0._imageLevel1, "v2a5_autochess_quality3_" .. var_5_3)
	UISpriteSetMgr.instance:setAutoChessSprite(arg_5_0._imageLevel2, "v2a5_autochess_quality3_" .. var_5_2)

	local var_5_4 = luaLang("autochess_malllevelupview_level")

	arg_5_0._txtMallLv1.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_5_4, var_5_3)
	arg_5_0._txtMallLv2.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_5_4, var_5_2)

	TaskDispatcher.runDelay(arg_5_0.onClickModalMask, arg_5_0, 2)
end

return var_0_0

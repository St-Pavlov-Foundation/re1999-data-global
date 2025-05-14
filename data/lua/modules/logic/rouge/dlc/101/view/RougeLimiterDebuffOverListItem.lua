module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffOverListItem", package.seeall)

local var_0_0 = class("RougeLimiterDebuffOverListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagedebufficon = gohelper.findChildImage(arg_1_0.viewGO, "#image_debufficon")
	arg_1_0._txtbufflevel = gohelper.findChildText(arg_1_0.viewGO, "#txt_bufflevel")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#txt_dec")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._config = arg_4_1
	arg_4_0._txtbufflevel.text = GameUtil.getRomanNums(arg_4_0._config.level)
	arg_4_0._txtname.text = arg_4_0._config and arg_4_0._config.title
	arg_4_0._txtdec.text = arg_4_0._config and arg_4_0._config.desc

	local var_4_0 = RougeDLCConfig101.instance:getLimiterGroupCo(arg_4_0._config.group)
	local var_4_1 = var_4_0 and var_4_0.icon

	UISpriteSetMgr.instance:setRouge4Sprite(arg_4_0._imagedebufficon, var_4_1)
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

return var_0_0

module("modules.logic.survival.view.shop.SurvivalShopTab", package.seeall)

local var_0_0 = class("SurvivalShopTab", SurvivalSimpleListItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_1)
	arg_1_0.image_icon = gohelper.findChildImage(arg_1_1, "#image_icon")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClick, arg_2_0)
end

function var_0_0.onItemShow(arg_3_0, arg_3_1)
	arg_3_0.cfg = arg_3_1.cfg
	arg_3_0.tabId = arg_3_0.cfg.id
	arg_3_0.onClickFunc = arg_3_1.onClickFunc
	arg_3_0.context = arg_3_1.context

	UISpriteSetMgr.instance:setSurvivalSprite(arg_3_0.image_icon, arg_3_0.cfg.tabIcon)
end

function var_0_0.onSelectChange(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.image_icon.color

	if arg_4_1 then
		arg_4_0.image_icon.color = Color.New(var_4_0.r, var_4_0.g, var_4_0.b, 1)
	else
		arg_4_0.image_icon.color = Color.New(var_4_0.r, var_4_0.g, var_4_0.b, 0.4)
	end
end

function var_0_0.onClick(arg_5_0)
	if arg_5_0.onClickFunc then
		arg_5_0.onClickFunc(arg_5_0.context, arg_5_0)
	end
end

return var_0_0

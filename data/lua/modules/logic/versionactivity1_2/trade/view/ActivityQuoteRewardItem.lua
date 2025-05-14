module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteRewardItem", package.seeall)

local var_0_0 = class("ActivityQuoteRewardItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.imageIcon = gohelper.findChildSingleImage(arg_1_0.go, "simage_icon")
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_0.go, "image_rarebg")
	arg_1_0.textCount = gohelper.findChildText(arg_1_0.go, "txt_count")
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_1

	if not arg_2_1 then
		gohelper.setActive(arg_2_0.go, false)

		return
	end

	gohelper.setActive(arg_2_0.go, true)

	if arg_2_1.progress >= arg_2_1.maxProgress then
		arg_2_0.textCount.text = string.format("%s/%s", arg_2_1.progress, arg_2_1.maxProgress)
	else
		arg_2_0.textCount.text = string.format("<color=#ff8949>%s</color>/%s", arg_2_1.progress, arg_2_1.maxProgress)
	end

	local var_2_0, var_2_1 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, tonumber(arg_2_1.listenerParam))
	local var_2_2 = var_2_0.rare and var_2_0.rare or 5

	UISpriteSetMgr.instance:setVersionActivityTrade_1_2Sprite(arg_2_0.imageRare, "bg_wupindi_" .. tostring(var_2_2))
	arg_2_0.imageIcon:LoadImage(var_2_1)
end

function var_0_0.destory(arg_3_0)
	arg_3_0.imageIcon:UnLoadImage()
	arg_3_0:__onDispose()
end

return var_0_0

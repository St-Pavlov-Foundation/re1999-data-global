module("modules.logic.main.view.MainThumbnailBannerContent", package.seeall)

local var_0_0 = class("MainThumbnailBannerContent", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1.go
	arg_1_0._config = arg_1_1.config
	arg_1_0._index = arg_1_1.index

	transformhelper.setLocalPos(arg_1_0._go.transform, arg_1_1.pos, 0, 0)
end

function var_0_0.loadBanner(arg_2_0)
	if arg_2_0._isLoadedBanner then
		return
	end

	arg_2_0._isLoadedBanner = true
	arg_2_0._simagebanner = gohelper.findChildSingleImage(arg_2_0._go, "#simage_banner")
	arg_2_0._txtdesc = gohelper.findChildText(arg_2_0._go, "#txt_des")

	arg_2_0._simagebanner:LoadImage(ResUrl.getAdventureTaskLangPath(arg_2_0._config.res))

	arg_2_0._txtdesc.text = arg_2_0._config.des
end

function var_0_0.updateItem(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	if arg_3_0._index == arg_3_1 or arg_3_0._index - arg_3_1 == 1 then
		arg_3_0:loadBanner()
	end
end

function var_0_0.destroy(arg_4_0)
	if arg_4_0._simagebanner then
		arg_4_0._simagebanner:UnLoadImage()
	end
end

return var_0_0

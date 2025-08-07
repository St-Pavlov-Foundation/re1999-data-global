module("modules.logic.sp01.library.AssassinLibraryListInfoItem", package.seeall)

local var_0_0 = class("AssassinLibraryListInfoItem", AssassinLibraryBaseInfoItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.go, "txt_index")
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.go, "image_BG")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	var_0_0.super.onUpdateMO(arg_2_0, arg_2_1)

	arg_2_0._txtindex.text = string.format("%2d", arg_2_0._index)

	arg_2_0:setLibraryBg(arg_2_0._imagebg)
end

return var_0_0

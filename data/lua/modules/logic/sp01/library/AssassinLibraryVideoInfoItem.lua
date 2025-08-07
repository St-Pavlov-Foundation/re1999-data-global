module("modules.logic.sp01.library.AssassinLibraryVideoInfoItem", package.seeall)

local var_0_0 = class("AssassinLibraryVideoInfoItem", AssassinLibraryBaseInfoItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.go, "txt_index")
	arg_1_0._gostairs1 = gohelper.findChild(arg_1_0.go, "#go_Stairs1")
	arg_1_0._gostairs2 = gohelper.findChild(arg_1_0.go, "#go_Stairs2")
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_0.go, "image_BG")
	arg_1_0._goplay = gohelper.findChild(arg_1_0.go, "image_Play")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.go, "go_unlocked/image_TitleBG/txt_name")
end

function var_0_0.updateIndex(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._allVideoCount = arg_2_1
	arg_2_0._index = arg_2_2
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	var_0_0.super.onUpdateMO(arg_3_0, arg_3_1)

	arg_3_0._txtindex.text = string.format("%2d", arg_3_0._index)

	gohelper.setActive(arg_3_0._gostairs1, arg_3_0._index > 1)
	gohelper.setActive(arg_3_0._gostairs2, arg_3_0._index < arg_3_0._allVideoCount)
	arg_3_0:setLibraryBg(arg_3_0._imagebg)
end

function var_0_0.refreshUI(arg_4_0)
	var_0_0.super.refreshUI(arg_4_0)
	gohelper.setActive(arg_4_0._goplay, arg_4_0._status ~= AssassinEnum.LibraryStatus.Locked)
end

return var_0_0

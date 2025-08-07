module("modules.logic.sp01.library.AssassinLibraryHeroInfoItem", package.seeall)

local var_0_0 = class("AssassinLibraryHeroInfoItem", AssassinLibraryBaseInfoItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.go, "go_unlocked/simage_icon")
	arg_1_0._infoAnimator = gohelper.onceAddComponent(arg_1_0._gounlocked, gohelper.Type_Animator)
end

function var_0_0.initRoot(arg_2_0, arg_2_1)
	arg_2_0._goroot = arg_2_1
	arg_2_0._gounlocked2 = gohelper.findChild(arg_2_0._goroot, "go_unlocked")
	arg_2_0._imagebg = gohelper.findChildImage(arg_2_0._goroot, "image_EmptyBG")

	gohelper.addChild(arg_2_1, arg_2_0.go)
end

function var_0_0.initBody(arg_3_0, arg_3_1)
	arg_3_0._gobody = arg_3_1
	arg_3_0._gounlocked3 = gohelper.findChild(arg_3_1, "go_unlocked")
	arg_3_0._bodyAnimator = gohelper.onceAddComponent(arg_3_0._gounlocked3, gohelper.Type_Animator)
end

function var_0_0.refreshUI(arg_4_0)
	var_0_0.super.refreshUI(arg_4_0)
	gohelper.setActive(arg_4_0._gounlocked2, arg_4_0._status ~= AssassinEnum.LibraryStatus.Locked)
	gohelper.setActive(arg_4_0._gounlocked3, arg_4_0._status ~= AssassinEnum.LibraryStatus.Locked)
	arg_4_0:setLibraryBg(arg_4_0._imagebg)
end

function var_0_0.setIsUsing(arg_5_0, arg_5_1)
	var_0_0.super.setIsUsing(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._gobody, arg_5_1)
	gohelper.setActive(arg_5_0._gounlocked2, arg_5_1)
end

function var_0_0.playUnlockAnim(arg_6_0)
	arg_6_0._infoAnimator:Play("unlock", 0, 0)
	arg_6_0._bodyAnimator:Play("unlock", 0, 0)
end

return var_0_0

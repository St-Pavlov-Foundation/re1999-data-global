module("modules.logic.sp01.library.AssassinLibraryBaseInfoItem", package.seeall)

local var_0_0 = class("AssassinLibraryBaseInfoItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gounlocked = gohelper.findChild(arg_1_0.go, "go_unlocked")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.go, "go_unlocked/go_reddot")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.go, "go_locked")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_click")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.go, "go_unlocked/txt_name")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.go, "go_unlocked/Mask/simage_icon")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateLibraryReddot, arg_2_0.tryRefreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._status == AssassinEnum.LibraryStatus.Locked then
		return
	end

	AssassinController.instance:openAssassinLibraryDetailView(arg_4_0._libraryId)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0:setIsUsing(true)

	arg_5_0._libraryCo = arg_5_1
	arg_5_0._libraryId = arg_5_1 and arg_5_1.id

	arg_5_0:tryRefreshUI()
end

function var_0_0.tryRefreshUI(arg_6_0)
	if not arg_6_0._isUsing then
		return
	end

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0._status = AssassinLibraryModel.instance:getLibraryStatus(arg_7_0._libraryId)
	arg_7_0._txtname.text = arg_7_0._libraryCo.title

	AssassinHelper.setLibraryIcon(arg_7_0._libraryId, arg_7_0._simageicon)
	gohelper.setActive(arg_7_0._golocked, arg_7_0._status == AssassinEnum.LibraryStatus.Locked)
	gohelper.setActive(arg_7_0._gounlocked, arg_7_0._status ~= AssassinEnum.LibraryStatus.Locked)
	arg_7_0:refreshRedDot()

	if AssassinLibraryModel.instance:isLibraryNeedPlayUnlockAnim(arg_7_0._libraryId) then
		arg_7_0:playUnlockAnim()
		AssassinLibraryModel.instance:markLibraryHasPlayUnlockAnim(arg_7_0._libraryId)
	end
end

function var_0_0.refreshRedDot(arg_8_0)
	if not arg_8_0._isUsing then
		return
	end

	arg_8_0._redDot = RedDotController.instance:addNotEventRedDot(arg_8_0._goreddot, arg_8_0._reddotCheckFunc, arg_8_0, AssassinEnum.LibraryReddotStyle)

	arg_8_0._redDot:refreshRedDot()
end

function var_0_0._reddotCheckFunc(arg_9_0)
	return arg_9_0._status == AssassinEnum.LibraryStatus.New
end

function var_0_0.playUnlockAnim(arg_10_0)
	return
end

function var_0_0.setIsUsing(arg_11_0, arg_11_1)
	arg_11_0._isUsing = arg_11_1

	gohelper.setActive(arg_11_0.go, arg_11_1)
end

function var_0_0.setLibraryBg(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._libraryCo.activityId
	local var_12_1 = arg_12_0._libraryCo.type
	local var_12_2 = AssassinHelper.multipleKeys2OneKey(var_12_0, var_12_1)
	local var_12_3 = var_12_2 and AssassinEnum.ActId2LibraryInfoBgName[var_12_2]

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_12_1, var_12_3)
end

return var_0_0

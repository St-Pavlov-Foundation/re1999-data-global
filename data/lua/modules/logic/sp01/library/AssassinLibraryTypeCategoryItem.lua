module("modules.logic.sp01.library.AssassinLibraryTypeCategoryItem", package.seeall)

local var_0_0 = class("AssassinLibraryTypeCategoryItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "go_select")
	arg_1_0._gounselect = gohelper.findChild(arg_1_1, "go_unselect")
	arg_1_0._imageicon1 = gohelper.findChildImage(arg_1_1, "go_select/image_Icon")
	arg_1_0._imageicon2 = gohelper.findChildImage(arg_1_1, "go_unselect/image_Icon")
	arg_1_0._txttitle1 = gohelper.findChildText(arg_1_1, "go_select/txt_title")
	arg_1_0._txttitle2 = gohelper.findChildText(arg_1_1, "go_unselect/txt_title")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "btn_click")
	arg_1_0._goreddot1 = gohelper.findChild(arg_1_1, "go_select/go_reddot")
	arg_1_0._goreddot2 = gohelper.findChild(arg_1_1, "go_unselect/go_reddot")
	arg_1_0._layoutElement = gohelper.onceAddComponent(arg_1_1, typeof(UnityEngine.UI.LayoutElement))
	arg_1_0._preferredHeight = arg_1_0._layoutElement.preferredHeight
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_glassclick)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnSelectLibLibType, arg_4_0._actId, arg_4_0._libType)
end

function var_0_0.setLibType(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._actId = arg_5_1
	arg_5_0._libType = arg_5_2

	arg_5_0:refreshUI()
end

function var_0_0.getLibType(arg_6_0)
	return arg_6_0._libType
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = AssassinHelper.multipleKeys2OneKey(arg_7_0._actId, arg_7_0._libType)
	local var_7_1 = AssassinEnum.LibraryType2LangId[var_7_0]
	local var_7_2 = ""

	if var_7_1 then
		var_7_2 = luaLang(var_7_1)
	else
		logError(string.format("缺少资料库页签多语言id actId = %s, libType = %s, langIdKey = %s", arg_7_0._actId, arg_7_0._libType, var_7_0))
	end

	arg_7_0._txttitle1.text = var_7_2
	arg_7_0._txttitle2.text = var_7_2

	local var_7_3 = AssassinHelper.multipleKeys2OneKey(arg_7_0._actId, arg_7_0._libType)
	local var_7_4 = var_7_3 and AssassinEnum.ActId2LibraryCategoryIconName[var_7_3]

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_7_0._imageicon1, var_7_4)
	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_7_0._imageicon2, var_7_4)
	arg_7_0:setSelectUI(false)
	gohelper.setActive(arg_7_0.go, true)
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	arg_8_0:setSelectUI(arg_8_1)
end

function var_0_0.setSelectUI(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselect, arg_9_1)
	gohelper.setActive(arg_9_0._gounselect, not arg_9_1)
end

function var_0_0.refreshRedDot(arg_10_0, arg_10_1)
	arg_10_0._isShowRedDot = arg_10_1

	gohelper.setActive(arg_10_0._goreddot1, arg_10_0._isShowRedDot)
	gohelper.setActive(arg_10_0._goreddot2, arg_10_0._isShowRedDot)
end

function var_0_0._redDotCheckFunc(arg_11_0)
	return arg_11_0._isShowRedDot
end

function var_0_0.buildFoldTweenWork(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._layoutElement.preferredHeight
	local var_12_1 = arg_12_1 and arg_12_0._preferredHeight or 0
	local var_12_2 = AssassinEnum.LibrarySubItemTweenDuration
	local var_12_3 = {
		type = "DOTweenFloat",
		from = var_12_0,
		to = var_12_1,
		t = var_12_2,
		frameCb = arg_12_0._tweenFrameCallBack,
		cbObj = arg_12_0
	}

	return (TweenWork.New(var_12_3))
end

function var_0_0._tweenFrameCallBack(arg_13_0, arg_13_1)
	arg_13_0._layoutElement.preferredHeight = arg_13_1
end

function var_0_0.tryClickSelf(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_14_0._btnclick.transform, arg_14_1, arg_14_2)

	if var_14_0 then
		arg_14_0:_btnclickOnClick()
	end

	return var_14_0
end

function var_0_0.onDestroy(arg_15_0)
	return
end

return var_0_0

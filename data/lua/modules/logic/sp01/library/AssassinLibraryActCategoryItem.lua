module("modules.logic.sp01.library.AssassinLibraryActCategoryItem", package.seeall)

local var_0_0 = class("AssassinLibraryActCategoryItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gotop = gohelper.findChild(arg_1_1, "go_top")
	arg_1_0._gotopselect = gohelper.findChild(arg_1_1, "go_top/go_select")
	arg_1_0._gotopunselect = gohelper.findChild(arg_1_1, "go_top/go_unselect")
	arg_1_0._txttitle1 = gohelper.findChildText(arg_1_1, "go_top/go_select/txt_title")
	arg_1_0._txttitle2 = gohelper.findChildText(arg_1_1, "go_top/go_unselect/txt_title")
	arg_1_0._goreddot1 = gohelper.findChild(arg_1_1, "go_top/go_select/go_reddot")
	arg_1_0._goreddot2 = gohelper.findChild(arg_1_1, "go_top/go_unselect/go_reddot")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_1, "go_top/btn_click")
	arg_1_0._goselectarrow_in = gohelper.findChild(arg_1_1, "go_top/go_select/image_Arrow_in")
	arg_1_0._goselectarrow_out = gohelper.findChild(arg_1_1, "go_top/go_select/image_Arrow_out")
	arg_1_0._gounselectarrow_in = gohelper.findChild(arg_1_1, "go_top/go_unselect/image_Arrow_in")
	arg_1_0._gounselectarrow_out = gohelper.findChild(arg_1_1, "go_top/go_unselect/image_Arrow_out")
	arg_1_0._gosubs = gohelper.findChild(arg_1_1, "go_subs")
	arg_1_0._gosubitem = gohelper.findChild(arg_1_1, "go_subs/go_subitem")

	gohelper.setActive(arg_1_0._gosubitem, false)

	arg_1_0._libTypeItemList = {}

	arg_1_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_1_0._onRefreshActivityState, arg_1_0)
	arg_1_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateLibraryReddot, arg_1_0.refreshRedDot, arg_1_0)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	arg_4_0:setFold(not arg_4_0._isFoldOut, true)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_glassclick)
end

function var_0_0.setActId(arg_5_0, arg_5_1)
	arg_5_0._actId = arg_5_1
	arg_5_0._libTypes = AssassinConfig.instance:getActLibraryTypeList(arg_5_1)
	arg_5_0._isFoldOut = false

	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = ActivityHelper.getActivityStatus(arg_6_0._actId)

	arg_6_0._isVisible = var_6_0 ~= ActivityEnum.ActivityStatus.NotOpen and var_6_0 ~= ActivityEnum.ActivityStatus.None

	gohelper.setActive(arg_6_0.go, arg_6_0._isVisible)

	if not arg_6_0._isVisible then
		return
	end

	local var_6_1 = AssassinHelper.getLibraryTopTitleByActId(arg_6_0._actId)

	arg_6_0._txttitle1.text = var_6_1
	arg_6_0._txttitle2.text = var_6_1

	arg_6_0:refreshLibTypeList()
	arg_6_0:refreshRedDot()
	arg_6_0:refreshSelectUI(false)
	arg_6_0:setFold(arg_6_0._isFoldOut)
end

function var_0_0.refreshLibTypeList(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._libTypes) do
		arg_7_0:_getOrCreateLibTypeItem(iter_7_0):setLibType(arg_7_0._actId, iter_7_1)
	end
end

function var_0_0._getOrCreateLibTypeItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._libTypeItemList[arg_8_1]

	if not var_8_0 then
		local var_8_1 = gohelper.cloneInPlace(arg_8_0._gosubitem, arg_8_1)

		var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, AssassinLibraryTypeCategoryItem)
		arg_8_0._libTypeItemList[arg_8_1] = var_8_0
	end

	return var_8_0
end

function var_0_0.onSelect(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:refreshSelectUI(arg_9_1, arg_9_2)
end

function var_0_0.refreshSelectUI(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_0._gotopselect, arg_10_1)
	gohelper.setActive(arg_10_0._gotopunselect, not arg_10_1)

	for iter_10_0, iter_10_1 in pairs(arg_10_0._libTypeItemList) do
		if iter_10_1:getLibType() == arg_10_2 then
			iter_10_1:onSelect(arg_10_1)

			if arg_10_1 then
				arg_10_0:setFold(true)
			end
		else
			iter_10_1:onSelect(false)
		end
	end
end

function var_0_0.getLibType(arg_11_0, arg_11_1)
	return arg_11_0._libTypes and arg_11_0._libTypes[arg_11_1]
end

function var_0_0._onRefreshActivityState(arg_12_0, arg_12_1)
	if arg_12_0._actId ~= arg_12_1 then
		return
	end

	arg_12_0:refreshUI()
end

function var_0_0.refreshRedDot(arg_13_0)
	if not arg_13_0._isVisible then
		return
	end

	local var_13_0 = arg_13_0:_redDotCheckFunc()

	gohelper.setActive(arg_13_0._goreddot1, var_13_0)
	gohelper.setActive(arg_13_0._goreddot2, var_13_0)
end

function var_0_0._redDotCheckFunc(arg_14_0)
	local var_14_0 = AssassinLibraryModel.instance:getNewUnlockLibraryIdMap(arg_14_0._actId)
	local var_14_1 = false

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		arg_14_0._libTypeItemList[iter_14_0]:refreshRedDot(iter_14_1)

		if iter_14_1 then
			var_14_1 = true
		end
	end

	return var_14_1
end

function var_0_0.setFold(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._isFoldOut = arg_15_1

	gohelper.setActive(arg_15_0._goselectarrow_in, arg_15_1)
	gohelper.setActive(arg_15_0._goselectarrow_out, not arg_15_1)
	gohelper.setActive(arg_15_0._gounselectarrow_in, arg_15_1)
	gohelper.setActive(arg_15_0._gounselectarrow_out, not arg_15_1)

	if arg_15_2 then
		arg_15_0:_playFoldAnim(arg_15_1)
	else
		arg_15_0:setSubListVisible(arg_15_1)
	end
end

function var_0_0._playFoldAnim(arg_16_0, arg_16_1)
	arg_16_0:setSubListVisible(true)

	arg_16_0._foldFlow = FlowSequence.New()

	arg_16_0._foldFlow:addWork(FunctionWork.New(arg_16_0._lockScreen, arg_16_0, true))

	local var_16_0 = arg_16_0._libTypeItemList and #arg_16_0._libTypeItemList or 0
	local var_16_1 = arg_16_1 and 1 or var_16_0
	local var_16_2 = arg_16_1 and var_16_0 or 1
	local var_16_3 = arg_16_1 and 1 or -1

	for iter_16_0 = var_16_1, var_16_2, var_16_3 do
		local var_16_4 = arg_16_0._libTypeItemList[iter_16_0]

		arg_16_0._foldFlow:addWork(var_16_4:buildFoldTweenWork(arg_16_1))
	end

	arg_16_0._foldFlow:addWork(FunctionWork.New(arg_16_0._lockScreen, arg_16_0, false))
	arg_16_0._foldFlow:addWork(FunctionWork.New(arg_16_0.setSubListVisible, arg_16_0, arg_16_1))
	arg_16_0._foldFlow:start()
end

function var_0_0._lockScreen(arg_17_0, arg_17_1)
	if arg_17_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AssassinLibraryActCategoryItem")
	else
		UIBlockMgr.instance:endBlock("AssassinLibraryActCategoryItem")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.setSubListVisible(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._gosubs, arg_18_1)

	arg_18_0._isSubVisible = arg_18_1
end

function var_0_0.tryClickSelf(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:tryClickTop(arg_19_1, arg_19_2)

	return var_19_0 and var_19_0 or arg_19_0:tryClickSubItems(arg_19_1, arg_19_2)
end

function var_0_0.tryClickTop(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_20_0._btnclick.transform, arg_20_1, arg_20_2)

	if var_20_0 then
		arg_20_0:_btnclickOnClick()
	end

	return var_20_0
end

function var_0_0.tryClickSubItems(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_0._isSubVisible then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._libTypeItemList) do
		if iter_21_1:tryClickSelf(arg_21_1, arg_21_2) then
			return true
		end
	end
end

function var_0_0.onDestroy(arg_22_0)
	if arg_22_0._foldFlow then
		arg_22_0._foldFlow:destroy()

		arg_22_0._foldFlow = nil

		arg_22_0:_lockScreen(false)
	end
end

return var_0_0

module("modules.logic.achievement.view.AchievementMainView", package.seeall)

local var_0_0 = class("AchievementMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocategoryitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_category/categorycontent/#go_categoryitem")
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageBottomBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_BottomBG")
	arg_1_0._btnedit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Bottom/Edit/#btn_edit")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_groupTips/image_TipsBG/#txt_Descr")
	arg_1_0._btnswitchscrolltype = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_switchscrolltype")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_container/#scroll_content")
	arg_1_0._scrolllist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_container/#scroll_list")
	arg_1_0._btnrare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_sort/#btn_rare")
	arg_1_0._btnunlocktime = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_sort/#btn_unlocktime")
	arg_1_0._txtunlockcount = gohelper.findChildText(arg_1_0.viewGO, "Bottom/UnLockCount/image_UnLockBG/#txt_unlockcount")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnedit:AddClickListener(arg_2_0._btneditOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnedit:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(AchievementMainController.instance, AchievementEvent.AchievementMainViewUpdate, arg_4_0.refreshUI, arg_4_0)
	arg_4_0:addEventCb(AchievementController.instance, AchievementEvent.UpdateAchievementState, arg_4_0.updateAchievementState, arg_4_0)
	arg_4_0._simageFullBG:LoadImage(ResUrl.getAchievementIcon("achievement_editfullbg"))
	arg_4_0._simageBottomBG:LoadImage(ResUrl.getAchievementIcon("achievement_editbottombg"))
	arg_4_0:initCategory()
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._categoryItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._categoryItems) do
			iter_5_1.btnself:RemoveClickListener()
		end

		arg_5_0._categoryItems = nil
	end

	arg_5_0._simageFullBG:UnLoadImage()
	arg_5_0._simageBottomBG:UnLoadImage()
	AchievementMainController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam and arg_6_0.viewParam.categoryType
	local var_6_1 = arg_6_0.viewParam and arg_6_0.viewParam.viewType
	local var_6_2 = arg_6_0.viewParam and arg_6_0.viewParam.sortType
	local var_6_3 = arg_6_0.viewParam and arg_6_0.viewParam.filterType
	local var_6_4 = arg_6_0.viewParam and arg_6_0.viewParam.focusDataId
	local var_6_5 = arg_6_0.viewParam and arg_6_0.viewParam.achievementType
	local var_6_6 = arg_6_0.viewParam and arg_6_0.viewParam.isOpenLevelView

	AchievementMainController.instance:onOpenView(var_6_0, var_6_1, var_6_2, var_6_3)

	if var_6_6 and var_6_4 and var_6_5 == AchievementEnum.AchievementType.Single then
		AchievementController.instance:openAchievementLevelView(var_6_4)
	end

	arg_6_0:refreshUI()
end

function var_0_0.updateAchievementState(arg_7_0)
	AchievementMainController.instance:updateAchievementState()
	arg_7_0:refreshUI()
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(AchievementMainController.instance, AchievementEvent.AchievementMainViewUpdate, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:removeEventCb(AchievementController.instance, AchievementEvent.UpdateAchievementState, arg_8_0.updateAchievementState, arg_8_0)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshCategory()
	arg_9_0:refreshUnlockCount()
	arg_9_0:refreshEmptyUI()
end

function var_0_0.refreshCategory(arg_10_0)
	local var_10_0 = AchievementMainCommonModel.instance:getCurrentCategory()

	for iter_10_0, iter_10_1 in pairs(arg_10_0._categoryItems) do
		local var_10_1 = var_10_0 == arg_10_0._focusTypes[iter_10_0]

		gohelper.setActive(iter_10_1.goselected, var_10_1)
		gohelper.setActive(iter_10_1.gounselected, not var_10_1)

		local var_10_2 = AchievementMainCommonModel.instance:categoryHasNew(arg_10_0._focusTypes[iter_10_0])

		gohelper.setActive(iter_10_1.goreddot1, var_10_2)
		gohelper.setActive(iter_10_1.goreddot2, var_10_2)
	end
end

function var_0_0.refreshUnlockCount(arg_11_0)
	local var_11_0 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_11_1, var_11_2 = AchievementMainCommonModel.instance:getCategoryAchievementUnlockInfo(var_11_0)
	local var_11_3 = {
		var_11_2,
		var_11_1
	}

	arg_11_0._txtunlockcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockTaskCount"), var_11_3)
end

function var_0_0.refreshEmptyUI(arg_12_0)
	local var_12_0 = AchievementMainCommonModel.instance:isCurrentViewBagEmpty()

	gohelper.setActive(arg_12_0._goempty, var_12_0)
end

function var_0_0.initCategory(arg_13_0)
	arg_13_0._focusTypes = {
		AchievementEnum.Type.Story,
		AchievementEnum.Type.Normal,
		AchievementEnum.Type.GamePlay,
		AchievementEnum.Type.Activity
	}
	arg_13_0._categoryItems = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._focusTypes) do
		local var_13_0 = arg_13_0:getUserDataTb_()

		var_13_0.go = gohelper.cloneInPlace(arg_13_0._gocategoryitem, "category_" .. tostring(iter_13_0))

		gohelper.setActive(var_13_0.go, true)

		var_13_0.gounselected = gohelper.findChild(var_13_0.go, "go_unselected")
		var_13_0.txtitemcn1 = gohelper.findChildText(var_13_0.go, "go_unselected/txt_itemcn1")
		var_13_0.txtitemen1 = gohelper.findChildText(var_13_0.go, "go_unselected/txt_itemen1")
		var_13_0.goselected = gohelper.findChild(var_13_0.go, "go_selected")
		var_13_0.txtitemcn2 = gohelper.findChildText(var_13_0.go, "go_selected/txt_itemcn2")
		var_13_0.txtitemen2 = gohelper.findChildText(var_13_0.go, "go_selected/txt_itemen2")
		var_13_0.btnself = gohelper.findChildButtonWithAudio(var_13_0.go, "btn_self")

		var_13_0.btnself:AddClickListener(arg_13_0.onClickCategory, arg_13_0, iter_13_0)

		var_13_0.goreddot1 = gohelper.findChild(var_13_0.go, "go_unselected/txt_itemcn1/#go_reddot1")
		var_13_0.goreddot2 = gohelper.findChild(var_13_0.go, "go_selected/txt_itemcn2/#go_reddot2")

		local var_13_1 = AchievementEnum.TypeName[iter_13_1]
		local var_13_2 = AchievementEnum.TypeNameEn[iter_13_1]

		if not string.nilorempty(var_13_1) then
			var_13_0.txtitemcn1.text = luaLang(var_13_1)
			var_13_0.txtitemcn2.text = luaLang(var_13_1)
			var_13_0.txtitemen1.text = tostring(var_13_2)
			var_13_0.txtitemen2.text = tostring(var_13_2)
		end

		arg_13_0._categoryItems[iter_13_0] = var_13_0
	end
end

function var_0_0.onClickCategory(arg_14_0, arg_14_1)
	local var_14_0 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_14_1 = arg_14_0._focusTypes[arg_14_1]

	if var_14_0 == var_14_1 then
		return
	end

	AchievementMainController.instance:setCategory(var_14_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
end

function var_0_0._btneditOnClick(arg_15_0)
	ViewMgr.instance:openView(ViewName.AchievementSelectView)

	if arg_15_0.viewParam.jumpFrom == ViewName.AchievementSelectView then
		arg_15_0:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_thumbnail_click)
end

return var_0_0

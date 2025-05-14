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
	arg_4_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnClickGroupFoldBtn, arg_4_0.onClickGroupFoldBtn, arg_4_0)
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
	arg_8_0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnClickGroupFoldBtn, arg_8_0.onClickGroupFoldBtn, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onEndPlayGroupFadeAnim, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onPreEndPlayGroupFadeAnim, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onDispatchAchievementFadeAnimationEvent, arg_8_0)

	arg_8_0._modifyMap = nil

	arg_8_0:onEndPlayGroupFadeAnim()
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

function var_0_0.onClickGroupFoldBtn(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:onStartPlayGroupFadeAnim()
	arg_16_0:doAchievementFadeAnimation(arg_16_1, arg_16_2)
end

function var_0_0.onStartPlayGroupFadeAnim(arg_17_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("AchievementMainView_BeginPlayGroupFadeAnim")
end

function var_0_0.onEndPlayGroupFadeAnim(arg_18_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainView_BeginPlayGroupFadeAnim")
end

local var_0_1 = 0.001
local var_0_2 = 0.0003
local var_0_3 = 0
local var_0_4 = 0.35

function var_0_0.doAchievementFadeAnimation(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = AchievementMainListModel.instance:getGroupMOList(arg_19_1)
	local var_19_1 = var_19_0 and var_19_0[1]
	local var_19_2 = arg_19_0:getCurRenderCellCount(arg_19_1, var_19_0, arg_19_2)
	local var_19_3 = arg_19_2 and var_19_2 or 1
	local var_19_4 = arg_19_2 and 1 or var_19_2
	local var_19_5 = 0

	arg_19_0._modifyMap = arg_19_0:getUserDataTb_()

	local var_19_6

	arg_19_0._modifyGroupId = arg_19_1
	arg_19_0._isFold = arg_19_2

	local var_19_7 = AchievementMainCommonModel.instance:getCurrentFilterType()
	local var_19_8 = AchievementMainListModel.instance:getIndex(var_19_1)

	for iter_19_0 = var_19_3, var_19_4, arg_19_2 and -1 or 1 do
		local var_19_9 = var_19_0[iter_19_0]

		arg_19_0._modifyMap[var_19_9] = true

		var_19_9:clearOverrideLineHeight()

		if not arg_19_2 and not var_19_9.isGroupTop then
			local var_19_10 = var_19_8 + iter_19_0 - 1

			AchievementMainListModel.instance:addAt(var_19_9, var_19_10)
		end

		local var_19_11 = arg_19_0:getEffectParams(var_19_7, arg_19_2, var_19_9, var_19_6)

		if not arg_19_2 and not var_19_9.isGroupTop then
			var_19_9:overrideLineHeight(0)
		end

		TaskDispatcher.runDelay(arg_19_0.onDispatchAchievementFadeAnimationEvent, var_19_11, var_19_5)

		var_19_5 = var_19_5 + var_19_11.duration
		var_19_6 = var_19_9
	end

	if arg_19_2 then
		arg_19_0:onBeginFoldIn(arg_19_0._modifyGroupId, arg_19_0._isFold)
	end

	TaskDispatcher.cancelTask(arg_19_0.onPreEndPlayGroupFadeAnim, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0.onPreEndPlayGroupFadeAnim, arg_19_0, var_19_5)
	TaskDispatcher.cancelTask(arg_19_0.onEndPlayGroupFadeAnim, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0.onEndPlayGroupFadeAnim, arg_19_0, var_19_5)
end

function var_0_0.onBeginFoldIn(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = AchievementMainListModel.instance:getGroupMOList(arg_20_1)

	if var_20_0 then
		for iter_20_0 = 1, #var_20_0 do
			local var_20_1 = var_20_0[iter_20_0]

			if not arg_20_0._modifyMap[var_20_1] then
				var_20_1:setIsFold(arg_20_2)
				var_20_1:clearOverrideLineHeight()
				AchievementMainListModel.instance:remove(var_20_1)
			end
		end

		AchievementMainListModel.instance:onModelUpdate()
	end
end

function var_0_0.onPreEndPlayGroupFadeAnim(arg_21_0)
	local var_21_0 = AchievementMainListModel.instance:getGroupMOList(arg_21_0._modifyGroupId)

	if var_21_0 then
		local var_21_1 = var_21_0 and var_21_0[1]
		local var_21_2 = AchievementMainListModel.instance:getIndex(var_21_1)

		for iter_21_0 = 1, #var_21_0 do
			local var_21_3 = var_21_0[iter_21_0]

			var_21_3:setIsFold(arg_21_0._isFold)
			var_21_3:clearOverrideLineHeight()

			if not arg_21_0._isFold and not arg_21_0._modifyMap[var_21_3] then
				local var_21_4 = var_21_2 + iter_21_0 - 1

				AchievementMainListModel.instance:addAt(var_21_3, var_21_4)
			end
		end

		AchievementMainListModel.instance:onModelUpdate()
	end
end

function var_0_0.getEffectParams(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_3:getLineHeight(arg_22_1, not arg_22_2)
	local var_22_1 = arg_22_3:getLineHeight(arg_22_1, arg_22_2)
	local var_22_2 = arg_22_2 and var_0_2 or var_0_1
	local var_22_3 = math.abs(var_22_1 - var_22_0) * var_22_2
	local var_22_4 = Mathf.Clamp(var_22_3, var_0_3, var_0_4)

	return {
		achievementId = arg_22_3.id,
		isFold = arg_22_2,
		orginLineHeight = var_22_0,
		targetLineHeight = var_22_1,
		duration = var_22_4,
		lastModifyMO = arg_22_4
	}
end

function var_0_0.onDispatchAchievementFadeAnimationEvent(arg_23_0)
	local var_23_0 = arg_23_0.isFold
	local var_23_1 = arg_23_0.lastModifyMO

	if var_23_0 and var_23_1 and not var_23_1.isGroupTop then
		AchievementMainListModel.instance:remove(var_23_1)
	end

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnPlayGroupFadeAnim, arg_23_0)
end

local var_0_5 = 3

function var_0_0.getCurRenderCellCount(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0.viewContainer:getScrollView(AchievementEnum.ViewType.List)
	local var_24_1 = var_24_0:getCsScroll()
	local var_24_2 = 0

	if not arg_24_3 then
		var_24_2 = arg_24_0:getCurRenderCellCountWhileFoldIn(arg_24_1, arg_24_2, var_24_1)
	else
		var_24_2 = arg_24_0:getCurRenderCellCountWhileFoldOut(arg_24_1, arg_24_2, var_24_0, var_24_1)
	end

	return (Mathf.Clamp(var_24_2, 1, var_0_5))
end

function var_0_0.getCurRenderCellCountWhileFoldIn(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = AchievementMainCommonModel.instance:getCurrentFilterType()
	local var_25_1 = 0
	local var_25_2 = 1
	local var_25_3 = 0

	for iter_25_0, iter_25_1 in ipairs(arg_25_2) do
		if AchievementConfig.instance:getAchievement(iter_25_1.id).groupId ~= arg_25_1 then
			var_25_1 = var_25_1 + iter_25_1:getLineHeight(var_25_0, iter_25_1:getIsFold())
		else
			var_25_2 = iter_25_0

			break
		end
	end

	local var_25_4 = arg_25_3.VerticalScrollPixel
	local var_25_5 = recthelper.getHeight(arg_25_3.transform)
	local var_25_6 = Mathf.Clamp(var_25_5 - var_25_1 - var_25_4, 0, var_25_5)

	for iter_25_2 = var_25_2, #arg_25_2 do
		var_25_6 = var_25_6 - arg_25_2[iter_25_2]:getLineHeight(var_25_0, false)

		if var_25_6 > 0 then
			var_25_3 = var_25_3 + 1
		else
			break
		end
	end

	return var_25_3
end

function var_0_0.getCurRenderCellCountWhileFoldOut(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = arg_26_3._cellCompDict
	local var_26_1 = {}
	local var_26_2 = 0

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		if AchievementConfig.instance:getAchievement(iter_26_0._mo.id).groupId == arg_26_1 then
			var_26_1[iter_26_0._mo.id] = iter_26_0
		end
	end

	for iter_26_2 = 1, #arg_26_2 do
		local var_26_3 = var_26_1[arg_26_2[iter_26_2].id]
		local var_26_4 = var_26_3 and var_26_3._index - 1 or -1

		if not var_26_3 then
			break
		end

		if not arg_26_4:IsVisual(var_26_4) then
			break
		end

		var_26_2 = var_26_2 + 1
	end

	return var_26_2
end

return var_0_0

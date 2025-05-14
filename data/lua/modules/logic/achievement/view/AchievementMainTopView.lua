module("modules.logic.achievement.view.AchievementMainTopView", package.seeall)

local var_0_0 = class("AchievementMainTopView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/Btns/#btn_View")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_container/#scroll_content")
	arg_1_0._scrolllist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_container/#scroll_list")
	arg_1_0._golist = gohelper.findChild(arg_1_0.viewGO, "Title/Btns/#btn_View/#go_On")
	arg_1_0._gotile = gohelper.findChild(arg_1_0.viewGO, "Title/Btns/#btn_View/#go_Off")
	arg_1_0._dropfilter = gohelper.findChildDropdown(arg_1_0.viewGO, "Title/Btns/#drop_Fliter")
	arg_1_0._goarrowup = gohelper.findChild(arg_1_0.viewGO, "Title/Btns/#drop_Fliter/#go_arrowup")
	arg_1_0._goarrowdown = gohelper.findChild(arg_1_0.viewGO, "Title/Btns/#drop_Fliter/#go_arrowdown")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnView:AddClickListener(arg_2_0._btnviewOnClick, arg_2_0)
	arg_2_0._dropfilter:AddOnValueChanged(arg_2_0._onDropFilterValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnView:RemoveClickListener()
	arg_3_0._dropfilter:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.filterDropExtend = DropDownExtend.Get(arg_4_0._dropfilter.gameObject)

	arg_4_0.filterDropExtend:init(arg_4_0.onFilterDropShow, arg_4_0.onFilterDropHide, arg_4_0)
	arg_4_0:initSearchFilterBtns()
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onAchievementListItemOpenAnimPlayFinished, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = AchievementMainCommonModel.instance:getCurrentViewType()

	arg_7_0:refreshViewTypeBtns(var_7_0)
	arg_7_0:refreshScrollVisible(var_7_0)
	arg_7_0:refreshFilterDropDownArrow()
end

function var_0_0._btnviewOnClick(arg_8_0)
	local var_8_0 = AchievementMainCommonModel.instance:getCurrentViewType() == AchievementEnum.ViewType.List and AchievementEnum.ViewType.Tile or AchievementEnum.ViewType.List

	arg_8_0:refreshViewTypeBtns(var_8_0)
	arg_8_0:refreshScrollVisible(var_8_0)

	if var_8_0 == AchievementEnum.ViewType.List then
		AchievementMainListModel.instance:setIsCurTaskNeedPlayIdleAnim(false)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AchievementMainFocusView_openAnim")
		TaskDispatcher.cancelTask(arg_8_0._onAchievementListItemOpenAnimPlayFinished, arg_8_0)
		TaskDispatcher.runDelay(arg_8_0._onAchievementListItemOpenAnimPlayFinished, arg_8_0, 0.6)
	end

	AchievementMainController.instance:switchViewType(var_8_0)
end

function var_0_0._onAchievementListItemOpenAnimPlayFinished(arg_9_0)
	AchievementMainListModel.instance:setIsCurTaskNeedPlayIdleAnim(true)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainFocusView_openAnim")
end

function var_0_0._onClickDropFilter(arg_10_0)
	arg_10_0._isPopUpFilterList = not arg_10_0._isPopUpFilterList

	arg_10_0:refreshFilterDropDownArrow()
end

function var_0_0.onFilterDropShow(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_11_0._isPopUpFilterList = true

	arg_11_0:refreshFilterDropDownArrow()
end

function var_0_0.onFilterDropHide(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_12_0._isPopUpFilterList = false

	arg_12_0:refreshFilterDropDownArrow()
end

function var_0_0.refreshFilterDropDownArrow(arg_13_0)
	gohelper.setActive(arg_13_0._goarrowdown, not arg_13_0._isPopUpFilterList)
	gohelper.setActive(arg_13_0._goarrowup, arg_13_0._isPopUpFilterList)
end

function var_0_0.refreshViewTypeBtns(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._golist, arg_14_1 == AchievementEnum.ViewType.List)
	gohelper.setActive(arg_14_0._gotile, arg_14_1 == AchievementEnum.ViewType.Tile)
end

function var_0_0.refreshScrollVisible(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._scrolllist.gameObject, arg_15_1 == AchievementEnum.ViewType.List)
	gohelper.setActive(arg_15_0._scrollcontent.gameObject, arg_15_1 == AchievementEnum.ViewType.Tile)
end

function var_0_0._onDropFilterValueChanged(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 + 1

	local var_16_0 = arg_16_0._filterTypeList and arg_16_0._filterTypeList[arg_16_1]

	AchievementMainController.instance:switchSearchFilterType(var_16_0)
end

function var_0_0.initSearchFilterBtns(arg_17_0)
	arg_17_0._filterTypeList = {
		AchievementEnum.SearchFilterType.All,
		AchievementEnum.SearchFilterType.Locked,
		AchievementEnum.SearchFilterType.Unlocked
	}

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._filterTypeList) do
		local var_17_1 = AchievementEnum.FilterTypeName[iter_17_1]
		local var_17_2 = luaLang(var_17_1)

		table.insert(var_17_0, var_17_2)
	end

	arg_17_0._dropfilter:AddOptions(var_17_0)
end

return var_0_0

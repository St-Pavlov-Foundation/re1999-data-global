module("modules.logic.achievement.view.AchievementMainTopView", package.seeall)

slot0 = class("AchievementMainTopView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnView = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/Btns/#btn_View")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#go_container/#scroll_content")
	slot0._scrolllist = gohelper.findChildScrollRect(slot0.viewGO, "#go_container/#scroll_list")
	slot0._golist = gohelper.findChild(slot0.viewGO, "Title/Btns/#btn_View/#go_On")
	slot0._gotile = gohelper.findChild(slot0.viewGO, "Title/Btns/#btn_View/#go_Off")
	slot0._dropfilter = gohelper.findChildDropdown(slot0.viewGO, "Title/Btns/#drop_Fliter")
	slot0._goarrowup = gohelper.findChild(slot0.viewGO, "Title/Btns/#drop_Fliter/#go_arrowup")
	slot0._goarrowdown = gohelper.findChild(slot0.viewGO, "Title/Btns/#drop_Fliter/#go_arrowdown")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnView:AddClickListener(slot0._btnviewOnClick, slot0)
	slot0._dropfilter:AddOnValueChanged(slot0._onDropFilterValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnView:RemoveClickListener()
	slot0._dropfilter:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0.filterDropExtend = DropDownExtend.Get(slot0._dropfilter.gameObject)

	slot0.filterDropExtend:init(slot0.onFilterDropShow, slot0.onFilterDropHide, slot0)
	slot0:initSearchFilterBtns()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onAchievementListItemOpenAnimPlayFinished, slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1 = AchievementMainCommonModel.instance:getCurrentViewType()

	slot0:refreshViewTypeBtns(slot1)
	slot0:refreshScrollVisible(slot1)
	slot0:refreshFilterDropDownArrow()
end

function slot0._btnviewOnClick(slot0)
	slot2 = AchievementMainCommonModel.instance:getCurrentViewType() == AchievementEnum.ViewType.List and AchievementEnum.ViewType.Tile or AchievementEnum.ViewType.List

	slot0:refreshViewTypeBtns(slot2)
	slot0:refreshScrollVisible(slot2)

	if slot2 == AchievementEnum.ViewType.List then
		AchievementMainListModel.instance:setIsCurTaskNeedPlayIdleAnim(false)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AchievementMainFocusView_openAnim")
		TaskDispatcher.cancelTask(slot0._onAchievementListItemOpenAnimPlayFinished, slot0)
		TaskDispatcher.runDelay(slot0._onAchievementListItemOpenAnimPlayFinished, slot0, 0.6)
	end

	AchievementMainController.instance:switchViewType(slot2)
end

function slot0._onAchievementListItemOpenAnimPlayFinished(slot0)
	AchievementMainListModel.instance:setIsCurTaskNeedPlayIdleAnim(true)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainFocusView_openAnim")
end

function slot0._onClickDropFilter(slot0)
	slot0._isPopUpFilterList = not slot0._isPopUpFilterList

	slot0:refreshFilterDropDownArrow()
end

function slot0.onFilterDropShow(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	slot0._isPopUpFilterList = true

	slot0:refreshFilterDropDownArrow()
end

function slot0.onFilterDropHide(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	slot0._isPopUpFilterList = false

	slot0:refreshFilterDropDownArrow()
end

function slot0.refreshFilterDropDownArrow(slot0)
	gohelper.setActive(slot0._goarrowdown, not slot0._isPopUpFilterList)
	gohelper.setActive(slot0._goarrowup, slot0._isPopUpFilterList)
end

function slot0.refreshViewTypeBtns(slot0, slot1)
	gohelper.setActive(slot0._golist, slot1 == AchievementEnum.ViewType.List)
	gohelper.setActive(slot0._gotile, slot1 == AchievementEnum.ViewType.Tile)
end

function slot0.refreshScrollVisible(slot0, slot1)
	gohelper.setActive(slot0._scrolllist.gameObject, slot1 == AchievementEnum.ViewType.List)
	gohelper.setActive(slot0._scrollcontent.gameObject, slot1 == AchievementEnum.ViewType.Tile)
end

function slot0._onDropFilterValueChanged(slot0, slot1)
	AchievementMainController.instance:switchSearchFilterType(slot0._filterTypeList and slot0._filterTypeList[slot1 + 1])
end

function slot0.initSearchFilterBtns(slot0)
	slot0._filterTypeList = {
		AchievementEnum.SearchFilterType.All,
		AchievementEnum.SearchFilterType.Locked,
		AchievementEnum.SearchFilterType.Unlocked
	}
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._filterTypeList) do
		table.insert(slot1, luaLang(AchievementEnum.FilterTypeName[slot6]))
	end

	slot0._dropfilter:AddOptions(slot1)
end

return slot0

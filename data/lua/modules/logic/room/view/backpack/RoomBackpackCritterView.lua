module("modules.logic.room.view.backpack.RoomBackpackCritterView", package.seeall)

slot0 = class("RoomBackpackCritterView", BaseView)

function slot0.onInitView(slot0)
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_num/#txt_num")
	slot0._gonumreddot = gohelper.findChild(slot0.viewGO, "#go_num/#txt_num/#go_reddot")
	slot0._gocritterSort = gohelper.findChild(slot0.viewGO, "#go_critterSort")
	slot0._btncirtterRare = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critterSort/#btn_cirtterRare")
	slot0._transcritterRareArrow = gohelper.findChild(slot0.viewGO, "#go_critterSort/#btn_cirtterRare/selected/txt/arrow").transform
	slot0._dropmaturefilter = gohelper.findChildDropdown(slot0.viewGO, "#go_critterSort/#drop_mature")
	slot0._transmatureDroparrow = gohelper.findChild(slot0.viewGO, "#go_critterSort/#drop_mature/#go_arrow").transform
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critterSort/#btn_filter")
	slot0._gonotfilter = gohelper.findChild(slot0.viewGO, "#go_critterSort/#btn_filter/#go_notfilter")
	slot0._gofilter = gohelper.findChild(slot0.viewGO, "#go_critterSort/#btn_filter/#go_filter")
	slot0._btncompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "compose/#btn_compose")
	slot0._gocomposeReddot = gohelper.findChild(slot0.viewGO, "compose/#btn_compose/#go_reddot")
	slot0._gocomposebtn = slot0._btncompose.gameObject

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._dropmaturefilter:AddOnValueChanged(slot0.onMatureDropValueChange, slot0)
	slot0._btncirtterRare:AddClickListener(slot0._btncirtterRareOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btncompose:AddClickListener(slot0._btncomposeOnClick, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0.onCritterFilterTypeChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0.onCritterChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, slot0.onCritterChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._dropmaturefilter:RemoveOnValueChanged()
	slot0._btncirtterRare:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
	slot0._btncompose:RemoveClickListener()
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0.onCritterFilterTypeChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0.onCritterChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, slot0.onCritterChange, slot0)
end

function slot0._btncirtterRareOnClick(slot0)
	RoomBackpackController.instance:clickCritterRareSort(slot0.filterMO)
	slot0:refreshRareSort()
end

function slot0._btnfilterOnClick(slot0)
	CritterController.instance:openCritterFilterView({
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}, slot0.viewName)
end

function slot0._btncomposeOnClick(slot0)
	RoomBackpackController.instance:openCritterDecomposeView()
end

function slot0.onDropShow(slot0)
	transformhelper.setLocalScale(slot0._transmatureDroparrow, 1, 1, 1)
end

function slot0.onMatureDropValueChange(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	RoomBackpackController.instance:selectMatureFilterType(slot0._filterTypeList and slot0._filterTypeList[slot1 + 1], slot0.filterMO)
	slot0:refreshCritterCount()
end

function slot0.onDropHide(slot0)
	transformhelper.setLocalScale(slot0._transmatureDroparrow, 1, -1, 1)
end

function slot0.onCritterFilterTypeChange(slot0, slot1)
	if slot1 ~= slot0.viewName then
		return
	end

	slot0:refreshFilterBtn()
	slot0:refreshCritterList()
end

function slot0.onCritterChange(slot0)
	slot0:refreshCritterList()
end

function slot0._editableInitView(slot0)
	slot0.dropExtend = DropDownExtend.Get(slot0._dropmaturefilter.gameObject)

	slot0.dropExtend:init(slot0.onDropShow, slot0.onDropHide, slot0)
	slot0:initMatureDropFilter()
end

function slot0.initMatureDropFilter(slot0)
	slot0._filterTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._filterTypeList) do
		table.insert(slot1, luaLang(CritterEnum.MatureFilterTypeName[slot6]))
	end

	slot0._dropmaturefilter:ClearOptions()
	slot0._dropmaturefilter:AddOptions(slot1)

	slot0.initMatureDropDone = true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.filterMO = CritterFilterModel.instance:generateFilterMO(slot0.viewName)

	slot0:refreshRareSort()
	slot0:refreshCritterList()
	slot0:refreshFilterBtn()
	RedDotController.instance:addRedDot(slot0._gonumreddot, RedDotEnum.DotNode.CritterIsFull)
	RedDotController.instance:addRedDot(slot0._gocomposeReddot, RedDotEnum.DotNode.CritterIsFull)
end

function slot0.refreshRareSort(slot0)
	transformhelper.setLocalScale(slot0._transcritterRareArrow, 1, RoomBackpackCritterListModel.instance:getIsSortByRareAscend() and 1 or -1, 1)
end

function slot0.refreshCritterList(slot0)
	RoomBackpackController.instance:refreshCritterBackpackList(slot0.filterMO)
	slot0:refreshCritterCount()
end

function slot0.refreshCritterCount(slot0)
	slot0._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_critter_backpack_num"), RoomBackpackCritterListModel.instance:getCount(), CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterBackpackCapacity) or 0)

	slot0:refreshIsEmpty()
end

function slot0.refreshIsEmpty(slot0)
	slot1 = RoomBackpackCritterListModel.instance:isBackpackEmpty()

	gohelper.setActive(slot0._goempty, slot1)
	gohelper.setActive(slot0._gocomposebtn, not slot1)
end

function slot0.refreshFilterBtn(slot0)
	slot1 = slot0.filterMO:isFiltering()

	gohelper.setActive(slot0._gonotfilter, not slot1)
	gohelper.setActive(slot0._gofilter, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.dropExtend then
		slot0.dropExtend:dispose()
	end
end

return slot0

module("modules.logic.room.view.backpack.RoomBackpackCritterView", package.seeall)

local var_0_0 = class("RoomBackpackCritterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_num/#txt_num")
	arg_1_0._gonumreddot = gohelper.findChild(arg_1_0.viewGO, "#go_num/#txt_num/#go_reddot")
	arg_1_0._gocritterSort = gohelper.findChild(arg_1_0.viewGO, "#go_critterSort")
	arg_1_0._btncirtterRare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critterSort/#btn_cirtterRare")
	arg_1_0._transcritterRareArrow = gohelper.findChild(arg_1_0.viewGO, "#go_critterSort/#btn_cirtterRare/selected/txt/arrow").transform
	arg_1_0._dropmaturefilter = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_critterSort/#drop_mature")
	arg_1_0._transmatureDroparrow = gohelper.findChild(arg_1_0.viewGO, "#go_critterSort/#drop_mature/#go_arrow").transform
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critterSort/#btn_filter")
	arg_1_0._gonotfilter = gohelper.findChild(arg_1_0.viewGO, "#go_critterSort/#btn_filter/#go_notfilter")
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "#go_critterSort/#btn_filter/#go_filter")
	arg_1_0._btncompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "compose/#btn_compose")
	arg_1_0._gocomposeReddot = gohelper.findChild(arg_1_0.viewGO, "compose/#btn_compose/#go_reddot")
	arg_1_0._gocomposebtn = arg_1_0._btncompose.gameObject

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._dropmaturefilter:AddOnValueChanged(arg_2_0.onMatureDropValueChange, arg_2_0)
	arg_2_0._btncirtterRare:AddClickListener(arg_2_0._btncirtterRareOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btncompose:AddClickListener(arg_2_0._btncomposeOnClick, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_2_0.onCritterFilterTypeChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_2_0.onCritterChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, arg_2_0.onCritterChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._dropmaturefilter:RemoveOnValueChanged()
	arg_3_0._btncirtterRare:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btncompose:RemoveClickListener()
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_3_0.onCritterFilterTypeChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_3_0.onCritterChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterDecomposeReply, arg_3_0.onCritterChange, arg_3_0)
end

function var_0_0._btncirtterRareOnClick(arg_4_0)
	RoomBackpackController.instance:clickCritterRareSort(arg_4_0.filterMO)
	arg_4_0:refreshRareSort()
end

function var_0_0._btnfilterOnClick(arg_5_0)
	local var_5_0 = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(var_5_0, arg_5_0.viewName)
end

function var_0_0._btncomposeOnClick(arg_6_0)
	RoomBackpackController.instance:openCritterDecomposeView()
end

function var_0_0.onDropShow(arg_7_0)
	transformhelper.setLocalScale(arg_7_0._transmatureDroparrow, 1, 1, 1)
end

function var_0_0.onMatureDropValueChange(arg_8_0, arg_8_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)

	local var_8_0 = arg_8_0._filterTypeList and arg_8_0._filterTypeList[arg_8_1 + 1]

	RoomBackpackController.instance:selectMatureFilterType(var_8_0, arg_8_0.filterMO)
	arg_8_0:refreshCritterCount()
end

function var_0_0.onDropHide(arg_9_0)
	transformhelper.setLocalScale(arg_9_0._transmatureDroparrow, 1, -1, 1)
end

function var_0_0.onCritterFilterTypeChange(arg_10_0, arg_10_1)
	if arg_10_1 ~= arg_10_0.viewName then
		return
	end

	arg_10_0:refreshFilterBtn()
	arg_10_0:refreshCritterList()
end

function var_0_0.onCritterChange(arg_11_0)
	arg_11_0:refreshCritterList()
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.dropExtend = DropDownExtend.Get(arg_12_0._dropmaturefilter.gameObject)

	arg_12_0.dropExtend:init(arg_12_0.onDropShow, arg_12_0.onDropHide, arg_12_0)
	arg_12_0:initMatureDropFilter()
end

function var_0_0.initMatureDropFilter(arg_13_0)
	arg_13_0._filterTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._filterTypeList) do
		local var_13_1 = CritterEnum.MatureFilterTypeName[iter_13_1]
		local var_13_2 = luaLang(var_13_1)

		table.insert(var_13_0, var_13_2)
	end

	arg_13_0._dropmaturefilter:ClearOptions()
	arg_13_0._dropmaturefilter:AddOptions(var_13_0)

	arg_13_0.initMatureDropDone = true
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0.filterMO = CritterFilterModel.instance:generateFilterMO(arg_15_0.viewName)

	arg_15_0:refreshRareSort()
	arg_15_0:refreshCritterList()
	arg_15_0:refreshFilterBtn()
	RedDotController.instance:addRedDot(arg_15_0._gonumreddot, RedDotEnum.DotNode.CritterIsFull)
	RedDotController.instance:addRedDot(arg_15_0._gocomposeReddot, RedDotEnum.DotNode.CritterIsFull)
end

function var_0_0.refreshRareSort(arg_16_0)
	local var_16_0 = RoomBackpackCritterListModel.instance:getIsSortByRareAscend() and 1 or -1

	transformhelper.setLocalScale(arg_16_0._transcritterRareArrow, 1, var_16_0, 1)
end

function var_0_0.refreshCritterList(arg_17_0)
	RoomBackpackController.instance:refreshCritterBackpackList(arg_17_0.filterMO)
	arg_17_0:refreshCritterCount()
end

function var_0_0.refreshCritterCount(arg_18_0)
	local var_18_0 = RoomBackpackCritterListModel.instance:getCount()
	local var_18_1 = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterBackpackCapacity) or 0

	arg_18_0._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_critter_backpack_num"), var_18_0, var_18_1)

	arg_18_0:refreshIsEmpty()
end

function var_0_0.refreshIsEmpty(arg_19_0)
	local var_19_0 = RoomBackpackCritterListModel.instance:isBackpackEmpty()

	gohelper.setActive(arg_19_0._goempty, var_19_0)
	gohelper.setActive(arg_19_0._gocomposebtn, not var_19_0)
end

function var_0_0.refreshFilterBtn(arg_20_0)
	local var_20_0 = arg_20_0.filterMO:isFiltering()

	gohelper.setActive(arg_20_0._gonotfilter, not var_20_0)
	gohelper.setActive(arg_20_0._gofilter, var_20_0)
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0.dropExtend then
		arg_22_0.dropExtend:dispose()
	end
end

return var_0_0

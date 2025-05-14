module("modules.logic.playercard.view.PlayerCardCritterPlaceView", package.seeall)

local var_0_0 = class("PlayerCardCritterPlaceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocritterview1 = gohelper.findChild(arg_1_0.viewGO, "#go_critterview1")
	arg_1_0._btnunfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critterview1/critterscroll/#btn_unfold")
	arg_1_0._gocritterview2 = gohelper.findChild(arg_1_0.viewGO, "#go_critterview2")
	arg_1_0._btnfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critterview2/critterscroll/#btn_fold")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critterview1/#btn_close")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critterview2/#btn_close")
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnunfold:AddClickListener(arg_2_0._btnunfoldOnClick, arg_2_0)
	arg_2_0._btnfold:AddClickListener(arg_2_0._btnfoldOnClick, arg_2_0, true)
	arg_2_0._btnclose1:AddClickListener(arg_2_0.closeThis, arg_2_0, true)
	arg_2_0._btnclose2:AddClickListener(arg_2_0.closeThis, arg_2_0, true)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectCritter, arg_2_0._onRefreshCritter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnunfold:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0._btnunfoldOnClick(arg_4_0)
	arg_4_0._isFold = false
	arg_4_0._canvasGroup1.blocksRaycasts = false
	arg_4_0._canvasGroup2.blocksRaycasts = true
	arg_4_0.currentScrollView = arg_4_0._critterView2
	arg_4_0._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	arg_4_0._critterView2.scrollCritter.verticalNormalizedPosition = 1

	arg_4_0:playAnim("switchup")
	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(arg_4_0.filterMO)

	arg_4_0._scrollRect = arg_4_0._critterView2.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function var_0_0._btnfoldOnClick(arg_5_0, arg_5_1)
	arg_5_0._isFold = true
	arg_5_0._canvasGroup1.blocksRaycasts = true
	arg_5_0._canvasGroup2.blocksRaycasts = false
	arg_5_0.currentScrollView = arg_5_0._critterView1
	arg_5_0._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	arg_5_0._critterView2.scrollCritter.verticalNormalizedPosition = 1

	if arg_5_1 then
		arg_5_0:playAnim("switchdown")
	end

	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(arg_5_0.filterMO)

	arg_5_0._scrollRect = arg_5_0._critterView1.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._canvasGroup1 = arg_6_0._gocritterview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_6_0._canvasGroup2 = arg_6_0._gocritterview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_6_0._critterView1 = arg_6_0:getUserDataTb_()
	arg_6_0._critterView2 = arg_6_0:getUserDataTb_()

	arg_6_0:initCritterView(arg_6_0._critterView1, arg_6_0._gocritterview1, 1)
	arg_6_0:initCritterView(arg_6_0._critterView2, arg_6_0._gocritterview2, 2)

	arg_6_0.currentScrollView = arg_6_0._critterView1
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.initMatureDropFilter(arg_7_0, arg_7_1)
	arg_7_0._filterTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._filterTypeList) do
		local var_7_1 = CritterEnum.MatureFilterTypeName[iter_7_1]
		local var_7_2 = luaLang(var_7_1)

		table.insert(var_7_0, var_7_2)
	end

	arg_7_1:ClearOptions()
	arg_7_1:AddOptions(var_7_0)
end

function var_0_0.playAnim(arg_8_0, arg_8_1)
	arg_8_0.animator.enabled = true

	arg_8_0.animator:Play(arg_8_1)
end

function var_0_0.onDropShow(arg_9_0)
	transformhelper.setLocalScale(arg_9_0._critterView1._transmatureDroparrow, 1, 1, 1)
	transformhelper.setLocalScale(arg_9_0._critterView2._transmatureDroparrow, 1, 1, 1)
end

function var_0_0.onMatureDropValueChange(arg_10_0, arg_10_1)
	arg_10_0:_refreshDropCareer(arg_10_0._critterView1._dropmaturefilter, arg_10_1)
	arg_10_0:_refreshDropCareer(arg_10_0._critterView2._dropmaturefilter, arg_10_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)

	local var_10_0 = arg_10_0._filterTypeList and arg_10_0._filterTypeList[arg_10_1 + 1]

	PlayerCardCritterPlaceListModel.instance:selectMatureFilterType(var_10_0, arg_10_0.filterMO)
end

function var_0_0._refreshDropCareer(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1:SetValue(arg_11_2)
end

function var_0_0.onDropHide(arg_12_0)
	transformhelper.setLocalScale(arg_12_0._critterView1._transmatureDroparrow, 1, -1, 1)
	transformhelper.setLocalScale(arg_12_0._critterView2._transmatureDroparrow, 1, -1, 1)
end

function var_0_0.initCritterView(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1._btncirtterRare = gohelper.findChildButtonWithAudio(arg_13_2, "crittersort/#btn_cirtterRare")
	arg_13_1._transcritterRareArrow = gohelper.findChild(arg_13_2, "crittersort/#btn_cirtterRare/selected/txt/arrow").transform
	arg_13_1._dropmaturefilter = gohelper.findChildDropdown(arg_13_2, "crittersort/#drop_mature")
	arg_13_1._transmatureDroparrow = gohelper.findChild(arg_13_2, "crittersort/#drop_mature/#go_arrow").transform
	arg_13_1.scrollCritter = gohelper.findChildScrollRect(arg_13_2, "critterscroll")
	arg_13_1.sortMoodItem = arg_13_0:getUserDataTb_()
	arg_13_1.sortRareItem = arg_13_0:getUserDataTb_()
	arg_13_1.dropExtend = DropDownExtend.Get(arg_13_1._dropmaturefilter.gameObject)

	arg_13_1.dropExtend:init(arg_13_0.onDropShow, arg_13_0.onDropHide, arg_13_0)
	arg_13_1._dropmaturefilter:AddOnValueChanged(arg_13_0.onMatureDropValueChange, arg_13_0)
	arg_13_1._btncirtterRare:AddClickListener(arg_13_0._btncirtterRareOnClick, arg_13_0)
	arg_13_0:initMatureDropFilter(arg_13_1._dropmaturefilter)
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0.animator:Play("open")

	arg_15_0.filterMO = CritterFilterModel.instance:generateFilterMO(arg_15_0.viewName)

	arg_15_0:_btnfoldOnClick()
	arg_15_0:refreshRareSort()
end

function var_0_0.refreshRareSort(arg_16_0)
	local var_16_0 = PlayerCardCritterPlaceListModel.instance:getIsSortByRareAscend() and 1 or -1

	transformhelper.setLocalScale(arg_16_0._critterView1._transcritterRareArrow, 1, var_16_0, 1)
	transformhelper.setLocalScale(arg_16_0._critterView2._transcritterRareArrow, 1, var_16_0, 1)
end

function var_0_0._btncirtterRareOnClick(arg_17_0)
	local var_17_0 = PlayerCardCritterPlaceListModel.instance:getIsSortByRareAscend()

	PlayerCardCritterPlaceListModel.instance:setIsSortByRareAscend(not var_17_0)
	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(arg_17_0.filterMO)
	arg_17_0:refreshRareSort()
end

function var_0_0._onRefreshCritter(arg_18_0)
	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(arg_18_0.filterMO)
end

function var_0_0.onClose(arg_19_0)
	PlayerCardCritterPlaceListModel.instance:clearData()
	arg_19_0.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseCritterView)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0:_critterViewOnDestroy(arg_20_0._critterView1)
	arg_20_0:_critterViewOnDestroy(arg_20_0._critterView2)
end

function var_0_0._critterViewOnDestroy(arg_21_0, arg_21_1)
	if arg_21_1.dropExtend then
		arg_21_1.dropExtend:dispose()
	end

	if arg_21_1._btncirtterRare then
		arg_21_1._btncirtterRare:RemoveClickListener()
	end

	if arg_21_1._dropmaturefilter then
		arg_21_1._dropmaturefilter:RemoveOnValueChanged()
	end
end

return var_0_0

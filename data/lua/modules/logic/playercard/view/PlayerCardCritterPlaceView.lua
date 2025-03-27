module("modules.logic.playercard.view.PlayerCardCritterPlaceView", package.seeall)

slot0 = class("PlayerCardCritterPlaceView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocritterview1 = gohelper.findChild(slot0.viewGO, "#go_critterview1")
	slot0._btnunfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critterview1/critterscroll/#btn_unfold")
	slot0._gocritterview2 = gohelper.findChild(slot0.viewGO, "#go_critterview2")
	slot0._btnfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critterview2/critterscroll/#btn_fold")
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critterview1/#btn_close")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critterview2/#btn_close")
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnunfold:AddClickListener(slot0._btnunfoldOnClick, slot0)
	slot0._btnfold:AddClickListener(slot0._btnfoldOnClick, slot0, true)
	slot0._btnclose1:AddClickListener(slot0.closeThis, slot0, true)
	slot0._btnclose2:AddClickListener(slot0.closeThis, slot0, true)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectCritter, slot0._onRefreshCritter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnunfold:RemoveClickListener()
	slot0._btnfold:RemoveClickListener()
	slot0._btnclose1:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
end

function slot0._btnunfoldOnClick(slot0)
	slot0._isFold = false
	slot0._canvasGroup1.blocksRaycasts = false
	slot0._canvasGroup2.blocksRaycasts = true
	slot0.currentScrollView = slot0._critterView2
	slot0._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	slot0._critterView2.scrollCritter.verticalNormalizedPosition = 1

	slot0:playAnim("switchup")
	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(slot0.filterMO)

	slot0._scrollRect = slot0._critterView2.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function slot0._btnfoldOnClick(slot0, slot1)
	slot0._isFold = true
	slot0._canvasGroup1.blocksRaycasts = true
	slot0._canvasGroup2.blocksRaycasts = false
	slot0.currentScrollView = slot0._critterView1
	slot0._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	slot0._critterView2.scrollCritter.verticalNormalizedPosition = 1

	if slot1 then
		slot0:playAnim("switchdown")
	end

	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(slot0.filterMO)

	slot0._scrollRect = slot0._critterView1.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function slot0._editableInitView(slot0)
	slot0._canvasGroup1 = slot0._gocritterview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._canvasGroup2 = slot0._gocritterview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._critterView1 = slot0:getUserDataTb_()
	slot0._critterView2 = slot0:getUserDataTb_()

	slot0:initCritterView(slot0._critterView1, slot0._gocritterview1, 1)
	slot0:initCritterView(slot0._critterView2, slot0._gocritterview2, 2)

	slot0.currentScrollView = slot0._critterView1
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.initMatureDropFilter(slot0, slot1)
	slot0._filterTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._filterTypeList) do
		table.insert(slot2, luaLang(CritterEnum.MatureFilterTypeName[slot7]))
	end

	slot1:ClearOptions()
	slot1:AddOptions(slot2)
end

function slot0.playAnim(slot0, slot1)
	slot0.animator.enabled = true

	slot0.animator:Play(slot1)
end

function slot0.onDropShow(slot0)
	transformhelper.setLocalScale(slot0._critterView1._transmatureDroparrow, 1, 1, 1)
	transformhelper.setLocalScale(slot0._critterView2._transmatureDroparrow, 1, 1, 1)
end

function slot0.onMatureDropValueChange(slot0, slot1)
	slot0:_refreshDropCareer(slot0._critterView1._dropmaturefilter, slot1)
	slot0:_refreshDropCareer(slot0._critterView2._dropmaturefilter, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	PlayerCardCritterPlaceListModel.instance:selectMatureFilterType(slot0._filterTypeList and slot0._filterTypeList[slot1 + 1], slot0.filterMO)
end

function slot0._refreshDropCareer(slot0, slot1, slot2)
	slot1:SetValue(slot2)
end

function slot0.onDropHide(slot0)
	transformhelper.setLocalScale(slot0._critterView1._transmatureDroparrow, 1, -1, 1)
	transformhelper.setLocalScale(slot0._critterView2._transmatureDroparrow, 1, -1, 1)
end

function slot0.initCritterView(slot0, slot1, slot2, slot3)
	slot1._btncirtterRare = gohelper.findChildButtonWithAudio(slot2, "crittersort/#btn_cirtterRare")
	slot1._transcritterRareArrow = gohelper.findChild(slot2, "crittersort/#btn_cirtterRare/selected/txt/arrow").transform
	slot1._dropmaturefilter = gohelper.findChildDropdown(slot2, "crittersort/#drop_mature")
	slot1._transmatureDroparrow = gohelper.findChild(slot2, "crittersort/#drop_mature/#go_arrow").transform
	slot1.scrollCritter = gohelper.findChildScrollRect(slot2, "critterscroll")
	slot1.sortMoodItem = slot0:getUserDataTb_()
	slot1.sortRareItem = slot0:getUserDataTb_()
	slot1.dropExtend = DropDownExtend.Get(slot1._dropmaturefilter.gameObject)

	slot1.dropExtend:init(slot0.onDropShow, slot0.onDropHide, slot0)
	slot1._dropmaturefilter:AddOnValueChanged(slot0.onMatureDropValueChange, slot0)
	slot1._btncirtterRare:AddClickListener(slot0._btncirtterRareOnClick, slot0)
	slot0:initMatureDropFilter(slot1._dropmaturefilter)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.animator:Play("open")

	slot0.filterMO = CritterFilterModel.instance:generateFilterMO(slot0.viewName)

	slot0:_btnfoldOnClick()
	slot0:refreshRareSort()
end

function slot0.refreshRareSort(slot0)
	slot2 = PlayerCardCritterPlaceListModel.instance:getIsSortByRareAscend() and 1 or -1

	transformhelper.setLocalScale(slot0._critterView1._transcritterRareArrow, 1, slot2, 1)
	transformhelper.setLocalScale(slot0._critterView2._transcritterRareArrow, 1, slot2, 1)
end

function slot0._btncirtterRareOnClick(slot0)
	PlayerCardCritterPlaceListModel.instance:setIsSortByRareAscend(not PlayerCardCritterPlaceListModel.instance:getIsSortByRareAscend())
	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(slot0.filterMO)
	slot0:refreshRareSort()
end

function slot0._onRefreshCritter(slot0)
	PlayerCardCritterPlaceListModel.instance:setPlayerCardCritterList(slot0.filterMO)
end

function slot0.onClose(slot0)
	PlayerCardCritterPlaceListModel.instance:clearData()
	slot0.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseCritterView)
end

function slot0.onDestroyView(slot0)
	slot0:_critterViewOnDestroy(slot0._critterView1)
	slot0:_critterViewOnDestroy(slot0._critterView2)
end

function slot0._critterViewOnDestroy(slot0, slot1)
	if slot1.dropExtend then
		slot1.dropExtend:dispose()
	end

	if slot1._btncirtterRare then
		slot1._btncirtterRare:RemoveClickListener()
	end

	if slot1._dropmaturefilter then
		slot1._dropmaturefilter:RemoveOnValueChanged()
	end
end

return slot0

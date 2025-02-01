module("modules.logic.room.view.backpack.RoomCritterDecomposeView", package.seeall)

slot0 = class("RoomCritterDecomposeView", BaseView)
slot1 = "DecomposeAnimKey"
slot2 = 0.2
slot3 = 0.5
slot4 = 0.9

function slot0.onInitView(slot0)
	slot0._btncirtterRare = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_critterSort/#btn_cirtterRare")
	slot0._dropmaturefilter = gohelper.findChildDropdown(slot0.viewGO, "left_container/#go_critterSort/#drop_mature")
	slot0._transmatureDroparrow = gohelper.findChild(slot0.viewGO, "left_container/#go_critterSort/#drop_mature/#go_arrow").transform
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_critterSort/#btn_filter")
	slot0._gonotfilter = gohelper.findChild(slot0.viewGO, "left_container/#go_critterSort/#btn_filter/#go_notfilter")
	slot0._gofilter = gohelper.findChild(slot0.viewGO, "left_container/#go_critterSort/#btn_filter/#go_filter")
	slot0._dropRareFilter = gohelper.findChildDropdown(slot0.viewGO, "left_container/#go_cost/#drop_filter")
	slot0._btnfastadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	slot0._txtselectNum = gohelper.findChildText(slot0.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "left_container/#go_empty")
	slot0._btnclear = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/go_clear/#btn_clear")
	slot0._simageresultItemIcon = gohelper.findChildSingleImage(slot0.viewGO, "right_container/frame/#simage_resultIcon")
	slot0._txtresultItemName = gohelper.findChildText(slot0.viewGO, "right_container/#txt_resultName")
	slot0._txtResultCount = gohelper.findChildText(slot0.viewGO, "right_container/#txt_count")
	slot0._btndecompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "right_container/#btn_decompose")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncirtterRare:AddClickListener(slot0._btncirtterRareOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btnfastadd:AddClickListener(slot0._btnfastaddOnClick, slot0)
	slot0._btnclear:AddClickListener(slot0._btnclearOnClick, slot0)
	slot0._btndecompose:AddClickListener(slot0._btndecomposeOnClick, slot0)
	slot0._dropmaturefilter:AddOnValueChanged(slot0.onMatureDropValueChange, slot0)
	slot0._dropRareFilter:AddOnValueChanged(slot0.onRareDropValueChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0.onCritterFilterTypeChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, slot0.onCritterDecomposeSelectChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterChangeSort, slot0.onCritterSortChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncirtterRare:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
	slot0._btnfastadd:RemoveClickListener()
	slot0._btnclear:RemoveClickListener()
	slot0._btndecompose:RemoveClickListener()
	slot0._dropmaturefilter:RemoveOnValueChanged()
	slot0._dropRareFilter:RemoveOnValueChanged()
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0.onCritterFilterTypeChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, slot0.onCritterDecomposeSelectChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeSort, slot0.onCritterSortChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenView, slot0)
end

function slot0._btncirtterRareOnClick(slot0)
	RoomCritterDecomposeListModel.instance:setIsSortByRareAscend(not RoomCritterDecomposeListModel.instance:getIsSortByRareAscend())
end

function slot0._btnfilterOnClick(slot0)
	CritterController.instance:openCritterFilterView({
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}, slot0.viewName)
end

function slot0._btnfastaddOnClick(slot0)
	RoomCritterDecomposeListModel.instance:fastAddCritter()
end

function slot0._btnclearOnClick(slot0)
	RoomCritterDecomposeListModel.instance:clearSelectedCritter()
end

function slot0._btndecomposeOnClick(slot0)
	if RoomCritterDecomposeListModel.instance:getSelectCount() <= 0 then
		return
	end

	if not RoomCritterDecomposeListModel.instance:checkDecomposeCountLimit() then
		GameFacade.showToast(ToastEnum.CritterDecomposeLimitCount)

		return
	end

	slot0.scrollRect.velocity = Vector2.zero

	UIBlockMgr.instance:startBlock(uv0)
	CritterController.instance:dispatchEvent(CritterEvent.BeforeDecomposeCritter)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_gplay_uihuan)
	TaskDispatcher.runDelay(slot0._sendCritterDecomposeRequest, slot0, uv1)
end

function slot0._sendCritterDecomposeRequest(slot0)
	UIBlockMgr.instance:endBlock(uv0)

	if RoomCritterDecomposeListModel.instance:getSelectCount() <= 0 then
		return
	end

	CritterRpc.instance:sendBanishCritterRequest(RoomCritterDecomposeListModel.instance:getSelectUIds())
end

function slot0.onMatureDropShow(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	transformhelper.setLocalScale(slot0._transmatureDroparrow, 1, 1, 1)
end

function slot0.onMatureDropValueChange(slot0, slot1)
	if not slot0.initMatureDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)

	slot2 = slot0.filterMatureTypeList and slot0.filterMatureTypeList[slot1 + 1]

	if RoomCritterDecomposeListModel.instance:getFilterMature() and slot3 == slot2 then
		return
	end

	RoomCritterDecomposeListModel.instance:setFilterMature(slot2)
	RoomCritterDecomposeListModel.instance:updateCritterList(slot0.filterMO)
	slot0:refreshCritterList()
end

function slot0.onMatureDropHide(slot0)
	transformhelper.setLocalScale(slot0._transmatureDroparrow, 1, -1, 1)
end

function slot0.onRareDropShow(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	transformhelper.setLocalScale(slot0._transRareDropArrow, 1, -1, 1)
end

function slot0.onRareDropValueChange(slot0, slot1)
	if not slot0.initRareDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	RoomCritterDecomposeListModel.instance:setFilterRare(slot0.filterRareList[slot1 + 1])
end

function slot0.onRareDropHide(slot0)
	transformhelper.setLocalScale(slot0._transRareDropArrow, 1, 1, 1)
end

function slot0.onCritterFilterTypeChange(slot0, slot1)
	if slot1 ~= slot0.viewName then
		return
	end

	RoomCritterDecomposeListModel.instance:updateCritterList(slot0.filterMO)
	slot0:refreshCritterList()
	slot0:refreshFilterBtn()
end

function slot0.onCritterDecomposeSelectChange(slot0)
	slot0:refreshSelectNum()
	slot0:refreshResultCount()
	slot0:refreshDecomposeBtn()
end

function slot0.onCritterSortChange(slot0)
	RoomCritterDecomposeListModel.instance:sortCritterList()
	slot0:refreshCritterList()
	slot0:refreshBtnItem(slot0.rareBtnItem)
end

function slot0.onOpenView(slot0, slot1)
	if slot1 ~= ViewName.CommonPropView then
		return
	end

	slot0:clearPerCount()
	RoomCritterDecomposeListModel.instance:updateCritterList(slot0.filterMO)
	slot0:refreshCritterList()
	slot0:refreshDecomposeBtn()
end

function slot0._editableInitView(slot0)
	slot0._goRareDrop = slot0._dropRareFilter.gameObject
	slot0._transRareDropArrow = gohelper.findChildComponent(slot0._goRareDrop, "Arrow", gohelper.Type_Transform)
	slot0.scrollRect = gohelper.findChild(slot0.viewGO, "left_container/#go_scrollcontainer/#scroll_critter"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0.goclear = gohelper.findChild(slot0.viewGO, "left_container/go_clear")
	slot0.txtCountAnimator = gohelper.findChildComponent(slot0.viewGO, "right_container/vx_count/ani", gohelper.Type_Animator)
	slot0.goDecomposeBtn = slot0._btndecompose.gameObject
	slot0.rareBtnItem = slot0:createSortBtnItem(slot0._btncirtterRare.gameObject)

	slot0:initMatureDropFilter()
	slot0:initRareFilterDrop()

	slot0.multipleChar = luaLang("multiple")

	slot0:clearVar()

	slot0.filterMO = CritterFilterModel.instance:generateFilterMO(slot0.viewName)

	RoomCritterDecomposeListModel.instance:updateCritterList(slot0.filterMO)
end

function slot0.createSortBtnItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goNormal = gohelper.findChild(slot2.go, "normal")
	slot2.goSelected = gohelper.findChild(slot2.go, "selected")
	slot2.arrowTr = gohelper.findChildComponent(slot2.go, "selected/txt/arrow", gohelper.Type_Transform)

	gohelper.setActive(slot2.goNormal, false)
	gohelper.setActive(slot2.goSelected, true)

	return slot2
end

function slot0.initMatureDropFilter(slot0)
	slot0.dropMatureExtend = DropDownExtend.Get(slot0._dropmaturefilter.gameObject)
	slot5 = slot0

	slot0.dropMatureExtend:init(slot0.onMatureDropShow, slot0.onMatureDropHide, slot5)

	slot0.filterMatureTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.filterMatureTypeList) do
		table.insert(slot1, luaLang(CritterEnum.MatureFilterTypeName[slot6]))
	end

	slot0._dropmaturefilter:ClearOptions()
	slot0._dropmaturefilter:AddOptions(slot1)

	slot0.initMatureDropDone = true
end

function slot0.initRareFilterDrop(slot0)
	slot0.dropRareExtend = DropDownExtend.Get(slot0._goRareDrop)
	slot5 = slot0

	slot0.dropRareExtend:init(slot0.onRareDropShow, slot0.onRareDropHide, slot5)

	slot1 = {}
	slot0.filterRareList = {}

	for slot5 = CritterEnum.CritterDecomposeMinRare, CritterEnum.CritterDecomposeMaxRare do
		table.insert(slot0.filterRareList, slot5)
		table.insert(slot1, GameUtil.getSubPlaceholderLuaLang(luaLang("critter_rare_filter"), {
			slot5 + 1
		}))
	end

	slot0._dropRareFilter:ClearOptions()
	slot0._dropRareFilter:AddOptions(slot1)

	slot0.initRareDropDone = true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:setResultIcon()
	slot0:refresh()
	gohelper.setActive(slot0._goempty, false)
	TaskDispatcher.runDelay(slot0.initCritterList, slot0, uv0)
end

function slot0.setResultIcon(slot0)
	slot1 = nil
	slot2 = ""

	if string.splitToNumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.DecomposeResult), "#") then
		slot5, slot1 = ItemModel.instance:getItemConfigAndIcon(slot4[1], slot4[2])
		slot2 = slot5.name
	end

	if not string.nilorempty(slot1) then
		slot0._simageresultItemIcon:LoadImage(slot1)
	end

	slot0._txtresultItemName.text = slot2
end

function slot0.initCritterList(slot0)
	slot0.viewContainer._views[2]._animationStartTime = Time.time

	slot0:refreshCritterList()
end

function slot0.refreshCritterList(slot0)
	RoomCritterDecomposeListModel.instance:refreshCritterShowList()
	gohelper.setActive(slot0._goempty, RoomCritterDecomposeListModel.instance:isEmpty())
end

function slot0.refresh(slot0)
	slot0:refreshTop()
	slot0:refreshSelectNum()
	slot0:refreshResultCount()
	slot0:refreshDecomposeBtn()
end

function slot0.refreshTop(slot0)
	slot0:refreshBtnItem(slot0.rareBtnItem)
	slot0:refreshFilterBtn()
end

function slot0.refreshBtnItem(slot0, slot1)
	transformhelper.setLocalScale(slot1.arrowTr, 1, RoomCritterDecomposeListModel.instance:getIsSortByRareAscend() and 1 or -1, 1)
end

function slot0.refreshFilterBtn(slot0)
	slot1 = slot0.filterMO:isFiltering()

	gohelper.setActive(slot0._gonotfilter, not slot1)
	gohelper.setActive(slot0._gofilter, slot1)
end

function slot0.refreshSelectNum(slot0)
	slot1 = RoomCritterDecomposeListModel.instance:getSelectCount()
	slot0._txtselectNum.text = string.format("<color=#ff7933>%s</color>/%s", slot1, CritterEnum.DecomposeMaxCount)

	gohelper.setActive(slot0.goclear, slot1 > 0)
end

function slot0.refreshResultCount(slot0)
	if slot0.preCount == RoomCritterDecomposeListModel.instance:getDecomposeCritterCount() then
		return
	end

	slot0.preCount = slot1

	slot0:killTween()

	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.preCount, slot1, uv0, slot0.frameCallback, slot0.finishCallback, slot0)

	slot0.txtCountAnimator:Play("vx_count", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_gplay_uihuan2)
end

function slot0.frameCallback(slot0, slot1)
	slot0:setTxtResultCount(math.ceil(slot1))
end

function slot0.setTxtResultCount(slot0, slot1)
	slot0._txtResultCount.text = string.format("%s%s", slot0.multipleChar, slot1)
end

function slot0.finishCallback(slot0)
	slot0.tweenId = nil
end

function slot0.refreshDecomposeBtn(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0.goDecomposeBtn, RoomCritterDecomposeListModel.instance:getSelectCount() < 1)
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.clearVar(slot0)
	slot0:clearPerCount()
	slot0:killTween()
end

function slot0.clearPerCount(slot0)
	slot0.preCount = 0

	slot0:setTxtResultCount(slot0.preCount)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.initCritterList, slot0)
	TaskDispatcher.cancelTask(slot0._sendCritterDecomposeRequest, slot0)
	UIBlockMgr.instance:endBlock(uv0)
	slot0:clearVar()
end

function slot0.onDestroyView(slot0)
	slot0._simageresultItemIcon:UnLoadImage()

	if slot0.dropMatureExtend then
		slot0.dropMatureExtend:dispose()
	end

	if slot0.dropRareExtend then
		slot0.dropRareExtend:dispose()
	end
end

return slot0

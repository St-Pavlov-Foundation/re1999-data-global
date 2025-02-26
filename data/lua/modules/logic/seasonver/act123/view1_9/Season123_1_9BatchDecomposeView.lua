module("modules.logic.seasonver.act123.view1_9.Season123_1_9BatchDecomposeView", package.seeall)

slot0 = class("Season123_1_9BatchDecomposeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goequipsort = gohelper.findChild(slot0.viewGO, "left_container/#go_equipsort")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_equipsort/#btn_rarerank")
	slot0._gorareRankSelect = gohelper.findChild(slot0.viewGO, "left_container/#go_equipsort/#btn_rarerank/#go_rareRankSelect")
	slot0._gorareRankNormal = gohelper.findChild(slot0.viewGO, "left_container/#go_equipsort/#btn_rarerank/#go_rareRankNormal")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_equipsort/#btn_filter")
	slot0._gonotfilter = gohelper.findChild(slot0.viewGO, "left_container/#go_equipsort/#btn_filter/#go_notfilter")
	slot0._gofilter = gohelper.findChild(slot0.viewGO, "left_container/#go_equipsort/#btn_filter/#go_filter")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "left_container/#go_cost")
	slot0._btnfastadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	slot0._txtmaxNum = gohelper.findChildText(slot0.viewGO, "left_container/#go_cost/txt_selected/#txt_num/#txt_maxNum")
	slot0._goscrollcontainer = gohelper.findChild(slot0.viewGO, "left_container/#go_scrollcontainer")
	slot0._scrollequip = gohelper.findChildScrollRect(slot0.viewGO, "left_container/#go_scrollcontainer/#scroll_equip")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "left_container/#go_empty")
	slot0._goclear = gohelper.findChild(slot0.viewGO, "left_container/#go_clear")
	slot0._btnclear = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#go_clear/#btn_clear")
	slot0._gocoinItem = gohelper.findChild(slot0.viewGO, "right_container/#go_coinItem")
	slot0._txtcoinName = gohelper.findChildText(slot0.viewGO, "right_container/#txt_coinName")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "right_container/#txt_count")
	slot0._btndecompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "right_container/#btn_decompose")
	slot0._golefttopbtns = gohelper.findChild(slot0.viewGO, "#go_lefttopbtns")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
	slot0._countAnim = gohelper.findChild(slot0.viewGO, "right_container/vx_count/ani"):GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btnfastadd:AddClickListener(slot0._btnfastaddOnClick, slot0)
	slot0._btnclear:AddClickListener(slot0._btnclearOnClick, slot0)
	slot0._btndecompose:AddClickListener(slot0._btndecomposeOnClick, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnResetBatchDecomposeView, slot0.resetDataUI, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnDecomposeItemSelect, slot0.onDecomposeItemClick, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
	slot0._btnfastadd:RemoveClickListener()
	slot0._btnclear:RemoveClickListener()
	slot0._btndecompose:RemoveClickListener()
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnResetBatchDecomposeView, slot0.resetDataUI, slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnDecomposeItemSelect, slot0.onDecomposeItemClick, slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, slot0.refreshUI, slot0)
end

slot0.maxOverCount = 4

function slot0._btnrarerankOnClick(slot0)
	slot0.isRareAscend = not slot0.isRareAscend

	Season123DecomposeModel.instance:setRareAscendState(slot0.isRareAscend)
	transformhelper.setLocalScale(slot0.rareArrowTrans, 1, slot0.isRareAscend and 1 or -1, 1)
	Season123DecomposeModel.instance:sortDecomposeItemListByRare()
end

function slot0._btnfilterOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Season123_1_9DecomposeFilterView)
end

function slot0._btnfastaddOnClick(slot0)
	Season123DecomposeModel.instance:selectOverPartItem()
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnRefleshDecomposeItemUI)
	slot0:refreshUI()

	if Season123DecomposeModel.instance.curSelectItemCount == 0 then
		GameFacade.showToast(ToastEnum.SeasonNotConformCardTip)

		return
	end
end

function slot0._btnclearOnClick(slot0)
	Season123EquipBookController.instance:clearItemSelectState()
	slot0:resetDataUI()
end

function slot0._btndecomposeOnClick(slot0)
	if Season123DecomposeModel.instance.curSelectItemCount == 0 then
		return
	end

	if Season123DecomposeModel.instance:isDecomposeItemUsedByHero(Season123DecomposeModel.instance.curSelectItemDict) then
		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, slot0.showDecomposeTip, nil, , slot0)
	else
		slot0:showDecomposeTip()
	end
end

function slot0.showDecomposeTip(slot0)
	slot1 = Season123DecomposeModel.instance.curSelectItemDict
	slot2 = GameUtil.getTabLen(slot1)
	slot3 = CurrencyConfig.instance:getCurrencyCo(slot0.coinId)

	for slot8, slot9 in pairs(slot1) do
		slot4 = 0 + Season123Config.instance:getSeasonEquipCo(slot9.itemId).decomposeGet
	end

	slot6 = nil

	GameFacade.showMessageBox(MessageBoxIdDefine.Season123DecomposeTip, MsgBoxEnum.BoxType.Yes_No, slot0.decomposeYesCallBack, nil, , slot0, nil, , string.format("<color=#AB5220>%s</color>", slot2), (not LangSettings.instance:isEn() or string.format("<color=#AB5220>%s %s</color>", slot4, slot3.name)) and string.format("<color=#AB5220>%s%s</color>", slot4, slot3.name))
end

function slot0.decomposeYesCallBack(slot0)
	slot0.selectlist = {}

	for slot5, slot6 in pairs(Season123DecomposeModel.instance.curSelectItemDict) do
		table.insert(slot0.selectlist, slot6.uid)
	end

	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnBatchDecomposeEffectPlay)
	UIBlockMgr.instance:startBlock("playBatchDecomposeEffect")
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_molu_button_display)
	TaskDispatcher.runDelay(slot0.sendDecomposeRequest, slot0, 1)
end

function slot0.sendDecomposeRequest(slot0)
	UIBlockMgr.instance:endBlock("playBatchDecomposeEffect")
	Activity123Rpc.instance:sendDecomposeAct123EquipRequest(slot0.actId, slot0.selectlist)
end

function slot0._dropFilterOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._editableInitView(slot0)
	slot0.rareArrowTrans = gohelper.findChild(slot0._gorareRankNormal, "txt/arrow"):GetComponent(gohelper.Type_Transform)
	slot0.isRareAscend = false

	Season123DecomposeModel.instance:setRareAscendState(slot0.isRareAscend)
	transformhelper.setLocalScale(slot0.rareArrowTrans, 1, slot0.isRareAscend and 1 or -1, 1)
	slot0:initDropFilter()
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.coinId = Season123Config.instance:getEquipItemCoin(slot0.actId, Activity123Enum.Const.EquipItemCoin)

	slot0:refreshUI()
end

function slot0.initDropFilter(slot0)
	slot0._dropFilter = gohelper.findChildDropdown(slot0.viewGO, "left_container/#go_cost/#drop_filter")
	slot0._txtLabel = gohelper.findChildText(slot0._dropFilter.gameObject, "Label")
	slot0._imageArrow = gohelper.findChildImage(slot0._dropFilter.gameObject, "Arrow")
	slot0._arrowTrans = slot0._imageArrow:GetComponent(gohelper.Type_Transform)

	slot0._dropFilter:AddOnValueChanged(slot0.dropFilterValueChanged, slot0)

	slot0._clickDropFilter = gohelper.getClick(slot0._dropFilter.gameObject)

	slot0._clickDropFilter:AddClickListener(slot0._dropFilterOnClick, slot0)

	slot0.dropFilterItemTab = {}
	slot0.dropFilterLabelList = {}
	slot1 = luaLang("common_all")
	slot0.dropFilterItemTab[0] = slot1

	table.insert(slot0.dropFilterLabelList, slot1)

	for slot5 = 1, uv0.maxOverCount do
		table.insert(slot0.dropFilterLabelList, string.format(luaLang("Season123DecomposeOverPart"), slot5))

		slot0.dropFilterItemTab[slot5] = string.format(luaLang("Season123DecomposeOverPart"), slot5)
	end

	slot0._dropFilter:ClearOptions()
	slot0._dropFilter:AddOptions(slot0.dropFilterLabelList)
	slot0._dropFilter:SetValue(1)

	slot0.dropShowHide = DropDownExtend.Get(slot0._dropFilter.gameObject)

	slot0.dropShowHide:init(slot0.onDropListShow, slot0.onDropListHide, slot0)
end

function slot0.refreshUI(slot0)
	slot0._txtcoinName.text = CurrencyConfig.instance:getCurrencyCo(slot0.coinId).name

	slot0:initCoinItem()

	slot0._txtcount.text = luaLang("multiple") .. slot0:getDecomposeCoin()

	ZProj.UGUIHelper.SetGrayscale(slot0._btndecompose.gameObject, Season123DecomposeModel.instance.curSelectItemCount == 0)

	slot0._txtmaxNum = string.format("/%s", Activity123Enum.maxDecomposeCount)
	slot0._txtnum.text = Activity123Enum.maxDecomposeCount <= slot2 and string.format("<color=#ff7933>%s</color>", slot2) or slot2

	gohelper.setActive(slot0._goclear, slot2 > 0)

	slot3 = Season123DecomposeModel.instance:hasSelectFilterItem()

	gohelper.setActive(slot0._gofilter, slot3)
	gohelper.setActive(slot0._gonotfilter, not slot3)
	gohelper.setActive(slot0._goempty, Season123DecomposeModel.instance:getCount() == 0)
end

function slot0.initCoinItem(slot0)
	if not slot0.cointItem then
		slot0.coinItem = IconMgr.instance:getCommonPropItemIcon(slot0._gocoinItem)

		slot0.coinItem:setMOValue(MaterialEnum.MaterialType.Currency, slot0.coinId, 1, nil, true)
		slot0.coinItem:isShowEquipAndItemCount(false)
		slot0.coinItem:setShowCountFlag(false)
		slot0.coinItem:hideEquipLvAndBreak(true)
		slot0.coinItem:setHideLvAndBreakFlag(true)
	end
end

function slot0.onDecomposeItemClick(slot0)
	slot0._countAnim:Play("vx_count", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_checkpoint_light_up)
	slot0:refreshUI()
end

function slot0.resetDataUI(slot0)
	slot0._txtcount.text = luaLang("multiple") .. 0
	slot0._txtnum.text = 0

	ZProj.UGUIHelper.SetGrayscale(slot0._btndecompose.gameObject, true)
	gohelper.setActive(slot0._goclear, false)
end

function slot0.getDecomposeCoin(slot0)
	for slot6, slot7 in pairs(Season123DecomposeModel.instance.curSelectItemDict) do
		if Season123Config.instance:getSeasonEquipCo(slot7.itemId) ~= nil then
			slot2 = 0 + slot8.decomposeGet
		end
	end

	return slot2
end

function slot0.dropFilterValueChanged(slot0, slot1)
	Season123DecomposeModel.instance:setCurOverPartSelectIndex(slot1)
end

function slot0.onDropListShow(slot0)
	transformhelper.setLocalScale(slot0._arrowTrans, 1, -1, 1)
end

function slot0.onDropListHide(slot0)
	transformhelper.setLocalScale(slot0._arrowTrans, 1, 1, 1)
end

function slot0.onClose(slot0)
	Season123DecomposeModel.instance._itemStartAnimTime = nil
end

function slot0.onDestroyView(slot0)
	Season123DecomposeModel.instance:clear()
	UIBlockMgr.instance:endBlock("playBatchDecomposeEffect")

	if slot0._dropFilter then
		slot0._dropFilter:RemoveOnValueChanged()

		slot0._dropFilter = nil
	end

	if slot0._clickDropFilter then
		slot0._clickDropFilter:RemoveClickListener()

		slot0._clickDropFilter = nil
	end
end

return slot0

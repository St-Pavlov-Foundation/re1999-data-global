module("modules.logic.seasonver.act123.view1_9.Season123_1_9BatchDecomposeView", package.seeall)

local var_0_0 = class("Season123_1_9BatchDecomposeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goequipsort = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_equipsort")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_rarerank")
	arg_1_0._gorareRankSelect = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_rarerank/#go_rareRankSelect")
	arg_1_0._gorareRankNormal = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_rarerank/#go_rareRankNormal")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_filter")
	arg_1_0._gonotfilter = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_filter/#go_notfilter")
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_equipsort/#btn_filter/#go_filter")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_cost")
	arg_1_0._btnfastadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	arg_1_0._txtmaxNum = gohelper.findChildText(arg_1_0.viewGO, "left_container/#go_cost/txt_selected/#txt_num/#txt_maxNum")
	arg_1_0._goscrollcontainer = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_scrollcontainer")
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "left_container/#go_scrollcontainer/#scroll_equip")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_empty")
	arg_1_0._goclear = gohelper.findChild(arg_1_0.viewGO, "left_container/#go_clear")
	arg_1_0._btnclear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#go_clear/#btn_clear")
	arg_1_0._gocoinItem = gohelper.findChild(arg_1_0.viewGO, "right_container/#go_coinItem")
	arg_1_0._txtcoinName = gohelper.findChildText(arg_1_0.viewGO, "right_container/#txt_coinName")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "right_container/#txt_count")
	arg_1_0._btndecompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#btn_decompose")
	arg_1_0._golefttopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_lefttopbtns")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._countAnim = gohelper.findChild(arg_1_0.viewGO, "right_container/vx_count/ani"):GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btnfastadd:AddClickListener(arg_2_0._btnfastaddOnClick, arg_2_0)
	arg_2_0._btnclear:AddClickListener(arg_2_0._btnclearOnClick, arg_2_0)
	arg_2_0._btndecompose:AddClickListener(arg_2_0._btndecomposeOnClick, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnResetBatchDecomposeView, arg_2_0.resetDataUI, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnDecomposeItemSelect, arg_2_0.onDecomposeItemClick, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btnfastadd:RemoveClickListener()
	arg_3_0._btnclear:RemoveClickListener()
	arg_3_0._btndecompose:RemoveClickListener()
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnResetBatchDecomposeView, arg_3_0.resetDataUI, arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnDecomposeItemSelect, arg_3_0.onDecomposeItemClick, arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, arg_3_0.refreshUI, arg_3_0)
end

var_0_0.maxOverCount = 4

function var_0_0._btnrarerankOnClick(arg_4_0)
	arg_4_0.isRareAscend = not arg_4_0.isRareAscend

	Season123DecomposeModel.instance:setRareAscendState(arg_4_0.isRareAscend)
	transformhelper.setLocalScale(arg_4_0.rareArrowTrans, 1, arg_4_0.isRareAscend and 1 or -1, 1)
	Season123DecomposeModel.instance:sortDecomposeItemListByRare()
end

function var_0_0._btnfilterOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.Season123_1_9DecomposeFilterView)
end

function var_0_0._btnfastaddOnClick(arg_6_0)
	Season123DecomposeModel.instance:selectOverPartItem()

	local var_6_0 = Season123DecomposeModel.instance.curSelectItemCount

	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnRefleshDecomposeItemUI)
	arg_6_0:refreshUI()

	if var_6_0 == 0 then
		GameFacade.showToast(ToastEnum.SeasonNotConformCardTip)

		return
	end
end

function var_0_0._btnclearOnClick(arg_7_0)
	Season123EquipBookController.instance:clearItemSelectState()
	arg_7_0:resetDataUI()
end

function var_0_0._btndecomposeOnClick(arg_8_0)
	if Season123DecomposeModel.instance.curSelectItemCount == 0 then
		return
	end

	local var_8_0 = Season123DecomposeModel.instance.curSelectItemDict

	if Season123DecomposeModel.instance:isDecomposeItemUsedByHero(var_8_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, arg_8_0.showDecomposeTip, nil, nil, arg_8_0)
	else
		arg_8_0:showDecomposeTip()
	end
end

function var_0_0.showDecomposeTip(arg_9_0)
	local var_9_0 = Season123DecomposeModel.instance.curSelectItemDict
	local var_9_1 = GameUtil.getTabLen(var_9_0)
	local var_9_2 = CurrencyConfig.instance:getCurrencyCo(arg_9_0.coinId)
	local var_9_3 = 0

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		var_9_3 = var_9_3 + Season123Config.instance:getSeasonEquipCo(iter_9_1.itemId).decomposeGet
	end

	local var_9_4 = string.format("<color=#AB5220>%s</color>", var_9_1)
	local var_9_5

	if LangSettings.instance:isEn() then
		var_9_5 = string.format("<color=#AB5220>%s %s</color>", var_9_3, var_9_2.name)
	else
		var_9_5 = string.format("<color=#AB5220>%s%s</color>", var_9_3, var_9_2.name)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Season123DecomposeTip, MsgBoxEnum.BoxType.Yes_No, arg_9_0.decomposeYesCallBack, nil, nil, arg_9_0, nil, nil, var_9_4, var_9_5)
end

function var_0_0.decomposeYesCallBack(arg_10_0)
	local var_10_0 = Season123DecomposeModel.instance.curSelectItemDict

	arg_10_0.selectlist = {}

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		table.insert(arg_10_0.selectlist, iter_10_1.uid)
	end

	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnBatchDecomposeEffectPlay)
	UIBlockMgr.instance:startBlock("playBatchDecomposeEffect")
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_molu_button_display)
	TaskDispatcher.runDelay(arg_10_0.sendDecomposeRequest, arg_10_0, 1)
end

function var_0_0.sendDecomposeRequest(arg_11_0)
	UIBlockMgr.instance:endBlock("playBatchDecomposeEffect")
	Activity123Rpc.instance:sendDecomposeAct123EquipRequest(arg_11_0.actId, arg_11_0.selectlist)
end

function var_0_0._dropFilterOnClick(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0.rareArrowTrans = gohelper.findChild(arg_13_0._gorareRankNormal, "txt/arrow"):GetComponent(gohelper.Type_Transform)
	arg_13_0.isRareAscend = false

	Season123DecomposeModel.instance:setRareAscendState(arg_13_0.isRareAscend)
	transformhelper.setLocalScale(arg_13_0.rareArrowTrans, 1, arg_13_0.isRareAscend and 1 or -1, 1)
	arg_13_0:initDropFilter()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0.actId = arg_14_0.viewParam.actId
	arg_14_0.coinId = Season123Config.instance:getEquipItemCoin(arg_14_0.actId, Activity123Enum.Const.EquipItemCoin)

	arg_14_0:refreshUI()
end

function var_0_0.initDropFilter(arg_15_0)
	arg_15_0._dropFilter = gohelper.findChildDropdown(arg_15_0.viewGO, "left_container/#go_cost/#drop_filter")
	arg_15_0._txtLabel = gohelper.findChildText(arg_15_0._dropFilter.gameObject, "Label")
	arg_15_0._imageArrow = gohelper.findChildImage(arg_15_0._dropFilter.gameObject, "Arrow")
	arg_15_0._arrowTrans = arg_15_0._imageArrow:GetComponent(gohelper.Type_Transform)

	arg_15_0._dropFilter:AddOnValueChanged(arg_15_0.dropFilterValueChanged, arg_15_0)

	arg_15_0._clickDropFilter = gohelper.getClick(arg_15_0._dropFilter.gameObject)

	arg_15_0._clickDropFilter:AddClickListener(arg_15_0._dropFilterOnClick, arg_15_0)

	arg_15_0.dropFilterItemTab = {}
	arg_15_0.dropFilterLabelList = {}

	local var_15_0 = luaLang("common_all")

	arg_15_0.dropFilterItemTab[0] = var_15_0

	table.insert(arg_15_0.dropFilterLabelList, var_15_0)

	for iter_15_0 = 1, var_0_0.maxOverCount do
		table.insert(arg_15_0.dropFilterLabelList, string.format(luaLang("Season123DecomposeOverPart"), iter_15_0))

		arg_15_0.dropFilterItemTab[iter_15_0] = string.format(luaLang("Season123DecomposeOverPart"), iter_15_0)
	end

	arg_15_0._dropFilter:ClearOptions()
	arg_15_0._dropFilter:AddOptions(arg_15_0.dropFilterLabelList)
	arg_15_0._dropFilter:SetValue(1)

	arg_15_0.dropShowHide = DropDownExtend.Get(arg_15_0._dropFilter.gameObject)

	arg_15_0.dropShowHide:init(arg_15_0.onDropListShow, arg_15_0.onDropListHide, arg_15_0)
end

function var_0_0.refreshUI(arg_16_0)
	local var_16_0 = CurrencyConfig.instance:getCurrencyCo(arg_16_0.coinId)

	arg_16_0._txtcoinName.text = var_16_0.name

	arg_16_0:initCoinItem()

	arg_16_0._txtcount.text = luaLang("multiple") .. arg_16_0:getDecomposeCoin()

	local var_16_1 = Season123DecomposeModel.instance.curSelectItemCount

	ZProj.UGUIHelper.SetGrayscale(arg_16_0._btndecompose.gameObject, var_16_1 == 0)

	arg_16_0._txtmaxNum = string.format("/%s", Activity123Enum.maxDecomposeCount)
	arg_16_0._txtnum.text = var_16_1 >= Activity123Enum.maxDecomposeCount and string.format("<color=#ff7933>%s</color>", var_16_1) or var_16_1

	gohelper.setActive(arg_16_0._goclear, var_16_1 > 0)

	local var_16_2 = Season123DecomposeModel.instance:hasSelectFilterItem()

	gohelper.setActive(arg_16_0._gofilter, var_16_2)
	gohelper.setActive(arg_16_0._gonotfilter, not var_16_2)
	gohelper.setActive(arg_16_0._goempty, Season123DecomposeModel.instance:getCount() == 0)
end

function var_0_0.initCoinItem(arg_17_0)
	if not arg_17_0.cointItem then
		arg_17_0.coinItem = IconMgr.instance:getCommonPropItemIcon(arg_17_0._gocoinItem)

		arg_17_0.coinItem:setMOValue(MaterialEnum.MaterialType.Currency, arg_17_0.coinId, 1, nil, true)
		arg_17_0.coinItem:isShowEquipAndItemCount(false)
		arg_17_0.coinItem:setShowCountFlag(false)
		arg_17_0.coinItem:hideEquipLvAndBreak(true)
		arg_17_0.coinItem:setHideLvAndBreakFlag(true)
	end
end

function var_0_0.onDecomposeItemClick(arg_18_0)
	arg_18_0._countAnim:Play("vx_count", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_checkpoint_light_up)
	arg_18_0:refreshUI()
end

function var_0_0.resetDataUI(arg_19_0)
	arg_19_0._txtcount.text = luaLang("multiple") .. 0
	arg_19_0._txtnum.text = 0

	ZProj.UGUIHelper.SetGrayscale(arg_19_0._btndecompose.gameObject, true)
	gohelper.setActive(arg_19_0._goclear, false)
end

function var_0_0.getDecomposeCoin(arg_20_0)
	local var_20_0 = Season123DecomposeModel.instance.curSelectItemDict
	local var_20_1 = 0

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		local var_20_2 = Season123Config.instance:getSeasonEquipCo(iter_20_1.itemId)

		if var_20_2 ~= nil then
			var_20_1 = var_20_1 + var_20_2.decomposeGet
		end
	end

	return var_20_1
end

function var_0_0.dropFilterValueChanged(arg_21_0, arg_21_1)
	Season123DecomposeModel.instance:setCurOverPartSelectIndex(arg_21_1)
end

function var_0_0.onDropListShow(arg_22_0)
	transformhelper.setLocalScale(arg_22_0._arrowTrans, 1, -1, 1)
end

function var_0_0.onDropListHide(arg_23_0)
	transformhelper.setLocalScale(arg_23_0._arrowTrans, 1, 1, 1)
end

function var_0_0.onClose(arg_24_0)
	Season123DecomposeModel.instance._itemStartAnimTime = nil
end

function var_0_0.onDestroyView(arg_25_0)
	Season123DecomposeModel.instance:clear()
	UIBlockMgr.instance:endBlock("playBatchDecomposeEffect")

	if arg_25_0._dropFilter then
		arg_25_0._dropFilter:RemoveOnValueChanged()

		arg_25_0._dropFilter = nil
	end

	if arg_25_0._clickDropFilter then
		arg_25_0._clickDropFilter:RemoveClickListener()

		arg_25_0._clickDropFilter = nil
	end
end

return var_0_0

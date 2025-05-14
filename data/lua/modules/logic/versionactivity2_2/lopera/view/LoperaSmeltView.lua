module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltView", package.seeall)

local var_0_0 = class("LoperaSmeltView", BaseView)
local var_0_1 = LoperaEnum.MapCfgIdx
local var_0_2 = VersionActivity2_2Enum.ActivityId.Lopera
local var_0_3 = "<color=#21631a>%s</color>"
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 0.3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnType1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Tab/Tab1")
	arg_1_0._btnType2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Tab/Tab2")
	arg_1_0._btnType3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Tab/Tab3")
	arg_1_0._goReddot1 = gohelper.findChild(arg_1_0.viewGO, "Right/Tab/Tab1/#go_reddot")
	arg_1_0._goReddot2 = gohelper.findChild(arg_1_0.viewGO, "Right/Tab/Tab2/#go_reddot")
	arg_1_0._goReddot3 = gohelper.findChild(arg_1_0.viewGO, "Right/Tab/Tab3/#go_reddot")
	arg_1_0._btnSmelt = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Smelt")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_List/Viewport/Content/#go_Item")
	arg_1_0._goItemRoot = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_List/Viewport/Content")
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_1_0._goItem, false)

	arg_1_0._tipsGo = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Tips")
	arg_1_0._tipsItemIcon = gohelper.findChildImage(arg_1_0._tipsGo, "image_TipsBG/#image_Icon")
	arg_1_0._tipsValueText = gohelper.findChildText(arg_1_0._tipsGo, "image_TipsBG/#txt_PropDescr")
	arg_1_0._tipsTypeText = gohelper.findChildText(arg_1_0._tipsGo, "image_TipsBG/#txt_PropType")
	arg_1_0._tipsNameText = gohelper.findChildText(arg_1_0._tipsGo, "image_TipsBG/#txt_Prop")
	arg_1_0._goFullCloseBg = gohelper.findChild(arg_1_0.viewGO, "#btn_TipsClose")
	arg_1_0._fullCloseBg = gohelper.findChildButton(arg_1_0.viewGO, "#btn_TipsClose")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSmelt:AddClickListener(arg_2_0._onClickSmelt, arg_2_0)
	arg_2_0._btnType1:AddClickListener(arg_2_0._onTabChange, arg_2_0, 1)
	arg_2_0._btnType2:AddClickListener(arg_2_0._onTabChange, arg_2_0, 2)
	arg_2_0._btnType3:AddClickListener(arg_2_0._onTabChange, arg_2_0, 3)
	arg_2_0._fullCloseBg:AddClickListener(arg_2_0._closeTipsBtnClick, arg_2_0)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.GoodItemClick, arg_2_0._onClickItem, arg_2_0)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.ComposeDone, arg_2_0._onSmeltResult, arg_2_0)

	arg_2_0._redDot1Comp = RedDotController.instance:addNotEventRedDot(arg_2_0._goReddot1, arg_2_0._showRedDot1, arg_2_0)
	arg_2_0._redDot2Comp = RedDotController.instance:addNotEventRedDot(arg_2_0._goReddot2, arg_2_0._showRedDot2, arg_2_0)
	arg_2_0._redDot3Comp = RedDotController.instance:addNotEventRedDot(arg_2_0._goReddot3, arg_2_0._showRedDot3, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSmelt:RemoveClickListener()
	arg_3_0._btnType1:RemoveClickListener()
	arg_3_0._btnType2:RemoveClickListener()
	arg_3_0._btnType3:RemoveClickListener()
	arg_3_0._fullCloseBg:RemoveClickListener()
end

function var_0_0._onClickSmelt(arg_4_0)
	if LoperaController.instance:checkCanCompose(arg_4_0._selectTabIdx) then
		LoperaController.instance:composeItem(arg_4_0._selectTabIdx)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_alchemy_success)
	else
		GameFacade.showToast(ToastEnum.CharacterExSkill)
	end
end

function var_0_0._onTabChange(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._selectTabIdx == arg_5_1 then
		return
	end

	arg_5_0._selectTabIdx = arg_5_1

	if not arg_5_2 then
		arg_5_0._viewAnimator:Play(UIAnimationName.Switch, 0, 0)
	end

	TaskDispatcher.runDelay(arg_5_0._doTabChangeRefresh, arg_5_0, var_0_6)
end

function var_0_0._doTabChangeRefresh(arg_6_0)
	arg_6_0:refreshTabItems(arg_6_0._selectTabIdx)
	arg_6_0:refreshTabMaterials(arg_6_0._selectTabIdx)
	arg_6_0:refreshTabProducts(arg_6_0._selectTabIdx)
	arg_6_0:_refreshBtnState()
end

function var_0_0._closeTipsBtnClick(arg_7_0)
	gohelper.setActive(arg_7_0._tipsGo, false)
	gohelper.setActive(arg_7_0._goFullCloseBg, false)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._tabStateGroup = {}

	for iter_8_0 = 1, 3 do
		arg_8_0._tabStateGroup[iter_8_0] = arg_8_0:getUserDataTb_()
		arg_8_0._tabStateGroup[iter_8_0].unSelect = gohelper.findChild(arg_8_0.viewGO, string.format("Right/Tab/Tab%s/#go_UnSelect", iter_8_0))
		arg_8_0._tabStateGroup[iter_8_0].select = gohelper.findChild(arg_8_0.viewGO, string.format("Right/Tab/Tab%s/#go_Selected", iter_8_0))
		arg_8_0._tabStateGroup[iter_8_0].txtUnSelect = gohelper.findChildText(arg_8_0.viewGO, string.format("Right/Tab/Tab%s/#go_UnSelect/#txt_Tab", iter_8_0))
		arg_8_0._tabStateGroup[iter_8_0].txtSelected = gohelper.findChildText(arg_8_0.viewGO, string.format("Right/Tab/Tab%s/#go_Selected/#txt_Tab", iter_8_0))
	end
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam

	arg_9_0._selectTabIdx = -1
	arg_9_0._defaultTab = 1

	arg_9_0:_onTabChange(arg_9_0._defaultTab, true)
	arg_9_0:_refreshTabsTtile()
	arg_9_0:refreshAllItems()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_uimIn_details_open)
end

function var_0_0.onExitGame(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.refreshView(arg_11_0)
	arg_11_0:refreshTabItems(arg_11_0._selectTabIdx)
	arg_11_0:refreshTabMaterials(arg_11_0._selectTabIdx)
	arg_11_0:refreshTabProducts(arg_11_0._selectTabIdx)
	arg_11_0:refreshAllItems()
	arg_11_0:_refreshRedDot()
end

function var_0_0.refreshAllItems(arg_12_0)
	arg_12_0._itemCfgList = Activity168Config.instance:getGameItemListCfg(var_0_2)

	table.sort(arg_12_0._itemCfgList, arg_12_0._itemListSort)
	gohelper.CreateObjList(arg_12_0, arg_12_0._createItem, arg_12_0._itemCfgList, arg_12_0._goItemRoot, arg_12_0._goItem, LoperaGoodsItem)
end

function var_0_0._itemListSort(arg_13_0, arg_13_1)
	local var_13_0 = Activity168Model.instance:getItemCount(arg_13_0.itemId)
	local var_13_1 = Activity168Model.instance:getItemCount(arg_13_1.itemId)

	if var_13_0 == 0 and var_13_1 == 0 then
		return arg_13_0.itemId < arg_13_1.itemId
	elseif var_13_0 > 0 and var_13_1 == 0 then
		return true
	elseif var_13_0 == 0 and var_13_1 > 0 then
		return false
	elseif var_13_0 > 0 and var_13_1 > 0 then
		local var_13_2 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. arg_13_0.itemId, 0)
		local var_13_3 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. arg_13_1.itemId, 0)

		if var_13_2 == 1 and var_13_3 == 0 then
			return false
		end

		if var_13_2 == 0 and var_13_3 == 1 then
			return true
		end

		if var_13_2 == var_13_3 then
			return arg_13_0.itemId < arg_13_1.itemId
		end
	end
end

function var_0_0._refreshTabsTtile(arg_14_0)
	local var_14_0 = Activity168Config.instance:getComposeTypeList(VersionActivity2_2Enum.ActivityId.Lopera)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		arg_14_0._tabStateGroup[iter_14_0].txtUnSelect.text = iter_14_1.name
		arg_14_0._tabStateGroup[iter_14_0].txtSelected.text = iter_14_1.name
	end
end

function var_0_0.refreshTabItems(arg_15_0, arg_15_1)
	local var_15_0
	local var_15_1 = Activity168Config.instance:getComposeTypeList(var_0_2)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if iter_15_1.composeType == arg_15_1 then
			local var_15_2 = iter_15_1

			break
		end
	end
end

function var_0_0.refreshTabMaterials(arg_16_0, arg_16_1)
	local var_16_0
	local var_16_1 = Activity168Config.instance:getComposeTypeList(var_0_2)

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if iter_16_1.composeType == arg_16_1 then
			var_16_0 = iter_16_1

			break
		end
	end

	local var_16_2 = string.split(var_16_0.costItems, "|")

	for iter_16_2 = 1, var_0_4 do
		local var_16_3 = gohelper.findChild(arg_16_0.viewGO, string.format("Right/Prop/Prop%s/#go_Have", iter_16_2))
		local var_16_4 = gohelper.findChild(arg_16_0.viewGO, string.format("Right/Prop/Prop%s/#go_Empty", iter_16_2))
		local var_16_5 = iter_16_2 <= #var_16_2 and var_16_2[iter_16_2] or nil

		if var_16_5 then
			local var_16_6 = string.splitToNumber(var_16_5, "#")
			local var_16_7 = var_16_6[1]
			local var_16_8 = var_16_6[2]
			local var_16_9 = Activity168Config.instance:getGameItemCfg(var_0_2, var_16_7)
			local var_16_10 = gohelper.findChildImage(var_16_3, "#image_Icon")

			UISpriteSetMgr.instance:setLoperaItemSprite(var_16_10, var_16_9.icon, false)

			local var_16_11 = gohelper.findChildText(var_16_3, "#txt_PropName")
			local var_16_12 = gohelper.findChildText(var_16_3, "#txt_Num")
			local var_16_13 = Activity168Model.instance:getItemCount(var_16_7)

			var_16_11.text = var_16_9.name
			var_16_12.text = string.format(var_0_3, var_16_13) .. "/" .. var_16_8
		end

		gohelper.setActive(var_16_4, var_16_5 == nil)
		gohelper.setActive(var_16_3, var_16_5 ~= nil)
	end
end

function var_0_0.refreshTabProducts(arg_17_0, arg_17_1)
	local var_17_0
	local var_17_1 = Activity168Config.instance:getComposeTypeList(var_0_2)

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if iter_17_1.composeType == arg_17_1 then
			local var_17_2 = iter_17_1

			break
		end
	end

	local var_17_3 = Activity168Config.instance:getGameItemListCfg(var_0_2, arg_17_1)

	for iter_17_2 = 1, var_0_5 do
		local var_17_4 = gohelper.findChild(arg_17_0.viewGO, string.format("Right/Output/Prop%s/#go_Have", iter_17_2))
		local var_17_5 = gohelper.findChild(arg_17_0.viewGO, string.format("Right/Output/Prop%s/#go_Empty", iter_17_2))
		local var_17_6 = iter_17_2 <= #var_17_3 and var_17_3[iter_17_2] or nil

		if var_17_6 then
			local var_17_7 = gohelper.findChildImage(var_17_4, "#image_Icon")

			UISpriteSetMgr.instance:setLoperaItemSprite(var_17_7, var_17_6.icon, false)

			gohelper.findChildText(var_17_4, "#txt_PropName").text = var_17_6.name
		end

		gohelper.setActive(var_17_5, var_17_6 == nil)
		gohelper.setActive(var_17_4, var_17_6 ~= nil)
	end
end

function var_0_0._refreshGoodItemTips(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._itemCfgList[arg_18_1]

	arg_18_0._tipsValueText.text = var_18_0.desc

	local var_18_1 = Activity168Config.instance:getComposeTypeCfg(var_0_2, var_18_0.compostType)

	if var_18_1 then
		arg_18_0._tipsTypeText.text = var_18_1.name
	end

	gohelper.setActive(arg_18_0._tipsTypeText.gameObject, var_18_1 ~= nil)

	arg_18_0._tipsNameText.text = var_18_0.name

	UISpriteSetMgr.instance:setLoperaItemSprite(arg_18_0._tipsItemIcon, var_18_0.icon, false)
end

function var_0_0._refreshBtnState(arg_19_0)
	local var_19_0 = LoperaController.instance:checkCanCompose(arg_19_0._selectTabIdx)

	ZProj.UGUIHelper.SetGrayscale(arg_19_0._btnSmelt.gameObject, not var_19_0)

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._tabStateGroup) do
		gohelper.setActive(iter_19_1.select, iter_19_0 == arg_19_0._selectTabIdx)
		gohelper.setActive(iter_19_1.unSelect, iter_19_0 ~= arg_19_0._selectTabIdx)
	end
end

function var_0_0._createItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_2.itemId
	local var_20_1 = Activity168Model.instance:getItemCount(var_20_0)
	local var_20_2 = {}

	var_20_2.showNewFlag = true

	arg_20_1:onUpdateData(arg_20_2, var_20_1 and var_20_1 or 0, arg_20_3, var_20_2)
end

function var_0_0._onClickItem(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._tipsGo, true)
	gohelper.setActive(arg_21_0._goFullCloseBg, true)

	local var_21_0 = gohelper.findChild(arg_21_0._goItemRoot, arg_21_1)
	local var_21_1 = arg_21_0._tipsGo.transform

	var_21_1:SetParent(var_21_0.transform, true)
	recthelper.setAnchorX(var_21_1, 130)
	recthelper.setAnchorY(var_21_1, -30)
	var_21_1:SetParent(arg_21_0.viewGO.transform, true)
	arg_21_0:_refreshGoodItemTips(arg_21_1)
end

function var_0_0._onSmeltResult(arg_22_0)
	LoperaController.instance:openSmeltResultView()
	arg_22_0:refreshView()
	arg_22_0:_refreshBtnState()
	arg_22_0:_refreshRedDot()
end

function var_0_0._showRedDot1(arg_23_0)
	return arg_23_0:_checkShowRedDot(1)
end

function var_0_0._showRedDot2(arg_24_0)
	return arg_24_0:_checkShowRedDot(2)
end

function var_0_0._showRedDot3(arg_25_0)
	return arg_25_0:_checkShowRedDot(3)
end

function var_0_0._checkShowRedDot(arg_26_0, arg_26_1)
	return LoperaController.instance:checkCanCompose(arg_26_1)
end

function var_0_0._refreshRedDot(arg_27_0)
	if arg_27_0._redDot1Comp then
		arg_27_0._redDot1Comp:refreshRedDot()
	end

	if arg_27_0._redDot2Comp then
		arg_27_0._redDot2Comp:refreshRedDot()
	end

	if arg_27_0._redDot3Comp then
		arg_27_0._redDot3Comp:refreshRedDot()
	end
end

function var_0_0.onDestroyView(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._doTabChangeRefresh, arg_28_0)
end

return var_0_0

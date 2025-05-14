module("modules.logic.rouge.view.RougeCollectionTipView", package.seeall)

local var_0_0 = class("RougeCollectionTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_root")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_root/anim/#simage_icon")
	arg_1_0._txtcollectionname = gohelper.findChildText(arg_1_0.viewGO, "#go_root/anim/#txt_collectionname")
	arg_1_0._scrollcollectiondesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_root/anim/#scroll_collectiondesc")
	arg_1_0._godescContent = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#scroll_collectiondesc/Viewport/#go_descContent")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	arg_1_0._gotags = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#go_tags")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#go_tags/#go_tagitem")
	arg_1_0._goextratags = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/tags/#go_extratags")
	arg_1_0._goextratagitem = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/tags/#go_extratags/#go_extratagitem")
	arg_1_0._goholetool = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#go_holetool")
	arg_1_0._goholeitem = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#go_holetool/#go_holeitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goshapecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#go_shapecontainer")
	arg_1_0._goshapecell = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#go_shapecontainer/#go_shapecell")
	arg_1_0._btnunequip = gohelper.findChildButton(arg_1_0.viewGO, "#go_root/anim/#btn_unequip")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#go_tips")
	arg_1_0._gotagdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_root/anim/#go_tips/#txt_tagitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnunequip:AddClickListener(arg_2_0._btnunequipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnunequip:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnunequipOnClick(arg_5_0)
	local var_5_0 = arg_5_0.viewParam and arg_5_0.viewParam.collectionId

	RougeCollectionChessController.instance:removeCollectionFromSlotArea(var_5_0)
	arg_5_0:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UnEquipCollection)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, arg_6_0.updateCollectionEnchantInfo, arg_6_0)
	arg_6_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.SetCollectionTipViewInteractable, arg_6_0.setViewInteractable, arg_6_0)
	arg_6_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateCollectionAttr, arg_6_0.updateCollectionAttr, arg_6_0)
	arg_6_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_6_0._onSwitchCollectionInfoType, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0.onCloseViewCallBack, arg_6_0)

	arg_6_0._cellModelTab = arg_6_0:getUserDataTb_()
	arg_6_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO)
	arg_6_0._hooltoolCanvasGroup = gohelper.onceAddComponent(arg_6_0._goholetool, gohelper.Type_CanvasGroup)
	arg_6_0._rootCanvasGroup = gohelper.onceAddComponent(arg_6_0._goroot, gohelper.Type_CanvasGroup)
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_1)
	arg_7_0:refreshCollectionInfos()
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refreshCollectionInfos()
end

function var_0_0.refreshCollectionInfos(arg_9_0)
	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.collectionId
	local var_9_1 = arg_9_0.viewParam and arg_9_0.viewParam.collectionCfgId
	local var_9_2 = arg_9_0:getViewPos()

	arg_9_0._interactable = true
	arg_9_0._useCloseBtn = true

	if arg_9_0.viewParam and arg_9_0.viewParam.interactable ~= nil then
		arg_9_0._interactable = arg_9_0.viewParam.interactable
	end

	if arg_9_0.viewParam and arg_9_0.viewParam.useCloseBtn ~= nil then
		arg_9_0._useCloseBtn = arg_9_0.viewParam.useCloseBtn
	end

	arg_9_0:updateViewPosition(var_9_2)
	arg_9_0:refreshCollectionTips(var_9_0, var_9_1)
	arg_9_0:setInterable(arg_9_0._interactable)
	arg_9_0:setCloseBtnInteractable(arg_9_0._useCloseBtn)
end

function var_0_0.getViewPos(arg_10_0)
	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.viewPosition

	if (arg_10_0.viewParam and arg_10_0.viewParam.source) ~= RougeEnum.OpenCollectionTipSource.ChoiceView then
		return var_10_0
	end

	return recthelper.screenPosToAnchorPos(var_10_0, arg_10_0.viewGO.transform)
end

function var_0_0.setCloseBtnInteractable(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._btnclose.gameObject, arg_11_1)
end

function var_0_0.setInterable(arg_12_0, arg_12_1)
	arg_12_0._hooltoolCanvasGroup.interactable = arg_12_1
	arg_12_0._hooltoolCanvasGroup.blocksRaycasts = arg_12_1
end

function var_0_0.updateViewPosition(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and arg_13_1.x or 0
	local var_13_1 = arg_13_1 and arg_13_1.y or 0

	recthelper.setAnchor(arg_13_0._goroot.transform, var_13_0, var_13_1)
end

function var_0_0.refreshCollectionTips(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = RougeCollectionModel.instance:getCollectionByUid(arg_14_1)

	if var_14_0 then
		arg_14_2 = var_14_0.cfgId
	end

	local var_14_1 = RougeCollectionConfig.instance:getCollectionCfg(arg_14_2)

	arg_14_0:refreshCollectionBaseInfo(var_14_0, var_14_1)
	arg_14_0:refreshCollectionHoles(var_14_1, var_14_0)
	RougeCollectionHelper.loadShapeGrid(arg_14_2, arg_14_0._goshapecontainer, arg_14_0._goshapecell, arg_14_0._cellModelTab, false)

	local var_14_2 = var_14_0 and var_14_0:getAllEnchantCfgId()

	RougeCollectionHelper.loadCollectionAndEnchantTags(arg_14_2, var_14_2, arg_14_0._gotags, arg_14_0._gotagitem)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(arg_14_2, var_14_2, arg_14_0._gotips, arg_14_0._gotagdescitem, RougeCollectionHelper._loadCollectionTagNameCallBack, RougeCollectionHelper)

	local var_14_3 = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(arg_14_1)

	gohelper.setActive(arg_14_0._btnunequip.gameObject, var_14_3 and arg_14_0._interactable)
end

local var_0_1 = 247
local var_0_2 = 420

function var_0_0.refreshCollectionBaseInfo(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1 and arg_15_1:getAllEnchantCfgId()
	local var_15_1 = arg_15_2 and arg_15_2.id

	arg_15_0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(var_15_1, var_15_0)

	local var_15_2 = RougeCollectionHelper.getCollectionIconUrl(var_15_1)

	arg_15_0._simageicon:LoadImage(var_15_2)

	arg_15_0._itemInstTab = arg_15_0._itemInstTab or arg_15_0:getUserDataTb_()

	if arg_15_1 then
		RougeCollectionDescHelper.setCollectionDescInfos(arg_15_1.id, arg_15_0._godescContent, arg_15_0._itemInstTab)
	else
		RougeCollectionDescHelper.setCollectionDescInfos2(var_15_1, var_15_0, arg_15_0._godescContent, arg_15_0._itemInstTab, nil, {
			isAllActive = true
		})
	end

	local var_15_3 = (arg_15_2 and arg_15_2.holeNum or 0) > 0 and var_0_1 or var_0_2

	recthelper.setHeight(arg_15_0._scrollcollectiondesc.transform, var_15_3)
end

local var_0_3 = 3

function var_0_0.refreshCollectionHoles(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1.holeNum or 0

	gohelper.setActive(arg_16_0._goholetool, var_16_0 > 0)

	for iter_16_0 = 1, var_0_3 do
		local var_16_1 = arg_16_0:getOrCreateHole(iter_16_0)

		gohelper.setActive(var_16_1.viewGO, true)
		gohelper.setActive(var_16_1.golock, var_16_0 < iter_16_0)
		gohelper.setActive(var_16_1.godisenchant, not arg_16_0._interactable or not arg_16_2)

		local var_16_2 = false

		if arg_16_2 then
			local var_16_3, var_16_4 = arg_16_2:getEnchantIdAndCfgId(iter_16_0)

			var_16_2 = var_16_3 and var_16_3 > 0

			if var_16_2 then
				local var_16_5 = RougeCollectionHelper.getCollectionIconUrl(var_16_4)

				var_16_1.simageicon:LoadImage(var_16_5)
			end
		end

		gohelper.setActive(var_16_1.goadd, iter_16_0 <= var_16_0 and not var_16_2 and arg_16_0._interactable)
		gohelper.setActive(var_16_1.goenchant, iter_16_0 <= var_16_0 and var_16_2)
		gohelper.setActive(var_16_1.btnremoveenchant.gameObject, iter_16_0 <= var_16_0 and var_16_2 and arg_16_0._interactable)
		gohelper.setActive(var_16_1.btnclick.gameObject, iter_16_0 <= var_16_0)
	end
end

function var_0_0.getOrCreateHole(arg_17_0, arg_17_1)
	arg_17_0._holeTab = arg_17_0._holeTab or arg_17_0:getUserDataTb_()

	local var_17_0 = arg_17_0._holeTab[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.viewGO = gohelper.cloneInPlace(arg_17_0._goholeitem, "hole_" .. arg_17_1)
		var_17_0.godisenchant = gohelper.findChild(var_17_0.viewGO, "go_disenchant")
		var_17_0.goadd = gohelper.findChild(var_17_0.viewGO, "go_add")
		var_17_0.golock = gohelper.findChild(var_17_0.viewGO, "go_lock")
		var_17_0.goenchant = gohelper.findChild(var_17_0.viewGO, "go_enchant")
		var_17_0.btnclick = gohelper.findChildButtonWithAudio(var_17_0.viewGO, "btn_click")

		var_17_0.btnclick:AddClickListener(arg_17_0._btnclickOnClick, arg_17_0, arg_17_1)

		var_17_0.simageicon = gohelper.findChildSingleImage(var_17_0.viewGO, "go_enchant/simage_icon")
		var_17_0.btnremoveenchant = gohelper.findChildButtonWithAudio(var_17_0.viewGO, "go_enchant/btn_remove")

		var_17_0.btnremoveenchant:AddClickListener(arg_17_0._btnRemoveEnchantOnClick, arg_17_0, arg_17_1)

		arg_17_0._holeTab[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0._btnclickOnClick(arg_18_0, arg_18_1)
	if not arg_18_0._interactable then
		return
	end

	local var_18_0 = arg_18_0.viewParam and arg_18_0.viewParam.collectionId

	if var_18_0 and var_18_0 > 0 then
		arg_18_0._selectCollectionId = var_18_0
		arg_18_0._selectHoleIndex = arg_18_1
		arg_18_0._waitCount = 1

		arg_18_0._animatorPlayer:Play("switch", arg_18_0.playSwitchAnimDoneCallBack, arg_18_0)
	end
end

function var_0_0._btnRemoveEnchantOnClick(arg_19_0, arg_19_1)
	if not arg_19_0._interactable then
		return
	end

	local var_19_0 = arg_19_0.viewParam and arg_19_0.viewParam.collectionId

	if var_19_0 and var_19_0 > 0 then
		RougeCollectionEnchantController.instance:removeEnchant(var_19_0, arg_19_1)
	end
end

function var_0_0.playSwitchAnimDoneCallBack(arg_20_0)
	arg_20_0._waitCount = (arg_20_0._waitCount or 0) - 1

	arg_20_0:checkIsCouldOpenEnchantView()
end

function var_0_0.checkIsCouldOpenEnchantView(arg_21_0)
	if arg_21_0._waitCount <= 0 then
		local var_21_0 = arg_21_0:getCollectionIds()
		local var_21_1 = {
			collectionId = arg_21_0._selectCollectionId,
			collectionIds = var_21_0,
			selectHoleIndex = arg_21_0._selectHoleIndex
		}

		RougeController.instance:openRougeCollectionEnchantView(var_21_1)
	end
end

function var_0_0.getCollectionIds(arg_22_0)
	local var_22_0 = arg_22_0.viewParam and arg_22_0.viewParam.source
	local var_22_1 = {}
	local var_22_2 = arg_22_0.sortCollectionFunction1

	if var_22_0 == RougeEnum.OpenCollectionTipSource.SlotArea then
		var_22_1 = RougeCollectionModel.instance:getSlotAreaCollection()
		var_22_2 = arg_22_0.sortCollectionFunction1
	elseif var_22_0 == RougeEnum.OpenCollectionTipSource.BagArea then
		var_22_1 = RougeCollectionModel.instance:getBagAreaCollection()
		var_22_2 = arg_22_0.sortCollectionFunction2
	end

	local var_22_3 = {}

	if var_22_1 then
		for iter_22_0, iter_22_1 in ipairs(var_22_1) do
			local var_22_4 = RougeCollectionConfig.instance:getCollectionCfg(iter_22_1.cfgId)

			if (var_22_4 and var_22_4.holeNum or 0) > 0 then
				table.insert(var_22_3, iter_22_1.id)
			end
		end
	end

	table.sort(var_22_3, var_22_2)

	return var_22_3
end

function var_0_0.sortCollectionFunction1(arg_23_0, arg_23_1)
	local var_23_0 = RougeCollectionModel.instance:getCollectionByUid(arg_23_0)
	local var_23_1 = RougeCollectionModel.instance:getCollectionByUid(arg_23_1)
	local var_23_2 = var_23_0 and var_23_0.cfgId
	local var_23_3 = var_23_1 and var_23_1.cfgId
	local var_23_4 = RougeCollectionConfig.instance:getCollectionCfg(var_23_2)
	local var_23_5 = RougeCollectionConfig.instance:getCollectionCfg(var_23_3)
	local var_23_6 = var_23_4 and var_23_4.showRare or 0
	local var_23_7 = var_23_5 and var_23_5.showRare or 0

	if var_23_6 ~= var_23_7 then
		return var_23_7 < var_23_6
	end

	local var_23_8 = RougeCollectionConfig.instance:getCollectionCellCount(var_23_0.cfgId, RougeEnum.CollectionEditorParamType.Shape)
	local var_23_9 = RougeCollectionConfig.instance:getCollectionCellCount(var_23_1.cfgId, RougeEnum.CollectionEditorParamType.Shape)

	if var_23_8 ~= var_23_9 then
		return var_23_9 < var_23_8
	end

	return arg_23_0 < arg_23_1
end

function var_0_0.sortCollectionFunction2(arg_24_0, arg_24_1)
	local var_24_0 = RougeCollectionModel.instance:getCollectionByUid(arg_24_0)
	local var_24_1 = RougeCollectionModel.instance:getCollectionByUid(arg_24_1)
	local var_24_2 = var_24_0 and var_24_0.cfgId
	local var_24_3 = var_24_1 and var_24_1.cfgId
	local var_24_4 = RougeCollectionConfig.instance:getCollectionCfg(var_24_2)
	local var_24_5 = RougeCollectionConfig.instance:getCollectionCfg(var_24_3)

	if var_24_4.type ~= var_24_5.type and (var_24_4.type == RougeEnum.CollectionType.Enchant or var_24_5.type == RougeEnum.CollectionType.Enchant) then
		return var_24_4.type == RougeEnum.CollectionType.Enchant
	end

	local var_24_6 = var_24_4 and var_24_4.showRare or 0
	local var_24_7 = var_24_5 and var_24_5.showRare or 0

	if var_24_6 ~= var_24_7 then
		return var_24_7 < var_24_6
	end

	local var_24_8 = RougeCollectionConfig.instance:getCollectionCellCount(var_24_0.cfgId, RougeEnum.CollectionEditorParamType.Shape)
	local var_24_9 = RougeCollectionConfig.instance:getCollectionCellCount(var_24_1.cfgId, RougeEnum.CollectionEditorParamType.Shape)

	if var_24_8 ~= var_24_9 then
		return var_24_9 < var_24_8
	end

	return arg_24_0 < arg_24_1
end

function var_0_0.updateCollectionEnchantInfo(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.viewParam and arg_25_0.viewParam.collectionId

	if not var_25_0 or var_25_0 ~= arg_25_1 then
		return
	end

	arg_25_0:refreshCollectionTips(arg_25_1)
end

function var_0_0.updateCollectionAttr(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.viewParam and arg_26_0.viewParam.collectionId

	if var_26_0 == arg_26_1 then
		arg_26_0:refreshCollectionTips(var_26_0)
	end
end

function var_0_0.removeAllHoleClicks(arg_27_0)
	if arg_27_0._holeTab then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._holeTab) do
			iter_27_1.btnclick:RemoveClickListener()
			iter_27_1.btnremoveenchant:RemoveClickListener()
			iter_27_1.simageicon:UnLoadImage()
		end
	end
end

function var_0_0.onCloseViewCallBack(arg_28_0, arg_28_1)
	if arg_28_1 == ViewName.RougeCollectionEnchantView then
		arg_28_0._animatorPlayer:Play("back", arg_28_0._onPlayBackAnimCallBack, arg_28_0)
	end
end

function var_0_0._onPlayBackAnimCallBack(arg_29_0)
	return
end

function var_0_0.setViewInteractable(arg_30_0, arg_30_1)
	arg_30_0._rootCanvasGroup.interactable = arg_30_1
	arg_30_0._rootCanvasGroup.blocksRaycasts = arg_30_1
end

function var_0_0._onSwitchCollectionInfoType(arg_31_0)
	arg_31_0:refreshCollectionInfos()
end

function var_0_0.onClose(arg_32_0)
	arg_32_0:removeAllHoleClicks()
end

function var_0_0.onDestroyView(arg_33_0)
	arg_33_0._simageicon:UnLoadImage()

	if arg_33_0._itemAttrCallBackId then
		RougeRpc.instance:removeCallbackById(arg_33_0._itemAttrCallBackId)

		arg_33_0._itemAttrCallBackId = nil
	end
end

return var_0_0

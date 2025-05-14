module("modules.logic.rouge.view.RougeCollectionEnchantView", package.seeall)

local var_0_0 = class("RougeCollectionEnchantView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#go_tips/#simage_icon")
	arg_1_0._txtcollectionname = gohelper.findChildText(arg_1_0.viewGO, "left/#go_tips/#txt_collectionname")
	arg_1_0._gocollectiondesccontent = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#scroll_collectiondesc/Viewport/#go_collectiondesccontent")
	arg_1_0._gocollectiondescitem = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#scroll_collectiondesc/Viewport/#go_collectiondesccontent/#go_collectiondescitem")
	arg_1_0._gotags = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#go_tags")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#go_tags/#go_tagitem")
	arg_1_0._goholetool = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#go_holetool")
	arg_1_0._goholeitem = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#go_holetool/#go_holeitem")
	arg_1_0._btnlast = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_tips/#btn_last")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_tips/#btn_next")
	arg_1_0._goshapecontainer = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#go_shapecontainer")
	arg_1_0._goshapecell = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#go_shapecontainer/#go_shapecell")
	arg_1_0._gounselected = gohelper.findChild(arg_1_0.viewGO, "middle/#go_unselected")
	arg_1_0._goenchantempty = gohelper.findChild(arg_1_0.viewGO, "right/#go_enchantempty")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "middle/#scroll_desc")
	arg_1_0._simageenchanticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "middle/#simage_enchanticon")
	arg_1_0._goenchantcontent = gohelper.findChild(arg_1_0.viewGO, "middle/#scroll_desc/Viewport/#go_enchantcontent")
	arg_1_0._txtenchantdesc = gohelper.findChildText(arg_1_0.viewGO, "middle/#scroll_desc/Viewport/#go_enchantcontent/#txt_enchantdesc")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "middle/#txt_name")
	arg_1_0._gotagcontents = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#go_tagcontents")
	arg_1_0._gotagnameitem = gohelper.findChild(arg_1_0.viewGO, "left/#go_tips/#go_tagcontents/#go_tagnameitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlast:AddClickListener(arg_2_0._btnlastOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlast:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
end

local var_0_1 = 0.3
local var_0_2 = 1

function var_0_0._btnlastOnClick(arg_4_0)
	RougeCollectionEnchantController.instance:switchCollection(false)
	arg_4_0:updateSwitchBtnState()
	arg_4_0:delay2RefreshInfo(var_0_0.DelayRefreshInfoTime)
	arg_4_0._tipAnimator:Play("switch", 0, 0)
end

function var_0_0._btnnextOnClick(arg_5_0)
	RougeCollectionEnchantController.instance:switchCollection(true)
	arg_5_0:updateSwitchBtnState()
	arg_5_0:delay2RefreshInfo(var_0_0.DelayRefreshInfoTime)
	arg_5_0._tipAnimator:Play("switch", 0, 0)
end

function var_0_0.updateSwitchBtnState(arg_6_0)
	local var_6_0 = RougeCollectionUnEnchantListModel.instance:getCurSelectIndex()
	local var_6_1 = RougeCollectionUnEnchantListModel.instance:getCount()
	local var_6_2 = gohelper.onceAddComponent(arg_6_0._btnlast, typeof(UnityEngine.CanvasGroup))
	local var_6_3 = var_6_0 <= 1

	var_6_2.alpha = var_6_3 and var_0_1 or var_0_2
	var_6_2.interactable = not var_6_3
	var_6_2.blocksRaycasts = not var_6_3

	local var_6_4 = gohelper.onceAddComponent(arg_6_0._btnnext, typeof(UnityEngine.CanvasGroup))
	local var_6_5 = var_6_1 <= var_6_0

	var_6_4.alpha = var_6_5 and var_0_1 or var_0_2
	var_6_4.interactable = not var_6_5
	var_6_4.blocksRaycasts = not var_6_5
end

function var_0_0._btndetailsOnClick(arg_7_0)
	RougeCollectionModel.instance:switchCollectionInfoType()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, arg_8_0.updateCollectionEnchantInfo, arg_8_0)
	arg_8_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_8_0._onSwitchCollectionInfoType, arg_8_0)

	arg_8_0._cellModelTab = arg_8_0:getUserDataTb_()
	arg_8_0._animator = gohelper.onceAddComponent(arg_8_0.viewGO, gohelper.Type_Animator)
	arg_8_0._tipAnimator = gohelper.onceAddComponent(arg_8_0._gotips, gohelper.Type_Animator)
	arg_8_0._itemInstTab = arg_8_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.collectionId
	local var_9_1 = arg_9_0.viewParam and arg_9_0.viewParam.collectionIds
	local var_9_2 = arg_9_0.viewParam and arg_9_0.viewParam.selectHoleIndex

	RougeCollectionEnchantController.instance:onOpenView(var_9_0, var_9_1, var_9_2)
	arg_9_0:refreshCollectionTips()
	arg_9_0:updateSwitchBtnState()
end

function var_0_0.refreshCollectionTips(arg_10_0)
	local var_10_0 = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	arg_10_0:refresh(var_10_0)
end

function var_0_0.refresh(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	local var_11_0 = RougeCollectionModel.instance:getCollectionByUid(arg_11_1)

	if not var_11_0 then
		logError("cannot find collection, id = " .. tostring(arg_11_1))

		return
	end

	local var_11_1 = var_11_0.cfgId
	local var_11_2 = RougeCollectionConfig.instance:getCollectionCfg(var_11_1)

	arg_11_0:refreshCollectionBaseInfo(var_11_0)

	local var_11_3 = var_11_0:getAllEnchantCfgId()

	RougeCollectionHelper.loadCollectionAndEnchantTags(var_11_1, var_11_3, arg_11_0._gotags, arg_11_0._gotagitem)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(var_11_1, var_11_3, arg_11_0._gotagcontents, arg_11_0._gotagnameitem, RougeCollectionHelper._loadCollectionTagNameCallBack, RougeCollectionHelper)
	RougeCollectionHelper.loadShapeGrid(var_11_0.cfgId, arg_11_0._goshapecontainer, arg_11_0._goshapecell, arg_11_0._cellModelTab, false)
	arg_11_0:refreshCollectionHoles(var_11_2, var_11_0)
	arg_11_0:checkIsSelectEnchant()
end

function var_0_0.refreshCollectionBaseInfo(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_1:getAllEnchantCfgId()

	arg_12_0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(arg_12_1.cfgId, var_12_0)

	RougeCollectionDescHelper.setCollectionDescInfos(arg_12_1.id, arg_12_0._gocollectiondesccontent, arg_12_0._itemInstTab)

	local var_12_1 = RougeCollectionHelper.getCollectionIconUrl(arg_12_1.cfgId)

	arg_12_0._simageicon:LoadImage(var_12_1)
end

local var_0_3 = 3

function var_0_0.refreshCollectionHoles(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.holeNum or 0

	gohelper.setActive(arg_13_0._goholetool, var_13_0 > 0)

	local var_13_1 = RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex()

	for iter_13_0 = 1, var_0_3 do
		local var_13_2 = arg_13_0:getOrCreateHole(iter_13_0)
		local var_13_3, var_13_4 = arg_13_2:getEnchantIdAndCfgId(iter_13_0)
		local var_13_5 = var_13_3 and var_13_3 > 0

		gohelper.setActive(var_13_2.viewGO, true)
		gohelper.setActive(var_13_2.golock, var_13_0 < iter_13_0)
		gohelper.setActive(var_13_2.goenchant, iter_13_0 <= var_13_0 and var_13_5)
		gohelper.setActive(var_13_2.goselect, iter_13_0 == var_13_1)
		gohelper.setActive(var_13_2.btnclick.gameObject, iter_13_0 <= var_13_0)
		gohelper.setActive(var_13_2.goadd, iter_13_0 <= var_13_0 and not var_13_5)

		if var_13_5 then
			var_13_2.icon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_13_4))
		end
	end
end

function var_0_0.getOrCreateHole(arg_14_0, arg_14_1)
	arg_14_0._holeTab = arg_14_0._holeTab or arg_14_0:getUserDataTb_()

	local var_14_0 = arg_14_0._holeTab[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.viewGO = gohelper.cloneInPlace(arg_14_0._goholeitem, "hole_" .. arg_14_1)
		var_14_0.golock = gohelper.findChild(var_14_0.viewGO, "go_lock")
		var_14_0.goenchant = gohelper.findChild(var_14_0.viewGO, "go_enchant")
		var_14_0.btnremove = gohelper.findChildButtonWithAudio(var_14_0.viewGO, "go_enchant/btn_remove")

		var_14_0.btnremove:AddClickListener(arg_14_0._btnremoveEnchantOnClick, arg_14_0, arg_14_1)

		var_14_0.goselect = gohelper.findChild(var_14_0.viewGO, "go_select")
		var_14_0.goadd = gohelper.findChild(var_14_0.viewGO, "go_add")
		var_14_0.btnclick = gohelper.findChildButtonWithAudio(var_14_0.viewGO, "btn_click")

		var_14_0.btnclick:AddClickListener(arg_14_0._btnclickHoleOnClick, arg_14_0, arg_14_1)

		var_14_0.icon = gohelper.findChildSingleImage(var_14_0.viewGO, "go_enchant/simage_icon")
		arg_14_0._holeTab[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0._btnremoveEnchantOnClick(arg_15_0, arg_15_1)
	local var_15_0 = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	RougeCollectionEnchantController.instance:removeEnchant(var_15_0, arg_15_1)
end

function var_0_0._btnclickHoleOnClick(arg_16_0, arg_16_1)
	if arg_16_0._holeTab and arg_16_0._holeTab[arg_16_1] then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._holeTab) do
			gohelper.setActive(iter_16_1.goselect, iter_16_0 == arg_16_1)
		end

		RougeCollectionEnchantController.instance:onSelectHoleGrid(arg_16_1)
	end
end

function var_0_0.updateCollectionEnchantInfo(arg_17_0, arg_17_1)
	RougeCollectionEnchantListModel.instance:onInitData(false)
	RougeCollectionEnchantListModel.instance:onModelUpdate()

	if arg_17_1 ~= RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId() then
		return
	end

	if arg_17_0._isInitDone then
		arg_17_0._animator:Play("switch", 0, 0)
		arg_17_0:delay2RefreshInfo(var_0_0.DelayRefreshInfoTime)
	else
		arg_17_0:refresh()

		arg_17_0._isInitDone = true
	end
end

var_0_0.DelayRefreshInfoTime = 0.16

function var_0_0.delay2RefreshInfo(arg_18_0, arg_18_1)
	TaskDispatcher.cancelTask(arg_18_0.refresh, arg_18_0)
	TaskDispatcher.runDelay(arg_18_0.refresh, arg_18_0, arg_18_1 or 0)
end

function var_0_0.checkIsSelectEnchant(arg_19_0)
	local var_19_0 = RougeCollectionEnchantListModel.instance:getCount()
	local var_19_1 = RougeCollectionEnchantListModel.instance:getCurSelectEnchantId()
	local var_19_2 = RougeCollectionEnchantListModel.instance:getById(var_19_1)
	local var_19_3 = var_19_2 ~= nil

	gohelper.setActive(arg_19_0._gounselected, not var_19_3)
	gohelper.setActive(arg_19_0._scrolldesc.gameObject, var_19_3)
	gohelper.setActive(arg_19_0._simageenchanticon.gameObject, var_19_3)
	gohelper.setActive(arg_19_0._txtname.gameObject, var_19_3)
	gohelper.setActive(arg_19_0._goenchantempty, var_19_0 <= 0)

	if var_19_3 then
		local var_19_4 = var_19_2 and var_19_2.cfgId

		if RougeCollectionConfig.instance:getCollectionCfg(var_19_4) then
			arg_19_0._txtname.text = RougeCollectionConfig.instance:getCollectionName(var_19_4)

			arg_19_0._simageenchanticon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_19_4))

			local var_19_5 = RougeCollectionDescHelper.getShowDescTypesWithoutText()

			RougeCollectionDescHelper.setCollectionDescInfos3(var_19_4, nil, arg_19_0._txtenchantdesc, var_19_5)
		end
	end
end

function var_0_0._onSwitchCollectionInfoType(arg_20_0)
	arg_20_0:refreshCollectionTips()
end

function var_0_0.removeAllHoleClicks(arg_21_0)
	if arg_21_0._holeTab then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._holeTab) do
			iter_21_1.btnremove:RemoveClickListener()
			iter_21_1.btnclick:RemoveClickListener()
			iter_21_1.icon:UnLoadImage()
		end
	end
end

function var_0_0.onClose(arg_22_0)
	arg_22_0:removeAllHoleClicks()
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0._simageicon:UnLoadImage()
	arg_23_0._simageenchanticon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_23_0.refresh, arg_23_0)
end

return var_0_0

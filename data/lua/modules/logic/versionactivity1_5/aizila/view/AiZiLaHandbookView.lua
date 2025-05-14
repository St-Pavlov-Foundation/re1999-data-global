module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookView", package.seeall)

local var_0_0 = class("AiZiLaHandbookView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._txtItemNum = gohelper.findChildText(arg_1_0.viewGO, "Left/ItemNum/#txt_ItemNum")
	arg_1_0._imageItemIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#image_ItemIcon")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_Title")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#scrollview/view/#txt_Descr")
	arg_1_0._goUnCollect = gohelper.findChild(arg_1_0.viewGO, "Left/#go_UnCollect")
	arg_1_0._scrollItems = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#scroll_Items")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goLeft = gohelper.findChild(arg_4_0.viewGO, "Left")
	arg_4_0._animatorLeft = arg_4_0._goLeft:GetComponent(AiZiLaEnum.ComponentType.Animator)
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	arg_4_0._singleItemIcon = gohelper.findChildSingleImage(arg_4_0.viewGO, "Left/#image_ItemIcon")
	arg_4_0._unCollectHideList = arg_4_0:getUserDataTb_()
	arg_4_0._grayGoList = arg_4_0:getUserDataTb_()

	local var_4_0 = {
		"ItemNum",
		"image_TitleLIne",
		"#scrollview/view/#txt_Descr"
	}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		table.insert(arg_4_0._unCollectHideList, gohelper.findChild(arg_4_0._goLeft, iter_4_1))
	end

	local var_4_1 = gohelper.findChild(arg_4_0.viewGO, "Left/ItemBG"):GetComponentsInChildren(gohelper.Type_Image, true)
	local var_4_2 = {}

	RoomHelper.cArrayToLuaTable(var_4_1, var_4_2)

	for iter_4_2, iter_4_3 in ipairs(var_4_2) do
		table.insert(arg_4_0._grayGoList, iter_4_3.gameObject)
	end

	table.insert(arg_4_0._grayGoList, arg_4_0._imageItemIcon.gameObject)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.playViewAnimator(arg_6_0, arg_6_1)
	if arg_6_0._animator then
		arg_6_0._animator:Play(arg_6_1, 0, 0)
	end
end

function var_0_0.onOpen(arg_7_0)
	if arg_7_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_7_0.viewContainer.viewName, arg_7_0.closeThis, arg_7_0)
	end

	local var_7_0 = AiZiLaHandbookListModel.instance

	var_7_0:init()

	local var_7_1 = var_7_0:getByIndex(1)

	if var_7_1 then
		var_7_0:setSelect(var_7_1.id)
	end

	arg_7_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.SelectItem, arg_7_0._onSelectItem, arg_7_0)
	arg_7_0:refreshUI()
	AiZiLaModel.instance:finishItemRed()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper3)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onDelayRefreshUI, arg_9_0)
	arg_9_0._singleItemIcon:UnLoadImage()
end

function var_0_0._onSelectItem(arg_10_0)
	if arg_10_0._animatorLeft then
		if not arg_10_0._isPlayLeftAnimIng then
			arg_10_0._isPlayLeftAnimIng = true

			arg_10_0._animatorLeft:Play(UIAnimationName.Switch, 0, 0)
			TaskDispatcher.runDelay(arg_10_0._onDelayRefreshUI, arg_10_0, 0.4)
		end
	else
		arg_10_0:refreshUI()
	end
end

function var_0_0._onDelayRefreshUI(arg_11_0)
	arg_11_0._isPlayLeftAnimIng = false

	arg_11_0:refreshUI()
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = AiZiLaHandbookListModel.instance:getSelectMO()

	gohelper.setActive(arg_12_0._goLeft, var_12_0)

	if var_12_0 then
		local var_12_1 = var_12_0:getQuantity()

		if arg_12_0._lastQuantity ~= var_12_1 then
			arg_12_0._lastQuantity = var_12_1
			arg_12_0._txtItemNum.text = formatLuaLang("materialtipview_itemquantity", var_12_1)
		end

		if arg_12_0._lastItemId ~= var_12_0.itemId then
			arg_12_0._lastItemId = var_12_0.itemId

			local var_12_2 = AiZiLaModel.instance:isCollectItemId(arg_12_0._lastItemId)
			local var_12_3 = var_12_0:getConfig()

			arg_12_0._singleItemIcon:LoadImage(ResUrl.getV1a5AiZiLaItemIcon(var_12_3.icon))

			arg_12_0._txtTitle.text = string.format(var_12_2 and "%s" or "<color=#524D46>%s</color>", var_12_3.name)
			arg_12_0._txtDescr.text = var_12_3.desc

			arg_12_0:_refreshGray(not var_12_2)
		end
	end
end

function var_0_0._refreshGray(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and true or false

	if arg_13_0._lastGray ~= var_13_0 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0._grayGoList) do
			arg_13_0:_setGrayMode(iter_13_1, arg_13_1)
		end

		for iter_13_2, iter_13_3 in ipairs(arg_13_0._unCollectHideList) do
			gohelper.setActive(iter_13_3, not arg_13_1)
		end

		gohelper.setActive(arg_13_0._goUnCollect, arg_13_1)
	end
end

function var_0_0._setGrayMode(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		ZProj.UGUIHelper.SetGrayFactor(arg_14_1, 0.8)
	else
		ZProj.UGUIHelper.SetGrayscale(arg_14_1, false)
	end
end

return var_0_0

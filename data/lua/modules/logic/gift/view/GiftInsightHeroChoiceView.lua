module("modules.logic.gift.view.GiftInsightHeroChoiceView", package.seeall)

local var_0_0 = class("GiftInsightHeroChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Title")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._goconfirm = gohelper.findChild(arg_1_0.viewGO, "#btn_confirm/#go_confirm")
	arg_1_0._gonoconfirm = gohelper.findChild(arg_1_0.viewGO, "#btn_confirm/#go_noconfirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._scrollrule = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_rule")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	arg_1_0._gotitle1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	arg_1_0._gonogain = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	arg_1_0._gotitle2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	arg_1_0._goown = gohelper.findChild(arg_1_0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.uid

	if ItemInsightModel.instance:getInsightItemCount(var_4_0) < 1 then
		GameFacade.showToast(ToastEnum.GiftInsightNoEnoughItem)

		return
	end

	local var_4_1 = GiftInsightHeroChoiceModel.instance:getCurHeroId()

	if var_4_1 > 0 then
		ItemRpc.instance:sendUseInsightItemRequest(var_4_0, var_4_1, arg_4_0._onUseFinished, arg_4_0)

		return
	end

	GameFacade.showToast(ToastEnum.GiftInsightNoChooseHero)
end

function var_0_0._onUseFinished(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		return
	end

	TaskDispatcher.runDelay(arg_5_0._useItemSuccess, arg_5_0, 0.5)
end

function var_0_0._useItemSuccess(arg_6_0)
	arg_6_0:_refreshHeros()
	arg_6_0:closeThis()
end

function var_0_0._btncancelOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._addEvents(arg_9_0)
	return
end

function var_0_0._removeEvents(arg_10_0)
	return
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._upHeroItems = {}
	arg_11_0._noUpHeroItems = {}

	arg_11_0:_addEvents()
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0._itemConfig = ItemConfig.instance:getInsightItemCo(arg_13_0.viewParam.id)
	arg_13_0._txtTitle.text = arg_13_0._itemConfig.useTitle

	arg_13_0:_refreshHeros()
end

function var_0_0.onClose(arg_14_0)
	GiftInsightHeroChoiceModel.instance:setCurHeroId(0)
end

function var_0_0._refreshHeros(arg_15_0)
	local var_15_0, var_15_1 = GiftInsightHeroChoiceModel.instance:getFitHeros(arg_15_0.viewParam.id)

	gohelper.setActive(arg_15_0._gotitle1, var_15_0 and #var_15_0 > 0)
	gohelper.setActive(arg_15_0._gonoconfirm, not var_15_0 or #var_15_0 < 1)
	gohelper.setActive(arg_15_0._goconfirm, var_15_0 and #var_15_0 > 0)
	arg_15_0:_refreshUpHeros(var_15_0)
	gohelper.setActive(arg_15_0._gotitle2, #var_15_1 > 0)
	arg_15_0:_refreshNoUpHeros(var_15_1)
end

function var_0_0._refreshUpHeros(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._upHeroItems) do
		iter_16_1:hide()
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_1) do
		if not arg_16_0._upHeroItems[iter_16_2] then
			local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes[1]
			local var_16_1 = arg_16_0:getResInst(var_16_0, arg_16_0._gonogain)

			arg_16_0._upHeroItems[iter_16_2] = GiftInsightHeroChoiceListItem.New()

			arg_16_0._upHeroItems[iter_16_2]:init(var_16_1)
		end

		arg_16_0._upHeroItems[iter_16_2]:refreshItem(iter_16_3)
		arg_16_0._upHeroItems[iter_16_2]:showUp(true)
	end
end

function var_0_0._refreshNoUpHeros(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._noUpHeroItems) do
		iter_17_1:hide()
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_1) do
		if not arg_17_0._noUpHeroItems[iter_17_2] then
			local var_17_0 = arg_17_0.viewContainer:getSetting().otherRes[1]
			local var_17_1 = arg_17_0:getResInst(var_17_0, arg_17_0._goown)

			arg_17_0._noUpHeroItems[iter_17_2] = GiftInsightHeroChoiceListItem.New()

			arg_17_0._noUpHeroItems[iter_17_2]:init(var_17_1)
		end

		arg_17_0._noUpHeroItems[iter_17_2]:refreshItem(iter_17_3)
		arg_17_0._noUpHeroItems[iter_17_2]:showUp(false)
	end
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._useItemSuccess, arg_18_0)
	arg_18_0:_removeEvents()

	if arg_18_0._upHeroItems then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._upHeroItems) do
			iter_18_1:destroy()
		end

		arg_18_0._upHeroItems = nil
	end

	if arg_18_0._noUpHeroItems then
		for iter_18_2, iter_18_3 in pairs(arg_18_0._noUpHeroItems) do
			iter_18_3:destroy()
		end

		arg_18_0._noUpHeroItems = nil
	end
end

return var_0_0

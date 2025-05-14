module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapInteractiveItem102", package.seeall)

local var_0_0 = class("VersionActivity_1_2_DungeonMapInteractiveItem102", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topRight = gohelper.findChild(arg_1_0.viewGO, "topRight")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gopickupbg = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_pickupbg")
	arg_1_0._gopickup = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_pickupbg/#go_pickup")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_pickupbg/#go_pickup/#txt_title")
	arg_1_0._goop = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op")
	arg_1_0._simageicon = gohelper.findChildImage(arg_1_0.viewGO, "rotate/#go_op/cost/iconnode/icon")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op/cost/#txt_cost")
	arg_1_0._txtdoit = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op/bg/#txt_doit")
	arg_1_0._btndoit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op/bg/#btn_doit")
	arg_1_0._contenttitle = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_pickupbg/#go_pickup/contenttitle")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/fragment/#go_line")
	arg_1_0._simagebgimag = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/#go_pickupbg/bgimag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndoit:AddClickListener(arg_2_0._btndoitOnClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeBuildingRepairItem, arg_2_0._onBtnCloseSelf, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndoit:RemoveClickListener()
end

function var_0_0._btndoitOnClick(arg_4_0)
	if #arg_4_0._costData > 0 and not ItemModel.instance:goodsIsEnough(arg_4_0._costData[1], arg_4_0._costData[2], arg_4_0._costData[3]) then
		GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = arg_4_0._config.title,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	DungeonRpc.instance:sendMapElementRequest(arg_4_0._config.id)
	arg_4_0:_onBtnCloseSelf()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:_onBtnCloseSelf()
end

function var_0_0._onBtnCloseSelf(arg_6_0)
	SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO):Play("close", arg_6_0.DESTROYSELF, arg_6_0)
end

function var_0_0.onRefreshViewParam(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._config = arg_7_1
	arg_7_0._mapElement = arg_7_2
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
	gohelper.setActive(arg_8_0._contenttitle, false)

	for iter_8_0, iter_8_1 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(arg_8_0._config.id)) do
		arg_8_0._buildingConfig = iter_8_1
	end

	arg_8_0._txttitle.text = arg_8_0._buildingConfig.desc

	arg_8_0:_showCost()
end

function var_0_0._showCost(arg_9_0)
	arg_9_0._costData = string.splitToNumber(arg_9_0._buildingConfig.cost, "#")

	if #arg_9_0._costData > 0 then
		local var_9_0 = CurrencyConfig.instance:getCurrencyCo(arg_9_0._costData[2]).icon

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_9_0._simageicon, var_9_0 .. "_1")

		arg_9_0._txtcost.text = arg_9_0._costData[3]
		arg_9_0._costIconClick = gohelper.getClick(arg_9_0._simageicon.gameObject)

		arg_9_0._costIconClick:AddClickListener(arg_9_0._onBtnCostIcon, arg_9_0)

		if ItemModel.instance:goodsIsEnough(arg_9_0._costData[1], arg_9_0._costData[2], arg_9_0._costData[3]) then
			SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._txtcost, "#ACCB8A")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._txtcost, "#D97373")
		end
	else
		gohelper.setActive(gohelper.findChild(arg_9_0.viewGO, "rotate/#go_op/cost"))
	end
end

function var_0_0._onBtnCostIcon(arg_10_0)
	MaterialTipController.instance:showMaterialInfo(arg_10_0._costData[1], arg_10_0._costData[2])
end

function var_0_0._showCurrency(arg_11_0)
	arg_11_0:com_loadAsset(CurrencyView.prefabPath, arg_11_0._onCurrencyLoaded)
end

function var_0_0._onCurrencyLoaded(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:GetResource()
	local var_12_1 = gohelper.clone(var_12_0, arg_12_0._topRight)
	local var_12_2 = CurrencyEnum.CurrencyType
	local var_12_3 = {
		var_12_2.DryForest
	}
	local var_12_4 = arg_12_0:openSubView(CurrencyView, var_12_1, nil, var_12_3)

	var_12_4.foreShowBtn = true

	var_12_4:_hideAddBtn(CurrencyEnum.CurrencyType.DryForest)
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0._costIconClick then
		arg_13_0._costIconClick:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagebgimag:UnLoadImage()
end

return var_0_0

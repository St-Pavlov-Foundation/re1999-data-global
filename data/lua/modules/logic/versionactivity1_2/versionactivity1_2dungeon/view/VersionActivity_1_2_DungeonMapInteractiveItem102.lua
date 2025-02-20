module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapInteractiveItem102", package.seeall)

slot0 = class("VersionActivity_1_2_DungeonMapInteractiveItem102", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._topRight = gohelper.findChild(slot0.viewGO, "topRight")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gopickupbg = gohelper.findChild(slot0.viewGO, "rotate/#go_pickupbg")
	slot0._gopickup = gohelper.findChild(slot0.viewGO, "rotate/#go_pickupbg/#go_pickup")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "rotate/#go_pickupbg/#go_pickup/#txt_title")
	slot0._goop = gohelper.findChild(slot0.viewGO, "rotate/#go_op")
	slot0._simageicon = gohelper.findChildImage(slot0.viewGO, "rotate/#go_op/cost/iconnode/icon")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "rotate/#go_op/cost/#txt_cost")
	slot0._txtdoit = gohelper.findChildText(slot0.viewGO, "rotate/#go_op/bg/#txt_doit")
	slot0._btndoit = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op/bg/#btn_doit")
	slot0._contenttitle = gohelper.findChild(slot0.viewGO, "rotate/#go_pickupbg/#go_pickup/contenttitle")
	slot0._goline = gohelper.findChild(slot0.viewGO, "rotate/layout/fragment/#go_line")
	slot0._simagebgimag = gohelper.findChildSingleImage(slot0.viewGO, "rotate/#go_pickupbg/bgimag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btndoit:AddClickListener(slot0._btndoitOnClick, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeBuildingRepairItem, slot0._onBtnCloseSelf, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btndoit:RemoveClickListener()
end

function slot0._btndoitOnClick(slot0)
	if #slot0._costData > 0 and not ItemModel.instance:goodsIsEnough(slot0._costData[1], slot0._costData[2], slot0._costData[3]) then
		GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = slot0._config.title,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	slot0:_onBtnCloseSelf()
end

function slot0._btncloseOnClick(slot0)
	slot0:_onBtnCloseSelf()
end

function slot0._onBtnCloseSelf(slot0)
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("close", slot0.DESTROYSELF, slot0)
end

function slot0.onRefreshViewParam(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._mapElement = slot2
end

function slot0.onOpen(slot0)
	slot0._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))

	slot4 = false

	gohelper.setActive(slot0._contenttitle, slot4)

	slot3 = VersionActivity1_2DungeonConfig.instance
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.getBuildingConfigsByElementID(slot5, slot0._config.id)) do
		slot0._buildingConfig = slot5
	end

	slot0._txttitle.text = slot0._buildingConfig.desc

	slot0:_showCost()
end

function slot0._showCost(slot0)
	slot0._costData = string.splitToNumber(slot0._buildingConfig.cost, "#")

	if #slot0._costData > 0 then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._simageicon, CurrencyConfig.instance:getCurrencyCo(slot0._costData[2]).icon .. "_1")

		slot0._txtcost.text = slot0._costData[3]
		slot0._costIconClick = gohelper.getClick(slot0._simageicon.gameObject)

		slot0._costIconClick:AddClickListener(slot0._onBtnCostIcon, slot0)

		if ItemModel.instance:goodsIsEnough(slot0._costData[1], slot0._costData[2], slot0._costData[3]) then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#ACCB8A")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#D97373")
		end
	else
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "rotate/#go_op/cost"))
	end
end

function slot0._onBtnCostIcon(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._costData[1], slot0._costData[2])
end

function slot0._showCurrency(slot0)
	slot0:com_loadAsset(CurrencyView.prefabPath, slot0._onCurrencyLoaded)
end

function slot0._onCurrencyLoaded(slot0, slot1)
	slot6 = slot0:openSubView(CurrencyView, gohelper.clone(slot1:GetResource(), slot0._topRight), nil, {
		CurrencyEnum.CurrencyType.DryForest
	})
	slot6.foreShowBtn = true

	slot6:_hideAddBtn(CurrencyEnum.CurrencyType.DryForest)
end

function slot0.onClose(slot0)
	if slot0._costIconClick then
		slot0._costIconClick:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebgimag:UnLoadImage()
end

return slot0

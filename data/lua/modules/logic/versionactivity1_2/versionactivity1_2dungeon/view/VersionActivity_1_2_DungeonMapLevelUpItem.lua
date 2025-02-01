module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapLevelUpItem", package.seeall)

slot0 = class("VersionActivity_1_2_DungeonMapLevelUpItem", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._topRight = gohelper.findChild(slot0.viewGO, "topRight")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gomaxbg = gohelper.findChild(slot0.viewGO, "rotate/#go_maxbg")
	slot0._txtmaxlv = gohelper.findChildText(slot0.viewGO, "rotate/#go_maxbg/bgimag/#txt_max_lv")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "rotate/#go_bg")
	slot0._gocurrentlv = gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_currentlv")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "rotate/#go_bg/#go_currentlv/#txt_lv")
	slot0._gonextlv = gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_nextlv")
	slot0._txtnextlv = gohelper.findChildText(slot0.viewGO, "rotate/#go_bg/#go_nextlv/#txt_next_lv")
	slot0._goop = gohelper.findChild(slot0.viewGO, "rotate/#go_op")
	slot0._simageicon = gohelper.findChildImage(slot0.viewGO, "rotate/#go_op/cost/iconnode/icon")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "rotate/#go_op/cost/#txt_cost")
	slot0._txtdoit = gohelper.findChildText(slot0.viewGO, "rotate/#go_op/bg/#txt_doit")
	slot0._btndoit = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op/bg/#btn_doit")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "rotate/layout/top/title/#txt_title")
	slot0._upEffect = gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_nextlv/vx")
	slot0._simagebgimag = gohelper.findChildSingleImage(slot0.viewGO, "rotate/#go_maxbg/bgimag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btndoit:AddClickListener(slot0._btndoitOnClick, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, slot0._onReceiveUpgradeElementReply, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeElementView, slot0._btncloseOnClick, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btndoit:RemoveClickListener()
end

function slot0._onReceiveUpgradeElementReply(slot0, slot1)
	if slot1 == slot0._config.id then
		gohelper.setActive(slot0._upEffect, false)
		gohelper.setActive(slot0._upEffect, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
		slot0:onOpen()
	end
end

function slot0._btndoitOnClick(slot0)
	if #slot0._costData > 0 and not ItemModel.instance:goodsIsEnough(slot0._costData[1], slot0._costData[2], slot0._costData[3]) then
		GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)

		return
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = slot0._config.title,
		[StatEnum.EventProperties.AfterLevel] = slot0._buildingConfig.level + 1,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	Activity116Rpc.instance:sendUpgradeElementRequest(slot0._config.id)
end

function slot0._btncloseOnClick(slot0)
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("close", slot0.DESTROYSELF, slot0)
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._config = slot1
end

function slot0.onOpen(slot0)
	slot0._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg_neirongdi_2"))

	slot0._elementData = VersionActivity1_2DungeonModel.instance:getElementData(slot0._config.id)
	slot0._levelList = {}
	slot4 = slot0._config.id

	for slot4, slot5 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot4)) do
		table.insert(slot0._levelList, slot5)
	end

	table.sort(slot0._levelList, function (slot0, slot1)
		return slot0.level < slot1.level
	end)

	slot0._curLevel = slot0._elementData and slot0._elementData.level or 0
	slot0._nextLevel = slot0._curLevel + 1
	slot0._buildingConfig = slot0._levelList[slot0._curLevel + 1]
	slot0._nextBuildingConfig = slot0._levelList[slot0._nextLevel + 1]

	gohelper.setActive(slot0._gobg, slot0._nextBuildingConfig)
	gohelper.setActive(slot0._goop, slot0._nextBuildingConfig)
	gohelper.setActive(slot0._gomaxbg, not slot0._nextBuildingConfig)

	if not slot0._nextBuildingConfig then
		slot0:_showMaxLevel()
	else
		slot0:_showLevelUpDate()
		slot0:_showCost()
	end

	slot0._txttitle.text = slot0._buildingConfig and slot0._buildingConfig.name or slot0._nextBuildingConfig.name
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

function slot0._showMaxLevel(slot0)
	slot0._txtmaxlv.text = "Lv. " .. slot0._buildingConfig.level

	slot0:_showGianText(slot0._buildingConfig.desc, gohelper.findChild(slot0.viewGO, "rotate/#go_maxbg/bgimag/content"))
end

function slot0._showLevelUpDate(slot0)
	slot0._txtlv.text = "Lv. " .. slot0._curLevel

	slot0:_showGianText(slot0._buildingConfig.desc, gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_currentlv/content"))

	slot0._txtnextlv.text = "Lv. " .. slot0._nextLevel

	slot0:_showGianText(slot0._nextBuildingConfig.desc, gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_nextlv/content"))
end

function slot0._showGianText(slot0, slot1, slot2)
	slot0:com_createObjList(slot0._onAttrShow, string.split(slot1, "|"), slot2, gohelper.findChild(slot2, "line1"))
end

function slot0._onAttrShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "").text = slot2
end

function slot0._showCost(slot0)
	slot1 = string.splitToNumber(slot0._nextBuildingConfig.cost, "#")
	slot0._costData = slot1

	if #slot1 > 0 then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._simageicon, CurrencyConfig.instance:getCurrencyCo(slot1[2]).icon .. "_1")

		slot0._txtcost.text = slot1[3]
		slot0._costIconClick = gohelper.getClick(slot0._simageicon.gameObject)

		slot0._costIconClick:AddClickListener(slot0._onBtnCostIcon, slot0)

		if ItemModel.instance:goodsIsEnough(slot1[1], slot1[2], slot1[3]) then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#ACCB8A")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#D97373")
		end
	else
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "rotate/#go_op/cost"))
	end
end

function slot0._onBtnCostIcon(slot0)
	slot1 = string.splitToNumber(slot0._nextBuildingConfig.cost, "#")

	MaterialTipController.instance:showMaterialInfo(slot1[1], slot1[2])
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

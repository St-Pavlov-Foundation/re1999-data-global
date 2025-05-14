module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapLevelUpItem", package.seeall)

local var_0_0 = class("VersionActivity_1_2_DungeonMapLevelUpItem", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topRight = gohelper.findChild(arg_1_0.viewGO, "topRight")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gomaxbg = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_maxbg")
	arg_1_0._txtmaxlv = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_maxbg/bgimag/#txt_max_lv")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg")
	arg_1_0._gocurrentlv = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_currentlv")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_bg/#go_currentlv/#txt_lv")
	arg_1_0._gonextlv = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_nextlv")
	arg_1_0._txtnextlv = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_bg/#go_nextlv/#txt_next_lv")
	arg_1_0._goop = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op")
	arg_1_0._simageicon = gohelper.findChildImage(arg_1_0.viewGO, "rotate/#go_op/cost/iconnode/icon")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op/cost/#txt_cost")
	arg_1_0._txtdoit = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op/bg/#txt_doit")
	arg_1_0._btndoit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op/bg/#btn_doit")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/layout/top/title/#txt_title")
	arg_1_0._upEffect = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_nextlv/vx")
	arg_1_0._simagebgimag = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/#go_maxbg/bgimag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndoit:AddClickListener(arg_2_0._btndoitOnClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, arg_2_0._onReceiveUpgradeElementReply, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeElementView, arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndoit:RemoveClickListener()
end

function var_0_0._onReceiveUpgradeElementReply(arg_4_0, arg_4_1)
	if arg_4_1 == arg_4_0._config.id then
		gohelper.setActive(arg_4_0._upEffect, false)
		gohelper.setActive(arg_4_0._upEffect, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
		arg_4_0:onOpen()
	end
end

function var_0_0._btndoitOnClick(arg_5_0)
	if #arg_5_0._costData > 0 and not ItemModel.instance:goodsIsEnough(arg_5_0._costData[1], arg_5_0._costData[2], arg_5_0._costData[3]) then
		GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)

		return
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = arg_5_0._config.title,
		[StatEnum.EventProperties.AfterLevel] = arg_5_0._buildingConfig.level + 1,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	Activity116Rpc.instance:sendUpgradeElementRequest(arg_5_0._config.id)
end

function var_0_0._btncloseOnClick(arg_6_0)
	SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO):Play("close", arg_6_0.DESTROYSELF, arg_6_0)
end

function var_0_0.onRefreshViewParam(arg_7_0, arg_7_1)
	arg_7_0._config = arg_7_1
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg_neirongdi_2"))

	arg_8_0._elementData = VersionActivity1_2DungeonModel.instance:getElementData(arg_8_0._config.id)
	arg_8_0._levelList = {}

	for iter_8_0, iter_8_1 in pairs(VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(arg_8_0._config.id)) do
		table.insert(arg_8_0._levelList, iter_8_1)
	end

	table.sort(arg_8_0._levelList, function(arg_9_0, arg_9_1)
		return arg_9_0.level < arg_9_1.level
	end)

	arg_8_0._curLevel = arg_8_0._elementData and arg_8_0._elementData.level or 0
	arg_8_0._nextLevel = arg_8_0._curLevel + 1
	arg_8_0._buildingConfig = arg_8_0._levelList[arg_8_0._curLevel + 1]
	arg_8_0._nextBuildingConfig = arg_8_0._levelList[arg_8_0._nextLevel + 1]

	gohelper.setActive(arg_8_0._gobg, arg_8_0._nextBuildingConfig)
	gohelper.setActive(arg_8_0._goop, arg_8_0._nextBuildingConfig)
	gohelper.setActive(arg_8_0._gomaxbg, not arg_8_0._nextBuildingConfig)

	if not arg_8_0._nextBuildingConfig then
		arg_8_0:_showMaxLevel()
	else
		arg_8_0:_showLevelUpDate()
		arg_8_0:_showCost()
	end

	arg_8_0._txttitle.text = arg_8_0._buildingConfig and arg_8_0._buildingConfig.name or arg_8_0._nextBuildingConfig.name
end

function var_0_0._showCurrency(arg_10_0)
	arg_10_0:com_loadAsset(CurrencyView.prefabPath, arg_10_0._onCurrencyLoaded)
end

function var_0_0._onCurrencyLoaded(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:GetResource()
	local var_11_1 = gohelper.clone(var_11_0, arg_11_0._topRight)
	local var_11_2 = CurrencyEnum.CurrencyType
	local var_11_3 = {
		var_11_2.DryForest
	}
	local var_11_4 = arg_11_0:openSubView(CurrencyView, var_11_1, nil, var_11_3)

	var_11_4.foreShowBtn = true

	var_11_4:_hideAddBtn(CurrencyEnum.CurrencyType.DryForest)
end

function var_0_0._showMaxLevel(arg_12_0)
	arg_12_0._txtmaxlv.text = "Lv. " .. arg_12_0._buildingConfig.level

	arg_12_0:_showGianText(arg_12_0._buildingConfig.desc, gohelper.findChild(arg_12_0.viewGO, "rotate/#go_maxbg/bgimag/content"))
end

function var_0_0._showLevelUpDate(arg_13_0)
	arg_13_0._txtlv.text = "Lv. " .. arg_13_0._curLevel

	arg_13_0:_showGianText(arg_13_0._buildingConfig.desc, gohelper.findChild(arg_13_0.viewGO, "rotate/#go_bg/#go_currentlv/content"))

	arg_13_0._txtnextlv.text = "Lv. " .. arg_13_0._nextLevel

	arg_13_0:_showGianText(arg_13_0._nextBuildingConfig.desc, gohelper.findChild(arg_13_0.viewGO, "rotate/#go_bg/#go_nextlv/content"))
end

function var_0_0._showGianText(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = string.split(arg_14_1, "|")

	arg_14_0:com_createObjList(arg_14_0._onAttrShow, var_14_0, arg_14_2, gohelper.findChild(arg_14_2, "line1"))
end

function var_0_0._onAttrShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	gohelper.findChildText(arg_15_1, "").text = arg_15_2
end

function var_0_0._showCost(arg_16_0)
	local var_16_0 = string.splitToNumber(arg_16_0._nextBuildingConfig.cost, "#")

	arg_16_0._costData = var_16_0

	if #var_16_0 > 0 then
		local var_16_1 = CurrencyConfig.instance:getCurrencyCo(var_16_0[2]).icon

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._simageicon, var_16_1 .. "_1")

		arg_16_0._txtcost.text = var_16_0[3]
		arg_16_0._costIconClick = gohelper.getClick(arg_16_0._simageicon.gameObject)

		arg_16_0._costIconClick:AddClickListener(arg_16_0._onBtnCostIcon, arg_16_0)

		if ItemModel.instance:goodsIsEnough(var_16_0[1], var_16_0[2], var_16_0[3]) then
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcost, "#ACCB8A")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcost, "#D97373")
		end
	else
		gohelper.setActive(gohelper.findChild(arg_16_0.viewGO, "rotate/#go_op/cost"))
	end
end

function var_0_0._onBtnCostIcon(arg_17_0)
	local var_17_0 = string.splitToNumber(arg_17_0._nextBuildingConfig.cost, "#")

	MaterialTipController.instance:showMaterialInfo(var_17_0[1], var_17_0[2])
end

function var_0_0.onClose(arg_18_0)
	if arg_18_0._costIconClick then
		arg_18_0._costIconClick:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._simagebgimag:UnLoadImage()
end

return var_0_0

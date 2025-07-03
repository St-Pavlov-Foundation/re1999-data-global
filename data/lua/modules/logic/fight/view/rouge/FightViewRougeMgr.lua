module("modules.logic.fight.view.rouge.FightViewRougeMgr", package.seeall)

local var_0_0 = class("FightViewRougeMgr", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ResonanceLevel, arg_2_0._onResonanceLevel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PolarizationLevel, arg_2_0._onPolarizationLevel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RougeCoinChange, arg_2_0._onRougeCoinChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	local var_4_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	arg_4_0._isRouge = var_4_0 and var_4_0.type == DungeonEnum.EpisodeType.Rouge

	if arg_4_0._isRouge then
		arg_4_0:_addCollectionBtn()
	end
end

function var_0_0._addCollectionBtn(arg_5_0)
	local var_5_0 = gohelper.findChild(arg_5_0.viewGO, "root/btns")
	local var_5_1 = "ui/viewres/rouge/fight/rougebtnview.prefab"

	arg_5_0._loader = PrefabInstantiate.Create(var_5_0)

	arg_5_0._loader:startLoad(var_5_1, arg_5_0._onLoaded, arg_5_0)
end

function var_0_0._onLoaded(arg_6_0)
	local var_6_0 = arg_6_0._loader:getInstGO()

	gohelper.setAsFirstSibling(var_6_0)

	arg_6_0._btnCollection = gohelper.findChildButtonWithAudio(var_6_0, "")

	arg_6_0._btnCollection:AddClickListener(arg_6_0._onClickCollection, arg_6_0)
end

function var_0_0._onClickCollection(arg_7_0)
	RougeController.instance:openRougeCollectionOverView()
end

function var_0_0.onRefreshViewParam(arg_8_0)
	return
end

function var_0_0.openRougeCoinView(arg_9_0)
	if arg_9_0.rougeCoinView then
		return
	end

	local var_9_0 = arg_9_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.RougeCoin)

	arg_9_0.rougeCoinView = arg_9_0:openSubView(FightViewRougeCoin, "ui/viewres/rouge/fight/rougecoin.prefab", var_9_0)
end

function var_0_0.openRougeGongMingView(arg_10_0)
	if arg_10_0.rougeGongMingView then
		return
	end

	local var_10_0 = arg_10_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.RougeGongMing)

	arg_10_0.rougeGongMingView = arg_10_0:openSubView(FightViewRougeGongMing, "ui/viewres/rouge/fight/rougegongming.prefab", var_10_0)
end

function var_0_0.openRougeTongPinView(arg_11_0)
	if arg_11_0.rougeTongPinView then
		return
	end

	local var_11_0 = arg_11_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.RougeTongPin)

	arg_11_0.rougeTongPinView = arg_11_0:openSubView(FightViewRougeTongPin, "ui/viewres/rouge/fight/rougetongpin.prefab", var_11_0)
end

function var_0_0.openRougeTipDescView(arg_12_0)
	if arg_12_0.rougeTipDescView then
		return
	end

	arg_12_0.rougeTipDescView = arg_12_0:openSubView(FightViewRougeDescTip, "ui/viewres/rouge/fight/rougedesctip.prefab", arg_12_0.viewGO)
end

function var_0_0._onResonanceLevel(arg_13_0, arg_13_1)
	arg_13_0:_openSubViewRight()
end

function var_0_0._onPolarizationLevel(arg_14_0, arg_14_1)
	arg_14_0:_openSubViewRight()
end

function var_0_0._onRougeCoinChange(arg_15_0)
	arg_15_0:_openSubViewRight()
end

function var_0_0._openSubViewRight(arg_16_0)
	arg_16_0:openRougeCoinView()
	arg_16_0:openRougeTongPinView()
	arg_16_0:openRougeGongMingView()
	arg_16_0:openRougeTipDescView()
end

function var_0_0.onOpen(arg_17_0)
	if arg_17_0._isRouge then
		arg_17_0:_openSubViewRight()
	end
end

function var_0_0.onClose(arg_18_0)
	ViewMgr.instance:closeView(ViewName.RougeCollectionOverView)
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0._btnCollection then
		arg_19_0._btnCollection:RemoveClickListener()
	end

	if arg_19_0._loader then
		arg_19_0._loader:dispose()

		arg_19_0._loader = nil
	end
end

return var_0_0

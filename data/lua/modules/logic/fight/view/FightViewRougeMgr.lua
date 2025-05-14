module("modules.logic.fight.view.FightViewRougeMgr", package.seeall)

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

function var_0_0._onResonanceLevel(arg_9_0, arg_9_1)
	arg_9_0:_openSubViewRight()
end

function var_0_0._onPolarizationLevel(arg_10_0, arg_10_1)
	arg_10_0:_openSubViewRight()
end

function var_0_0._onRougeCoinChange(arg_11_0)
	arg_11_0:_openSubViewRight()
end

function var_0_0._openSubViewRight(arg_12_0)
	arg_12_0._subViewRight = arg_12_0._subViewRight or arg_12_0:openSubView(FightViewRougePianzhenGongZhenJinBi, "ui/viewres/rouge/fight/rougebuffview.prefab", gohelper.findChild(arg_12_0.viewGO, "root/rougeBuffRoot"))
end

function var_0_0.onOpen(arg_13_0)
	if arg_13_0._isRouge then
		arg_13_0:_openSubViewRight()
	end
end

function var_0_0.onClose(arg_14_0)
	ViewMgr.instance:closeView(ViewName.RougeCollectionOverView)
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._btnCollection then
		arg_15_0._btnCollection:RemoveClickListener()
	end

	if arg_15_0._loader then
		arg_15_0._loader:dispose()

		arg_15_0._loader = nil
	end
end

return var_0_0

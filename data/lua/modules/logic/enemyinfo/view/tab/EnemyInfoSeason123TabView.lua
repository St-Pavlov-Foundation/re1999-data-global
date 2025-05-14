module("modules.logic.enemyinfo.view.tab.EnemyInfoSeason123TabView", package.seeall)

local var_0_0 = class("EnemyInfoSeason123TabView", UserDataDispose)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goseasontab = gohelper.findChild(arg_1_0.viewGO, "#go_tab_container/#go_season123tab")
	arg_1_0.simagebg = gohelper.findChildSingleImage(arg_1_0.goseasontab, "#simage_bg")
	arg_1_0.golayeritem = gohelper.findChild(arg_1_0.goseasontab, "scroll_layer/Viewport/layer_content/#go_layeritem")

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
	gohelper.setActive(arg_4_0.golayeritem, false)

	arg_4_0.layerItemList = {}

	arg_4_0.simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0.goseasontab, true)

	arg_5_0.actId = arg_5_0.viewParam.activityId
	arg_5_0.stage = arg_5_0.viewParam.stage

	local var_5_0 = Season123Config.instance:getSeasonEpisodeByStage(arg_5_0.actId, arg_5_0.stage)

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = arg_5_0:getLayerItem()

		var_5_1.layer = iter_5_1.layer
		var_5_1.txt.text = string.format("%02d", iter_5_0)
	end

	local var_5_2 = arg_5_0.viewParam.layer or var_5_0[1].layer

	arg_5_0:selectLayer(var_5_2)
end

function var_0_0.getLayerItem(arg_6_0)
	local var_6_0 = arg_6_0:getUserDataTb_()

	var_6_0.go = gohelper.cloneInPlace(arg_6_0.golayeritem)
	var_6_0.txt = gohelper.findChildText(var_6_0.go, "txt")
	var_6_0.goSelect = gohelper.findChild(var_6_0.go, "select")
	var_6_0.click = gohelper.getClickWithDefaultAudio(var_6_0.go)

	var_6_0.click:AddClickListener(arg_6_0.onClickLayerItem, arg_6_0, var_6_0)
	gohelper.setActive(var_6_0.go, true)
	table.insert(arg_6_0.layerItemList, var_6_0)

	return var_6_0
end

function var_0_0.onClickLayerItem(arg_7_0, arg_7_1)
	arg_7_0:selectLayer(arg_7_1.layer)
end

function var_0_0.updateLayerItemSelect(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.layerItemList) do
		gohelper.setActive(iter_8_1.goSelect, iter_8_1.layer == arg_8_0.selectLayerId)
	end
end

function var_0_0.selectLayer(arg_9_0, arg_9_1)
	if arg_9_0.selectLayerId == arg_9_1 then
		return
	end

	arg_9_0.selectLayerId = arg_9_1

	arg_9_0:updateLayerItemSelect()

	local var_9_0 = Season123Config.instance:getSeasonEpisodeCo(arg_9_0.actId, arg_9_0.stage, arg_9_0.selectLayerId)
	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0.episodeId)

	arg_9_0.enemyInfoMo:updateBattleId(var_9_1.battleId)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0.simagebg:UnLoadImage()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.layerItemList) do
		iter_11_1.click:RemoveClickListener()
	end
end

return var_0_0

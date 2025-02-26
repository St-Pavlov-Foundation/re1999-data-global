module("modules.logic.enemyinfo.view.tab.EnemyInfoSeason123TabView", package.seeall)

slot0 = class("EnemyInfoSeason123TabView", UserDataDispose)

function slot0.onInitView(slot0)
	slot0.goseasontab = gohelper.findChild(slot0.viewGO, "#go_tab_container/#go_season123tab")
	slot0.simagebg = gohelper.findChildSingleImage(slot0.goseasontab, "#simage_bg")
	slot0.golayeritem = gohelper.findChild(slot0.goseasontab, "scroll_layer/Viewport/layer_content/#go_layeritem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0.golayeritem, false)

	slot0.layerItemList = {}

	slot0.simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0.goseasontab, true)

	slot0.actId = slot0.viewParam.activityId
	slot0.stage = slot0.viewParam.stage

	for slot5, slot6 in ipairs(Season123Config.instance:getSeasonEpisodeByStage(slot0.actId, slot0.stage)) do
		slot7 = slot0:getLayerItem()
		slot7.layer = slot6.layer
		slot7.txt.text = string.format("%02d", slot5)
	end

	slot0:selectLayer(slot0.viewParam.layer or slot1[1].layer)
end

function slot0.getLayerItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0.golayeritem)
	slot1.txt = gohelper.findChildText(slot1.go, "txt")
	slot1.goSelect = gohelper.findChild(slot1.go, "select")
	slot1.click = gohelper.getClickWithDefaultAudio(slot1.go)

	slot1.click:AddClickListener(slot0.onClickLayerItem, slot0, slot1)
	gohelper.setActive(slot1.go, true)
	table.insert(slot0.layerItemList, slot1)

	return slot1
end

function slot0.onClickLayerItem(slot0, slot1)
	slot0:selectLayer(slot1.layer)
end

function slot0.updateLayerItemSelect(slot0)
	for slot4, slot5 in ipairs(slot0.layerItemList) do
		gohelper.setActive(slot5.goSelect, slot5.layer == slot0.selectLayerId)
	end
end

function slot0.selectLayer(slot0, slot1)
	if slot0.selectLayerId == slot1 then
		return
	end

	slot0.selectLayerId = slot1

	slot0:updateLayerItemSelect()
	slot0.enemyInfoMo:updateBattleId(DungeonConfig.instance:getEpisodeCO(Season123Config.instance:getSeasonEpisodeCo(slot0.actId, slot0.stage, slot0.selectLayerId).episodeId).battleId)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simagebg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.layerItemList) do
		slot5.click:RemoveClickListener()
	end
end

return slot0

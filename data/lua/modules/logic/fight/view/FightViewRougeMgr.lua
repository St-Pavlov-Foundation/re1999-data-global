module("modules.logic.fight.view.FightViewRougeMgr", package.seeall)

slot0 = class("FightViewRougeMgr", BaseViewExtended)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ResonanceLevel, slot0._onResonanceLevel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PolarizationLevel, slot0._onPolarizationLevel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RougeCoinChange, slot0._onRougeCoinChange, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._isRouge = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type == DungeonEnum.EpisodeType.Rouge

	if slot0._isRouge then
		slot0:_addCollectionBtn()
	end
end

function slot0._addCollectionBtn(slot0)
	slot0._loader = PrefabInstantiate.Create(gohelper.findChild(slot0.viewGO, "root/btns"))

	slot0._loader:startLoad("ui/viewres/rouge/fight/rougebtnview.prefab", slot0._onLoaded, slot0)
end

function slot0._onLoaded(slot0)
	slot1 = slot0._loader:getInstGO()

	gohelper.setAsFirstSibling(slot1)

	slot0._btnCollection = gohelper.findChildButtonWithAudio(slot1, "")

	slot0._btnCollection:AddClickListener(slot0._onClickCollection, slot0)
end

function slot0._onClickCollection(slot0)
	RougeController.instance:openRougeCollectionOverView()
end

function slot0.onRefreshViewParam(slot0)
end

function slot0._onResonanceLevel(slot0, slot1)
	slot0:_openSubViewRight()
end

function slot0._onPolarizationLevel(slot0, slot1)
	slot0:_openSubViewRight()
end

function slot0._onRougeCoinChange(slot0)
	slot0:_openSubViewRight()
end

function slot0._openSubViewRight(slot0)
	slot0._subViewRight = slot0._subViewRight or slot0:openSubView(FightViewRougePianzhenGongZhenJinBi, "ui/viewres/rouge/fight/rougebuffview.prefab", gohelper.findChild(slot0.viewGO, "root/rougeBuffRoot"))
end

function slot0.onOpen(slot0)
	if slot0._isRouge then
		slot0:_openSubViewRight()
	end
end

function slot0.onClose(slot0)
	ViewMgr.instance:closeView(ViewName.RougeCollectionOverView)
end

function slot0.onDestroyView(slot0)
	if slot0._btnCollection then
		slot0._btnCollection:RemoveClickListener()
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0

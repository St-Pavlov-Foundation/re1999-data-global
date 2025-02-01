module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionFightEntry", package.seeall)

slot0 = class("V1a6_CachotCollectionFightEntry", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._rootPath = slot1 or ""

	uv0.super.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._rootGo = gohelper.findChild(slot0.viewGO, slot0._rootPath)

	gohelper.setActive(slot0._rootGo, true)

	slot0._btncollection = gohelper.findChildButtonWithAudio(slot0._rootGo, "#btn_collection")
	slot0._txtcollectionnum = gohelper.findChildText(slot0._rootGo, "#btn_collection/bg/#txt_collectionnum")
end

function slot0.addEvents(slot0)
	if slot0._btncollection then
		slot0._btncollection:AddClickListener(slot0._btncollectionOnClick, slot0)
	end

	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueInfo, slot0.refreshUI, slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateCollectionsInfo, slot0.updateCollectionNum, slot0)
end

function slot0.removeEvents(slot0)
	if slot0._btncollection then
		slot0._btncollection:RemoveClickListener()
	end

	slot0:removeEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueInfo, slot0.refreshUI, slot0)
	slot0:removeEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateCollectionsInfo, slot0.updateCollectionNum, slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:updateCollectionNum()
end

function slot0.updateCollectionNum(slot0)
	slot2 = 0

	if V1a6_CachotModel.instance:getRogueInfo() then
		slot2 = slot1.collections and #slot1.collections or 0
	end

	slot0._txtcollectionnum.text = slot2
end

function slot0.onClose(slot0)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotCollectionBagView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotCollectionOverView)
end

function slot0._btncollectionOnClick(slot0)
	if not FightModel.instance:isStartFinish() then
		return
	end

	if V1a6_CachotModel.instance:getRogueInfo() then
		V1a6_CachotController.instance:openV1a6_CachotCollectionBagView({
			isCanEnchant = false
		})
	end
end

return slot0

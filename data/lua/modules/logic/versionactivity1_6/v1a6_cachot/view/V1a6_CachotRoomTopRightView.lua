module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTopRightView", package.seeall)

slot0 = class("V1a6_CachotRoomTopRightView", BaseView)

function slot0.onInitView(slot0)
	slot0._btngroup = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_group")
	slot0._btncollection = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_collection")
	slot0._txtcollectionnum = gohelper.findChildTextMesh(slot0.viewGO, "right/#btn_collection/bg/#txt_collectionnum")
	slot0._gocollectioneffect = gohelper.findChild(slot0.viewGO, "right/#btn_collection/icon_effect")
end

function slot0.addEvents(slot0)
	slot0._btngroup:AddClickListener(slot0._btngroupOnClick, slot0)
	slot0._btncollection:AddClickListener(slot0._btncollectionOnClick, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0._refreshView, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, slot0.updateCollectionNum, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngroup:RemoveClickListener()
	slot0._btncollection:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0._refreshView, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, slot0.updateCollectionNum, slot0)
end

function slot0._btngroupOnClick(slot0)
	V1a6_CachotController.instance:openV1a6_CachotTeamPreView()
end

function slot0._btncollectionOnClick(slot0)
	V1a6_CachotController.instance:openV1a6_CachotCollectionBagView()
end

function slot0.onOpen(slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	slot0:updateCollectionNum()
end

function slot0.updateCollectionNum(slot0)
	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	slot1 = slot0._rogueInfo.collections and #slot0._rogueInfo.collections or 0
	slot0._txtcollectionnum.text = slot1
	slot2 = false

	if slot1 > 0 then
		slot2 = V1a6_CachotCollectionHelper.isCollectionBagCanEnchant()
	end

	gohelper.setActive(slot0._gocollectioneffect, slot2)
end

return slot0

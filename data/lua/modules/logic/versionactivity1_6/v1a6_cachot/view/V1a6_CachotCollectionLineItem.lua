module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionLineItem", package.seeall)

slot0 = class("V1a6_CachotCollectionLineItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._golayout = gohelper.findChild(slot1, "#go_layout")
	slot0._gotop = gohelper.findChild(slot1, "#go_top")
	slot0._imagetitleicon = gohelper.findChildImage(slot1, "#go_top/#image_titleicon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0._mo = slot1

	slot0:_initCloneCollectionItemRes()
	slot0:refreshUI()
end

function slot0._editableInitView(slot0)
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)

	V1a6_CachotCollectionController.instance:registerCallback(V1a6_CachotEvent.OnSwitchCategory, slot0._resetAnimPlayState, slot0)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._gotop, slot0._mo._isTop)
	UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imagetitleicon, "v1a6_cachot_icon_collectionsort" .. slot0._mo.collectionType)
	gohelper.CreateObjList(slot0, slot0._onUpdateCollectionItem, slot0._mo.collectionList, slot0._golayout, slot0._cloneCollectionItemRes, V1a6_CachotCollectionItem)
	slot0:_playAnim()
end

function slot0._onUpdateCollectionItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.viewGO, slot2 ~= nil)

	if slot2 then
		slot1:onUpdateMO(slot2, slot0._index)
	end
end

function slot0._initCloneCollectionItemRes(slot0)
	if not slot0._cloneCollectionItemRes then
		slot0._cloneCollectionItemRes = slot0._view.viewContainer:getRes(ViewMgr.instance:getSetting(slot0._view.viewName).otherRes[1])
	end
end

function slot0._playAnim(slot0)
	if slot0._mo._isTop and not slot0._isPlayOpenAnimFinished then
		slot0._animator:Play("open", 0, 0)

		slot0._isPlayOpenAnimFinished = true
	else
		slot0._animator:Play("idle", 0, 0)
	end
end

function slot0._resetAnimPlayState(slot0)
	slot0._isPlayOpenAnimFinished = false

	slot0:_playAnim()
end

function slot0.onDestroy(slot0)
	slot0._cloneCollectionItemRes = nil

	V1a6_CachotCollectionController.instance:unregisterCallback(V1a6_CachotEvent.OnSwitchCategory, slot0._resetAnimPlayState, slot0)
end

return slot0

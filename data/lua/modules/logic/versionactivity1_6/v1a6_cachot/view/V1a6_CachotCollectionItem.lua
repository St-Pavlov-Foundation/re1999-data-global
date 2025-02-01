module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionItem", package.seeall)

slot0 = class("V1a6_CachotCollectionItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1

	slot0:initComponents()
end

function slot0.initComponents(slot0)
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_collection")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_normal/#simage_collection")
	slot0._imageframe = gohelper.findChildImage(slot0.viewGO, "#go_normal/#image_frame")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._gonotget = gohelper.findChild(slot0.viewGO, "#go_notget")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_normal/#go_new")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_normal/#go_select")
	slot0._canvasgroup = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
	slot0._anim = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, slot0.onSelect, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, slot0.onSelect, slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0._mo then
		V1a6_CachotCollectionController.instance:onSelectCollection(slot0._mo.id)
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	if slot0._mo ~= slot1 then
		slot0._mo = slot1

		UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imageframe, string.format("v1a6_cachot_img_collectionframe%s", slot0._mo.showRare))
		gohelper.setActive(slot0._gonotget, V1a6_CachotCollectionListModel.instance:getCollectionState(slot0._mo.id) == V1a6_CachotEnum.CollectionState.UnLocked)
		gohelper.setActive(slot0._golocked, slot3 == V1a6_CachotEnum.CollectionState.Locked)

		slot0._simagecollection.curImageUrl = nil

		slot0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot0._mo.icon))
		slot0:refreshIconColor(slot3)
		slot0:onSelect()
	end

	slot0:playAnim(slot2)
end

slot0.IconNormalColor = "#FFFFFF"
slot0.IconUnLockColor = "#060606"
slot0.IconUnLockAndUnGetColor = "#5C5C5C"
slot0.UnLockStateItemAlpha = 0.5
slot0.OtherStateItemAlpha = 1

function slot0.refreshIconColor(slot0, slot1)
	slot2 = "#FFFFFF"
	slot3 = uv0.OtherStateItemAlpha

	if slot1 == V1a6_CachotEnum.CollectionState.UnLocked then
		slot2 = uv0.IconUnLockAndUnGetColor
		slot3 = uv0.UnLockStateItemAlpha
	else
		slot2 = (slot1 ~= V1a6_CachotEnum.CollectionState.Locked or uv0.IconUnLockColor) and uv0.IconNormalColor
	end

	slot0._canvasgroup.alpha = slot3

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageicon, slot2)
end

function slot0.onSelect(slot0)
	gohelper.setActive(slot0._goselect, slot0._mo and slot0._mo.id == V1a6_CachotCollectionListModel.instance:getCurSelectCollectionId())
	gohelper.setActive(slot0._gonew, V1a6_CachotCollectionListModel.instance:isCollectionNew(slot0._mo.id))
end

slot1 = 0.06
slot2 = 3

function slot0.playAnim(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.delayPlayCollectionOpenAnim, slot0)

	slot2 = V1a6_CachotCollectionListModel.instance:getCurPlayAnimCellIndex()

	if slot1 and (not slot2 or slot2 <= slot1 and slot1 <= uv0) then
		TaskDispatcher.runDelay(slot0.delayPlayCollectionOpenAnim, slot0, (slot1 - 1) * uv1)
		V1a6_CachotCollectionListModel.instance:markCurPlayAnimCellIndex(slot1)
	end

	gohelper.setActive(slot0.viewGO, not slot3)
end

function slot0.delayPlayCollectionOpenAnim(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0._anim:Play("v1a6_cachot_collectionitem_open", 0, 0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayCollectionOpenAnim, slot0)
	slot0._simagecollection:UnLoadImage()
	slot0:__onDispose()
end

return slot0

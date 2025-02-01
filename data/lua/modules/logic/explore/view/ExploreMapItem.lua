module("modules.logic.explore.view.ExploreMapItem", package.seeall)

slot0 = class("ExploreMapItem", LuaCompBase)
slot1 = typeof(UnityEngine.UI.Mask)
slot2 = {
	"explore_map_img_mask7",
	"explore_map_img_mask6",
	"explore_map_img_mask8",
	"explore_map_img_mask5",
	"explore_map_img_mask3",
	"explore_map_img_mask1",
	"explore_map_img_mask4",
	"explore_map_img_mask2"
}

function slot0.ctor(slot0, slot1)
	slot0._mo = slot1
	slot0._nowIconRotate = 0
	slot0._isShowIcon = false
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot1:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
	slot2 = gohelper.findChild(slot1, "image_left")
	slot3 = gohelper.findChild(slot1, "image_right")
	slot4 = gohelper.findChild(slot1, "image_top")
	slot5 = gohelper.findChild(slot1, "image_bottom")

	if gohelper.findChild(slot1, "typemask") then
		slot0._maskComp = slot6:GetComponent(uv0)
		slot0._maskImageComp = slot6:GetComponent(gohelper.Type_Image)
	end

	slot0._type = gohelper.findChildImage(slot1, "type") or gohelper.findChildImage(slot1, "typemask/type")
	slot0._icon = gohelper.findChildImage(slot1, "icon")
	slot0._leftTrans = slot2.transform
	slot0._rightTrans = slot3.transform
	slot0._topTrans = slot4.transform
	slot0._bottomTrans = slot5.transform

	slot0:updateMo(slot0._mo)
end

function slot0.updateMo(slot0, slot1)
	gohelper.setActive(slot0.go, true)

	slot0._mo = slot1

	gohelper.setActive(slot0._leftTrans, slot0._mo.left)
	gohelper.setActive(slot0._rightTrans, slot0._mo.right)
	gohelper.setActive(slot0._topTrans, slot0._mo.top)
	gohelper.setActive(slot0._bottomTrans, slot0._mo.bottom)

	if slot0._maskComp then
		if slot0._mo.bound then
			slot0._maskComp.enabled = true
			slot0._maskImageComp.enabled = true

			UISpriteSetMgr.instance:setExploreSprite(slot0._maskImageComp, uv0[slot0._mo.bound])
		else
			slot0._maskComp.enabled = false
			slot0._maskImageComp.enabled = false
		end
	end

	transformhelper.setLocalPosXY(slot0.go.transform, slot0._mo.posX, slot0._mo.posY)

	if ExploreMapModel.instance:getNode(slot0._mo.key) then
		UISpriteSetMgr.instance:setExploreSprite(slot0._type, "dungeon_secretroom_landbg_" .. slot2.nodeType)
	end

	slot0:updateOutLineIcon()

	if slot0._mo.rotate then
		slot0:updateRotate()
	end
end

function slot0.updateRotate(slot0)
	if not slot0._isShowIcon or not slot0._mo.rotate or slot0._nowIconRotate == ExploreMapModel.instance.nowMapRotate then
		return
	end

	slot0._nowIconRotate = ExploreMapModel.instance.nowMapRotate

	transformhelper.setLocalRotation(slot0._icon.transform, 0, 0, -ExploreMapModel.instance.nowMapRotate)
end

slot3 = Color.clear
slot4 = Color.white

function slot0.updateOutLineIcon(slot0)
	if not slot0._mo.bound and ExploreMapModel.instance:getSmallMapIcon(slot0._mo.key) then
		UISpriteSetMgr.instance:setExploreSprite(slot0._icon, slot1)

		slot0._icon.color = uv0
		slot0._isShowIcon = true
	else
		slot0._icon.color = uv1
		slot0._isShowIcon = false
	end
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.markUse(slot0, slot1)
	slot0._isUse = slot1
end

function slot0.getIsUse(slot0)
	return slot0._isUse
end

function slot0.setScale(slot0, slot1)
	if slot0._mo.left then
		transformhelper.setLocalScale(slot0._leftTrans, slot1, 1, 1)
	end

	if slot0._mo.right then
		transformhelper.setLocalScale(slot0._rightTrans, slot1, 1, 1)
	end

	if slot0._mo.top then
		transformhelper.setLocalScale(slot0._topTrans, slot1, 1, 1)
	end

	if slot0._mo.bottom then
		transformhelper.setLocalScale(slot0._bottomTrans, slot1, 1, 1)
	end
end

return slot0

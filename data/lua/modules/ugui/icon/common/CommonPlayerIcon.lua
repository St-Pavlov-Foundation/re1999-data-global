module("modules.ugui.icon.common.CommonPlayerIcon", package.seeall)

slot0 = class("CommonPlayerIcon", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._simageheadicon = gohelper.findChildSingleImage(slot0.go, "bg/#simage_headicon")
	slot0._goframenode = gohelper.findChild(slot0.go, "bg/#simage_headicon/#go_framenode")
	slot0._golevel = gohelper.findChild(slot0.go, "#go_level")
	slot0._imgLevelbg = gohelper.findChildImage(slot0.go, "#go_level")
	slot0._txtlevel = gohelper.findChildText(slot0.go, "#go_level/#txt_level")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "#btn_click")
	slot0._loader = MultiAbLoader.New()
	slot0._enableClick = true
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0.setEnableClick(slot0, slot1)
	slot0._enableClick = slot1
end

function slot0.isSelectInFriend(slot0, slot1)
	slot0._isSelectInFriend = slot1
end

function slot0.setPlayerIconGray(slot0, slot1)
	slot0._liveHeadIcon:setGray(slot1)
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.tr, slot1, slot1, slot1)
end

function slot0.setPos(slot0, slot1, slot2, slot3)
	if not slot0[slot1] then
		return
	end

	recthelper.setAnchor(slot0[slot1].transform, slot2, slot3)
end

function slot0._onClick(slot0)
	if not slot0._enableClick then
		return
	end

	if slot0._isSelectInFriend then
		-- Nothing
	end

	ViewMgr.instance:openView(ViewName.PlayerInfoView, {
		mo = slot0._mo,
		worldPos = slot0._simageheadicon.transform.position,
		isSelectInFriend = slot0._isSelectInFriend
	})
end

function slot0._refreshUI(slot0)
	slot0._txtlevel.text = "Lv." .. slot0._mo.level

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheadicon)
	end

	slot0._liveHeadIcon:setLiveHead(slot0._mo.portrait)

	if slot0._mo.userId == PlayerModel.instance:getMyUserId() then
		slot0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerinfo, slot0._changePlayerinfo, slot0)
	else
		slot0:removeEventCb(PlayerController.instance, PlayerEvent.ChangePlayerinfo, slot0._changePlayerinfo, slot0)
	end
end

function slot0._onLoadCallback(slot0)
	slot0.isloading = false

	gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")

	slot0.frame = gohelper.findChild(slot0._goframenode, "frame")
	slot0.frame:GetComponent(gohelper.Type_Image).enabled = false
	slot5 = 1.41 * recthelper.getWidth(slot0._simageheadicon.transform) / recthelper.getWidth(slot0.frame.transform)

	transformhelper.setLocalScale(slot0.frame.transform, slot5, slot5, 1)
end

function slot0._changePlayerinfo(slot0)
	slot0._mo = SocialModel.instance:getPlayerMO(slot0._mo.userId)

	slot0:_refreshUI()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()
	slot0:refreshFrame()
end

function slot0.refreshFrame(slot0)
	if #string.split(lua_item.configDict[slot0._mo.portrait].effect, "#") > 1 then
		if slot1.id == tonumber(slot2[#slot2]) then
			gohelper.setActive(slot0._goframenode, true)

			if not slot0.frame and not slot0.isloading then
				slot0.isloading = true

				slot0._loader:addPath("ui/viewres/common/effect/frame.prefab")
				slot0._loader:startLoad(slot0._onLoadCallback, slot0)
			end
		end
	else
		gohelper.setActive(slot0._goframenode, false)
	end
end

function slot0.setMOValue(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._mo = SocialPlayerMO.New()

	slot0._mo:init({
		userId = slot1,
		name = slot2,
		level = slot3,
		portrait = slot4,
		time = slot5,
		bg = slot6
	})
	slot0:_refreshUI()
	slot0:setShowLevel(true)
end

function slot0.setShowLevel(slot0, slot1)
	gohelper.setActive(slot0._golevel, slot1)
end

function slot0.getLevelBg(slot0)
	return slot0._imgLevelbg
end

function slot0.onDestroy(slot0)
	slot0._simageheadicon:UnLoadImage()

	slot0._simageheadicon = nil

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0

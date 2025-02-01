module("modules.logic.turnback.invitation.view.TurnBackInvitationFriendItem", package.seeall)

slot0 = class("TurnBackInvitationFriendItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0._txtName = gohelper.findChildTextMesh(slot1, "invited/namebg/#txt_name")
	slot0._goInvited = gohelper.findChild(slot1, "invited")
	slot0._goUnInvite = gohelper.findChild(slot1, "uninvite")
	slot0._simgHeadIcon = gohelper.findChildSingleImage(slot1, "invited/#go_playerheadicon")
	slot0._goframenode = gohelper.findChild(slot1, "invited/#go_playerheadicon/#go_framenode")
	slot0._loader = MultiAbLoader.New()
end

function slot0.setData(slot0, slot1)
	slot0._roleInfo = slot1

	slot0:_refreshItem()
end

function slot0.setEmpty(slot0)
	slot0:setInfoState(false)
end

function slot0.setInfoState(slot0, slot1)
	gohelper.setActive(slot0._goInvited, slot1)
	gohelper.setActive(slot0._goUnInvite, not slot1)
end

function slot0._refreshItem(slot0)
	if slot0._roleInfo == nil then
		logError("Player Info is nil")
		slot0:setEmpty()

		return
	end

	slot0:setInfoState(true)

	slot0._txtName.text = slot1.name
	slot2 = lua_item.configDict[slot1.portrait]

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simgHeadIcon)
	end

	slot0._liveHeadIcon:setLiveHead(slot2.id)

	if #string.split(slot2.effect, "#") > 1 then
		if slot2.id == tonumber(slot3[#slot3]) then
			gohelper.setActive(slot0._goframenode, true)

			if not slot0.frame then
				slot0._loader:addPath("ui/viewres/common/effect/frame.prefab")
				slot0._loader:startLoad(slot0._onLoadCallback, slot0)
			end
		end
	else
		gohelper.setActive(slot0._goframenode, false)
	end
end

function slot0._onLoadCallback(slot0)
	gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")

	slot0.frame = gohelper.findChild(slot0._goframenode, "frame")
	slot0.frame:GetComponent(gohelper.Type_Image).enabled = false
	slot5 = 1.41 * recthelper.getWidth(slot0._simgHeadIcon.transform) / recthelper.getWidth(slot0.frame.transform)

	transformhelper.setLocalScale(slot0.frame.transform, slot5, slot5, 1)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.destroy(slot0)
	slot0:__onDispose()
	slot0._simgHeadIcon:UnLoadImage()

	slot0._roleInfo = nil
end

return slot0

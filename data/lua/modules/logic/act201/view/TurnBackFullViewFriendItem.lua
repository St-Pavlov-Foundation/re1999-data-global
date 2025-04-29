module("modules.logic.act201.view.TurnBackFullViewFriendItem", package.seeall)

slot0 = class("TurnBackFullViewFriendItem", RougeSimpleItemBase)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._txtName = gohelper.findChildTextMesh(slot0.viewGO, "invited/namebg/#txt_name")
	slot0._goInvited = gohelper.findChild(slot0.viewGO, "invited")
	slot0._goUnInvite = gohelper.findChild(slot0.viewGO, "uninvite")
	slot0._simgHeadIcon = gohelper.findChildSingleImage(slot0.viewGO, "invited/#go_playerheadicon")
	slot0._goframenode = gohelper.findChild(slot0.viewGO, "invited/#go_playerheadicon/#go_framenode")
	slot0._txtstatetext = gohelper.findChildText(slot0.viewGO, "invited/playerstate/#txt_statetext")
	slot0._txtframenum1 = gohelper.findChildText(slot0.viewGO, "uninvite/frame/#txt_framenum")
	slot0._txtframenum2 = gohelper.findChildText(slot0.viewGO, "invited/frame/#txt_framenum")
	slot0._txtframenum1.text = ""
	slot0._txtframenum2.text = ""
	slot0._loader = MultiAbLoader.New()
end

function slot0.setData(slot0, slot1)
	slot0._roleInfo = slot1

	slot0:_refreshItem()
end

function slot0.setEmpty(slot0)
	slot0:setInfoState(false)
	slot0:_refreshItemNum()
end

function slot0.setInfoState(slot0, slot1)
	gohelper.setActive(slot0._goInvited, slot1)
	gohelper.setActive(slot0._goUnInvite, not slot1)
end

function slot0._refreshItem(slot0)
	if slot0._roleInfo == nil then
		slot0:setEmpty()

		return
	end

	slot0:setInfoState(true)
	slot0:_refreshItemNum()

	slot0._txtName.text = slot1.name
	slot0._txtstatetext.text = Activity201Config.instance:getRoleTypeStr(slot1.roleType)
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
	slot0._simgHeadIcon:UnLoadImage()

	slot0._roleInfo = nil

	slot0:disposeLoader()
	slot0:__onDispose()
end

function slot0.onDestroyView(slot0)
	slot0:destroy()
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0._refreshItemNum(slot0)
	slot1 = slot0._index < 10 and "0" .. slot0._index or slot0._index
	slot0._txtframenum1.text = slot1
	slot0._txtframenum2.text = slot1
end

function slot0.disposeLoader(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0

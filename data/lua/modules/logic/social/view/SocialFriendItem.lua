module("modules.logic.social.view.SocialFriendItem", package.seeall)

slot0 = class("SocialFriendItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._goskinbg = gohelper.findChild(slot0.viewGO, "#go_skinbg")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_normal/#go_bg")
	slot0._imagegobg = gohelper.findChildImage(slot0.viewGO, "#go_normal/#go_bg")
	slot0._gobgselect = gohelper.findChild(slot0.viewGO, "#go_normal/#go_bgselect")
	slot0._imagegoselectbg = gohelper.findChildImage(slot0.viewGO, "#go_normal/#go_bgselect")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "#go_playericon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "name/#txt_name")
	slot0._txtnameoffline = gohelper.findChildText(slot0.viewGO, "name/#txt_nameoffline")
	slot0._txtstatus = gohelper.findChildText(slot0.viewGO, "status/#txt_status")
	slot0._txtofflinetime = gohelper.findChildText(slot0.viewGO, "status/#txt_offlinetime")
	slot0._friendreddot = gohelper.findChild(slot0.viewGO, "#go_friendreddot")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	SocialModel.instance:setSelectFriend(slot0._mo.userId)
end

function slot0._editableInitView(slot0)
	slot0._playericon = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericon)

	slot0:addEventCb(SocialController.instance, SocialEvent.SelectFriend, slot0._onFriendSelect, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.FriendDescChange, slot0.updateName, slot0)
end

function slot0._refreshUI(slot0)
	slot0._playericon:onUpdateMO(slot0._mo)
	slot0._playericon:setShowLevel(true)
	slot0._playericon:isSelectInFriend(slot0:_isSelectFriend())

	if RedDotModel.instance:getDotInfo(RedDotEnum.DotNode.FriendInfoDetail, tonumber(slot0._mo.userId)) then
		RedDotController.instance:addRedDot(slot0._friendreddot, RedDotEnum.DotNode.FriendInfoDetail, tonumber(slot0._mo.userId))
	end

	gohelper.setActive(slot0._txtstatus.gameObject, tonumber(slot0._mo.time) == 0)
	gohelper.setActive(slot0._txtofflinetime.gameObject, tonumber(slot0._mo.time) ~= 0)
	gohelper.setActive(slot0._txtname.gameObject, tonumber(slot0._mo.time) == 0)
	gohelper.setActive(slot0._txtnameoffline.gameObject, tonumber(slot0._mo.time) ~= 0)
	slot0._playericon:setPlayerIconGray(tonumber(slot0._mo.time) ~= 0)

	if tonumber(slot0._mo.time) ~= 0 then
		slot0._txtofflinetime.text = SocialConfig.instance:getStatusText(slot0._mo.time)
	end

	slot0:updateName()

	slot0._txtstatus.text = luaLang("social_online")

	slot0:_loadBg(slot0._mo.bg)
	slot0:_onFriendSelect()
end

function slot0._loadBg(slot0, slot1)
	if not slot1 or slot1 == 0 then
		slot0._hasSkin = false
	else
		slot0._hasSkin = true

		if not slot0.lastskinId or slot0.lastskinId ~= slot1 then
			slot0._skinPath = string.format("ui/viewres/social/socialfrienditem_bg_%s.prefab", slot1)

			slot0:_disposeBg()

			slot0._loader = MultiAbLoader.New()

			slot0._loader:addPath(slot0._skinPath)
			slot0._loader:startLoad(slot0._onLoadFinish, slot0)
		end
	end

	gohelper.setActive(slot0._gonormal, not slot0._hasSkin)
	gohelper.setActive(slot0._goskinbg, slot0._hasSkin)
end

function slot0._disposeBg(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._goskinEffect then
		gohelper.destroy(slot0._goskinEffect)

		slot0._goskinEffect = nil
	end
end

function slot0._onLoadFinish(slot0)
	slot0._goskinEffect = gohelper.clone(slot0._loader:getAssetItem(slot0._skinPath):GetResource(slot0._skinPath), slot0._goskinbg)
	slot0.lastskinId = slot0._mo.bg
end

function slot0.setBgState(slot0, slot1)
	if not slot0._isplaycard then
		slot4 = slot0:_isSelectFriend()

		gohelper.setActive(gohelper.findChild(slot1, "offline"), not slot4)
		gohelper.setActive(gohelper.findChild(slot1, "online"), slot4)
	else
		gohelper.setActive(slot3, false)
		gohelper.setActive(slot2, true)
	end
end

function slot0.selectSkin(slot0, slot1)
	slot0._isplaycard = true

	slot0:_loadBg(slot1)
end

function slot0.updateName(slot0, slot1)
	if slot1 and slot1 ~= slot0._mo.id then
		return
	end

	slot2 = slot0._mo and slot0._mo.name or ""

	if slot0:_isSelectFriend() then
		if not string.nilorempty(slot0._mo.desc) then
			slot0._txtname.text = "<size=32><color=#c66030>" .. slot2 .. "<color=#5c574d>(" .. slot0._mo.desc .. ")"
			slot0._txtnameoffline.text = "<size=32><color=#c66030>" .. slot2 .. "<color=#5c574d>(" .. slot0._mo.desc .. ")"
		else
			slot0._txtname.text = "<size=38><color=#c66030>" .. slot2
			slot0._txtnameoffline.text = "<size=38><color=#222222>" .. slot2
		end

		slot0._txtstatus.text = "<color=#56A165>" .. slot0._txtstatus.text
	else
		if not string.nilorempty(slot0._mo.desc) then
			slot0._txtname.text = "<size=32><color=#404040>" .. slot2 .. "<color=#5c574d>(" .. slot0._mo.desc .. ")"
			slot0._txtnameoffline.text = "<size=32><color=#222222>" .. slot2 .. "<color=#5c574d>(" .. slot0._mo.desc .. ")"
		else
			slot0._txtname.text = "<size=38><color=#404040>" .. slot2
			slot0._txtnameoffline.text = "<size=38><color=#222222>" .. slot2
		end

		slot0._txtstatus.text = "<color=#4E7656>" .. slot0._txtstatus.text
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()
end

slot1 = Color.New(1, 1, 1, 1)
slot2 = Color.New(1, 1, 1, 0.7)

function slot0._onFriendSelect(slot0)
	slot2 = slot0._mo.userId == SocialModel.instance:getSelectFriend()

	gohelper.setActive(slot0._gobg, not slot2)
	gohelper.setActive(slot0._gobgselect, slot2)
	gohelper.setActive(slot0._goarrow, slot2)
	slot0._playericon:isSelectInFriend(slot0:_isSelectFriend())
	slot0:updateName()
	slot0:setBgState(slot0._goskinEffect)
end

function slot0._isSelectFriend(slot0)
	if slot0._mo.userId == SocialModel.instance:getSelectFriend() then
		return true
	end

	return false
end

function slot0.onDestroy(slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.SelectFriend, slot0._onFriendSelect, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.FriendDescChange, slot0.updateName, slot0)
end

return slot0

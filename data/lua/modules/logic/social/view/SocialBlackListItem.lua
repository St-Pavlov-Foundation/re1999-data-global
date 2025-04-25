module("modules.logic.social.view.SocialBlackListItem", package.seeall)

slot0 = class("SocialBlackListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "#go_playericon")
	slot0._goskinbg = gohelper.findChild(slot0.viewGO, "#go_skinbg")
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "bg")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtstatus = gohelper.findChildText(slot0.viewGO, "status/#txt_status")
	slot0._txtofflinetime = gohelper.findChildText(slot0.viewGO, "status/#txt_offlinetime")
	slot0._btnremove = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_remove")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnremove:AddClickListener(slot0._btnremoveOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnremove:RemoveClickListener()
end

function slot0._btnremoveOnClick(slot0)
	FriendRpc.instance:sendRemoveBlacklistRequest(slot0._mo.userId)
end

function slot0._editableInitView(slot0)
	slot0._playericon = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericon)
end

function slot0._refreshUI(slot0)
	slot0._playericon:onUpdateMO(slot0._mo)
	slot0._playericon:setShowLevel(true)

	slot0._txtname.text = slot0._mo.name

	gohelper.setActive(slot0._txtstatus.gameObject, tonumber(slot0._mo.time) == 0)
	gohelper.setActive(slot0._txtofflinetime.gameObject, tonumber(slot0._mo.time) ~= 0)

	if tonumber(slot0._mo.time) ~= 0 then
		slot0._txtofflinetime.text = SocialConfig.instance:getStatusText(slot0._mo.time)
	end

	slot0._txtstatus.text = luaLang("social_online")

	slot0:_loadBg()
end

function slot0._loadBg(slot0)
	if not slot0._mo.bg or slot0._mo.bg == 0 then
		slot0._hasSkin = false
	else
		slot0._hasSkin = true

		if not slot0.lastskinId or slot0.lastskinId ~= slot0._mo.bg then
			slot0._skinPath = string.format("ui/viewres/social/socialblacklistitem_bg_%s.prefab", slot0._mo.bg)

			slot0:_disposeBg()

			slot0._loader = MultiAbLoader.New()

			slot0._loader:addPath(slot0._skinPath)
			slot0._loader:startLoad(slot0._onLoadFinish, slot0)
		end
	end

	gohelper.setActive(slot0._imagebg.gameObject, not slot0._hasSkin)
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

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()
end

function slot0.onDestroy(slot0)
end

return slot0

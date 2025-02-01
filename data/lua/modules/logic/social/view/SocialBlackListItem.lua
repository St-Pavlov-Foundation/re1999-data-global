module("modules.logic.social.view.SocialBlackListItem", package.seeall)

slot0 = class("SocialBlackListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "#go_playericon")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
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

	if not slot0._mo.bg or slot0._mo.bg == 0 then
		gohelper.setActive(slot0._simagebg, false)
	else
		gohelper.setActive(slot0._simagebg, true)
		slot0._simagebg:LoadImage(string.format("singlebg/playerinfo/%s.png", PlayerConfig.instance:getBgCo(slot0._mo.bg).chatbg))
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()
end

function slot0.onDestroy(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0

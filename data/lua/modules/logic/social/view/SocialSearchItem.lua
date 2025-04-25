module("modules.logic.social.view.SocialSearchItem", package.seeall)

slot0 = class("SocialSearchItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "#go_playericon")
	slot0._goskinbg = gohelper.findChild(slot0.viewGO, "#go_skinbg")
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "image_ItemBG")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtuid = gohelper.findChildText(slot0.viewGO, "#txt_uid")
	slot0._txtstatus = gohelper.findChildText(slot0.viewGO, "status/#txt_status")
	slot0._txtofflinetime = gohelper.findChildText(slot0.viewGO, "status/#txt_offlinetime")
	slot0._goofflinebg = gohelper.findChild(slot0.viewGO, "status/bg")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_add")
	slot0._gosent = gohelper.findChild(slot0.viewGO, "#go_sent")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._anim.keepAnimatorControllerStateOnDisable = true

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadd:RemoveClickListener()
end

function slot0._btnaddOnClick(slot0)
	SocialController.instance:AddFriend(slot0._mo.userId, slot0._addCallback, slot0)
end

function slot0._addCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 or slot2 == -310 then
		slot0._mo:setAddedFriend()
		gohelper.setActive(slot0._btnadd.gameObject, false)
		gohelper.setActive(slot0._gosent, true)
	end
end

function slot0._editableInitView(slot0)
	slot0._heros = {}
	slot0._heroParents = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0._heroParents[slot4] = gohelper.findChild(slot0.viewGO, "Role/" .. slot4)
	end

	gohelper.addUIClickAudio(slot0._btnadd.gameObject, AudioEnum.UI.UI_Common_Click)

	slot0._playericon = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericon)
end

function slot0._refreshUI(slot0)
	slot0._playericon:onUpdateMO(slot0._mo)
	slot0._playericon:setShowLevel(true)

	slot1 = tostring(slot0._mo.userId)
	slot2 = slot1

	if GameUtil.utf8len(slot1) > 3 then
		slot2 = GameUtil.utf8sub(slot1, slot3 - 2, slot3)
	end

	slot0._txtname.text = string.format("%s#%s", slot0._mo.name, slot2)
	slot0._txtuid.text = string.format(slot1)
	slot4 = slot0._mo:isSendAddFriend()
	slot5 = tonumber(slot0._mo.time) == 0

	gohelper.setActive(slot0._btnadd, not slot4)
	gohelper.setActive(slot0._gosent, slot4)
	gohelper.setActive(slot0._txtstatus, slot5)
	gohelper.setActive(slot0._txtofflinetime, not slot5)

	if not slot5 then
		slot0._txtofflinetime.text = SocialConfig.instance:getStatusText(slot0._mo.time)
	end

	gohelper.setActive(slot0._goofflinebg, not slot5)

	slot0._txtstatus.text = luaLang("social_online")

	slot0:_loadBg()
end

function slot0._loadBg(slot0)
	if not slot0._mo.bg or slot0._mo.bg == 0 then
		slot0._hasSkin = false
	else
		slot0._hasSkin = true

		if not slot0.lastskinId or slot0.lastskinId ~= slot0._mo.bg then
			slot0._skinPath = string.format("ui/viewres/social/socialsearchitem_bg_%s.prefab", slot0._mo.bg)

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
	TaskDispatcher.cancelTask(slot0._delayPlaySwtich, slot0)
	gohelper.setActive(slot0.viewGO, true)

	if UnityEngine.Time.realtimeSinceStartup - SocialModel.instance.playSearchItemAnimDt - (slot0._index - 1) * 0.1 >= 0.5 then
		slot0._anim:Play("open", 0, 1)
	elseif slot3 < 0 then
		gohelper.setActive(slot0.viewGO, false)
		TaskDispatcher.runDelay(slot0._delayPlaySwtich, slot0, -slot3)
	else
		slot0._anim:Play("switch", 0, slot3)
	end

	slot0._mo = slot1

	slot0:_refreshUI()

	for slot9 = 1, 3 do
		if slot9 <= #(slot1.infos or {}) then
			slot0:getHeroIcon(slot9):updateMo(slot4[slot9])
		else
			slot10:setActive(false)
		end
	end
end

function slot0._delayPlaySwtich(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0._anim:Play("switch", 0, 0)
	slot0._anim:Update(0)
end

function slot0.getHeroIcon(slot0, slot1)
	if not slot0._heros[slot1] then
		slot0._heros[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst("ui/viewres/social/socialheroitem.prefab", slot0._heroParents[slot1], "HeroItem"), SocialHeroItem)
	end

	return slot0._heros[slot1]
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayPlaySwtich, slot0)
end

return slot0

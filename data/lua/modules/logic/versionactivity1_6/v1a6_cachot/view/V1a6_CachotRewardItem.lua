module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRewardItem", package.seeall)

slot0 = class("V1a6_CachotRewardItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._txtnum = gohelper.findChildTextMesh(slot1, "#txt_num")
	slot0._txtname = gohelper.findChildTextMesh(slot1, "#txt_name")
	slot0._txtdesc = gohelper.findChildTextMesh(slot1, "scroll_dec/Viewport/Content/#txt_dec")
	slot0._scrollreward = gohelper.findChild(slot1, "scroll_dec"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._imagebg = gohelper.findChildImage(slot1, "#simage_bg")
	slot0._simagecollection = gohelper.findChildSingleImage(slot1, "#simage_collection")
	slot0._imageicon = gohelper.findChildImage(slot1, "#simage_icon")
	slot0._btnComfirm = gohelper.findChildButtonWithAudio(slot1, "#btn_comfirm")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))

	slot0._anim:Play("open", 0, 0)

	slot0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._txtdesc.gameObject, FixTmpBreakLine)
	slot0._goenchantlist = gohelper.findChild(slot1, "#go_enchantlist")
	slot0._gohole = gohelper.findChild(slot1, "#go_enchantlist/#go_hole")
end

function slot0.addEventListeners(slot0)
	slot0._btnComfirm:AddClickListener(slot0._getReward, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnComfirm:RemoveClickListener()
end

function slot0._getReward(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_award_charge)
	slot0._anim:Play("close", 0, 0)
	UIBlockMgr.instance:startBlock("V1a6_CachotRewardItem_Get")
	TaskDispatcher.runDelay(slot0._delaySendReq, slot0, 0.367)
end

function slot0._delaySendReq(slot0)
	UIBlockMgr.instance:endBlock("V1a6_CachotRewardItem_Get")

	if not V1a6_CachotRoomModel.instance:getNowTopEventMo() then
		return
	end

	if slot0._collections then
		if #slot0._collections == 1 then
			RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, slot1.eventId, slot0._mo.idx, 1)
		else
			V1a6_CachotController.instance:openV1a6_CachotCollectionSelectView({
				selectCallback = slot0.onCollectionSelect,
				selectCallbackObj = slot0,
				collectionList = slot0._collections
			})
		end
	else
		RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, slot1.eventId, slot0._mo.idx)
	end
end

function slot0.onCollectionSelect(slot0, slot1)
	if not V1a6_CachotRoomModel.instance:getNowTopEventMo() or not slot0._mo then
		return
	end

	RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, slot2.eventId, slot0._mo.idx, slot1)
end

function slot0.updateMo(slot0, slot1, slot2)
	slot0._scrollreward.parentGameObject = slot2

	if slot0._mo then
		slot0._anim:Play("idle", 0, 0)
	end

	slot0._mo = slot1
	slot3 = false
	slot0._collections = nil
	slot0._imageicon.enabled = false

	slot0._simagecollection:UnLoadImage()
	gohelper.setActive(slot0._simagecollection, false)
	gohelper.setActive(slot0._goenchantlist, false)

	slot4 = false
	slot5, slot6 = nil

	if slot1.type == "COIN" then
		if slot1.valuePercent and slot1.valuePercent > 0 then
			slot1.value = math.floor(V1a6_CachotModel.instance:getRogueInfo().coin * slot1.valuePercent / 1000)
		end

		slot3 = true

		gohelper.setActive(slot0._simagecollection, true)
		slot0._simagecollection:LoadImage(ResUrl.getCurrencyItemIcon(lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Currency][V1a6_CachotEnum.DropCurrencyType.Coin].icon))

		slot4 = true
	elseif slot1.type == "CURRENCY" then
		slot3 = true

		gohelper.setActive(slot0._simagecollection, true)
		slot0._simagecollection:LoadImage(ResUrl.getCurrencyItemIcon(lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Currency][V1a6_CachotEnum.DropCurrencyType.Currency].icon))

		slot4 = true
	elseif slot1.type == "COLLECTION" then
		slot7 = slot1.colletionList
		slot0._collections = slot7

		if #slot7 == 1 then
			if lua_rogue_collection.configDict[slot7[1]] then
				gohelper.setActive(slot0._simagecollection, true)
				gohelper.setActive(slot0._goenchantlist, true)
				slot0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot8.icon))

				slot0._txtname.text = slot8.name
				slot0._txtdesc.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(slot8)

				slot0._fixTmpBreakLine:refreshTmpContent(slot0._txtdesc)

				slot0._txtnum.text = ""

				V1a6_CachotCollectionHelper.createCollectionHoles(slot8, slot0._goenchantlist, slot0._gohole)
			end

			UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imagebg, lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Collection][1].iconbg)
		else
			slot5 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.SelectCollection][1]
		end
	elseif slot1.type == "EVENT" then
		slot5, slot6 = V1a6_CachotEventConfig.instance:getDescCoByEventId(slot1.value)
	end

	if slot5 then
		slot0._txtname.text = slot5.title
		slot0._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(slot6 or slot5.desc)

		slot0._fixTmpBreakLine:refreshTmpContent(slot0._txtdesc)

		if slot3 then
			slot0._txtnum.text = luaLang("multiple") .. slot1.value
		else
			slot0._txtnum.text = ""
		end

		UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imagebg, slot5.iconbg)

		if not slot4 then
			slot0._imageicon.enabled = true

			UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imageicon, slot5.icon)
		end
	end
end

function slot0.onDestroy(slot0)
	if slot0._simagecollection then
		slot0._simagecollection:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0._delaySendReq, slot0)
	UIBlockMgr.instance:endBlock("V1a6_CachotRewardItem_Get")
end

return slot0

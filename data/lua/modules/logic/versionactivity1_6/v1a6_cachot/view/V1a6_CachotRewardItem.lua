module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRewardItem", package.seeall)

local var_0_0 = class("V1a6_CachotRewardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_1, "#txt_num")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "#txt_name")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_1, "scroll_dec/Viewport/Content/#txt_dec")
	arg_1_0._scrollreward = gohelper.findChild(arg_1_1, "scroll_dec"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._imagebg = gohelper.findChildImage(arg_1_1, "#simage_bg")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_1, "#simage_collection")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "#simage_icon")
	arg_1_0._btnComfirm = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_comfirm")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0._anim:Play("open", 0, 0)

	arg_1_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._txtdesc.gameObject, FixTmpBreakLine)
	arg_1_0._goenchantlist = gohelper.findChild(arg_1_1, "#go_enchantlist")
	arg_1_0._gohole = gohelper.findChild(arg_1_1, "#go_enchantlist/#go_hole")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnComfirm:AddClickListener(arg_2_0._getReward, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnComfirm:RemoveClickListener()
end

function var_0_0._getReward(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_award_charge)
	arg_4_0._anim:Play("close", 0, 0)
	UIBlockMgr.instance:startBlock("V1a6_CachotRewardItem_Get")
	TaskDispatcher.runDelay(arg_4_0._delaySendReq, arg_4_0, 0.367)
end

function var_0_0._delaySendReq(arg_5_0)
	UIBlockMgr.instance:endBlock("V1a6_CachotRewardItem_Get")

	local var_5_0 = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if not var_5_0 then
		return
	end

	if arg_5_0._collections then
		if #arg_5_0._collections == 1 then
			RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, var_5_0.eventId, arg_5_0._mo.idx, 1)
		else
			local var_5_1 = {
				selectCallback = arg_5_0.onCollectionSelect,
				selectCallbackObj = arg_5_0,
				collectionList = arg_5_0._collections
			}

			V1a6_CachotController.instance:openV1a6_CachotCollectionSelectView(var_5_1)
		end
	else
		RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, var_5_0.eventId, arg_5_0._mo.idx)
	end
end

function var_0_0.onCollectionSelect(arg_6_0, arg_6_1)
	local var_6_0 = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if not var_6_0 or not arg_6_0._mo then
		return
	end

	RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, var_6_0.eventId, arg_6_0._mo.idx, arg_6_1)
end

function var_0_0.updateMo(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._scrollreward.parentGameObject = arg_7_2

	if arg_7_0._mo then
		arg_7_0._anim:Play("idle", 0, 0)
	end

	arg_7_0._mo = arg_7_1

	local var_7_0 = false

	arg_7_0._collections = nil
	arg_7_0._imageicon.enabled = false

	arg_7_0._simagecollection:UnLoadImage()
	gohelper.setActive(arg_7_0._simagecollection, false)
	gohelper.setActive(arg_7_0._goenchantlist, false)

	local var_7_1 = false
	local var_7_2
	local var_7_3

	if arg_7_1.type == "COIN" then
		if arg_7_1.valuePercent and arg_7_1.valuePercent > 0 then
			arg_7_1.value = math.floor(V1a6_CachotModel.instance:getRogueInfo().coin * arg_7_1.valuePercent / 1000)
		end

		var_7_2 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Currency][V1a6_CachotEnum.DropCurrencyType.Coin]
		var_7_0 = true

		gohelper.setActive(arg_7_0._simagecollection, true)
		arg_7_0._simagecollection:LoadImage(ResUrl.getCurrencyItemIcon(var_7_2.icon))

		var_7_1 = true
	elseif arg_7_1.type == "CURRENCY" then
		var_7_2 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Currency][V1a6_CachotEnum.DropCurrencyType.Currency]
		var_7_0 = true

		gohelper.setActive(arg_7_0._simagecollection, true)
		arg_7_0._simagecollection:LoadImage(ResUrl.getCurrencyItemIcon(var_7_2.icon))

		var_7_1 = true
	elseif arg_7_1.type == "COLLECTION" then
		local var_7_4 = arg_7_1.colletionList

		arg_7_0._collections = var_7_4

		if #var_7_4 == 1 then
			local var_7_5 = lua_rogue_collection.configDict[var_7_4[1]]

			if var_7_5 then
				gohelper.setActive(arg_7_0._simagecollection, true)
				gohelper.setActive(arg_7_0._goenchantlist, true)
				arg_7_0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_7_5.icon))

				arg_7_0._txtname.text = var_7_5.name
				arg_7_0._txtdesc.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(var_7_5)

				arg_7_0._fixTmpBreakLine:refreshTmpContent(arg_7_0._txtdesc)

				arg_7_0._txtnum.text = ""

				V1a6_CachotCollectionHelper.createCollectionHoles(var_7_5, arg_7_0._goenchantlist, arg_7_0._gohole)
			end

			local var_7_6 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Collection][1]

			UISpriteSetMgr.instance:setV1a6CachotSprite(arg_7_0._imagebg, var_7_6.iconbg)
		else
			var_7_2 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.SelectCollection][1]
		end
	elseif arg_7_1.type == "EVENT" then
		var_7_2, var_7_3 = V1a6_CachotEventConfig.instance:getDescCoByEventId(arg_7_1.value)
	end

	if var_7_2 then
		arg_7_0._txtname.text = var_7_2.title
		arg_7_0._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(var_7_3 or var_7_2.desc)

		arg_7_0._fixTmpBreakLine:refreshTmpContent(arg_7_0._txtdesc)

		if var_7_0 then
			arg_7_0._txtnum.text = luaLang("multiple") .. arg_7_1.value
		else
			arg_7_0._txtnum.text = ""
		end

		UISpriteSetMgr.instance:setV1a6CachotSprite(arg_7_0._imagebg, var_7_2.iconbg)

		if var_7_1 then
			-- block empty
		else
			arg_7_0._imageicon.enabled = true

			UISpriteSetMgr.instance:setV1a6CachotSprite(arg_7_0._imageicon, var_7_2.icon)
		end
	end
end

function var_0_0.onDestroy(arg_8_0)
	if arg_8_0._simagecollection then
		arg_8_0._simagecollection:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_8_0._delaySendReq, arg_8_0)
	UIBlockMgr.instance:endBlock("V1a6_CachotRewardItem_Get")
end

return var_0_0

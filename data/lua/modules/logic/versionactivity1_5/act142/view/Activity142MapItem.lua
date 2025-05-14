module("modules.logic.versionactivity1_5.act142.view.Activity142MapItem", package.seeall)

local var_0_0 = class("Activity142MapItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._clickCb = arg_1_1.clickCb
	arg_1_0._clickCbObj = arg_1_1.clickCbObj
	arg_1_0._starItemList = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_2_0._go)
	arg_2_0._golock = gohelper.findChild(arg_2_0._go, "#go_lock")
	arg_2_0._simagemaplock = gohelper.findChildImage(arg_2_0._go, "#go_lock/mask/#simage_maplock")
	arg_2_0._gonormal = gohelper.findChild(arg_2_0._go, "#go_normal")
	arg_2_0._gonormalbg = gohelper.findChild(arg_2_0._go, "#go_normal/#simage_normalbg")
	arg_2_0._gosinglebg = gohelper.findChild(arg_2_0._go, "#go_normal/#simage_singlebg")
	arg_2_0._simagemap = gohelper.findChildImage(arg_2_0._go, "#go_normal/mask/#simage_map")
	arg_2_0._characternum = gohelper.findChildText(arg_2_0._go, "#txt_characternum")
	arg_2_0._txtmap = gohelper.findChildText(arg_2_0._go, "#txt_map")
	arg_2_0._gostarts = gohelper.findChild(arg_2_0._go, "#go_starts")
	arg_2_0._gostartitem = gohelper.findChild(arg_2_0._go, "#go_starts/#go_startitem")

	gohelper.setActive(arg_2_0._gostartitem, false)

	arg_2_0._btnclickarea = gohelper.findChildButtonWithAudio(arg_2_0._go, "#btn_clickarea")
	arg_2_0._btnreplay = gohelper.findChildButtonWithAudio(arg_2_0._go, "#btn_replay")

	arg_2_0:setEpisodeId()
	arg_2_0:setBg(false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnreplay:AddClickListener(arg_3_0._btnreplayOnClick, arg_3_0)
	arg_3_0._btnclickarea:AddClickListener(arg_3_0._onClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnreplay:RemoveClickListener()
	arg_4_0._btnclickarea:RemoveClickListener()
end

function var_0_0._btnreplayOnClick(arg_5_0)
	if not arg_5_0._episodeId then
		return
	end

	Activity142Controller.instance:openStoryView(arg_5_0._episodeId)
end

function var_0_0._onClick(arg_6_0)
	if not arg_6_0._episodeId or not arg_6_0._clickCb then
		return
	end

	arg_6_0._clickCb(arg_6_0._clickCbObj, arg_6_0._episodeId)
end

function var_0_0.setEpisodeId(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:cancelAllTaskDispatcher()

	arg_7_0._episodeId = arg_7_1

	if not arg_7_0._episodeId then
		gohelper.setActive(arg_7_0._go, false)

		return
	end

	gohelper.setActive(arg_7_0._go, true)

	local var_7_0 = Activity142Model.instance:getActivityId()
	local var_7_1 = Activity142Config.instance:getEpisodeOrder(var_7_0, arg_7_0._episodeId) or ""
	local var_7_2 = Activity142Config.instance:getEpisodeName(var_7_0, arg_7_0._episodeId) or ""

	arg_7_0._characternum.text = var_7_1
	arg_7_0._txtmap.text = var_7_2

	local var_7_3 = Activity142Config.instance:getEpisodeNormalSP(var_7_0, arg_7_0._episodeId)

	if var_7_3 then
		UISpriteSetMgr.instance:setV1a5ChessSprite(arg_7_0._simagemap, var_7_3)
	end

	local var_7_4 = Activity142Config.instance:getEpisodeLockSP(var_7_0, arg_7_0._episodeId)

	if var_7_4 then
		UISpriteSetMgr.instance:setV1a5ChessSprite(arg_7_0._simagemaplock, var_7_4)
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._starItemList) do
		gohelper.setActive(iter_7_1.go, false)
	end

	local var_7_5 = Activity142Config.instance:getEpisodeMaxStar(var_7_0, arg_7_0._episodeId)

	for iter_7_2 = 1, var_7_5 do
		local var_7_6 = arg_7_0._starItemList[iter_7_2] or arg_7_0:_addStarItem()

		gohelper.setActive(var_7_6.go, true)
		gohelper.setActive(var_7_6.grayGO, true)
		gohelper.setActive(var_7_6.lightGO, false)
		gohelper.setActive(var_7_6.lightEffectGO, false)
	end

	arg_7_0:refresh(arg_7_2)
end

function var_0_0._addStarItem(arg_8_0)
	local var_8_0 = #arg_8_0._starItemList + 1
	local var_8_1 = arg_8_0:getUserDataTb_()

	var_8_1.go = gohelper.clone(arg_8_0._gostartitem, arg_8_0._gostarts, "star" .. var_8_0)
	var_8_1.grayGO = gohelper.findChild(var_8_1.go, "#go_gray")
	var_8_1.lightGO = gohelper.findChild(var_8_1.go, "#go_light")
	var_8_1.lightAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(var_8_1.lightGO)
	var_8_1.lightEffectGO = gohelper.findChild(var_8_1.go, "#go_light/xing")
	arg_8_0._starItemList[var_8_0] = var_8_1

	ZProj.UGUIHelper.RebuildLayout(arg_8_0._gostarts.transform)

	return var_8_1
end

function var_0_0.setParent(arg_9_0, arg_9_1)
	if gohelper.isNil(arg_9_0._go) or gohelper.isNil(arg_9_1) then
		return
	end

	arg_9_0._go.transform:SetParent(arg_9_1.transform, false)
end

function var_0_0.setBg(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._gosinglebg, arg_10_1)
	gohelper.setActive(arg_10_0._gonormalbg, not arg_10_1)
end

function var_0_0.refresh(arg_11_0, arg_11_1)
	if not arg_11_0._episodeId then
		return
	end

	arg_11_0:_refreshUnlock(arg_11_1)
	arg_11_0:_refreshStar()
	arg_11_0:_refreshReplayBtn()
end

function var_0_0._refreshUnlock(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._animatorPlayer and arg_12_0._animatorPlayer.isActiveAndEnabled

	if var_12_0 then
		arg_12_0._animatorPlayer:Play(Activity142Enum.MAP_ITEM_IDLE_ANIM)
	end

	local var_12_1 = Activity142Model.instance:getActivityId()
	local var_12_2 = Activity142Model.instance:isEpisodeOpen(var_12_1, arg_12_0._episodeId)
	local var_12_3 = string.format("%s_%s", Activity142Enum.MAP_ITEM_CACHE_KEY, arg_12_0._episodeId)

	if arg_12_0._episodeId ~= Activity142Enum.AUTO_ENTER_EPISODE_ID and not Activity142Controller.instance:havePlayedUnlockAni(var_12_3) and var_12_0 and var_12_2 then
		arg_12_0:playMapItemUnlockAnim(arg_12_1)
	else
		gohelper.setActive(arg_12_0._gonormal, var_12_2)
		gohelper.setActive(arg_12_0._golock, not var_12_2)
	end
end

function var_0_0._refreshStar(arg_13_0)
	local var_13_0 = Activity142Model.instance:getEpisodeData(arg_13_0._episodeId)

	if not var_13_0 then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._starItemList) do
		if iter_13_1.lightAnimatorPlayer then
			iter_13_1.lightAnimatorPlayer:Play(Activity142Enum.MAP_STAR_IDLE_ANIM)
		end

		local var_13_1 = string.format("%s_%s_%s", Activity142Enum.MAP_STAR_CACHE_KEY, arg_13_0._episodeId, iter_13_0)
		local var_13_2 = not Activity142Controller.instance:havePlayedUnlockAni(var_13_1)
		local var_13_3 = iter_13_0 <= var_13_0.star

		if var_13_2 and iter_13_1.lightAnimatorPlayer and var_13_3 then
			Activity142Helper.setAct142UIBlock(true, Activity142Enum.EPISODE_STAR_UNLOCK)
			UIBlockMgrExtend.setNeedCircleMv(false)
			gohelper.setActive(iter_13_1.grayGO, true)
			gohelper.setActive(iter_13_1.lightGO, true)
			iter_13_1.lightAnimatorPlayer:Play(Activity142Enum.MAP_STAR_OPEN_ANIM, arg_13_0._finishStarItemUnlockAnim, {
				self = arg_13_0,
				index = iter_13_0
			})
		else
			gohelper.setActive(iter_13_1.grayGO, not var_13_3)
			gohelper.setActive(iter_13_1.lightGO, var_13_3)
		end
	end
end

function var_0_0._finishStarItemUnlockAnim(arg_14_0)
	if not arg_14_0 or not arg_14_0.self or not arg_14_0.self._episodeId or not arg_14_0.index then
		return
	end

	local var_14_0 = arg_14_0.self
	local var_14_1 = var_14_0._episodeId
	local var_14_2 = arg_14_0.index
	local var_14_3 = string.format("%s_%s_%s", Activity142Enum.MAP_STAR_CACHE_KEY, var_14_1, var_14_2)

	Activity142Controller.instance:setPlayedUnlockAni(var_14_3)
	var_14_0:_endBlock(true)
end

function var_0_0._refreshReplayBtn(arg_15_0)
	local var_15_0 = Activity142Model.instance:getActivityId()
	local var_15_1 = Va3ChessConfig.instance:isStoryEpisode(var_15_0, arg_15_0._episodeId)
	local var_15_2 = Activity142Config.instance:getEpisodeStoryList(var_15_0, arg_15_0._episodeId)
	local var_15_3 = Activity142Model.instance:isEpisodeClear(arg_15_0._episodeId)

	gohelper.setActive(arg_15_0._btnreplay.gameObject, var_15_3 and not var_15_1 and #var_15_2 > 0)
end

function var_0_0.playMapItemUnlockAnim(arg_16_0, arg_16_1)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.MAP_ITEM_UNLOCK)
	gohelper.setActive(arg_16_0._golock, true)
	gohelper.setActive(arg_16_0._gonormal, false)

	if arg_16_1 and arg_16_1 > 0 then
		TaskDispatcher.runDelay(arg_16_0._delayPlayMapItemUnlockAnim, arg_16_0, arg_16_1)
	else
		arg_16_0:_delayPlayMapItemUnlockAnim()
	end
end

function var_0_0._delayPlayMapItemUnlockAnim(arg_17_0)
	gohelper.setActive(arg_17_0._gonormal, true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
	arg_17_0._animatorPlayer:Play(Activity142Enum.CATEGORY_UNLOCK_ANIM, arg_17_0._finishMapItemUnlockAnim, arg_17_0)
end

function var_0_0._finishMapItemUnlockAnim(arg_18_0)
	local var_18_0 = string.format("%s_%s", Activity142Enum.MAP_ITEM_CACHE_KEY, arg_18_0._episodeId)

	Activity142Controller.instance:setPlayedUnlockAni(var_18_0)
	arg_18_0:_endBlock()
end

function var_0_0._endBlock(arg_19_0, arg_19_1)
	local var_19_0 = Activity142Enum.MAP_ITEM_UNLOCK

	if arg_19_1 then
		var_19_0 = Activity142Enum.EPISODE_STAR_UNLOCK
	end

	Activity142Helper.setAct142UIBlock(false, var_19_0)
end

function var_0_0.onDestroy(arg_20_0)
	arg_20_0._episodeId = nil
	arg_20_0.clickCb = nil
	arg_20_0.clickCbObj = nil
	arg_20_0._starItemList = {}

	arg_20_0:cancelAllTaskDispatcher()
	arg_20_0:_endBlock()
	arg_20_0:_endBlock(true)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.cancelAllTaskDispatcher(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._delayPlayMapItemUnlockAnim, arg_21_0)
end

return var_0_0

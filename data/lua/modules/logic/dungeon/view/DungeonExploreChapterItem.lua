module("modules.logic.dungeon.view.DungeonExploreChapterItem", package.seeall)

local var_0_0 = class("DungeonExploreChapterItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._imageselectlevel = gohelper.findChildImage(arg_1_1, "#go_selected/image_level")
	arg_1_0._imageunselectlevel = gohelper.findChildImage(arg_1_1, "#go_unselected/image_level")
	arg_1_0._goselected = gohelper.findChild(arg_1_1, "#go_selected")
	arg_1_0._gounselected = gohelper.findChild(arg_1_1, "#go_unselected")
	arg_1_0._golocked = gohelper.findChild(arg_1_1, "#go_locked")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_1, "#btn_click")
	arg_1_0._txtselectname = gohelper.findChildTextMesh(arg_1_1, "#go_selected/txt_levelname")
	arg_1_0._txtselectnameEn = gohelper.findChildTextMesh(arg_1_1, "#go_selected/Text")
	arg_1_0._txtunselectname = gohelper.findChildTextMesh(arg_1_1, "#go_unselected/txt_levelname")
	arg_1_0._gonew = gohelper.findChild(arg_1_1, "#go_unselected/go_unselectednew")
	arg_1_0._goselectStar = gohelper.findChild(arg_1_1, "#go_selected/#simage_star")
	arg_1_0._gounselectStar = gohelper.findChild(arg_1_1, "#go_unselected/#simage_star")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0._btnclick:AddClickListener(arg_1_0._click, arg_1_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, arg_1_0.onChapterClick, arg_1_0)
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._index = arg_2_2
	arg_2_0._config = arg_2_1
	arg_2_0._txtselectname.text = arg_2_1.name
	arg_2_0._txtunselectname.text = arg_2_1.name
	arg_2_0._txtselectnameEn.text = arg_2_1.name_En

	UISpriteSetMgr.instance:setExploreSprite(arg_2_0._imageselectlevel, "dungeon_secretroom_img_select" .. tostring(arg_2_2))
	UISpriteSetMgr.instance:setExploreSprite(arg_2_0._imageunselectlevel, "dungeon_secretroom_img_unselect" .. tostring(arg_2_2))

	local var_2_0 = ExploreSimpleModel.instance:isChapterCoinFull(arg_2_1.id)
	local var_2_1 = not ExploreSimpleModel.instance:getChapterIsUnLock(arg_2_1.id)
	local var_2_2 = true

	if not var_2_1 then
		var_2_2 = ExploreSimpleModel.instance:getChapterIsShowUnlock(arg_2_1.id)
	end

	gohelper.setActive(arg_2_0._gonew, not var_2_0 and ExploreSimpleModel.instance:getChapterIsNew(arg_2_1.id))
	gohelper.setActive(arg_2_0._goselectStar, var_2_0)
	gohelper.setActive(arg_2_0._gounselectStar, var_2_0)
	gohelper.setActive(arg_2_0._golocked, var_2_1)

	if not var_2_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
		ExploreSimpleModel.instance:markChapterShowUnlock(arg_2_1.id)
		gohelper.setActive(arg_2_0._golocked, true)
		gohelper.setActive(arg_2_0._gounselected, true)

		arg_2_0._showingUnlock = true

		TaskDispatcher.runDelay(arg_2_0._unlockFinish, arg_2_0, 1.3)
		arg_2_0._anim:Play("unlock", 0, 0)
	else
		arg_2_0._showingUnlock = false

		TaskDispatcher.cancelTask(arg_2_0._unlockFinish, arg_2_0)
		arg_2_0._anim:Play("idle", 0, 0)
	end

	ExploreSimpleModel.instance:markChapterNew(arg_2_0._config.id)

	arg_2_0._isLock = var_2_1
end

function var_0_0._unlockFinish(arg_3_0)
	arg_3_0._showingUnlock = false

	gohelper.setActive(arg_3_0._golocked, false)
	TaskDispatcher.cancelTask(arg_3_0._unlockFinish, arg_3_0)
	arg_3_0._anim:Play("idle", 0, 0)
end

function var_0_0._click(arg_4_0)
	if arg_4_0._isLock then
		local var_4_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_4_0._config.id)[1]
		local var_4_1 = var_4_0 and lua_episode.configDict[var_4_0.preEpisode]
		local var_4_2 = ""
		local var_4_3 = ""

		if var_4_1 then
			var_4_2 = lua_chapter.configDict[var_4_1.chapterId].name
			var_4_3 = var_4_1.name
		end

		GameFacade.showToast(ExploreConstValue.Toast.ExploreChapterLock, var_4_2, var_4_3)

		return
	end

	gohelper.setActive(arg_4_0._gonew, false)
	ExploreSimpleModel.instance:markChapterNew(arg_4_0._config.id)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnChapterClick, arg_4_0._index)
end

function var_0_0.onChapterClick(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goselected, arg_5_1 == arg_5_0._index and not arg_5_0._isLock)
	gohelper.setActive(arg_5_0._gounselected, arg_5_1 ~= arg_5_0._index and not arg_5_0._isLock)

	if arg_5_1 == arg_5_0._index then
		gohelper.setActive(arg_5_0._gonew, false)
	end

	if arg_5_1 == arg_5_0._index and not arg_5_0._isLock and arg_5_0._showingUnlock then
		arg_5_0:_unlockFinish()
	end
end

function var_0_0.destroy(arg_6_0)
	arg_6_0:_unlockFinish()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnChapterClick, arg_6_0.onChapterClick, arg_6_0)
	arg_6_0._btnclick:RemoveClickListener()

	arg_6_0._index = 0
	arg_6_0._config = nil
	arg_6_0._goselected = nil
	arg_6_0._gounselected = nil
	arg_6_0._btnclick = nil
	arg_6_0._txtselectname = nil
	arg_6_0._txtunselectname = nil
end

return var_0_0

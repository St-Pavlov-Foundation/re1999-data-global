module("modules.logic.versionactivity1_5.act142.view.Activity142MapCategoryItem", package.seeall)

local var_0_0 = class("Activity142MapCategoryItem", LuaCompBase)
local var_0_1 = 1

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._index = arg_1_1.index
	arg_1_0._clickCb = arg_1_1.clickCb
	arg_1_0._clickCbObj = arg_1_1.clickCbObj
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_2_0._go)
	arg_2_0._golock = gohelper.findChild(arg_2_0._go, "#go_lock")
	arg_2_0._simagelock = gohelper.findChildImage(arg_2_0._go, "#go_lock")
	arg_2_0._txtlock = gohelper.findChildText(arg_2_0._go, "#go_lock/#txt_lock")
	arg_2_0._gounlock = gohelper.findChild(arg_2_0._go, "#go_unlock")
	arg_2_0._gonormal = gohelper.findChild(arg_2_0._go, "#go_unlock/#go_normal")
	arg_2_0._simagenormal = gohelper.findChildImage(arg_2_0._go, "#go_unlock/#go_normal")
	arg_2_0._txtnormal = gohelper.findChildText(arg_2_0._go, "#go_unlock/#go_normal/#txt_normal")
	arg_2_0._goselect = gohelper.findChild(arg_2_0._go, "#go_unlock/#go_select")
	arg_2_0._simageselect = gohelper.findChildImage(arg_2_0._go, "#go_unlock/#go_select")
	arg_2_0._txtselect = gohelper.findChildText(arg_2_0._go, "#go_unlock/#go_select/#txt_select")
	arg_2_0._btncategory = gohelper.findChildButtonWithAudio(arg_2_0._go, "#btn_click")

	arg_2_0:setChapterId()
	arg_2_0:setIsSelected(false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btncategory:AddClickListener(arg_3_0.onClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btncategory:RemoveClickListener()
end

function var_0_0.onClick(arg_5_0, arg_5_1)
	if arg_5_0._isSelected or not arg_5_0._chapterId or not arg_5_0._index then
		return
	end

	if not arg_5_0:isChapterOpen() then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	if arg_5_0._clickCb then
		arg_5_0._clickCb(arg_5_0._clickCbObj, arg_5_0._index, arg_5_1)
	end
end

function var_0_0.setChapterId(arg_6_0, arg_6_1)
	arg_6_0:cancelAllTaskDispatcher()

	arg_6_0._chapterId = arg_6_1

	if arg_6_0._chapterId then
		local var_6_0 = Activity142Model.instance:getActivityId()
		local var_6_1 = Activity142Config.instance:getChapterName(var_6_0, arg_6_0._chapterId)

		arg_6_0._txtnormal.text = var_6_1
		arg_6_0._txtselect.text = var_6_1

		local var_6_2 = Activity142Config.instance:getChapterCategoryTxtColor(var_6_0, arg_6_0._chapterId)

		if var_6_2 then
			local var_6_3 = GameUtil.parseColor(var_6_2)

			arg_6_0._txtnormal.color = var_6_3
			arg_6_0._txtselect.color = var_6_3
		end

		local var_6_4 = Activity142Config.instance:getChapterCategoryNormalSP(var_6_0, arg_6_0._chapterId)

		if var_6_4 then
			UISpriteSetMgr.instance:setV1a5ChessSprite(arg_6_0._simagenormal, var_6_4)
		end

		local var_6_5 = Activity142Config.instance:getChapterCategorySelectSP(var_6_0, arg_6_0._chapterId)

		if var_6_5 then
			UISpriteSetMgr.instance:setV1a5ChessSprite(arg_6_0._simageselect, var_6_5)
		end

		local var_6_6 = Activity142Config.instance:getChapterCategoryLockSP(var_6_0, arg_6_0._chapterId)

		if var_6_6 then
			UISpriteSetMgr.instance:setV1a5ChessSprite(arg_6_0._simagelock, var_6_6)
		end

		arg_6_0:refresh()
		arg_6_0:setIsSelected(false)
	end

	gohelper.setActive(arg_6_0._go, arg_6_0._chapterId)
end

function var_0_0.getChapterId(arg_7_0)
	return arg_7_0._chapterId
end

function var_0_0.refresh(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._animatorPlayer and arg_8_0._animatorPlayer.isActiveAndEnabled

	if var_8_0 then
		arg_8_0._animatorPlayer:Play(Activity142Enum.CATEGORY_IDLE_ANIM)
	end

	local var_8_1 = arg_8_0:isChapterOpen()
	local var_8_2 = string.format("%s_%s", Activity142Enum.CATEGORY_CACHE_KEY, arg_8_0._chapterId)

	if arg_8_0._chapterId ~= Activity142Enum.NOT_PLAY_UNLOCK_ANIM_CHAPTER and not Activity142Controller.instance:havePlayedUnlockAni(var_8_2) and var_8_0 and var_8_1 then
		arg_8_0:playUnlockAnim(arg_8_1)
	else
		gohelper.setActive(arg_8_0._gounlock, var_8_1)
		gohelper.setActive(arg_8_0._golock, not var_8_1)
	end
end

function var_0_0.setIsSelected(arg_9_0, arg_9_1)
	arg_9_0._isSelected = arg_9_1

	gohelper.setActive(arg_9_0._goselect, arg_9_0._isSelected)
	gohelper.setActive(arg_9_0._gonormal, not arg_9_0._isSelected)
end

function var_0_0.isChapterOpen(arg_10_0)
	return (Activity142Model.instance:isChapterOpen(arg_10_0._chapterId))
end

function var_0_0.playUnlockAnim(arg_11_0, arg_11_1)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.MAP_CATEGORY_UNLOCK)
	gohelper.setActive(arg_11_0._golock, true)
	gohelper.setActive(arg_11_0._gounlock, false)

	if arg_11_1 and arg_11_1 > 0 then
		TaskDispatcher.runDelay(arg_11_0._delayPlayUnlockAnim, arg_11_0, arg_11_1)
	else
		arg_11_0:_delayPlayUnlockAnim()
	end
end

function var_0_0._delayPlayUnlockAnim(arg_12_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	gohelper.setActive(arg_12_0._gounlock, true)
	TaskDispatcher.runDelay(arg_12_0.playUnlockAudio, arg_12_0, var_0_1)
	arg_12_0._animatorPlayer:Play(Activity142Enum.MAP_ITEM_UNLOCK_ANIM, arg_12_0._finishUnlockAnim, arg_12_0)
end

function var_0_0.playUnlockAudio(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockChapter)
end

function var_0_0._finishUnlockAnim(arg_14_0)
	local var_14_0 = string.format("%s_%s", Activity142Enum.CATEGORY_CACHE_KEY, arg_14_0._chapterId)

	Activity142Controller.instance:setPlayedUnlockAni(var_14_0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.MAP_CATEGORY_UNLOCK)
end

function var_0_0.onDestroy(arg_15_0)
	arg_15_0._index = nil
	arg_15_0._chapterId = nil
	arg_15_0._clickCb = nil
	arg_15_0._clickCbObj = nil
	arg_15_0._isSelected = false

	arg_15_0:cancelAllTaskDispatcher()
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.MAP_CATEGORY_UNLOCK)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.cancelAllTaskDispatcher(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayPlayUnlockAnim, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.playUnlockAudio, arg_16_0)
end

return var_0_0

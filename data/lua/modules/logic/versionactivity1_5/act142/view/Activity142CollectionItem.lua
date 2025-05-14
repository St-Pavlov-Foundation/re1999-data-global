module("modules.logic.versionactivity1_5.act142.view.Activity142CollectionItem", package.seeall)

local var_0_0 = class("Activity142CollectionItem", LuaCompBase)
local var_0_1 = 0.25

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0._go)
	arg_1_0._goUnlock = gohelper.findChild(arg_1_0._go, "go_unlocked")
	arg_1_0._collectionIcon = gohelper.findChildImage(arg_1_0._go, "go_unlocked/icon_bg/collection_icon")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0._go, "go_unlocked/middle/#txt_name")
	arg_1_0._txtNameEn = gohelper.findChildText(arg_1_0._go, "go_unlocked/middle/#txt_en")
	arg_1_0._scrollDesc = gohelper.findChild(arg_1_0._go, "go_unlocked/#scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0._go, "go_unlocked/#scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._txtUnlockIndex = gohelper.findChildText(arg_1_0._go, "go_unlocked/#txt_index")
	arg_1_0._goLock = gohelper.findChild(arg_1_0._go, "go_locked")
	arg_1_0._txtLockIndex = gohelper.findChildText(arg_1_0._go, "go_locked/#txt_index")
	arg_1_0._goRightLine = gohelper.findChild(arg_1_0._go, "line")
	arg_1_0._index = nil
	arg_1_0._collectionId = nil
	arg_1_0._isLast = false
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._index = arg_2_1
	arg_2_0._collectionId = arg_2_2
	arg_2_0._isLast = arg_2_3
	arg_2_0._parentScrollGO = arg_2_4

	arg_2_0:refresh()
	gohelper.setActive(arg_2_0._go, arg_2_0._collectionId)
end

function var_0_0.onStart(arg_3_0)
	if not arg_3_0._collectionId then
		return
	end

	arg_3_0:refresh()
end

function var_0_0.refresh(arg_4_0)
	if not arg_4_0._collectionId or gohelper.isNil(arg_4_0._go) then
		return
	end

	if arg_4_0._parentScrollGO then
		arg_4_0._scrollDesc.parentGameObject = arg_4_0._parentScrollGO
	end

	arg_4_0._scrollDesc.horizontalNormalizedPosition = 0

	local var_4_0 = Activity142Model.instance:getActivityId()
	local var_4_1 = Activity142Config.instance:getCollectionCfg(var_4_0, arg_4_0._collectionId, true)

	if not var_4_1 then
		return
	end

	local var_4_2 = Activity142Model.instance:isHasCollection(arg_4_0._collectionId)

	if var_4_2 then
		arg_4_0._txtDesc.text = var_4_1.desc
		arg_4_0._txtName.text = var_4_1.name
		arg_4_0._txtNameEn.text = var_4_1.nameen

		arg_4_0:loadIcon(var_4_1.icon)
	end

	local var_4_3 = arg_4_0._animatorPlayer and arg_4_0._animatorPlayer.isActiveAndEnabled

	if var_4_3 then
		arg_4_0._animatorPlayer:Play(Activity142Enum.COLLECTION_IDLE_ANIM)
	end

	local var_4_4 = string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, arg_4_0._collectionId)

	if not Activity142Controller.instance:havePlayedUnlockAni(var_4_4) and var_4_3 and var_4_2 then
		Activity142Helper.setAct142UIBlock(true, Activity142Enum.COLLECTION_UNLOCK)
		gohelper.setActive(arg_4_0._goLock, true)
		gohelper.setActive(arg_4_0._goUnlock, true)
		TaskDispatcher.runDelay(arg_4_0.playUnlockAudio, arg_4_0, var_0_1)
		arg_4_0._animatorPlayer:Play(Activity142Enum.COLLECTION_UNLOCK_ANIM, arg_4_0._finishUnlockAnim, arg_4_0)
	else
		gohelper.setActive(arg_4_0._goUnlock, var_4_2)
		gohelper.setActive(arg_4_0._goLock, not var_4_2)
	end

	local var_4_5 = string.format("%02d", arg_4_0._collectionId)

	arg_4_0._txtUnlockIndex.text = var_4_5
	arg_4_0._txtLockIndex.text = var_4_5

	gohelper.setActive(arg_4_0._goRightLine, arg_4_0._isLast)
end

function var_0_0.playUnlockAudio(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
end

function var_0_0._finishUnlockAnim(arg_6_0)
	local var_6_0 = string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, arg_6_0._collectionId)

	Activity142Controller.instance:setPlayedUnlockAni(var_6_0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.COLLECTION_UNLOCK)
end

function var_0_0.loadIcon(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	UISpriteSetMgr.instance:setV1a5ChessSprite(arg_7_0._collectionIcon, arg_7_1)
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0._index = nil
	arg_8_0._collectionId = nil
	arg_8_0._isLast = false

	TaskDispatcher.cancelTask(arg_8_0.playUnlockAudio, arg_8_0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.COLLECTION_UNLOCK)
end

return var_0_0

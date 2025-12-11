module("modules.logic.necrologiststory.view.NecrologistStoryReviewView", package.seeall)

local var_0_0 = class("NecrologistStoryReviewView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBgCg = gohelper.findChild(arg_1_0.viewGO, "#go_bgcg")
	arg_1_0.bgCgCtrl = arg_1_0._goBgCg:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_1_0.animBgCg = arg_1_0._goBgCg:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goUnlockedBg = gohelper.findChild(arg_1_0._goBgCg, "unlocked")
	arg_1_0._unlocksimagecgbg = gohelper.findChildSingleImage(arg_1_0._goUnlockedBg, "#simage_cgbg")
	arg_1_0._unlockimagecgbg = gohelper.findChildImage(arg_1_0._goUnlockedBg, "#simage_cgbg")
	arg_1_0._goLockedBg = gohelper.findChild(arg_1_0._goBgCg, "locked")
	arg_1_0._locksimagecgbg = gohelper.findChildSingleImage(arg_1_0._goLockedBg, "bgmask/#simage_cgbg")
	arg_1_0._lockimagecgbg = gohelper.findChildImage(arg_1_0._goLockedBg, "bgmask/#simage_cgbg")
	arg_1_0.goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_content")
	arg_1_0.goItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_content/Viewport/Content/goItem")
	arg_1_0.goItem1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_content/Viewport/Content/go_item1")
	arg_1_0.goItem2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_content/Viewport/Content/go_item2")

	gohelper.setActive(arg_1_0.goItem, false)
	gohelper.setActive(arg_1_0.goItem1, false)
	gohelper.setActive(arg_1_0.goItem2, false)

	arg_1_0.itemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickStoryItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.plotCo

	if not var_5_0 then
		return
	end

	if not arg_5_0.gameMo:isStoryFinish(var_5_0.id) then
		return
	end

	arg_5_0.selectId = var_5_0.id

	NecrologistStoryController.instance:openStoryView(var_5_0.id)
	arg_5_0:refreshStoryList()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshRoleStoryBg()
	arg_6_0:refreshStoryList()
end

function var_0_0.refreshParam(arg_7_0)
	arg_7_0.storyId = arg_7_0.viewParam.roleStoryId
	arg_7_0.cgUnlock = arg_7_0.viewParam.cgUnlock
	arg_7_0.gameMo = NecrologistStoryModel.instance:getGameMO(arg_7_0.storyId)
end

function var_0_0.refreshStoryList(arg_8_0)
	if arg_8_0.cgUnlock then
		gohelper.setActive(arg_8_0.goContent, false)

		return
	end

	gohelper.setActive(arg_8_0.goContent, true)

	local var_8_0 = NecrologistStoryConfig.instance:getPlotListByStoryId(arg_8_0.storyId)

	for iter_8_0 = 1, math.max(#var_8_0, #arg_8_0.itemList) do
		local var_8_1 = arg_8_0:createItem(iter_8_0)

		arg_8_0:refreshItem(var_8_1, var_8_0[iter_8_0])
	end
end

function var_0_0.createItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.itemList[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()
		var_9_0.index = arg_9_1

		local var_9_1 = arg_9_0.goItem1

		if arg_9_1 % 2 == 0 then
			var_9_1 = arg_9_0.goItem2
		end

		var_9_0.goParent = gohelper.cloneInPlace(var_9_1, tostring(arg_9_1))
		var_9_0.go = gohelper.clone(arg_9_0.goItem, var_9_0.goParent, "item")

		gohelper.setActive(var_9_0.go, true)

		var_9_0.normalItem = arg_9_0:getUserDataTb_()
		var_9_0.normalItem.go = gohelper.findChild(var_9_0.go, "go_normalbg")
		var_9_0.normalItem.txtIndex = gohelper.findChildTextMesh(var_9_0.normalItem.go, "txtIndex")
		var_9_0.normalItem.txtTitle = gohelper.findChildTextMesh(var_9_0.normalItem.go, "txtTitle")
		var_9_0.normalItem.txtTitleEn = gohelper.findChildTextMesh(var_9_0.normalItem.go, "txtTitleEn")
		var_9_0.selectItem = arg_9_0:getUserDataTb_()
		var_9_0.selectItem.go = gohelper.findChild(var_9_0.go, "go_selectbg")
		var_9_0.selectItem.txtIndex = gohelper.findChildTextMesh(var_9_0.selectItem.go, "txtIndex")
		var_9_0.selectItem.txtTitle = gohelper.findChildTextMesh(var_9_0.selectItem.go, "txtTitle")
		var_9_0.selectItem.txtTitleEn = gohelper.findChildTextMesh(var_9_0.selectItem.go, "txtTitleEn")
		var_9_0.btn = gohelper.findButtonWithAudio(var_9_0.go)

		var_9_0.btn:AddClickListener(arg_9_0.onClickStoryItem, arg_9_0, var_9_0)

		arg_9_0.itemList[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0.refreshItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1.plotCo = arg_10_2

	if not arg_10_2 then
		gohelper.setActive(arg_10_1.goParent, false)

		return
	end

	if not arg_10_0.gameMo:isStoryFinish(arg_10_2.id) then
		gohelper.setActive(arg_10_1.goParent, false)

		return
	end

	gohelper.setActive(arg_10_1.goParent, true)

	local var_10_0 = arg_10_0.selectId == arg_10_2.id

	gohelper.setActive(arg_10_1.selectItem.go, var_10_0)
	gohelper.setActive(arg_10_1.normalItem.go, not var_10_0)

	local var_10_1 = var_10_0 and arg_10_1.selectItem or arg_10_1.normalItem

	var_10_1.txtIndex.text = string.format("%02d", arg_10_1.index)
	var_10_1.txtTitle.text = arg_10_2.storyName
	var_10_1.txtTitleEn.text = arg_10_2.storyNameEn
end

function var_0_0.refreshRoleStoryBg(arg_11_0)
	gohelper.setActive(arg_11_0._goBgCg, true)

	local var_11_0 = RoleStoryConfig.instance:getStoryById(arg_11_0.storyId)
	local var_11_1 = var_11_0.cgUnlockStoryId
	local var_11_2 = var_11_1 == 0 or arg_11_0.gameMo:isStoryFinish(var_11_1)

	if var_11_2 and (arg_11_0.cgUnlock or RoleStoryModel.instance:canPlayDungeonUnlockAnim(arg_11_0.storyId)) then
		if ViewMgr.instance:isOpen(ViewName.NecrologistStoryView) then
			gohelper.setActive(arg_11_0._goUnlockedBg, false)
			gohelper.setActive(arg_11_0._goLockedBg, true)
			arg_11_0.animBgCg:Play("idle")
			arg_11_0:refreshRoleStoryLockBg(var_11_0)
		else
			RoleStoryModel.instance:setPlayDungeonUnlockAnimFlag(arg_11_0.storyId)
			gohelper.setActive(arg_11_0._goUnlockedBg, true)
			gohelper.setActive(arg_11_0._goLockedBg, true)
			arg_11_0:refreshRoleStoryUnlockBg(var_11_0)
			arg_11_0:refreshRoleStoryLockBg(var_11_0)
			arg_11_0.animBgCg:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	else
		gohelper.setActive(arg_11_0._goUnlockedBg, var_11_2)
		gohelper.setActive(arg_11_0._goLockedBg, not var_11_2)
		arg_11_0.animBgCg:Play("idle")

		if var_11_2 then
			arg_11_0:refreshRoleStoryUnlockBg(var_11_0)
		else
			arg_11_0:refreshRoleStoryLockBg(var_11_0)
		end
	end
end

function var_0_0.refreshRoleStoryUnlockBg(arg_12_0, arg_12_1)
	arg_12_0._unlocksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", arg_12_1.cgBg), arg_12_0._onLoadUnlockCgCallback, arg_12_0)
	recthelper.setAnchor(arg_12_0._unlockimagecgbg.transform, 0, 0)
	transformhelper.setLocalScale(arg_12_0._unlockimagecgbg.transform, 1, 1, 1)
end

function var_0_0.refreshRoleStoryLockBg(arg_13_0, arg_13_1)
	arg_13_0._locksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", arg_13_1.cgBg), arg_13_0._onLoadLockCgCallback, arg_13_0)

	local var_13_0 = string.splitToNumber(arg_13_1.cgPos, "#")

	recthelper.setAnchor(arg_13_0._lockimagecgbg.transform, var_13_0[1] or 0, var_13_0[2] or 0)
	transformhelper.setLocalScale(arg_13_0._lockimagecgbg.transform, tonumber(arg_13_1.cgScale) or 1, tonumber(arg_13_1.cgScale) or 1, 1)
end

function var_0_0._onLoadUnlockCgCallback(arg_14_0)
	arg_14_0._unlockimagecgbg:SetNativeSize()
end

function var_0_0._onLoadLockCgCallback(arg_15_0)
	arg_15_0._lockimagecgbg:SetNativeSize()
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0._unlocksimagecgbg then
		arg_17_0._unlocksimagecgbg:UnLoadImage()
	end

	if arg_17_0._locksimagecgbg then
		arg_17_0._locksimagecgbg:UnLoadImage()
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.itemList) do
		iter_17_1.btn:RemoveClickListener()
	end
end

return var_0_0

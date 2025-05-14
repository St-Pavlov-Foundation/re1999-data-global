module("modules.logic.dungeon.view.rolestory.RoleStoryItem", package.seeall)

local var_0_0 = class("RoleStoryItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.root = gohelper.findChild(arg_1_0.viewGO, "Root")
	arg_1_0.mainAnim = arg_1_0.root:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_0.root)
	arg_1_0.simagePhoto = gohelper.findChildSingleImage(arg_1_0.root, "#simage_Photo")
	arg_1_0.goNewTag = gohelper.findChild(arg_1_0.root, "#image_NewTag")
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.root, "Name/image_NameBG/#txt_Name")
	arg_1_0.slider = gohelper.findChildSlider(arg_1_0.root, "Info/Slider")
	arg_1_0.txtScheduleNum = gohelper.findChildTextMesh(arg_1_0.root, "Info/#txt_ScheduleNum")
	arg_1_0.btnReward = gohelper.findChildButtonWithAudio(arg_1_0.root, "Info/btnReward")
	arg_1_0.imgReward = gohelper.findChildImage(arg_1_0.root, "Info/btnReward/#image_Reward")
	arg_1_0.aniReward = arg_1_0.imgReward.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.goCanGet = gohelper.findChild(arg_1_0.root, "#go_CanGet")
	arg_1_0.goCompleted = gohelper.findChild(arg_1_0.root, "#go_Completed")
	arg_1_0.completedAnim = arg_1_0.goCompleted:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.txtState = gohelper.findChildTextMesh(arg_1_0.root, "Info/#txt_State")
	arg_1_0.goLock = gohelper.findChild(arg_1_0.root, "#go_Locked")
	arg_1_0.imgPropItem = gohelper.findChildImage(arg_1_0.root, "#go_Locked/image_LockedTextBG/#image_PropItem")
	arg_1_0.txtPropNum = gohelper.findChildTextMesh(arg_1_0.root, "#go_Locked/image_LockedTextBG/#txt_PropNum")
	arg_1_0.goRedDot = gohelper.findChild(arg_1_0.root, "Info/#go_Reddot")
	arg_1_0.txtLocked = gohelper.findChildTextMesh(arg_1_0.root, "#go_Locked/image_LockedBG/txt_Locked")
	arg_1_0.txtLockedEn = gohelper.findChildTextMesh(arg_1_0.root, "#go_Locked/image_LockedBG/txt_LockedEn")
	arg_1_0.goRewardPanel = gohelper.findChild(arg_1_0.root, "Info/#go_RewardPanel")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnReward:AddClickListener(arg_2_0.onClickReward, arg_2_0)
	arg_2_0.btnClick:AddClickListener(arg_2_0.onClickItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnReward:RemoveClickListener()
	arg_3_0.btnClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	gohelper.setActive(arg_5_0.goNewTag, RoleStoryModel.instance:isNewStory(arg_5_1.id))
	arg_5_0:refreshPhoto()
	arg_5_0:refreshName()
	arg_5_0:refreshProgress()
	arg_5_0:refreshState()
	arg_5_0:refreshRedDot()
	RoleStoryModel.instance:setStoryNewTag(arg_5_1.id, false)
end

function var_0_0.refreshPhoto(arg_6_0)
	local var_6_0 = arg_6_0._mo.cfg.photo

	arg_6_0.simagePhoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(var_6_0))
end

function var_0_0.refreshName(arg_7_0)
	arg_7_0.txtName.text = arg_7_0._mo.cfg.heroName
end

function var_0_0.refreshImageReward(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0.goCanGet, arg_8_1 ~= 1)
	gohelper.setActive(arg_8_0.goCompleted, arg_8_1 ~= 1)

	if arg_8_1 ~= 1 then
		if arg_8_1 == 2 and RoleStoryModel.instance:isFinishTweenUnplay(arg_8_0._mo.id) then
			arg_8_0.completedAnim:Play("open", 0, 0)
		else
			arg_8_0.completedAnim:Play("idle")
		end
	end

	UISpriteSetMgr.instance:setUiFBSprite(arg_8_0.imgReward, string.format("rolestory_rewardbtn%s", arg_8_1), true)

	if arg_8_1 == 2 then
		arg_8_0.aniReward:Play("loop")
	else
		arg_8_0.aniReward:Play("idle")
	end
end

function var_0_0.refreshTxtState(arg_9_0, arg_9_1)
	arg_9_0.txtState.text = luaLang(string.format("rolestoryrewardstate_%s", arg_9_1))
end

function var_0_0.refreshProgress(arg_10_0)
	if arg_10_0._mo.progress >= arg_10_0._mo.maxProgress then
		arg_10_0.txtScheduleNum.text = string.format("<color=#cc5b17>%s/%s</color>", arg_10_0._mo.progress, arg_10_0._mo.maxProgress)
	else
		arg_10_0.txtScheduleNum.text = string.format("%s/<color=#cc5b17>%s</color>", arg_10_0._mo.progress, arg_10_0._mo.maxProgress)
	end

	local var_10_0 = math.max(arg_10_0._mo.maxProgress, 1)

	arg_10_0.slider:SetValue(arg_10_0._mo.progress / var_10_0)
end

function var_0_0.refreshState(arg_11_0)
	if not arg_11_0._mo.hasUnlock then
		arg_11_0:refreshImageReward(1)
		arg_11_0:refreshTxtState(1)
		arg_11_0:refreshUnlock(false)

		return
	end

	arg_11_0:refreshUnlock(true)

	if arg_11_0._mo.getReward then
		arg_11_0:refreshImageReward(3)
		arg_11_0:refreshTxtState(3)

		return
	end

	arg_11_0:refreshTxtState(2)

	if arg_11_0._mo.progress >= arg_11_0._mo.maxProgress then
		arg_11_0:refreshImageReward(2)

		return
	end

	arg_11_0:refreshImageReward(1)
end

function var_0_0.refreshUnlock(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0.goLock, not arg_12_1)

	if not arg_12_1 then
		local var_12_0, var_12_1, var_12_2 = arg_12_0._mo:getCost()
		local var_12_3 = CurrencyConfig.instance:getCurrencyCo(var_12_1)
		local var_12_4 = string.format("%s_1", var_12_3 and var_12_3.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_12_0.imgPropItem, var_12_4)

		local var_12_5 = ItemModel.instance:getItemQuantity(var_12_0, var_12_1)
		local var_12_6 = var_12_2
		local var_12_7 = var_12_6 == 0 and string.format("<color=#65b96f>%s</color>", var_12_6) or tostring(var_12_6)

		if var_12_5 < var_12_6 then
			arg_12_0.txtPropNum.text = string.format(string.format("<color=#d97373>%s</color>/%s", var_12_5, var_12_7))
		else
			arg_12_0.txtPropNum.text = string.format(string.format("%s/%s", var_12_5, var_12_7))
		end

		arg_12_0.txtLocked.text = var_12_6 == 0 and luaLang("first_time_free") or luaLang("unlock")
		arg_12_0.txtLockedEn.text = var_12_6 == 0 and "1st Time Free" or "UNLOCK"
	end

	if arg_12_1 and RoleStoryModel.instance:isUnlockingStory(arg_12_0._mo.id) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		arg_12_0.mainAnim:Play("unlock")
	elseif arg_12_0._view.isFirst then
		arg_12_0.mainAnim:Play("open")
	else
		arg_12_0.mainAnim:Play("idle")
	end
end

function var_0_0.onClickReward(arg_13_0)
	if not arg_13_0._mo then
		return
	end

	if arg_13_0._mo.progress < arg_13_0._mo.maxProgress or arg_13_0._mo.getReward then
		arg_13_0:showReward()

		return
	end

	HeroStoryRpc.instance:sendGetHeroStoryBonusRequest(arg_13_0._mo.id)
end

function var_0_0.onClickItem(arg_14_0)
	if not arg_14_0._mo then
		return
	end

	if arg_14_0._mo.hasUnlock then
		RoleStoryController.instance:enterRoleStoryChapter(arg_14_0._mo.id)
	else
		local var_14_0, var_14_1, var_14_2 = arg_14_0._mo:getCost()

		if var_14_2 > 0 then
			local var_14_3 = arg_14_0._mo.cfg.heroName
			local var_14_4 = ItemModel.instance:getItemConfig(var_14_0, var_14_1)
			local var_14_5 = var_14_4 and var_14_4.name

			GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryUnlockTips, MsgBoxEnum.BoxType.Yes_No, arg_14_0._unlockCallback, nil, nil, arg_14_0, nil, nil, var_14_2, var_14_5, var_14_3)
		else
			arg_14_0:_unlockCallback()
		end
	end
end

function var_0_0._unlockCallback(arg_15_0)
	if not arg_15_0._mo or arg_15_0._mo.hasUnlock then
		return
	end

	local var_15_0, var_15_1, var_15_2 = arg_15_0._mo:getCost()
	local var_15_3 = {}

	table.insert(var_15_3, {
		type = var_15_0,
		id = var_15_1,
		quantity = var_15_2
	})

	local var_15_4, var_15_5, var_15_6 = ItemModel.instance:hasEnoughItems(var_15_3)

	if not var_15_5 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_15_6, var_15_4)

		return
	end

	HeroStoryRpc.instance:sendUnlocHeroStoryRequest(arg_15_0._mo.id)
end

function var_0_0.refreshRedDot(arg_16_0)
	local var_16_0 = false

	if arg_16_0._mo and not arg_16_0._mo.getReward and arg_16_0._mo.progress >= arg_16_0._mo.maxProgress then
		var_16_0 = true
	end

	gohelper.setActive(arg_16_0.goRedDot, var_16_0)
end

function var_0_0.showReward(arg_17_0)
	local var_17_0, var_17_1, var_17_2 = transformhelper.getPos(arg_17_0.goRewardPanel.transform)

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.OnClickRoleStoryReward, arg_17_0._mo, var_17_0, var_17_1, var_17_2)
end

function var_0_0.onDestroyView(arg_18_0)
	if arg_18_0.simagePhoto then
		arg_18_0.simagePhoto:UnLoadImage()

		arg_18_0.simagePhoto = nil
	end
end

return var_0_0

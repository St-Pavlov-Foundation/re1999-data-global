module("modules.logic.dungeon.view.rolestory.RoleStoryItem", package.seeall)

slot0 = class("RoleStoryItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.root = gohelper.findChild(slot0.viewGO, "Root")
	slot0.mainAnim = slot0.root:GetComponent(typeof(UnityEngine.Animator))
	slot0.btnClick = gohelper.findButtonWithAudio(slot0.root)
	slot0.simagePhoto = gohelper.findChildSingleImage(slot0.root, "#simage_Photo")
	slot0.goNewTag = gohelper.findChild(slot0.root, "#image_NewTag")
	slot0.txtName = gohelper.findChildTextMesh(slot0.root, "Name/image_NameBG/#txt_Name")
	slot0.slider = gohelper.findChildSlider(slot0.root, "Info/Slider")
	slot0.txtScheduleNum = gohelper.findChildTextMesh(slot0.root, "Info/#txt_ScheduleNum")
	slot0.btnReward = gohelper.findChildButtonWithAudio(slot0.root, "Info/btnReward")
	slot0.imgReward = gohelper.findChildImage(slot0.root, "Info/btnReward/#image_Reward")
	slot0.aniReward = slot0.imgReward.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0.goCanGet = gohelper.findChild(slot0.root, "#go_CanGet")
	slot0.goCompleted = gohelper.findChild(slot0.root, "#go_Completed")
	slot0.completedAnim = slot0.goCompleted:GetComponent(typeof(UnityEngine.Animator))
	slot0.txtState = gohelper.findChildTextMesh(slot0.root, "Info/#txt_State")
	slot0.goLock = gohelper.findChild(slot0.root, "#go_Locked")
	slot0.imgPropItem = gohelper.findChildImage(slot0.root, "#go_Locked/image_LockedTextBG/#image_PropItem")
	slot0.txtPropNum = gohelper.findChildTextMesh(slot0.root, "#go_Locked/image_LockedTextBG/#txt_PropNum")
	slot0.goRedDot = gohelper.findChild(slot0.root, "Info/#go_Reddot")
	slot0.txtLocked = gohelper.findChildTextMesh(slot0.root, "#go_Locked/image_LockedBG/txt_Locked")
	slot0.txtLockedEn = gohelper.findChildTextMesh(slot0.root, "#go_Locked/image_LockedBG/txt_LockedEn")
	slot0.goRewardPanel = gohelper.findChild(slot0.root, "Info/#go_RewardPanel")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnReward:AddClickListener(slot0.onClickReward, slot0)
	slot0.btnClick:AddClickListener(slot0.onClickItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnReward:RemoveClickListener()
	slot0.btnClick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0.goNewTag, RoleStoryModel.instance:isNewStory(slot1.id))
	slot0:refreshPhoto()
	slot0:refreshName()
	slot0:refreshProgress()
	slot0:refreshState()
	slot0:refreshRedDot()
	RoleStoryModel.instance:setStoryNewTag(slot1.id, false)
end

function slot0.refreshPhoto(slot0)
	slot0.simagePhoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(slot0._mo.cfg.photo))
end

function slot0.refreshName(slot0)
	slot0.txtName.text = slot0._mo.cfg.heroName
end

function slot0.refreshImageReward(slot0, slot1)
	gohelper.setActive(slot0.goCanGet, slot1 ~= 1)
	gohelper.setActive(slot0.goCompleted, slot1 ~= 1)

	if slot1 ~= 1 then
		if slot1 == 2 and RoleStoryModel.instance:isFinishTweenUnplay(slot0._mo.id) then
			slot0.completedAnim:Play("open", 0, 0)
		else
			slot0.completedAnim:Play("idle")
		end
	end

	UISpriteSetMgr.instance:setUiFBSprite(slot0.imgReward, string.format("rolestory_rewardbtn%s", slot1), true)

	if slot1 == 2 then
		slot0.aniReward:Play("loop")
	else
		slot0.aniReward:Play("idle")
	end
end

function slot0.refreshTxtState(slot0, slot1)
	slot0.txtState.text = luaLang(string.format("rolestoryrewardstate_%s", slot1))
end

function slot0.refreshProgress(slot0)
	if slot0._mo.maxProgress <= slot0._mo.progress then
		slot0.txtScheduleNum.text = string.format("<color=#cc5b17>%s/%s</color>", slot0._mo.progress, slot0._mo.maxProgress)
	else
		slot0.txtScheduleNum.text = string.format("%s/<color=#cc5b17>%s</color>", slot0._mo.progress, slot0._mo.maxProgress)
	end

	slot0.slider:SetValue(slot0._mo.progress / math.max(slot0._mo.maxProgress, 1))
end

function slot0.refreshState(slot0)
	if not slot0._mo.hasUnlock then
		slot0:refreshImageReward(1)
		slot0:refreshTxtState(1)
		slot0:refreshUnlock(false)

		return
	end

	slot0:refreshUnlock(true)

	if slot0._mo.getReward then
		slot0:refreshImageReward(3)
		slot0:refreshTxtState(3)

		return
	end

	slot0:refreshTxtState(2)

	if slot0._mo.maxProgress <= slot0._mo.progress then
		slot0:refreshImageReward(2)

		return
	end

	slot0:refreshImageReward(1)
end

function slot0.refreshUnlock(slot0, slot1)
	gohelper.setActive(slot0.goLock, not slot1)

	if not slot1 then
		slot2, slot3, slot4 = slot0._mo:getCost()

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.imgPropItem, string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(slot3) and slot5.icon))

		if ItemModel.instance:getItemQuantity(slot2, slot3) < slot8 then
			slot0.txtPropNum.text = string.format(string.format("<color=#d97373>%s</color>/%s", slot7, slot4 == 0 and string.format("<color=#65b96f>%s</color>", slot8) or tostring(slot8)))
		else
			slot0.txtPropNum.text = string.format(string.format("%s/%s", slot7, slot9))
		end

		slot0.txtLocked.text = slot8 == 0 and luaLang("first_time_free") or luaLang("unlock")
		slot0.txtLockedEn.text = slot8 == 0 and "1st Time Free" or "UNLOCK"
	end

	if slot1 and RoleStoryModel.instance:isUnlockingStory(slot0._mo.id) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		slot0.mainAnim:Play("unlock")
	elseif slot0._view.isFirst then
		slot0.mainAnim:Play("open")
	else
		slot0.mainAnim:Play("idle")
	end
end

function slot0.onClickReward(slot0)
	if not slot0._mo then
		return
	end

	if slot0._mo.progress < slot0._mo.maxProgress or slot0._mo.getReward then
		slot0:showReward()

		return
	end

	HeroStoryRpc.instance:sendGetHeroStoryBonusRequest(slot0._mo.id)
end

function slot0.onClickItem(slot0)
	if not slot0._mo then
		return
	end

	if slot0._mo.hasUnlock then
		RoleStoryController.instance:enterRoleStoryChapter(slot0._mo.id)
	else
		slot1, slot2, slot3 = slot0._mo:getCost()

		if slot3 > 0 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryUnlockTips, MsgBoxEnum.BoxType.Yes_No, slot0._unlockCallback, nil, , slot0, nil, , slot3, ItemModel.instance:getItemConfig(slot1, slot2) and slot5.name, slot0._mo.cfg.heroName)
		else
			slot0:_unlockCallback()
		end
	end
end

function slot0._unlockCallback(slot0)
	if not slot0._mo or slot0._mo.hasUnlock then
		return
	end

	slot1, slot2, slot3 = slot0._mo:getCost()
	slot4 = {}

	table.insert(slot4, {
		type = slot1,
		id = slot2,
		quantity = slot3
	})

	slot5, slot6, slot7 = ItemModel.instance:hasEnoughItems(slot4)

	if not slot6 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot7, slot5)

		return
	end

	HeroStoryRpc.instance:sendUnlocHeroStoryRequest(slot0._mo.id)
end

function slot0.refreshRedDot(slot0)
	slot1 = false

	if slot0._mo and not slot0._mo.getReward and slot0._mo.maxProgress <= slot0._mo.progress then
		slot1 = true
	end

	gohelper.setActive(slot0.goRedDot, slot1)
end

function slot0.showReward(slot0)
	slot1, slot2, slot3 = transformhelper.getPos(slot0.goRewardPanel.transform)

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.OnClickRoleStoryReward, slot0._mo, slot1, slot2, slot3)
end

function slot0.onDestroyView(slot0)
	if slot0.simagePhoto then
		slot0.simagePhoto:UnLoadImage()

		slot0.simagePhoto = nil
	end
end

return slot0

module("modules.logic.versionactivity2_5.act186.view.Activity186SignItem", package.seeall)

slot0 = class("Activity186SignItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.txtIndex = gohelper.findChildTextMesh(slot0.viewGO, "txtIndex")
	slot0.goTomorrow = gohelper.findChild(slot0.viewGO, "#go_TomorrowTag")
	slot0.goNormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0.goCanget = gohelper.findChild(slot0.viewGO, "#go_canget")
	slot0.goCangetCookies1 = gohelper.findChild(slot0.viewGO, "#go_canget/cookies1")
	slot0.goCangetCookies2 = gohelper.findChild(slot0.viewGO, "#go_canget/cookies2")
	slot0.goHasget = gohelper.findChild(slot0.viewGO, "#go_hasget")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClick")
	slot0.canvasGroup = gohelper.findChildComponent(slot0.viewGO, "#go_rewards", gohelper.Type_CanvasGroup)
	slot0.rewardList = {}
	slot0.hasgetCookiesAnim = gohelper.findChildComponent(slot0.viewGO, "#go_hasget/cookies/ani", gohelper.Type_Animator)
	slot0.hasgetHookAnim = gohelper.findChildComponent(slot0.viewGO, "#go_hasget/gou/go_hasget", gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnClick:AddClickListener(slot0.onClickBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnClick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.initActId(slot0, slot1)
	slot0.act186Id = slot1
end

function slot0.onClickBtn(slot0)
	if not slot0._mo then
		return
	end

	if Activity186SignModel.instance:getSignStatus(slot0._mo.activityId, slot0.act186Id, slot0._mo.id) == Activity186Enum.SignStatus.Canget then
		Activity101Rpc.instance:sendGet101BonusRequest(slot0._mo.activityId, slot0._mo.id)
	elseif slot1 == Activity186Enum.SignStatus.None then
		GameFacade.showToast(ToastEnum.NorSign)
	else
		ViewMgr.instance:openView(ViewName.Activity186GameBiscuitsView, {
			config = slot0._mo,
			act186Id = slot0.act186Id
		})
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if not slot1 then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)
	slot0:refreshView()
end

function slot0.refreshView(slot0)
	gohelper.setActive(slot0.goTomorrow, slot0._mo.id == ActivityType101Model.instance:getType101LoginCount(slot0._mo.activityId) + 1)

	slot3 = Activity186SignModel.instance:getSignStatus(slot0._mo.activityId, slot0.act186Id, slot1)
	slot4 = slot0.status and slot0.status ~= slot3

	gohelper.setActive(slot0.goNormal, slot3 == Activity186Enum.SignStatus.None)
	gohelper.setActive(slot0.goCanget, slot3 == Activity186Enum.SignStatus.Canplay or slot3 == Activity186Enum.SignStatus.Canget)
	gohelper.setActive(slot0.goCangetCookies1, slot3 == Activity186Enum.SignStatus.Canplay)
	gohelper.setActive(slot0.goCangetCookies2, slot3 == Activity186Enum.SignStatus.Canget)
	gohelper.setActive(slot0.goHasget, slot3 == Activity186Enum.SignStatus.Hasget)

	if slot3 == Activity186Enum.SignStatus.Hasget then
		slot0.txtIndex.text = string.format("<color=#6A372C>Day %s</color>", slot1)
	else
		slot0.txtIndex.text = string.format("Day %s", slot1)
	end

	slot0.canvasGroup.alpha = slot3 == Activity186Enum.SignStatus.Hasget and 0.5 or 1

	slot0:refreshReward(slot3)

	if slot3 == Activity186Enum.SignStatus.Hasget then
		if slot4 then
			slot0.hasgetCookiesAnim:Play("open")
			slot0.hasgetHookAnim:Play("go_hasget_in")
		else
			slot0.hasgetCookiesAnim:Play("opened")
			slot0.hasgetHookAnim:Play("go_hasget_idle")
		end
	end

	slot0.status = slot3
end

function slot0.refreshReward(slot0, slot1)
	slot6 = #slot0.rewardList

	for slot6 = 1, math.max(#GameUtil.splitString2(slot0._mo.bonus, true), slot6) do
		slot0:updateRewardItem(slot0:getOrCreateRewardItem(slot6), slot2[slot6], slot1)
	end
end

function slot0.getOrCreateRewardItem(slot0, slot1)
	if not slot0.rewardList[slot1] then
		if not gohelper.findChild(slot0.viewGO, "#go_rewards/#go_reward" .. slot1) then
			return
		end

		slot2 = slot0:getUserDataTb_()
		slot2.go = slot3
		slot2.goIcon = gohelper.findChild(slot3, "go_icon")
		slot0.rewardList[slot1] = slot2
	end

	return slot2
end

function slot0.updateRewardItem(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	if not slot1.itemIcon then
		slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.goIcon)
	end

	slot1.itemIcon:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1.itemIcon:setScale(0.7)
	slot1.itemIcon:setCountFontSize(46)
	slot1.itemIcon:setHideLvAndBreakFlag(true)
	slot1.itemIcon:hideEquipLvAndBreak(true)
	slot1.itemIcon:customOnClickCallback(uv0.onClickItemIcon, {
		actId = slot0._mo.activityId,
		index = slot0._mo.id,
		status = slot3,
		itemCo = slot2,
		selfitem = slot0
	})
end

function slot0.onClickItemIcon(slot0)
	if not ActivityModel.instance:isActOnLine(slot0.actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	slot2 = slot0.itemCo

	MaterialTipController.instance:showMaterialInfo(slot2[1], slot2[2])
end

function slot0.onDestroyView(slot0)
end

return slot0

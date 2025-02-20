module("modules.logic.season.view1_4.Season1_4TaskItem", package.seeall)

slot0 = class("Season1_4TaskItem", UserDataDispose)
slot0.BlockKey = "Season1_4TaskItemAni"

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._viewGO = slot1
	slot0._simageBg = gohelper.findChildSingleImage(slot1, "#simage_bg")
	slot0._goNormal = gohelper.findChild(slot1, "#goNormal")
	slot0._goTotal = gohelper.findChild(slot1, "#goTotal")
	slot0._ani = slot1:GetComponent(typeof(UnityEngine.Animator))

	slot0:initNormal(slot2)
	slot0:initTotal()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end

	slot0:addEventListeners()
end

function slot0.addEventListeners(slot0)
	slot0._btnGoto:AddClickListener(slot0.onClickGoto, slot0)
	slot0._btnReceive:AddClickListener(slot0.onClickReceive, slot0)
	slot0._btnGetTotal:AddClickListener(slot0.onClickGetTotal, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnGoto:RemoveClickListener()
	slot0._btnReceive:RemoveClickListener()
	slot0._btnGetTotal:RemoveClickListener()
end

function slot0.initNormal(slot0, slot1)
	slot0._txtCurCount = gohelper.findChildTextMesh(slot0._goNormal, "#txt_curcount")
	slot0._txtMaxCount = gohelper.findChildTextMesh(slot0._goNormal, "#txt_curcount/#txt_maxcount")
	slot0._txtDesc = gohelper.findChildTextMesh(slot0._goNormal, "#txt_desc")
	slot0._scrollreward = gohelper.findChild(slot0._goNormal, "#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._gocontent = gohelper.findChild(slot0._goNormal, "#scroll_rewards/Viewport/Content")
	slot0._scrollreward.parentGameObject = slot1
	slot0._goRewardTemplate = gohelper.findChild(slot0._gocontent, "#go_rewarditem")

	gohelper.setActive(slot0._goRewardTemplate, false)

	slot0._goMask = gohelper.findChild(slot0._goNormal, "#go_blackmask")
	slot0._goFinish = gohelper.findChild(slot0._goNormal, "#go_finish")
	slot0._goGoto = gohelper.findChild(slot0._goNormal, "#btn_goto")
	slot0._btnGoto = gohelper.findChildButtonWithAudio(slot0._goNormal, "#btn_goto")
	slot0._goReceive = gohelper.findChild(slot0._goNormal, "#btn_receive")
	slot0._btnReceive = gohelper.findChildButtonWithAudio(slot0._goNormal, "#btn_receive")
	slot0._goUnfinish = gohelper.findChild(slot0._goNormal, "#go_unfinish")
	slot0._goType1 = gohelper.findChild(slot0._goGoto, "#go_gotype1")
	slot0._goType3 = gohelper.findChild(slot0._goGoto, "#go_gotype3")
end

function slot0.initTotal(slot0)
	slot0._btnGetTotal = gohelper.findChildButtonWithAudio(slot0._goTotal, "#btn_getall")
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	if slot1 then
		gohelper.setActive(slot0._viewGO, true)

		if slot1.isTotalGet then
			gohelper.setActive(slot0._goNormal, false)
			gohelper.setActive(slot0._goTotal, true)
			slot0._simageBg:LoadImage(ResUrl.getSeasonIcon("tap2.png"))
		else
			gohelper.setActive(slot0._goNormal, true)
			gohelper.setActive(slot0._goTotal, false)
			slot0:refreshNormal(slot1)
		end

		if slot2 then
			slot0._ani:Play(UIAnimationName.Open)
		else
			slot0._ani:Play(UIAnimationName.Idle)
		end
	else
		gohelper.setActive(slot0._viewGO, false)
	end
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._viewGO, false)
end

function slot0.refreshNormal(slot0, slot1)
	slot0.taskId = slot1.id
	slot0.jumpId = slot1.config.jumpId

	gohelper.setActive(slot0._viewGO, true)
	slot0:refreshReward(slot1)
	slot0:refreshDesc(slot1)
	slot0:refreshProgress(slot1)
	slot0:refreshState(slot1)
end

function slot0.refreshReward(slot0, slot1)
	for slot8, slot9 in ipairs(string.split(slot1.config.bonus, "|")) do
		if not string.nilorempty(slot9) then
			slot10 = string.splitToNumber(slot9, "#")

			table.insert({}, {
				isIcon = true,
				materilType = slot10[1],
				materilId = slot10[2],
				quantity = slot10[3]
			})
		end
	end

	if slot2.activity104EquipBonus > 0 then
		table.insert(slot4, {
			equipId = slot2.activity104EquipBonus
		})
	end

	if not slot0._rewardItems then
		slot0._rewardItems = {}
	end

	slot8 = #slot0._rewardItems

	for slot8 = 1, math.max(slot8, #slot4) do
		slot0:refreshRewardItem(slot0._rewardItems[slot8] or slot0:createRewardItem(slot8), slot4[slot8])
	end
end

function slot0.createRewardItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.clone(slot0._goRewardTemplate, slot0._gocontent, "reward_" .. tostring(slot1))
	slot2.go = slot3
	slot2.itemParent = gohelper.findChild(slot3, "go_prop")
	slot2.cardParent = gohelper.findChild(slot3, "go_card")
	slot0._rewardItems[slot1] = slot2

	return slot2
end

function slot0.refreshRewardItem(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	if slot2.equipId then
		gohelper.setActive(slot1.cardParent, true)
		gohelper.setActive(slot1.itemParent, false)

		if not slot1.equipIcon then
			slot1.equipIcon = Season1_4CelebrityCardItem.New()

			slot1.equipIcon:init(slot1.cardParent, slot2.equipId)
		end

		slot1.equipIcon:reset(slot2.equipId)

		return
	end

	gohelper.setActive(slot1.cardParent, false)
	gohelper.setActive(slot1.itemParent, true)

	if not slot1.itemIcon then
		slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.itemParent)
	end

	slot1.itemIcon:onUpdateMO(slot2)
	slot1.itemIcon:isShowCount(true)
	slot1.itemIcon:setCountFontSize(40)
	slot1.itemIcon:showStackableNum2()
	slot1.itemIcon:setHideLvAndBreakFlag(true)
	slot1.itemIcon:hideEquipLvAndBreak(true)
end

function slot0.destroyRewardItem(slot0, slot1)
	if slot1.itemIcon then
		slot1.itemIcon:onDestroy()

		slot1.itemIcon = nil
	end

	if slot1.equipIcon then
		slot1.equipIcon:destroy()

		slot1.equipIcon = nil
	end
end

function slot0.refreshDesc(slot0, slot1)
	slot0._simageBg:LoadImage(ResUrl.getSeasonIcon(string.format("tap%s.png", slot1.config.bgType == 1 and 3 or 1)))

	slot0._txtDesc.text = slot2.desc
end

function slot0.refreshProgress(slot0, slot1)
	slot0._txtCurCount.text = slot1.progress
	slot0._txtMaxCount.text = slot1.config.maxProgress
end

function slot0.refreshState(slot0, slot1)
	if slot1.config.maxFinishCount <= slot1.finishCount then
		gohelper.setActive(slot0._goMask, true)
		gohelper.setActive(slot0._goFinish, true)
		gohelper.setActive(slot0._goGoto, false)
		gohelper.setActive(slot0._goReceive, false)
	elseif slot1.hasFinished then
		gohelper.setActive(slot0._goMask, false)
		gohelper.setActive(slot0._goFinish, false)
		gohelper.setActive(slot0._goGoto, false)
		gohelper.setActive(slot0._goReceive, true)
	else
		gohelper.setActive(slot0._goMask, false)
		gohelper.setActive(slot0._goFinish, false)
		gohelper.setActive(slot0._goReceive, false)

		if slot0.jumpId and slot0.jumpId > 0 then
			slot2 = slot1.config

			gohelper.setActive(slot0._goGoto, true)
			gohelper.setActive(slot0._goUnfinish, false)
			gohelper.setActive(slot0._goType1, slot1.config.bgType ~= 1)
			gohelper.setActive(slot0._goType3, slot1.config.bgType == 1)
		else
			gohelper.setActive(slot0._goGoto, false)
			gohelper.setActive(slot0._goUnfinish, true)
		end
	end
end

function slot0.onClickGoto(slot0)
	if not slot0.jumpId then
		return
	end

	if GameFacade.jump(slot0.jumpId) then
		ViewMgr.instance:closeView(SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.TaskView))
	end
end

function slot0.onClickReceive(slot0)
	if not slot0.taskId then
		return
	end

	gohelper.setActive(slot0._goMask, true)
	slot0._ani:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(uv0.BlockKey)
	TaskDispatcher.runDelay(slot0._onPlayActAniFinished, slot0, 0.76)
end

function slot0.onClickGetTotal(slot0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season)
end

function slot0._onPlayActAniFinished(slot0)
	UIBlockMgr.instance:endBlock(uv0.BlockKey)
	TaskRpc.instance:sendFinishTaskRequest(slot0.taskId)
	slot0:hide()
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)
	slot0:removeEventListeners()

	if slot0._rewardItems then
		for slot4, slot5 in pairs(slot0._rewardItems) do
			slot0:destroyRewardItem(slot5)
		end

		slot0._rewardItems = nil
	end

	slot0:__onDispose()
end

return slot0

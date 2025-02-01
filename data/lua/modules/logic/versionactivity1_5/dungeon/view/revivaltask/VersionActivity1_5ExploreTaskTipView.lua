module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5ExploreTaskTipView", package.seeall)

slot0 = class("VersionActivity1_5ExploreTaskTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goTipContainer = gohelper.findChild(slot0.viewGO, "#go_exploretipcontainer")
	slot0._goclosetip = gohelper.findChild(slot0.viewGO, "#go_exploretipcontainer/#go_closetip")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_exploretipcontainer/#go_exploretip")
	slot0._txtTipTitle = gohelper.findChildText(slot0._gotips, "#txt_title")
	slot0._txtTipTitleEn = gohelper.findChildText(slot0._gotips, "#txt_title/#txt_en")
	slot0._txtTipDesc = gohelper.findChildText(slot0._gotips, "scroll/view/#txt_dec")
	slot0._goTipFinish = gohelper.findChild(slot0._gotips, "layout/#go_finish")
	slot0._goTipGoTo = gohelper.findChild(slot0._gotips, "layout/#go_goto")
	slot0._txtTipStatus = gohelper.findChildText(slot0._gotips, "layout/#go_goto/#txt_status")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goTipContainer, false)

	slot0.goTipRectTr = slot0._gotips:GetComponent(typeof(UnityEngine.RectTransform))
	slot0.goTipContainerTr = slot0._goTipContainer:GetComponent(typeof(UnityEngine.RectTransform))
	slot0.halfViewWidth = recthelper.getWidth(slot0.goTipContainerTr) / 2
	slot0.halfTipWidth = recthelper.getWidth(slot0.goTipRectTr) / 2
	slot0.goToClick = gohelper.getClickWithDefaultAudio(slot0._goTipGoTo)

	slot0.goToClick:AddClickListener(slot0.onClickGoToBtn, slot0)

	slot0.closeClick = gohelper.getClickWithDefaultAudio(slot0._goclosetip)

	slot0.closeClick:AddClickListener(slot0.onHideTipContainer, slot0)
end

function slot0.onHideTipContainer(slot0)
	gohelper.setActive(slot0._goTipContainer, false)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.HideExploreTip, slot0.taskItem)

	slot0.taskItem = nil
	slot0.config = nil
end

function slot0.onClickGoToBtn(slot0)
	if slot0.isGainedReward then
		return
	end

	for slot4, slot5 in ipairs(slot0.config.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(slot5) then
			if not DungeonMapModel.instance:getElementById(slot5) then
				logError("element not exist or not unlock, element id : " .. slot5)

				return
			end

			slot0:closeThis()
			VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, slot5)

			return
		end
	end
end

function slot0.showTip(slot0, slot1, slot2)
	gohelper.setActive(slot0._goTipContainer, true)

	slot0.taskItem = slot1
	slot0.config = slot1.taskCo

	slot0:setPos(slot2)
	slot0:refreshUI()
end

function slot0.setPos(slot0, slot1)
	slot3 = recthelper.screenPosToAnchorPos(slot1, slot0.goTipContainerTr)
	slot4 = slot3.x
	slot6 = VersionActivity1_5DungeonEnum.ExploreTipOffsetX

	recthelper.setAnchor(slot0.goTipRectTr, slot0.halfViewWidth <= slot1.x and slot4 - slot0.halfTipWidth - slot6 or slot4 + slot0.halfTipWidth + slot6, math.min(math.max(slot3.y, VersionActivity1_5DungeonEnum.ExploreTipAnchorY.Min), VersionActivity1_5DungeonEnum.ExploreTipAnchorY.Max))
end

function slot0.refreshUI(slot0)
	slot0._txtTipTitle.text = slot0.config.title
	slot0._txtTipTitleEn.text = slot0.config.titleEn
	slot0._txtTipDesc.text = slot0.config.desc
	slot0.status = VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(slot0.config)
	slot0.isGainedReward = slot0.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward

	gohelper.setActive(slot0._goTipFinish, slot0.isGainedReward)
	gohelper.setActive(slot0._goTipGoTo, not slot0.isGainedReward)

	if not slot0.isGainedReward then
		if slot0.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Finished then
			slot0._txtTipStatus.text = luaLang("p_v1a5_dispatch_finish")
		elseif slot0.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running then
			slot0._txtTipStatus.text = luaLang("p_v1a5_dispatch_ing")
		else
			slot0._txtTipStatus.text = ""
		end
	end
end

function slot0.onDestroyView(slot0)
	slot0.goToClick:RemoveClickListener()
	slot0.closeClick:RemoveClickListener()
end

return slot0

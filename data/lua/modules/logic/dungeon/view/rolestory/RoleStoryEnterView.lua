module("modules.logic.dungeon.view.rolestory.RoleStoryEnterView", package.seeall)

slot0 = class("RoleStoryEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._txttime = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_LimitTime")
	slot0._btnenter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#image_reddot")
	slot0._simagephoto = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Photo")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_Descr")
	slot0.rewardItems = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnenter:AddClickListener(slot0._onClickEnter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnenter:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewContainer.activityId

	uv0.super.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._simagephoto then
		slot0._simagephoto:UnLoadImage()

		slot0._simagephoto = nil
	end

	if slot0.rewardItems then
		for slot4, slot5 in pairs(slot0.rewardItems) do
			slot5:onDestroy()
		end

		slot0.rewardItems = nil
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshRemainTime()
	slot0:refreshStory()
end

function slot0.refreshStory(slot0)
	if not RoleStoryModel.instance:getCurActStoryId() or slot1 == 0 then
		slot1 = RoleStoryConfig.instance:getStoryIdByActivityId(slot0.actId)
	end

	if slot1 and slot1 > 0 then
		slot0._simagephoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(RoleStoryConfig.instance:getStoryById(slot1).photo))
	end

	slot2 = ActivityConfig.instance:getActivityCo(slot0.actId)

	RedDotController.instance:addRedDot(slot0._goreddot, slot2.redDotId)

	slot0._txtdesc.text = slot2.actDesc
	slot7 = #(GameUtil.splitString2(slot2.activityBonus, true) or {})

	for slot7 = 1, math.max(slot7, #slot0.rewardItems) do
		slot9 = slot3[slot7]

		if not slot0.rewardItems[slot7] then
			table.insert(slot0.rewardItems, IconMgr.instance:getCommonPropItemIcon(slot0._gorewardcontent))
		end

		if slot9 then
			gohelper.setActive(slot8.go, true)
			slot8:setMOValue(slot9[1], slot9[2], slot9[3] or 1, nil, true)
			slot8:isShowEquipAndItemCount(false)
			slot8:hideEquipLvAndBreak(true)
		else
			gohelper.setActive(slot8.go, false)
		end
	end
end

function slot0.everySecondCall(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshRemainTime(slot0)
	gohelper.setActive(slot0._txttime.gameObject, ActivityModel.instance:getActMO(slot0.actId):getRealEndTimeStamp() - ServerTime.now() > 0)

	if slot2 > 0 then
		slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
	end
end

function slot0._onClickEnter(slot0)
	RoleStoryController.instance:openRoleStoryDispatchMainView()
end

return slot0

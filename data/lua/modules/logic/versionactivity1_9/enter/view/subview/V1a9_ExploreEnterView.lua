module("modules.logic.versionactivity1_9.enter.view.subview.V1a9_ExploreEnterView", package.seeall)

slot0 = class("V1a9_ExploreEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/txt_Des")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
end

function slot0._btnEnterOnClick(slot0)
	if ExploreSimpleModel.instance:getMapIsUnLock(201) then
		ExploreSimpleModel.instance:setLastSelectMap(1403, 140301)
	end

	if JumpController.instance:jump(440001) then
		ExploreModel.instance.isJumpToExplore = true
	end
end

function slot0._editableInitView(slot0)
	slot0.animComp = VersionActivitySubAnimatorComp.get(slot0.viewGO, slot0)
	slot0.config = ActivityConfig.instance:getActivityCo(VersionActivity1_9Enum.ActivityId.Explore3)
	slot0._items = {}

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot0.config and slot0.config.activityBonus or "", true) or {}) do
		slot8 = gohelper.create2d(slot0._gorewards, "item" .. slot6)

		recthelper.setSize(slot8.transform, 250, 250)

		slot0._items[slot6] = IconMgr.instance:getCommonPropItemIcon(slot8)

		slot0._items[slot6]:setMOValue(slot7[1], slot7[2], 1)
		slot0._items[slot6]:isShowEquipAndItemCount(false)
	end

	slot0._txtDescr.text = slot0.config.actDesc
end

function slot0.onOpen(slot0)
	slot0.animComp:playOpenAnim()
end

function slot0.onDestroyView(slot0)
	slot0.animComp:destroy()
end

return slot0

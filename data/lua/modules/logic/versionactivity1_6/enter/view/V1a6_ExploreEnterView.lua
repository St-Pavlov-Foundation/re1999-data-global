module("modules.logic.versionactivity1_6.enter.view.V1a6_ExploreEnterView", package.seeall)

slot0 = class("V1a6_ExploreEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Locked")
	slot0._txtLockTxt = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	slot0._txtDescr = gohelper.findChildTextMesh(slot0.viewGO, "Right/txt_Des")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._onEnterClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._onEnterClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	slot1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Explore)

	gohelper.setActive(slot0._btnEnter, slot1)
	gohelper.setActive(slot0._btnLocked, not slot1)

	if not slot1 then
		slot0._txtLockTxt.text = string.format(luaLang("dungeon_unlock_episode_mode_sp"), DungeonConfig.instance:getEpisodeDisplay(OpenConfig.instance:getOpenCo(ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Explore).openId).episodeId))
	end
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0._editableInitView(slot0)
	slot0.config = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Explore)
	slot0._items = {}

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot0.config and slot0.config.activityBonus or -1, true)) do
		slot8 = gohelper.create2d(slot0._gorewards, "item" .. slot6)

		recthelper.setSize(slot8.transform, 200, 200)

		slot0._items[slot6] = IconMgr.instance:getCommonPropItemIcon(slot8)

		slot0._items[slot6]:setMOValue(slot7[1], slot7[2], 1)
		slot0._items[slot6]:isShowEquipAndItemCount(false)
	end

	slot0._txtDescr.text = slot0.config.actDesc
end

function slot0._onEnterClick(slot0)
	if ExploreSimpleModel.instance:getMapIsUnLock(301) then
		ExploreSimpleModel.instance:setLastSelectMap(1402, 140201)
	end

	JumpController.instance:jump(440001)
end

return slot0

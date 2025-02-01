module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterViewContainer", package.seeall)

slot0 = class("VersionActivity1_6EnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._subViewGroup = TabViewGroup.New(2, "#go_subview")

	return {
		TabViewGroup.New(1, "#go_topleft"),
		slot0._subViewGroup,
		VersionActivity1_6EnterView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif slot1 == 2 then
		slot2 = {
			[#slot2 + 1] = Va1_6DungeonEnterView.New(),
			[#slot2 + 1] = V1a6_CachotEnterView.New(),
			[#slot2 + 1] = ReactivityEnterview.New(),
			[#slot2 + 1] = Va1_6QuNiangEnterView.New(),
			[#slot2 + 1] = Va1_6GeTianEnterView.New(),
			[#slot2 + 1] = V1a6_BossRush_EnterView.New(),
			[#slot2 + 1] = Va1_6SeasonEnterView.New(),
			[#slot2 + 1] = RoleStoryEnterView.New(),
			[#slot2 + 1] = V1a6_ExploreEnterView.New()
		}

		return slot2
	end
end

function slot0.selectActTab(slot0, slot1, slot2)
	slot0:modifyBgm(slot2.actId)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onContainerInit(slot0)
	ActivityStageHelper.recordActivityStage(slot0.viewParam.activityIdList)
end

function slot0.onContainerClose(slot0)
	if slot0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function slot0.modifyBgm(slot0, slot1)
	if slot0["onModifyBgmAct" .. slot1] then
		slot2(slot0)

		return
	end

	if slot0._curBgmId == (ActivityConfig.instance:getActivityEnterViewBgm(slot1) ~= 0 and slot3 or AudioEnum.Bgm.Act1_6DungeonBgm1) then
		return
	end

	slot0._curBgmId = slot3

	if slot3 == AudioEnum.Bgm.Activity128LevelViewBgm then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_6Main, slot3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm, nil, , FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	else
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_6Main, slot3, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end
end

return slot0

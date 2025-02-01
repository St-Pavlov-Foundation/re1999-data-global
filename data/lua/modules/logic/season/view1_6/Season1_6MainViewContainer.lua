module("modules.logic.season.view1_6.Season1_6MainViewContainer", package.seeall)

slot0 = class("Season1_6MainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.scene = Season1_6MainScene.New()
	slot0.view = Season1_6MainView.New()

	table.insert(slot1, slot0.scene)
	table.insert(slot1, slot0.view)
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
end

function slot0.getScene(slot0)
	return slot0.scene
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, slot0._closeCallback, slot0._homeCallback, nil, slot0)

	slot0._navigateButtonView:setOverrideClose(slot0._overrideClose, slot0)
	slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_6MainViewHelp)

	return {
		slot0._navigateButtonView
	}
end

function slot0.onContainerInit(slot0)
	slot1 = Activity104Model.instance:getCurSeasonId()

	ActivityEnterMgr.instance:enterActivity(slot1)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot1
	})
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_goldcup_open)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio()
end

function slot0._closeCallback(slot0)
end

function slot0._homeCallback(slot0)
	slot0:closeThis()
end

function slot0.stopUI(slot0)
	slot0:setVisibleInternal(true)

	slot0._anim.speed = 0
	slot0._animRetail.speed = 0

	slot0.view:activeMask(true)
end

function slot0.playUI(slot0)
	slot0:setVisibleInternal(true)

	slot0._anim.speed = 1
	slot0._animRetail.speed = 1

	slot0.view:activeMask(false)
end

function slot0.setVisibleInternal(slot0, slot1)
	if not slot0.viewGO then
		return
	end

	if not slot0._anim then
		slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if slot1 then
		slot0:_setVisible(true)
		slot0._anim:Play(UIAnimationName.Switch, 0, 0)

		if not slot0._animRetail then
			slot0._animRetail = gohelper.findChild(slot0.viewGO, "rightbtns/#go_retail"):GetComponent(typeof(UnityEngine.Animator))
		end

		slot0._animRetail:Play(UIAnimationName.Switch, 0, 0)

		if slot0.scene then
			slot0.scene:initCamera()
		end
	else
		slot0:_setVisible(false)
		slot0._anim:Play(UIAnimationName.Close)
	end
end

return slot0

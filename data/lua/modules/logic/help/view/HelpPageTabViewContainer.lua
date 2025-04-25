module("modules.logic.help.view.HelpPageTabViewContainer", package.seeall)

slot0 = class("HelpPageTabViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._helpPageTabView = HelpPageTabView.New()

	return {
		slot0._helpPageTabView,
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_helpview"),
		TabViewGroup.New(3, "#go_voidepage")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	elseif slot1 == 2 then
		return {
			HelpPageHelpView.New()
		}
	elseif slot1 == 3 then
		return {
			HelpPageVideoView.New()
		}
	end
end

function slot0.setBtnShow(slot0, slot1)
	if slot0._navigateButtonsView then
		slot0._navigateButtonsView:setParam({
			slot1,
			slot1,
			false
		})
	end
end

function slot0.setVideoFullScreen(slot0, slot1)
	if slot0._helpPageTabView then
		slot0._helpPageTabView:setVideoFullScreen(slot1)
	end
end

function slot0.checkHelpPageCfg(slot0, slot1, slot2, slot3)
	if not slot1 then
		return false
	end

	if slot2 then
		if HelpController.instance:canShowPage(slot1) or slot1.unlockGuideId == slot0._matchGuideId then
			return true
		end
	elseif slot3 then
		if slot1.unlockGuideId == slot3 then
			return true
		end
	elseif HelpController.instance:canShowPage(slot1) then
		return true
	end

	return false
end

function slot0.checkHelpVideoCfg(slot0, slot1, slot2, slot3)
	if not slot1 then
		return false
	end

	if slot2 then
		if HelpController.instance:canShowVideo(slot1) or slot1.unlockGuideId == slot0._matchGuideId then
			return true
		end
	elseif slot3 then
		if slot1.unlockGuideId == slot3 then
			return true
		end
	elseif HelpController.instance:canShowVideo(slot1) then
		return true
	end

	return false
end

return slot0
